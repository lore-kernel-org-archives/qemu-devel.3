Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B15E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyfv-0000Fa-Ea; Wed, 18 Dec 2024 13:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfs-0000CL-Lx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:33 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfr-0001mt-4D
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:32 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so45895075e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734546088; x=1735150888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIyUHiJKQfSfPVBPMnG+jU4xHnWZoadB6o95UeG1dIA=;
 b=IhM0eBqHPQ5tF+gnDsIiMo3neml6cC7Cxcu8mKAOM1UMp+Wi7PXQzGssjUrEBrbXoK
 2JHzMORsyuwcOiESV4n1A8c1vwsmN7ezC9haK3E5AMlwO5wlVSPJXkhvm4hmGDkB4Eff
 4ADjkrmYm1MJDle3xoYzF/SyRaWX+kjYfYqC9pjk6qxQgv7fmQ47KgOdEi7w0l/xSt3b
 9Kxp0mznQq5qtlpJpAo3ZrIJQIutJpI3KmlKNyP5DLexC2WaxqKhrPX0f6yeDxUZG4nP
 KSQsC7nnMlwhw7PfN1WjXj1QTG5eAp5ZYEqZhbBOZzXWQJnBinBMPwV4XbUdyn4TWovd
 R0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734546088; x=1735150888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIyUHiJKQfSfPVBPMnG+jU4xHnWZoadB6o95UeG1dIA=;
 b=L9adO3oZ2t3w/Run8l+w0BFUzpmSOFi6pAlyPzSeyr9RteRx8KRRkpPCOZWnpW5cS+
 Ga3N72EE/v6J2TBo9u2cGsaijp9lhuAd6t7oOd4W1bWKijM5Afl3SfGu7INhgaYEgU9/
 E5tCOXTTBYSvS5NC8JOpmqypp+T/XHXGS1H4Dae1oBxvYvdDZSXGn9bWvDuBYxaH8kjr
 uayei6IGfDGo46hmAMhYwL3kkuQk8fSY7gjR+UGAp6+W4LzYdXY+FVK8Uo0QRSQ4WjzV
 5HiF+Mtd5Fo7jTOgE1IlmwT3/8kmE5A+MkDYL8QKhcyZMxbnahjUs4XMB8H83sikEOot
 VWsg==
X-Gm-Message-State: AOJu0Ywf9vbl9F8dPVohPsEgXEE6Ndaq16DhciB+qTil0/COSoVGKcst
 /wWUoT4LGqNwyWh34WaTHY8PYLZbKmRuxJEE8yXI6Lnlq7fVNzAVH3n5WAhXHZlVLwy7SaVH+NS
 S
X-Gm-Gg: ASbGncsOmBx24nMC6uvku8HWVodwTAZbpIioSI8ojeuEGgvhf6hCyC9BlopdzYeX1iW
 LmOsWUrcwWc1AqYhbE3bTr3W/Ix1UcX9d0xsP2Zr62wYTbFFsMQG+9eDTgQ7TD9vWb3Wc8LA7UZ
 +nuHDA+esFWHNNmyKHMuYPnGRvUAye9hbfPWy06jU22jBOjd8FTXZwq7SsDQfNdZNMQC/z/cTeu
 wXKccU8ptW7b5hx/uW4nT3y7b0NCMCDbSC9j90BiKo9/OQ8huur7XXDJaldaR9bGlPK1NKfB/22
 umtY
X-Google-Smtp-Source: AGHT+IEXmpGC9n4kckt6+1Pm4QUWP6DVGZJJ+J8B6/WjU+d+E5TUGwaGdhbsQ48AFQEmtdK0k8r/cg==
X-Received: by 2002:a05:600c:1c9f:b0:434:ff25:1988 with SMTP id
 5b1f17b1804b1-4365cbb450fmr2189095e9.32.1734546088499; 
 Wed, 18 Dec 2024 10:21:28 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b013e1sm27190955e9.12.2024.12.18.10.21.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 10:21:27 -0800 (PST)
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
Subject: [PATCH v3 4/7] hw/ppc/spapr: Convert HPTE_DIRTY() macro as
 hpte_is_dirty() method
Date: Wed, 18 Dec 2024 19:21:03 +0100
Message-ID: <20241218182106.78800-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218182106.78800-1-philmd@linaro.org>
References: <20241218182106.78800-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Convert HPTE_DIRTY() macro as hpte_is_dirty() method.
Since sPAPR is in big endian configuration at reset,
use the big endian LD/ST API to access the HPTEs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b67ab1ee685..5bc49598a97 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1411,7 +1411,11 @@ static bool hpte_is_valid(SpaprMachineState *s, unsigned index)
     return ldq_be_p(hpte_get(s, index)) & HPTE64_V_VALID;
 }
 
-#define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
+static bool hpte_is_dirty(SpaprMachineState *s, unsigned index)
+{
+    return ldq_be_p(hpte_get(s, index)) & HPTE64_V_HPTE_DIRTY;
+}
+
 #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
 #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
 
@@ -2257,7 +2261,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume non-dirty HPTEs */
         while ((index < htabslots)
-               && !HPTE_DIRTY(hpte_get(spapr->htab, index))) {
+               && !hpte_is_dirty(spapr->htab, index)) {
             index++;
             examined++;
         }
@@ -2265,7 +2269,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         chunkstart = index;
         /* Consume valid dirty HPTEs */
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
-               && HPTE_DIRTY(hpte_get(spapr->htab, index))
+               && hpte_is_dirty(spapr->htab, index)
                && hpte_is_valid(spapr->htab, index)) {
             CLEAN_HPTE(hpte_get(spapr->htab, index));
             index++;
@@ -2275,7 +2279,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         invalidstart = index;
         /* Consume invalid dirty HPTEs */
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
-               && HPTE_DIRTY(hpte_get(spapr->htab, index))
+               && hpte_is_dirty(spapr->htab, index)
                && !hpte_is_valid(spapr->htab, index)) {
             CLEAN_HPTE(hpte_get(spapr->htab, index));
             index++;
-- 
2.45.2


