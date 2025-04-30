Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4429C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8Ox-0001FG-70; Wed, 30 Apr 2025 10:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8OH-0001Dx-Sd
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:26:26 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8OF-00075f-3d
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:26:25 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c597760323so809354685a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023181; x=1746627981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpvMgcrpSQGafRLyw/ZNHAX6/bjj0J9IvQrfqDaCmhA=;
 b=EorfgvUiqlOHDcrO4TCvkJrha4KJqb70ushd/NHHSbA6eC3KGB0MoGnWOcwgj53kbH
 aCL1p9G9B5qGt63PXkzn+5/HrUEEJjzGyFotyAEe3DP7Qp5o40gW4YdbG+7bYzctZJB1
 qAz7kOu5TRzO+Y+pH8GVWtqvG02sQAkqq322S2Q2bKVfD/Gzf90hZEUOvPGOahp6TXdB
 GcNFmvJ80oxJcjfeNISkBfqROBsit+D5E+eR/VGS6FnfwYu5NH5Adclb6V3HN/fm3/LU
 wLZlei3AQRGuk1kfsN6vokcoiTE22hah5pMyQ5YqAD9UUtL9nNXWRxuqaKrtiZxwU9Dr
 wUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023181; x=1746627981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpvMgcrpSQGafRLyw/ZNHAX6/bjj0J9IvQrfqDaCmhA=;
 b=sYtzstLiqT3DAeDPgTppdbSeuzyVJMS+vGkIo8kQUVLNqndcmNHOMQADqa5x3MVX4d
 5YGH8u55AIjP+IxbQ15aEP4soHyXlX80Dga9sBMXAAZG1R59pO8viD/puuFbz0kmEPCu
 dTGCe6h/oeDSx/kPPyWnsXhtmTGJkavCR8naprQ8OPwChcm84BvefPGWWRSquqkTFPCR
 DC5ejOIEDJTUoAMbNq4nmLcqdx2kKBkVlWJxnGYpLIUnyVFNa8wL7atdvxiJv9GEsK0s
 zBb1MLYn6dJoKiMAIbnhwR1YKZD32i4yyRVVYDkuI08miZJVWR3DUXMqzp+BKzfABJjP
 uSYg==
X-Gm-Message-State: AOJu0Ywa4xxbgvT2jjA34uDbJJXIB//VC8K0WILtfUYJowTpqvCnlUGy
 LUYL4mpaHeQAdmw3z1WUfVisLlxOCUwcIv7Dy8BOLasyrfnXWXh0+cn3MFgfqPrV0dZ8dRPz6KV
 l
X-Gm-Gg: ASbGncsWOdWLP8dPdIHRjMfJse5YxS9OHamcQij0M6LwrUs7YZ6g1W87kymKiT4axcW
 Y2aFVW9pH/eT2/drozlTjJdDFj/qGD9Kg2joZyVQVQ9x0hPLZ5Epg0hwEWUhbD/3gdYyQJ3OgPS
 7FvkGLNm33iaKtlejUa9gjnB7Nwd6reeiOAOUS11zupgbklnADKpos3AHH5Mzj34zvnXNbf0ZqH
 YH3otif0vjdTBrjCcPfK7u5RDnEVZSlhNN+GDdy8o9WMw5XkbF3MMtgbsnPcxc2XgW9LscHHL5k
 nJw1Fz8YZsuTlZJJ2yjDCn0EqV62TodUJaaWkVquNkDQuLfs9UU0J3n4D10nNcVCarA/BC4hr2c
 s/TisaID3aTbwPe8=
X-Google-Smtp-Source: AGHT+IHhrFJ901CyS8hrsRsuGE/sjPVG1T+2AFQNRh7YNsqAy6Pm1hzqNnUiWs355IiUdpSDsoPzow==
X-Received: by 2002:a05:620a:1985:b0:7c5:95f0:e776 with SMTP id
 af79cd13be357-7cac740f35cmr442128685a.1.1746023180741; 
 Wed, 30 Apr 2025 07:26:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958cac816sm858406185a.31.2025.04.30.07.26.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Apr 2025 07:26:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim
 field
Date: Wed, 30 Apr 2025 16:26:05 +0200
Message-ID: <20250430142609.84134-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430142609.84134-1-philmd@linaro.org>
References: <20250430142609.84134-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x732.google.com
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

The IntelIOMMUState::buggy_eim boolean was only set in
the hw_compat_2_7[] array, via the 'x-buggy-eim=true'
property. We removed all machines using that array, lets
remove that property, simplifying vtd_decide_config().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/intel_iommu.h | 1 -
 hw/i386/intel_iommu.c         | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index e95477e8554..29304329d05 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -303,7 +303,6 @@ struct IntelIOMMUState {
     uint32_t intr_size;             /* Number of IR table entries */
     bool intr_eime;                 /* Extended interrupt mode enabled */
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
-    bool buggy_eim;                 /* Force buggy EIM unless eim=off */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
     bool dma_translation;           /* Whether DMA translation supported */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5f8ed1243d1..c980cecb4ee 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3823,7 +3823,6 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
     DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
                             ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
@@ -4731,11 +4730,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     }
 
     if (s->intr_eim == ON_OFF_AUTO_AUTO) {
-        s->intr_eim = (kvm_irqchip_in_kernel() || s->buggy_eim)
+        s->intr_eim = kvm_irqchip_in_kernel()
                       && x86_iommu_ir_supported(x86_iommu) ?
                                               ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
-    if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
+    if (s->intr_eim == ON_OFF_AUTO_ON) {
         if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
             error_setg(errp, "eim=on requires support on the KVM side"
                              "(X2APIC_API, first shipped in v4.7)");
-- 
2.47.1


