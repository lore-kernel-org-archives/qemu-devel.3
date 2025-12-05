Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44197D3398B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYXf-00049S-NI; Fri, 05 Dec 2025 11:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXc-00048K-Tr
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:21 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXb-0001ZD-Dc
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:20 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-88054872394so30694576d6.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764951618; x=1765556418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nI2B3s4qT59VpUOR5FSRRVjE02qzSIL1d1ObsWlt6A=;
 b=y8EyGcKFASJmGbttmqpv8PILSTKXbhFApK1eaLv/MFZMBPxtuDwbeTiz0VXt2mubo2
 omFzeO18C/DZgnwBAWydBgw6tuhD5RweMG2Zh4WqhApyYa/HEp9ToBBoWN4ZXNBGHSts
 IcCSGnwlY80ZcsUt/PfaKgLAe48ICv4WvhrRTQ1ZDCk2MVUf7CZ8mATwW1E9GIRV3sw9
 wuRXZslaJ2+HVsEfdqwrqs51CUfNxORIP9pkNlA0sJjZPhtWHP7t1DSxVOGUTHe6qHnr
 PMrVquMXIfzbCIWqfAFkCEB2x7yYhrSa9oym+kdr7IQngHDwpCMp/gqjKTxzrswfgW2T
 +DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764951618; x=1765556418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/nI2B3s4qT59VpUOR5FSRRVjE02qzSIL1d1ObsWlt6A=;
 b=KBWkWcaaKkJk2O+IZHMiB4Cm2P4DTK3H5IAZlvDP9MetrS9Ms42eFNwr9vOh2fIePJ
 WmnaK+kcum+vGLsOmumwbBuq9jQBMh1C1HeIKniUJalWdm/V+K5+tBIaneP+AjWv2R0W
 aoex48zorO+6z1K/UAmqb0ltw/lou2C4C9uUvhJTfsVThFamkDSGSbtoLmNhRxUE8Sb9
 2WLXO+Is7lt4PbCB9mI1TcC7RhR5IN5GW4P1FXjWBboY45TF1R7B8R7XcPhZmVbDv/fO
 azCyPG+r0v6teUXq2CljWxKJ00ZSKlo5m9M5o42GjVmm14IbpnopbVS/g9UtlN0AKsUn
 ADzQ==
X-Gm-Message-State: AOJu0YyPoTEjbu3NNFzqHRqWq7TZNuUISr/qiNMyU2bBo4vEGkTAaMbR
 F4FLMwUSpXqWhaQGpE6utrafNeAB/v7R77NWwir0LzPsco/kFqvIYDLUnUzoBCt9S8CJaFc2XOP
 hqAFepUQ=
X-Gm-Gg: ASbGnctndcXOJYzPtfRqNJyCv25rnANu1VAKK25BlZuSyoAln03yCUumpseZalps4OS
 gEy+uiudXO+FxLJaJc5yvdP2PmvIPzZHyPhO4u0pRwwge8NbZfksoyUbsoFhUGUhK2JJvd7ftS7
 wZc0K1B0Y8k+mwadWx64iYY19+moganoaBmKVLwkuLoI7RUrvXvx+QScwPGsiFG61mild0rYW8q
 qGhLUAK2NPZmJX174H68KADpzFFwMT7UJamhxHfuxBffr44Fw4KhwRQlJmYdQeBSomgoUsa/3sl
 XXlMwqZNl+h4xlY2bdT2+Uw8tJkup+CCG6phlx9rLQyt9gABHGgr0mRCo922/9keNKyBK2Ber0c
 LFbR332k/bOvmyrmZyNtrw4N/zFgafKmckwRn7FhD3ZNoyuIKV27jtrrV6m+nCl1lE8vgUd3mK5
 N/xk4TPnLh6Q2cQAoXeN7McQHif/AoGmhmhzwHpUZBezcMvGCnJSXuPXstLS/OEqeKfiM=
X-Google-Smtp-Source: AGHT+IEQDTUOKxKQk7NQnZzYRSUnjmwBbBjDzT9L0O0GyBxC1K6eT3IQJubUE9ZDyVTldx8F/2KBUw==
X-Received: by 2002:a05:6214:2308:b0:880:51f0:5b93 with SMTP id
 6a1803df08f44-888194e9285mr148621316d6.18.1764951618159; 
 Fri, 05 Dec 2025 08:20:18 -0800 (PST)
Received: from stoup.. ([172.56.17.137]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88830bfc22dsm21591636d6.43.2025.12.05.08.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:20:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/6] tcg: Remove duplicate test from plugin_gen_mem_callbacks
Date: Fri,  5 Dec 2025 10:20:04 -0600
Message-ID: <20251205162007.26405-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205162007.26405-1-richard.henderson@linaro.org>
References: <20251205162007.26405-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf30.google.com
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

All callers have already tested tcg_ctx->plugin_insn.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 1c0b06dbc7..7716c3ad7c 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -182,23 +182,21 @@ static void
 plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
                          enum qemu_plugin_mem_rw rw)
 {
-    if (tcg_ctx->plugin_insn != NULL) {
-        qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
+    qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
 
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            if (!copy_addr) {
-                copy_addr = tcg_temp_ebb_new_i64();
-                tcg_gen_extu_i32_i64(copy_addr, temp_tcgv_i32(orig_addr));
-            }
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        if (!copy_addr) {
+            copy_addr = tcg_temp_ebb_new_i64();
+            tcg_gen_extu_i32_i64(copy_addr, temp_tcgv_i32(orig_addr));
+        }
+        tcg_gen_plugin_mem_cb(copy_addr, info);
+        tcg_temp_free_i64(copy_addr);
+    } else {
+        if (copy_addr) {
             tcg_gen_plugin_mem_cb(copy_addr, info);
             tcg_temp_free_i64(copy_addr);
         } else {
-            if (copy_addr) {
-                tcg_gen_plugin_mem_cb(copy_addr, info);
-                tcg_temp_free_i64(copy_addr);
-            } else {
-                tcg_gen_plugin_mem_cb(temp_tcgv_i64(orig_addr), info);
-            }
+            tcg_gen_plugin_mem_cb(temp_tcgv_i64(orig_addr), info);
         }
     }
 }
-- 
2.43.0


