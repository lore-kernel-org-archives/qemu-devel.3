Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F43C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83R-00061M-FN; Sat, 21 Jun 2025 19:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82O-0002A0-3t
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:20 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82M-00055u-0c
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:19 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso2670723b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550057; x=1751154857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IMevFYpNHiYdviZ+xxjbC6i5fdLi8QE9bn2xV49Gr9k=;
 b=p4AMdo6UlhDySCWzE33OoRyDsJfS+1tdCQs7LYydbmJIXfDDqxSjgp7qw6+BIH/csD
 8babDu5lihEkGzZY/2HK0WaVV4004R/NS+rhaaiQgc2ly4XKJnI09+sr2sYaMPBtAYLK
 YfmF54nbhqhLnzq2lbmvQkxC3MaL2tZlxKofmkfQQTII7HtmB21TRgLX9RNGKm89LGkK
 FcrqfKUgzYbDcqAUr7erBK4e6aLW0OL/EMXia6jowFItEKzbhHSGYsL5kGTc9cQtFWyN
 D669rJVXAqiooLj15l+cwfEMzFeU1hPsCbPenFgZ5mgLBYDGUXc8pe8QB3Hfg+vcwP9z
 R9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550057; x=1751154857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMevFYpNHiYdviZ+xxjbC6i5fdLi8QE9bn2xV49Gr9k=;
 b=wBO36xYUO3DPNRvw6CTgWxrsVJlaG7zi9x75ElGOA7Sof6LnR52XHSUGhN/et04DXi
 Bp6AggNnnoQ/YoFKBuKEYvNGt3o3qEzR6mpl0CE52Uk+Od38TcabZ7mBVf2Vwc2+L76J
 AuknqBdMA7eEZdeRZzXF6ptKzGJRk++Hpsf5M6eS5/q3Z8bTrL4Yp76/DNeIomJnh8wd
 OKI3Loyk5xcJD+1UlDJD5qkgcfOwTq4DBWAohMV8qYSLyaXEHR+ZlAuGKebrslkqqK0E
 XzHDP3k34TZ9tG1uwuO22Elvz29SaaIRQ8wu/lELX+Rx604Vr5C5I9DrM/+88hGeK7LX
 tB8A==
X-Gm-Message-State: AOJu0Yz0XMuiKqd9K2imXVzedN2dy65lsaKh9EuMZO/clHpCabOus+ea
 ZgDogRzZeUxzk7yyI+iyfNIKIulcqMOia3b4sPjfG29lgVzVg38Gs+W+t0XL9Pg8jsHL+Z+6NF2
 kmmnUf5M=
X-Gm-Gg: ASbGnctDXjEMsSkFpSPXQPguQy1ujJexHSemLBOQBD8fxgfDKyyPnFOUDWCsVunAxHp
 iNmZvZqZZvF3o5sKmhuOekiDe6QdZ8p4NwH9AMRYD/nvm7aXOKT38FDCEAarCjqa4SBCKvF5auE
 jJMLZ+zHpPgcLY8W0QFB9H3KyOomqLFzXS5EPgMwokzwDX9p23jMMn8EuMrWEz913VjWV9b8DoM
 MtPwseHG1/bmCDCrDMkI3eW60SvCc3lHq31vvAy8Ji/rvw9SeFLkoLgzYysgHF6NTrbhbumX5JN
 sLejWxBHvr38VFIUktW7RqXRyOP1eOB8zPZW8mlBO65lJftfKQj0qW6hoMZVsXwDqtIbWWrpo/7
 q0+pbWgRqV0i2kg7RY1mS
X-Google-Smtp-Source: AGHT+IExkcKflt5nwmQ30VJov8DHURJCxBovbZPNPNngy8VV8/8jLX+F3FFOuG69q78gquaPBVS8ng==
X-Received: by 2002:a05:6a00:2d1b:b0:748:33f3:8da8 with SMTP id
 d2e1a72fcca58-7490d663646mr9340238b3a.5.1750550056683; 
 Sat, 21 Jun 2025 16:54:16 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 059/101] target/arm: Implement SQCVTN, UQCVTN,
 SQCVTUN for SME2/SVE2p1
Date: Sat, 21 Jun 2025 16:49:55 -0700
Message-ID: <20250621235037.74091-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c |  7 +++++++
 target/arm/tcg/sve.decode      | 20 ++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 95121cce8e..a854c40ea2 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7380,3 +7380,10 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
 }
 
 TRANS_FEAT(UCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
+
+TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
+           gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
+TRANS_FEAT(UQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
+           gen_helper_sme2_uqcvtn_sh, a->rd, a->rn, 0)
+TRANS_FEAT(SQCVTUN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
+           gen_helper_sme2_sqcvtun_sh, a->rd, a->rn, 0)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 5234d0f0ae..7e29882a71 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -57,6 +57,8 @@
 # as propagated via the MOVPRFX instruction.
 %reg_movprfx    0:5
 
+%rn_ax2         6:4 !function=times_2
+
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
 # when creating helpers common to those for the individual
@@ -102,6 +104,7 @@
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
 @rd_rn          ........ esz:2 ...... ...... rn:5 rd:5          &rr_esz
+@rd_rnx2        ........ ... ..... ...... ..... rd:5            &rr_esz rn=%rn_ax2
 
 # Two operand with governing predicate, flags setting
 @pd_pg_pn_s     ........ . s:1 ...... .. pg:4 . rn:4 . rd:4     &rpr_s
@@ -1507,13 +1510,22 @@ UABA            01000101 .. 0 ..... 11111 1 ..... .....  @rd_rn_rm
 #### SVE2 Narrowing
 
 ## SVE2 saturating extract narrow
-
 # Bits 23, 18-16 are zero, limited in the translator via esz < 3 & imm == 0.
-SQXTNB          01000101 .. 1 ..... 010 000 ..... .....  @rd_rn_tszimm_shl
+
+{
+  SQCVTN_sh     01000101 00 1 10001 010 000 ....0 .....  @rd_rnx2 esz=1
+  SQXTNB        01000101 .. 1 ..... 010 000 ..... .....  @rd_rn_tszimm_shl
+}
 SQXTNT          01000101 .. 1 ..... 010 001 ..... .....  @rd_rn_tszimm_shl
-UQXTNB          01000101 .. 1 ..... 010 010 ..... .....  @rd_rn_tszimm_shl
+{
+  UQCVTN_sh     01000101 00 1 10001 010 010 ....0 .....  @rd_rnx2 esz=1
+  UQXTNB        01000101 .. 1 ..... 010 010 ..... .....  @rd_rn_tszimm_shl
+}
 UQXTNT          01000101 .. 1 ..... 010 011 ..... .....  @rd_rn_tszimm_shl
-SQXTUNB         01000101 .. 1 ..... 010 100 ..... .....  @rd_rn_tszimm_shl
+{
+  SQCVTUN_sh    01000101 00 1 10001 010 100 ....0 .....  @rd_rnx2 esz=1
+  SQXTUNB       01000101 .. 1 ..... 010 100 ..... .....  @rd_rn_tszimm_shl
+}
 SQXTUNT         01000101 .. 1 ..... 010 101 ..... .....  @rd_rn_tszimm_shl
 
 ## SVE2 bitwise shift right narrow
-- 
2.43.0


