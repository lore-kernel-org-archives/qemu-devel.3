Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91055606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FJi+0jBb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtvy-0007Kh-LJ; Fri, 30 Oct 2026 17:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvx-0007KY-TC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvw-0007ph-DQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uSO1MBrUYVrFvlTPHQeezTq48bM4sccwd0zAs6JrO4=;
 b=FJi+0jBbO6ZUSonRPhwDV1+OYK8cCSOmGcKEr3MyxvywV5Zyv7xvhHS8Do73gfzYSxzWNt
 IA6lv0fyqm5twHPyNZtQne2S/a9nw7gVnxeAwfvo8ef3MxEQLl9/tUCAGXA6IqE8d3AxPh
 IUOzCIZhweysenvoqaSdzgpTWCOktSI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-EmyKhYEWOSeMCdMS5aU5dQ-1; Fri,
 30 Oct 2026 17:14:40 -0400
X-MC-Unique: EmyKhYEWOSeMCdMS5aU5dQ-1
X-Mimecast-MFC-AGG-ID: EmyKhYEWOSeMCdMS5aU5dQ_1793394878
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7844019541A4; Fri, 30 Oct 2026 21:14:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97E9D18005B7; Fri, 30 Oct 2026 21:14:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:10 +0400
Subject: [GIT PULL 07/10] hw/s390x/ipl: fix short SCSI loadparm buffer
 over-read
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-7-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Joshua Daley <jdaley@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=c9YOix2NRFd+vbdfX3IxVTNQ3IqV3wTDUd97DXtw4WI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5QigvogaaMqN0o1YbwF9pYpRTbPtjOyODqMgE
 PhyjTouTa2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5SuPEAC2uq7SkAk1z95gNFjbZr5U4MqqTtiJqLT6UR5PWYe/ml6xe/wAWkc4VgP1tD4arPM0TkO
 ztubhv3AIboWqk1NTEF0UndTYkAMW2oSaYBSvAKCZNo55hdt5YGhIsB+vvdhytVXZHNsWyCgcbm
 qi3+3zZZ2Xcn+5L4f1iCnI8pVSU3Q8KriH9bfVSS03yd8tcQF/GztMV5FxTKtYtuwtO4p2E37rq
 P6bp/Q5elzOP6aP3VXhwzmviGKpx2Pv9YZcmeSWGc82/FbFxAsSgRKVQpTXmqZwcy2m12fuHYX/
 Aud5OPIm/EOmcp8aKawL61Pyk2T9o25CsFd8cwfxRyifAXfq9junxYpmcl9f5cYyIck24BjYm6T
 Di7a0J75BynrclpFIqbrGgP86yW4/Dxox9SjhPz8xZNLKkJISAs2yUCQFdfIQlF0pwKHRG12m/t
 LpVwSdXCG0WXY2j8MxDwQ7h0/sCjMkMUOB+WZjQ/16EFLXG9BV1JqfDDuwGkRB9R6v+KQeM3KVX
 mLmtgesEyz/VaxUT17tnZXeNfh9dnuR5WswBJnQ3Cbuap43Ez3xfrFDpHXbdvMDeNcy2vOGm7gL
 mrdmYsWOacDJ083jpR0wlIwUaaP5gLxdjZbN+qUUDBEcCUQKHZt+oi1sXCV5f9FuWahgLRl+4ND
 jhKiW91YQ2EkLZQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
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


