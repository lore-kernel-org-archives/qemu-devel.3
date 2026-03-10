Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51D6FD88C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d0-0001HW-T1; Tue, 10 Mar 2026 18:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05ct-0001FK-Dj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:31 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cq-00073D-Bi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:31 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 c815286c4b03074983df96e1d0d7030ff4df70fcc881aed03da51469ae14a769 with SMTP id
 69b09bf43b0c4bd463bb56a7; Tue, 10 Mar 2026 22:32:20 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181940;
 bh=ie3KnA3zSe/OY4fJXImsWJl/LLtl85SdzvZnziW8fSg=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=j+2zEc0M3k2AwKP5ZU4GYyH/Evfym+xcW9pTiQPpkXW2ULpiKZQCN7CIdyZrL0KBA
 OpbkhKb/wuPezSXD41p/0HiVdyKZjy1S6bkpklX7C8JnU+hRawxme0AjmHYleHD+Wn
 1UAAIuVSVQ5TUJBi3XN5YRVL8ECSd7zr0m2eS9kMMVATIMQGZCg4i+chB/mBg7j6vj
 mTepwhXWuKnwGnqRXA94XGG0jsLXkQ/qrGytYQ5aDwcCKuReyn/XnUFmzhuaFmuCiL
 Axk4fHy1l93SURd2ei9jR55XapohXL7WRsG4TQw6z64l0WVGUnI7yz+49XZLEIBMTx
 mubinykJEtgLQ==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:43 -0500
Subject: [PATCH 03/15] hw/alpha/dp264: Validate kernel and initrd sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-3-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=aPspX5549W/3cl/wYaUIf2kItOZjmjVUFEyp2OsWXjQ=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP5oacYp/1S05/DdpbtnRVR/rKn7J8AtIfX8kWncj
 gOrft9M6ihlYRDjYpAVU2S5fFbirEPu7q60lT/uw8xhZQIZwsDFKQATKbvEyHAgYNfP365yqZ/X
 a15069gpd2WrUqbO20UeFb9SDzw9bO/KyNDwt+CX4ZnfW6xv3w+9eqjeZknNAxstQVaetxf2z1j
 Szs4HAA==
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Add an underflow check when calculating the initrd base address.

Warn the user if initrd overlaps with kernel.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/dp264.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 27fbcee637..87af919895 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -61,7 +61,7 @@ static void clipper_init(MachineState *machine)
     long size, i;
     char *palcode_filename;
     uint64_t palcode_entry;
-    uint64_t kernel_entry, kernel_low;
+    uint64_t kernel_entry, kernel_low, kernel_high;
     unsigned int smp_cpus = machine->smp.cpus;
 
     /* Create up to 4 cpus.  */
@@ -165,7 +165,7 @@ static void clipper_init(MachineState *machine)
         uint64_t param_offset;
 
         size = load_elf(kernel_filename, NULL, cpu_alpha_superpage_to_phys,
-                        NULL, &kernel_entry, &kernel_low, NULL, NULL,
+                        NULL, &kernel_entry, &kernel_low, &kernel_high, NULL,
                         ELFDATA2LSB, EM_ALPHA, 0, 0);
         if (size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
@@ -181,7 +181,7 @@ static void clipper_init(MachineState *machine)
         }
 
         if (initrd_filename) {
-            long initrd_base;
+            hwaddr initrd_base;
             int64_t initrd_size;
 
             initrd_size = get_image_size(initrd_filename, NULL);
@@ -192,7 +192,15 @@ static void clipper_init(MachineState *machine)
             }
 
             /* Put the initrd image as high in memory as possible.  */
-            initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
+            if (usub64_overflow(ram_size, initrd_size, &initrd_base)) {
+                error_report("initial ram disk exceeds allotted ram size");
+                exit(1);
+            }
+            initrd_base &= TARGET_PAGE_MASK;
+            if (initrd_base <= kernel_high) {
+                warn_report("initial ram disk overlaps with kernel");
+            }
+
             load_image_targphys(initrd_filename, initrd_base,
                                 ram_size - initrd_base, NULL);
 

-- 
2.53.0


