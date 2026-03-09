Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3A5F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcuy-0004Es-6d; Mon, 09 Mar 2026 11:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcux-00047x-A0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcut-0008Be-4C
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so5666290f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071589; x=1773676389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3AcIpsO3Z8lXw3c5iZUqwV5IA07HcbVKYRak/NRH6Uw=;
 b=jn75L3/ebE2r90VKHhcEyp9HdSEYqgLffOvxip13lyJoob1W2g2PiLUKgIf9d5WBHF
 HWWYjF9MRtViE0qjhpdcS0q1kzQvoboMvSszjDfHAMeOXapDoZjL/HuEb96HLGET+TJT
 UqsVAEGRckptTfiQVNHCbEleb53XzbBbx8ixhVLHTN6VWF67DfLQ4RGFWKH0CSkY8S5g
 /3LKxNnT2T3sOvOrWjCg/PBt6CiAmtaY89bmk+mbot9COrc6fUFSCU0rdOkmVMVF3W1/
 nacLu/r3ha4youM7GXrPJzvEOWXWfj3xP2dMGaR/nH+6iBizP3iLSwEY/wS1yfeAqdqK
 Q0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071589; x=1773676389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3AcIpsO3Z8lXw3c5iZUqwV5IA07HcbVKYRak/NRH6Uw=;
 b=viQquhd6/kzAnGv60x75mjl38JKJO+4GHNdifpCMs/9pPtjnuW9L0Eutxphuo7CFZd
 srqDFyJdUcYk6KUQ1k/Wc3oUyAEreDZuAOcOz3n+TxFRem6NJkEdAox0MT0mToiQYGnz
 XyJVzYdYp1gD3x3iXrKdfcOkRP8ay8nUF1/BCBjxTne1ap3fM4gL2R9csvriEkro2IpY
 4Rdyohkx+jY5Jv7yPrLk0EsxjnWbM+e7NOiLhAX0X+ROOvJJnQcPLC6z4rH3cBZJqZT8
 o+uFXuEgAa/s4MlEexfoImR+C4XYpdwh4NULpxUkqq7UpJSi6QXLPRjHpLb06XvA/fMN
 NFOA==
X-Gm-Message-State: AOJu0YwQuFOpWDXtSugbdhLI3TD20hJoDjYkmwvZo8kiTZn7Hdq3BKzz
 5zUBPaT3vHkB3KpLUQ0jtxa26TZlXICykQpbGZZpPWlNPbtMB75FBDFjir6kJ6+oSP7v086rzM2
 YQ26xKcI=
X-Gm-Gg: ATEYQzwH2HGLTVEKAy6qb3s3yKuzvY/ekuK8udrWb7ItUxMsskZiSXnDIU9dKQePA3o
 /4oKpcxOW328T8Nqbpp3/N+CV7rp5omU+qXe5UaXKWomTkY9/rK0VYcc0lo6jurYLA4XQqzvSvJ
 7DyTpNx16cnD42ZCaA7dXYIn5raik4RJ5j8aik7MEmDqeZlIeX/zk9OXajtBcdc1K76Fm3fhcls
 93rqaTbxBVmmgXbuqG7jN2d0Fr0/5JlkWq4VGU/6Cgdc6G4BOylS8Ab8G/a0MbAIEsZvtdsxpSo
 +AGQdEkCroOhEvTbkrL4iosfld5XbB42plLNZ8DqCBDjK5rNye06/AZx2xhQGQNE1f/MTkJIdIP
 ZW+puTFs72bsfqLgj5AY9LfV7GXiSodq6KCCzqQ4pEMTM1TumFwGDts/7uyRUqwlPZp4SZw4k+p
 MEUrEw+SP+I8vn+9KdeViEi/0CDQtmbNqREAmpF7tNb/cmoRDG4rU6INVRGpXIDZ9lS91ZP9PO
X-Received: by 2002:a05:6000:1789:b0:439:cd10:192a with SMTP id
 ffacd0b85a97d-439eff50330mr173977f8f.26.1773071589091; 
 Mon, 09 Mar 2026 08:53:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae46353sm31745284f8f.33.2026.03.09.08.53.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:53:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/49] hw/i386/iommu: Remove IntelIOMMUState::dma_drain field
Date: Mon,  9 Mar 2026 16:51:37 +0100
Message-ID: <20260309155219.62400-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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


