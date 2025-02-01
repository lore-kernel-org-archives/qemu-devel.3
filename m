Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D5CC02194
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZ6-0000E8-Vt; Sat, 01 Feb 2025 11:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYk-0007Rg-C7
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYi-0001LG-D1
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:29 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso20894315e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428087; x=1739032887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sRqqPpGVbwUeVvN/4CiKtvqDsOf3lS1J+P0K/UtKIGM=;
 b=dT5P5lJRTFveA/1AYYer5eXkjMpdL7GPkOtwELoJaPmy9lHNqYS0BZASLopodhTaCy
 CDjg2oZEeQ/sGvufTBcApWkN7YDWhEuSNf5SNMzSeQMJE/VzrdrPvSMAskjf4ADg5P2q
 Q6i/7BrbCmQ1QSjRzZZaSgTYIJoqcGZMsgOQadbkLA+9lx7C30lSD586eNRxarjAb0rf
 n17ILUiBL8x8Kd7wVtSdFQIe57DruIIqGigatxTrsnsaN5vqm45uL4R5BcAjURWjfEw1
 iKAsaog1mfp5VJLX5i3m5lJLEhgeWjfOqMHwgQWogkt3PdrZxII+jovRjPWb6n2FC0rS
 CEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428087; x=1739032887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRqqPpGVbwUeVvN/4CiKtvqDsOf3lS1J+P0K/UtKIGM=;
 b=JwveoAxKivFGkwmc6VU6MZHrbaMsXHpotmcwwRjMAdsXQsEpiWa+Czc9nsZUNF3IMs
 E3VD4hwxbdhsz45W8RAuNpJqNeao32m87N/NQrmaAAfbbv9TPUaPb4tYavbQ3P5AdvQK
 vDmb4BZsh2uMXh/orI9Sg2AsDS/YcawdGMQAHJrZMswlIaC5eLxIYMeSseD+gEC79drV
 Y1kDw9Cp/FskPBu4mlwKAvGlM3VNHeJKu1p80rcTtdEonZqCA+M2k26nqcar9pcCDRHJ
 zP3ZtWthS0z3DArivCfYwXOmUSIOATRj5JI17LsLD91w8oQh6WaQhz2Zq/BXUDxh1XuO
 ZazA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUYwg04LofUTiu9Ed+X3rS8QTsAybsuShwufKZH8OTSh9zlkKfaIRs8sLO0sEJiBkb9+euRx3N5yQr@nongnu.org
X-Gm-Message-State: AOJu0Yyr2d72qkpKLy8Z77k9UBvxaWic5dmcKsdruANlYom3Skh1muxE
 +D4sz9gTCCzH4+TlL8hbCTOjg2TvavblvR2d42ba1wEyjshUl0/XUhyhper3UEBgteQ8hDuotdD
 Z
X-Gm-Gg: ASbGnctMdh5mws17q43O0IV5Az4k+/fzbPqQFWNptgdggg+GKiqFJcc4jae+gK5819N
 WGAAApF6Ve6SGjwExMmi7XB5QbxYtJLJt6kfdj7ibESXCLzZIf7l8fKqywo9mdJJgP3HizgHfXn
 RoeJaJNxeaA2+UuCs0ni2miWSbz08FiOiOFmRwpXLpbd+aJEj3bZ4KrdvnwdlEZ/BFH2MZ/ju6H
 ihmRbodXWvJshZ7tMC02NJivEgViGsc3QnfBNboo2WAJGOSZioYJ53QqxN1rx1dSUfFmXghZdp+
 mFd+X3yQIzoF2/w1A922
X-Google-Smtp-Source: AGHT+IG+h1Xz42lPTY+J9n9oUMwbdOgpDkZuj7s59SXh/8mh3EUMmQARRJ0Fl2ln5318r7DcZeIVmA==
X-Received: by 2002:a5d:68ca:0:b0:385:decf:52bc with SMTP id
 ffacd0b85a97d-38c51b5ed4emr9356637f8f.32.1738428087006; 
 Sat, 01 Feb 2025 08:41:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 56/69] target/arm: Enable FEAT_RPRES for -cpu max
Date: Sat,  1 Feb 2025 16:39:59 +0000
Message-Id: <20250201164012.1660228-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Now the emulation is complete, we can enable FEAT_RPRES for the 'max'
CPU type.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 63b4cdf5fb1..78c2fd2113c 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -118,6 +118,7 @@ the following architecture extensions:
 - FEAT_RDM (Advanced SIMD rounding double multiply accumulate instructions)
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
 - FEAT_RNG (Random number generator)
+- FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SEL2 (Secure EL2)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0bc68aac177..29ab0ac79da 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,6 +1167,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64isar1 = t;
 
     t = cpu->isar.id_aa64isar2;
+    t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* FEAT_RPRES */
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
-- 
2.34.1


