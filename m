Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F8DD374A5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RsQ-0003AK-FH; Thu, 17 Oct 2024 10:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1RsO-00039R-8m
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:21 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1RsM-0006yR-Na
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:20 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso716593a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729176797; x=1729781597;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8U2uO9qd5IodOHkoxi5qOiNsNpKEr6lwWDwDi6hiUAM=;
 b=P/DPa+6eggrnluSy1MMU4IxeTaiFmNdZO3usIxhmUaP69GZqGS+UwQQh7QCCjtsECY
 +zg+/8u6aAi7vZDixkjHcdx0rAaZ4DUmOCPEJx9KB2ayeyMPB9c3FsAPl7qGcuHJB/is
 yjKr9BPaNtxIDcFBF9x8zGHlOKWbKVFxzMZMzZotASXtuEHcTz4MQNHd6GvNuCb0E5/j
 pHx0kaxii+dzkv1CQ4RiC0xTyCijXmB2jU/FiXKehR+0O7cT7xJ9nbhLxa8/H0vFu1Vt
 Uy4RlpudKbV2vVhL6XIo99/7LKBd+1AFNHBbGyLy3j8Q3TBP3gYte9/TL7fZlEXn/S1L
 MAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176797; x=1729781597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8U2uO9qd5IodOHkoxi5qOiNsNpKEr6lwWDwDi6hiUAM=;
 b=wcbSJsTlppeczw+QDeskgNOx0815npmCzd6Qur1N6SzdwVEIleehgx6+clu8oTOTBN
 s7h8wryf7mqnisaiM6vaSdpC88niHUSiwimqBX6oTyuwRIr9YK6uqf/02jWqDUjhupR6
 NUvuzaHEHZhm9vX9KTXZhT7xwLiTnUgZ1xlfMGIbT9DuJEyBc7xu8VN0d08Jmy3TpTfC
 2oAr3pQ5R3duBxICXrpo3nwUlSVdZl091+lqIlJz26HS48KSkqauIn0ByXKOkk4tbAKn
 Qf7V2QAJnpaf7yQy06w36gPdJSvNVPueWz6szSHVRYsfsthpPitqAzujO1fPNl7GLRoR
 G5wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA0LfENR/LwmJqEm1Lde5/H/8kbv34IfSCFlNp1+lUzZYJ+Oj7pf8yv875+GS5IL2Aa7Lj1XUIDlUt@nongnu.org
X-Gm-Message-State: AOJu0YyNFAMUhihmZFgPXgzU6suO3PHek/52uxuVpBM2Hl6t61tOKLe+
 XMH7+Q15KcBuBX4aeNVZeb4ZYyNpzf7i00g7yDa7Z93idQ54SHstoz80nZnI0Lc=
X-Google-Smtp-Source: AGHT+IGdBSTXg+mry+zVHa3vNQVHkpcMmvB7181D5FtKONcEnB8GgcMl5i8g+fu2XMrP8lhm8tz2pg==
X-Received: by 2002:a05:6a20:8829:b0:1d9:a90:8879 with SMTP id
 adf61e73a8af0-1d90a908937mr7134563637.21.1729176797522; 
 Thu, 17 Oct 2024 07:53:17 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm4859580b3a.21.2024.10.17.07.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:53:16 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 5/9] target/riscv: Add Ssdbltrp ISA extension enable switch
Date: Thu, 17 Oct 2024 16:52:16 +0200
Message-ID: <20241017145226.365825-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017145226.365825-1-cleger@rivosinc.com>
References: <20241017145226.365825-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=cleger@rivosinc.com; helo=mail-pg1-x531.google.com
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
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5224eb356d..39555364bf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -190,6 +190,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1506,6 +1507,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
+    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-- 
2.45.2


