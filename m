Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19B0FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLOt-0000Vg-7s; Mon, 27 Apr 2026 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNr-00086X-Vc
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNn-0005gi-Kj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso50193405e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294092; x=1777898892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U6+LMwBwSx9z5uRa0bJxch1nnS9wZaiUEFSDL/4DmaI=;
 b=qBAeMCCubKzAMrmLM2RsCjqwKFrWzvujqZSmK91i6BR1rtJAelsrH8oHMljXxJQRId
 NpLY/26c2TqEUsmGTIS1YRKipt2Pb5z7pYGJGSZqvaTq686avIo0kdCo9xJQ/HmKWKfT
 GZ93nYRNdv11LmV9jBw3MR2hWIO6IiD3V3NBLX3ZKCQnHqD0MD2kdXasU8EKEJALP/jZ
 C/yd6tdOTEfExi3gowncSVvJXkmgPMfXbydirZ9Alf3B3FQtsJLfGaC0CDkxInpYvdn0
 /fnwW85nOaOKC0MsMIYjBO77ZB9vpPcIVBs6xbECyiv2QrOcVDD5KI8TwdwWDGcyMo8f
 ZeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294092; x=1777898892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U6+LMwBwSx9z5uRa0bJxch1nnS9wZaiUEFSDL/4DmaI=;
 b=oWawovx2q1H03r8Lh4AoFN1rLju4fDaMyelwSW1uyTosAvLbxwxfp9ryaPYq67S814
 Sx/OOoFJ5GplOmCdeEXLOLHgjrfpVO6eLx0F+8dGYrzsnlKePa0ZFIrLk/eIJt9HySO+
 Rvr0yb5omA0G9W0bptF4DmABi7MobDAH3h08AL8FO7B0a5XwGGXA9jjHW8ljJCbPXfdi
 yL2oa7Hbmf2Ot9+WRCpdMsnVFJHOd+A8b4N8V2wqh0HXyYYbxZDcRfwHc90xwxDUZIwX
 5vBJ1ocVIlJCJGCXCb8BomZucZqPk03IBXkd4dSFml/w/FK/pBJnkOmVJDpGjXi4+HLv
 tzjA==
X-Gm-Message-State: AOJu0YwzECF6EQpviWFOs0zC3GRZffywk9l49XBrR+9b0C5spoWNLXUd
 5xYGN07ywnwLWeAjg5dd8ZUIT9As4NbuWfl9nw9IuSl6lC1f7OoNcSNuIAhb4tQLYGAnIoEo/pb
 s8SRc
X-Gm-Gg: AeBDievsB+CGG0aoANoIZ9YFP/QZLDQu2QtbQKD57dPphkflGACLXmex/5/RRpYXmOr
 9vZVa+K1J8mXq5gInvT92UyXvhL1przOBuNe/A0iNkPxaku9vjcOZKwYg+bm9JWKmU7siUnx5Fx
 A0c6i8ciuc67iPv2aqThHPCvBRCWW4QzmnWYDPIyFvfNLRWw+x1sK5Frj3cQiic3K2TFBY+SstI
 hf7/mIqQcRbkIyAjSe0aRbhRMM7bNKwr2IpZ2oY0tCOX3Cq0wXpwCybtY2qZxKD4qHbASaHY0NX
 Buo6+vGERfmP8S+OXeef64uHHg3R/0Tno7K2wvobtRuSzQzJLzdkb3xHrqqTCs9s1LJZB1EYAkz
 jKd4ehjrerNaEQCimLiXVT3+EHJ6dwh1Ui6eQKRuOkZ0onA9oxL3HZ3o4G6ic/Lf29C7gE09W+d
 OTPwIpcZa0iGzRxOR9Ln8Bt0G2zYaZGIHgm8IScFlHACmOrE68nbYOpbQfDMRcOFtunXqPpHTMW
 gqHJyVrWArhyA547r1jnTNvd//u/U0qwaWgabUCxw==
X-Received: by 2002:a05:600c:8a08:b0:488:a82f:bb9b with SMTP id
 5b1f17b1804b1-488ff369a1cmr479913435e9.30.1777294092081; 
 Mon, 27 Apr 2026 05:48:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/63] target/arm/cpu64: Define cpreg migration tolerance for
 KVM_REG_ARM_VENDOR_HYP_BMAP_2
Date: Mon, 27 Apr 2026 13:47:09 +0100
Message-ID: <20260427124738.966578-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Eric Auger <eric.auger@redhat.com>

KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
from v6.15 onwards. Backward migration from a >= v6.15 to an older
kernel would fail without cpreg migration tolerance definition
for this register. If the register is present on source but not
on destination, its value must be checked to make sure it matches
the reset value, ie. 0, meaning no service is exposed to the guest,
hence the choice of a ToleranceOnlySrcTestValue migration
tolerance.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260420140552.104369-6-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e7014022df..a93ad2da5a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -834,6 +834,17 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
                                      0, 0, ToleranceNotOnBothEnds);
     arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
                                      0, 0, ToleranceNotOnBothEnds);
+
+    /*
+     * KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
+     * from v6.15 onwards. Backward migration from a >= v6.15 to an older
+     * kernel would fail without cpreg migration tolerance definition.
+     * If the register is present on source but not on destination, make
+     * sure it has its reset value, ie. 0, meaning no service is exposed
+     * to the guest.
+     */
+    arm_register_cpreg_mig_tolerance(cpu, KVM_REG_ARM_FW_FEAT_BMAP_REG(3),
+                                     UINT64_MAX, 0, ToleranceOnlySrcTestValue);
 }
 #endif
 
-- 
2.43.0


