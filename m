Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B848C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi678-0005Y5-E9; Fri, 10 Jul 2026 03:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi676-0005XV-DH; Fri, 10 Jul 2026 03:57:36 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi674-0002wG-EY; Fri, 10 Jul 2026 03:57:36 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id E6AF02003B4;
 Fri, 10 Jul 2026 09:57:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783670251;
 bh=CdqKKfVtsjgJdqIULJuMGh/IOJvF7tvnIxvWLsK9iuQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Xyv16B35XsTiqasjE8R4mKyTXekuZVkVPxeYWWxPT7j42GjuLL1F+YZdlfj/YATpi
 toiFWxjCXsJanzw6bqz4Uyvx7sNqWQuaQoBtZWAwKm9RVwMtvrcyQDzDBdETk13gMn
 YcuikbaOB5welWA2TeQHDqMsqTiSg7LTBWAln0UT0Ombay03duU29TEKpB+okNDXd2
 4NI2JNDReKGy2Te9Yf9fUCZ25DuKLX/RNSZdjoWZ4pyqBtRY2m+al9dLyctj2R91u4
 LtDBUhgELeK91NYaZI3lBnmt1Q7fpb8COzOzN7NeVB/rfh2G6KzHCVL5iYEowPKCZb
 AOsK4SCtNSKKQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:18 +0200
Subject: [PATCH 26/29] hw/i2c: parent slaves created with
 i2c_slave_create_simple
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-26-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=2108;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=CdqKKfVtsjgJdqIULJuMGh/IOJvF7tvnIxvWLsK9iuQ=;
 b=p9o0xEIN8/0URdldssS2ASxK22H/K+l6lpB6QbOLsCRd5/QLtMCd4WdvDs3uLjEnCE7on/Ixa
 m2CaVu5E7GNBRYbckNJhFDbHccqkKZVfPTvawGBbz1jPmmp48SdtseG
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

THIS PATCH IS ALREADY PART OF THE ADC128D818 SERIES
WILL BE REMOVED BEFORE FINAL REVIEW

Slaves created with i2c_slave_create_simple() were left unparented and
showed up under /machine/unattached with no stable QOM path. Add each
slave as a QOM child of its bus, named after its I2C address, so it has
a deterministic and addressable QOM path.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
(cherry picked from commit f55644fa78777e52fd90efaa59dd89b4ff0a7020)
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/i2c/core.c        | 3 +++
 include/hw/i2c/i2c.h | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 54f6bdca882..0bbce45d48d 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -382,6 +382,9 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr)
 {
     I2CSlave *dev = i2c_slave_new(name, addr);
 
+    g_autofree char *childname = g_strdup_printf("0x%02x", addr);
+    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
+
     i2c_slave_realize_and_unref(dev, bus, &error_abort);
 
     return dev;
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index dd5930f4b5e..dc557bbf3f2 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -166,13 +166,16 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broadcast,
 I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
 
 /**
- * Create and realize an I2C slave device on the heap.
+ * Create and realize an I2C slave device on the heap, add the device as a
+ * child of its parent bus.
+ *
  * @bus: I2C bus to put it on
  * @name: I2C slave device type name
  * @addr: I2C address of the slave when put on a bus
  *
  * Create the device state structure, initialize it, put it on the
- * specified @bus, and drop the reference to it (the device is realized).
+ * specified @bus, parent it, and drop the reference to it (the device is
+ * realized).
  */
 I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
 

-- 
2.50.1


