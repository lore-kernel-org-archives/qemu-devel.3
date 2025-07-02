Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7072BC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwll-0005im-Aq; Wed, 02 Jul 2025 08:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjN-0004Ir-1Y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:36 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjB-00024s-Bu
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:28 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ebb72384dbso1835109fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459895; x=1752064695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKVRj4bJiSVnznOWCuYAEM7mpBZr6yUxsIsSj2mrfmA=;
 b=yTUFmc/WU6gRb4k52+OOatLGM3d4aiE/jBCpPSJjQMKlt148BinDN+/2oQNUKOnSv3
 0UVTmkhRr3PARwzCp7boAvnIUkSAteQ7SIkUMJpmL693xMvBnVoqJbb3XzFKjGxCO6vi
 iNhY5+ODkbmIzrrmNzDqR4h8LH2i/CdzSY1Tte1OYRO3UPO8Amwsu6vJAHthhE6Se4FS
 mi35i82lpDxFrjE5N8rwaU0tTNgWPTQo7MCJXm2CBRDZQoVjjYDNJIn9+eMm5NUfEdlL
 vH8JhVk/SRoe3iEegj5j21fg4nsrdJISlK/JnX+VnpQTQ9FFWYETZuWCK7//V9BWrsTX
 +6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459895; x=1752064695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKVRj4bJiSVnznOWCuYAEM7mpBZr6yUxsIsSj2mrfmA=;
 b=D51nY2HlYqxpkrI5XLcF58C3N3OsXHrfWwzqbb+sZWa2cdBYBQnaHvqR+DGxig7GUD
 lJ/qgEoYq5z/YGo9XXNHMvte3ndK6EdBJAGCvBJR4xoK7qZe/Al6/LYJoGskFsapvctI
 DfCV50kZpTDD+tES5qtqEksHN2fl68oajngrsg6EJkvHU46iJvWuJRPDv5z7RtSckNlE
 HTWVbuFi9jL4BOQXD5KMz+okQFjDgC6J3hV2Uzc+dnk7oG5eGYmDBFrVftATfwimOzTm
 /0Qkbir9P8vzjuXyTR2yzVi/UJ7tj0BdHjeyqo0COYV9J0GJDe9mcxZqQmLBN45FXhJu
 Pjow==
X-Gm-Message-State: AOJu0YzCTGusOJ1s12kCJCaWHn0JT96/KmvifyB2t6SwTXwmfaW4JuEM
 yindlyu01Odp+0hX6pyi+m2J15daZhkzMGX2ahKBvGcBXPBK8nhj+9CsizCQAE/oDRfWvHMnhvd
 Z+pn7eVE=
X-Gm-Gg: ASbGnct3i7ksafd/NZSI9jNUn28DU4/oq9YT5rES6+O3fAY6jYTKxfFSXFA5bo/WHQb
 2yYjytd9DAnviCTBTpuVguoY8SDZiao7yTohoQt3uXfwlz8tcJhOI/KVfBqY/4o+7PYYGxrUSDM
 KhBySLBtOvl/vpoXInQZy4tJUVT3pUhUNj9jNcNvbHut3U6e8NAyaxQVcYj9FL58ZJ7pYyKb16z
 8C9Qh5oEAt59WF/yo+vaCRSLfoyCtAuV1vhTy6Z3VuHJnneDT+4TI2AFSuOMoywdsYvUlBhCkcK
 UJ1p84cIHfBnyH9WjfyLf17NYnHSGXmAC1UfpSz80G7wqoNmPPPU7wwW9v6FIKVRkePNwA==
X-Google-Smtp-Source: AGHT+IHhnjfZ8UaN+HTv4as41tHfk+1OWIhWXte6Ke5z/Pn7d3imTsoM+MCkOJ4QStZ2p+C4FdU7YQ==
X-Received: by 2002:a05:6870:af42:b0:2d4:e96a:580d with SMTP id
 586e51a60fabf-2f5a8aa21b0mr1701495fac.16.1751459895235; 
 Wed, 02 Jul 2025 05:38:15 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 50/97] target/arm: Implement SQCVTN, UQCVTN,
 SQCVTUN for SME2/SVE2p1
Date: Wed,  2 Jul 2025 06:33:23 -0600
Message-ID: <20250702123410.761208-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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
index 10261e25f9..ac4dc7db46 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7427,3 +7427,10 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
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
index 83c259def6..f808362f23 100644
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


