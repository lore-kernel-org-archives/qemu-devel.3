Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8822C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJuy-0003tg-OJ; Sat, 18 Jan 2025 20:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuE-0001zQ-9N
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:15 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuC-0003fL-43
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:13 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f4409fc8fdso5244421a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249309; x=1737854109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwEyXlo5Rvtc+kl5EB4TVm2Xy+p29wGWgR0S30rNC/g=;
 b=g9+7rIF3XaZtR/fmmhoJKlZX/fFRPf0xilSowbI+yYzdR7T/IIf57FdBlJyiH8TACP
 zH6LZ42PAscrj+TLRsrltrK/Te8FG3nocJ+ra/ulZPxiwvnOsY34nhyFpWO8Rl8WnJno
 UFg+ngsQQ9Hz2TtuLBO4ZiKl+LyOQ2rFEPRFIiJWJ+toUUKm6Hg29nNRcZ+mnmL9SnjA
 ad6OSZjBDg0t0pM15GIwP31t/qbisE4M0tgD6LZR8sNyqH4a3vKNe1fYvbnFopCZ8ApK
 cJAh5UsYZ0cETozhxrMGvYPEEXtXUHZVO37UUcVQPiwvBD2tnKnE1VQzcN5dm3xsGt/V
 Hs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249309; x=1737854109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwEyXlo5Rvtc+kl5EB4TVm2Xy+p29wGWgR0S30rNC/g=;
 b=Ps8/4wdPyci9/ZhdakyztR4ah2XZpY6NlSwLthjUhxQ7CuC3eAKfAxqXdMA2JPxife
 qiGqxOm5nMzW9m5bLu6kBDwmX73eobpW4xlpPGUszhGGxwIRWR8vJo7CpfN0OHwd8GkV
 AxJt88jYh7zzrKxUUIObzrHcqrG5n1A/HK6iw7I5dHXMMTWExCYf/ylWlLErzg+VvitA
 4rTX1ax3NBSpaFgNCkZaJ4/ucn8x28t8MUWjoZozLc90/KcWwZtfaHjV5M4xZT9Gw0yE
 EFgP45q7eZyJV1alhal+uSFOR6p0t8wdhEmxhsL2eJEXpahJCyeTFIT6OfrmxLvbQIf8
 qd3g==
X-Gm-Message-State: AOJu0Yy3HfVgdFSWOfxTwT7jRTMwFECX8D3/HDbxjJjWxMTRGOoApXqP
 Dud496yYlMXfQaGgMVk22r6moPE0xvL7WMPCykItMz/bvCdbub9x44t9UDux
X-Gm-Gg: ASbGncv0H3jHNxM5G7Kd59fDXAV0MWlw/zGEVgeUN92qUIeyLTxCpQPV38FFftscIyw
 dg+CzwpL0JHG2X+jSMqzWHCW4K0JggqoRgrrnRM5E/ztPiHOim8SmscAMgAPTiYeH7p4Bs0HWj5
 OxA7zjeqdZVsOJEan7TxBhYFzXZRMHMfCgPJvQdCI77oUqUxBS3P+UPo92dvuZ72Pbgos7lAmH8
 uWR49bYM884gtnoNb8rXvWyXTaXIhpLmE9H0ET/yXVLDkFieyoeIO4yXuUD6B5+hWimDZ7mrctq
 MXr37fQZSAXnFyoHek26v0UJ7FjX3DnHyuKZCT8kXMXG3TGQpIOSImN1A6baMwngn7aT8A5BuQ=
 =
X-Google-Smtp-Source: AGHT+IF1RaktCwLsT12ERsF9lwkS0iw4E6OD4RcFB8l31tI0CfrSm9jr7ZPHxqVy4I+LzpcKRSZLjg==
X-Received: by 2002:a17:90b:2e44:b0:2f7:4c7a:b5f with SMTP id
 98e67ed59e1d1-2f74c7a0c32mr19816223a91.2.1737249309564; 
 Sat, 18 Jan 2025 17:15:09 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:15:09 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 43/50] target/riscv: Add Ssdbltrp ISA extension enable switch
Date: Sun, 19 Jan 2025 11:12:18 +1000
Message-ID: <20250119011225.11452-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Clément Léger <cleger@rivosinc.com>

Add the switch to enable the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-6-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5540eb7f63..9e1ce0e1f1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -205,6 +205,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
+    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
@@ -1628,6 +1629,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
+    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-- 
2.48.1


