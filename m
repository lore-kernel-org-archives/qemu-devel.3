Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D41C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDW8-0005am-72; Thu, 06 Mar 2025 10:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVi-0004rS-H1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:46 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVg-0006nh-6f
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:45 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-390effd3e85so810335f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276302; x=1741881102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xEi19GICoksLADKOo55mK0c9OwojgM4AwDlkdDj14C0=;
 b=Nf7FgUOiC1ppDQZ1S/Ed2O2IYTrP8GWk6dFxoqwBkSi0SF/7KM8XGTgZTdAnqSLNYc
 tlWwoyWqGmCXKFzT11DW5kZdKYVGQA11/iarX/mGsKTb4IBOOZZO07XBLoM3F/yr/4X2
 b08X6C70hJIRorOEMpepX6Lu9yHK9tI4Qig+w5Tg+nmNHKG/L4T3LfJJH0/uXaDkSSgd
 xAV1inTt3e1qXW+WQ40f9LHrS53LkeCgb4uYnBO1VUHTj59q7x0lJ81dMTDqtDI9iEE8
 aQg6JR2Pzcyl2k+JNj64c59SQwa7fJCv0jE/9EporEbIuy63Nyftn+Qx/qGc9dHBK9UI
 8KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276302; x=1741881102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEi19GICoksLADKOo55mK0c9OwojgM4AwDlkdDj14C0=;
 b=mQwDF7fAKGMEF2NQ2bD3PpY1fLgmuBZo0GTr+V3+naG7J3K+kI0ew+nfSEt39t/ylP
 BhNe0lZlytHabEZG2SCgBTFO0ce4Zm3sp/JpeZH5gz8jcx/GfCTu+8NASgi4h6xNJq12
 wqKU+Wl8hulbJ7mBeRG5by0TtN4sCimFCbESBE1hJW0+8Mtm4xPteHgNBEOI7Ympf9gO
 LTnSUSKB56DqnYTXzKNU2S/HkTAU8zeSy7LC+lm2pK8/0CACy8FmffrW0UmWX7E7sK9Z
 fYJTyBWRFL8Z0U4x8BM6zGygNRSdbWJp6rC/VrZYy+UfiTDd5ftYmrqCqTn91rZR4ju5
 u3/A==
X-Gm-Message-State: AOJu0YywqI6n6NWtsDKtX+xAQXmlAPIAUBAw1MMn7cCo+LU4LCRPkNy+
 KyTUrqWD7CR+v/eqSJ5hvyJpGkOdHyvg3gcvNlB1h0gxraanCo+Af/qqBNZJzjFvyTg0iirka8A
 oOwU=
X-Gm-Gg: ASbGncs1yXiAzdJ5+ytGm10ZvS4JlqRBe5to4gm85yxD++wUb5SBhycji2Aw864ETxM
 6ddP3gkd5cN5kCHMp1wIytjrxIw4hdE2/GRa/3TOmwUx3LZpeuLgrrg0CrYLYK6ROtSnpDS5E+g
 CuKmeFzcY106EL9eAGuxjgkVbVD5lLPFRx8RdzsBTuI5XVOgMEigVCMDHQLpp5Bz6GiUTIuS3OK
 8TEhKTaZyWm7N6bxvUwB+Dmpa1T1NtA4jF9XPeuY8fRASukrzxKKNmU7pTtmKUgvYvRJyWOq9Z8
 3+2IDfasYJFXAqIBnOVxfVv6zBE8poKw+lkqaUKgqdfdJseDsb0IVc6DMK4JWyk+7AfvC7O52re
 SBLsgHDaDhdlxpi8Gxp4=
X-Google-Smtp-Source: AGHT+IEVrov16+raJ7o2l7HY9jVUt18KcgUcA0AfP24jVhhusgHCSyixLNk2eCd9tgvCgDUviWTRiQ==
X-Received: by 2002:a5d:5f91:0:b0:391:fcc:9ee8 with SMTP id
 ffacd0b85a97d-3911f740cb5mr7729816f8f.23.1741276302120; 
 Thu, 06 Mar 2025 07:51:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103808sm2438477f8f.97.2025.03.06.07.51.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/54] include: Poison TARGET_PHYS_ADDR_SPACE_BITS definition
Date: Thu,  6 Mar 2025 16:47:36 +0100
Message-ID: <20250306154737.70886-55-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Ensure common code never use this target specific definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250305153929.43687-4-philmd@linaro.org>
---
 include/exec/poison.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index f4283f693af..d6d4832854e 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -48,6 +48,7 @@
 #pragma GCC poison TARGET_PAGE_MASK
 #pragma GCC poison TARGET_PAGE_BITS
 #pragma GCC poison TARGET_PAGE_ALIGN
+#pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
 
 #pragma GCC poison CPU_INTERRUPT_HARD
 #pragma GCC poison CPU_INTERRUPT_EXITTB
-- 
2.47.1


