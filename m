Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A512CA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRDq-0003A7-OW; Fri, 05 Sep 2025 03:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDl-00036p-Al
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:50:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDh-0008Ri-M7
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:50:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3df15fdf0caso1462318f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757058651; x=1757663451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qiesEZLirOm2kTsIFlH0zMZ4nblsrNRxWqDrcxVvyy8=;
 b=quYVr8DlxY+QsRZd2wAP5xudJ9snwpr0VrHUBgE0ACJ8q9v9QNW9w3qSrqW1uRIxdL
 nu9UC9dNCCpGItk1tVPgx5PfQtnFiOBq807nqsXdYsoHx2iX+j9Zv6z0pmfekBIlEUtS
 ySzUzE2V972hfn0hjGBKJ1l7QX2+FaSvEZU4zD65nkpUWnerDMLzdSx2cGewvStImnSJ
 YDz/114A+2xtK7dTGbOo9LBrpy4Wsy8AfuEcm+UeisYuY02COdRzqyFtMJc/gXxqbCNh
 S7EducGTSMlBB5qNKB3dT71+Oo5DWOKKgGLV2Tdxw+/ZM5gvRR4gzOpeyJZzFdQf9q+N
 RT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757058651; x=1757663451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiesEZLirOm2kTsIFlH0zMZ4nblsrNRxWqDrcxVvyy8=;
 b=QLHYMOJNCY6EdwDqwKekT6tKsClNTNPYXbP4BvVV0gSC8+Qa3QUvy71l+ZU4Cb2/36
 tAM/BrHoUhUn2HhK4KoSBroyqUhuWWE1qB79YSsEO8EE94cVASHwT/shDJ3TH9g1TAFe
 ySOFyRusIwGG3sNrJdBEU4H6JJ/m6bnF0+t5pQpfGMFgsr/oXBb/AK3WSlh4/SKPaGNg
 tyNxavPY1kFXdUgg/i4t1u9HcxLaBCDCruXtzaP8lTOVavDaxx/RjQqusRb39M9FUsKM
 +okdqoAd5LROt7xzhWdVfkLV5bSFtM5Hwwc8sFyacRN19wFEA8gQtqAYtoZzAqMDG9Ll
 hvug==
X-Gm-Message-State: AOJu0YynVchPl5cXQkUXXJ3IsHWKhXyn55PntM0uAyvp1UKFOpoExD3B
 4wXqnwxfADfB/6m30CDEjv67cPof6V9Un3ECE9IA/TKfquT3Rf65Q85byqWMNalTspjHGFzqHTI
 9gWIdn98=
X-Gm-Gg: ASbGncvMpREv262ay1yqDUIRH0xlmPt9kqtM6ZqMn4De7EgsDWXuCpitRm1rGSNp0su
 NsOmRoymc21VGcruJQZ0oAiNGqNcF35EVOvs7ZYlZ/XFXfnpLiMwygRbQMTnE493gztuCk+UzDp
 SjCyPE7aDWIarKrPVEgvs1zDAmLiHPCKoVLLaudpGPnEMSPhThHZYwZxbrQs6yEyvqlcLH/lVkc
 2CWHi1KxejxX8mvB5HdxxujCtZt/UoeuIzzepgSuJuCeD0SRyCp5JtnjF9aI0Ua9ZoItT6kfrcC
 CMxKmTUkxsa/HatA1OcJ6kVwcDEAUra7Zxrmdk67IrNLiZlo390G0X0ZFa1R+Hylzid1JKbJ3mK
 AN8AjehZ9zx4h0y3T6YXFNEbxtgZR3YbjXKWS+4HAtx/DzYQCPtyPr7Jq
X-Google-Smtp-Source: AGHT+IFS+TUkbReBXgSNM5gI8IX7DOG28oU8k0IZ03l+BOKO+bNFMel9Nhah4LHCC3rTZNsaiRqxSA==
X-Received: by 2002:a05:6000:2c0c:b0:3e3:a839:c648 with SMTP id
 ffacd0b85a97d-3e3a839c9c7mr944114f8f.27.1757058651319; 
 Fri, 05 Sep 2025 00:50:51 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b98e77231sm143760715e9.12.2025.09.05.00.50.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:50:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/sparc: Loosen decode of STBAR for v8
Date: Fri,  5 Sep 2025 09:50:41 +0200
Message-ID: <20250905075048.100496-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905075048.100496-1-richard.henderson@linaro.org>
References: <20250905075048.100496-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

Solaris 8 appears to have a bug whereby it executes v9 MEMBAR
instructions when booting a freshly installed image. According
to the SPARC v8 architecture manual, whilst bits 13 and bits 12-0
of the "Read State Register Instructions" are notionally zero,
they are marked as unused (i.e. ignored).

Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3097
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 12 +++++++++++-
 target/sparc/insns.decode | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b922e53bf1..c2ffd965d8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2823,12 +2823,22 @@ static bool trans_Tcc_i_v9(DisasContext *dc, arg_Tcc_i_v9 *a)
     return do_tcc(dc, a->cond, a->cc, a->rs1, true, a->i);
 }
 
-static bool trans_STBAR(DisasContext *dc, arg_STBAR *a)
+static bool do_stbar(DisasContext *dc)
 {
     tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
     return advance_pc(dc);
 }
 
+static bool trans_STBAR_v8(DisasContext *dc, arg_STBAR_v8 *a)
+{
+    return avail_32(dc) && do_stbar(dc);
+}
+
+static bool trans_STBAR_v9(DisasContext *dc, arg_STBAR_v9 *a)
+{
+    return avail_64(dc) && do_stbar(dc);
+}
+
 static bool trans_MEMBAR(DisasContext *dc, arg_MEMBAR *a)
 {
     if (avail_32(dc)) {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9e39d23273..1b1b85e9c2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -88,7 +88,7 @@ CALL    01 i:s30
 
 {
   [
-    STBAR           10 00000 101000 01111 0 0000000000000
+    STBAR_v9        10 00000 101000 01111 0 0000000000000
     MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
 
     RDCCR           10 rd:5  101000 00010 0 0000000000000
@@ -107,6 +107,17 @@ CALL    01 i:s30
     RDSTICK_CMPR    10 rd:5  101000 11001 0 0000000000000
     RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
   ]
+
+  # The v8 manual, section B.30 STBAR instruction, says
+  # bits [12:0] are ignored, but bit 13 must be 0.
+  # However, section B.28 Read State Register Instruction has a
+  # comment that RDASR with rs1 = 15, rd = 0 is STBAR.  Here,
+  # bit 13 is also ignored and rd != 0 is merely reserved.
+  #
+  # Solaris 8 executes v9 MEMBAR instruction 0x8143e008 during boot.
+  # This confirms that bit 13 is ignored, as 0x8143c000 is STBAR.
+  STBAR_v8          10 ----- 101000 01111 - -------------
+
   # Before v8, all rs1 accepted; otherwise rs1==0.
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
-- 
2.43.0


