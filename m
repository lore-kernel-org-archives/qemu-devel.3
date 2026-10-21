Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55A606A328
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CY3a1oCY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJR70-0004af-Qp; Wed, 21 Oct 2026 03:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6s-0004Wz-MI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6q-00040p-SJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792569100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XAMi0HrTLKQqtXBzHsADAyOWxkdskHxLY/vBFknjMN4=;
 b=CY3a1oCYZK4q7AMihGkj4AlQZSRn10ovVQZfCil8Q3tGBEBy8HDQg8eGROOd3kZgXoor5h
 xKksRHqcmTdwvKYOHdZ+6cTaO6ESpZZyCmNDBjOJTn+7hLGRw5TbZqh2O4ZyMuaopeemcc
 a7cSesRStYI/Hb0e/+wzkVAuMbzSo6w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-lvaGCU9QNZevfRV9mCbskA-1; Wed,
 21 Oct 2026 03:51:38 -0400
X-MC-Unique: lvaGCU9QNZevfRV9mCbskA-1
X-Mimecast-MFC-AGG-ID: lvaGCU9QNZevfRV9mCbskA_1792569096
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1E551956088; Wed, 21 Oct 2026 07:51:35 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E98DF1956087; Wed, 21 Oct 2026 07:51:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 11:51:09 +0400
Subject: [PATCH v2 6/9] hw/s390x/ipl: fix short SCSI loadparm buffer over-read
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-nohmp-next-v2-6-85471fca83db@redhat.com>
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
In-Reply-To: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2G7sNdknHjQDE5zAK6n+oA3mbgkrUUJPTfTQi
 KWQ7ygeqJiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCathu7AAKCRDa6OEJdZac
 5VmTD/4w/liODXHdeLWQ7OW83j9L9qejjPwJzRxjNBoFxr6i05Rh6NJoigiEUHSLZ2vanvNZKlv
 T/AHxf+I4v0twr+wV7OtOFpRhYZ+uW3XL5AVycBcoXhQiR2ERK76TCsD/TqISuBeE36qMDvhnQe
 diRrjEghVL2XpvDzg7/aCnVUObbzJE338+LZ4uwBOqVCbvb6hEhZGIXZoh3tOq1y1SYVUBNTms4
 Go7EmNKXylykmUY3hKPP0Y+ObNDnrXvvBujbk3D7RlOTdj/Lj3MbGwFZ5jdGEy9HwLAz1wSzanj
 S8rrraMDc9+1oYqafjBmHIQKXkvP4T4OK/bCTG4q9oxospeZQ8WwCAEKtVPsBwc0BN/YBuGJ6iM
 uMpnVKrpvO3vNGP4CiALeUskVMcBaTZ74UPT2BOQm+Fq/qzoGSfvXPwL3gDhBYCjVXZtrFpklaU
 BgCgdPx7ln+theCK9oRCMR9AGISlvEOn3AFzBBJo6qDKHfACPqIwHPZbtpOeuuEEreYqpa3uOWL
 do/oZzsW2cnblJUIFJvoehsRy79mIjRCURSeDj5VpyC75ZG7Jp8IABlunnW7ApTbSMn+Kaw2Fe2
 c9BkX5/O1UqcOVAmxS16tsGAQcEnKIazbmwcgzdWrf4xYyzPZsXyWGPg1DC8/Zbncl3V5mrOE97
 9c4zwXYp650dV7A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


