Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60945C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxM-0001x1-IW; Tue, 04 Mar 2025 20:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxI-0001mC-T4
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:52 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxH-0008Pf-5F
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso2325125ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139629; x=1741744429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLdRW22sROzZ5TFnPkvO1AYAOQeJ8pmp1wpXeyxPDUQ=;
 b=UwQA7v665UgZJNTYLbaIcNEMPybdyPHRcZ82P0DjC3OePyWGBUKFIANLrNHPv2oeh9
 XcPKadN2bQn1lum8MGTsqYOR2oppZVUTR19p4oEvEqW7Us43q4SH20mBqSHz7KQwjO4Z
 2cglEIkHmKEOmWCgvz39v1i37qkO1rkUTMsF5oKKG29n76wyZMoD4o0DNcSqoFQ2Be7q
 MlmHYTj++LpiFipYLrc2kwnykNj18oQ1EfsIefpYzjsrZOCyT3GQjVXNEMatxN0mzTRa
 xWDqgKKJdVu5vt43K6mydzuu5QVhwoSUVJzQRZW9G40qXg6tVEkKPOpxORz6i3kbCJJO
 ixvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139629; x=1741744429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLdRW22sROzZ5TFnPkvO1AYAOQeJ8pmp1wpXeyxPDUQ=;
 b=QzoGsy686pUV9YG4ni12cepaMmmy1OhA9P1usie3qDHUptgivQzK6AfKp7pbMJAtxn
 mnQicQwOhYzy2M//AFSaAxYP4gE/fn7O9nLjAo0nQQ5hoUrT9T0oi0Al+cBJ/QV7Omvd
 Meab/+Gb1kPPzOew3Ys0Wka2EwRxjxWRSYEhJRU0gJrtSaIEfZ9DE8GkWytZUnOx5HLS
 mlVdBYMHxVbUJxxH6WqncyzuEM/MH9z4wOQwQ1ct0MF+Bumbc8wmIYzQLFDqoHw4onIT
 Ix963ahiihaicgVjSr/1mvbL8nPAu42C44gD+p8yiw4EWc0sMNRpkmkuiA7J/dnwj1rB
 ZjDQ==
X-Gm-Message-State: AOJu0Yz0YsTNAo7go4gxok5ugJW4OQpCiPlp7g7svV9/o65wcYivnTcA
 LEHKUE1rI6vQMiELFsT69yFseZ55tWPOxfxBFa3n18LNNde0UR4y/WGUKAoeOdU=
X-Gm-Gg: ASbGncukxV6k+hqTcfmnCSTHyx2UIA/ehVg7N8thnDAtrO9/pAauiqu4yTzAwgzC48d
 mOUqPO4t5FjaX6Tha7fFF1bNhFzZmXpTAH7BD6n1JTA4Nessxt8FF6iZcej9H+2NfgDkUxaONer
 4j2HlMJMOrIx8t+gRNDKl2OH1ZappRHEx0CxoAgSWC+tm7cpzFFaNGLgItN3bK3bUVLpt2uczLA
 ScbNTCTeB9NnAr0e8XjcwDy8cLlSgVgxHEL/XD5lEBKpEAwz0Q+QM2e/GOwEGpu2nBCuGoNSD+W
 7CE3MpZ9vR+ZfVCdX+f4zT/GKRxUMBieooNvtw6kXqOSe+hDLsCx0ixpKhogSFjF5YrudIX06C9
 x9NU5oHukWJoz0cwxZdOmvLcRmrQefJCubz3bt0BP9zc9PHnTlgM=
X-Google-Smtp-Source: AGHT+IGVwi3SfSICE4Q/MJLSV/D4vUGtnc7QgTN0QdYpx6SR2rgLlN0ouijH8O0BIvyP+j3CcCUbfA==
X-Received: by 2002:a17:903:1986:b0:220:cfb7:56eb with SMTP id
 d9443c01a7336-223f1e2905cmr18628675ad.26.1741139629472; 
 Tue, 04 Mar 2025 17:53:49 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:48 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/59] target/riscv: use RVB in RVA22U64
Date: Wed,  5 Mar 2025 11:52:20 +1000
Message-ID: <20250305015307.1463560-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250115184316.2344583-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   2 +-
 tests/data/acpi/riscv64/virt/RHCT | Bin 398 -> 400 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4f5e13a759..578bc95652 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2345,7 +2345,7 @@ static const PropertyInfo prop_marchid = {
 static RISCVCPUProfile RVA22U64 = {
     .parent = NULL,
     .name = "rva22u64",
-    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
+    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
     .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
     .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
     .ext_offsets = {
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index b14ec15e55..13c8025b86 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.48.1


