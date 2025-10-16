Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4545ACCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mwr-0003BF-2M; Thu, 16 Oct 2025 08:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mwl-0002oc-FM
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwZ-0008Tq-PZ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:07 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-426edfffc66so429217f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617129; x=1761221929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WsyYPdM1vn0MfvsZNIemI3w4MzRBEEtjEM5zTGb2pOw=;
 b=kpfvIAtEO9bbGMLh/jUoLiZ+TCe6vXxLS7QH++PXIUWdjM6mzH/81GUwl7AmbwzQIy
 Z1m3S0HabGbEQvHRznLaXqC2smDJeOYeSWE14Ne2WIm77qbzXnVsLovtt8fPEGbJ6uHL
 3jsb+VsyC0WcckzY1JY22VeIeK55EOIg40OUQzaCCdNAlac6tjpPNEAfJgNfsrKs64Dg
 BHPOtSpjjAy9dyN0E2dvJelDlZZN6VCcRPDKmsZgYjqjNFtF3Eg339Et128UD4XJfe4u
 x7vNM1qRbZo2OPaZv1vYGqWDMabO9t+QPoBFs3cnJ10+z39meUTKiHHJJSu8JgluqxAv
 AXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617129; x=1761221929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WsyYPdM1vn0MfvsZNIemI3w4MzRBEEtjEM5zTGb2pOw=;
 b=da0f4YxET0Ll6VvlHbxFeCPmaM/GlxZYR9h3IjzFeSqMvIKRkF7qTznyRXatjHPXzS
 dDc8ZLgt36RaLvouyf23TMq6ZGaCMTU1LSefYGvh0YjYPWEty4jkQfGlmsIArOcyvWLV
 fhlXM0OfPwyvuFeZMabohhI3VFJBw3Nz8A1PxvTIcRybGrElWbo6Lq7jeASOEknTRMHD
 je3Y4RuTX0Ed6S/VSCVkmbwaw4yg2os1jv97uTF1nOwdSAAIDZblTYya/K59OoFG7foj
 dWlaTA7CYdZlqlctWnPFfnbm0Hn7zKOUmA67uzFk6VIiZ6Ly3ODQ+Hvo4W7ejYz1ei0X
 sl0w==
X-Gm-Message-State: AOJu0YxIAIGncFV3Yqm+3dRSY8sZiqj5VKuu5zISgit30HYEel6F/ULp
 8NjB6QK5uTIkUKdlm8MEroNaI+EpoLyk5TC7RIppy6tawHGQrxforh/5cpEodh6uDJwYecsoGjQ
 k4TjFbtI=
X-Gm-Gg: ASbGncswzYEgE2xPfBCT5cOTwSvWhXFw5oQY4a3O3vwjxeZ2TWQqe3GQr1d5JXdD0Hm
 FyNj1H548CHnERl39lhoPbNBR0QC8NrJRekbGfoL6ksrbI2lYKgPIYLOcHE/yOJPqijWaDjRY9Q
 +5hL/8reuij1b1KxRqtkXqYmOB1RebUzE/OE6s4ru9X1h5djhLMXTyKEvD/jyZjNmMPtm+XeqTs
 OLsn4Ad97K1ZAgA8MwzF0KayS8XwQaLZ6c90+EUk0xztTWT3sTVS9T9TWIXm1bSr59WA1vZEcdG
 lndxl0i+S0KuKd3nSd7rLGtItC2i6J074FTC/zJXo52Q4HaZb61af2e7y8CBeq6TtMsnbCfVTS4
 DUqYPNZDiKDqpPaITlBJl2i+K3U9Fo7xRm9W7MQ40/BVwnyNo2mx/EpemXTuLTt+Wb+SSC9w8nZ
 1Icb6pye/Td2dh1g16iFPJqlmDq/xNiPepop1GpEOLkaNtlK0VHRSWAMAZtCVTQbm4EwEdS/nzt
 qY=
X-Google-Smtp-Source: AGHT+IFvmWB/Z6FVHIy8oDswnCEI6xPqotxW6dj6DcVNCwdFWsN30OlgXyvHTMO3r7pJsSnWq27/ew==
X-Received: by 2002:a05:6000:178c:b0:425:57dd:58ca with SMTP id
 ffacd0b85a97d-426fb6a92f2mr2578157f8f.8.1760617129346; 
 Thu, 16 Oct 2025 05:18:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583664sm34783353f8f.22.2025.10.16.05.18.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/75] target/rx: Replace target_ulong -> vaddr for translator
 API uses
Date: Thu, 16 Oct 2025 14:14:58 +0200
Message-ID: <20251016121532.14042-43-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since commit b1c09220b4c ("accel/tcg: Replace target_ulong with
vaddr in translator_*()") the API takes vaddr argument, not
target_ulong. Update the 2 callers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009151607.26278-2-philmd@linaro.org>
---
 target/rx/translate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 5fc589c706b..1c911cd9a67 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -85,7 +85,7 @@ static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
 
 static uint32_t li(DisasContext *ctx, int sz)
 {
-    target_ulong addr;
+    vaddr addr;
     uint32_t tmp;
     CPURXState *env = ctx->env;
     addr = ctx->base.pc_next;
@@ -147,8 +147,7 @@ void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx,
-                        target_ulong dest)
+static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
 {
     if (translator_use_goto_tb(&dc->base, dest)) {
         tcg_gen_goto_tb(tb_slot_idx);
-- 
2.51.0


