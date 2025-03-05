Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72DEC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpe0I-0002nv-EB; Tue, 04 Mar 2025 20:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdz6-0007br-F9
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:51 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdz5-0000Tl-0Y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:44 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223594b3c6dso108683905ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139741; x=1741744541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXG/wl75wWZct8Q4+yC2guW2Q8+SpXtJAlKS1h2kzlA=;
 b=l3VAfiDEVeM4dFINqfJGmk4FouBTKGtWynKs0qbHnwXGChnv0HYBdbnBZyEQLWycX1
 XkMDIiKxI7kRhEyddc0LbfQVaP610ETrhPMdF7E//ogTygfTHHx1bZYN2iusSTipukQp
 aUT/V8OP9HE/kD6n1QJk8qTk7y5jKHDIlMfzMLG7RqFD88tPURhkJ4oRNjZMG8/bDnP6
 tKb7j89iZw29RjTAjTaXtbvdHMwTS7B9KueO//Td5uq1Fh1e5sfxq8nPQoI5YJLLgDMk
 gJDbrIu1UqT7Ute33eq9fBntjTjL43OA+m7Vq1iiw+Sc9T17H5h+f+DMh07S1PhJ6gqa
 KEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139741; x=1741744541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXG/wl75wWZct8Q4+yC2guW2Q8+SpXtJAlKS1h2kzlA=;
 b=rXE+cj5T2cSGh2hr45/pgmwFrV0/oeM+CYLzR037cPTYcRyF2pxD+XQwnCM108+NVK
 HguEVM55QCAWaNHLyg+3Fr3Sk49lBG87bnpL6fPqO+5qQ6TvMDnKAuIFoXKX1RFBo3RK
 C3JF3Lc3ZNZz5FRETa7mRfS2MqgR/RxF6VwBGBtOWX01n2e5p2lP7PDJPUF10DZmtqYN
 W69lHmfkCXOE/sBcXqtdQyIQuX6b2zd6R67jSjb4eaS0CrnjgtWY5zCzNyHaBZUlM52Q
 W1aKSwcVD7KdKlBpycxg+Lpb4kgKrayWpTv4153u0gA7CKMF/ctUGI1bfeu7/tMgCqFX
 /J/w==
X-Gm-Message-State: AOJu0Yy2vAbfwRxF5gaFQnPwkFgSLNLe1wkRkcsiPujMagSG6khwHF7i
 sTt5FMmi8tITSvZc0ku5GRHVFeS+1yuFgZk5wyp4A1hi3wAVED10K42Vkx233JA=
X-Gm-Gg: ASbGncsgOh91w0poo3Hyy1NKYEEtaJVJB0k5GQlcxalZexdTiVYyCRdSh0O9xR9yl6P
 ad7R1g+MOLwp0df5ftCAT27bGHxHv+aQa9pYRwI/XTaqxtqKMOxnAbK/em1E70liIM8C8xrlFJB
 Y7NFUanhZbzgvb+e8w4vuuW3IGd+oT+XU0X8BgHsEZfQLSM83cI21/TQrys3KIFFsABRTHQAFpZ
 PRgjbLYfNkza4ucPGEFo/EgyPs0Gu0vuV+efQFKipvjbTfKAolok3NA4yieJDG58s0lJ7upsUEX
 YuynxalQfbfPW0bR/ol+KZ5KFYbK6xy9spMUjHbFRZwN9F2Yfxfh2U4JPMuEBHzR04BdVgH9s8x
 vDCVDsRiwZo81AaXOxHXxDOTdHgUr+8Vh3WtCukThxCbisUIi4Ow=
X-Google-Smtp-Source: AGHT+IFB6kbq5G3KU0UnwInKMGhUAeeFrIBCFokWVQB5GysbU4Y1HNte5wg2F9q+ua4ld3pJ/zZWWQ==
X-Received: by 2002:a17:903:41d2:b0:21f:9107:fca3 with SMTP id
 d9443c01a7336-223f1cfd17emr22656545ad.30.1741139741443; 
 Tue, 04 Mar 2025 17:55:41 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Quan Zhou <zhouquan@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/59] target/riscv/kvm: Add some exts support
Date: Wed,  5 Mar 2025 11:52:58 +1000
Message-ID: <20250305015307.1463560-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Quan Zhou <zhouquan@iscas.ac.cn>

When the Sscofpmf/Svade/Svadu/Smnpm/Ssnpm exts is available
expose it to the guest so that guest can use it.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <303616ccad2b5309768157b50d93b3e89fecc9cb.1740371468.git.zhouquan@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 471fd554b3..e436083dbb 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -321,9 +321,14 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zvksed", ext_zvksed, KVM_RISCV_ISA_EXT_ZVKSED),
     KVM_EXT_CFG("zvksh", ext_zvksh, KVM_RISCV_ISA_EXT_ZVKSH),
     KVM_EXT_CFG("zvkt", ext_zvkt, KVM_RISCV_ISA_EXT_ZVKT),
+    KVM_EXT_CFG("smnpm", ext_smnpm, KVM_RISCV_ISA_EXT_SMNPM),
     KVM_EXT_CFG("smstateen", ext_smstateen, KVM_RISCV_ISA_EXT_SMSTATEEN),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
+    KVM_EXT_CFG("sscofpmf", ext_sscofpmf, KVM_RISCV_ISA_EXT_SSCOFPMF),
+    KVM_EXT_CFG("ssnpm", ext_ssnpm, KVM_RISCV_ISA_EXT_SSNPM),
     KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
+    KVM_EXT_CFG("svade", ext_svade, KVM_RISCV_ISA_EXT_SVADE),
+    KVM_EXT_CFG("svadu", ext_svadu, KVM_RISCV_ISA_EXT_SVADU),
     KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
     KVM_EXT_CFG("svnapot", ext_svnapot, KVM_RISCV_ISA_EXT_SVNAPOT),
     KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
-- 
2.48.1


