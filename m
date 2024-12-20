Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AB4E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkas-0004uQ-5O; Fri, 20 Dec 2024 16:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkai-0004hy-Iv
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkag-00074X-HS
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso16523725e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730280; x=1735335080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UW2DurBRFq8X0rj+tQILJDXJHVLhDrQlFsO7ozj6g7Y=;
 b=Gr217UP6cud+regX0TGffjI2+oqxyDSEZUOHqmueS2mcas2LLHwLfcg4jbXCmatmS3
 Do/KCq62i+hA0sW168zsFsnsm9S26bBKjsypr53TQbgaxevB58S8BEDITQ2MctM3UAR6
 x6UMHfoaUoTNGP4lJO/CmqNFVEgKLAE70gPmftVPYiDt+rr9KbMv+tJ5w2yziR1bnDQM
 1X6471wTJQOKo5iDSnB5t7am2hun8aS3dmQO5mnRAzlBChv3J0frD842THC2LTOshZ0p
 +TReXX2kZS6Ks7eIMYYz8YIaB0L9LmqCBfAtXRJarcDc7gk/JLyQ3jyqxQlbLMN7g+nw
 pZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730280; x=1735335080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UW2DurBRFq8X0rj+tQILJDXJHVLhDrQlFsO7ozj6g7Y=;
 b=wCQbuzFUgoZMcmwlRszmkW+VNW3cAH0QSbTN9TUNrzfkcz70YWU5aA7JakxdvQGDPW
 YdymsvjmP241RpDkScMPug/5VV2YkEPCsdCF1Z7ku/KE8fVHORCESoGpkcLj4ITSvfM9
 RFfTePmNBioegluey+adnTa6i/Az2UQSx2l4ZeXGEkG1Iqe8oUEt4heXURHSS7HEENZe
 HXZTbcuaKbMbvncfTVmu7AMNslZfU+6NH68SL5xmJn2DiDBidJzYb6zM6jVJ5FEO3MLZ
 vw5iWnzb54F9ZfsKde6aQFz4N/eibZBUtAo8h4rX4Y6DcMQNtgF/TZIYidbld+BA0+Xl
 RDfA==
X-Gm-Message-State: AOJu0YxE+pfB23gsXexED3hZhK7V2nlpGj8RYMIdFEhPRK9Tw/Yk04LU
 VpAR6/YqqxQq1RWSFQlAIC6StcTcfQsupA6/4D7FvLTbIIg7FWehKwaeRb7HJ7iNZ/7ViIPq3uv
 G
X-Gm-Gg: ASbGncu/FA0vIZ/nMCdeG6IEyomj++O5DrWOKO6oSKQBg62h/q/wDqQ2wGlIJaj3g9X
 Kz+qxMSo9afKaEIsEKX8w7SIAGWHVQ2phmVhk66LmbZiyfCmq5vlyTmeSPvkhP3iWEuO5uvgqrY
 8/1J3f/M6Sr3YTQRfSbKCc76BMdlZLNdkxtC7QOKrkLF+3ghhjEyHpjEoZGYKX5+SLLLxG5a+Rk
 oOpJmNLAqhyfJ47Zi0UifuwRE3lcTO2OhxBiEGJCz1ZKlTo06p3yWlN7RgxEVWbm/I6TQjSHrc=
X-Google-Smtp-Source: AGHT+IG6MuKlPerVPzWqn6Bmhy5nHwoVIUzwBmccYDsy7r+CtdLD5SGPTn6dWpHJvLdzKGFa4Qe/Jg==
X-Received: by 2002:a05:600c:1550:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-43668b5f6a5mr35405245e9.26.1734730279727; 
 Fri, 20 Dec 2024 13:31:19 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b442dasm89469085e9.42.2024.12.20.13.31.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 13:31:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 3/6] hw/ppc/spapr: Convert HPTE_DIRTY() macro as
 hpte_is_dirty() method
Date: Fri, 20 Dec 2024 22:31:00 +0100
Message-ID: <20241220213103.6314-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220213103.6314-1-philmd@linaro.org>
References: <20241220213103.6314-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Convert HPTE_DIRTY() macro as hpte_is_dirty() method.

sPAPR data structures including the hash page table are big-endian
regardless of current CPU endian mode, so use the big-endian LD/ST
API to access the hash PTEs.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 43220e93c4b..31df6fdc40c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1411,7 +1411,11 @@ static bool hpte_is_valid(SpaprMachineState *s, unsigned index)
     return ldq_be_p(hpte_get_ptr(s, index)) & HPTE64_V_VALID;
 }
 
-#define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
+static bool hpte_is_dirty(SpaprMachineState *s, unsigned index)
+{
+    return ldq_be_p(hpte_get_ptr(s, index)) & HPTE64_V_HPTE_DIRTY;
+}
+
 #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
 #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
 
@@ -2257,7 +2261,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume non-dirty HPTEs */
         while ((index < htabslots)
-               && !HPTE_DIRTY(hpte_get_ptr(spapr, index))) {
+               && !hpte_is_dirty(spapr, index)) {
             index++;
             examined++;
         }
@@ -2265,7 +2269,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         chunkstart = index;
         /* Consume valid dirty HPTEs */
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
-               && HPTE_DIRTY(hpte_get_ptr(spapr, index))
+               && hpte_is_dirty(spapr, index)
                && hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
@@ -2275,7 +2279,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         invalidstart = index;
         /* Consume invalid dirty HPTEs */
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
-               && HPTE_DIRTY(hpte_get_ptr(spapr, index))
+               && hpte_is_dirty(spapr, index)
                && !hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
-- 
2.47.1


