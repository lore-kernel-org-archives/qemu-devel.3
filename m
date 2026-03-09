Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011EBF417F9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbyi-0006uY-GC; Mon, 09 Mar 2026 10:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwk-0004Gx-Eg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwi-0005j2-9a
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-485345e1013so11272155e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067858; x=1773672658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AcIpsO3Z8lXw3c5iZUqwV5IA07HcbVKYRak/NRH6Uw=;
 b=ud/x5TMpTyZ0wTucsIf5qPGjITJfK+VoAUowB5e1t2yfWzSuXvhLywxO9uB/fQCHBn
 QV3532I3OEaQ5O9j1FFxK6897QHZcKwrPlLddfFbdc41TAypUbOIOwYgbZssk2/qpIaf
 N7zP8uvVyu003a5mQcCjsv9oQDq0fGDIfsE+tP6EXYkqPE1gspQuVjq69KvU5SzAxlHA
 5/wcLyeWu5741Espo7Hrlg86ozwnstm3JCiOXzATrTbyO3LTCIw0rJT8oO0Axg1aOTJT
 GMPueaSk+g8DcjhFSpx37poejLaJZoG661fzduxroCTDGmIEHrjDnwTLHlhqg1nVyHQb
 UGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067858; x=1773672658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3AcIpsO3Z8lXw3c5iZUqwV5IA07HcbVKYRak/NRH6Uw=;
 b=RkG2n46SbX1lK4OQ+hk9Ar8E5xUc1E1Lhobo4FeqqHq+kuyheBy6fnXSfEudgAjtyq
 QffD2monFV0LqFNhb6RWuxv+P9dWB8e/9Y3WAcu8tPOKY412birJjtSXcXSocMA6+Hmc
 PbOyQyUS/O0HWkbkvTxAlJdKVHRHMEKjO0nfneF3vOXcmSbLdSn0PxyQRqzpKXM6N/mn
 92qvlb7UBmIR13Ri9QV62vWckV1s4OGSbBNB/G9nTMfGe32F1TQ/0tGVADtkeIyRXGiI
 hv1fQ0YvuOUynxDL+J4acSChbzM6ND8Lnetip2+Tj0nh605+24hOHhn5jUf7Xdzk78/y
 rHuA==
X-Gm-Message-State: AOJu0YxrU3FfkZXXAmGptNp1NDPXA4FxsiGFW75A4Q2yoml2TLQp3b27
 mYI0hWqLdkOtp+EnO+Ljl0urXi6gL0u5KalZjuDeETFapdhc8zBIsgxJPbNMG1EfKQ3QAwjXPXf
 nVnm+52U=
X-Gm-Gg: ATEYQzygVXNLiedgZe17UYzP+YN6gjAKH6CUC2FHMFuRq9ygz/bFYL7bxvogmbLutwm
 HmtggZckD1vC70tBdNm36fR3fkEmIR8KeWN+x+gprhA2Lviq8FLHrspC/tEftBtb4AvG6HKDhmc
 JmBNx/1nZdwR0PvmYyLsukl4nxS5sXUN4E04rkwV64UHd1GTOHijkdktfHRB/qQ9Bq0lbYbVyAg
 ggO8hKJ3qu3zfa6OrYrBtsGkUpqmxtdWNYoLqPlwIB1dOnycO9ww0gTXhONRtG4WuR6LIsOcH1/
 zn1cE/8hg3YFvuM6tnfQF+UctkzUTiLodZtp/EGT+CRg2EWZn4zeA1QcqMg5gupoMPeFI2+EmrP
 3bwd/FN2+vs3Wvy0ToXOXNz3w60Uq1eGuFweJDMFlUxjzWQYfkzcAUZJzq9Blrn/Kgq+Ffqa/H/
 uzeNXx6ZGR3GRAiPjwbgCpJTz8HudXur73nxjUXTKlJhMlyFRhoDIwvItWq9S6QSsxhnqeLVTOT
 DsR8g==
X-Received: by 2002:a05:600c:3b9a:b0:485:3c11:de84 with SMTP id
 5b1f17b1804b1-4853c11e970mr48744735e9.14.1773067858248; 
 Mon, 09 Mar 2026 07:50:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853f8f9938sm10968895e9.23.2026.03.09.07.50.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:50:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 06/10] hw/i386/iommu: Remove IntelIOMMUState::dma_drain
 field
Date: Mon,  9 Mar 2026 15:50:08 +0100
Message-ID: <20260309145013.44327-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
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

The IntelIOMMUState::dma_drain boolean was only set in
the pc_compat_3_1[] array, via the 'dma-drain=off' property.
We removed all machines using that array, lets remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-7-philmd@linaro.org>
---
 include/hw/i386/intel_iommu.h |  1 -
 hw/i386/intel_iommu.c         | 11 +----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 54c2b6b77a0..e44ce318417 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -314,7 +314,6 @@ struct IntelIOMMUState {
     bool intr_eime;                 /* Extended interrupt mode enabled */
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
-    bool dma_drain;                 /* Whether DMA r/w draining enabled */
     bool pasid;                     /* Whether to support PASID */
     bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d24ba989bfc..f395fa248c0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4205,7 +4205,6 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
-    DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
 };
@@ -5000,11 +4999,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
-             VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS |
+             VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
              VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
-    if (s->dma_drain) {
-        s->cap |= VTD_CAP_DRAIN;
-    }
     if (x86_iommu->dma_translation) {
             if (s->aw_bits >= VTD_HOST_AW_39BIT) {
                     s->cap |= VTD_CAP_SAGAW_39bit;
@@ -5582,11 +5578,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         return false;
     }
 
-    if (s->scalable_mode && !s->dma_drain) {
-        error_setg(errp, "Need to set dma_drain for scalable mode");
-        return false;
-    }
-
     if (s->pasid && !s->scalable_mode) {
         error_setg(errp, "Need to set scalable mode for PASID");
         return false;
-- 
2.53.0


