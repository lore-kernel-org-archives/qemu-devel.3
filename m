Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6EACAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75Zr-0006cV-0s; Fri, 10 Oct 2025 01:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zm-0006c3-V5
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:21:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zf-0000MW-UY
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:21:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso9136845e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760073707; x=1760678507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbKb7a9+FDFFb7O3f6kDuhi6M8QfBjUl/fWMF4m1FM4=;
 b=L2Rm7v2/laOPB1YrHMkyc+hXjCcWOG09NzRaZhlTsS4OMbX4vqfK+skKZcgRflidWO
 nuaEb8quko0exIevZy93nctnN9sxREQhT48H9Y+fRnz3uKDoml2kWHQHA64q5JwWbwtC
 rTk0FqA9B3KEd3HLax28v7MEU/wobF3JOtqudIgh2tE1iF9Jvdjy5KdReK9Igisd9C6R
 vqwRHNpCNJ/kBnN1Ut8QV4AQnDLKLl2euriWkoLwUbgOFtw3Td9V5eTvclCSbgf8E3s+
 QFBvlDgkO9DqsNOrHIr7RgngVuiFII+RU27tOhSH16tYNrSkB7sFrWZDiUog0vnXTcvY
 UC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760073707; x=1760678507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbKb7a9+FDFFb7O3f6kDuhi6M8QfBjUl/fWMF4m1FM4=;
 b=VGYmEF/jVDuTQ+NG+UlJR3w6I1gqsLOLd4p3KiS1PZCMl5syGaw6N7DLEbYRa23qNh
 /5snU1tMQLzPWHFf7jq6cd5D5KRkaZMuNZ3JQ9g4ah077ca6ynk6OucEX+DkZuKBJV6/
 G11fgwwIpC8hk98L6rqKCx2W6KGz3AEbP8/HYWWfuE7awvTJ9OLedV02qdqMEJahLXDX
 v590S/CZXyURUGjBbXna8cwpwFkhwNNgqpEpdkRAo8c5jlgzWPz8gkQQoyw/aVR56UIL
 Rb1Bd+nWGAH7ADYsTtNf0XCNG2EwINibrKNzsr/jeUGJ6UywHeFAoDeV+/e/GHpIBurp
 cOvg==
X-Gm-Message-State: AOJu0YydVwb8XPdjX5sXszY80HW6Sim0Du5F6+B+ruDNReXMBAFhcCCA
 dO/XyATzo2GpSmy+olmlqlYXLLrIh5xNKGA9JNMXfTVrhUspjiOe85YQU2T0r0TvVWTTM2jtl44
 qnoyxJjd3vg==
X-Gm-Gg: ASbGnctVQMlM4nR+eUb8Z5sf98Elvy7CdIJWvzakDNx9hp1pAgHSKqOGEFYY1CPousJ
 RiShCG6A8bVpupgflBkWA+GGTzAjkc9ZOJeGQVoFECi1aBJgHSKLLGTXi6bi1yxXzK1syugygaM
 SCvbFpZrrtz6+v8mpkNnoHc+6No/lQtSAPeI0pWePeUJwVh1elo58RvSQkfy/IlqOY3D6HPx949
 nCmX9pX5syLROBEShKET4U+QLUrsVL712V3QycKBoHtKsaS/DFZnImjriilqnSiDuIW8vM+dCyO
 2wqS+xtB3sMA57dlM8jk8AzNHFvk6B0B1yrVio0ambveWVoMpTRIdRI8BpjM4Vf8r/t94HZepOg
 Vlg7/GDyPGHAlb0WYfMyFsbymVkL51Yk/j79JDodpW6TNlTnPDgFVNob64uHovIPsT0D01yemWK
 qudzNJt7xYUP7IUIvGpqMikVS0
X-Google-Smtp-Source: AGHT+IH0hoIb/YrY1gVVdRw8MTLHT7IgX5R9HEIh9VRR6rjN3Z50ve7lnapwafw6/4GV/aeHh8rCqA==
X-Received: by 2002:a05:600c:46c7:b0:46e:36f2:2a62 with SMTP id
 5b1f17b1804b1-46fa9b08c22mr66061605e9.27.1760073707248; 
 Thu, 09 Oct 2025 22:21:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb497aea6sm27921015e9.4.2025.10.09.22.21.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 22:21:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/12] target/tricore: Remove target_ulong use in gen_goto_tb()
Date: Fri, 10 Oct 2025 07:21:29 +0200
Message-ID: <20251010052141.42460-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010052141.42460-1-philmd@linaro.org>
References: <20251010052141.42460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
 target/tricore/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 7c6e3095971..dd09f0651f5 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -72,7 +72,8 @@ static const char *regnames_d[] = {
 
 typedef struct DisasContext {
     DisasContextBase base;
-    target_ulong pc_succ_insn;
+
+    vaddr pc_succ_insn;
     uint32_t opcode;
     /* Routine used to access memory */
     int mem_idx;
@@ -2811,13 +2812,12 @@ static void gen_calc_usb_mulr_h(TCGv arg)
 
 /* helpers for generating program flow micro-ops */
 
-static inline void gen_save_pc(target_ulong pc)
+static inline void gen_save_pc(vaddr pc)
 {
     tcg_gen_movi_tl(cpu_PC, pc);
 }
 
-static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index,
-                        target_ulong dest)
+static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index, vaddr dest)
 {
     if (translator_use_goto_tb(&ctx->base, dest)) {
         tcg_gen_goto_tb(tb_slot_index);
-- 
2.51.0


