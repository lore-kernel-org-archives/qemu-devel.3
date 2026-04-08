Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B9510F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYcL-0005td-DV; Wed, 08 Apr 2026 15:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjian.3032@bytedance.com>)
 id 1wAYAA-0000wB-11
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:06 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjian.3032@bytedance.com>)
 id 1wAOm9-0002r4-04
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 05:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1775638836; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=eUJ8ysynggBwqU6MeWf3s5qMtr/W2qn8sO1vb4zJqhg=;
 b=NxEf2scUDM6aNIE0zyDzleLq2VeXfhNGU2Yea7DOs8HB+/fuxNqZyViZL60EBHTiE7JvhR
 ShC9u+WVMTAyZj94uWyEYLduDgXI0+n389r+/X/tI5gGpO/OZmV/582V5gyEDlXQ/yxFvI
 129cW0n8KhGscKnWo4TQivpu5hyxXEOdJ2/Vs93EQ0PN8B83D8CwASIoFuansmEtjk8dq2
 GqhOm/vTtkhbhTSt0ZVoS6toy9hmIqX2zUQZLNNdmnn1kmREWjdUvutX34y/Y7iDAjs+rm
 uL1wRdM1D51Y/dIXQoC/C6sbjO+LXsBlEjABB5mQhlwg12fX3iBWx8tSHzCmbw==
X-Original-From: Jian Zhang <zhangjian.3032@bytedance.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269d61933+0cd7c5+nongnu.org+zhangjian.3032@bytedance.com>
References: <20260408085941.3837334-1-zhangjian.3032@bytedance.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Peter Maydell" <peter.maydell@linaro.org>, 
 "Steven Lee" <steven_lee@aspeedtech.com>, "Troy Lee" <leetroy@gmail.com>, 
 "Jamin Lin" <jamin_lin@aspeedtech.com>, 
 "Andrew Jeffery" <andrew@codeconstruct.com.au>, 
 "Joel Stanley" <joel@jms.id.au>, "Paolo Bonzini" <pbonzini@redhat.com>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, 
 "Jeremy Kerr" <jk@codeconstruct.com.au>, 
 "Matt Johnston" <matt@codeconstruct.com.au>
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
Subject: [PATCH v1 2/2] hw/arm/aspeed: add mctp responder device for test
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Date: Wed,  8 Apr 2026 16:59:41 +0800
Message-Id: <20260408085941.3837334-3-zhangjian.3032@bytedance.com>
In-Reply-To: <20260408085941.3837334-1-zhangjian.3032@bytedance.com>
X-Mailer: git-send-email 2.20.1
Received-SPF: pass client-ip=209.127.230.112;
 envelope-from=zhangjian.3032@bytedance.com; helo=va-1-112.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Only for mctp test.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 hw/arm/aspeed_ast2600_evb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index c43d2687c1c..1ad3264d568 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -22,6 +22,8 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
+    I2CSlave *mctp;
+    I2CSlave *mctp_ncsi;
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50,
                           eeprom_buf);
@@ -29,6 +31,18 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
     /* LM75 is compatible with TMP105 driver */
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
                      TYPE_TMP105, 0x4d);
+
+    /* MCTP over I2C responder: bus4, addr 0x1d (7-bit) */
+    mctp = i2c_slave_new("mctp-i2c-responder", 0x1d);
+    object_property_set_uint(OBJECT(mctp), "eid", 0x00, &error_abort);
+    i2c_slave_realize_and_unref(mctp, aspeed_i2c_get_bus(&soc->i2c, 4),
+                                &error_abort);
+
+    /* MCTP over I2C responder (NCSI extension): bus5, addr 0x1d (7-bit) */
+    mctp_ncsi = i2c_slave_new("mctp-i2c-responder-ncsi", 0x1d);
+    object_property_set_uint(OBJECT(mctp_ncsi), "eid", 0x00, &error_abort);
+    i2c_slave_realize_and_unref(mctp_ncsi, aspeed_i2c_get_bus(&soc->i2c, 5),
+                                &error_abort);
 }
 
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
-- 
2.20.1

