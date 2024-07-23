Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ABFC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHeY-0004b3-LD; Tue, 23 Jul 2024 11:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHeW-0004aH-S6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:42:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHeV-0007qs-4V
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:42:12 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-368440b073bso2868261f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721749329; x=1722354129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z+QzS9QA9QvOiWnY8XIiTLDO7LUpB/9AuTBIybu/pEo=;
 b=KJckQogUKng5Dy38/H9ru4LZj9tdySsM/Wee3FcckjmqRpjOlE0xim4jKjkWujx0vC
 +fsPKksko/k7tz+pY912/l0905G+pwS2WA+Fp9DRP/EIufG2QJFmYKk/jKWeMwMafEkF
 53U19xcu/YXLRn03yHVbHMNoaTIu/W6XKH0davUc0KcQC9Hsqp1sc6bd6ks8uAXGkTiY
 Irg8GehmUmO8s0yrBXNJm9yxphXJOw+sZe4hNdk8pq/Mb9W6IVPsSqvUnjohJlwOF1XL
 8sp+6vkl9J7jgK7nrtwwpCFpr4SqEyKWZPl/3gFhmQJAplUdo6vfriEfvENfXpucfY7X
 eb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721749329; x=1722354129;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+QzS9QA9QvOiWnY8XIiTLDO7LUpB/9AuTBIybu/pEo=;
 b=Yl+8KHJNFXJ/C19HdvtEScir2EFfkmsc4vKAOylNi3B/fnrbVYR2KtMpy/kUwSRvNY
 O1dAXG9RfqurRCwgBPi2DjELS9PTOvuWF7hM/ytE9ombLmA2ID9t2wZ9yDJDg3NIKktA
 nnvXKLcVq7zQj1X3CWz0Togzf4vZP4wdmQcvrLQIJHDqJ5wwoGpkn9ivlByGQNRr/6sW
 uZpgqdNNwuW4ABu62pXgBsgfi2rKgvoNrhkgYIp/tjhDmuDnNvTqF9IVbXoUWFEI4UX+
 GgCdEhfoLUVvG8ULc/Lp9ntnAHQXSBhgAZds8J6AeybxTNIFrXq7U3MZZ9rGSlnHbBEV
 TK8Q==
X-Gm-Message-State: AOJu0Yw5jBa899EJ9tcYurS4uVX7FD2Gm+lypEbLD5fW3hnbOKjXI/IY
 MzvsGCztC+OnEcKmjdouf3WQCxLl14jXdKPZEm8FtPOVcXg9qCkbIJe+oBCxDidX4r4eo1HTCv1
 2
X-Google-Smtp-Source: AGHT+IFRlXsHz++WfB7YODqOIAi6LA4seUVxC0ISLmd3ZvoOX59FqKWcmPto1nmLFADTZymRJeLleA==
X-Received: by 2002:a5d:64ac:0:b0:367:8e52:3bb9 with SMTP id
 ffacd0b85a97d-369e3f179b3mr2443752f8f.22.1721749328939; 
 Tue, 23 Jul 2024 08:42:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878694833sm11858198f8f.55.2024.07.23.08.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 08:42:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] target/m68k: avoid shift into sign bit in dump_address_map()
Date: Tue, 23 Jul 2024 16:42:07 +0100
Message-Id: <20240723154207.1483665-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Coverity complains (CID 1547592) that in dump_address_map() we take a
value stored in a signed integer variable 'i' and shift it by enough
to shift into the sign bit when we construct the value 'logical'.
This isn't a bug for QEMU because we use -fwrapv semantics, but
we can make Coverity happy by using an unsigned type for the loop
variables i, j, k in this function.

While we're changing the declaration of the variables, put them
in the for() loops so their scope is the minimum required (a style
now permitted by our coding style guide).

Resolves: Coverity CID 1547592
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I could have just marked this as a false-positive, but it
just about seemed worth making the change overall.
---
 target/m68k/helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 7967ad13cbf..4c85badd5d3 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -479,7 +479,6 @@ static void print_address_zone(uint32_t logical, uint32_t physical,
 
 static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
 {
-    int i, j, k;
     int tic_size, tic_shift;
     uint32_t tib_mask;
     uint32_t tia, tib, tic;
@@ -502,19 +501,19 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
         tic_shift = 12;
         tib_mask = M68K_4K_PAGE_MASK;
     }
-    for (i = 0; i < M68K_ROOT_POINTER_ENTRIES; i++) {
+    for (unsigned i = 0; i < M68K_ROOT_POINTER_ENTRIES; i++) {
         tia = address_space_ldl(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4,
                                 MEMTXATTRS_UNSPECIFIED, &txres);
         if (txres != MEMTX_OK || !M68K_UDT_VALID(tia)) {
             continue;
         }
-        for (j = 0; j < M68K_ROOT_POINTER_ENTRIES; j++) {
+        for (unsigned j = 0; j < M68K_ROOT_POINTER_ENTRIES; j++) {
             tib = address_space_ldl(cs->as, M68K_POINTER_BASE(tia) + j * 4,
                                     MEMTXATTRS_UNSPECIFIED, &txres);
             if (txres != MEMTX_OK || !M68K_UDT_VALID(tib)) {
                 continue;
             }
-            for (k = 0; k < tic_size; k++) {
+            for (unsigned k = 0; k < tic_size; k++) {
                 tic = address_space_ldl(cs->as, (tib & tib_mask) + k * 4,
                                         MEMTXATTRS_UNSPECIFIED, &txres);
                 if (txres != MEMTX_OK || !M68K_PDT_VALID(tic)) {
-- 
2.34.1


