Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C157ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Nyj-00027w-Sq; Wed, 08 Oct 2025 02:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Nyh-00026p-WC
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Nyg-0005Yr-5i
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so73569645e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759906123; x=1760510923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqAqFGr+ulSrtJouz6Xn5Oa4i6EGYoP5rKMr4dMr6wI=;
 b=PTfBB0LTQgbMjYii53xkPrsqkKdTL9wrUPROJUzJi0MUcqBbFaiCAklO+eGzKOaHr9
 PWQk4cT9t9Wgvn8FCSVwqLj2jPQWRLQItxriqI0msAPae3ZeiRmHW/jyporK9Cw+Ghpt
 8kyXbV64v6LtKqwVt9eiPj0Zm/f9kTCXOoiIxYAcq9y/odVV6fCOgRWTzqbqbEH500lb
 RnW0t0bs1ad47j1LBCaGuWE3ZtuvWcSmzT2S8XKdEsE+nuWxpRW2NS9BhBOD28fDR1cs
 rvv1OlEW9AOQQsLrE7/3Ns1IPilkadsLEc2//ceKBfYKGi0echU+nMfgVm519sVZTOeW
 Kn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759906123; x=1760510923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqAqFGr+ulSrtJouz6Xn5Oa4i6EGYoP5rKMr4dMr6wI=;
 b=g0YA/p/Mg7tqNSHSyG34jXYTBxPd9/jdpYeNevtwYYI43XT2mJZkasNhrTuIPZYn5u
 ESclUyWQ7kVHiWFjy4m/PxUwkBaMx8FXjWzmMpoe3bZTIGR0Prp4l+sHW9sVvQ8HzypX
 Q8ERijPBrgS3nytaVdjsS0sII22+GCSAl+vx2JIAmK6M0E6LWC0i80q4Rq4qT7BJXvxJ
 Sv4xdkhPNNiLCa1ZT0D6AhGjJSxQUXir67Af5LiiwZDlYmE6HeLoHlbIU1QqzlgXr0ig
 Z+LWMtiNHBeQtnZNj7LaSPrgmFhdMAW8cHi+BhZtOC83dydkGGuw30m5WlJKNNUHSaS5
 KibA==
X-Gm-Message-State: AOJu0YyQc3jGKGS2IIifejqo/24B6uM2pW/xK+0fHDieLNvEEYK57EUM
 y55o4PCXEKED2K+jwq2XEXx0Sq7PnAwwkh+UexLGqxndNVTBcMQIVi92n65uS2Y8spnxCizpdUe
 AEkSDyS0baA==
X-Gm-Gg: ASbGnctDB9y/672lFBNY1AYHp6lodWbnSrTU4eADC5SLdvixuMjH74bYdQC8oaW+rZf
 4sk2w/xRhZWqHGjtSiDNURXFiuijLdnTHjAAJDQcE2Qxj+a6KH47ic2+6a7IBnEmYDryl29datj
 tg5Lmo3B9QOF4nXlqP3QPOzoTV0iXrdCSZx9YbS95Cl/GNoADT8eIMOgZmNcOY7VKgRkt+gocRl
 3+fOLRriyTkTI/QyqftGnZums6MTA+TXjOu+kXsMzgeYYoLXDO9z4Bafn6GdlA54y7Fv1ogWPyM
 enGpe0URguOep/ybOCSvvU1En+57b4EWdiqRHpb7iZ5FL7K7W5cATlTl/mG1ZXa6e5tG8CR89xG
 XIBOT620TIMRY/7X7s8LMMAueE9tuFUl2tsiG6CpNvxa51+04t2NydCFdxArqg6mafzSCOF9Qlx
 OpFBzp8+gjvVD17STQJ0M6rZa9
X-Google-Smtp-Source: AGHT+IFvU/Uh7lTNLODvwphfZc6f5VOVjWWFN88JwKuOFiFUiYu+41pvpSl87z9Aw+s7n93DJNRpUA==
X-Received: by 2002:a05:600c:4753:b0:46e:1d8d:cfb6 with SMTP id
 5b1f17b1804b1-46fa9af0621mr12399585e9.19.1759906123309; 
 Tue, 07 Oct 2025 23:48:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9bf8295sm23617475e9.3.2025.10.07.23.48.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:48:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] target/sh4: Remove target_ulong use in gen_goto_tb()
Date: Wed,  8 Oct 2025 08:48:13 +0200
Message-ID: <20251008064814.90520-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008064814.90520-1-philmd@linaro.org>
References: <20251008064814.90520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 70fd13aa3f5..038c8e37063 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -223,7 +223,7 @@ static inline bool use_exit_tb(DisasContext *ctx)
     return (ctx->tbflags & TB_FLAG_GUSA_EXCLUSIVE) != 0;
 }
 
-static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
+static bool use_goto_tb(DisasContext *ctx, vaddr dest)
 {
     if (use_exit_tb(ctx)) {
         return false;
@@ -231,7 +231,7 @@ static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
     return translator_use_goto_tb(&ctx->base, dest);
 }
 
-static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
+static void gen_goto_tb(DisasContext *ctx, int n, vaddr dest)
 {
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
@@ -267,7 +267,7 @@ static void gen_jump(DisasContext * ctx)
 }
 
 /* Immediate conditional jump (bt or bf) */
-static void gen_conditional_jump(DisasContext *ctx, target_ulong dest,
+static void gen_conditional_jump(DisasContext *ctx, vaddr dest,
                                  bool jump_if_true)
 {
     TCGLabel *l1 = gen_new_label();
-- 
2.51.0


