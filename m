Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C41FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwtd-00082l-32; Wed, 29 Apr 2026 00:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtL-0007iq-NG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtK-0000y5-6q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so3131105ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438277; x=1778043077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NhJMkgzUcZIas6wdwAWbF8laZLoVF+8isiydmPP7fI=;
 b=eu0bVTnIesdbxr8uCRAnjNgTSu+7+78sb6TNvgHRVHmDdQKHdzmnP3GFQV7MmZzNJG
 F2GmTS/6rgk3tWtR8iX5WrNwX/DPhXn4J+iFU19sW1STP9fn2ApIoWK/wIRu3/yr1MGU
 /H98KCkutacO8IRXyAbON6ASuVK76dTQfFWJECRzzj57ouRivIKojYR4bQ0xlbjG3v8j
 8xBSqWeKrmfNy3UPgR39CQcdy4Xs/UYYLbCOaP36BVz6xNZbTeVKGRGYymGUG5EjKZVY
 Ix4OrhMq3f9r76I4hyvMOGqVZiw5g9Bs27qmx9sL9TkIxCki7hasiWQOUM9wuy/tFelD
 7saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438277; x=1778043077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8NhJMkgzUcZIas6wdwAWbF8laZLoVF+8isiydmPP7fI=;
 b=OY4uqIF3k2LsdHCZHAS2Tx2KULYltp8jmU/OXMXwjsRk4nQPO+kczuaSo8KeGH3Jcd
 k2bSdBNBe+3dS+3Zv1FCcvZoPyPA3MZSuqAktyOZDgLXPq4qpsiOVtAyrsYdOaiX8MrF
 gClCSr618qI74OjjVfonXD430GfoLkiLcgRyZGM7w0mkbibvzH3mDcn6wnmAf5oTVee6
 +wbynVl1w1CIOAa/pHvpMJ8nZkzx+Si9yL5KV1W5PY36bsKfFBjjZbwkq/QwTuayfn9S
 Ht7G/HMKkcog1y6a6CdRI3sfZDlxr9M/46F0JZwnbCl3lQNeYi7uun451/NwmmyAPceM
 qpGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HAVnzt91XVj/4QZOksR2ARF2AwnB77wUZ1Bc4CN/fZVVkaUdU7ODuXMKAvpsMkXT9HV1NeMFnfZpY@nongnu.org
X-Gm-Message-State: AOJu0YxCwVS5yBCd+jOewfiwTtLuF0WKpswd5O1WIzrG4gqkhKijwrPo
 OtOoOnUp6bY6FV5W6Ueee74w3BS5FhIMxh4CoD+JSuSw1IQ8DNLIzO2UkWoXsw==
X-Gm-Gg: AeBDieu1pRMx4goyxWsdUF/F5j9+F3Qd2k+0VA1oEHrU+JZWVth/W2ufe0n0RCV4Jl6
 6BOLCzs+2EoyC2iTWsf5XFk2NPV9iVmXAgszTmX4U0qQgmqpTtBgUT+Cs2UxL4rXdZ8MM6Bi4SH
 oLYGEOaoWeD51G7e4bCaCbRyHmHTWthAln1+PHHxzfZl1jGYFUhKulT4ZtOv4yDwMmWGizhPf/J
 NhE8a83UVsFoDmgltX3kYRftro4T1i/zlUqE1n/xcEl8WXEPbWSR/iwHi5soTguYpvdfTZmoYYG
 bqTRt+Prp2/imig5XcgHV+b+Y2giCuRkoAMANd8WnUgCg3f1S+OSopwgcVCPsF9nIvZ4S2Ql4aI
 lIEldKBxOuUq8KJhJoXgiHCBptAEX0YRIIxrlu4xwjo50hi5uD4O1ixxhBwzGwsmGB7iegK2NHn
 8JcecUboQ0vm+VYLrghvQ7Fy+JeN6sd3f2xogudQAv415RG3iLRrre
X-Received: by 2002:a17:903:1988:b0:2ae:5ab4:f4c0 with SMTP id
 d9443c01a7336-2b988433716mr12975595ad.13.1777438276785; 
 Tue, 28 Apr 2026 21:51:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/51] target/riscv: tt-ascalon: Add Tenstorrent mvendorid
Date: Wed, 29 Apr 2026 14:47:38 +1000
Message-ID: <20260429044752.4176397-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
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

From: Joel Stanley <joel@jms.id.au>

JEP106 has two vendor IDs for Tenstorrent. We will use Bank 16, company 33:

  ((16 - 1) << 7) | 33 = 0x7a1

As JEP106 requires registration to download, the number can confirmed by
looking at the OpenOCD sources[1].

Alternatively, referring to the JEDEC document the hex IDs are listed with the
parity (MSB) bit added. Company 33 has hex 0xa1:

 ((16 - 1) << 7) | (0xa1 & ~0x80) = 0x7a1

Add it to the Ascalon CPU definition as the mvendorid CSR.

[1] https://github.com/openocd-org/openocd/blob/1ebff3ab33c77e3f8fb4e1ddda262b606b572af1/src/helper/jep106.inc#L1935

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Michael Ellerman <mpe@oss.tenstorrent.com>
Message-ID: <20260114020516.982305-1-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_vendorid.h | 2 ++
 target/riscv/cpu.c          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index f1ffc66542..751a13aace 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -8,4 +8,6 @@
 #define VEYRON_V1_MIMPID        0x111
 #define VEYRON_V1_MVENDORID     0x61f
 
+#define TENSTORRENT_VENDOR_ID   0x7a1
+
 #endif /*  TARGET_RISCV_CPU_VENDORID_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 38286b6b40..72c6f4f0f1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3207,6 +3207,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svnapot = true,
         .cfg.ext_svpbmt = true,
 
+        .cfg.mvendorid = TENSTORRENT_VENDOR_ID,
+
         .cfg.max_satp_mode = VM_1_10_SV57,
     ),
 
-- 
2.53.0


