Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC37ECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lc7-00052N-4p; Mon, 22 Sep 2025 14:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc1-0004ya-Kp
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbu-0004Cb-GJ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f3405c38aso1263841b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566998; x=1759171798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HidgR8YbdGgwoHKVV2oZVXdM2RMQ3ecG9VGCjbLMY1s=;
 b=hFS9XJylgsenpGO6uMkh8PMcGh4z5swIi8+qjIH/YX7WHpKFWA1ed1gtctls2UzaLq
 Wgw/Pu3JTRVPAw1spggV/16qH1ArdUCdwjZ4RoHSmyONMYER7hIbfX8FpqC8yJAXRidY
 UPeZnDLF5lYF0oF3n17NGFylAxaqoAPbzMnZ+th2s5ajZA7mR9RsBKnr79egKZVUgvl+
 MKbVsrPisMZD1zj8ZTrT/56ff9wJepMUzVLQAjFjXI0+dejgtSl1HZKZh/hQJuspasfQ
 NqL79oSUsnzzBPnPX3/dB9Uiw1v1aPCQGFe983JI4ASpUFuAv8YPfVSRb5iHuP8V/xXp
 GQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566998; x=1759171798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HidgR8YbdGgwoHKVV2oZVXdM2RMQ3ecG9VGCjbLMY1s=;
 b=jFz4LvStQ2qkfUnSdTeCfsJLC0a8Zc9kW/htwh3iVD5ER0Vsni4ULtt6tV34Dnxd4B
 a7PvniwKz38ISECoxtL9RtuDLLKtB3C9yzqK8I9w/Cs1hn4hJrJk+7JdRCVC/pKMVarb
 O6yGfMN80CUJAA2LfhNlWURKncEg/fRs7EABsrDG/h7Oe5V/Plm34tFAbLcDXXg5YHyj
 bW817YDGrlPDlKAhkN/yDHA97NOEFBxCOsofVNC9ta6oc2tzyJbGy5lIMltLD3FQ8XuQ
 cMpXeJfVmpaikTWFIDJ9UBactddyXTS3hCK4PEEN1DGIgqJDGyl0ENUzb4Tc5CIHFqvW
 iMQw==
X-Gm-Message-State: AOJu0YytbfN7B9hpzA6eZwQVsVgBjJ3aJpdTMcZ5dRFR5Riq2VTccL3T
 R2pyQqFP7gkdqEwBAMrbRtfz0LK71KLEP5AZ08x80gqncrWEHr7LLetZ4nihKSEeupm6f8YSShF
 PqT/y
X-Gm-Gg: ASbGncuk3mR+TY6RIZnu/0OXNV0C4w114uG9Ohe/bPt7eJLfH8uvsIZstf1y56Kt135
 ySLREOwPknhASxM3Wlm9pXniLlGiXwIddKP1F8MJQjM2f99Y9CECWcWbazKKJYoZESGKXVZXwHi
 5iNwJYk8k4u//qkOBVX08SAIJWhb0FXB+Hs+60cvhAG0b3VMrrWYAjVQTmGU8W+mbuUh7CfzKet
 i3lreBNwLnzKeuuuK2vZZFD6Oj/Vr7o2G54vhGkQNNKUq3dEKjxZgzdBD5NrZNwc1AD02LAm+e4
 XbiqKwTxw7FRzq9wEUC/1cJijbrfgcGTNfea3vVoAKR5E7duiiNSj36rY/yktil7uWyeqMscCO3
 QH6eC4QwU2A9wK+dBM0mRVBovolly
X-Google-Smtp-Source: AGHT+IEz49kNzWGti3Us/0yjyZzEpNLwdomoQLQFyFMC90XvzhCEeZzjsrGNFZcfduEuXuW6QybXww==
X-Received: by 2002:a05:6a00:23c3:b0:77f:42d5:b914 with SMTP id
 d2e1a72fcca58-77f42d5bb6amr3565135b3a.12.1758566997680; 
 Mon, 22 Sep 2025 11:49:57 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 24/76] target/arm: Remove unused env argument from
 regime_is_pan
Date: Mon, 22 Sep 2025 11:48:32 -0700
Message-ID: <20250922184924.2754205-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/ptw.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a25ef90c4c..b32c31779c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,7 +1027,7 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_is_pan(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E1_PAN:
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 622b5cf520..db51e55cd2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1393,10 +1393,10 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
          * We make the IMPDEF choices that SCR_EL3.SIF and Realm EL2&0
          * do not affect EPAN.
          */
-        if (user_rw && regime_is_pan(env, mmu_idx)) {
+        if (user_rw && regime_is_pan(mmu_idx)) {
             prot_rw = 0;
         } else if (cpu_isar_feature(aa64_pan3, cpu) && is_aa64 &&
-                   regime_is_pan(env, mmu_idx) &&
+                   regime_is_pan(mmu_idx) &&
                    (regime_sctlr(env, mmu_idx) & SCTLR_EPAN) && !xn) {
             prot_rw = 0;
         }
@@ -1535,7 +1535,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
             p_perm &= ~(PAGE_RWX | PAGE_GCS);
             u_perm &= ~(PAGE_RWX | PAGE_GCS);
         }
-        if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(env, mmu_idx)) {
+        if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(mmu_idx)) {
             p_perm &= ~(PAGE_READ | PAGE_WRITE);
         }
         perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
-- 
2.43.0


