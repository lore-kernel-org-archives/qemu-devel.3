Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5B8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlOe-0006ya-9G; Sun, 02 Nov 2025 22:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOF-00068H-4h
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:37:55 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlOA-0000El-6e
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:37:54 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b608df6d2a0so3628358a12.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 19:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762141065; x=1762745865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpNQdPpzfT14cCGsW3Km7XkFypzdKH+sZ2079tWFHM4=;
 b=fJjpX0BqZyqpor89fLHrC/puDnItl4NES9OYB9ZsxFu8sT4Qbh/vyOIx3U/IVHWsQK
 Y22Kghy/125rRGxoZT64GoXPZzpC5/zdSqr74068o3SMFIaVs33wJQ+NkmuXLgJJas4T
 EpFZuv2YUE7jJ//Ag/uoxKRZaQOfEzvy9D3dhsFdy6xQxuvR9rOIoLNSxXgSlwpcpeph
 I/PyZ1ujfK1Z7MbXZxibi2gOImHN4aRPjF648aNDjM7ZJzrzY3j0ChC2tKtkxBeCiykW
 5I8VmAPzPHAtqU617PsVqfVJXr8/ERoAP1VKV5PJ/CS+ly6dM/HSHDhbHfKKGu0RuBnN
 RBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762141065; x=1762745865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpNQdPpzfT14cCGsW3Km7XkFypzdKH+sZ2079tWFHM4=;
 b=rFPoeTcW8axs54573E7s4p/hpP07MS+1SwFXJY0X+lBuk25Y46H8PYsmh7T5PaYIh8
 Q04rlB4Wvf572YhfbKoHnQbRs/vWvAxpADY0j05NwyX3j+rh9K2GBSsc1SQ7r1nnoUcj
 xXXeyg/ae6YWco7vsRiu93utBjeOgZ7B3Iw7fAeiyFCt+BEz6uKE31eX8zLYQVjlJcfY
 yW3RNV+rBWtRRRV8v84IPE1dq4JSN/igPuTYCPmTvYDh1bhMLsqOasTwHgpHSX1ByM83
 KvyeyuLHo97T6Es2E+FhV1no1s/j3RXlR2r8SY44arbm7iWIAV2hhvv8OV4gKWlfHM2v
 bPhA==
X-Gm-Message-State: AOJu0Yz/K13rpj/Uh3YJgNcJX9AqYKE4lrtPE62mC6a3pUCy06htQqCf
 9iWkojMAEhAdSen3Q0dJSN54GaSCZ09QPfKGcoY6Rg7YzMRmQ0vY2dfw6J340Q==
X-Gm-Gg: ASbGnctqX3dttTW3xPyiLLPa5c8mXNKLwNLsNQAGoUEJ24EI/xaC7tINm/uVpMBbwPY
 0bfx3UuX8RdzHDeMmYXe8BxdsmX2ClTWr4vBihkEfFzJQw3vksp0QAdjpim0BZklizVMr5htfrM
 d5QSd7QeopRKKkdePx5MpAz7xuSrkzZEOIEqsi/Lcd++lioHnQPg+3duKhWuPYwzDVwSBLyxv1n
 4RFjc1B3RtQj06zvxRw1SN27mfKwgmNZZaaNn3XQNFGVn2gCa2szYd4WZBrzrjxjAnjpBX2gXIk
 unSHxqyOCEBHi3hif1VoJwjB2Q0Cn5sPQfQXAEEhlI/2+aIQ9n/t43wXGjpPSjeY74NsPeG9rwi
 DLF9IMF/n980LobCMTzmz6XpzF2tTj4FxRHvjr0in6wRCXgT+eyL8qKnE/w8+t7HhQ1SccnXOIj
 VWk0T3TPL4GGGm85xOE0aAgU1r7HFDcrXLcm3FkvE51kEYhogonBPnsk5pJdFFMPhgydxeAJbwP
 k9gtcn6
X-Google-Smtp-Source: AGHT+IFb85I+7fXJMpyl+YnydbLrzDiH/RsjR6RVVmgOH+UOu5DFx+2mrFys5vVIDgKfzJk5nRpNtw==
X-Received: by 2002:a17:902:f60c:b0:295:9cb5:ae2a with SMTP id
 d9443c01a7336-2959cb5b3a5mr36411915ad.9.1762141065236; 
 Sun, 02 Nov 2025 19:37:45 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340a460ed24sm7939641a91.16.2025.11.02.19.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 19:37:44 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, anjo@rev.ng, philmd@linaro.org, palmer@dabbelt.com,
 dbarboza@ventanamicro.com, atishp@rivosinc.com
Cc: alistair23@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 3/8] target/riscv: Bugfix make bit 62 read-only 0 for sireg*
 cfg CSR read
Date: Mon,  3 Nov 2025 13:37:08 +1000
Message-ID: <20251103033713.904455-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103033713.904455-1-alistair.francis@wdc.com>
References: <20251103033713.904455-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Johansson <anjo@rev.ng>

According to version 20250508 of the privileged specification, a read of
cyclecfg or instretcfg through sireg* should make the MINH bit
read-only 0, currently bit 30 is zeroed.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251027181831.27016-5-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3d..b0917f27bb 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1544,7 +1544,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
             wr_mask &= ~MCYCLECFG_BIT_MINH;
             env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
         } else {
-            *val = env->mcyclecfg &= ~MHPMEVENTH_BIT_MINH;
+            *val = env->mcyclecfg &= ~MHPMEVENT_BIT_MINH;
         }
         break;
     case 2:             /* INSTRETCFG */
@@ -1553,7 +1553,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
             env->minstretcfg = (new_val & wr_mask) |
                                (env->minstretcfg & ~wr_mask);
         } else {
-            *val = env->minstretcfg &= ~MHPMEVENTH_BIT_MINH;
+            *val = env->minstretcfg &= ~MHPMEVENT_BIT_MINH;
         }
         break;
     default:
-- 
2.51.1


