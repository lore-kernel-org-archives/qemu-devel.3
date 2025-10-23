Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45620CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtt0-00063g-Pb; Thu, 23 Oct 2025 07:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtsz-00061l-EF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtsx-0002dp-LD
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711810948aso5403135e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220418; x=1761825218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jshA5o7CtEOKbvk7d/DMpS50wl/NlFslnNDFO+dEz7Q=;
 b=keBuBCSAcZLGjZltJ+oIDoEBHmlaN98PIzt0Ij63t2GId3fFebCyLEziPeDwVqOMaK
 Wop0+zonish848SuTFudpbH77FHsnfooKqV0NJuI88yDMN356hnGJM9rViShZDIquXv0
 yuqFUxdzJNa0QikPAj9CMTAM1RKE8Z7RiuAJvfnrPmyVRH4CaiN5Ky/DCoOg1CPlzpdg
 CmYngSajrc6d19knlJOTAJHP5jVLxEApZNxZuxLnWlQ+20SrO4Bz0wyNGUr595ZjRMjT
 877j67qCLWTKLD+/y44+JUToF2O0InzgOPAFLZYBal34QrQ4HcI9cFN9LhczONEzxuLh
 e9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220418; x=1761825218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jshA5o7CtEOKbvk7d/DMpS50wl/NlFslnNDFO+dEz7Q=;
 b=sPgvkuN22sG1oxDUnTVGKpqgyqQwJlSDF7BMR52UT6+KC0US15i/8JIhpomEvDoTAr
 dOWLDZGktHJL6v6YshaJlv63FkBuACUiSo+4s5TZsoOmNJb3z/k7gCJ/4kemjb7j2Tl0
 qd7uyJg7A9NePbjbxiy/J/Rcq8w67olhByiANDqR3E2OrVqgavDam5CK5G9PL+JbrjTO
 3hTR2KBrZi0UioFtkxqT4Sl2GF1WBHZrEkkYm72rxGIBoLDE/gkzKKHHg5sreCXxsmSJ
 UK+viWGqEoDwCodg2sXbYkZfpGbpawkGTRwk1b7f2w0I/NfDVCZqMcEKPTHUWHHHPDeu
 dJbA==
X-Gm-Message-State: AOJu0YzqmTo7aBBsFoCRRDhtv2TfKYPy7UzplwvNiNPlVK+qzfw/5Lhf
 jTFv69d+UfGS8FX+jk/T9z1iOSAiO5sRZ8+MS6GD4eOkZk7zZfyzrAEMjmy67kSMJ/YgfSH6yiG
 8rVcyOMQ=
X-Gm-Gg: ASbGncvRP20FxfPtC6HOeBsUwPvmpmGrgpKMEniRu2V50+U58AqOO/tYvynAUdpL4by
 7IMFYhVM5a9oGFmBSjM4i0NvakWE5+ICx3rfluRgRqopMDaddy9+xseS/ZyfHNUWMzg+dbLFxo3
 XAtCdxO+j186gWw2vWky2DBwL2PzJFN98LFyoplCHpIIHNmjhjuRh14NKy95V4anrrv25xaNa5Y
 0hO0bp/E6XNHmmooyR7a1DBerpNgR3xz1+39EdSqJSoFTrPYBnylunngy5k+jxu6/Aa3zRnkaF1
 ZRaZ5vMsk6mUK+Nro/xcvJhYT+L5UpOmPU0iRXLQ0zk9xPU8yijHEIX+GJ+SFIrLBR2QjLv6mHS
 nGZc76BrdHV5eA3W8LOsDV/LCwFkJlWC/hylaWTernpg7ScKb+KeHYSKLASt6377jUK03w3Woc4
 OakBU9SVbE4BrZz0sGwN+QYKC4F9WOiaXXaQzgk0ZGfA6RT/pjvLTmEPRMdKaf
X-Google-Smtp-Source: AGHT+IHaU2J2Y0fXpHPGiSVNyAuA3Nwz8U1ThUfeJSbttC2L5bqChf8gIbR39Q+Up+sN8xKSD+FpWg==
X-Received: by 2002:a05:600c:3b05:b0:471:d13:5762 with SMTP id
 5b1f17b1804b1-471178761bemr170274825e9.4.1761220417696; 
 Thu, 23 Oct 2025 04:53:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b5esm108570225e9.15.2025.10.23.04.53.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:53:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 35/58] target/i386/hvf: Use hvf_unprotect_page
Date: Thu, 23 Oct 2025 13:52:46 +0200
Message-ID: <20251023115311.6944-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index ab59381b500..aae4877d568 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -139,8 +139,7 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
         if (slot->flags & HVF_SLOT_LOG) {
             uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
-                          HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
+            hvf_unprotect_dirty_range(dirty_page_start, TARGET_PAGE_SIZE);
         }
     }
 
-- 
2.51.0


