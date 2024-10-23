Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D45D2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9d-0007SX-KR; Tue, 22 Oct 2024 23:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S9C-00073c-CI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S97-0008OO-LX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso4881286b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654492; x=1730259292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X83xWCv83hGSH85wNPTrTrrz+axiWZRIP24OnLMy8CA=;
 b=Xtp8HItjTezCYOsw3rz/P+o1oNi5w9TYUBphDoJ12FApY/DfqUiUT4tqg4wQiafnQ3
 HyQ6AeuhqFoAwTonOWPMgEOXcjE8P1fh8NPit0BrEHBEjqJdBF/DlmI6CFcE6F2oZ/Le
 O0iZ9llWgH7ix7xBk6sX1G+Ud2gC2toQs2Vml/WX1+/gezN98EoRHZxG8vyhQuxwkaeJ
 5A3QbaPgLbUv5/tKVZ8liMsZvkYj+3IYPuA/wGMn1Z6JclZ3cgNl+mCyT2krMrVmXjp3
 ipUjLJrjoKbTF3UkcPV4rtzgaigk7r0n5NEIXEfxtrOCNRXHMiSR+rOXcpiir729z7KP
 ziPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654492; x=1730259292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X83xWCv83hGSH85wNPTrTrrz+axiWZRIP24OnLMy8CA=;
 b=AT19ksqGyEf2yN6uFkB+Dmg/qvatb/an0ng1fdU6V/pMUpD9LFzDR6iWvEthD2uu+U
 ITNa30GS+oIHSEJLJh7sXArgz+qE+cnNEk2ENGVJWrBOm7PoqE19oE6iEuw9J2xLSmHG
 tYLSWuARHBfXKmd1+HaKUPihkMu8uHn3So527/p+2w0eZDJebUKwb5MgvB8JjKncZZJm
 8jOWf16WYwPL7YNjr2O4W8GoInDigue97SR+Fu3q31Gvclt82KWSPcapBPveBBY3T2wF
 cO2Fh0X07A7E0seeG/HYymCPcsXGX1ZML4SXT54ELLNDV3YVnGi+TB5CKmX6vtbU1Lhw
 IdEA==
X-Gm-Message-State: AOJu0YzKNqWhMkP/VfYKWWYbIf373e7JJtA39LkEGrxo5XkiJgiOOKac
 RZZfjAPZVYWf3M37gNBjp2U0hSCLWIkfmT7s0p+OQzFoEblPCbU8zqWKSCwQCexc4EoPcrefvxM
 Y
X-Google-Smtp-Source: AGHT+IHNN0E1zZk7vFQGYamyRM2sKbiUxGoku/KZ3smeX7RnLwxYxiAZ/MrVlSTakOkUIgqqWFP4Ig==
X-Received: by 2002:a05:6a00:1390:b0:71e:6c67:2ebf with SMTP id
 d2e1a72fcca58-72030aa75d9mr2177245b3a.11.1729654492243; 
 Tue, 22 Oct 2024 20:34:52 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Yao Zi <ziyao@disroot.org>,
 qemu-stable@nongnu.org
Subject: [PULL 24/24] linux-user/riscv: Fix definition of
 RISCV_HWPROBE_EXT_ZVFHMIN
Date: Tue, 22 Oct 2024 20:34:32 -0700
Message-ID: <20241023033432.1353830-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

From: Yao Zi <ziyao@disroot.org>

Current definition yields a negative 32bits value, messing up hwprobe
result when Zvfhmin extension presents. Replace it by using a 1ULL bit
shift value as done in kernel upstream.

Link: https://github.com/torvalds/linux/commit/5ea6764d9095e234b024054f75ebbccc4f0eb146
Fixes: a3432cf227 ("linux-user/riscv: Sync hwprobe keys with Linux")
Cc: qemu-stable@nongnu.org
Signed-off-by: Yao Zi <ziyao@disroot.org>
Message-ID: <20241022160136.21714-2-ziyao@disroot.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dd2ec0712b..587954cf47 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8945,7 +8945,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_EXT_ZFHMIN        (1 << 28)
 #define     RISCV_HWPROBE_EXT_ZIHINTNTL     (1 << 29)
 #define     RISCV_HWPROBE_EXT_ZVFH          (1 << 30)
-#define     RISCV_HWPROBE_EXT_ZVFHMIN       (1 << 31)
+#define     RISCV_HWPROBE_EXT_ZVFHMIN       (1ULL << 31)
 #define     RISCV_HWPROBE_EXT_ZFA           (1ULL << 32)
 #define     RISCV_HWPROBE_EXT_ZTSO          (1ULL << 33)
 #define     RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
-- 
2.43.0


