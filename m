Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D57E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyI-0008D2-Vh; Wed, 08 Jan 2025 16:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyF-0008Cf-S3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyE-000404-8j
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso2352495e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373123; x=1736977923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZJhlkmlayFpUeqjr7RAzVc9FiLlsMH2hRpk2ZVeInw=;
 b=Z1hlXZRqErX8xlVg8souNoD6blC7FcwO6+jQkwSa677RjH1B5n25WRl5Kc913GACp8
 b8drLp+GkYxtYknOJANBDsKMvbpxPF0x/6reof4SFKyxeyjKH8jq8vUy3pgb68RGDupQ
 R5Hi4Gare3TjcuLQ0KSgGESHQB8NQ1+NbGEz8bOQ+SlBrVfs6aHCbRxYt44Qo4COKrah
 sQ4Q7R8ARaIPxaelG5UpHstZBRjK+oZuPfXa1X5sm5khRYSY6Vn0+TGjABj0BB24pxQ9
 xOeImYYNSenJ+Z3cNOKW3AxOogF+EWticfrdcwH99X7oEAMaPx0Qmh2XLk3iBC8zYJLl
 r9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373123; x=1736977923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZJhlkmlayFpUeqjr7RAzVc9FiLlsMH2hRpk2ZVeInw=;
 b=I5teLHXL8HnpRjrKxrXZY4N6oLKGfCa6VBhWQMy13I0PQi8NrgNg2YxrSBu7nG/XHC
 sFsv7Q9V7tFZXgUOLbJ/7kPn/kByMTc4MD6k/s0jW4ZK1l0LDH3OnYY7LdgNw/707Qp5
 2DmpVYvETgoLlqJKnR9hHbltc4x0QCMFxVvXzsFvUJsMWa7JQxEpj7Hoz9lOSVv/+axH
 jCli6bxNTpUVmQU3Pm4/QT7VQCKiQomxX9mWJLI6lrLABG6jgs1VgK0345tYpOzf9ZLg
 K9lEYm2HHzSjm9yIQZ7zxG54Eq7ONG7Eg+JYbXh8nW43hW8xDvI9KbK6oDycziJn2CaC
 wPcA==
X-Gm-Message-State: AOJu0YzOPJlexYdOck1Arv57vMjcpATQbPs+gX2G2AS7KcoILArBiFJp
 xXqmU1ESjtQCYjvif1juGustSuoqr4faLletdJLTvkPSat9cqLuP11MdfrFFKQvNNR/ui2BstvD
 3zvI=
X-Gm-Gg: ASbGnctdZQEmOHAUCGCj5wWARBJ14Ql1th5W+JyejB7YsjmxTVyi47Xs8uaMLTsFkbk
 peKxTV8TEqoNUng+bkx+PgQZKV7yTHuxLPlgNx6h1Kc1pnoBlwbhTLUO5k2rk98P8WPZViY7219
 Nd7f7hHYscVvuRppphkm7WSDwgnj2PfF46Y9Dil4CYdbgs9wx0VpNEmkEnsKNwa69fKvxqq1+PR
 xnM0NHd0meeFHtniBv0dbsDKk+UVb2cvghYmQzJ3kC3xXEcIcDe0c0GsdaqQWBnfbSw+8RScG1W
 kMmcOaDKiUE61NDWj6q1UtoPegigQic=
X-Google-Smtp-Source: AGHT+IEqNL+gCfENTqskniWKn2SVYVF16O2GKXejLbbsMKoWv5DYwsgB60XvWaQ2c/AB/0L0EwfBug==
X-Received: by 2002:adf:a108:0:b0:38a:88ac:ed10 with SMTP id
 ffacd0b85a97d-38a88acedf9mr2535671f8f.25.1736373123134; 
 Wed, 08 Jan 2025 13:52:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e99b4a5asm739205e9.19.2025.01.08.13.52.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/14] tcg/ppc: Remove TCGPowerISA enum
Date: Wed,  8 Jan 2025 22:51:42 +0100
Message-ID: <20250108215156.8731-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Left-over from commit 623d7e3551a ("util: Add cpuinfo-ppc.c").

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/ppc/tcg-target.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 8291e0127db..4fa4a30de41 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -55,14 +55,6 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
-typedef enum {
-    tcg_isa_base,
-    tcg_isa_2_06,
-    tcg_isa_2_07,
-    tcg_isa_3_00,
-    tcg_isa_3_10,
-} TCGPowerISA;
-
 #define have_isa_2_06  (cpuinfo & CPUINFO_V2_06)
 #define have_isa_2_07  (cpuinfo & CPUINFO_V2_07)
 #define have_isa_3_00  (cpuinfo & CPUINFO_V3_0)
-- 
2.47.1


