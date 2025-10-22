Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44DACCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWf6-0005ba-8Y; Wed, 22 Oct 2025 07:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBWf3-0005av-Lm
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:05:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBWez-0006dY-U8
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:05:44 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so68617735ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761131139; x=1761735939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FUOfyFuvAmLFwE8+R36LTL7/r9hMJZoegojkEohliwU=;
 b=aJkyRifhrBCSoHAZNB6jES6HNGbAuDmGbisemd+xZugZns2yRuqT0JgeZ3COv6fMr4
 r+uui4pmtQlEbiZA/kM6/HQqEgQ89GrWUh7Ng7VPNSv6biAdXev8vsJzEKt7j1oFLbNT
 jNzxBfyLZcQAHp6u3MWp83oFVxrB4pVSfACGr7QTYRDA6+S3OeSF70hdRI0xOOuO/05R
 151ji58Ies8p579/FiZ+67nTcugJV1yoU3NgD76myg3F5aG9F48Ve7X5ajFcwSj3k+zJ
 BkcwuwcSN6Bi6B5M/f6Mbh+MGSecyOktxZrf6FQ47X2LhaJYBOJXJdzLGBQwijfGMgi+
 UeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761131139; x=1761735939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FUOfyFuvAmLFwE8+R36LTL7/r9hMJZoegojkEohliwU=;
 b=cfcyofsPqRZOFRgdFUK6O2e8O6KqoYAus8r4t/YBZngzaKQ6RqLY6mPXlcum7S2yEU
 7Gj9knuf6dufnWBMvcyOc0XgV2VnfmhUmfGqi6nTHjlAQBkLKSzj7izv/XweYK/TsjM1
 5J9wlzZ4+JARJDllYPKNmjKU3I4sDspf4TfN546HRQTZ8agfVTsdtETYlFxQPYs4uy6I
 3QYAMXK8OhxrSfoE8O5IJpdZL7n4UwnE2vSSfYiTOWecneuBJPJaF4ZRD0ExvLvtXOGR
 QtXT1hrZ+4zOO9G+d0xPv9W6ERkvrbHLriKCLqrPp5oFPYy33j5lzpiYsf9WbybUhAAM
 Jzgw==
X-Gm-Message-State: AOJu0Yyib2O8YrxirWzeEIavzTbXfKJTuW5argK2RpSuvkaMiawiObCh
 0DpH3yLcVVdkARPPs47B+NrNLrRY6w8Btwl2hQsckS2sFpEGexUHpW++V0J5tnG1wAKdl0RddQ0
 PNBiEJfI=
X-Gm-Gg: ASbGncu/xz8HLV1yI+WLD3aviHvp4b4f3B95T9mQjnwFqwm7Un3KtjAKuKRiFKYeciV
 PRRxDXmSlfhzZsOJrqezWnAxxButQ0PLZHdNPhPQ3vOxeCVXBTvK9EiDNc0GjQ5xVElqmIOW0gB
 Vekb+sXG8Yw37KIFzUFwNYJVbMU4ctVqpf9ZhNs5KHMOgM4svEn+As2hvdCefgtBo9kSWftCJ2I
 LMYNV0CEfJLrzsMtokxvRp5X5rWtFP5CC2Yz2/DsR9sfKZBw0E77jwMAXzf3M/hNeLWgCMYxarf
 QmLv4Kfxo7rbSsCZPgl7E8lOeGqtg7iexu1MfIrxSbByboznOd1j+rhEkuZVswuy0Sop3/o7BZd
 xcbMfzdasGjAf/wIWz5Jpz+ngQ32xladhPWF0nYFs8EZEdyLjHBPHSbKG03goIq5W4iaEimtraB
 7I3Ymro7LXBGjgbLIxv7LckON/pTSphBqxB02McKKhmH26HJcC+A==
X-Google-Smtp-Source: AGHT+IENB2ljRQaNH8NbAiDcnjF9tBRKeEUswLVM0gEf8GUbCVe18uSwQ6EuoeYwduOieQIjfBosSg==
X-Received: by 2002:a17:903:244f:b0:261:e1c0:1c44 with SMTP id
 d9443c01a7336-290cc2f83a5mr268514345ad.40.1761131138952; 
 Wed, 22 Oct 2025 04:05:38 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc1:92d3:4170:1cad:ed8e:78ba])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2930340092dsm16897975ad.42.2025.10.22.04.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:05:38 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] target/riscv/riscv-qmp-cmds.c: coverity-related fixes
Date: Wed, 22 Oct 2025 08:05:24 -0300
Message-ID: <20251022110524.483588-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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
---
 target/riscv/riscv-qmp-cmds.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index c499f9b9a7..7bde7090ab 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -273,12 +273,13 @@ static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
     }
 
     for (int i = 0; i < 32; i++) {
-        g_autofree char *reg_name = g_strdup(reg_names[i]);
-        char *reg1 = strtok(reg_name, "/");
-        char *reg2 = strtok(NULL, "/");
+        g_autofree char **reg_name = g_strsplit(reg_names[i], "/", 2);
 
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
+        g_autofree char **reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
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


