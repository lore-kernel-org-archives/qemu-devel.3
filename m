Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BACAF327CD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7Vr-0007yT-06; Tue, 21 Apr 2026 05:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wF7Vo-0007xv-DD
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:35:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wF7Vm-0007eC-T7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:35:20 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso30954145e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776764116; x=1777368916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B8wmPdxsTtoVIQiSn8NhB4SnGv17V2Z6hlvm58P36Ro=;
 b=GbERfvUHDFaCQmA9iW3LJjml9RmEM/GOViS+w20xMlLFojiOeXsnIK3vOMStFIFHQT
 /zSAPROkfs/F4nf2hrRHtlaLxb8RGKzXHXeVPSHyBRJbgHKW03irBI+goN9jM/2T319n
 P52nTfZlm6ISpv2REkKaHkrXVDc+ta1cnLrJufZ/fbjPY4wd8q43DX1aKfhcd0sX2NY2
 99yCzYQP1Bz5JFIKk4ToSy+rSDyGUC/48Yj/0onKzcaU9SV8Qby3SBtIIxy2DG8dhsAd
 ATWOh3H3UxPwWrC+dtnaAFWb6DLUWS3hkhCLK5x9D1nF2juPQgjj1742F6KOc67rEd2t
 pfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776764116; x=1777368916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8wmPdxsTtoVIQiSn8NhB4SnGv17V2Z6hlvm58P36Ro=;
 b=AwN0rUE+UBh3ZQ42DIqEIieaJyEDeFLdfKgorxpRrWK50UFwyuapgpThvdQkDdrvCr
 CQ7C06kW0kTW6JGqa91anQTMz8aUJTrtVXmLl+rVUqM9qoy2NCIOP5u4sJF5ijFkx1t1
 57srM7FUlBSocFQlw6xEVqeLmi1tyIQNZrrkul4jDoWVjdxFR6gr5a1Qc/TWl9pAR1YJ
 n5HwBAARC/JAeRaUU5BVcHkpNn3cHJ/AE1JbhGXGBXxckkwuiD5gkWqdDuM0iUC8n+8T
 hrrKtDZzcfwXLIOewNBemVmJWMfY2Big7aLgA38pNXSCH0GOdZ1KINlUVm0ZPdVnmJLC
 +Flw==
X-Gm-Message-State: AOJu0Yx7XMmRPSAFRhTPsgW3Gs8SjgPGEtS1MfRYmo0z53mPFJ+zsho9
 KjrUiUmgyKcfeqnHy6JIyOWqneB5Vk6VCD3pt9Sd3xbl4d/n/cpsYZEMZpiXgwpK344=
X-Gm-Gg: AeBDiesKJ7P3xe1x1oKb88hGoH0yC6lJHHTzA+lXB03QXNqV/3ny9YZcWgp8LOWQc99
 oObupathssDqT8a1pdoqaoY1HeBesybzXMYy7nctBZ+sjULqMn8kd+ifPTRecPtFi4YEh5YT4by
 wNYWrijVR9LVOENjLimwJAbNV6RQiHFxDJA7kDMcjAan9FHALxl9IGoCeBEEkUFLlPpee4DI3tQ
 Qin8vWKE6QXQ2/EllYhLPp4lRwnLH7hbAzq3pGTFWaQ+MnrL30UyJxr0i8CyUDzLS26W64BrNnW
 kzK0ghnFI2aHZ8+NFmitpFpC5w3x+rHknp1ZACcMetPGyqS+JijSqwLzXAiMwI3qT4A4YPe9DKj
 xsdjLcFp0IH8nrGhCiG7tPfy0T+tGQOw4FCKOmMzOkUelXAEVFMlaFMqC8lCq5iKrmddw5RrEVA
 SsiqbFEy02aYxtp4rf+c6vQZdBSsDnjw8JYcr2l37wCm1M
X-Received: by 2002:a05:600c:c0d3:b0:488:a916:14a8 with SMTP id
 5b1f17b1804b1-488fb74fe74mr195927695e9.10.1776764116368; 
 Tue, 21 Apr 2026 02:35:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a55dc9f58sm81256495e9.6.2026.04.21.02.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:35:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C4E85F7FE;
 Tue, 21 Apr 2026 10:35:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH] docs/system: add FEAT_AA32 and FEAT_AA64 to emulation list
Date: Tue, 21 Apr 2026 10:35:06 +0100
Message-ID: <20260421093506.616307-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

This is just a documentation tweak as we already support both.
FEAT_AA32 implies FEAT_AA32EL0. FEAT_AA64 implies FEAT_AA64EL[0123].

This is however useful if you are using emulation.rst as a source of
truth of what QEMU emulates and when cross checking with
Features.json from Arm.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7787691853e..8cd7fe7b00d 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -7,6 +7,7 @@ QEMU's TCG emulation includes support for the Armv5, Armv6, Armv7,
 Armv8 and Armv9 versions of the A-profile architecture. It also has support for
 the following architecture extensions:
 
+- FEAT_AA32 (PE Support for AArch32)
 - FEAT_AA32BF16 (AArch32 BFloat16 instructions)
 - FEAT_AA32EL0 (Support for AArch32 at EL0)
 - FEAT_AA32EL1 (Support for AArch32 at EL1)
@@ -14,6 +15,7 @@ the following architecture extensions:
 - FEAT_AA32EL3 (Support for AArch32 at EL3)
 - FEAT_AA32HPD (AArch32 hierarchical permission disables)
 - FEAT_AA32I8MM (AArch32 Int8 matrix multiplication instructions)
+- FEAT_AA64 (PE uses AArch64 after last reboot)
 - FEAT_AA64EL0 (Support for AArch64 at EL0)
 - FEAT_AA64EL1 (Support for AArch64 at EL1)
 - FEAT_AA64EL2 (Support for AArch64 at EL2)
-- 
2.47.3


