Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE04C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmr2-0007Rv-Tq; Mon, 27 May 2024 22:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmq2-0005kK-3G; Mon, 27 May 2024 22:45:23 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpo-00041N-Cr; Mon, 27 May 2024 22:45:21 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so2540145ad.1; 
 Mon, 27 May 2024 19:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864305; x=1717469105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BljNjeMaZO3XaNf0tppv2lCKaXtzum6yJ/eCc7gYwjE=;
 b=C+73i1uZHmyhlx/h9o8cFBSCl2kzjA5HsXdpNoocMHSFs+CJ156tMrVkk4NpNezW9Y
 CuNeI4YNhMkVQiBDGMf87t2T0f9aDrNx83d6+NtluU+6AxgHD/6259tuYWtUzNPjKowY
 7f+bZgu67hnkLTKCih/AKW67B8jb8KEp6oGVKmY0RFZABKhHLke+zzE4aHxoXK/2Uckb
 fYT+/GerzuRpkQsfIQH7LtL83V9pHhEO/yyqrf2QGFPxQ2o9F+RMTFgC5dO36+qMlst7
 xW440GnWNsPypoxG3hygnGsG2hfqmAflFX+QyX6AMSk249idMPbbqgf7r77Rlt/bJQ8V
 BHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864305; x=1717469105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BljNjeMaZO3XaNf0tppv2lCKaXtzum6yJ/eCc7gYwjE=;
 b=YzzguGX18X5U6b5LJZ/d2zFg8KBfmpwYwKYa7+d6/cbTICArW8GbGXA9iESlraLtY7
 ZhKZUnL50HxesgiccsVLJD3BDiXFAmSMpN4zDAYBoeDPp+p2iBUjb3N6wS2w9Ze2wky4
 yJU5QC6CH2dpoUCE+7nC67GAd3O8q4VgafOA5XC7ESTIlNuCM0aQs5lcmArKJRCYR3ZZ
 Dz3yADdA9Xl5KgcAyRwrzR9WZlrsfIOYzi5UG03yZ9Xb+4M9SIKeJoue2NkzoPB9dKjT
 TtzlHEtIuHMyAQH86BNZlIiJZu9t2j7SE5C15ZYmGTUQgjJV8LJ4Hhv/3qk5exRiRTMO
 jApg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhjbibivKKo0fb2sLjPcOGfjGpOQDJ7xT8I57wk6VPEXLlh4iReUgu7yOj7qJ05dDpTtQ2HsT1hEZmsTw0uTzLJdsUCwjp
X-Gm-Message-State: AOJu0YwWJP3IipkGAr3SD8aESoPpSKBhX0RRswxyT6FACbQmljVOBpnc
 IGvmDso+IqcpeMSqY+4mv56Hv96eRAUKe8TiFTZtUss/D2mGgbqbgAcTHw==
X-Google-Smtp-Source: AGHT+IHIWMkzcC2taA0xL7S4iJiF04uT/yBLd9R6pYldNAqU75SFzGHDGOiJ1VA7OFc4KD3a7VrgsQ==
X-Received: by 2002:a17:902:fc8e:b0:1f4:a04e:8713 with SMTP id
 d9443c01a7336-1f4a04e8cd4mr65536155ad.28.1716864304559; 
 Mon, 27 May 2024 19:45:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:45:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/28] target/riscv: rvv: Remove redudant SEW checking for
 vector fp narrow/widen instructions
Date: Tue, 28 May 2024 12:43:20 +1000
Message-ID: <20240528024328.246965-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

If the checking functions check both the single and double width
operators at the same time, then the single width operator checking
functions (require_rvf[min]) will check whether the SEW is 8.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240322092600.1198921-5-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index c3af38af80..3a3896ba06 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2333,7 +2333,6 @@ static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
-           (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
            vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
@@ -2373,7 +2372,6 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
-           (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
@@ -2406,7 +2404,6 @@ static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
-           (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
            vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm);
 }
@@ -2446,7 +2443,6 @@ static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
-           (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
            vext_check_dd(s, a->rd, a->rs2, a->vm);
 }
@@ -2704,8 +2700,7 @@ static bool opffv_widen_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_widen_check(s, a) &&
            require_rvfmin(s) &&
-           require_scale_rvfmin(s) &&
-           (s->sew != MO_8);
+           require_scale_rvfmin(s);
 }
 
 #define GEN_OPFV_WIDEN_TRANS(NAME, CHECK, HELPER, FRM)             \
@@ -2810,16 +2805,14 @@ static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
            require_rvfmin(s) &&
-           require_scale_rvfmin(s) &&
-           (s->sew != MO_8);
+           require_scale_rvfmin(s);
 }
 
 static bool opffv_rod_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
            require_rvf(s) &&
-           require_scale_rvf(s) &&
-           (s->sew != MO_8);
+           require_scale_rvf(s);
 }
 
 #define GEN_OPFV_NARROW_TRANS(NAME, CHECK, HELPER, FRM)            \
@@ -2947,8 +2940,7 @@ static bool freduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_widen_check(s, a) &&
            require_rvf(s) &&
-           require_scale_rvf(s) &&
-           (s->sew != MO_8);
+           require_scale_rvf(s);
 }
 
 GEN_OPFVV_WIDEN_TRANS(vfwredusum_vs, freduction_widen_check)
-- 
2.45.1


