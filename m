Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF4606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SWnf8HSU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrIg-0007mY-PQ; Thu, 22 Oct 2026 07:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrH8-0006lc-86
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrH6-0007H2-Pr
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XAMi0HrTLKQqtXBzHsADAyOWxkdskHxLY/vBFknjMN4=;
 b=SWnf8HSUEZPS6GmmDkP45+fT9dyrPcscLPFF9YjGLI86Gm4IIQ2FoGWLZcUQ4VXvYuGtYl
 vJpv4K+2sCcylvku0EqH94GbZFbDqgMjz/XeVkDRhAdpLGHRSNGG1yaPPQpqt6Qh5iLdNu
 26dgeTlvBoLjkbDuU4FR8363Uug39S4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-2RmNFmVTPLaoRWuYSM6S1A-1; Thu,
 22 Oct 2026 07:47:57 -0400
X-MC-Unique: 2RmNFmVTPLaoRWuYSM6S1A-1
X-Mimecast-MFC-AGG-ID: 2RmNFmVTPLaoRWuYSM6S1A_1792669675
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 910EC1955F73; Thu, 22 Oct 2026 11:47:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B030C1800444; Thu, 22 Oct 2026 11:47:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 15:47:20 +0400
Subject: [PATCH v3 07/10] hw/s390x/ipl: fix short SCSI loadparm buffer
 over-read
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-nohmp-next-v3-7-8b581b590512@redhat.com>
References: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
In-Reply-To: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=F2rHJNlR/CFS/VceTNWL7HfX4e29ttJ+I9Xyczh3VNo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2ffNpcAoRG9/cip0mOoDcmNEbGpZpGrq7kjGG
 8s8efGiIwGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn3zQAKCRDa6OEJdZac
 5bdWEACUDfC4X2xx5VfVBiFQfyEbR6/HgCG3eyMm1kLlFsFhPITjohYXqJmBK1d18UJXKYPDrNl
 aPJ5SWkki5gizeyKwLyioCT80Ta1gjXX5+KhyigBALgdiBOZCPsZz1wcAX5qcmpNVQEpGqJNDoT
 TvlMGt+jdb8LzcUrS61yCdMv0sv/X0V5ZO3fn5Q4+WXNXLANbA9n0f6fnxSkUWjK6fU0aCwTB5W
 HSTsh7yMAcxX5RG1nJLYmHUaNJtvw6oipXbA3hbNc5y9HELCK4AcozHAgqfTgeYvweO6/ppPw0D
 X+VaEozUxXLN3//ppmkigFTsRYq3FJIU/PikSVaxtoy/naN/g9qmQTYDrYf9tGQbSmkpGyuU9gB
 eZZpSgYZb31l8gklJTXHu/knifoqVRbrUIVCW7CYuVzCrQAiHTQxZcmrhiBAhaG0/oIxfoVsEB5
 KUbbvn8R3ZXRo8mWgA1zylxlDHJGJWjh/IyVU2g8pzwFN1ABAjHXHRE0kLUp95h/jJBfJOF4xDV
 hI+F32vX0f1e4/mON2hErrDrBrN6a0qeAQ4cjvvUZrsWP4nsNwgHnzv9q20ZoEABVfOJwd9ktKq
 aMufTaHfQmq87roULZT3/yhzlLEvoW3L1hev0+OCOkVF9tXPfBPXriAvzOlFO4p58P5KTU/st1U
 4OBg9OBeYO4Ajgg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

s390_build_iplb() initially points lp at the eight-byte CCW loadparm
array. For SCSI devices, it can replace lp with a variable-length string
returned by object_property_get_str().

The following memcmp() still reads eight bytes. ASan reports
buffer-overflow on value "3", when running test_scsi_loadparm
func-s390x-boot_4k test.

Check the fixed-size CCW loadparm for the 8-zero before the SCSI
property can replace lp.

Fixes: 429442e52d94 ("hw: Add "loadparm" property to scsi disk devices for booting on s390x")
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/s390x/ipl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 1add11ad7b2c..fe107af84de0 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -570,6 +570,11 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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
@@ -605,11 +610,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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
2.56.0.116.g6de20f6092dc


