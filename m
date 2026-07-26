Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124B9C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5iE-0007zj-8r; Sun, 26 Jul 2026 16:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5iC-0007z5-3h
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5iA-000499-No
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZD9c+t7MILB/tiCBpv52ymj4SpFNv8fK+VqJytjmOdk=;
 b=WK9asMESIzRNY2gLctGaPL6jsmIuP6JS0jXlNEDR14LfrAy7GkcM6xeKQeYWyvwOyZl9Zx
 kCc2pF8JNb6dnshJUyZ2HwosjKV1/dwZdHbdXhp4DYu1NyLwccatUVCBaCV5Rx7zfOoaYu
 cMtdJH1D6eiVdLMCbceNLDOWm/lbII0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-Ugweij-7MW6f7RU7UILbNA-1; Sun,
 26 Jul 2026 16:44:35 -0400
X-MC-Unique: Ugweij-7MW6f7RU7UILbNA-1
X-Mimecast-MFC-AGG-ID: Ugweij-7MW6f7RU7UILbNA_1785098673
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13F5B1956053; Sun, 26 Jul 2026 20:44:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A33C18001E0; Sun, 26 Jul 2026 20:44:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:01 +0400
Subject: [PATCH v2 02/12] block/blkio: fix error return value on
 getlength()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-2-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=656;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KUwdh4qWkjrixCjRkFzF1AESBuEqtaV7DKeiZd1uFaU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGX7YpxQWXaaGmDfwVLM1l+jDrPKhzdn7f+i
 DybceyvvueJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5fDJD/0X6NzR1k+kircKGc+Criog16ENyjwtcAo4cq+m7UNuaNHJ2+o2YmFdO41zEn/eS8MKVZJ
 c69+HhlSLjM7hU5EdcklCJoSl4v5TwZGVQeAJuGBsH/ezGTi07YKlmRh8iFUHWInZrX7PuoxFbU
 1cxFkqz1NwvmWmwlnp37t5RfjsDHbHgHFFBGXuQOLXjsA1RehMVWEyshVyONXeIp/69YJEd1O/M
 NsfNuHYGeDNBlPY49uHCSyDt2o8OtnU5ex+v8VL3W8u64X++RLmSqstlGL46ZdTlXGPZiKRF43+
 FRehK14fBGDW2MeV6hMfrMFCOT9eKOl1bYyu6Gt5SII5FWc1nOcXhNTRli1EfSK5VKdmFxobUEw
 e6kx+IU5h09/onPe2bQIu1zhWtJOfdC1tuFl5pq0mrZJPCBf1eC6wRuM1aXgGetF1pGWvl1MlPZ
 skrYenapjTYwjyqhKZbDn9PLc7yXht64XwfVhLq7JDINu67BhYEjFFs4Wbsj7FlOgs1qPwHcXBF
 QdIDpGtCJz1LXBWMFhnm3fUaQc6pNqXXkq4WasvfI9srvIKx4U5ygjkDPke0PNg6B7ZDYhcFDTx
 8XZ3rGr27+wBSNYlVKsNKfAaxy8Pftk0Qdx//GfhkcXpSYomBCWOl/OUE4omtLNfrghWB26AWgv
 JusPeLjgfzl8qiw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Negative values should be returned for errors.

Fixes: fd66dbd424 ("blkio: add libblkio block driver")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/blkio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blkio.c b/block/blkio.c
index fb8bec27d71a..52a8be220d1c 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -941,7 +941,7 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
         ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
     }
     if (ret < 0) {
-        return -ret;
+        return ret;
     }
 
     return capacity;

-- 
2.55.0


