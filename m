Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCCFC624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONc-0001Lu-AK; Tue, 01 Sep 2026 09:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONb-0001En-0Q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:23 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONZ-0007Km-7N
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:22 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1677c91969so461835866b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268700; x=1788873500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pt5JfGmspIpJ+Cp4yhZDaBPjZXqqwtO8Y62+xVXBKEo=;
 b=LlWDnXUKbanfRplBcYNdHGID1Cq0N8KgAWx/yPL0P2LipIofLlYSRX4D0r8kpuAiIh
 GAL19or+JJWzanvFdUFtx9AhXWJ6l4x/ym806XNwO4Ukd8RxwGWz8JnbZJw8oaXOx9pp
 hw/az1jYRBuQ+Znr8LbRavsitWmG1zQ5P8QB82n4zWASO7nWr3/o3YHT8f93pyRpqweJ
 RaptxtC/zJiLvn681OwmQHYpRPRTFNxOLsisMMPlyv8zqT59rUTRVaQb99ahvX75rg0e
 nt7RSYVAKDQPRqhDRK7C0t3U7O6fx/JhIgYxspkLPb4R0U0A4RAZcT4TfyZsYtN2yoCb
 ueMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268700; x=1788873500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pt5JfGmspIpJ+Cp4yhZDaBPjZXqqwtO8Y62+xVXBKEo=;
 b=hd/zG2AxFUBG1wfBQhd1uyExZ/yE2vc6H8Lyj+100CufbLbTFd7T241l2/ueJoZTxo
 8S7+XaruAtUrmEV8Ta8UCyGfugWPhcdhaDPIn/1IB/+B2B47I2r/VoxxDOv2D5HGN++y
 n5hOu7ooe+dztsQXwksn+5dLVJS7bmk5JvtlufpseaTRIGUEnmpPRlo7emdTeUadRpqf
 11y1eD5/UsSQ7Mdfu6AqV9geNvhaHnHrz948fc4PAMYhLYLVgHTkjEmB7sudy6jS3Pxd
 losytY4/uM1Hwo2zgSEbEhAxbzBn0D7Et5U86qNQKShl32tXpVK/lqpLLPsgG8gAzlNl
 bZCQ==
X-Gm-Message-State: AFuF++nVWhFMTdtHwOhTP+3qY6nb/z66cu4Bs8PqBEBFnxNn11sjc1hC
 1bIlOLbxuOtzfZZoKS8Ekzf9HgGSgCytnEtqW4THFOLCz/pThSYnVGkruNENShqkUMHxzA11Pd5
 AtkomsW8=
X-Gm-Gg: AR+sD11FySnP+yk8bAYHeCoWWnio2NLrxTPeMbs5aXWKK0XsMWr4UO4WTeKogLmyKyR
 ixnXztwx/fouAhIAhpZG4wcdMh6Iv2+HMdMzx4FdkYy4P0jE+wB16F0RTY+2u9NxmkbLKhHTm7M
 CnQPw15jIO8spZCpYaaqwzc2QZFiXVlcGZWnbcijoUMV/12UMu5M+7LqQ06idQRxCDXwzN4v4/7
 bSg/XB5ZuQXnp1WLm3kWcVUmL+l6ARkfXBoArBD2JUJ7X6ORqUVokFhYPhWZBtlnMMpheOQY2Ac
 kqS0oDYXkej2Fki6DAqpPXJ47Ug6XLsqhXpcceFyDyYyPhvkQXuX3lC/nSWQQyPblzI79W3ED58
 ehLHP9t6YVrh1jfm5kAJAdL16EL781g7E5LQ/5L1RyaIliKTTAnPkfJsNgxpUxxHSFgy0VSms0W
 tDQUGFTv8Jf4acjfPdxwjeEXmi70t6XeJZcqoFbWiLWexfD7gKmD0DO2R+kx7X1/kbAqfn5fX/c
 Le6unul+hMbxNKJnOi2QliLae1NnwNFFeaJlT0f8s3ixwN/dcpDkRYMxNQZXI+XgmlZVw==
X-Received: by 2002:a05:6938:a086:10b0:c25:b597:60bc with SMTP id
 a640c23a62f3a-c25b5976156mr373387666b.23.1788268699708; 
 Tue, 01 Sep 2026 06:18:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/58] target/arm: Implement SME BFMUL
Date: Tue,  1 Sep 2026 14:17:20 +0100
Message-ID: <20260901131732.2263947-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 24 ++++++++++++++++++++----
 target/arm/tcg/translate-sme.c |  4 ++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 4e19c42b196..3e4cb7e5829 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -296,10 +296,18 @@ SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
   FSCALE_n1    1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
 }
 
-FMUL_n1        1100000 1 esz:2 1 zm:4 0 111010 ....0 ....0 \
+{
+  BFMUL_n1     1100000 1 00    1 zm:4 0 111010 ....0 ....0 \
+               &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 esz=0
+  FMUL_n1      1100000 1 esz:2 1 zm:4 0 111010 ....0 ....0 \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2
-FMUL_n1        1100000 1 esz:2 1 zm:4 1 111010 ...00 ...00 \
+}
+{
+  BFMUL_n1     1100000 1 00    1 zm:4 1 111010 ...00 ...00 \
+               &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4 esz=0
+  FMUL_n1      1100000 1 esz:2 1 zm:4 1 111010 ...00 ...00 \
                &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4
+}
 
 ### SME2 Multi-vector Multiple Vectors SVE Destructive
 
@@ -380,10 +388,18 @@ FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
   FSCALE_nn    1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
 }
 
-FMUL_nn        1100000 1 esz:2 1 ....0 111001 ....0 ....0  \
+{
+  BFMUL_nn     1100000 1 00    1 ....0 111001 ....0 ....0  \
+               &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2 esz=0
+  FMUL_nn      1100000 1 esz:2 1 ....0 111001 ....0 ....0  \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2
-FMUL_nn        1100000 1 esz:2 1 ...01 111001 ...00 ...00  \
+}
+{
+  BFMUL_nn     1100000 1 00    1 ...01 111001 ...00 ...00  \
+               &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4 esz=0
+  FMUL_nn      1100000 1 esz:2 1 ...01 111001 ...00 ...00  \
                &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4
+}
 
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d28574a8cf0..08b25b0be9d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -903,6 +903,10 @@ static gen_helper_gvec_3_ptr * const f_vector_fmul[4] = {
 };
 TRANS_FEAT(FMUL_n1, aa64_sme2p2, do_zzz_n1_fpst, a, f_vector_fmul[a->esz])
 TRANS_FEAT(FMUL_nn, aa64_sme2p2, do_zzz_nn_fpst, a, f_vector_fmul[a->esz])
+TRANS_FEAT(BFMUL_n1, aa64_sme2_sve_bfscale, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fmul_b16)
+TRANS_FEAT(BFMUL_nn, aa64_sme2_sve_bfscale, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fmul_b16)
 
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
-- 
2.43.0


