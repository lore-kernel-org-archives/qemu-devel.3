Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C0CCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJX-0005SE-2y; Tue, 21 Oct 2025 16:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJN-00050M-28
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJH-0001Xh-Fv
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so40263095e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079819; x=1761684619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8+mIUrwS9misif/yxHTdNYcYKWXudE/3bhL49JVCt/E=;
 b=Hyk8dd1Bv3ZNL1UnQH2AMIUN/3Pbfv7SDu4h3oqK/DQsMIUc3lyzcL0bo9ozMv0Uo/
 GmA3AZBwFSIq9Q6N1c4foFaEFZ3RUejuFAY12pYP44J94atdJ5KP3GiTWJUP4P1mRI7p
 FqHv8zpEj+IMFyzW7wo/epyQ6pkke8IbPMTnO8AhwX2NVv1L0/JRiheJ8opb+ZG9sTaK
 57uSnwggQaaCPrniMX3WuG/MZCRZqMkMe08bmc7XTrhjfktJ802Nev9jQAFMLM7rNgC2
 oQl8Ynuy/EvIPZatt044ZvNXAoWotAYINJdks5f7sG0GVt2TSD72mnOyY2PD3ymEuslO
 8A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079819; x=1761684619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+mIUrwS9misif/yxHTdNYcYKWXudE/3bhL49JVCt/E=;
 b=Tpmkl42PzZXdg+WlBMBx36+oozErCNnPs+rlAnOp6BzAHanwk5P7IEZzUfaXMl12hw
 Ze8jQ2kTke+EADqXiw/bJWPXP92oyUUH12IwoTQkCBfP8z+OjpV35OwLpkrnjgqBPc9G
 3r9wxgi9mNEw4DQcDX66YqOyRJe+daAJsMMZBOFDDK8USFiXbNJ9xSnfYXg2Si2liE2d
 dXjNZ0VyQ4YcQ0y9ugCukqk1LKRgg+CPgw7Xk2MKD67ks7YJiHY2dxrV2A/9sQxNtY0t
 qpoJ/ae1BR1VbNq5uy/Ye5Sxx77vTJDSMeRbW1OyBTgnaWauuE2G9TS6awR46Y0nd4QW
 h0gA==
X-Gm-Message-State: AOJu0Yz9EcGdd2f+kEjvcMNeCdA7pu917WklCfrln6xNPS3zl+OtW2YZ
 NpucgBfgEVy3rEuVLNaaSDX1qPoYK3HFhNQ24KOBLRJgd/zTmf5o/0jz6DRXv59XaHNi4heMryc
 ofYy9++8=
X-Gm-Gg: ASbGncuG//p+ageMIYZL1KatDs2J/YPeIghpxeBLeHtAk7em1cafG4eHEgqyDVxPC4X
 eDt9d7pEfCE68O9zSVf6gB3gWhNl80BryynqNmJFerVyDinDq8V49gNCGx+hw5fHLMuO+wE14E7
 TvW+BCklpOVd7lwtHltLfs6Hkjuf9IZl4PfoTBVb/MGW7ZbWoaMyKnpZC+pJVeFEVFcR/btudQd
 5TPZXVFlhHmu5DJsP9H4vLr+WFBXcdNDXKs54rGQ8J7RzLVAGfDXchfKxgTnmD0Urfdr2AE3vpj
 aP55nsngMVw039J+WwA6aP30qxNHpcU3djPGM3+npVXRpt144KfhFOKcJz7Qt6qHNsxzVypMJ/Q
 jt9VVXdtTUZHbJSjHWjG9FfblSDwtyFCvFCr2wUlDAGmaT5MDf2sUGJWAU0Hsn4/BWJesOpkoWZ
 WHMp/aJXuejnZBU/Rk8soRLW8vBM5x5CbhMyZwQsYQ5XqI4RuC+8VNgrdv7b1A
X-Google-Smtp-Source: AGHT+IH0ckarYdOwYsc7SCvkF/M81GmT8bT9QiINHVfg7YgXaK9BKSGgOX6NFVZ+bu0EXGT7QJtgjg==
X-Received: by 2002:a05:600c:4f95:b0:46e:345d:dfde with SMTP id
 5b1f17b1804b1-471178ac017mr120968615e9.16.1761079818825; 
 Tue, 21 Oct 2025 13:50:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42d9524sm9275545e9.18.2025.10.21.13.50.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:50:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/45] qemu/target-info: Include missing 'qapi-types-common.h'
 header
Date: Tue, 21 Oct 2025 22:46:56 +0200
Message-ID: <20251021204700.56072-43-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

When adding the TargetInfo::@endianness field in commit a37aec2e7d8,
we neglected to include the "qapi-types-common.h" header to get the
EndianMode enum definition. Fix that.

Fixes: a37aec2e7d8 ("qemu/target-info: Add target_endian_mode()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20251020220941.65269-10-philmd@linaro.org>
---
 include/qemu/target-info-impl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 17887f64e26..e446585bf53 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -9,6 +9,7 @@
 #ifndef QEMU_TARGET_INFO_IMPL_H
 #define QEMU_TARGET_INFO_IMPL_H
 
+#include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
 
 typedef struct TargetInfo {
-- 
2.51.0


