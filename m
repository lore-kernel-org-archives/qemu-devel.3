Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD8FCCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC55c-0006EH-OG; Thu, 23 Oct 2025 19:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC553-0005Db-RC
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:58 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC551-0007Vc-98
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-29488933a91so5168885ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263448; x=1761868248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEQEOMtu60rG98D2pD2eQ/ov/DkPTh4vzA3I2V26s10=;
 b=SbPOkoyph26fbvKgPigOPe6hsWVlY+00yqFRALEW01DF9SwijxeFNW/DP9d613zDWg
 xszZalR+9jq43MQ0QJVsrUR0giL69FpyaiTH2ZT7jjDpLje7ZATNKy9t/6uEqSUQLIaP
 2b1hZ48Q8pvHZs6Lu2+a8A1/kzkaBlg/lm59SMteZ/wFRwnqsfPcgVXU829He/Q3JkRf
 9/JR4v9HKid+yPxw/eNw5BbnePuWrjgKJ6dmUpzHDCzMac3dSa2UOiALPkEKq88WXm6p
 6tg7UrSmQXx2gc8qpHT+t4c7UuElnXzFCYKzMb95WDiEgOnkCaIKesLSOcqlg9iDCdU2
 QfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263448; x=1761868248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEQEOMtu60rG98D2pD2eQ/ov/DkPTh4vzA3I2V26s10=;
 b=pVViFA2vhpf9TY/oiDEr7zp1Hm8GqKvzKle3BEgF+JOyHEHJFNtn7WH/fGbXL6A1DF
 K5xJ0u5WbLBl9SbwJX1F43nHFugChfhEm6OUuoq5u3po9jRcac2UfAcHQAwAk3dKRchH
 9LbLfLC7ZYCadnrVwx+SpcO2OTnPYzcevKGYBvqbQWRopya5p6qz1KP5zdvzsK+qjZMw
 xVE/AFl/QPGxMwc1c/0P80jtyaPvG7wsyu7/rZs5RDme25YwaI8Ea7ILCxNULvS7dvYO
 USh2ui9sGcQ0xkWCzP0UVk0JTZNreDaJN+SVmf72LuZB1B5utlJAdk2Lroxee6MiM/Bb
 ccUQ==
X-Gm-Message-State: AOJu0YywOVaIXWCUa2WGnxpWxiyJEXvqt8QU4u6pCB2c0sYSeu8xEG8r
 65hygBoAn7hHsq+k9OWfP7697DKt5yqi0LXDqSzJb+v1R5+npFYbK1FGBubmLA==
X-Gm-Gg: ASbGnct3oQ4RsyqLtYLVbrO83MgCiwwdFIC4Yr7zgPNFRTgnC8I6+Wp1Q0Tu1MLcrCb
 v+WkWIaORp2f/xD/XlSX/AcZKVci7Oo9PNhz8Lux+SCwq3QppQjra0P26j+Yw8DCeWlCoWGHOgU
 wLpWr1fPsCliupOyqxdNOPByjt4RQ/Q7g4DKeHqYAywgsIt/K1D8WibU0qRFx3pxustRrPWNnuM
 lNKBlHAz9QKtp7W7u2LSJ6vPIpy5qtCsffr4MMIvp+0rAT4kJtd1YfkAF2i7BJK2swW49sYkGT8
 DN7zYdiDp9QqSR4eWXYSVArXDrEd1RyLGuI8sixOfsM/Lme2Pc6wrvf4XX8yDH+NlSovYowT31p
 xShgFUnDWJ2oeh1xHdAwa5cSLLrc4VwqcuUJzJ2IdYsB/v9C86Tk5B+UimT2p+YbD5YKzqUox17
 OsC1is1R28FR6ihOeUA7atRs6prKMn2Ecg09sGPJyDsqbYXe9Hab9WYVVACGAW53P8iNlGv/gOq
 w7jgfGm6orWDSp4dK8=
X-Google-Smtp-Source: AGHT+IFK/HyRphrwnhnVHoXZglr/25Q+W9XHcd3CDJcq8Ujln/CFynyAFkrgbHaZWk3u4L79qj1ZCQ==
X-Received: by 2002:a17:903:240d:b0:290:ac36:2ecd with SMTP id
 d9443c01a7336-290c9ca66famr332463385ad.14.1761263448472; 
 Thu, 23 Oct 2025 16:50:48 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 21/25] target/riscv/riscv-qmp-cmds.c: coverity-related fixes
Date: Fri, 24 Oct 2025 09:49:23 +1000
Message-ID: <20251023234927.1864284-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Coverity CID 1641401 reports that, in reg_is_ulong_integer(), we're
dereferencing a NULL pointer in "reg1" when using it in strcasecmp()
call. A similar case is reported with CID 1641393.

In theory that will never happen - it's guaranteed that both "reg1" and
"reg2" is non-NULL because we're retrieving them in compile-time from
static arrays. Coverity doesn't know that though.

To make Coverity happier and add a bit more clarity in the code,
g_assert() each token to make it clear that those 2 values aren't
supposed to be NULL ever. Do that in both reg_is_ulong_integer() and
reg_is_u64_fpu().

We're also taking the opportunity to implement suggestions made by Peter
in [1] in both functions:

- use g_strsplit() instead of strtok();
- use g_ascii_strcasecmp() instead of strcasecmp().

[1] https://lore.kernel.org/qemu-devel/CAFEAcA_y4bwd9GANbXnpTy2mv80Vg_jp+A-VkQS5V6f0+BFRAA@mail.gmail.com/

Coverity: CID 1641393, 1641401
Fixes: e06d209aa6 ("target/riscv: implement MonitorDef HMP API")
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251022125643.588947-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/riscv-qmp-cmds.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index c499f9b9a7..d5e9bec0f8 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -273,12 +273,13 @@ static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
     }
 
     for (int i = 0; i < 32; i++) {
-        g_autofree char *reg_name = g_strdup(reg_names[i]);
-        char *reg1 = strtok(reg_name, "/");
-        char *reg2 = strtok(NULL, "/");
+        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
 
-        if (strcasecmp(reg1, name) == 0 ||
-            (reg2 && strcasecmp(reg2, name) == 0)) {
+        g_assert(reg_name[0]);
+        g_assert(reg_name[1]);
+
+        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
+            g_ascii_strcasecmp(reg_name[1], name) == 0) {
             *val = vals[i];
             return true;
         }
@@ -294,12 +295,13 @@ static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
     }
 
     for (int i = 0; i < 32; i++) {
-        g_autofree char *reg_name = g_strdup(riscv_fpr_regnames[i]);
-        char *reg1 = strtok(reg_name, "/");
-        char *reg2 = strtok(NULL, "/");
+        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
+
+        g_assert(reg_name[0]);
+        g_assert(reg_name[1]);
 
-        if (strcasecmp(reg1, name) == 0 ||
-            (reg2 && strcasecmp(reg2, name) == 0)) {
+        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
+            g_ascii_strcasecmp(reg_name[1], name) == 0) {
             *val = env->fpr[i];
             return true;
         }
-- 
2.51.0


