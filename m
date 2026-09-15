Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF82C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdK-0005Pe-6k; Tue, 15 Sep 2026 13:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdF-0005OP-If
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:45 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdC-0003Tk-15
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:45 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f63546c5so432788f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492060; x=1790096860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E044AAl5EJB3+S1h4ssG7CoWYXWkxOfE84p38VpBkXc=;
 b=rZhvWrZQXD+I6GCjobB6XmihoERhQiPeDj1zDE9fmeDumzdOB8GkR3awB/ylF/COvB
 Y0qQ6V7J+3cXAE6Or5l3Tj2v+jack9EtYtHgISW+O1VPW5GuBv4GeJfF1IEzgqkP3WH6
 3Hmb8KxasbSzBjkT4IpgAzDIm+tf6HXiPHCCRDVuiPvmBHDGwsLwAuVLBVMKExlMUNvk
 VuiGatFsY2zJct8GviPFqpbqdQFiB5iYxvM82S9ieydfle2ErqS979gPTLtsmawJnGV2
 LRjYqPraN9OlVhYrftRH0ASUTaxY4uXwbm0hRkg1ZrZfvcNmOJG1F519yfJoFTqyt10k
 EKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492060; x=1790096860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=E044AAl5EJB3+S1h4ssG7CoWYXWkxOfE84p38VpBkXc=;
 b=BMBtBXDWi8NhOpslNL0+wUoYnvvJ2LStP9xQP3IMrVZBWV3DIhOeIYAQdTM2sOHiTY
 bJ1uu8S4RHQKWjtOEIMLitryxPg6QppR+7YKyuZRc6Mlnlt/mlt+4eDlhBtlcF3xEhqn
 ApiWDKSkH5KJnNdifosoHPX24x4eWznS2i3hJB2zdo3V84AD/fVsFelYK017mE/psj1L
 GOwTBqh1VUKejkesT2qTD3kldUOOcLoIVUBbYtJIO0Wf6gQdnDtOnnXp7oM6saR8wZ6V
 6rLOzOpZKfEUY5sy+JhD+G+FZLnV2H6I+TcnfHoXw+YrDV4QkZYUUE2tSY/5cohK27dr
 nVzA==
X-Gm-Message-State: AFuF++ln7G2W6oBXcH27TBP1NVMgRrlUJHTkbUL7dvWt4qCJgnGr+4y5
 nTvtWmi04gjh7xrXbxFdAKC8BfTQZ7/+yiXPVyryYqSvmHDKBMpGNOp2ikcyut7spiKesC1oC+B
 Z5ao0J0k=
X-Gm-Gg: AYBFou05O4KTyHVM5Euh0BYegzT/yDbBkpkHrHsEbifDNxvTni+R3LKOdLvpGsqql9o
 kpHRqDXFiXXIZlEJyNFtQwEfkuMVsia0/Psn+6yIS3duNougxstZQYNGKz8lQXd+o8CEm2HhyiI
 8ip0BgneGQnSGvE/h5rS0hgJotOGSkoz/4PZMpD5pfbqrhftaBzPuNK1Il/iDzgaDTfni60mtHy
 jCdBa7pkEwZ/vp/TeCjGKOoVIfR3jU0b8Biok+YitjceslJPVedUJ+mLhKNomSUt/4F6Dx9yqgU
 uUT0aFzdpQxBkGlgQDweC4PQQOsuR03ufzKJwwGdlniFnf2mTBXhJwL9y+gdJzQGrnuBabGXxJd
 Fs+V7wvC58Bljoe8zsWQQQw4r2OSLCsFFPqfWWelUOwSUwia+UxL4FE6qSA3PB/F0lpkpj29m2P
 P84nAgR5jnDEOnzfXKJvBjrJQLJjNFjE9J4LqHNTkagTB528oqnRjj5NMrF1A9mWaUqDq9P9Wjz
 fj8qXz3HVr2rRjGZGHyUVLLNZaBrfoobpu/uhalBF2jLctkl+PF3kmUCS1DD+BQ5UiKiWv1Q057
 MP24
X-Received: by 2002:a5d:59c1:0:b0:487:7fd:734 with SMTP id
 ffacd0b85a97d-4870a992fefmr2161898f8f.18.1789492059844; 
 Tue, 15 Sep 2026 10:07:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] target/arm/whpx: incorrect ENCODE_AA64_CP_REG parameter
 order
Date: Tue, 15 Sep 2026 18:07:17 +0100
Message-ID: <20260915170735.425445-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Doug Cook <dcook@microsoft.com>

ENCODE_AA64_CP_REG expects parameters (op0, op1, crn, crm, op2) but whpx
was using parameter order (crn, crm, op0, op1, op2). As a result, every
call to get_arm_cp_reginfo() returned NULL, cp_idx was -1, and both
whpx_get_registers() and whpx_set_registers() were no-ops.

In addition, several encodings were paired with the wrong WHV register
tag. These are inert while the encodings do not resolve, but would sync
the wrong register once they do:

- the series 1 debug register encodings used series 0 tags,
- the SP_EL0 encoding was tagged WHvArm64RegisterSpEl1, which would
  clobber SP_EL0 with SP_EL1 on get and never write SP_EL0 on set,
- the ID_AA64PFR0_EL1 encoding was tagged WHvArm64RegisterIdPfr0El1.

Fix parameter order (using a regular expression). Fix tags.

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 218 ++++++++++++++++++-------------------
 1 file changed, 109 insertions(+), 109 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 9a5a575b5e9..a05df7d2cb3 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -135,145 +135,145 @@ struct whpx_sreg_match {
 };
 
 static struct whpx_sreg_match whpx_sreg_match[] = {
-    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 4) },
+    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 5) },
+    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 6) },
+    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 7) },
 
-    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 4) },
+    { WHvArm64RegisterDbgbcr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 5) },
+    { WHvArm64RegisterDbgwvr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 6) },
+    { WHvArm64RegisterDbgwcr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 7) },
 
-    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 4) },
+    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 5) },
+    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 6) },
+    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 7) },
 
-    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 4) },
+    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 5) },
+    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 6) },
+    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 7) },
 
-    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 4) },
+    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 5) },
+    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 6) },
+    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 7) },
 
-    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 4) },
+    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 5) },
+    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 6) },
+    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 7) },
 
-    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 4) },
+    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 5) },
+    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 6) },
+    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 7) },
 
-    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 4) },
+    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 5) },
+    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 6) },
+    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 7) },
 
-    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 4) },
+    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 5) },
+    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 6) },
+    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 7) },
 
-    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 4) },
+    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 5) },
+    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 6) },
+    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 7) },
 
-    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 4) },
+    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 5) },
+    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 6) },
+    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 7) },
 
-    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 4) },
+    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 5) },
+    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 6) },
+    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 7) },
 
-    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 4) },
+    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 5) },
+    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 6) },
+    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 7) },
 
-    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 4) },
+    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 5) },
+    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 6) },
+    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 7) },
 
-    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 4) },
+    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 5) },
+    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 6) },
+    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 7) },
 
-    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 4) },
+    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 5) },
+    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 6) },
+    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 7) },
 #ifdef SYNC_NO_RAW_REGS
     /*
      * The registers below are manually synced on init because they are
      * marked as NO_RAW. We still list them to make number space sync easier.
      */
-    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },
-    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
-    { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
+    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(3, 0, 0, 0, 0) },
+    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(3, 0, 0, 0, 5) },
+    { WHvArm64RegisterIdAa64Pfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, 0) },
 #endif
 #ifdef SYNC_CONST_ID_REGS
     /* ID registers are ARM_CP_CONST (writes ignored).  */
-    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), true },
-    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), true },
-    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), true },
-    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 0), true },
-    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 1), true },
+    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, 1), true },
+    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 5, 0), true },
+    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 5, 1), true },
+    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(3, 0, 0, 6, 0), true },
+    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(3, 0, 0, 6, 1), true },
 #ifdef SYNC_NO_MMFR0
     /* We keep the hardware MMFR0 around. HW limits are there anyway */
-    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 0) },
+    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 0) },
 #endif
-    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), true },
-    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), true },
-    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), true },
+    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 1), true },
+    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 2), true },
+    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 3), true },
 #endif
 
-    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
-    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
-    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 2) },
-    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },
-    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },
-    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 2) },
+    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 2) },
+    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(3, 0, 1, 0, 0) },
+    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(3, 0, 1, 0, 2) },
+    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 0) },
+    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 1) },
+    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 2) },
 
-    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) },
-    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) },
-    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 2) },
-    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) },
-    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) },
-    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 1) },
-    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) },
-    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) },
-    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 0) },
-    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) },
+    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 0) },
+    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 1) },
+    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 2) },
+    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 3) },
+    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 0) },
+    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 1) },
+    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 2) },
+    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 3) },
+    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 3, 0) },
+    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 3, 1) },
 
-    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },
-    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 1) },
-    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },
-    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },
-    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, 0, 0) },
-    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },
-    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },
-    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, 3, 0, 0) },
-    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 1) },
-    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },
-    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, 1, 3, 0, 0) },
-    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },
-    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },
-    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 3) },
-    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) },
-    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) },
-    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
+    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(3, 0, 4, 0, 0) },
+    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(3, 0, 4, 0, 1) },
+    { WHvArm64RegisterSpEl0, ENCODE_AA64_CP_REG(3, 0, 4, 1, 0) },
+    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(3, 0, 5, 2, 0) },
+    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(3, 0, 6, 0, 0) },
+    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(3, 0, 7, 4, 0) },
+    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(3, 0, 10, 2, 0) },
+    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(3, 0, 12, 0, 0) },
+    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(3, 0, 13, 0, 1) },
+    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(3, 0, 13, 0, 4) },
+    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(3, 0, 14, 1, 0) },
+    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(3, 2, 0, 0, 0) },
+    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(3, 3, 13, 0, 2) },
+    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(3, 3, 13, 0, 3) },
+    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(3, 3, 14, 3, 1) },
+    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(3, 3, 14, 3, 2) },
+    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(3, 4, 4, 1, 0) },
 };
 
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
-- 
2.43.0


