Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC6DC61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0i0j-00063u-3O; Sun, 30 Aug 2026 12:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0h-00062y-HU
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:03:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0f-0007ih-Q7
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:03:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8541875f596so1117111b3a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788105832; x=1788710632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z7X8vNXpfbUgmeDzjf4b8uyymeW/AhWIXS9gh5j9L1k=;
 b=VkAxLs97R5bsRlbNWulBp3eqD2giWFx0oVo2d6D6VcZONKdVTFaR2ki/5rsdTtagOa
 HkR9PgslK3MyEF2HKx0+xU+EbdrW5qVE2BGImR9Q4ZyWuuMvOYcE3LrrKzcjAsylVV8Y
 hf92j+ZMPurVg1S0htovXXFMZTGw6TfPb3ow7DvOUzTk1uigu1AqWMT1xnEApgIO6sqN
 KjA85lpCRvg6URyri0QFeBwfWp54CPax6O3FOvhYWBHT4U5gbT78U55+rPN4DKLPI8yI
 P3g8BTY8Zz/FZNs9CLgexeWyNPXfb9H0RW66nMnsAfvi1OH8Jdjtz5HoWHcS6QYmvFTs
 vPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788105832; x=1788710632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z7X8vNXpfbUgmeDzjf4b8uyymeW/AhWIXS9gh5j9L1k=;
 b=IGpBYz3ej+xhOotUXXycW1y/ZSKSkRDFHqvUuIdIR18cp7CHOYoKGbutk9rdQsxPIT
 +AQycEdsT/CMfvRA97Y6qWjN+yoXL4CPhHCHqf0hn4RdY55NMWKIHT++l8eFFz79BVEP
 nzPQnNPN16EFT2kRo/y5gr6MRYyEBEibMeCGN1OTLrP1dbeTrOeS9zTTRNZUmIflI5C4
 dDDRueCEI4/VT+q/SMIx6f03ydo7/enLP3InQmmKZx62NmI6BtkVnaPaugQYWSPDA7xQ
 ECIlY4PSFBkT7Hz5lzZm6Tv50sL1HJHzuD5kgKA1b5QWDDS4VOd7CqzuKUqvN/+Q0xUZ
 021Q==
X-Gm-Message-State: AFuF++lOR1nwgUzFTbXUBcjLO6ZfHvyww5mqgHo8JwWkcZJZYDAtmXde
 1sGqeXvu5cStd7MKCLlAHI3dYUpxYsDuiC7xl3fqXoEhWuPL/kH/WCkM6uPCgH7kq/2NqMwhRJz
 3MJG7q8j5G9g/zjKjgy9PlSOJHxjm27ZL8yREr817sRWCWt4IfoT/eCF+lqm11xo7CtAY1tkZL5
 bBXUM8Vh9IMWOwbCJIh/j/RbWjrS1RCQ30l9EebsY1KQ==
X-Gm-Gg: AR+sD12HpG+ccW93JfStS0AB9B+V1MhTC46xkvVT+Cbz53bQubOHyCLgNfiwVHBdTSW
 sMEWbA0vDZF1itep5RwAC87ticFPDAIJ4XeJjduXN8EVarnnOYB4BH5vLg6iFrBdESAZXWFi0Ip
 MEWGII0x5tIH1H8CvtgRaFqT2u3pFwhhaMyjFIfQCHCALFe+zuQ0eRylpAlFdXT+3je6HdeRTyS
 Jk7IxAj35ecXkXLflEk5IBtqEDvq5kAl/sfchxcgW/lggdHLPeBTWvVpgz0jFewdpR90gMra1NN
 UWY3hAZ1/v3pPwGgFMGwAfPNoR36yEtOBA4uQj+iWhXdITWN85SSNUIg/KofYqHUvxPlRGazfg4
 Sx9D5kM0RU5C28SjM7QE7IFNfY9Rlt75l0xzSvPNdEdW0cLa2jnB0eP7CAVYcQgfompQG3yQQuC
 qCaJ0794I6GRPXFI9yl+qux/NaqkK3H/bC9RslDUxpaYwIGr2i8d8T+FImMqFVccn5nFBUzzDRF
 uz7bYiF2EO0KKKRGXsujxzTKfdEwXgIcvCBRnRFJoQp9zZD4zNBRDdVTMdEe6E=
X-Received: by 2002:a05:6a00:f04:b0:84e:89a:b8ec with SMTP id
 d2e1a72fcca58-8562b58e469mr36905267b3a.11.1788105832327; 
 Sun, 30 Aug 2026 09:03:52 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8569ff701d5sm2455900b3a.25.2026.08.30.09.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:03:51 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 3/6] target/riscv/cpu: Add SiFive custom int8 matmul
 extension implied rules
Date: Mon, 31 Aug 2026 00:03:32 +0800
Message-ID: <20260830160335.3441069-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830160335.3441069-1-max.chou@sifive.com>
References: <20260830160335.3441069-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

Add SiFive custom int8 matmul extension implied rules to enable the
implied extensions of SiFive custom int8 matmul extension recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index af61a1ab48d..4263b7de241 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2902,6 +2902,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule XSFVQMACCDOD_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccdod),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule XSFVQMACCQOQ_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccqoq),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
@@ -2953,6 +2971,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &SMCTR_IMPLIED,
     &SSCTR_IMPLIED,
     &SSSTATEEN_IMPLIED,
+    &XSFVQMACCDOD_IMPLIED,
+    &XSFVQMACCQOQ_IMPLIED,
     NULL
 };
 
-- 
2.43.0


