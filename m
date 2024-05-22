Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDF7C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 17:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pLJ-0000Qp-Mr; Wed, 22 May 2024 13:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pLI-0000QE-NZ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pL7-0006G9-35
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716397279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Z8qwgx2tbYux8MlEKpFhB/CS+fM9t1Ig/khgGvS7uY=;
 b=Wsh1yfgtV6MzlpoPXD4kl+uheWoTblucQjO5sO8K9o6vuXl8+qkkYVvr4ubn96Gyn4p8yc
 qDvp+oexLUIxUxHs6lEclt0IunPjHByNZ82ILsG1yQIZD42ffWHJgM68bnbHmBgJn60+Oy
 rTwes6VVf5vJuGiRHMtkpV4e7eV5M1U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-_Lm71GWaMWCg_o11oeFB0A-1; Wed,
 22 May 2024 13:01:14 -0400
X-MC-Unique: _Lm71GWaMWCg_o11oeFB0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 499B3380008A;
 Wed, 22 May 2024 17:01:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1AA55618;
 Wed, 22 May 2024 17:01:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/7] s390x/css: Make CCWDeviceClass::realize return bool
Date: Wed, 22 May 2024 19:01:02 +0200
Message-ID: <20240522170107.289532-3-clg@redhat.com>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since the realize() handler of CCWDeviceClass takes an 'Error **'
argument, best practices suggest to return a bool. See the api/error.h
Rules section. While at it, modify the call in s390_ccw_realize().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/s390x/ccw-device.h | 2 +-
 hw/s390x/ccw-device.c | 3 ++-
 hw/s390x/s390-ccw.c   | 3 +--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 6dff95225df11c63f9b66975019026b215c8c448..5feeb0ee7a268b8709043b5bbc56b06e707a448d 100644
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
index fb8c1acc64d5002c861a4913f292d8346dbef192..a7d682e5af9ce90e7e2fad8c24b30e39328c7cf4 100644
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
index a06e91dfb318e3500324851488c56806fa46c08d..4b8ede701df90949720262b6fc1b65f4e505e34d 100644
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
2.45.1


