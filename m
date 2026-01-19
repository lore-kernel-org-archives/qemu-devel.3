Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C516ECCF2EF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhnw3-0001Lk-3T; Mon, 19 Jan 2026 07:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vhnw1-0001LA-St
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:00:41 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vhnw0-0007wX-7E
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:00:41 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432755545fcso2308603f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768824038; x=1769428838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AqxHyjEuQPKHPyx5WfORnyB0ROCMxrgg1w6gOY+4oEM=;
 b=fwOMScZrTV3RYjwONwkocqT82Lmd0ZjpzBBN4wA5nZK4Dbyd1AzQynvfgGg+4YIPqS
 vn+R606SJzZ8lb8OVXb7jlXntdI0ZXO4rKh/TYEzPyslsBzwMpBrHgDpC6YJ0OZoYt7w
 PSvY23kiEXSugZOCWuFZUYnljo0mnTgrhkDGv3N3j73kngg/+eFW413bxWlbYOv1eex3
 pS73OXb8sZwbc18PNUGuXSUCKF2KEf71X0HH7wcnN1amI+uP6NYS5KNxOxTKWwo4doMw
 DvTd8G9hONOAVis0JXjm2+Dd0veQUL/V+ErpFjCduFsxor4WvX/5WpcgrixBw4ETDXEi
 0Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768824038; x=1769428838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqxHyjEuQPKHPyx5WfORnyB0ROCMxrgg1w6gOY+4oEM=;
 b=hlmiixLz+frpozquQhIJId7SP6+4eWN7p9tvYbX0YWE3bf/Y+Me0ObXxCUDxI2NKMp
 nZJC16hjk3nTjbmqkK/RMzWOxehoVM0Z5Kghg3gFY+V1dzWf56dZb0nadxoyxk3MR9bQ
 1d0gvsfiPYXUgLuexbYxr/YouQRNs6d316/EzH71j1KB6Fs2rF85yE3kK3WcnQhmgQfY
 cxKMGmfcSvWY2t1dz+EYv/yJ1ghbEqL66fRdXpnDbFiaYTafLhVekiuhrVbe6wzXVR2q
 58MQalDs+CWnhJj6WHE1eNRDPEfvnNHNC7DhnF7IScSeIxetvQHU0/o5BDOfeLr6GQbd
 IFkg==
X-Gm-Message-State: AOJu0Yyqmf66CR5+iOS2hRjw7ARIvzauWIIB0QJLk6ojEEI/k6vLmnBq
 +5Q+w3InK5HHJ5ZNlwIydGt0wkZP6h5AfnYuYBM6gFlpTuILkhCSD7CRZD1oW6EsYCo=
X-Gm-Gg: AZuq6aJzYWn+hbkQbC6MBofA0yfzMpsC629Sguag7y+wq8596U+RXAG/HRHJSn2N0uA
 mDHMLEIA2X5Ps1Ntwp4sdt4SmmGg85XjZHWb/fK6ePnlh8rY/cwVOc8JDhoC7cqdlAQ3dcphLV8
 vcj4wqsFJl2vgA9teJo6lyxdeojbDtPwtmHspMgqU/ggpbJ3K5x+Y/5LpAH/gO4OYS1zlggxZ8z
 SeSNGCB1avP7W3zcwTqKmxAXDxb1GyrBKeN10gkL64QNOyonfoSBp/Z9y0/uulJx3DhZKaAqo4W
 zAg7XshcIq46a4uuEKZCAMu5pQIVdwUrXoIEICHsyA6GttYRMIF92yhN2VV73lVdMj28IP2llof
 Rcos2JhNAY2F4NsAxAUq+dRPhnyiK8x7N98l2a67XQp/upyH2hOGiniywsaLMUrc58DA8Lwxwun
 KHYqAdyzn7Q5BI9Vk13MteYA==
X-Received: by 2002:a05:6000:2481:b0:42f:9f18:8f40 with SMTP id
 ffacd0b85a97d-43569bc6d7cmr14046408f8f.42.1768824038400; 
 Mon, 19 Jan 2026 04:00:38 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf33sm23397065f8f.25.2026.01.19.04.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 04:00:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E3825F87E;
 Mon, 19 Jan 2026 12:00:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM cores)
Subject: [RFC PATCH] hw/intc: avoid byte swap fiddling in gicv3 its path
Date: Mon, 19 Jan 2026 12:00:30 +0000
Message-ID: <20260119120030.2593993-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The GIC should always be a little-endian device as big-endian
behaviour is a function of the current CPU configuration not the
system as a whole. This allows us to keep the MSI data in plain host
order rather then potentially truncating with multiple byte swaps of
different sizes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/intc/arm_gicv3_its_common.c | 4 ++--
 hw/intc/arm_gicv3_its_kvm.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index e946e3fb87b..60a5abd8d3e 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -81,7 +81,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
     if (offset == 0x0040 && ((size == 2) || (size == 4))) {
         GICv3ITSState *s = ARM_GICV3_ITS_COMMON(opaque);
         GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
-        int ret = c->send_msi(s, le64_to_cpu(value), attrs.requester_id);
+        int ret = c->send_msi(s, value, attrs.requester_id);
 
         if (ret <= 0) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -97,7 +97,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps gicv3_its_trans_ops = {
     .read_with_attrs = gicv3_its_trans_read,
     .write_with_attrs = gicv3_its_trans_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 void gicv3_its_init_mmio(GICv3ITSState *s, const MemoryRegionOps *ops,
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index ae12d41eee1..a8d6d4fb540 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -58,7 +58,7 @@ static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
 
     msi.address_lo = extract64(s->gits_translater_gpa, 0, 32);
     msi.address_hi = extract64(s->gits_translater_gpa, 32, 32);
-    msi.data = le32_to_cpu(value);
+    msi.data = value;
     msi.flags = KVM_MSI_VALID_DEVID;
     msi.devid = devid;
     memset(msi.pad, 0, sizeof(msi.pad));
-- 
2.47.3


