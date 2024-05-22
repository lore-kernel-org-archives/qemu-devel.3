Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50DCC25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 17:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pLJ-0000Qn-Ey; Wed, 22 May 2024 13:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pLI-0000Q5-Ju
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pL8-0006Gj-Dt
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716397281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKjuk6fjg6iz0+aIvm9tzmOZTgOfGaENLQD4KGF73DA=;
 b=Y/U+1SswCuKBGLXshdBrhLBdQstchWLWuugI3h7kk9STqv1Fo0VjNRA2wUnplCfmdZsED4
 kZ54PSDEzd5NEQhu0A9XQG3aAR81cw/EkcqgMkBv6wZg9VRwarwd6sfQFcjQ73NGEdaKmy
 WSQguRb1BoPeehFGNqVrg7Qsi45hFXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-GsdxkOC3Pvi-B8vCsNr1JA-1; Wed, 22 May 2024 13:01:18 -0400
X-MC-Unique: GsdxkOC3Pvi-B8vCsNr1JA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7299A803785;
 Wed, 22 May 2024 17:01:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18C6F5619;
 Wed, 22 May 2024 17:01:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/7] s390x/css: Make S390CCWDeviceClass::realize return bool
Date: Wed, 22 May 2024 19:01:04 +0200
Message-ID: <20240522170107.289532-5-clg@redhat.com>
In-Reply-To: <20240522170107.289532-1-clg@redhat.com>
References: <20240522170107.289532-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since the realize() handler of S390CCWDeviceClass takes an 'Error **'
argument, best practices suggest to return a bool. See the api/error.h
Rules section. While at it, modify the call in vfio_ccw_realize().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/s390x/s390-ccw.h | 2 +-
 hw/s390x/s390-ccw.c         | 7 ++++---
 hw/vfio/ccw.c               | 3 +--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 2c807ee3a1ae8d85460fe65be8a62c64f212fe4b..2e0a70998132070996d6b0d083b8ddba5b9b87dc 100644
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
index b3d14c61d732880a651edcf28a040ca723cb9f5b..3c0975055089c3629dd76ce2e1484a4ef66d8d41 100644
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
index 2600e62e37238779800dc2b3a0bd315d7633017b..9a8e052711fe2f7c067c52808b2af30d0ebfee0c 100644
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
2.45.1


