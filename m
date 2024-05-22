Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D952CC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 17:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pLE-0000Nl-Az; Wed, 22 May 2024 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pL7-0000LW-BC
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pL3-0006Fr-CG
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716397276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NH2Qma3K6JHa3biLRiK7TBjGAz4Sbry3T+EMcJa1ZaU=;
 b=EHKxgD6nidHZf3Ge0VulUgrHc+RZKYa11QsU5w7xJclg9pscMnNPVg5H7qLZoGnnKTOq+D
 +t+gOSW2dcXw8Zl9HaK83BAKN9DjFr7JCuD+Tcduh3zgKKQeemR+w0VC76RPfuQlTgOVOj
 ecp/Ns3ik/B1pMod88YIXQhQQ8BFIO0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473--ixrUXf3ONKspQ8Eik4wnQ-1; Wed,
 22 May 2024 13:01:13 -0400
X-MC-Unique: -ixrUXf3ONKspQ8Eik4wnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABBA73C025C1;
 Wed, 22 May 2024 17:01:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50C11561B;
 Wed, 22 May 2024 17:01:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/7] hw/s390x/ccw: Make s390_ccw_get_dev_info() return a bool
Date: Wed, 22 May 2024 19:01:01 +0200
Message-ID: <20240522170107.289532-2-clg@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since s390_ccw_get_dev_info() takes an 'Error **' argument, best
practices suggest to return a bool. See the qapi/error.h Rules
section. While at it, modify the call in s390_ccw_realize().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/s390x/s390-ccw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 5261e66724f1cc3157b9413b0d5fdf5289c92503..a06e91dfb318e3500324851488c56806fa46c08d 100644
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
2.45.1


