Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682A8C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfj2-0007uQ-8t; Mon, 24 Jun 2024 05:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfj0-0007uH-UU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfix-0003rn-78
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719220254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MEH/mKV63v/JJwnQ03ODMnT7oVBF8nDVD2HElTki68=;
 b=AvWuCeqXGnVBr9aaVe1l3Hx8oiri2cORBVDuZv6583AhOA1Eo6shkp9lFtyp0HAi2+3+dv
 SceS8J8VH5gzGNTgkBYOPtgSeFHjMhNHBoGfoKN1UoiD5Z4jePX6SMAX3NEPZwbO1t+APv
 zkrKPe6TGaTI9Z9zJ+oUM9eUbRI/m+Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-ZyPEeIplM-2XMuSsTDoVgg-1; Mon,
 24 Jun 2024 05:10:51 -0400
X-MC-Unique: ZyPEeIplM-2XMuSsTDoVgg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B6E61956056; Mon, 24 Jun 2024 09:10:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C38A3000603; Mon, 24 Jun 2024 09:10:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 01/11] hw/s390x/ccw: Make s390_ccw_get_dev_info() return a bool
Date: Mon, 24 Jun 2024 11:10:33 +0200
Message-ID: <20240624091043.177484-2-thuth@redhat.com>
In-Reply-To: <20240624091043.177484-1-thuth@redhat.com>
References: <20240624091043.177484-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Since s390_ccw_get_dev_info() takes an 'Error **' argument, best
practices suggest to return a bool. See the qapi/error.h Rules
section. While at it, modify the call in s390_ccw_realize().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240522170107.289532-2-clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-ccw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 5261e66724..a06e91dfb3 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -71,7 +71,7 @@ IOInstEnding s390_ccw_store(SubchDev *sch)
     return ret;
 }
 
-static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
+static bool s390_ccw_get_dev_info(S390CCWDevice *cdev,
                                   char *sysfsdev,
                                   Error **errp)
 {
@@ -84,12 +84,12 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
         error_setg(errp, "No host device provided");
         error_append_hint(errp,
                           "Use -device vfio-ccw,sysfsdev=PATH_TO_DEVICE\n");
-        return;
+        return false;
     }
 
     if (!realpath(sysfsdev, dev_path)) {
         error_setg_errno(errp, errno, "Host device '%s' not found", sysfsdev);
-        return;
+        return false;
     }
 
     cdev->mdevid = g_path_get_basename(dev_path);
@@ -98,13 +98,14 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
     tmp = g_path_get_basename(tmp_dir);
     if (sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid) != 3) {
         error_setg_errno(errp, errno, "Failed to read %s", tmp);
-        return;
+        return false;
     }
 
     cdev->hostid.cssid = cssid;
     cdev->hostid.ssid = ssid;
     cdev->hostid.devid = devid;
     cdev->hostid.valid = true;
+    return true;
 }
 
 static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
@@ -116,8 +117,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
     int ret;
     Error *err = NULL;
 
-    s390_ccw_get_dev_info(cdev, sysfsdev, &err);
-    if (err) {
+    if (!s390_ccw_get_dev_info(cdev, sysfsdev, &err)) {
         goto out_err_propagate;
     }
 
-- 
2.45.2


