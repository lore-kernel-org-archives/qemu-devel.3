Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633D7C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFK-0003pO-Pc; Fri, 04 Jul 2025 12:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEs-0001Vx-ON
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEr-0006cm-3j
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so813979f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646372; x=1752251172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MeBk8+23Qld/xDrPvpisbhEiplaNjhAIJT2BQMnpAac=;
 b=Le77Bj5c4E3yHTqjncQ/Y2CvfE0QBtQ4frY6M6CVfkeQ24N3LesBVlZOcShA1UFpxC
 tsraN+UKcClafFjDvBKvmDg4sXMN1uJti07I6KhymhZd0/ow37H7rw+6Tyzlg9BqCiWb
 F6E8l6WYLKykdwEkyXRH9ZHkssU7bwGpsUIqza/D+Xni6UiZMhz8UWR17fGLVCz4dHbF
 HaUf+j8xK+ja3+H311gPVzI4zp5xcCHX3kBKndgGvDIjjFzMEgpS7Zk0IfmuMTgdJA5M
 cjj9k9R4ZEgvO7DwCAeNy1tarp9mEZqZRP6shCqVfHeogQDwcyjX1xGoY3qMpIcjOLVW
 5Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646372; x=1752251172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MeBk8+23Qld/xDrPvpisbhEiplaNjhAIJT2BQMnpAac=;
 b=ryp/I5tVT8fTYZuUqcZ+WEntRH4svGe6PmGFtb5SZRNkY0r1LSWdeDbQ+dS52tbBeH
 Pplzq2/OsBNvPWNE6iaWvroi4ASOvjcOT+o5mTvEJdcQjQ3qVbLrh0Mc0NcbzRttDXtP
 EcUP2KV3ds6GJj4vT4vF0OgWQvbElA8yQ1VPuHupUI/EYfF35Jskn3WobBFIpL8EJ3WQ
 +rzwa+1kph7OXK73QIaLM11X69xUoLwEwCPJ18kDrj0Cgh8Iz5H5ggAWsQicbYQQFDoL
 hSSHUQdc+DrPGeRmCAXW+xZKbrKWYh/nDEcSxFJETRZe//eZ6O8ssTzNYFhBQpQhcH0r
 G/iQ==
X-Gm-Message-State: AOJu0Yz9i+s/Ldsx5DoqjoSa0FsFSedr7JqGNVStAYCRrDJmCIpwx/bt
 e1/NAe6p8wMjiyEvKYqOStL8UzTsH41HMy7lRNLOi3sgReFiVq8SyAA1tITulTtDWO3XXjlKK+3
 0grUi
X-Gm-Gg: ASbGncuw/JPGj21vnhSDEoVxnlSRmJ3q0+0pXPvIBoICX5VOkOo08xNl5h0Y0mVMyMQ
 B0LBnIRidd6D/hEYhDd3dxFwreCpH320+4XRLVNeMTxCClS4nxrmObAs7DEAhGNCajkR8WZ73oL
 SqXShI/8ao4h4LaXbjIHzWtpVYYxvGf4zL3klyhbn893LcCwQg0Bp5d8YKWdR6/XHdBFUHhohkr
 vZDxH38vXnyl/nGj/3Zb4N0N/CXHuG2zTNMkHoE0AZdPKUGy6KdpHXwXEo8XVU8LFhffuO+wWYt
 NPP4UkEIWP/iHQ767HKYSamf85saCnngEVeYkOlpuId5wDa73eVBAglF0x7eqDIHtckZ
X-Google-Smtp-Source: AGHT+IHtzCDirvj+9tyXsHz/XJx1RnMboVjU8oZKKTUFGtu9Y4jHQwz5n8tEyn+2ME1Pi+5mOLX+9w==
X-Received: by 2002:adf:fd0f:0:b0:3a5:2fae:1348 with SMTP id
 ffacd0b85a97d-3b49660df31mr2640318f8f.51.1751646371700; 
 Fri, 04 Jul 2025 09:26:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 072/119] target/arm: Implement SQCVTN, UQCVTN,
 SQCVTUN for SME2/SVE2p1
Date: Fri,  4 Jul 2025 17:24:12 +0100
Message-ID: <20250704162501.249138-73-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-61-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 20 ++++++++++++++++----
 target/arm/tcg/translate-sve.c |  7 +++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 83c259def6e..f808362f239 100644
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
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 10261e25f92..ac4dc7db461 100644
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
-- 
2.43.0


