Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95F3C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLR-00043q-Jv; Tue, 30 Jul 2024 05:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLP-0003tp-7B
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLN-0000dQ-CR
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3687f8fcab5so1997966f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332432; x=1722937232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lVuR3ZLOLOt/AiMMURW3eUdzjUzZNpRvpqI9AHUBE2w=;
 b=yPfzRwwXa0X/tc87ftEMJA0//2UCYz/gW8yn3/B+WvfCyAgsy2NlWx7JVUQqP6oUJo
 Il2VCLX3teA+sPEVriJj7/8Ixi5vU1kWLMPLxFpfrZBmwN2FRvmEo8LXMiSYjc+jTaR2
 zX2dFfbD4U8ms1ffXmcqeQuO4aGnDyI9V8TqJLHIvr4pP8VpzVv/a/IugHOOorIeUpiO
 3MZ5fFI6aLfCE97frjf+OODEBNnsrtixrzbHYEaDmLP0hXJ8ZW8tPJRMv+SbRGmgZwbP
 Zxc/hdBPfe1E9pXlHXtUHalx865R8QHHBsG0+XZskUawZjsNKSMSKyzFw+ZDNSdObQ96
 Ry5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332432; x=1722937232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVuR3ZLOLOt/AiMMURW3eUdzjUzZNpRvpqI9AHUBE2w=;
 b=NmMOqms/IS4oolttJRuAzkXoZuhT/5H/9RWXYxVXz+vaab1Tis5mLw6oDELqZqPylK
 SzZkr8gOv1bs7gBflpdXl6zkkFKPdCWMrMErCBCfqgzbUavDHvrxaLjky9BTSxAR56vO
 JP+Dl8wfTxD6vNmPzIg6K6zm3tT50WQxWM71KnYVzmH6xZc6gZmrNs6ckxNI24HTujg2
 4Y5gVF72KG9KeuTGpT8Nf3c3UdjzPYgoIoWnD4MZOh+l+IhoDREmjipVGvzEMbSBwFtd
 E+pkar8QLBquQViKKI2dmwCY4vlye7wItv2m6h4cE2TZYFRQXqIOqY0cdqOC6g/LNkT5
 PbFQ==
X-Gm-Message-State: AOJu0YydkuiNaPySa0g6RfYZJWnPzubW/Z5nspE4+ldnDEie63+b6H/q
 Mc481ovOxleuq7GYsoJWnmtePa1Px1DnvpAV7joXxSi+KwdKpuclcFF15s8RJxxLpMxC1Rg6HjT
 k
X-Google-Smtp-Source: AGHT+IHg2dW/K/bkCA0b2pW4OxpUzaXwuxO+6wxsVEphb8AX+Cb8OluNUB6SQQbkSKgM6W1dhBjrXA==
X-Received: by 2002:a05:6000:120f:b0:367:4383:d9b4 with SMTP id
 ffacd0b85a97d-36b5d093e98mr6188697f8f.56.1722332431836; 
 Tue, 30 Jul 2024 02:40:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/21] target/m68k: avoid shift into sign bit in
 dump_address_map()
Date: Tue, 30 Jul 2024 10:40:17 +0100
Message-Id: <20240730094020.2758637-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723154207.1483665-1-peter.maydell@linaro.org
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


