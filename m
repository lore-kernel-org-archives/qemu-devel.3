Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EB3C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYpH-0003aw-Iv; Thu, 01 May 2025 14:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYng-00028j-ME
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:25 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYne-0008IW-N1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:24 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d46ef71b6cso12280375ab.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124701; x=1746729501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpvMgcrpSQGafRLyw/ZNHAX6/bjj0J9IvQrfqDaCmhA=;
 b=u+E130CvTa2buvbr6Z0GgwjxlAu2d2tHI/wP6ELU0gpT2VAi1GoVKVX+bkQezysorn
 lpIIu6GgfyJoiwDF8amKoqASH72Mq1Fa8YsuphLK+BPG8uUDfVNotVVclNyaLyNO+3ye
 OL3PriK61/juatXKX0KeUhcoaRaICp31VyaQj2GUuSZKojxN5ryD/IDcBkipBkWujQLz
 UpUX4TIAT3uHXJq4UQ8ua7HpZBxyUt7+Q3TXeMjcgDUzeGH+p5mapnUMJ48LERRHEUX5
 j/IEKUKZGwL722/srH08yO16dZJlZUO7XgVIsiO1VZo014jAaB5mKdDkfc6ChQ/8wsYy
 /u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124701; x=1746729501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpvMgcrpSQGafRLyw/ZNHAX6/bjj0J9IvQrfqDaCmhA=;
 b=VkECxNS5kKmO1y2C6I4FaZVvaQ2Th04p4EzErTpQ4Ymkt3IpPX/aVGG7MNiNIAja5O
 EzL4J5virQP15uwmtPmu3vv/vFaQrzWLtcyYV31hAW31jKQ363fLlqRMCs8D+YMGrlTB
 kE2F5T79RIcTbmepktPGoBrmAKeDHWHhPRCgG8AUqcG17JGSEwPtyCUMIAvmRpDm17PN
 DrFNmaFdMf9ASZ8Ygw6Y85o6VAOg6zo3LcIlVI1dJhVtuRP9L3zCMedkMN2ohP0rFsHX
 ryJh1P7BvdsSt7J6ouI0z6Mj2f3KrXxOsC/jCnokrUVB2ZyNHTStUxpF1gc/r2hzBJ9Z
 i21A==
X-Gm-Message-State: AOJu0Yyj4avJnzrHII5YHAaRgzNoyHT3Il6gzGCvWOozLWuZIHkXodaE
 bTb+KVpQgEbQRcvGXh3poGxH+8vihfhvXgFSwOFvnTwPcwMPNZnbbzKUWDDFNB/bNZMFWdMc/af
 3
X-Gm-Gg: ASbGncuvBkce+3bdZy+DVpw/+LHCSRLQ68AMQyq94zmzjG2AgaJoACkUHI+vds1fX0F
 8OzM6vbr3ivFBCFvKmPkiItpE6ZKsMaNH2/QnkkjuDH1KXB6JfMjeT7vDGky05fYXssESNYNQ59
 piwRyBJrYuX0JD2pnylitjrrx0ET1nHjaa6VCz83foDR+u6dtB4Wd9zKAbRu9UZKbhbSxGYI6Jf
 phCvnq1FKOBgg4DfJQYOviwYhntDLJwtALdkchk9NcESnOezsVh4o/uCaQpFMVu4scksh0Zih6u
 qHeDk4zdLRzFJfaGv92aAeLmY7R1l1bSVGJp46wocdxQgZXVDuTTEJWH+6OpnXI1XMRzZMqUmLx
 7Lkzk6OcJujTV3RJu5bHjWhfjrofd/ME=
X-Google-Smtp-Source: AGHT+IHesjngyZIqoY1XhWDgroSc1Qv1/VD7145/jTW5KKe+qQhy+N8XHls82UKCwc/xAtQY8IuwjQ==
X-Received: by 2002:a92:d84e:0:b0:3d4:70ab:f96f with SMTP id
 e9e14a558f8ab-3d9701fc1f1mr38617615ab.8.1746124701176; 
 Thu, 01 May 2025 11:38:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975f6cce5sm2532555ab.59.2025.05.01.11.38.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:38:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 12/16] hw/i386/intel_iommu: Remove
 IntelIOMMUState::buggy_eim field
Date: Thu,  1 May 2025 20:36:24 +0200
Message-ID: <20250501183628.87479-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12a.google.com
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


