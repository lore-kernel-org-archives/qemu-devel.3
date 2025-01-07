Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F39E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4YD-0002Qa-FK; Tue, 07 Jan 2025 03:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wn-0000Dl-5o
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:30 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wl-0002uC-GD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:28 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2163bd70069so31434355ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236886; x=1736841686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnf+fSHWEdd4ca8fA4cnMkUUnEWFBlmFUk49aGQ3+K8=;
 b=y2YcytOxgUEUM0OmeMpRgkBOmwfScN628RRv4ATZMRoNe3TTRSG5muDHwq2KaNPnus
 E8i9zpG/MapP+/Fr36cGnD4KSM4ztNItZVKZdvysB4mY++sB1Yt4XytblGn/naOw8X54
 VfjP4sS0AC8Grpnj5jcrppgH9htV1ox7/ELEgz6v5JBqIA+LPWwhu1+kpPBkE+Pi3koF
 qXjWcI7bdT2boz0zc6zS4YCq6T7b6G4x7scIQeU5Xoi8IDhax6yyOcKasyiVHYZ0FnkZ
 TH3LjGUUNcLRudFcKKP337liXJpBLOFq3yB2vSePFw7lrWn/eQ3PqNXzVDD5d6tphzKE
 xvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236886; x=1736841686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qnf+fSHWEdd4ca8fA4cnMkUUnEWFBlmFUk49aGQ3+K8=;
 b=UQizO4wsxWbnmo2aUc9ofcOdBWmBlOoO1zL4R+uHZ4AVIlnQYuugmBtcJ0+ozyqVZ1
 fZTl5qVeOyHE1XgJfAdJjsayRPveVrNPvmbXIZ9A5J3PoBNNlbo1PmYfC7Et2svQwH42
 lEqmPL81NhxZ6Yzjchy2ZeojUly+8JkFMv26dlreTSggJBOOmMmV3+fvc6GJDkVcMl0M
 qqL0tqVf5bxTVc+utDtxPLF8VGvbDxAN+3+wGe0cm2skjTtE0IEMm92r3rL/iaIwG+7N
 TrxwVmUW1O5Sxoi5r04aD/WfDqqYQ7g98+l9635MgAEUaw3cdKE7umW7WtV5U/rd6/0S
 vQUg==
X-Gm-Message-State: AOJu0YxBHL85UbTkXqRWyEuzA631PMqzsvYM27fJWonNXz0zZn3JkRZH
 PQToHAh3aklksO9RdOf1x9a4mp39yC7xZfWVk1Qp0qE+4rb27Yo7h1HvlV/eL/c+EITOiCTnpoE
 g
X-Gm-Gg: ASbGncsDROVf2FZE/HsNYndnEaCvTtGxPx0hrVm4CfeyHlT9tGNi/bwhnvHkyq3NegQ
 Wxvn41sqv65lxK7V2m6OYj/X4JIqXg0L0tyWuknVT0Yx0BwpR0lYNQF4x2GPPJv7wX0Iq0no3NA
 ICZjdjMduH7Gx6D6Xlm4VkllNvk2IeqAE6CrJNTTh4n4XHYP1tIPk2zpOmm/kI7rlQ1yE3NNExw
 vIKw+CTaZh/OHI86dOm2lSSpODcw/dVvReFOCg3wIuMnQmX2zPArOuKWNci4fq4OPHeWUIOoltt
 1yxa75ppjCWFbSP5TQ==
X-Google-Smtp-Source: AGHT+IHTCrqUsQ67wG2h38KjGj0hjbe+4LHd8T4udrtkU3UuuQLTV9y6Q7h+65C+eG+ZnuUfK5LZEw==
X-Received: by 2002:a17:903:32cb:b0:216:4e9f:4ec9 with SMTP id
 d9443c01a7336-219e6f13c68mr902084445ad.38.1736236886066; 
 Tue, 07 Jan 2025 00:01:26 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 11/81] target/i386: Remove TCG_TARGET_extract_tl_valid
Date: Tue,  7 Jan 2025 00:00:02 -0800
Message-ID: <20250107080112.1175095-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This macro is unused.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 785ff63f2a..ab416627b7 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -26,11 +26,9 @@
 #ifdef TARGET_X86_64
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
 #define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i64_valid
-#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i64_valid
 #else
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
 #define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i32_valid
-#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i32_valid
 #endif
 
 #define MMX_OFFSET(reg)                        \
-- 
2.43.0


