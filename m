Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B5DE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm9d-00070d-6t; Tue, 14 Jan 2025 14:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXm9N-0006To-6y
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:00:30 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXm9J-00035u-J0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:00:27 -0500
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-71e181fb288so3267721a34.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736881222; x=1737486022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6vq2sosVGVcjMUAGcKq1UGGLY86FU4I8V25OFJTASo=;
 b=Fmg/I2rTFWdhpEavlmPyjewO+01OQasv3NvVsEKASiz1EFfLAmkEpuS1T9Fy/7aIoJ
 m3s2SHITFiKOQOE0Th7x6YrTGVJMwT+HEDyIwpA9UoH3KM5dmPXJsSYKMJ/k3QnUVrAR
 Vq6hZAgcc+RtG5gdD6nB5/DcrasBeTyxQscZR2sPpgF4WNTSiU6OGYjGkDKkXUdMS9qU
 UfwbrSXry/l3vGC9SGW0/xY6DoYq0mFQgnV3+a7za0E/hUuE6VGlb8xxxFpDtt74fGEb
 g6VZh7Jhx2Ohmt8u50lkQIHxOxEq3ga4ZD8tekz3D04RZ1OCZPzjDf6DhvHQxmMjcAKa
 T/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736881222; x=1737486022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6vq2sosVGVcjMUAGcKq1UGGLY86FU4I8V25OFJTASo=;
 b=f8VNSblEV+JPjjZNjzQO8GNmO+JPwxJogQHkkGd/zbY6edlzbSAyQMvGTD3WO83ScQ
 ungUXpxKBtNHQFqlHcwutkshDXs1+fSyj/rAwQ3TK9AYR/sPfU9MYrnz30/OF3m+hy1R
 dqwDK3PKjytxWWMbBZZ3Wq5So2aDUBRS5cEEnHSq0PyTp/8Q5GOhs7EqGvzhTzLh6M8p
 gdEI94uNpBOtOOwDyEXnyTo861FeBHUA+P6p1FxLvGlDKF6jzxxHYmKyZ5m+PjRhn/XM
 caSqVTuy1drFOdG8YMI4fQPgj+YEHMO1kztUH2PHfE9P9Vszf0Gu8Mzqnw6wnWfzJESK
 GSWw==
X-Gm-Message-State: AOJu0YySGPhKUEiDgKxgjlK20GKOjZfBda+qJNrBe3wVTh8RBZ1/yTO5
 EjWFDq8Sc/qGjg0UBX6je2JH06saO31OKeua+ZbA4PdmQUW71fIwjE44cRw5vkppAyftuH80i/y
 +2VkBEw==
X-Gm-Gg: ASbGnctyZ/KwPZOcJ8fBao6y9tworUUXqT2+BSnZzNJMuVTD5batY5cuDVLRL6fYrzT
 wBCWJ76gXi+y4pbY8/CegXipBXfekQk+aRUEZv50S5XvwzdQqxGFJYRQXqNaPPpt1P202PL4vKK
 +8rxJKxzg4Qh9XURZL8V6MUSz1/o+j5Zwbu2rCOQY+BlbTVmSU7cRlyIEVn0hqdSr9yK0jugEaq
 ajdPXbJsYGT9Yq/ybWo4sS/OB6z+kVZhWjxZTMuk19EY8lo/25kbOM71h/iF26EVQDIx0wizwbp
 v6ep+4sRNA==
X-Google-Smtp-Source: AGHT+IH+9w/4FHpO9Zml+ejdTgh0xHG3lBqclREnDR9vKs/fwhmoI9q6jgY/8X0u1xHqbvxYTaqXgA==
X-Received: by 2002:a05:6830:6107:b0:71e:17c1:45e with SMTP id
 46e09a7af769-721e2e9a53dmr22239436a34.21.1736881220883; 
 Tue, 14 Jan 2025 11:00:20 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7231855ee1esm4875647a34.32.2025.01.14.11.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 11:00:20 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/4] target/riscv: use RVB in RVA22U64
Date: Tue, 14 Jan 2025 15:59:59 -0300
Message-ID: <20250114190001.1650942-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x343.google.com
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

From the time we added RVA22U64 until now the spec didn't declare 'RVB'
as a dependency, using zba/zbb/zbs instead. Since then the RVA22 spec
[1] added the following in the 'RVA22U64 Mandatory Extensions' section:

"B Bit-manipulation instructions

Note: The B extension comprises the Zba, Zbb, and Zbs extensions. At the
time of RVA22U64's ratification, the B extension had not yet been
defined, and so RVA22U64 explicitly mandated Zba, Zbb, and Zbs instead.
Mandating B is equivalent."

It is also equivalent to QEMU (see riscv_cpu_validate_b() in
target/riscv/tcg/tcg-cpu.c).

Finally, RVA23U64 [2] directly mentions RVB as a mandatory extension,
not citing zba/zbb/zbs.

To make it clear that RVA23U64 will extend RVA22U64 (i.e. RVA22 is a
parent of RVA23), use RVB in RVA22U64 as well.

(bios-tables-test change: RVB added to riscv,isa)

[1] https://github.com/riscv/riscv-profiles/blob/main/src/profiles.adoc#61-rva22u64-profile
[2] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc#rva23u64-profile

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                |   2 +-
 tests/data/acpi/riscv64/virt/RHCT | Bin 398 -> 400 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b187ef2e4b..6fb4d5f374 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2351,7 +2351,7 @@ static const PropertyInfo prop_marchid = {
 static RISCVCPUProfile RVA22U64 = {
     .parent = NULL,
     .name = "rva22u64",
-    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
+    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
     .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
     .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
     .ext_offsets = {
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index b14ec15e553200760a63aad65586913d31ea2edc..13c8025b868051485be5ba62974a22971a07bc6a 100644
GIT binary patch
delta 53
zcmeBUp1{l%<l!7LfsuiM@#{n`13^7TMg~>JqB1j+%-qDZl;ot1UQ&#clNpsc(ij;S
I3K$s}0ARKZK>z>%

delta 52
zcmbQh+{ern<l!9B$H>6Im@tvcKtP9)kwJyAsLaeHGdD3UC3&N_6yxMHMkS6EMh1pF
HMg|4|IwT82

-- 
2.47.1


