Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C20EC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfj8-0007w4-Ef; Mon, 24 Jun 2024 05:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfj5-0007v3-A1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfj3-0003s5-Kd
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719220259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4megXEFudFNidDu6usxu59kkO19OEawrxjQOAqZvUk=;
 b=YKXP9eV9cZalEUMOOZXWPf4QvloANLhEEbQXkW3GTKh01hRUgOqwGWryHMPtEjtkBuR1nm
 yiW0hr+Uzsb576y92LuEV54hmCB+Jf6LRsq3oamln6YCTkLvd7dhk8xh/lCHqkXLoeiOmU
 7IPzvWt+rZH8PPoHvStjlQcvOrHyJ0A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-1rP4PcvANlm60yjG_2QYJg-1; Mon,
 24 Jun 2024 05:10:55 -0400
X-MC-Unique: 1rP4PcvANlm60yjG_2QYJg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0592E19560A2; Mon, 24 Jun 2024 09:10:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D47A83000219; Mon, 24 Jun 2024 09:10:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 02/11] s390x/css: Make CCWDeviceClass::realize return bool
Date: Mon, 24 Jun 2024 11:10:34 +0200
Message-ID: <20240624091043.177484-3-thuth@redhat.com>
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

Since the realize() handler of CCWDeviceClass takes an 'Error **'
argument, best practices suggest to return a bool. See the api/error.h
Rules section. While at it, modify the call in s390_ccw_realize().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240522170107.289532-3-clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ccw-device.h | 2 +-
 hw/s390x/ccw-device.c | 3 ++-
 hw/s390x/s390-ccw.c   | 3 +--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 6dff95225d..5feeb0ee7a 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -36,7 +36,7 @@ extern const VMStateDescription vmstate_ccw_dev;
 struct CCWDeviceClass {
     DeviceClass parent_class;
     void (*unplug)(HotplugHandler *, DeviceState *, Error **);
-    void (*realize)(CcwDevice *, Error **);
+    bool (*realize)(CcwDevice *, Error **);
     void (*refill_ids)(CcwDevice *);
 };
 
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index fb8c1acc64..a7d682e5af 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -31,9 +31,10 @@ static void ccw_device_refill_ids(CcwDevice *dev)
     dev->subch_id.valid = true;
 }
 
-static void ccw_device_realize(CcwDevice *dev, Error **errp)
+static bool ccw_device_realize(CcwDevice *dev, Error **errp)
 {
     ccw_device_refill_ids(dev);
+    return true;
 }
 
 static Property ccw_device_properties[] = {
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index a06e91dfb3..4b8ede701d 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -137,8 +137,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
         goto out_err;
     }
 
-    ck->realize(ccw_dev, &err);
-    if (err) {
+    if (!ck->realize(ccw_dev, &err)) {
         goto out_err;
     }
 
-- 
2.45.2


