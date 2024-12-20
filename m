Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A91FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkbN-0005QS-K0; Fri, 20 Dec 2024 16:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkae-0004fi-BJ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkab-000746-TG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43618283d48so17501305e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730275; x=1735335075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYPfEaXLXgiDntyIsctMYItfQ3K/JB1eh75nxaA67GU=;
 b=GqQ1K9V3Sa2BZuRoTrWKGCcmXpF6XGfyS3GAzrkuafaZoeqTeo7Y8QKWdIV0ebo/k3
 sEVrRDhVThlVUsJ2X31Gism1tG6mDf9uXVVQ1lIJSBce+P/50JkPzaTedaqPeum5kvGz
 /fAgdrkdOxcfPLtyT3N2y3wFF33N/amBMmxVhEftQczp3XMze25qrgCREQOoGL6nYEGL
 gEHJfQGcBzlORmsZTkxIUnRa2wxGyw1DPkuQAPExzS0j4Qkcymh/Ezno7Zcuhxjo7dho
 b/3+VEnu1X5u+W0HRM5cbJFeTbK7iUIR+8XBqYLD2IzXPC5EMX7N9b5Mg1n6NH2L7oax
 o0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730275; x=1735335075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYPfEaXLXgiDntyIsctMYItfQ3K/JB1eh75nxaA67GU=;
 b=E4wtKXUtJJQNGZlq1rtZMRfye1PssJbVQxMnP7UKI199/+hhBApyRR3ZpyawhCgULt
 Y3Pg4uXUT7Vx3Tx8Yx8+X6A+YDnjXPs43EzYBw4z1IK6PQ21TeHhXU27EO6wYeLBefSR
 +ydiKJ/vXwidFsmHQhgWA21dP9Il207SpyjlIpLZQ8uIlCgMwCGP2X2H0kDAk++05+LV
 IOfH1auJTMeGJaGngnFotX6xlOekSsLgg3LStyGTUJeS8XPt2pQ720vWKgtca4VxbDoT
 MQW8OCFdUbFckNrNP52K2TvtMqTFUpAm11oyj5G3+9EPqBgIFQuDvRssQPbMjVEpEoKO
 Yovw==
X-Gm-Message-State: AOJu0YzkWjxLIYFJN+P0LfR6yk3o3r3m7/ykNXki3EEk9rpU3AXRaAKL
 qcTWyYPkqqi4L6WNuRvA8ti5Xq0KkqLE9OoGY2Pys1DjJFN+WZubGCKJ0QnzcQKhuVJhZsxixI+
 F
X-Gm-Gg: ASbGncsxtapshCKXkIl+rOQPIL0fbL4RQoylJhKjre5z5E/ru/Cicnni/qL18SrWs9/
 +7zaRzY12svdc5cCqDmoKWRW1BQW2Z+6OQdHS9Ou5sKtwakOETqezTStvHSF9pIlC7tKkXozgRL
 4q6kOj27z1s/oHNw717P6c7Z5tRPhzh3R+EOiA4AHRv+9X5xBkzdhBSMYwz39cv9C8sqv3/FjTu
 uzLsg0/JkARdWlJdOZIQdi2nQbk2tloz3DQbiDpufeghmcjc/w+2T5HgOBAJbOHJsmuzp7qO5g=
X-Google-Smtp-Source: AGHT+IF8W7UQ92zAwegU2Lq3isyluZMCvD1GgayPqxaC1aU/a40Q9S1OSWRkWib1ugmHTBDTW9LWOw==
X-Received: by 2002:a05:600c:19c6:b0:434:f2bf:1708 with SMTP id
 5b1f17b1804b1-4366854740fmr35398435e9.7.1734730275144; 
 Fri, 20 Dec 2024 13:31:15 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661200ae5sm55589035e9.17.2024.12.20.13.31.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 13:31:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 2/6] hw/ppc/spapr: Convert HPTE_VALID() macro as
 hpte_is_valid() method
Date: Fri, 20 Dec 2024 22:30:59 +0100
Message-ID: <20241220213103.6314-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220213103.6314-1-philmd@linaro.org>
References: <20241220213103.6314-1-philmd@linaro.org>
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

Convert HPTE_VALID() macro as hpte_is_valid() method.

sPAPR data structures including the hash page table are big-endian
regardless of current CPU endian mode, so use the big-endian LD/ST
API to access the hash PTEs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bed60afbe22..43220e93c4b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1406,7 +1406,11 @@ static uint64_t *hpte_get_ptr(SpaprMachineState *s, unsigned index)
     return &table[2 * index];
 }
 
-#define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_VALID)
+static bool hpte_is_valid(SpaprMachineState *s, unsigned index)
+{
+    return ldq_be_p(hpte_get_ptr(s, index)) & HPTE64_V_VALID;
+}
+
 #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
 #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
 #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
@@ -2204,7 +2208,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume invalid HPTEs */
         while ((index < htabslots)
-               && !HPTE_VALID(hpte_get_ptr(spapr, index))) {
+               && !hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
         }
@@ -2212,7 +2216,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume valid HPTEs */
         chunkstart = index;
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
-               && HPTE_VALID(hpte_get_ptr(spapr, index))) {
+               && hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
         }
@@ -2262,7 +2266,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume valid dirty HPTEs */
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && HPTE_DIRTY(hpte_get_ptr(spapr, index))
-               && HPTE_VALID(hpte_get_ptr(spapr, index))) {
+               && hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
             examined++;
@@ -2272,7 +2276,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume invalid dirty HPTEs */
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
                && HPTE_DIRTY(hpte_get_ptr(spapr, index))
-               && !HPTE_VALID(hpte_get_ptr(spapr, index))) {
+               && !hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
             examined++;
-- 
2.47.1


