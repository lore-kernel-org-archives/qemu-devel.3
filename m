Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF06AC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 21:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP7ZU-0007a1-AP; Wed, 03 Jul 2024 17:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sP7ZR-0007Za-Sr; Wed, 03 Jul 2024 17:31:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sP7ZQ-0007MR-8J; Wed, 03 Jul 2024 17:31:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-36785e72a48so1359677f8f.3; 
 Wed, 03 Jul 2024 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720042278; x=1720647078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mXZdodmm/SPOx7d8Ft9YHnvvXNt8tnle5mmFhuOWqf4=;
 b=HEuvHe5ZbHPwwffhxjnu1shHENPaz+6PL1JVuB3RBxhXAA8MXpY3aVl7BP9Pi+rtVI
 cwmGfHQE1+qJezM6yqMNLfdWz6QLPCtfEQMvsgisIL6Raz9OwRTvqIKnJZkopLLdKmOT
 7PYAMkW6lkWH4mXuQ6DX5U/XOtXn99hn1orYqdnhgngGFdkvniTnVhbIlNDJQLDksI73
 2MmFybVuL8CU2ce4qU/k9r4ve7jbUiGCQXLwvML4rnc6d/a3h46bfT0lCvj74QuQzicw
 0U6nmZDQYiWX6JDFIzbP/R31cXFlNFM9XyJf7KtfFFzAgQsLnUQWF6/3oUjimfVENJ4a
 NtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720042278; x=1720647078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mXZdodmm/SPOx7d8Ft9YHnvvXNt8tnle5mmFhuOWqf4=;
 b=P3e67ViGgRh2MBRf3yjQSiU1Rxx7h75c7K5ZxXRz2oFCaw/Y8cLSg2t1SPMm5pV83G
 baN6JMrQRiOKsDmqgklyPP6oUP01yzAvzhk0cycGGKZjGDuhRx5EIrKcc/7PEOj8ZqV2
 iy9lxe3fpmD2HW1GrgSbWXa3wfoMce7ayJ3VpsBmsXRvI52rt/P7a9KuXusN1s4EAttM
 ynDqFvQ/dSLZiDApBpYamQ2gFcHD0eH/dG7zb4iSnYQBWSA6F/XY125pc0QODsnFxalQ
 5C6yhuyfeChho61bF5LSY5icZAq7hPj48pvluDhl5f34LqFnSQZpptNWdUjLv/sfT3dj
 7TXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYaenO1xn7rpSCJvGJwcwwz38bxQRdB4oJ5IzbkYmYOT3CSXo8CEnnCR+G25GS0yY1ZzvTmeGKidgTO2QOkvaxdjvAX/VmxEXqKQf8GirqJ3M3o2mQTlzHEmUwpg==
X-Gm-Message-State: AOJu0YzfJVCEVvW5b4OvrNfaMSn3Y4oYVFc0HgCACdpMhOUSNhpFxI27
 lWVQQhUJuOS9o3Xpvj1439+HUe5zsOvhOhp01lTu2oJUPS6RJH8=
X-Google-Smtp-Source: AGHT+IFrCvfL9n6yPKeBMFkiGcPzch+iKMhsI4B4uxV73t7dkTZlJu7zAjTytV6KHhjKHlSnd8dknQ==
X-Received: by 2002:a5d:5f91:0:b0:367:83e9:b4a5 with SMTP id
 ffacd0b85a97d-36783e9b614mr4778539f8f.49.1720042277443; 
 Wed, 03 Jul 2024 14:31:17 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264924b03csm3043305e9.13.2024.07.03.14.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 14:31:16 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/intc: sifive_plic: Fix heap-buffer-overflow in SiFive PLIC
 read operation
Date: Wed,  3 Jul 2024 23:31:02 +0200
Message-Id: <20240703213102.254927-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=zheyuma97@gmail.com; helo=mail-wr1-x42f.google.com
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

The sifive_plic_read function in hw/intc/sifive_plic.c had a potential
heap-buffer-overflow issue when reading from the pending_base region.
This occurred because the code did not check if the calculated word index
was within valid bounds before accessing the pending array.

This fix prevents out-of-bounds memory access, ensuring safer and more
robust handling of PLIC reads.

ASAN log:
==78800==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x602000038a14 at pc 0x5baf49d0d6cb bp 0x7ffc2ea4e180 sp 0x7ffc2ea4e178
READ of size 4 at 0x602000038a14 thread T0
    #0 0x5baf49d0d6ca in sifive_plic_read hw/intc/sifive_plic.c:151:16
    #1 0x5baf49f7f3bb in memory_region_read_accessor system/memory.c:445:11

Reproducer:
cat << EOF | qemu-system-riscv64  -display \
none -machine accel=qtest, -m 512M -machine shakti_c -m 2G -qtest stdio
readl 0xc001004
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/intc/sifive_plic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index e559f11805..d2a90dfd3a 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -147,7 +147,14 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
                             (plic->num_sources + 31) >> 3)) {
         uint32_t word = (addr - plic->pending_base) >> 2;
 
-        return plic->pending[word];
+        if (word < plic->bitfield_words) {
+            return plic->pending[word];
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "sifive_plic_read: Word out of bounds for pending_base read: word=%u\n",
+                          word);
+            return 0;
+        }
     } else if (addr_between(addr, plic->enable_base,
                             plic->num_addrs * plic->enable_stride)) {
         uint32_t addrid = (addr - plic->enable_base) / plic->enable_stride;
-- 
2.34.1


