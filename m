Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AEBFE5204
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDlh-0005NW-JW; Fri, 24 Apr 2026 06:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDlb-0005M4-R2
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDla-0006PB-C2
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso36388805ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777026488; x=1777631288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkwl7uSGd1NMwPEHDV0MGjN+nL/p/8ylq5hEMFu9pLU=;
 b=N4Fzg27loDjJTG1ZG5GBUfvjh1sv6OEUB6OPYwsyg6iSd0uAdYqS2zcd7KY9tnGvdF
 ujVgpPvV/7aXhCiflYAwL0Z3uk+wPSfYqoHduzh3SdTgtugeiVvRtD9lwSr40hlESZjl
 V0+VHV4zIc6H4K3n28KN5at45THCIfK+NCw6wo7GTy4pY25dX3cnP/MLeJxlJDDUQAwc
 wyLPg9Och7pHO3xAn9LjqlMHlJBMo1QbsDZp+6VCtDJqgLEJ95x6872Dtc9EK2KNdt2c
 t/c5380dijIxneAof7JhYfIq1J1vPTrQfbg6Xxrg5k0BcsmIPVJd+P0Q7L1sc2UZkt19
 L81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026488; x=1777631288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vkwl7uSGd1NMwPEHDV0MGjN+nL/p/8ylq5hEMFu9pLU=;
 b=j+hdDrlBfXH98kxt+5rrUIakWoBjTQ+dKGmxfgyThTBAik4oEGlfLPJPPhIj45GGR1
 7iFmmN4BQW8XzyHgTgDKUtN/D9jqOVn2aBMiybWn4tHXaovCefS8lzVzNJirqqqVmW8B
 ez7IVfEpLSAi2EHy9nS0jHIvPbgzINKHjhEg++fhQddKjay/kUUw1wghX6dUD6MrhIoH
 nZhxZgwnE60G9oiqjKthf829ocZYGrziQp1eGDBHI2MXw2yepKJkXVZ+9ZplT4GQMm+J
 fvhLwh4weP5WGOyhj3xVtxY8yCtdZunDhzrKa0/JixG9p8MurIh27kV5oAAYZ0d1yENX
 uKJA==
X-Gm-Message-State: AOJu0Yygk3Na1s4y+m7BMyxbJLUsaVfbJ4voF6DlHvYasVnadN/WA+D4
 ma51nz1W44PAl/f6jlQMS4xG6raU8cXcdKPadH1HgGrQq1DMtxMyLe4ge7596a2g0/ttFDB9eWB
 g7VGRKJl6EGfD1U5cS4Vz8pzDAXuRZyoLgwIn2rFx1FtYHNH+Vlz9MIidfiXTCsh5E0kogLwMkX
 If83IDlwfB6/5376VBnO0inx1jk5a31dX+mMmWPB6y98v6eGTN
X-Gm-Gg: AeBDievKjGIOzxIZZCWGuFtjYwF1sewSzA8F/+R+0CK8OgUQhCWUowN92yUAD8Gkj7e
 XoldJ8PP+9D/Tt8FqHDnzRGNzFREqKHc8UNq+GSUdKBIGZvkCpGZ+UqmPYkAPAK1BqPBv2/0ML/
 hLVsgjUx17/KO6Ai4VcZlRVzeBPzDd78FDjUTR/6B9458lLS3wr5ljMr7nrb845vc5hyhd0x76j
 OqJQd+D8ePpS3+CKHWNk7Zjj8GIJN268ytRCNtniqbJj/wcSd1kzqqK4i5eUxE/8cfqUlpKWBHI
 83aPJcnMNGatTtEzJu4cRrOfMt/FBEL7M43j9vV7Suo+p/mKlXxPb6QMVsIHs56rUJcxrHfz9W7
 fIKWdWYxQ2EXCTMyHZV2uS6Cd/asMQJrGYMwG+3TCfe2Pb8TJQBlDUSTLkWbvEmFjByfke7aNjK
 dI4rZFy9gXKF4RJNTWG30hGHP46buj5SwkyCVqMFnKP8hffR3VMAzrtW8eiW8l
X-Received: by 2002:a17:902:6bc2:b0:2b0:9101:1b77 with SMTP id
 d9443c01a7336-2b5f9eaf6a6mr228203835ad.17.1777026488237; 
 Fri, 24 Apr 2026 03:28:08 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0c17esm218889585ad.41.2026.04.24.03.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:28:07 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 1/4] target/riscv: Add Zicclsm CPU option
Date: Fri, 24 Apr 2026 18:27:57 +0800
Message-ID: <20260424102800.24022-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424102800.24022-1-frank.chang@sifive.com>
References: <20260424102800.24022-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x629.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Frank Chang <frank.chang@sifive.com>

Add Zicclsm CPU option so that user can turn on/off misaligned loads
and stores support.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 2 +-
 target/riscv/cpu_cfg_fields.h.inc | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37d..df56b64a736 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -127,7 +127,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 734fa079f28..fc55dc6d892 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
 /* Always enabled for TCG if has_priv_1_11 */
 BOOL_FIELD(ext_ziccrse)
 
+BOOL_FIELD(ext_zicclsm)
+
 /* Vendor-specific custom extensions */
 BOOL_FIELD(ext_xtheadba)
 BOOL_FIELD(ext_xtheadbb)
-- 
2.43.0


