Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B0AC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfjJ-0007wd-4o; Mon, 24 Jun 2024 05:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjH-0007wQ-Li
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjA-0003sN-S3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719220267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1/JShl0HA5iIO/ldYs3XyH7C9qq8BP88fI07ymd6mI=;
 b=HNwPI+GjTV1fCiOayb0j8BgGkPJDkWcGTnN7Ke4o7bTkQsIyRx1fawZ5DG2+DZVl3+e7CK
 pzkt60l0vPOcweXHEwepAraRHsnrP8xu+qYdt3cOk2MeWgYZ0VB7tEii3yBrh21a1seuAo
 OHbwZT82W9zT/r92rIC+wEHladJpmds=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-PGgbdl4zM4e_3SH_gKRCbw-1; Mon,
 24 Jun 2024 05:11:02 -0400
X-MC-Unique: PGgbdl4zM4e_3SH_gKRCbw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAE2C195605F; Mon, 24 Jun 2024 09:11:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 050773000618; Mon, 24 Jun 2024 09:10:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 04/11] s390x/css: Make S390CCWDeviceClass::realize return bool
Date: Mon, 24 Jun 2024 11:10:36 +0200
Message-ID: <20240624091043.177484-5-thuth@redhat.com>
In-Reply-To: <20240624091043.177484-1-thuth@redhat.com>
References: <20240624091043.177484-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Cédric Le Goater <clg@redhat.com>

Since the realize() handler of S390CCWDeviceClass takes an 'Error **'
argument, best practices suggest to return a bool. See the api/error.h
Rules section. While at it, modify the call in vfio_ccw_realize().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240522170107.289532-5-clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390-ccw.h | 2 +-
 hw/s390x/s390-ccw.c         | 7 ++++---
 hw/vfio/ccw.c               | 3 +--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 2c807ee3a1..2e0a709981 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -31,7 +31,7 @@ struct S390CCWDevice {
 
 struct S390CCWDeviceClass {
     CCWDeviceClass parent_class;
-    void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
+    bool (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
     void (*unrealize)(S390CCWDevice *dev);
     IOInstEnding (*handle_request) (SubchDev *sch);
     int (*handle_halt) (SubchDev *sch);
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index b3d14c61d7..3c09750550 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -108,7 +108,7 @@ static bool s390_ccw_get_dev_info(S390CCWDevice *cdev,
     return true;
 }
 
-static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
+static bool s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(cdev);
     CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
@@ -117,7 +117,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
     int ret;
 
     if (!s390_ccw_get_dev_info(cdev, sysfsdev, errp)) {
-        return;
+        return false;
     }
 
     sch = css_create_sch(ccw_dev->devno, errp);
@@ -142,7 +142,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
 
     css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
                           parent->hotplugged, 1);
-    return;
+    return true;
 
 out_err:
     css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
@@ -150,6 +150,7 @@ out_err:
     g_free(sch);
 out_mdevid_free:
     g_free(cdev->mdevid);
+    return false;
 }
 
 static void s390_ccw_unrealize(S390CCWDevice *cdev)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 2600e62e37..9a8e052711 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -582,8 +582,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
 
     /* Call the class init function for subchannel. */
     if (cdc->realize) {
-        cdc->realize(cdev, vcdev->vdev.sysfsdev, &err);
-        if (err) {
+        if (!cdc->realize(cdev, vcdev->vdev.sysfsdev, &err)) {
             goto out_err_propagate;
         }
     }
-- 
2.45.2


