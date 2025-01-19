Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E3AC02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJs5-00014e-Br; Sat, 18 Jan 2025 20:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJs4-00014H-Cr
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:00 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJs2-00039z-TC
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:00 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso7008492a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249177; x=1737853977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oe4ixlLoNm05J1Uam0Ub0O9tzxvxA5rEYMLk9bmud0=;
 b=NuBf2hVtJjPSx3XfCw+ah/ZchbRws236ptS5F4d9gKndHKPTN7xsXvbWIcgAeVkxvT
 D5tQ38UQJCE09eCngLgCw4+HnUx8KYHpzs5mjgtIR8L+xI4i5TqKgSAaQReI1d7WJQMQ
 q6odp9QMhPGU2G74p451lMATX9Al9Hh200yHIKlQIxwsqr2FBvHkDqTWF32K9A9UU5Zy
 DLmw6m4pevTlo6Rcqf3TcT7swpWBArZmqR1K7ZiiSVipyAn1ciTV58ccAp5wAucHNpqR
 zmKWRQJ2yzV6apgKHTXvVw6S6cDRS+UsaQA0SrqJt0vw0uBxaLWqoj00QNqZPXW5Rh4E
 fGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249177; x=1737853977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oe4ixlLoNm05J1Uam0Ub0O9tzxvxA5rEYMLk9bmud0=;
 b=YG4ee6/pok+6HvOxBpsx3On7uhr4XrO48C2Nu2iVJT8q2TnrqQyjOc+k63LB9qFVSE
 9sYes0ZLjUaeiUODW+3ctO4v+Nnv+uZR7hcxbGhfB+PbpV37vLri7aeAm9DFPLMKMY7B
 DEUvlwVfsMKOLclPYPKgo6hjTZHqa7LSS+UtDradKR2ais5Z4FIZf7HY6vE1+3lQYO98
 FFvOeoh178c3eiWclSF7YhoNBg+wF8GkqFd7g0WZRfCpwsF42n5EBPmqKYGVc2rgr138
 aLD6VuexdTi9rjgcG4ffvvrJRCNsaYv8Ar99Z+I6q+tmS8F4BisM3g4qOAN7b1GgCRiZ
 PD0A==
X-Gm-Message-State: AOJu0YxpoSXdA/1iI6POoane1Y9mVRMuEcsbd8+b7OJ9DfiKOye7tGvM
 ppzSZICDu/a5EkO1AMKpF/imt5hUoBNwHPTkdjZdsui/x8B/QkysRA9cb/al
X-Gm-Gg: ASbGncuX8c2ouv8Ee5TQiJMGaXSVaQ9NiL1EJ6Ty3HFnVwxVpgp5nXahKMCLfao7kxB
 GYqmS+AWQUT9HgwBXay3+qshAR+Wlrh/wGdScSiMYQQbzSi0vyv12KVEIe7s0tYuXBY145zv/Ig
 t9TxPWhCpmHMcfAvI6SPk2tLWj8xGwQFeOC/OwDKEgZQVg6tHy1iCrexTouWXRURBf2/2/HgCEi
 mChLFLBzJ9+Elea3rbECgXabCS1OSmYcGSkzM9o5fPoxlwJV/qFOPm4KG7NOnk0ytBPdRtxMjfk
 XJJrMRnU/yAtn4rW/Cum3D6osdTyHghgev2BCsd15GpYgg0JEuRF//owHrb/suEqx6XGeXAc6g=
 =
X-Google-Smtp-Source: AGHT+IG+Q7ETey3DHcFK/zDzagfdQYLljMhBG2tERwRVAfdQUk+3Quc5wqofahtbJqs8njjHW5A69w==
X-Received: by 2002:a17:90b:3902:b0:2ee:5106:f565 with SMTP id
 98e67ed59e1d1-2f728e6838fmr24369046a91.16.1737249177189; 
 Sat, 18 Jan 2025 17:12:57 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:12:56 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 06/50] target/riscv: add shtvala
Date: Sun, 19 Jan 2025 11:11:41 +1000
Message-ID: <20250119011225.11452-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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

shtvala is described in RVA22 as:

"htval must be written with the faulting guest physical address
in all circumstances permitted by the ISA."

This is the case since commit 3067553993, so claim support for shtvala.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 356 -> 364 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4f76efc298..fe5f7b572f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 15b82b5bb1..065f894010 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.48.1


