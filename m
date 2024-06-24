Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849B9C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfjT-0007yE-Q3; Mon, 24 Jun 2024 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjS-0007xp-50
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjE-0003sV-1K
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719220268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1v+7D4EiyD7M+nQxR3WsvAByd+Ga93rHD+GWWIFd1k=;
 b=XS3Rbv22cGPZDRuK+QD4QTc3BJfCmSfz3J7gG/ezMppoOQ86qZuv17m5MNSOszU5iP6Usa
 grx8fHBezq/8dWv2PLjXLQJZlqvhNrsBxavhHnLwnmLtTe8FWz1FQlFiHYFm+pBqpEGpUq
 y8xxFxYpUb5EDAL3R7Dfe8jikQrwok4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-lFWznw1EMYyqunFt60F5eQ-1; Mon,
 24 Jun 2024 05:10:59 -0400
X-MC-Unique: lFWznw1EMYyqunFt60F5eQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7606B19560BE; Mon, 24 Jun 2024 09:10:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5AC53000227; Mon, 24 Jun 2024 09:10:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 03/11] hw/s390x/ccw: Remove local Error variable from
 s390_ccw_realize()
Date: Mon, 24 Jun 2024 11:10:35 +0200
Message-ID: <20240624091043.177484-4-thuth@redhat.com>
In-Reply-To: <20240624091043.177484-1-thuth@redhat.com>
References: <20240624091043.177484-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use the 'Error **errp' argument of s390_ccw_realize() instead and
remove the error_propagate() call.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240522170107.289532-4-clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-ccw.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 4b8ede701d..b3d14c61d7 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -115,13 +115,12 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
     DeviceState *parent = DEVICE(ccw_dev);
     SubchDev *sch;
     int ret;
-    Error *err = NULL;
 
-    if (!s390_ccw_get_dev_info(cdev, sysfsdev, &err)) {
-        goto out_err_propagate;
+    if (!s390_ccw_get_dev_info(cdev, sysfsdev, errp)) {
+        return;
     }
 
-    sch = css_create_sch(ccw_dev->devno, &err);
+    sch = css_create_sch(ccw_dev->devno, errp);
     if (!sch) {
         goto out_mdevid_free;
     }
@@ -132,12 +131,12 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
     ccw_dev->sch = sch;
     ret = css_sch_build_schib(sch, &cdev->hostid);
     if (ret) {
-        error_setg_errno(&err, -ret, "%s: Failed to build initial schib",
+        error_setg_errno(errp, -ret, "%s: Failed to build initial schib",
                          __func__);
         goto out_err;
     }
 
-    if (!ck->realize(ccw_dev, &err)) {
+    if (!ck->realize(ccw_dev, errp)) {
         goto out_err;
     }
 
@@ -151,8 +150,6 @@ out_err:
     g_free(sch);
 out_mdevid_free:
     g_free(cdev->mdevid);
-out_err_propagate:
-    error_propagate(errp, err);
 }
 
 static void s390_ccw_unrealize(S390CCWDevice *cdev)
-- 
2.45.2


