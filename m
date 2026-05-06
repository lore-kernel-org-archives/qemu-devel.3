Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1291AFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcsu-0004xr-Pr; Wed, 06 May 2026 10:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsS-0004Ok-MP
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsR-0001fd-49
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b150559bso44944585e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076324; x=1778681124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ub397WlAj5cZllR/Tmzri5mPQ8B8Ii7hkS/oyqyErps=;
 b=LKGau0UIMBb068uNt7HLFGEhN03QkfMEWWiu7dDEmtwlvcpnfGrRlAv27crK2OIUWg
 g6Bm7lSQEZLxPsSz/9fZneexbEXg3SxVAgmkI5jBlRzy/UoTa3WEGe7v5R/liGApkU1D
 0lbH+LrDYCEzLxIarGsY/f4/Fjv5WyABULWU1MAtbRO6NWwEyualfw3msPv6LszbyS9J
 q6K77ckER5KleBE3J/52Cov2VvKbazrujXNel7RS2/8qmxcSvsZD1NANqWbmRlGzfx1Z
 /Ab8HHeNDSmLFTP8GuQURcVUsJl1nhvXNA8dHki4mTxdQjQmuvNPMMTMoycLXkt6I9aX
 dhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076324; x=1778681124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ub397WlAj5cZllR/Tmzri5mPQ8B8Ii7hkS/oyqyErps=;
 b=rJ6UBpp1teISBicTeQqPpjC+ylZwHZ35d/V8jNZgNVLiO+4uI5SlkOvxuFcLNFNZMR
 JyXaacqDTOAkeVLK92bYO6ocRTZ4cIG1Do53K6KyaYpxiw48oyDqCfvuzagwo1LMu5c5
 EYMMmNlpKjr3BMOUqQHN3VQhLGI75MKC8NM6d/05XF/JONucN/KnmI3rNwxfDGuRQPDq
 fmeB0P0HAR362ZPKFDv3Y3MCN08uovg6CpqZwMn4SzwCTd6gxEHW5FbifxGSW6pEoVAw
 RMc/BXfAgducgcvhb6Ek24dCwdRhJ95MJRSUh+FcmXOv+6wz3zUlxyj3mx2IsdlaGisu
 9b/Q==
X-Gm-Message-State: AOJu0YxWg04tq5KqxDxzL9Nq79rjma6VclWHeaO+D8PL6Dm/ysJG+XXE
 xooHXG1cadgmdDa95i/1pVZRd/cP+mahv69oEHVuG2vG0Tcmwb0qUebge6CYByKm5SpulQU8Tpa
 +mwIt4ew=
X-Gm-Gg: AeBDieuxGyV6pW0gVjoskZF8VnSw9uQJsd1e5ErxSvm2kkCtAB+JjMJ3mtiwkjSwJKB
 SIrDrW8U/PaReyVjmIXNXa+g3M7pXXePawKhzggHDL2IPAhAQPlrQL92h7cxID/NfCk+YPIqeS1
 n/On2ViyracfKoGzbgXLkWAbWWd1JxsFufKmcCCVc7gmS0brw1mKVOYpfPdQATCm/SeTuafBYdN
 Hmev9FVn94lv7XEVn5ys+IMB8mIg8aqQmn2tGvnOO7dQ2yfFawDEoej5t5dtlGIrUvojnnhW1KW
 v58mB8yjOSug7rNa/NqTdkfSdy3xeqWJlcbmcD5Qytg46Zax/SRxNBBRfDD2cm48HVgTWmticr7
 PZvM3XIGlAvNQstaOnWp8LQe8H0Pu4DId8BBlhf0PTG2oHIxamuAk3ymln00I3ynRltBsUK146L
 GT7Q4mR7E5VrbXYrkxsaekkAdiDRiFMUOYW5hhmw/KOvzeRtGPgyCo+ot2aEjHuSNcLG8/sLmJl
 2P/BINkKJM=
X-Received: by 2002:a05:600c:3e8d:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-48e51f40b12mr67329625e9.22.1778076324303; 
 Wed, 06 May 2026 07:05:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538aca14sm46641165e9.7.2026.05.06.07.05.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:05:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 076/110] target/mips: Remove last MO_TE use
Date: Wed,  6 May 2026 15:54:48 +0200
Message-ID: <20260506135524.20617-77-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Unfortunately commit 54821ff6e90 ("target/mips: Convert mips16e
decr_and_load/store() macros to functions") got rebased on top
of commit 2803e24694c ("target/mips: Replace MO_TE by mo_endian")
and we missed the replacement. Fix that.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260417042620.35329-5-philmd@linaro.org>
---
 target/mips/tcg/mips16e_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index beb5b04ea29..e83587971d4 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -293,7 +293,7 @@ static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
 
     tcg_gen_movi_tl(t2, -4);
     gen_op_addr_add(ctx, t0, t0, t2);
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                        ctx->default_tcg_memop_mask);
     gen_store_gpr(t1, regidx);
 }
-- 
2.53.0


