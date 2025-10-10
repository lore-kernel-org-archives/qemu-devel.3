Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C4CCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqE-000773-Vk; Fri, 10 Oct 2025 09:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpy-0006s3-0x
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:10 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpG-0003y0-3p
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:09 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1526678f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101581; x=1760706381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZI+JmucMI1hO6swS0D2hueIshzmi+ImbluGskO1/wG0=;
 b=oWQXjfJb6f9qDdU+COcVbWKUVaJ/PjUrpCTx8sQvRlnxTbpWV873dQdbAzMgv1X1VQ
 PlkilNqDR4TWz18uChmY8SvNJypqs2VdldK8gEWplywo9tpwGX/ZCWccW2+oihsHE61M
 Hw3fZtga9glfmqRsnGFAx800VERynokD64PIBNPtVCq7lmd02ptXY30uXl8z6Fr1zYKg
 rl82JFVFgBqc/a+V/b/+eYAvdHbUTNnY7H/sE9cf/QqP7CBsSCIFIsdB/uw+DETNbzCN
 DF+R1iblBAVy2hOoaUlAdPGlclnlo5zmh1KYrzYN9Soht2EOqrgqeaNJSVZnev/ajkyT
 7HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101581; x=1760706381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZI+JmucMI1hO6swS0D2hueIshzmi+ImbluGskO1/wG0=;
 b=o2Dxq8aSOeLpd+P64sYSOsk4/pnfPqZ9vBgAahtx4C44zMPos3nphe646e1sWH8qf+
 eKj4wVaUzOwlhJNXoalZX3wQF+HiG6cOJK9kLTTg499UccoGOrbnStoksU3OldvrjOo9
 ZO5ripny7YJquF01UPcoZpUj3wbVd6mi+EZoDNrR8l2T2gVrNhTPYKWB+E2aZK1TYFNB
 t3Id4NaP5vuIMZglsi50GjlQ/ls8QkeMblVCAhNtxsiyS4PInzk8UNDXRkPpOw/VJAEw
 eQQcGBzQ6xZDyebKYcABqfOQ9iqtmss1LhRXq3UOCiVGX2KVj3nS0MqthmmE4yvGeb4N
 E+rA==
X-Gm-Message-State: AOJu0YwSjfdgLV9fDoetF/dyEnenIjlFXBKss1WTDPoOLU/eJZ/SyxXb
 Q+8VJYkXCfRYhtbwNb6ile1UfDrwK4UMXcuTk9Qx7pN2SPSyBPBoZiCxLFVubchOt3TGNpxFxQR
 dkaAx
X-Gm-Gg: ASbGncsDIYl8ZkSvL10H2FeZ9n1YBx+qefv9VgxpRCwtEvJbOBPgKmg/d3S+uF2AuOV
 V6vx4mqq1uEomUkbCYYUFkbiXEWubO1U2EpeFwdUqF6CmcY3l3Tqa8HjQ3rDVj4FNweGD3X4u24
 j+YB3LQzuQa7GFCKRc1liPQp0h6SI/P8lkaNKn4L3VW0Q294QwA554I2ruEzSYT1fm8o+XzKJ3Q
 +FuPID8ssjBPvhbiExt26Amqi2IO4Mao9+ApkSMRFOjcliPXdPrQTp6xug3Gdxjk6btJWrmBwJF
 kwnCBY6YiYrMv4iIbbXAnNjmZdPyyiJtXfZQE6pWxWvWOo2ccYmiGZWrINAwVJ5YlWeLL0wUEID
 +iDXKTnhOzPnP6ihSaEa9ypV/gfT/+21Me5M/CGyuQGTWmGnEFNM=
X-Google-Smtp-Source: AGHT+IGQjOaA+6uiJ98/uuRVu3DHauKy5imHHOAtwn0og2gBKACQXdNSv21WU5IWrzjX2zeP18N7fw==
X-Received: by 2002:a05:6000:3101:b0:3e9:b208:f2f1 with SMTP id
 ffacd0b85a97d-4266e7d025amr7642649f8f.29.1760101581072; 
 Fri, 10 Oct 2025 06:06:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/76] target/arm: Emit v7m LTPSIZE exception out of line
Date: Fri, 10 Oct 2025 14:04:56 +0100
Message-ID: <20251010130527.3921602-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-46-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 57bc8ea4c54..3df0bbcb7f8 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5598,11 +5598,10 @@ static bool trans_LE(DisasContext *s, arg_LE *a)
 
     if (!a->tp && dc_isar_feature(aa32_mve, s) && fpu_active) {
         /* Need to do a runtime check for LTPSIZE != 4 */
-        DisasLabel skipexc = gen_disas_label(s);
+        TCGLabel *fail = delay_exception(s, EXCP_INVSTATE, syn_uncategorized());
+
         tmp = load_cpu_field(v7m.ltpsize);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 4, skipexc.label);
-        gen_exception_insn(s, 0, EXCP_INVSTATE, syn_uncategorized());
-        set_disas_label(s, skipexc);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 4, fail);
     }
 
     if (a->f) {
-- 
2.43.0


