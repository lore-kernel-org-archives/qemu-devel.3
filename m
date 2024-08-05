Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC7CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawQs-0001oB-WD; Mon, 05 Aug 2024 08:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sawQj-0001hO-Eo
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:03:16 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sawQh-0006tq-9p
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:03:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7105043330aso3606126b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 05:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722859388; x=1723464188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yE/tJ1ICqbl1HI0gNOYUvhKXvochvRJl/nkViuBQ/hQ=;
 b=FvV7woO3SPTU2OB6Gg6nk8o+vPlcfeIlEVCM3MGMbsfrYNZDHCwbBZpwUDU7to/Ogv
 0t7z7OGwyw1Tn6sTxpeGzlY1Z9L90Vfuswp1tgJNp60v/4CXpX07gEmG9jxbpjK4CCaY
 0ZI93OznjHvbwy481YBLk32wI2U7JLprovK225xWS64opkGdxySqEEmtmMCYZ46ne66R
 0JNUkDVlw13f6HeV3WuhcdvRg6nH3ClxOdlQro5Y9tOvOnrDhhYN/b0RKCAKbb6VhHxV
 eGMsiFIs93z6+ZqjT7OC1onR+Q2q3HAgHrsLD2ChonnfVwFKEXf0esFCqLIVfa6SI27O
 /qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722859388; x=1723464188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yE/tJ1ICqbl1HI0gNOYUvhKXvochvRJl/nkViuBQ/hQ=;
 b=bTtlGTTMlikMNTdc6PmPVQqNvJF6mFKmpOwWgpD4jaY+AuhBXsvQ/yJLaJtpWCrs1M
 EiMe7IZs2mQkxJs+cKDtgR9Yr8tHw/JEdhVLzjBhbfyrP7RSisoZ/4R4XyHBu3PTaNYO
 rkWB6TRBXLFQnlJfWggsoOXZa8UusfDOnBA0TPIJBZitIZy5yUb9/GjD5oGE8/cxgtVW
 3m4rMGtTv6+S8xKsuPBLcc9XsSAxtS9VVExSYoTVNIesytHvOGO3gS7WU1mfFIr6hhAb
 lTX1EMenevs3/k64xcV44zVh0cZ4zXiwbDpjJ5mc+eGXHFLyIgdyzbxi2Ss7belOfFm8
 NzWg==
X-Gm-Message-State: AOJu0YwRGB/IqW0Ed3StRvlDwPZzo9tQNIUv3qYSnqfvw9KQd6QB3efP
 P9aoja4WDN+Besae+ChrLLvesz+cHN4sWOSWSX0UUg4ErhuFqTh3AsN8lCZ49beQU3NDdy1Cyw6
 X
X-Google-Smtp-Source: AGHT+IHHncF/a7S0dU0a0DME73uCwvkt1Fi81X7lgeUwbiLSOwngwEnhVPdP5V+E7HoJrNKXh3t5CQ==
X-Received: by 2002:a05:6a20:1717:b0:1c0:f26e:2296 with SMTP id
 adf61e73a8af0-1c699653df0mr8986995637.48.1722859387722; 
 Mon, 05 Aug 2024 05:03:07 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.133.97.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ecdffd9sm5231041b3a.129.2024.08.05.05.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:03:07 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.1 1/1] roms/opensbi: Update to v1.5.1
Date: Mon,  5 Aug 2024 09:02:59 -0300
Message-ID: <20240805120259.1705016-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805120259.1705016-1-dbarboza@ventanamicro.com>
References: <20240805120259.1705016-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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

A new minor version of OpenSBI was just released after our bump to
OpenSBI 1.5. It contains significant bug fixes that it's worth doing
a new update for QEMU 9.1.

Submodule roms/opensbi 455de672dd..43cace6c36:
  > lib: sbi: check result of pmp_get() in is_pmp_entry_mapped()
  > lib: sbi: fwft: fix incorrect size passed to sbi_zalloc()
  > lib: sbi: dbtr: fix potential NULL pointer dereferences
  > include: Adjust Sscofpmf mhpmevent mask for upper 8 bits
  > lib: sbi_hsm: Save/restore menvcfg only when it exists

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268312 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 272504 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index 7ec260ff40..b2e740010b 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index 090c0cf6ac..018b4731a7 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index 455de672dd..43cace6c36 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 455de672dd7c2aa1992df54dfb08dc11abbc1b1a
+Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
-- 
2.45.2


