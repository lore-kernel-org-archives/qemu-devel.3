Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44907D16245
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JA3-0006bw-8K; Mon, 14 Oct 2024 07:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0J9x-0006ZD-Qr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0J9v-0002dp-1H
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d4c482844so2351814f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728904959; x=1729509759;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLp4r6f6llKlFkIQR3exhrK8GnjMUvUuiR9NnPTHniw=;
 b=WLVCQyOzLmCtAkGRxPuHpOhZujOWR4PvHm0zK3Gd0etwBtnxllwLWn61IRpl1//GVj
 TIQyMGUXOINzHJJ6SFvB9RzO4eP44qmJYiQjIAuSGb+Lx5w7IC0Evcv3hnqiKdVPoDRg
 N7gPM69hLl/SNzz+tiNYozFUBhmqROGglhPIe6Sagp4FaJOdR0n3QuDDe5U4/ATo8ejM
 XKXv0zDNH0T2zufpxzYztia0CugOySGJPoMJ5NGn3fvOuycCQlkFAU5+TBnlB0duS2tD
 aFyl5Z9RKzakDeD4Pv7vNwz5JsecQrQE79jGqU8OBlWWXjTpAtSUj6/K6qfK2P+W+IJ6
 HekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728904959; x=1729509759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLp4r6f6llKlFkIQR3exhrK8GnjMUvUuiR9NnPTHniw=;
 b=EFwfwpeUXnXJOz3tyOTa2HX5TmFaeKrq6PRuJZwruFPR1/2aH70oLxQcMA9EWtSV4U
 +CD5VhWm+E9m6gONOWvakK+GfzjAXIXEIb/CF0rJ5TflWE0opU0TnrSSifoXHG6y0ULH
 2fEXiLpzQ9D+luuyBV8HlDFrqutE6S2sVrmI58H4NYJAbZL1S8elk/YVtKPrALYofqmL
 QcdOXJHEGJ2TpBr2wbob6yHllmICAkuRTdZVfuJZEykWqWIP5+/f8IA/c/jb30rqKnkt
 ImIzW+bUjP/4F5fph9j62rGDz9qQ6DR8F7aqLlmzjfJZNO32rRTilztsHxOQuJl4+4Q4
 MURg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDYeobWD9rzebLLHERw/oGcPj4UFs9asPa9ob3L+A0LV1Vpvhogv2BugdS5+kjCOrrEaydnLTGQdt5@nongnu.org
X-Gm-Message-State: AOJu0YxgqkTC5QLU5FTZgJ3G1IWdip6vEpelK1r01arFBVRqhbCe/o90
 m+Hu3vQxFgGX0Ll9TvzX9b/le/CD7uHI1jLAp4dhlGCIH2KMiPj18CjdRavMlsM=
X-Google-Smtp-Source: AGHT+IGcm4wAoeiVRTAh/v/bSmxcwTVDPXMFZEHIdbI9BOBLCSP4QpJehj9WHmu22Ars0836ai+vkw==
X-Received: by 2002:a5d:4f91:0:b0:37d:45f0:dd08 with SMTP id
 ffacd0b85a97d-37d551aac31mr7285938f8f.11.1728904959344; 
 Mon, 14 Oct 2024 04:22:39 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd382sm11117303f8f.43.2024.10.14.04.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:22:38 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 6/8] target/riscv: Implement Smdbltrp sret,
 mret and mnret behavior
Date: Mon, 14 Oct 2024 13:22:16 +0200
Message-ID: <20241014112225.90297-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014112225.90297-1-cleger@rivosinc.com>
References: <20241014112225.90297-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When the Ssdbltrp extension is enabled, SSTATUS.MDT field is cleared
when executing sret if executed in M-mode. When executing mret/mnret,
SSTATUS.MDT is cleared.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/op_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 00b6f75102..9d0911f697 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -299,6 +299,9 @@ target_ulong helper_sret(CPURISCVState *env)
         }
         mstatus = set_field(mstatus, MSTATUS_SDT, 0);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp && env->priv >= PRV_M) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -375,6 +378,9 @@ target_ulong helper_mret(CPURISCVState *env)
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -416,6 +422,12 @@ target_ulong helper_mnret(CPURISCVState *env)
         env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        if (prev_priv < PRV_M) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, false);
+        }
+    }
+
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
     }
-- 
2.45.2


