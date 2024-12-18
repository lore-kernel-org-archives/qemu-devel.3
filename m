Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F39BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsQb-0007fv-59; Wed, 18 Dec 2024 06:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQP-0007b5-JV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:41:12 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQO-0007xJ-1j
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:41:09 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21680814d42so52916585ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734522066; x=1735126866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AlFl+TxHMtjNlkR4E/snmXOdeZIi6lyTp35UQkY7Vg=;
 b=jgqcgj+yoi7k2kVRhPmClz2432Gdfe91EfW8a8Rulwmp70RVXAX8muiSUrKUf6DX4H
 04IKrxlbMvZQsa6AIecZ1N/GkM4iVPPxXATEE0j1m1P2qveJvSwOS6CErTc1CfleOcRm
 dbSBYQHCneLtoxvmtyFkQuT3V1kKnKCh+Nj3NDI4jgnybeoKsdtrAV2obC0cjEl8sz+U
 o2zJOawNy3e3qNkPQFjhKueRne/YkIM69li0oG8nh4Vk3bTw1fy05eyqdOwY25yExZB+
 gQj5kodU3TEPC/Fwdno5+XdAr/4xGHR/C0e7QAQ+no72EaDQUbHpJ/VG3DH7BvaqC24f
 JHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734522066; x=1735126866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AlFl+TxHMtjNlkR4E/snmXOdeZIi6lyTp35UQkY7Vg=;
 b=rcGzlFc2y2g4oMNT+KD7XRdIvH93g16z6NfmU2/qwuU8akyuzprB1YOebu5HrHq/1U
 tl6t33rCzZRNkd+m134afBhR1TkMNlge0WbeVm04gY4Sx10eWUj8GOch7ZuoJx135Fx+
 BSveaJwwpa1Dnq+En+NJI52yYlEmC6+Gaj2x/KyJcNkWwnmxTAD3S5/hyJde7igv13Fa
 Jv6uKL27ttMjVH/uvdNtbWYkJRVhUT3Bz65UKJ++RWb74quT8Yx0K4duD26cbSWWCNQq
 CB5ALsm2x88MgWzSbmQ6NmJk4XJfBMFJtWwo3EBQIoDcnomVcv5QPahXWVq7eou6LGpt
 5Buw==
X-Gm-Message-State: AOJu0YzVz8YoYVvOBVfCufDJTN/cI3vLjH8bep9B5qCzZJJOecH+6JFg
 DJoG3WCWuGO3PW+ElQNJgR3enk9nSgylKdzv0VAp7WADgNmPa+qT5/dJJmHBtX98IHBUY+/ll5J
 JB1k=
X-Gm-Gg: ASbGncsFFKJwrN0C/0gqVuWaqcCR/QAt77a30FZuscAW4a58Z/REM+xxQ4EHRoT8cXP
 nwd6vxFnFUUBF7YwSvqYos3G5BAlLoaNOu57Jf/NePL7FF8aRdeDk/XGcA6zClmkhcwzp6l0amt
 ifPmfMNdJo/68+5ZDsmi0TXoF2Hf2H9I8TngPjFlR6U5iWRfYI79KLObE3Y1Z62JSYcmKvKKFS3
 vLIjILXNN1CWyL8ANSnMhvPHucGe7x5EG4fCxdh3DDtl0lV0o4YnY0S43BlYd7LBMxjAd4yO3O9
 5A==
X-Google-Smtp-Source: AGHT+IEIEUCIgSkiPbFpXZXqqQLlTgbOfXGKfn39bXcYy3KUwCtU81BLj0E+HmDJopLFxrKMPWZR+g==
X-Received: by 2002:a17:902:d489:b0:210:fce4:11ec with SMTP id
 d9443c01a7336-218d6fd5de9mr36572675ad.1.1734522065914; 
 Wed, 18 Dec 2024 03:41:05 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb447sm74462285ad.68.2024.12.18.03.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 03:41:05 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 8/9] target/riscv: add shgatpa
Date: Wed, 18 Dec 2024 08:40:25 -0300
Message-ID: <20241218114026.1652352-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
References: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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

shgatpa is defined in RVA22 as:

"For each supported virtual memory scheme SvNN supported in satp, the
corresponding hgatp SvNNx4 mode must be supported. The hgatp mode Bare
must also be supported."

Claim support for shgatpa since this is always true for TCG.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 382 -> 390 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b5ab97b4de..41629019e2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index fcd9c95a6ae6e6977e5d9c33a39785269a28aa58..695022d56c4ac16607d4c622955ad339fbbfe997 100644
GIT binary patch
delta 45
zcmeyz)W*ye<l!9B#>l|HIAJ1}0jmllBZJID`yH(5i6sSz6TdWZ#4s{2q%kru000jj
B3tRvI

delta 39
vcmZo;{>Q`><l!7r$H>6I_<tgo0jmrnBZJ69`yCVi*K>q0GBCt3GB5xD(EkaU

-- 
2.47.1


