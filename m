Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF49C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6uA-0004hv-S1; Thu, 05 Jun 2025 05:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN6u9-0004hh-PV
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:28:57 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN6u8-0003Pv-1p
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:28:57 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-87e7c306fc4so279261241.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749115733; x=1749720533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwm25hiwIg/8ckj5j8PRZomVpe15vvR6v2GT8eECMYw=;
 b=N/fYgmVu3fDgRIsZx05eGhFr7BZZPkgQtPDf3TAsYEBPkMF7y426EaITavkYnfIVPt
 +nrhpgGZdrmI8H8qOx5L0YE7vkDrMppcBlZ3kGTIFfdnpaRTHEqHQgTAxmuPDouZNGoJ
 CDsWqADp8io1orwyCxG8mgN0TeYiHxz/8V/aQbA6Ywr6eaowxXZxhUqs36B42ohypa0S
 EDQ+S3h9SJF/pzvt90PAGhbqcDKamI8OQYl4BACPpRTKNgZLCv61E6+Llt9Yw5r1NKod
 G5umKSV5q2sKNWavvlUt3JcsSabYEj81bYLYHKc3uBDDiwBiJUvU/TqpOrxFRk9UcJEM
 rOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749115733; x=1749720533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwm25hiwIg/8ckj5j8PRZomVpe15vvR6v2GT8eECMYw=;
 b=OHK5YS7Emh24ffVZgxVvaxSopNsOPsxWZUHklpzBMqJRNQ3U54WzsRhgTqK3FWxHkV
 cU2c4L+B8GbjxczH8VKMlyrS6/UPh492fcugdcZ1iA4hi2spgh3RXcdGlG7LkdRNvVL8
 pH0u2fm28uKe2ixbXQyUVkGP8JPG1AN5oJahpSGIUs0TRiJmN/14I9W59XslVTWuH5FH
 kycoUwUD3MIBGIAYSxyU1Aw6silZXe9HFPlpaw4m02kTbCgQrV6l2CRbnGpoVnZB8NIO
 H7ERZb7hMhRNrFsNJQ5ousoEcRUNhaRrRytgkvVMIPS8JoM7uYeuaif99/40Q900iiVg
 Pz4g==
X-Gm-Message-State: AOJu0YxP8zvI2cYgolcbHwBseOiNJNPmjXMu9F5+f1pEKJu/rL6cgrDA
 /636/2kJhzfc2Spy9JcGX/GLUJC9d6Xtebsuva1tK6b/LU28Of4j3aEE1XjoPivm+Ep6/Qpqj0x
 vdfLxWWI=
X-Gm-Gg: ASbGncsjtL5X3sGkp6niizjjJuIdxL/z78Hf+AxoqdVpWMUeh9WWcoo+GzClmFJPiQq
 Tn/ejFKly7ZAkEuasvVAJToi7SFqldkW+hSbbMVlKcRb/FWLRxzWcwbfO0Dhiz02TCslN4RqTL2
 BVIlznqoVndCvDI/e9AgUjAGcXFJI5hIcYw6geoKCiNTdrMXAJfjimDn68h9l8ODSiwt+Ect3fi
 I3o7Nn1+BO5FW8IbDuGdEN26xN67Zz57TKuKq4fAP7m+azPiOfzKyk3E6kHcgCq/L6mFZ9FTvxP
 z+9Ev6d+wbVtl+hGjVXFKI1s6J7Mtv4TwHRu8AxUfQb62XUGAD56hpuoztoB5DbRIcZnzxopfrl
 DM051
X-Google-Smtp-Source: AGHT+IESIyMTwIWdJjk4wyRtRFEA23cCMOPO4y9ohQKLDRt3+dEyiomh7Gq+Q95EuETGYiYaYztFug==
X-Received: by 2002:a05:6122:d99:b0:520:61ee:c815 with SMTP id
 71dfb90a1353d-530c73f5f10mr4641917e0c.10.1749115733464; 
 Thu, 05 Jun 2025 02:28:53 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53074bf86b1sm12311772e0c.36.2025.06.05.02.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 02:28:53 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 2/3] target/riscv/cpu.c: add 'ssstrict' to riscv,isa
Date: Thu,  5 Jun 2025 06:28:35 -0300
Message-ID: <20250605092836.1383882-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605092836.1383882-1-dbarboza@ventanamicro.com>
References: <20250605092836.1383882-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x936.google.com
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

'ssstrict' is a RVA23 profile-defined extension defined as follows:

"No non-conforming extensions are present. Attempts to execute
unimplemented opcodes or access unimplemented CSRs in the standard or
reserved encoding spaces raises an illegal instruction exception that
results in a contained trap to the supervisor-mode trap handler."

In short, we need to throw an exception when accessing unimplemented
CSRs or opcodes. We do that, so let's advertise it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 406 -> 416 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3c1b1dca47..058387ac48 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -217,6 +217,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
+    ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 156607dec45b0e63e5b3ebed62e81076dacd80d0..52a4cc4b6380eee3299b965271a39e9e01f5a698 100644
GIT binary patch
delta 52
zcmbQnynvZ2$iq2g0V4wg<L!xD2CR0Bj0~n5?U@+aic5+zlS?MsG3rguW>n@VV`N}x
IU}Rtb08<(Z?f?J)

delta 45
zcmZ3$JdK$v$iq2g8Y2S(<Ex2W2COEGj0`#(?U@)SdogNHE@M>U$YEq)C}U(`008kX
B2|xe<

-- 
2.49.0


