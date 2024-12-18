Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8D1E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNygB-0000WO-KB; Wed, 18 Dec 2024 13:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyg1-0000Nt-7H
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:41 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfz-0001o2-Nz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:40 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so1965f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734546098; x=1735150898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRCJLMdgZW3KLUCMhAufUiGlbDH+xCju65D/z9uiuwI=;
 b=Aq4QcoGqVi4GYDg4+PgknSGWQ/RJNaAQbRlrPB64WeGiT//h9EqIZlJdiT9cbldJXN
 WEUQK1IwDIWjh6aqkqEw/clTTVJumZ2ZULIJLz5nKJvzrgnECKMUbVQNggeTXpi1L3h/
 ir8vqQl4hmDSLghm4hz0bGvqVk4HtPLNdyJANEbHP7ZexYJGzHGgiyQysJGwtqhQXaJl
 +jQGhJRa93xkqYaotxk46K913na6S1Zwe1QXUGsIDHKhyYGJp86F15z1e/c8piD/DXBt
 XywNEf/1pugEgt1wJ/WQ2Uq2zrRj48sX+gGmFccFomm7CNJLU4wzXxX6l1GztoSq0Hyu
 ZqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734546098; x=1735150898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRCJLMdgZW3KLUCMhAufUiGlbDH+xCju65D/z9uiuwI=;
 b=cRbKm3lzZvuIOE/s9AwddBKip1Mb0kb+ZNAMk4hh/1GGBqAZ+9JW8hqezQPyfWXAQn
 qeHLgGOj+Y+Eu1Iwp5+31Feu8h7SCRmeG42SIdOHhYKpCEVdN9Ey7fFPKyOjy9VX0219
 bqRdvpwE13Jspo5WmqFffJVnIePI20ern8GdOHGHXmDDA9ohsGnw4Ol6ZEgIsDykzU5a
 EGUE2IS7QVmGPDjc9fhD24lWAGl6M32KeA+ys14OsHCyWRbM8W4csAvJjk7vKTclDSNX
 5sagMym2xYJL+InWQkQ/fuxWtWfKy/yUTK1oNH6unmmYtHelGokTGbRhMG/ILAdl8fSU
 JwZw==
X-Gm-Message-State: AOJu0Yy5mE/0OiMgUh+d9qjeiEtRdwvhdx0/OL+/vstFXX1qvfagrU0A
 92R/H+40XGZr2Xe3VNxcWuANCzKQY3rY52WP+tiq9KLRB4I24QhA0K0u5WzLNXhe70wShtH0DbG
 e
X-Gm-Gg: ASbGncvagP4YaAHq498+2NM8+w4p60M4FzOFIkhaOYNGE83vYs+ekHnhhISLThW93GH
 CRsxLMDXOvIGTxbzMGOq/tQU3NyFbRBNOC8Lf1ETQH+7KtXQQdIXAgaXZupKtrTvkjhiO8h0YZ3
 r5ljf2KBNpw6M/1IJnCOLES72KaPDEeoRjUhT67gpgp9CcLUBr59hQbyvhFQvILHGovt+BBGxEP
 QtLqhd0K7wRBtd4GuJSbtKcrgdmA32jCgU4e9h6JPGAEV2bKQjONzSUCypkpLXobqZzZvFntpP4
 uCfA
X-Google-Smtp-Source: AGHT+IFbd4r9DltG1/C6zUZNFz1g0Ag+9OaCCpr3WZLo4yCOf86bBCAKE9fD0qJO/utrgMPFPFiLLw==
X-Received: by 2002:a5d:6d02:0:b0:382:3efc:c6d8 with SMTP id
 ffacd0b85a97d-388e4d2dfedmr3282820f8f.12.1734546097835; 
 Wed, 18 Dec 2024 10:21:37 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a628sm14968029f8f.47.2024.12.18.10.21.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 10:21:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 6/7] hw/ppc/spapr: Convert DIRTY_HPTE() macro as
 hpte_set_dirty() method
Date: Wed, 18 Dec 2024 19:21:05 +0100
Message-ID: <20241218182106.78800-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218182106.78800-1-philmd@linaro.org>
References: <20241218182106.78800-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Convert DIRTY_HPTE() macro as hpte_set_dirty() method.
Since sPAPR is in big endian configuration at reset,
use the big endian LD/ST API to access the HPTEs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4e1fe832c29..dedf6fb2916 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1422,7 +1422,11 @@ static void hpte_set_clean(SpaprMachineState *s, unsigned index)
              ldq_be_p(hpte_get(s, index)) & ~HPTE64_V_HPTE_DIRTY);
 }
 
-#define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
+static void hpte_set_dirty(SpaprMachineState *s, unsigned index)
+{
+    stq_be_p(hpte_get(s, index),
+             ldq_be_p(hpte_get(s, index)) | HPTE64_V_HPTE_DIRTY);
+}
 
 /*
  * Get the fd to access the kernel htab, re-opening it if necessary
@@ -1633,7 +1637,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
         spapr->htab_shift = shift;
 
         for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
-            DIRTY_HPTE(hpte_get(spapr->htab, i));
+            hpte_set_dirty(spapr->htab, i);
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
-- 
2.45.2


