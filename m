Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB200E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsQa-0007fT-7C; Wed, 18 Dec 2024 06:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQN-0007aR-RN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:41:09 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQH-0007wQ-Tf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:41:07 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21636268e43so77067465ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734522060; x=1735126860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeGHTv7WUGU2Badmf2iQKUYOhrgRKmlPJ9jE2wBhvhA=;
 b=lQjk1rCDSDGkeHOir7jiB6nfjWfnnUjlPP4Wtm6OYAuePGmT3pXy96uIIahg+HMOfz
 jnvt/Pj7cf9+YScXzhysgdO1DqTPzcvpzDerdhWVT71oco74i4q1UPpeHXqL0ZiC4Kvw
 BC5Klfn9iQ6BgU/4l9bZ0rYt4J+Do710cRZsDJlFhf7ixr7DvuqZkpetm0lMnoApzzZJ
 REn4Z2RGXeoa/et+sZOkmgHQKCEgOIkYrnRkpsJa9GddIP0TYphJtKWuz6WccLiCA6ms
 O462RwcSWWLyfvHDw7bak5K/FWc/7OUe0CeFFOnGk4JjxZgfzaF/KuGFPKLl+lCgLv2m
 VnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734522060; x=1735126860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeGHTv7WUGU2Badmf2iQKUYOhrgRKmlPJ9jE2wBhvhA=;
 b=TFD505BgC2qYHCUWbjhug9xSBZ+4Q0Q6uPvVgq/+FOgfbKR/xPP8UgfjUvfTCoIUr9
 PsbwFt9v6Dwa4DaM3zPYgh+6mxY6b4zPprZpKRpMSiqB1Qm9fAZwB4E4F0USDO55Z9MT
 GG0gfdjMPBO24Iohxzdi819vOz2zbsPEz0mDRtQGzRVxBsp9bPV93adZOGt3PgTMn8zn
 OtkuOYsT1H2y5pZCTrHGMYU9QXdzfxW81+WN+UxSSRlIpe/qOtHsOGuunmRg1K5DNi/L
 HvM4z3zMJdxGxvgRS0xESIt9egZEcbvwtzjyik4MjcR91FXpIavliJb7O78lFwep4HFX
 rNUw==
X-Gm-Message-State: AOJu0YyQUvr8Y7Z5TF880dfhWETnS5jMYLF7g8rkiNE8bVriMqv8lox4
 4iKoV+kf5hRgr/dClLrh8h5NQqjDNKrriirb28uhslHmHxygEehpdrthXgfo0TytMGk8CzmRumy
 Vg5g=
X-Gm-Gg: ASbGncuLFQEb4jx/Qb5GwLErbeDuryNJM0wHhfVYvarV5EVln/6Iqb7rOeQk3I0DWcW
 VjZSawlK2S5EUfr3XceJFqCGYdWXN//0HMUsUZcAwdCx7ja0py5QEkVuVCDOPvWH1cP2ISRN69f
 MOvuDp35iG3F3hy6DgfwuPW6k3A5q88/0XHd+8rJn52VQe7JdcXrpSjRGXvke1mQ4Am2FNPuIpg
 fMud4jcBufckQyOzzyyVFZH4cIhOV3OfOrP2BRrzKC1UOpOXf/avtIeaHbEUH8jSQwZERkKyWBu
 Qg==
X-Google-Smtp-Source: AGHT+IHyU8Wbomp5y51DyqLpTxl6Rb1sGktSfOtboz5QcDuNAbVcJmIaxxDWD3UfD0gu/9GDT8gqmA==
X-Received: by 2002:a17:902:ce8b:b0:215:a3fd:61f5 with SMTP id
 d9443c01a7336-218d6fc137emr36718955ad.5.1734522060365; 
 Wed, 18 Dec 2024 03:41:00 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb447sm74462285ad.68.2024.12.18.03.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 03:41:00 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 6/9] target/riscv: add shvstvecd
Date: Wed, 18 Dec 2024 08:40:23 -0300
Message-ID: <20241218114026.1652352-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
References: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

shvstvecd is defined in RVA22 as:

"vstvec.MODE must be capable of holding the value 0 (Direct).
When vstvec.MODE=Direct, vstvec.BASE must be capable of holding any
valid four-byte-aligned address."

This is always true for TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 364 -> 374 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 70301def20..7aa8a136d6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -186,6 +186,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 065f894010272e7f27834b2c8d5d5fb0c21066a1..2c7dc6c9ab8d8da9c30ad34294ef28427a4f8f1a 100644
GIT binary patch
delta 49
zcmaFE^o@xt$iq3LjFEwX@#91;16C16Mh5PQ_9r<q%8E<MQj=3AvoXeT_%JdsgfTKO
F002~G3@88q

delta 40
vcmeyy^oEHm$iq1#hmnDSF=ir{0V@|HBLm|^`;(J}7-Kk`7#SFR7#SD<#!?6T

-- 
2.47.1


