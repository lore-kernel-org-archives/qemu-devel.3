Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4161DC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuCi-0005PN-IY; Wed, 21 Feb 2024 16:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuCJ-00058U-94
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:32:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuCB-0004NT-2m
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:32:07 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dbb47852cdso10240525ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708551121; x=1709155921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9axBQwna36gH+4FogF2jceIZ7UQwZdXDxIAW/69WUJg=;
 b=X1Df34epczGms53icve50I7yWylzF/awI7jClCufz5+yFVAvBCp3BoIDSUp2z2iTd/
 KgDftUXGoev7sv5DrJryYrICz2z1sLg2hmJe1FVO9xJvAexVtYnCfgVvu/9skOaJg/Z6
 f1V6qVWanPMcV2gdud0coDmr/CFfomt5FmDqM9dY+KyOwYY+iSKNgCrq0oLP41JZJCbf
 D4HqQdnWnuVA3myRK7NCwuM224Zu5Naq1cSGjU3iin/9TN1WTIPBBLccsY9/ZwYXxQ3E
 mNTutyf0X/Evaq70OKF4k8T7KJ5kJFYDvIIxStnNBcAxIKTU1m4M6AqNP8Tg1YBCKHuz
 jbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708551121; x=1709155921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9axBQwna36gH+4FogF2jceIZ7UQwZdXDxIAW/69WUJg=;
 b=rFwUrejCQWPeSccfOYK+TmADfNeuj6/KmibH/5orEeqcc23fr/DPLOwyQ4mfhB3rVI
 jPsAC6uTFmAMzdu6Wiky1ueoQDI9jAfkaZV7L7kb3vXNwywj3fw+y+LdA2G3petU8gMV
 vkMomidnuz7lN3/8EvKIBcVjIy41OH5xb9BZBat8c+QSuOLGsNGimlapxURZSo4eLyE8
 6eTSI6WsnmI2Ih44fEijDyCkixtrD0fY0j2ovzczTb9mlSa4ZW4+FPSffF9OBC7WIgtZ
 9GM4Y7qRtyKvokMIgK04paVYc+oUjr035bay5979dKN3tGaAQHHI2j/mH4WpUg36hG+K
 GQBg==
X-Gm-Message-State: AOJu0YyLrg0B2vokRQ323igDjmucU9ol1BSAh1jr7vMrtneKqd73bnzh
 e/n+iA1h8CMpgeDUjkqM1OitT+btfP7vZxRtrCg1kWrkPEpO7YzbyJlGi2fn+sUubEHRgaNzGeI
 T
X-Google-Smtp-Source: AGHT+IGnbbzm0CpOkMbdg763RNCvy7Ls+dGK9D0+3B/k2sHRRQDx1Xdo8JdpDVtEGOrFm1Wc3+zd2A==
X-Received: by 2002:a17:902:f688:b0:1db:ff7b:d1fa with SMTP id
 l8-20020a170902f68800b001dbff7bd1famr10498434plg.47.1708551121134; 
 Wed, 21 Feb 2024 13:32:01 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a170902ee9300b001dbb0348733sm6618051pld.67.2024.02.21.13.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 13:32:00 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 4/9] target/riscv/translate.c: remove 'cpu_vstart' global
Date: Wed, 21 Feb 2024 18:31:35 -0300
Message-ID: <20240221213140.365232-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221213140.365232-1-dbarboza@ventanamicro.com>
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The global is unused after recent changes.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 177418b2b9..f2f0593830 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -38,7 +38,7 @@
 #undef  HELPER_H
 
 /* global register indices */
-static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
+static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
@@ -1321,8 +1321,6 @@ void riscv_translate_init(void)
 
     cpu_pc = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), "pc");
     cpu_vl = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vl), "vl");
-    cpu_vstart = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vstart),
-                            "vstart");
     load_res = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_res),
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
-- 
2.43.2


