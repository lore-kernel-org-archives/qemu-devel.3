Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68547C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHkA-000347-Dz; Sat, 02 Mar 2024 00:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk6-000325-Gc
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:02 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk4-0007br-Qe
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:02 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-299c11b250fso1957122a91.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356619; x=1709961419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reIU85DFkHu+nqHrVViTLnYwfJ9p8+zCdkjjovUmIVc=;
 b=jEHcTpYyo0E9pK3yV+xZMYpoNYhxXuZjAEVO1v3Gl6LdBN43DkeFcUKUZvsVkpX8LR
 kAKa37WAxp1IO4y4V8w/P1mpsj/v0kPsbFSa49mfLvFPbYwOVT95NZWk4pNRI0m9UC7Y
 xL2RuDpuTJto1X1kUSNPB+JffsTk4r4TygnDKKeNorxyQRi/MGeOAAKjxC2GGWVUR3m1
 jwZFZPIULFSoxPO12iC4pIstIP0h8DXoVJTtJGbvwSVR6KXPuZpjIEUgO3MdKsFi9I6e
 TSUM5IS/W8NCivt6xyLxr+6PLfcS+W7UWG0y7ZHQiQpY6gGiM6Rmo+HM/Jp9b+ZklOy+
 NmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356619; x=1709961419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=reIU85DFkHu+nqHrVViTLnYwfJ9p8+zCdkjjovUmIVc=;
 b=qFcTRhegCLzz8bZazPewRpN6TlPZ25tL3NloteY1iRirqeIrKJIvSw9VVt9Pr5JF61
 rgCDRYLVouM/BQd5wou4OF87JltHUk5hb3dXyFlWbu/wywnezDhXzl6bzSZRFKGYByO+
 5hVMWAXT+Fu2q+IT805mC3EvZldNq9joT0WS5Ednnqj3bgd9aieEJYaCwZJaLxHrGkCm
 rZjV7fDwZvgTZ0oLFK+Z9oxl9h5J6VC7pVldGK7T9lD66ZBbGsZKK7ONCrk7TBsRb65J
 D1VMgqPYo9zhRuHQQwQy3c0TllsCMexgUKEDFETm2p4Xk2NCqirPHrvMkhz1yF7CBjAE
 rotg==
X-Gm-Message-State: AOJu0YxoJe5cyHCCTTDSdJaKiaB9JlQzBtHnk/5Tuic5Brub/e4CubUs
 r3oqEQrOo/nP7J0M33BMfXrx/zjrscgn5zhv53i/ZnX5uhlUa6XoDuKcwNHbAO++1ieZ81vPczf
 r
X-Google-Smtp-Source: AGHT+IHaYxtdLlOUXpMC3O/6OWHKuJEszoc7ZS2L+b+f3f8oYEpUkhSSkLDbBEZqnSAKUUCCztocPA==
X-Received: by 2002:a17:90a:53c6:b0:299:7120:e08c with SMTP id
 y64-20020a17090a53c600b002997120e08cmr3279753pjh.22.1709356619457; 
 Fri, 01 Mar 2024 21:16:59 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 35/41] target/sparc: Implement 8-bit FPADD, FPADDS, and FPADDUS
Date: Fri,  1 Mar 2024 19:15:55 -1000
Message-Id: <20240302051601.53649-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 11 +++++++++++
 target/sparc/insns.decode |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8e67d9023d..cb5d8c27ae 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5017,17 +5017,28 @@ static bool do_gvec_ddd(DisasContext *dc, arg_r_r_r *a, MemOp vece,
     return advance_pc(dc);
 }
 
+TRANS(FPADD8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_add)
 TRANS(FPADD16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_add)
 TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
+
+TRANS(FPSUB8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_sub)
 TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
 TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
+
 TRANS(FCHKSM16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fchksm16)
 TRANS(FMEAN16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fmean16)
 
+TRANS(FPADDS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_ssadd)
 TRANS(FPADDS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_ssadd)
 TRANS(FPADDS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_ssadd)
+TRANS(FPADDUS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_usadd)
+TRANS(FPADDUS16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_usadd)
+
+TRANS(FPSUBS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_sssub)
 TRANS(FPSUBS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sssub)
 TRANS(FPSUBS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sssub)
+TRANS(FPSUBUS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_ussub)
+TRANS(FPSUBUS16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_ussub)
 
 TRANS(FSLL16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_shlv)
 TRANS(FSLL32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_shlv)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 7833437f6c..52bacff126 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -509,6 +509,15 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     MOVdTOx     10 ..... 110110 00000 1 0001 0000 .....    @r_d2
     MOVxTOd     10 ..... 110110 00000 1 0001 1000 .....    @d_r2
 
+    FPADD8      10 ..... 110110 ..... 1 0010 0100 .....    @d_d_d
+    FPADDS8     10 ..... 110110 ..... 1 0010 0110 .....    @d_d_d
+    FPADDUS8    10 ..... 110110 ..... 1 0010 0111 .....    @d_d_d
+    FPADDUS16   10 ..... 110110 ..... 1 0010 0011 .....    @d_d_d
+    FPSUB8      10 ..... 110110 ..... 1 0101 0100 .....    @d_d_d
+    FPSUBS8     10 ..... 110110 ..... 1 0101 0110 .....    @d_d_d
+    FPSUBUS8    10 ..... 110110 ..... 1 0101 0111 .....    @d_d_d
+    FPSUBUS16   10 ..... 110110 ..... 1 0101 0011 .....    @d_d_d
+
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
                 rs1=%dfp_rs1 rs2=%dfp_rs2
-- 
2.34.1


