Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24ABC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 14:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wncws-00059M-A4; Sat, 25 Jul 2026 10:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncwg-00053z-NY
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncwe-000586-8k
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784988099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqYGAMQYTE7NgCivyeQuW01dQY8Lzslgx4hiMYj0PE0=;
 b=NDVnN/Ek3vgSu2pgwfZAR23Z/GPpMPw4yfQtM8ADfsqzRg8npvMHd3M1Z6YqOxZ0++nmgY
 azNGshMwoTLhDBFVY3Gk9EP5/SI0jIUwaVn55rwtXkCxef8wz+pQJ2Ng7mSqubDxPUDOlr
 Gf6G9CAIPUfPg1+B0MNCTGwqetVMs50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-RXRoJnUNOCi3x4xGMBHJ7A-1; Sat,
 25 Jul 2026 10:00:29 -0400
X-MC-Unique: RXRoJnUNOCi3x4xGMBHJ7A-1
X-Mimecast-MFC-AGG-ID: RXRoJnUNOCi3x4xGMBHJ7A_1784988027
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EE8A18002A2; Sat, 25 Jul 2026 14:00:27 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A216195422A; Sat, 25 Jul 2026 14:00:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:03 +0400
Subject: [PATCH 2/7] block/blkio: fix error return value on getlength()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-fix2-v1-2-5c9a6ce7b96a@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
In-Reply-To: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mk7xOY7MrP6hzIZ9/rwfiY5pmK/wzv9sLr3O7waARAo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFl3l+pb8+oFbJ8vFGbzbVFnDmVOYYa1trpI
 EI5hHN9bT2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZQAKCRDa6OEJdZac
 5SF6D/9Fbz48ox7+C5SOvyXLlKChpwF+aIQtuyeE7dl1B+1zJ3hR6HBf9Ur7fotHIwFuzTbybjq
 ePsAqcsWTP4X1PfTTvMRmjU9MeTFmfFO5kPaxF/DpTGZwish/jZgcbg5/MP6BDS7kr2Hs05v21s
 zIT3vgQrzXkeD5pVIG4q/qzDoFm1mwdNMPteUstuo1GnG29/sQMmfAaw9WRPN09tMBi586pUn2R
 AlmX2LczK0mgxjVvh0+5zpx6yOL0uiXqWTZ5+2BY5H44Wx5rRm5Dg6easLcXccix+PyLP1dIbU8
 67BifWKhf4vHoiJbownhFmP0iLpZaos/J8qYwrGn5E38hmxroFTU9v2zbn1BuP5S5ONU/39UDh0
 13CMv7kZk/2KlEeymGvlTbChRorkgxXlrutYqTQRymTzNxBuPKyuL+O4VDR7flCrf2PM02SclYa
 0wwqgJ5iDdT0ov/Jo6ZfucWWJ2Y8FArGg+2wQLPIARKEgC7e8YLsW5IsKYu4O1+w45eBocINcGj
 6rcV0dMVY09KdEJdGVwwFZvL9aX9ucwLUNOj73nZIn28DTBKvt0uLhffLhRFXlDNlP/28HtBdl7
 ZbOYr+oRp7G7QDbxvW9+inZRNEa77v7qhyuYuNpB1x5+NfMOfeEaUMdo3ZD3nvy4oa85ATckw+m
 8gSLleNfUYrVPCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Negative values should be return for errors.

It also helps with GCC false-positives:
../block/blkio.c: In function ‘blkio_co_getlength’:
../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
  943 |     if (ret < 0) {
      |        ^

Fixes: fd66dbd424 ("blkio: add libblkio block driver")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/blkio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index fb8bec27d71a..d2ba2a4d58dc 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -935,13 +935,13 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
 {
     BDRVBlkioState *s = bs->opaque;
     uint64_t capacity;
-    int ret;
+    int ret = -1;
 
     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
         ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
     }
     if (ret < 0) {
-        return -ret;
+        return ret;
     }
 
     return capacity;

-- 
2.55.0


