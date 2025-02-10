Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DD5C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW3i-00080Y-7B; Mon, 10 Feb 2025 10:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2o-0007Et-FM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:50:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2m-0004iJ-Td
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:58 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43934d41730so19145585e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202595; x=1739807395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3JpDb2mBXISvW4UeQqZGI1/QPv2WFhNstUlA8Z8vw/w=;
 b=FusLA1jTO/S5B7uejDcvEGfT2aW+OMBGV/GkOs/Id9BldmwCwunA/UTQz2YN0RwXpA
 76ZcSMonV34dzCKjZ/4t/uE9vF1a2rMeDrENvAirfP02inCMAKI8EjmGI9GgfikV6gpH
 Qrybx6Ht6fn68btAVB5TVIUNQWchucY1OwnlRIBVXBjWrORuY0BlJSPU9DJOy72zFikM
 aRzQAsEsFQs6ANuyj8z9jG8Yc926ksGUkYb0uw46Ka89YCNLTlq8GaNrEx+3Jj/GDzag
 LpAHtP0EJEZg+s3ujK+6/beLHdCgw0XCG9aCMAclQEVjgJ/oh7ExIKHTrx/E8jVBFK8j
 9+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202595; x=1739807395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JpDb2mBXISvW4UeQqZGI1/QPv2WFhNstUlA8Z8vw/w=;
 b=INY/oJbDEgfn96JXVUdEfInjQ5kIuuDvu7i8wAP02vPe903x7c3nMNSwcbgF8KdsBA
 clzL1ww+CcpHIxZgRMhn7LAeYKhzobDwCrq8w93pHV3MWRXgDTz6Po5ygfrA8qrpuUtc
 nbcn1BKZnbNPPhDBvaoP6rejf0vKStWeGmeiCabssYaZ0Y5317rNIye777FUk1So9Geg
 8lgd23hnOeV+zCXUWuVHskSJQ4rKgMH3ahRoQMSt79rYJmTEVgTv2inPpaty4y6Gc+As
 r/BsEL23Ld1xaTUw/PuYi15N+XEgtpQYDqpmgSmtk47/djXQXtliO0M9VBUjMdK92wRk
 LWig==
X-Gm-Message-State: AOJu0YyX6rPKfmf98BR/3ErqWoUFABFSNQStSS0l9NSB9L1DkgFUD/+r
 hpQyaAyKuhKXT6pdtPU9yxOqVJp620EfWsXj3+a7LQPJ+6LrqqwhcLhi6K1Arz0wGG6kRqoGppN
 8
X-Gm-Gg: ASbGnctQvhVaYpTwlPWVoDvBvV1Ed6pK1eDF9BQoRFDvRd6UWpnM/E4HVpRHGXslIlg
 4ExQ7THihgDKusm0kx6PYcsxma+GnbZH1ia8gjr9Rvm5ybz5yNB4X4qV3ApOxLdGUoT5Xw6liKR
 3O0bu6Po9Oc/n5deX5CWLWXqSFFFRISgzzxU+4A2d0u6rUNg4279pb9i44r69GvB1/sVxyBJYWN
 oMcMRUy8S3xYMsudTRGjw4AkO4OmRFzhJsEai88FxH+ammPHKAGG7SS3kGlKrozaD08za0iuhW0
 zOtn1C30hGp2h6bHlu6k
X-Google-Smtp-Source: AGHT+IFh6xUF5DhVPGQy9dcn5DZb7DlQWE9OdX3pXv1qWATF3378Uh7+WyXemhVeHBDIZLU2qrADjg==
X-Received: by 2002:a05:600c:1f8c:b0:439:35d2:ed6 with SMTP id
 5b1f17b1804b1-43935d2109emr70352135e9.3.1739202595470; 
 Mon, 10 Feb 2025 07:49:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] hw/net/cadence_gem: Fix the mask/compare/disable-mask
 logic
Date: Mon, 10 Feb 2025 15:49:40 +0000
Message-Id: <20250210154942.3634878-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Andrew Yuan <andrew.yuan@jaguarmicro.com>

Our current handling of the mask/compare logic in the Cadence
GEM ethernet device is wrong:
 (1) we load the same byte twice from rx_buf when
     creating the compare value
 (2) we ignore the DISABLE_MASK flag

The "Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev:
R1p12 - Doc Rev: 1.3 User Guide" states that if the DISABLE_MASK bit
in type2_compare_x_word_1 is set, the mask_value field in
type2_compare_x_word_0 is used as an additional 2 byte Compare Value.

Correct these bugs:
 * in the !disable_mask codepath, use lduw_le_p() so we
   correctly load a 16-bit value for comparison
 * in the disable_mask codepath, we load a full 4-byte value
   from rx_buf for the comparison, set the compare value to
   the whole of the cr0 register (i.e. the concatenation of
   the mask and compare fields), and set mask to 0xffffffff
   to force a 32-bit comparison

Signed-off-by: Andrew Yuan <andrew.yuan@jaguarmicro.com>
Message-id: 20241219061658.805-1-andrew.yuan@jaguarmicro.com
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: Expand commit message and comment]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f744054a6d8..80fbbacc1e7 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -909,8 +909,8 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
 
         /* Compare A, B, C */
         for (j = 0; j < 3; j++) {
-            uint32_t cr0, cr1, mask, compare;
-            uint16_t rx_cmp;
+            uint32_t cr0, cr1, mask, compare, disable_mask;
+            uint32_t rx_cmp;
             int offset;
             int cr_idx = extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
                                    R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
@@ -946,9 +946,25 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                 break;
             }
 
-            rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
-            mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
-            compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
+            disable_mask =
+                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);
+            if (disable_mask) {
+                /*
+                 * If disable_mask is set, mask_value is used as an
+                 * additional 2 byte Compare Value; that is equivalent
+                 * to using the whole cr0 register as the comparison value.
+                 * Load 32 bits of data from rx_buf, and set mask to
+                 * all-ones so we compare all 32 bits.
+                 */
+                rx_cmp = ldl_le_p(rxbuf_ptr + offset);
+                mask = 0xFFFFFFFF;
+                compare = cr0;
+            } else {
+                rx_cmp = lduw_le_p(rxbuf_ptr + offset);
+                mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
+                compare =
+                    FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
+            }
 
             if ((rx_cmp & mask) == (compare & mask)) {
                 matched = true;
-- 
2.34.1


