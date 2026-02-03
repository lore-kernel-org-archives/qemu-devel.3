Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D825E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHyD-0000zB-CI; Tue, 03 Feb 2026 10:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxs-0000nR-C9
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:17 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxq-0001am-Si
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-480142406b3so42773065e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131113; x=1770735913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dUDGMevwxhmocOvRkyNjiWD7VSBUKTSpnU8hxAPu28Y=;
 b=IeyK8X09IOIEu5gw5HoiMhnVa2B/EEU/wHp4GhsOj5zUVym7HS5vpjmuat5AW1fzZF
 SHc2wM+OUBco3qLDOI9HtOyOE94vFpmmNYJFCNpQhUlrVMBtAws8gypKJlm1EzkIzvbk
 MtKZBkDD2mjsCmNSpUbSOpoqLwgjSGXNnrFr5HCEatc19RqN1iraXvIGPhQs1RbPpDGY
 9VghEK4b+XgYNxZpZhmdqicJz0cGC/5UonRhhdh9+sZIoitPn2beOqkarunm1xRcry5F
 MJXpbbA0kuFUNRfQjiECV6GmhhOuUosQht/1IVmYnbhktq8cFaDLNF8eUQf35N6WF/Sv
 PvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131113; x=1770735913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dUDGMevwxhmocOvRkyNjiWD7VSBUKTSpnU8hxAPu28Y=;
 b=DUwWaUdnfXokBbc938w9rvovChRPDCAvihxy4e1dblQpiIzozC9MdRh4SNDCPP4y6d
 z+D9FuXwAJ7iX9amv336p6LIgDR8JM8Y/6k2dEQHSjILaeAOtzmnz/3yLWWB8yzNezWQ
 1tYx+/PvXQ/+Ljcy+v+hfnBvho2LBtQ0GargQHj8jQwgyMB59Q+vqRshur3HaBxvJdA+
 u6F8GdSsFTaTNVia4GFxJvbSEnSfqFwxlkziIincB5nxjZ3vHvRs/pPEP8o/j0j81TYa
 X808wsSSn1uftncR8rYlLmrAwKWg8wbYmZCsmqi8kZ5lXRR4aEhEgmqeAkIpDhj2SKUC
 48OA==
X-Gm-Message-State: AOJu0Yz8req73dzwTMs7tohr3BkxGJQyBcV6GqPunYksHNQYeDsAwyQx
 eFQi1QQ7NCnlIK+oVzTAhX4fzcvCPZlWW5lgW+zDTP2fEz6F+Pcm/Srk56glKeDhnTDhCT0Ol3K
 5NxjMZso=
X-Gm-Gg: AZuq6aKeRErrFHt1jy6WnJb2Kl2kM4yhb0sndYY/idRb2KbkNe/efYVBTK7UQ3ey9qX
 T3HrSN5C6+1XAwlkyc41vo0OKb7jiUlXgzxaWY7nZIuPSOGoVOM9jQWZWE20RH+vaJG0rIvL71f
 F5LcTxWIwtCSJcWnaAkbUFvpRkm1LEqFHto+PIJmxbkKHb9ZzLEymjijei90lP5StwiWJy01kNU
 SMuiRHHZFipB4s1ayFjq4repo/Bnj3BNalMgTZSpwFGdUckMo9CiAxkN9g4PPdT5QBArTjjy0/q
 eFKdPMoOV0tKRSU0q+flSNDRxi6w+fsA520RauqNILCKfeaVHXvvMqhDbm+EaqCGVJYyewG1AAc
 Fk+m8v+mACuDCVtJ6NVJYAcMCd63ou0JfPP/61VYIrN55n5UMESMhNZJ6ER0UzqbbGajqeFUdpN
 Egeo4Hz9AKneqVsHLdTcNYdI1vRDHmFQsIJTVoXyxOilCLyCrYUvjL/nLWJW4r
X-Received: by 2002:a05:600c:8115:b0:47e:e2b0:15b8 with SMTP id
 5b1f17b1804b1-482db447c40mr241427215e9.4.1770131112751; 
 Tue, 03 Feb 2026 07:05:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830513730esm71313835e9.14.2026.02.03.07.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:05:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/30] target/ppc: Expect page translation hash addresses to be
 aligned
Date: Tue,  3 Feb 2026 16:04:10 +0100
Message-ID: <20260203150436.71907-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The page translation hash addresses are aligned:
remove the misleading MO_UNALN flag.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260202210106.93257-5-philmd@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 6f5d82af636..a8c67364669 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -161,7 +161,7 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
-    MemOp op = MO_TE | MO_UQ | MO_UNALN;
+    MemOp op = MO_TE | MO_UQ;
     MemOpIdx oi = make_memop_idx(op, mmu_idx);
     uintptr_t retaddr = GETPC();
 
-- 
2.52.0


