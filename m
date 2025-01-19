Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38E6C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJv1-00043y-Ex; Sat, 18 Jan 2025 20:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuJ-0002UT-T1
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:20 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuH-0003hP-WA
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:19 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso7009505a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249316; x=1737854116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIpCKy5JQx0bR6D2mwy5LNfmO2MRj2In2XtJ3m1ANi0=;
 b=ce3BUzFsmElZ38cm8iWTSKmtbUXMiPk0/ypJ/N9TmTWXi8cK2D2OZWhNzgzyar5ftt
 JP4/oQsvMVL+lInLJlPSD18qzFxzku81VvO4fo2H/KWSvPDFOqOa1sehprAh0WiZVuWf
 R/nx7Hvrg4yF8mO0hqN19tyXfMXuljmVRbKNZS5WiA+KxSM5q5Mt4s4/Eslfg1BxSEeS
 AAl4Nc23wWejIW1d3OpI7IQMZAF520jAptkK/aXPtcpnalhdc77yyNWsCSEv21FeNZzw
 uWYs9CkLzZoRXH2wTUICnKO2Gm2vIyvnnwQuHcRYh4WbGeuv9qgqMyBybUzx+qRpIxBV
 QbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249316; x=1737854116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIpCKy5JQx0bR6D2mwy5LNfmO2MRj2In2XtJ3m1ANi0=;
 b=mvrwcT8YixN6x30zCN41QMxxK/mv/zyqaoCQCjvRAOQRzjj47BC0GkBsET6NGWEUlg
 ZMO6fwKiQt5b0BzZ5ubG/IFInRFEu+osHZ8Gid2VtxdmfJCw51UTPdfnv0K18KoUAM6/
 WzsJ40eEsp30zzGAobosDo/tIRufPwDj90Y1L3JYkRCj5eSttnr0/FeLixlScNbhHhsU
 PCU4XxqbNW3HbuX/WBeDAEhhBEXbHLTP2a1qO5yUY1qSO82o44+fDWSPKfkqS8KNQEEO
 s0M6V6NB8mF9+ciMnPHb/m25KyQDx3vHF3yo+Fh8T93S/VUvqiMxnZyhG9elzDwWlzZB
 LFUw==
X-Gm-Message-State: AOJu0Yx05F6KX1fnfO0yBFGZtiToa4YcW8kBOhfpn/1hwNOR1MAgMx+G
 HrZlLRgsBYKS/pJX+PGu1Zmo6hAtZWe9MEopu3kAf0YCKqYXY5Bi8y9rnoXX
X-Gm-Gg: ASbGnctpfd2o8IPqfu55irxVYSpWcFutC/QGCj/NRmiEu4mOI5mLneI99F7nI0TutgL
 HN/LSBeBswYfcDqdK9bfBJ/hIO8EATSw81BrFKcmu4LNqPgqN5GkN6K9sx8XE4XAVT9ELKXSSGC
 Ztg6aBuj4cVOsB91qQWiypn8s0YMxMmaKoiosXMCOX/KM+/MeG8JbiAcApJgJDGiS75tA7/J1P3
 6OSc0U3AVJ7zBJgCI6xVQIX1C5hDflx1FiLlfrQC2l0Pd1uEdmZtcXQkz8Fq2nHGd9lWdMEPXbh
 HMEhAM3PpT+WmkcpDcLGzf3HUZylygG/THF/gLi94jkMDUO2DVIJR5umY4t8bqbVk2/2zA1S/g=
 =
X-Google-Smtp-Source: AGHT+IGfCS1xDzUCBQ4dLcaH49+YOSkPH0mdHZQyf2ITJJESKGLAl8mH858HLAHS46zK3kvHIpho0Q==
X-Received: by 2002:a17:90b:1e53:b0:2f5:5bc6:a78d with SMTP id
 98e67ed59e1d1-2f728da3537mr23487166a91.3.1737249316292; 
 Sat, 18 Jan 2025 17:15:16 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:15:15 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 45/50] target/riscv: Implement Smdbltrp sret,
 mret and mnret behavior
Date: Sun, 19 Jan 2025 11:12:20 +1000
Message-ID: <20250119011225.11452-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Clément Léger <cleger@rivosinc.com>

When the Ssdbltrp extension is enabled, SSTATUS.MDT field is cleared
when executing sret if executed in M-mode. When executing mret/mnret,
SSTATUS.MDT is cleared.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-8-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 59c4bf28ed..ce1256f439 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -306,6 +306,9 @@ target_ulong helper_sret(CPURISCVState *env)
         }
         mstatus = set_field(mstatus, MSTATUS_SDT, 0);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp && env->priv >= PRV_M) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -391,6 +394,9 @@ target_ulong helper_mret(CPURISCVState *env)
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -436,6 +442,12 @@ target_ulong helper_mnret(CPURISCVState *env)
         env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        if (prev_priv < PRV_M) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 0);
+        }
+    }
+
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
     }
-- 
2.48.1


