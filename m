Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E041E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEYQ-0005xL-L7; Fri, 10 Jan 2025 07:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXZ-0004Fx-EP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:55:07 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXU-0000zQ-DG
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:55:02 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so15364145e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736513697; x=1737118497;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Intj25dUMjfWMrsTWGApzMX540YpGGUYsQtvJQNbXsI=;
 b=yfB6xj1hMcvtuCbAhrLJAgL4gCiCGbrKXgej7iNY9McxQ6J+wZu590gfOeUUjWlFSQ
 XiSOs5ocrHRZucc7VUIK1rS35W0BsLiMVMZNKtP1mhr6OSBhnZJUa8JwVxSIw/nWGWo7
 5oWzErxXoIoNLXVUPYS8EcRRnIZIZAaw3x9+sbakFcbjADdSR9Z7nMJMdNyPUyQsz9Gp
 eJP9g2AAOOI7gmMbLwusK8153WShU1uawgeNxOKa2UpTbaz7lDSrqJPQJQncvK84irci
 dOOvRchVnBylHG9f8DAKDqiEqxuIDi+Zztqs7KLBIwp03sbzX1W3FITFbiPB2ZZgbNiO
 ANeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513697; x=1737118497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Intj25dUMjfWMrsTWGApzMX540YpGGUYsQtvJQNbXsI=;
 b=V5j6B/+rDFGn1nYAr8DC5xcJwiYoftyrF4LBmE65vuOoVrCCr53DalJMAFNXnZNzev
 Xwgj/YQDiyd92RpdyijfZmMAtipwgwV6+WP/MAqtQIbEMXhiD+1my6VCx5GD40HKj72z
 m7zAaxiysB4hUQxghxeIhvxfpxvd8ApFNJj152B1BfsEyJn8cGhhE9g6gAWK+rDRFAJo
 Dblhg3N/4JKGbQ5yOl6XA9mnsqIoMMHqGCFCzlvfWaxjWM8rDFvA3EKgK3cO4TZavXs3
 b6Ih7oxTEZJQ7JL7+ytYl4HpiEX/eS7NcfwUBFhLDU5W2JVU9HGhaKGs0RSr0wFiajzy
 VMOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6jErXbQpDFet1GWgA7CRdI06hNmTQd0oDaXETv2SwskvdQGAdaxSzwRCVbPx6W3OVB5Z0dbSzxr7S@nongnu.org
X-Gm-Message-State: AOJu0YwcbbHboT5T0vfy9YrSKVoS3ad+zUtfLjPPFuaH2d/t5loFsV2R
 bCz5NsLRzkuJxwK0l/NcrBZmYNTtxn2yFKrgbSDgK/k7+Fgt9GUShRVJGn9/GaM=
X-Gm-Gg: ASbGncvyJohvFIUkdCrhiUgcz3732l+EtyqyjC2jAyr7JvzLDdu/rmIDMSYuS6UUkhm
 v86R1IwgjwNjciRG1rBXe1OIZW3qRnww5+bn2tblhOH1ezRFrZwgHpwRunclO3vJW3QyA68Zbt2
 82GekzBV+qmDB6MgOUaUrp/3ggN7hdkoav/+EBAyHgBvttkWXxwCmQgTosoH7Bdd65AVLj1pFvY
 dFO2JJNjCYlaDUWS+FPwnGBXI7vxucffJm1BtZlJfViJLy2EXmGj5OZ+w==
X-Google-Smtp-Source: AGHT+IFEWMeI/gUoG9bum7xcWHg4H5NRrxSpWqF7gjzGhhTqE6tycViNzYwVPjLSEy2NXEYlxS1K3g==
X-Received: by 2002:a05:600c:3c85:b0:434:a802:e99a with SMTP id
 5b1f17b1804b1-436e267821emr96007805e9.4.1736513697256; 
 Fri, 10 Jan 2025 04:54:57 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm4548921f8f.97.2025.01.10.04.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 04:54:56 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 5/9] target/riscv: Add Ssdbltrp ISA extension enable switch
Date: Fri, 10 Jan 2025 13:54:36 +0100
Message-ID: <20250110125441.3208676-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110125441.3208676-1-cleger@rivosinc.com>
References: <20250110125441.3208676-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the switch to enable the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5540eb7f63..9e1ce0e1f1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -205,6 +205,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
+    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
@@ -1628,6 +1629,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
+    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-- 
2.47.1


