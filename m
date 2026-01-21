Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A42C44503
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viVw8-0003p4-Al; Wed, 21 Jan 2026 05:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1viVw4-0003Qh-Hn
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:59:40 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1viVw2-0007wY-59
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:59:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so38377975e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 02:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768993177; x=1769597977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZ6t9XZ5QAwAxAU+JLleQRkqn02gh51WB6UgsTIMHoY=;
 b=wUn3sSDaHFQkfCu9Dd2ptx8jwNrib3HP7Uw6k5W5ZyWmx3Szz8RSY1iGHjMClsgqXk
 y6Dry96mpaHzpiro9wl2GZ8eg8XRj0UhTJ+3fgTrJLQkKRJOpxLM0o3nRAUqCF+36ACK
 Gmf+kaWd0tC5lm3ka3+t5kQjcSR0YVtR+Dgo3RdOT4FwuqB05sVBIojk+J87EBWD6NV1
 khMiM9eorcVW9g8bemubBORVhXOlas8tAQ41U/7nmXZyUyPmDV1Jiwad68yIEgo2OPrY
 Gg0GtWTw9lELsw9mEBgM8VZYuFpi74ms8bmrvGvlvZM9Lv/WhaY5z84lmHtDoqdYY81/
 xKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768993177; x=1769597977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zZ6t9XZ5QAwAxAU+JLleQRkqn02gh51WB6UgsTIMHoY=;
 b=ilq956AtwbdlxXZ2gMiIznlZV0s1QaAMdPxXv16h2BB9Xfv9JL+1jtu7bVDjBswL3D
 D1JW47oaCoJMN4lNjqFgfsZX+AG4/P5KsyIWWpaPjVdHvur6lteYtbZxqDxNooHSZZp+
 6Ob12yVpIW2rfBvX/SW/8dJItYkm23EFwYDn3I1TI2nZH1nigBu+KbPkwcUuql+/G6gG
 sPlaWLlxDZ39OGzHmdLEwNPPZ5d+G7UByqy70dgvC5YkLgotWxPxckF24lU7xZbFX8h8
 pMqUovvRytEdQw40GtgWGN2W96KvoCFWa61hsT2OqbJeOJSdQQ8FInwyU6LfvAl1G0Cb
 MCVw==
X-Gm-Message-State: AOJu0YwIjPOG+cpKhmDZUHIXfSLmdkwJGddJSQClxj6OoJW9DkM532jZ
 +OiaEfCajZwBQaS4qBCOes1NljPFpQLbkFUD7lQGrxzQ73uM6WQmr2QNqz7CSHMkYGo=
X-Gm-Gg: AZuq6aI65ckdVyyOa5N30Oo6KAj5H8GN3xw6bgkpsE7DMpcGt+QPt/3mEmKPMMOod7T
 Q2IphzY5kGzatNuK61h4rJEs5L0jihN60v77NUcVHh5/HNKCECy7vMJE7mNQrQz+8PfdU3SEeJM
 X9WpWGXW9uBEd6d1oaIHtns2l2FjvKJVRAhQQIBd7ks5yCe/zkaZOgfZJJ8H31RmmV9PCwukhRk
 67HNlWWcjx2jrjMRetg05pnKBzXIcKwE1rI4t139Z6mEU22T8V6LJYArFSAp3DAnsSLRgjgRKBD
 trTMUawRvL8rUCpl6evsaiwi7zlRWO2cxMS+/WWtQV9tsUCWV8YM8U9R+lWOWaZAoIK2HCgQkfb
 tm1NHJFAxUqShhDdOYNL4/LlReD64HTXuFJLIIn5QPflzYkqhmKPgXUc3v8mn8IBF8lMX7jaV+P
 NRudg87vzcdIKG
X-Received: by 2002:a05:600c:8b75:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-4803e79b7famr76971705e9.8.1768993176662; 
 Wed, 21 Jan 2026 02:59:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428acae8sm359509295e9.4.2026.01.21.02.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 02:59:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE65A5FE90;
 Wed, 21 Jan 2026 10:59:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 4/4] hw/intc: avoid byte swap fiddling in gicv3 its path
Date: Wed, 21 Jan 2026 10:59:32 +0000
Message-ID: <20260121105932.135676-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121105932.135676-1-alex.bennee@linaro.org>
References: <20260121105932.135676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This allows us to keep the MSI data in plain host order all the way
from the MemoryRegionOps write method to the final KVM_SIGNAL_MSI
ioctl. This fixes a theoretical bug on big-endian hosts because we
were using different size byte swaps which would have truncated the data.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org

---
v2
  - split from DEVICE_LITTLE_ENDIAN changes
  - expanded the commit message
  - cc stable
---
 hw/intc/arm_gicv3_its_common.c | 2 +-
 hw/intc/arm_gicv3_its_kvm.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 9fc51ad1e0b..60a5abd8d3e 100644
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


