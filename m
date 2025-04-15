Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9C6C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bGK-0007Ua-IT; Tue, 15 Apr 2025 04:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4bGA-0007TJ-OM; Tue, 15 Apr 2025 04:03:11 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4bG8-0000ak-Cz; Tue, 15 Apr 2025 04:03:10 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-aee79a0f192so3469369a12.3; 
 Tue, 15 Apr 2025 01:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744704186; x=1745308986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVdc1YwIRV2GyTbuh3vK0eXda9+aM0GBapiUKLD+4mY=;
 b=aG8Wmks5KYKe7NPNYAphLjxk6TQMQHopa9Z3bsRR4OojtWbU8zkQufdNooaT8bvyOn
 TgohpT/pRjVoIEvXPi/plPy7FFRUA8jhezNY4hOaweRaAWekoXEbzqb1glRyoGh8VJOG
 hQ4wVl4KhiZ0aMLHv3KnYIuBmsxUFSBLK9Tr/eUdh8qX6cnVt0LAz2Hd4Ow2f3oO59wc
 kvmmfuKrs1S5ao0zRYGkj3Gd7NoFWYl6VrzvFsKjM4eYeDDykISfMAPEmLGf3eieTEaP
 85/jkPYsawAvaDOl3ZzJ4klR78OK+clqv55AUyEQ2gTWsH/4P3QT9JDUDJ/XcBeanmsD
 wdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704186; x=1745308986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVdc1YwIRV2GyTbuh3vK0eXda9+aM0GBapiUKLD+4mY=;
 b=nlAHsXZt90thy1tvRFxerQ905gnu+l1Yu5J3PJ7LCbxmeE2YDdJBsOmg06g/omDyqt
 ISRTg6p0yjCdNdi5+X/hM0vFGB4qbhmBL2//IpasgDvALNBzoYfsYBFLpjnw3KB3wtwm
 y+vxU6bp0P3F3ZmA86qcyghs/7GujSzT7VtQt/IjRXk5Rwd2/Du0XfQrBMPJwMK+Tvrb
 wY6Qx0Y5EvSCq7XW4t+ZdHnPPXil0IR/P/UVlgdOrJNiQ8VvwLf5mv64tPET7Ndgxy+f
 5PidU2BOYg9sS0CuqPj6lJbgK1QU61B5hPYVoQkap/ISi/GE35MLe+5FXy1BqJgvHmCo
 +/EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbDJcuKuv6G6yKqg4dlRyDRgBdJJUDSKfM6MLY9iYT3yNVeasXrOfPrU8+fF5iKvD0Nttekqt+e15FE+E=@nongnu.org
X-Gm-Message-State: AOJu0YxdPgUEqRzj9wQH+pzoz89Lnm8g2bDvuyJyvYnlH7u3oBBNIvFL
 eyD0gJnKRxsYY2u43lHoxEOybV7halORlOzACwW8odvPXmUdy68jRvBKDLus
X-Gm-Gg: ASbGncugY1QEZdAIIv4jTaLTDmXX8t/T0fnw1996pPS0yE4LxMHh8urxSSoR7pQ1FD1
 C5T9JNL1MT/brKgzZPBC9SZlKcP/rKXv45/MuZ7stEDWf2B/K1D+Hzj+bIuFd6x+uosa+iBL5u3
 6bXbzl8OpOiNxLqM8uqqAsbpg8NbWby+1YEJgTQOegKOiKJnRrckTUtb4VUrCiCaiRmmZPFAya9
 Lo5sf2Q9ZLYf/yMbGqyG8kr5Go4mWQejwypU86OkUyA4CEUz54+5L2N63/VCFeaTKYCBACIL3uk
 JbzHWqFZHG/WEEPDhZtKFS9TuBrmon/w31wl2geD
X-Google-Smtp-Source: AGHT+IEM6SnnT4U83vT5Oyz6uNGi46RbIwqHKC2BsaBiibjfZPH1Ry1tWzRNVnR00RGIqksYWev95g==
X-Received: by 2002:a17:90b:2551:b0:2ff:7ad4:77af with SMTP id
 98e67ed59e1d1-3082378e72cmr23084739a91.20.1744704186243; 
 Tue, 15 Apr 2025 01:03:06 -0700 (PDT)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd12b5c5sm12640745a91.24.2025.04.15.01.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:03:05 -0700 (PDT)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: ziqiaokong@gmail.com, qemu-trivial@nongnu.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org, philmd@linaro.org, pbonzini@redhat.com
Subject: [PATCH v3 1/1] target/riscv: fix endless translation loop on big
 endian systems
Date: Tue, 15 Apr 2025 16:02:54 +0800
Message-Id: <20250415080254.3667878-2-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415080254.3667878-1-ziqiaokong@gmail.com>
References: <20250415080254.3667878-1-ziqiaokong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On big endian systems, pte and updated_pte hold big endian host data
while pte_pa points to little endian target data. This means the branch
at cpu_helper.c:1669 will be always satisfied and restart translation,
causing an endless translation loop.

The correctness of this patch can be deduced by:

old_pte will hold value either from cpu_to_le32/64(pte) or 
cpu_to_le32/64(updated_pte), both of wich is litte endian. After that, 
an in-place conversion by le32/64_to_cpu(old_pte) ensures that old_pte 
now is in native endian, same with pte. Therefore, the endianness of the
both side of if (old_pte != pte) is correct. 

Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
---
 target/riscv/cpu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6c4391d96b..3233b66e7e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1662,9 +1662,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
             target_ulong old_pte;
             if (riscv_cpu_sxl(env) == MXL_RV32) {
-                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
+                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
+                old_pte = le32_to_cpu(old_pte);
             } else {
-                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
+                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
+                old_pte = le64_to_cpu(old_pte);
             }
             if (old_pte != pte) {
                 goto restart;
-- 
2.34.1


