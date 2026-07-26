Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438A1C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5iV-00083D-Ro; Sun, 26 Jul 2026 16:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5iV-00082x-4u
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5iT-0004BI-Qw
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/POaYwIz7h1//1YrnKweU5fHiZe4sgfVD5NET1i974=;
 b=Wh7de3EERW3FuFple8rpmu/KfK1H/AEE+a81XO7T7wySEDxtwwfKbGniYayNHUUGDGpQs6
 KEnIQF7YENLIcixRp8BCBJyMLfeq/peS+HMLVBxFPBOFOoddNLsR8HMRXcK4kUN0MnDr5/
 7KGZUkKZbjh3Dda9YJgocg4M4rmG1NM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-BjhnSJ1GPq6lxd1wDejhgQ-1; Sun,
 26 Jul 2026 16:44:53 -0400
X-MC-Unique: BjhnSJ1GPq6lxd1wDejhgQ-1
X-Mimecast-MFC-AGG-ID: BjhnSJ1GPq6lxd1wDejhgQ_1785098691
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99C671800590; Sun, 26 Jul 2026 20:44:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0495318001E0; Sun, 26 Jul 2026 20:44:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:04 +0400
Subject: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=778;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BvH11bAGqVafjw/9JvRuhekLdJbHoBFg9BIf/wU6vRM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXHbn11IZQ/CDpUaKI05AbxWrb9OZgBYekD
 XuyRkyAFmWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5TYkEAC0/2zRf5blPzTCAoJEW0pHJuoT9U8kH4ZlWJmNB3kkCelOXhj4bOA+ruA/vDQ84R1H6DB
 naJaP6PBqRfjYiDIzb11fNEqGIvqeo3GpQZfgDwn0UYjrBmQxNLzPst8NURBymGu75UmKEiYIWz
 l89a4uaSsUqPRlXyOmzjxDUL2c6OqMSJkCVx9WaDVRqhIlMaW8MkdUCsW8ezdLScTWNSJnQw0yJ
 7SpNkb9o/iTFiV0Txec3oqoxoSaQD2foMqM8V8a4AQMyUNA6ug0i3v4L8sgfDadt1pO6GR/2eA+
 yL5uzreMw/jotkO8M11vR/GlsvmYa0Uj7knOrCBTs37cy+axWflxBK3/k0V2RdpywlfMwHz9O9K
 w9jwOiaYELCwHcWmfZObOWAt9m31trcUeJ8iskULfPBrMKef2sR1a/bUcfhBTnuLjWTHaJQq84h
 946xKgjQ0zPiEE+dywIZQAukm83YoIekyQDTjZNLmV7SNfurUs778wu9H/x8nnLYO8DVgBa1COu
 3+6PYOWkNEvxzy6I1XvrRzjsKbYYlxKeNZ+VJ08v5Nc79pjtYsFi+jDIEb8e6rlb86AblPrin4E
 K4Wk2O5MzpHmPZtOC2/RwmnpXwIKWrDqtfib+1taDAHhnY0C1+1yZn+eK0qSJQZgVvRHqKjvDrg
 AQ5C84uCth0eyJQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/cxl/cxl-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7e744312f1d8..eba13c9e7cba 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
     MemoryRegion *mr = NULL;
     uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
     MemoryRegion *direct_mr;
-    g_autofree char *direct_mr_name;
+    g_autofree char *direct_mr_name = NULL;
     unsigned int idx = state->hdm_decoder_idx;
 
     if (ct3d->hostvmem) {

-- 
2.55.0


