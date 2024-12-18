Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C65E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyg5-0000P8-E7; Wed, 18 Dec 2024 13:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfx-0000HL-46
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfv-0001nR-HI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:36 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e06af753so3536167f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734546093; x=1735150893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORsHx8jiVKr/JQ5fOHZz0x6Kt4tSSuHxrz6OZHh7sx0=;
 b=B2TLQ3N7HoIBH9zrdYHi6Rfb5UYqTjnK10QN85KtmDbEjlWT5bRf4iPXCZMdPE21Wj
 xBwV+J9OZErVSuJxqFXgJrROyjUSea2J+HZJBlbzwsuPtNfJFoK5xKxIL0+EMLs+GRBL
 QjQ3KaBofe9opnNf0h5rtegBjFBg25uc9C95lnZWPSQNzpUCanx4AO33qPQdSAbU9rvH
 TfL7SwXuV2NWFqQVP5nEic6RWSl9GpZWnIxK5Bm33g5ETqc0DMA4NMt/4rMXWvGx3ARr
 Qz3RLsrvUNKSefB6Xq2P0L6AwITo95wDvf4ghv6y/8Gkmi6SyjCTxr3HATTwSJDprrJl
 4Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734546093; x=1735150893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ORsHx8jiVKr/JQ5fOHZz0x6Kt4tSSuHxrz6OZHh7sx0=;
 b=Ya8R2Abymn2wspVItTVA9uaUVmGoraF0mYIAedwDRTT3n+EtvYD9cEpGPHCYurqJPB
 8CXBFfVDtj3VtCwrCYwSUXYORnANtyESiVmpxujD9spE6c1vXqKWhdO9C+8aL8XI9nAX
 H/OjTs82z7ax6c/JBMqm/WmSrC/9/tK5otsmcw9RcKoGBVcsFy6GrlzbLtfjABO75tl4
 XEOScDSogl6x0kODUqFslR0Orzaqm+fJ9lou3M89RrA+VUq9OZMG8WKb1pT9mlqmmwxP
 2+Rw+eG3uvZ4gswrJderKOS8bR7FQvQfIe0atVY4D5zstN0RdN6C29s98h1UDj54Y5cg
 gGIg==
X-Gm-Message-State: AOJu0YykntNmarYILLIQyyHmTNs3cco3LsHm3VWorbCD1ECkSU8XE6ow
 1uYjVTROOfIVjLok6gxguY9golZb8ukyytuhmkkXH2XAex6Tcx/8F64PHYYnZlmR8wSqkLJw8TJ
 q
X-Gm-Gg: ASbGncsEgGvrufNbEvM9flMKzNuHK0OlQ9NtzKOAXJGN3sjj+DenyFwi26HvOv5GqYS
 /TCHhIdAMo973D1ykolFxY3mgKIzQUSr8GdN9G8iiaL2lHxuZ7pb0iF0tL5EoZapyUNAJWrZ48u
 5XAMjbLl2AHUb5L6oHSI+Nv4ADbE2p+qopoJ+Ian6ztKP63T9u2+5qj0nw6iFs9Lun9r91dajKz
 PciIg5a/Jxz5/CUhZQR9MNYgUBe8O33WkdShFXyoaXS2Kh51W55YBoXaE1093XRf0IF7PtvTyE7
 07yh
X-Google-Smtp-Source: AGHT+IGh3MuKwwak3fbod0s54NHlSaR8+MiLVhr7B8vWBXrEBjGfuxo2ewnNQTYjM4AvogSTpM2vgg==
X-Received: by 2002:a5d:59ac:0:b0:385:f840:e613 with SMTP id
 ffacd0b85a97d-388e4db57a9mr4069597f8f.51.1734546093119; 
 Wed, 18 Dec 2024 10:21:33 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060679sm14498648f8f.105.2024.12.18.10.21.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 10:21:32 -0800 (PST)
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
Subject: [PATCH v3 5/7] hw/ppc/spapr: Convert CLEAN_HPTE() macro as
 hpte_set_clean() method
Date: Wed, 18 Dec 2024 19:21:04 +0100
Message-ID: <20241218182106.78800-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218182106.78800-1-philmd@linaro.org>
References: <20241218182106.78800-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Convert CLEAN_HPTE() macro as hpte_set_clean() method.
Since sPAPR is in big endian configuration at reset,
use the big endian LD/ST API to access the HPTEs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5bc49598a97..4e1fe832c29 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1416,7 +1416,12 @@ static bool hpte_is_dirty(SpaprMachineState *s, unsigned index)
     return ldq_be_p(hpte_get(s, index)) & HPTE64_V_HPTE_DIRTY;
 }
 
-#define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
+static void hpte_set_clean(SpaprMachineState *s, unsigned index)
+{
+    stq_be_p(hpte_get(s, index),
+             ldq_be_p(hpte_get(s, index)) & ~HPTE64_V_HPTE_DIRTY);
+}
+
 #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
 
 /*
@@ -2213,7 +2218,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume invalid HPTEs */
         while ((index < htabslots)
                && !hpte_is_valid(spapr->htab, index)) {
-            CLEAN_HPTE(hpte_get(spapr->htab, index));
+            hpte_set_clean(spapr->htab, index);
             index++;
         }
 
@@ -2221,7 +2226,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
         chunkstart = index;
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && hpte_is_valid(spapr->htab, index)) {
-            CLEAN_HPTE(hpte_get(spapr->htab, index));
+            hpte_set_clean(spapr->htab, index);
             index++;
         }
 
@@ -2271,7 +2276,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && hpte_is_dirty(spapr->htab, index)
                && hpte_is_valid(spapr->htab, index)) {
-            CLEAN_HPTE(hpte_get(spapr->htab, index));
+            hpte_set_clean(spapr->htab, index);
             index++;
             examined++;
         }
@@ -2281,7 +2286,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
                && hpte_is_dirty(spapr->htab, index)
                && !hpte_is_valid(spapr->htab, index)) {
-            CLEAN_HPTE(hpte_get(spapr->htab, index));
+            hpte_set_clean(spapr->htab, index);
             index++;
             examined++;
         }
-- 
2.45.2


