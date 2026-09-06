Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3A5C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38e4-0002Zj-3N; Sun, 06 Sep 2026 04:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38e3-0002YP-35
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38e1-0000oT-Ky
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MlOzefOMyFIYin8lnPxCAKgI3I17CqTz3mHT4Btd4VQ=;
 b=UQaTkPIWsMUXkRNtPaBMnUQ9bwmYGhplicmVR+lhDF2+6dG4glb5cCj6HMDFMqU6JjhGwh
 QJmPJ6UimkCwe/FwoXRqvQcxv7c3YYLy+/CQtY5VItzZVoHEuH6U3Yjs6Q+/aVKMpHwTCg
 /2fsdvCjjaWOHVKSNbQQwOLuXeBxrpY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-CM2PUJlxMcOYobfVR1V-Wg-1; Sun,
 06 Sep 2026 04:54:29 -0400
X-MC-Unique: CM2PUJlxMcOYobfVR1V-Wg-1
X-Mimecast-MFC-AGG-ID: CM2PUJlxMcOYobfVR1V-Wg_1788684866
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AD2918011EA; Sun,  6 Sep 2026 08:54:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1ADE230002EF; Sun,  6 Sep 2026 08:54:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:53:41 +0400
Subject: [PATCH 9/9] hw/s390x/ipl: fix short SCSI loadparm buffer over-read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-next-v1-9-2b21e63974f3@redhat.com>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 qemu-s390x@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bIdpGVAkPWhL6iCZ6lwgkzBd3NrpzsxJLuDajQEJb08=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSoZ9BWKtdg14kuD7L52A3Yq38D3WnaWC8RzL
 6Nv+J+eKl6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0qGQAKCRDa6OEJdZac
 5SNIEACwDQ7QCTE+tiPha8vJ+E1Sh6Tu4NLwIAwOJgAd0kWAJVxiDXazng7m43jX4e1DRuRrs/e
 g8YX7sAoj6aPpEkB0Zc7JBAC3sHcq0QzOsKK1sKaCGwiJinKwa337eXRUOMhixmGiXgRTqVC6dB
 RNQg9z4jZWWL3zFsPfqZDjLbno7dftad0e0R0sLiwD7rxrb5kezqafZO6uOT0QR3Lz382z4HgR2
 a+YX0woMlrq++Q9tIdf/tGKIhMR95l6UnzFhHw2btgQDvN1bw3TLznqcZKHSzGTLhFdZxwOj/cm
 O5y++S3C719rR9TnSI4zrjy5hCneyobWpYr9He3sSl2tEnvs1ajlmJ5VOAly2MTXrEBGS/w3J/s
 6GqnpwzeGiMUe6PXdpjL0DAnEz5W6dSLK66Dr2UMZQ2zLIvpwFrCn+FP9Qc0JvvZ4CZ6jFPuZhv
 U4cXBf0vZkbBuI2DXo42hBUhMtBRJ26Ofwm5uZeVJ6hMQFZ+DEWnNuS2fJeJSiqwmdneo0EUXUr
 TiZhlpPEYevJNWS+aBH0cwgXa8JCamUFptxRGg617eylXPVGvCvEVK2+jcsLtENN+14xttamvbm
 OlyXV0Zabl8jGE51SOHksqqcypYep4lJwUU8s42ul20k9MQ/9G86Hrv7geu/iorvcdxUHFJ3Y7m
 ydKm2ygW5/dtGrQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

s390_build_iplb() initially points lp at the eight-byte CCW loadparm
array. For SCSI devices, it can replace lp with a variable-length string
returned by object_property_get_str().

The following memcmp() still reads eight bytes. ASan reports
buffer-overflow on value "3", when running test_scsi_loadparm
func-s390x-boot_4k test.

Check the fixed-size CCW loadparm for the 8-zero before the SCSI
property can replace lp.

Fixes: 429442e52d94 ("hw: Add "loadparm" property to scsi disk devices for booting on s390x")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/s390x/ipl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d59ed36c7839..e249d50b1ce3 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -549,6 +549,11 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
     if (ccw_dev) {
         lp = ccw_dev->loadparm;
 
+        /* If the device loadparm is empty use the global machine loadparm */
+        if (memcmp(lp, NO_LOADPARM, 8) == 0) {
+            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
+        }
+
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
             sd = SCSI_DEVICE(dev_st);
@@ -583,11 +588,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             break;
         }
 
-        /* If the device loadparm is empty use the global machine loadparm */
-        if (memcmp(lp, NO_LOADPARM, 8) == 0) {
-            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
-        }
-
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 

-- 
2.55.0.543.g5ebe2ebe4ea8


