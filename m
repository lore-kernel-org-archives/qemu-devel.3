Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E090C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeM0-0002TS-B4; Fri, 04 Jul 2025 07:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLu-00027f-J6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLs-0003Bx-In
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234d366e5f2so13002425ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627587; x=1752232387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76WPPZHQq4LKV1s9IuHTeixJXupaUC4s7ONmVql1/4g=;
 b=fSHGoFz6MyQqL8bBnOEEPc8ENc4sOzu1brX981p5C0wlJv8a1AU115JBsqCzlV+39g
 RagsTfJF9kAfa+LiJSeXPao61EQQXqw0BgIrqGCtU/JDwvPg3OI1/iNFBjA+A//QN1IQ
 mak4razsm7IdUZaviUza7RYyuoLicjhGJoUBlXGjfYIwwOChD6JB5VR+d+Uf6z8fMGPw
 DB37P04Y+QGGAfUcUZjAq6PQQn2iQXAJnu9FGkvkKhcq/rzlxZei3bteI/lud6mZf8z2
 NIfJmmuxQaFZlT7ABZpotz/U8X20RQaq0MI3wBJ0XZYaNK3zJdwCLZh4TATWzOUnkwC5
 cGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627587; x=1752232387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76WPPZHQq4LKV1s9IuHTeixJXupaUC4s7ONmVql1/4g=;
 b=Mfv4MMnLz0KAIzAICU8cG7W08Sr6ANoAXIiBg4FONtw/lQDHMWq51r3t9DDEO2ovWL
 8Y/fZvD0/Bs8+8sM++/5dncNdCEfuMXKQbx0C+bOprctDQ9AleKlOs2ycClo3C5KHWtc
 TRzSNw8Jqm3dLqcHoqMfVFeUcD5nQ/VmCMQk1oFO7lY7FhH5369lm/Pf+cxVVW8yLk8F
 29DRgkPZEmsOMgEIut+gOQ+enbS08klUuXIsuVMMevtw+2xAGJI7xhHazfTas5nlG4wv
 ojgVRgNEPvGnH5T7HioCEX2vYX/1t4PpHFSf19QEin+vu4rEYZxdxUoPkGWZ8Jab/1dt
 Tacg==
X-Gm-Message-State: AOJu0Yw+i7Wadjpd7Z7SP6RlIOp9Pdd+E8Zk0URL7sI/hi6PFzuXMXLq
 4p9qnuJbjBmHd5vrMH/kOawEb3LCDxAvppAV/l/+nPSD7KK9Q273Jq8B87DM3w==
X-Gm-Gg: ASbGncuUeJLt78HrCkx1gOBkAnWGn8nRNPEaUpOojcT6Tv2Cgvt4ECZURDDLzWcA2DX
 vRm68JbffhPGfDoq4aAfMVkRONYSKr4veMu094/rOXffXbQWFqjHp7e7Fq6ikyYzgOreMo9O42T
 sZpRCQ1JupmdzLi6O+OJsXJ6MXCQcUO5RFFhwwlyUaKydXKOrBP2P4nRpmnNpZiSmt8Br9AFJ3x
 fUyMd/Yr6ahbSYiDk4mjXhsOQwgC47fw8LGxITzF+4ok2OlNkLFBQjsxtp/JtGrZD2RaYiDTAv+
 SI+Y/+5kM1LSgAHM03eDpdGw823okjaDwDtJx4vKv3TOj5KgdG1IcnNmuNLdf7kk0P03wEpcDSG
 7L5U3a2+GvA4Dh709Kebv7qkrzGa41tBD8QOo+ZhYWzDt+jvB8yxFJlFFIgA9ZpuAmFM=
X-Google-Smtp-Source: AGHT+IGnxhfk9nL9iM+cynY9XgQB8O9vtNY521rMyUjgjvjFypr8Z4FW4izA3Iv/m1Eae0tid12G6A==
X-Received: by 2002:a17:902:ccd0:b0:235:f078:473e with SMTP id
 d9443c01a7336-23c875aacb4mr32980925ad.43.1751627586986; 
 Fri, 04 Jul 2025 04:13:06 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/40] target/riscv/cpu.c: add 'ssstrict' to riscv, isa
Date: Fri,  4 Jul 2025 21:11:39 +1000
Message-ID: <20250704111207.591994-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

'ssstrict' is a RVA23 profile-defined extension defined as follows:

"No non-conforming extensions are present. Attempts to execute
unimplemented opcodes or access unimplemented CSRs in the standard or
reserved encoding spaces raises an illegal instruction exception that
results in a contained trap to the supervisor-mode trap handler."

In short, we need to throw an exception when accessing unimplemented
CSRs or opcodes. We do that, so let's advertise it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20250529202315.1684198-3-dbarboza@ventanamicro.com>
Message-ID: <20250604174329.1147549-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 406 -> 416 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b4e7eff331..626b0b8b26 100644
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
index 156607dec4..52a4cc4b63 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.50.0


