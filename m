Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFFDC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDWE-0005sH-Nz; Thu, 06 Mar 2025 10:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUc-0004GQ-Nr
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUZ-0006i2-Kl
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so7468395e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276233; x=1741881033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OQjx41PTEPR3Oc8nlUx+93jp4JXIcOc6sQ64pqHRe5Y=;
 b=gIm7r9vEoBs5PUkxyhlS4igje5iklfX7uVWdQ/oWdP4OdTb/cVzdGkwBwtrhoOqXf0
 SvNYjuwWJMIJEKR1RsH4uRS2tC2LonwsX0f+9kPmj4fNSXX4A0NcNtWspqsLGZUgmlw6
 9ruNzASyprg0fi5hvn6SmHrkoN4LA+d3knDdztH2gDmDCN4vnzZG1hupoxTA7uf984Tb
 9duhXTdf/xWTKF9iXFT5pKvCLDHUNFevO/XWG+Iw+tTqS82fRWRW9DQqArBw9DVFtvhV
 IfkC0k72LXLojlb6f75JrqrH28ZSUjf35B1AYrisnGt+0F/DdSSDgaXJ7KJZaBwfz2wV
 uYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276233; x=1741881033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQjx41PTEPR3Oc8nlUx+93jp4JXIcOc6sQ64pqHRe5Y=;
 b=oqAe9pONyp6NeoVtgtKH9a476S2m0DiOgz+wcnT7hFBwUh2nZVa62mxbinrN/MrAOO
 vNOXcJ1ueuI/qYiMpCQBGrkBIAK2fQrAnpUCXrV6HcqYTy2M+RlMSozg+kQa4WlhbkMy
 MHvpQO03cOmT4Ru2L+C2i9hMBp8eDJp/XamIQow6CBrfoLkpPHALdAAn6YXY7E5K7loD
 apIm0/PYHD2ljUkh66FmBa1Xu+wpi+wlsbgVWPvjbO23SYn05KtSuwkQWgsvBq96UG4H
 H5uXJB4y9ndOtxDEkZzy3oqokOZ81iLbgBQfzEtT1VC+rEhpmd/Pz45r8kNN0ULxiU+K
 llTA==
X-Gm-Message-State: AOJu0YzQbzOsEe7n3zQClWcHAQA4toM9r6bS5cAeO0NGN9o6kLMPHatY
 mYJh3D5saUfxMCgQYxvU7hEF7U3a0tdIweCVf5FXwKLQVbARZcAQbGWePkyWAVViuv5sH2JXrUB
 z2Qk=
X-Gm-Gg: ASbGncvwYp945WDsohfJ7CizX8u4AKBMkQEWG4o9j674/KZcomBFhpMEpyhV7LsM9j6
 vj9Dh0+4xFYhpAFBuRi3dZCVQw430EbrwhUxRD2gAxY7KU7mUl5OUVXH/njNe1nurh+yBjS7pnW
 04s+gBFbiTDtv7xOcNoSpiO3ZB4OSy21Fm0PG+tz+g+s8SLYYinEU/EDzPJo9AngPGsTp+sUp3X
 7W3DJ+hogbFuKK4ph5RExqyqn4ie2X6MHtM7iWzkgQDy+7D8jnHoCJ2K837C1t0in2AASn/H01I
 zeVhKDQJvAA2soLHPd4hjyB4PGTMBW91l5l6GwLAl2P5CvN+ur6gZ8n2jkF/yOo0qaNtwE7wTPJ
 2qLFIPUueQqzrBf+6kGY=
X-Google-Smtp-Source: AGHT+IFqp1IauRBfCHSRogXpiJoxgIFdAjiPg7dPVSaIbLclB4uYK3v+Aq4tekzRRJ8mPURILCp4Lg==
X-Received: by 2002:a05:600c:35c2:b0:439:8bc3:a698 with SMTP id
 5b1f17b1804b1-43bd293f637mr64962945e9.6.1741276233543; 
 Thu, 06 Mar 2025 07:50:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435300esm53634645e9.29.2025.03.06.07.50.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/54] target/microblaze: Set disassemble_info::endian value in
 disas_set_info
Date: Thu,  6 Mar 2025 16:47:21 +0100
Message-ID: <20250306154737.70886-40-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210212931.62401-5-philmd@linaro.org>
---
 target/microblaze/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 13d194cef88..d5ee1244cad 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -224,6 +224,8 @@ static void mb_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_microblaze;
     info->print_insn = print_insn_microblaze;
+    info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
+                                     : BFD_ENDIAN_LITTLE;
 }
 
 static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.47.1


