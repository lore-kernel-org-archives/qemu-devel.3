Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3058CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfZv-00045G-Fi; Wed, 03 Jun 2026 02:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfZt-00044g-L2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:59:49 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfZs-0006Js-As
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:59:49 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c85893bce34so1523649a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 23:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780469987; x=1781074787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3M3o7iu8Yqs3fbpTwLGXiXAr+OPP7yogr14zhg80Z4Q=;
 b=b93Zbmi3IbTsvdb0tzgMVmJyU14P2kPP/GcmXLdj526wyC/2vizCcfxTZfSGe91LDx
 sOMfA+jBUQlsWvDlGgdgAK/1WegKJM3xsF04W2Wk7PHpgGzS8xxJ4srPFZeIWvY5gv+P
 ooechJ7df/f5tZ3nrIfCrkLXLp2zmbti6MW9p8aHKW/9h1tg6HKN0ID9R0f+gahry/Jr
 lDYBni83Rk63sX6sBY3LSlTGsw/Ku1IpCxcfde6/KMKUr/Mz6VJMiWeIhfJvfqLfde0m
 cSlLdenfqpCYuqb9J5tZ9VohP+12yzgbgTuTFnen3t4WzS/pOfvDoTmZISK8ZkUROB6T
 3AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780469987; x=1781074787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3M3o7iu8Yqs3fbpTwLGXiXAr+OPP7yogr14zhg80Z4Q=;
 b=ARjMJVqTehj33GhK9HDMtMUCZTWr/r7lMfS01j14kQZmWgDAJm6GhJEqvSPivB7kma
 owzUwO88DOesj5s01ze5tttKs9Lr2lL31DMK2IVIsJCNyP3wyLZu0MgUphc7zCCWg0u8
 0hh9IZNbLKbADsZ6ejv63ReCBbqXUn9LGRsVBGfd6VbR1fkGBpBb9UwOKt85kAYeQL3c
 vCbo0pryPjR2lSOILsaTex8DX5V+DjBfWuBC10f8q0pycVSjwYzW15Y+Q3AiQcYppXmP
 uXjRKPBwUkFYQikbv2Y8SuwjSABgHQdIGZWjoYz0dfpcGBAO1RHo0UQ0oZ22FWP4t8MD
 S1Ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sULD9V9kJBsDO6qL+lF0kAheq/JX0OTJ8FsXJ51cf+G67hqTDMcxiEMceOlsQh8a8FZ54Ts/7G0EV@nongnu.org
X-Gm-Message-State: AOJu0YyCccVYWEscf+AIRYDVmWHUFBt4aoebxaV/NXRX/+dTQ9CQLwg/
 6OswY8Mq/0s9TfP49Zswd3TlM7rzPCR+snK5puQOkzhdxH/tgIF1RdYC
X-Gm-Gg: Acq92OHHBgxVLF/qZXWdB+S4XCk4Xv1aPZEz4imXgG1rdRwTEYLHRcZViSp+ge8/hbD
 YnLcAjPecsKYZYUItr420wLoVVjGtgjlOf2LPWloTgdBrr9n13yyuU6xyrwqQ2f7QgmEYa9LpDl
 rqqd+aO2rwYx5UOppFN3CeXTNJMKfbdOQUqbiJvTKzHPKm0iWjhOgU/DebcCWabDDAiRpPbfPFP
 6XAsRw0goBjxaZygF9xdc6/ybUoRGWNVyhANGQLh+XBDkQeu2ojpXeAredelM5WQw/TpwrS9Z2N
 HkOSoMq0j0Ed2Qioq9910Rdi8NiyklSVrrJ+opNMDZp1SgpuVyjfH0y3G77LSP9MT+xacSeoyVc
 PmwhAKPb+dYLXpLsU0lNkg+iIl4hET40aUa156A/8NhX9gdn+/z6E9DAeXkKrfJ7XyqzInNK9uB
 tZyaYXCmoXR1VAT/y1a00dBoRGMQ1apqCm+d3A6JLzNnNS6Wx8AoZrApa/GVhdK8Lv5yXpcokWD
 KcxeaCfS1y+87/cwM6Q6wpkwVH0VfQXQYUnkSVzHji58/J56fnt/hqZE1PJGV3M
X-Received: by 2002:a05:6a21:3989:b0:3b3:1c7b:ff7 with SMTP id
 adf61e73a8af0-3b4977b34e6mr2683504637.46.1780469986897; 
 Tue, 02 Jun 2026 23:59:46 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df033887sm1283261a12.2.2026.06.02.23.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 23:59:46 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v8 06/12] target/riscv: tt-ascalon: Enable Zkr extension
Date: Wed,  3 Jun 2026 16:28:50 +0930
Message-ID: <20260603065859.592063-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603065859.592063-1-joel@jms.id.au>
References: <20260603065859.592063-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Zkr and the SEED CSR.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 862834b48097..6bf93188d24b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3090,6 +3090,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbs = true,
+        .cfg.ext_zkr = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zvbb = true,
         .cfg.ext_zvbc = true,
-- 
2.47.3


