Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5426CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mxs-0004Vq-EH; Thu, 16 Oct 2025 08:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MxX-0004CS-RC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MxP-00007c-Gm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso5597995e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617181; x=1761221981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tFemSrV+yXNTrcdNlowTIb2z00rqADa2FjVBPDuDWzE=;
 b=DcTm+FOD2k2UofjKKwFqRtFTXbBzemW60czEpXiHxjw/gGbaqovL408gHo2GhdjdDX
 5JQrPlDkfcwZ0xh6xXMj8fJWTsBVZkWXzFOnYKBL0M3yRrbPHgQMQQHgNmPXH343Z+Iu
 QXhvfNrPFrbgQjsTXn82xt4I26SVBfjZLV6l1nW199ClxnDyro5x3pz2LA9iZa2e8DTm
 pPcsLrbGf5G8lsoTvh4lMYwLXJtPJw2AHFEiCU2Enuee7TER4oLiIcoxiCY8MGtSKGTe
 tEm4EOtkTAUquDLTYDypLZMBWNeC/QBDehpeXTYN1K//8/cntM83tNdVQsgtNGoQLNNK
 /TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617181; x=1761221981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFemSrV+yXNTrcdNlowTIb2z00rqADa2FjVBPDuDWzE=;
 b=L63J8AJ9RgpU6QslIV2si1pnkBdGXiASXu5hixlRQplXy0jtHRCkrjfz/yZt6jtGhH
 aH6l49bXgyohs663JO1wtn6chVmcnjZr8Mx9itUBJbSPfvk0LPmravefaulTxAT5Rhql
 cHEZr7xobpZgj7x9dsf1BPi0nVh5e+PP+MJErk6W6kK0h9NNffPNGFCh9USIySBOiu1v
 aiuKStI4xJsHlhWgvboecIJhkjOBRjrXmJgdWSzZeHcvuNlLFnCnwA3usObZUxtlObsW
 fOXmmTB3Yg3+fSS/MRFiTJJ0sj8fCxaWAbbdnwwgMFUN3AVa7KWTPhKxN+uMCkYia7Kg
 JVeQ==
X-Gm-Message-State: AOJu0Yxq8DQWzeceAPDR5Y97qAOpwH045uwxJzrlhS/mvrBlKjWyxgxp
 UFctg4F2mDIljHoG5OjTDOpp4JeWPQxRTmQHJOa3KouD97pAL3btWExvo3kT+7c1SRTariIFSE0
 KcDd2+NA=
X-Gm-Gg: ASbGnctqJtnQciwkOa5dtA99wQTSvH+VYh80XeGeRiUzleDvJQKYOyE6DqHNxblID4R
 rjP/9gQR62ru2I0anVRQGAOxx+4zRl6sNcK1Y8PsSDHgk7u3RZMkB0tDGbP2X/ChQWFUBQYMJaf
 yQc1XCJJt2kL7YED85/IZPxrdFERr8i7mH3xhzKyEfMp/84zjcj/xacg3wTKwzfnP3C0JRUxwnP
 CIbS70TkMBlKl6hpF3KJ4PCtKwsKaW4NtqAPsHwXACyfoMxCr+mqQbBL2XWOs8c15TTfPcIjzt5
 D4pGxNz7/a7RWVrO510lPgQWhXbX/6ewDlGQdjDmy0C18t4geDVDsL06FmLNi4wLE5yVO63NkUR
 NU+Nz5XGPl9U+VieA7Am4I2wjyZeH6byEBRocALKcHezeuinWNmwa4HKAC7cv4V58ArBG95IP9v
 K7+IXHMDYSyzcoOkxHCGG0DO5i3l73WIOhyE9jqkukPN1mKrJ5BozciA==
X-Google-Smtp-Source: AGHT+IFhSRBfRkbcS645BVjvJglyH0AgUcW68CzVW5vC7+nP5gRKETdnSUKyAc+5NHHFI7mjaSpusw==
X-Received: by 2002:a05:600c:450d:b0:470:bcc4:b0a0 with SMTP id
 5b1f17b1804b1-470bcc4b26amr88325985e9.34.1760617180825; 
 Thu, 16 Oct 2025 05:19:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ca243a3sm20282155e9.0.2025.10.16.05.19.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/75] target/sh4: Remove target_ulong use in
 cpu_sh4_is_cached()
Date: Thu, 16 Oct 2025 14:15:09 +0200
Message-ID: <20251016121532.14042-54-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Since commit 852d481faf7 ("SH: Improve movca.l/ocbi emulation")
helper_movcal() pass a uint32_t type to cpu_sh4_is_cached().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20251008064814.90520-3-philmd@linaro.org>
---
 target/sh4/cpu.h    | 2 +-
 target/sh4/helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index db27a693f12..b0759010c47 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -277,7 +277,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, hwaddr addr,
                                     uint32_t mem_value);
 #endif
 
-int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr);
+int cpu_sh4_is_cached(CPUSH4State *env, uint32_t addr);
 
 void cpu_load_tlb(CPUSH4State * env);
 
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 1744ef0e6d8..4f1e2072296 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -47,7 +47,7 @@
 
 #if defined(CONFIG_USER_ONLY)
 
-int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
+int cpu_sh4_is_cached(CPUSH4State *env, uint32_t addr)
 {
     /* For user mode, only U0 area is cacheable. */
     return !(addr & 0x80000000);
@@ -735,7 +735,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, hwaddr addr,
     }
 }
 
-int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
+int cpu_sh4_is_cached(CPUSH4State *env, uint32_t addr)
 {
     int n;
     int use_asid = !(env->mmucr & MMUCR_SV) || !(env->sr & (1u << SR_MD));
-- 
2.51.0


