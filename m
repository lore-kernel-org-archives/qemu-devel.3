Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DDDD462B9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 14:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBEh0-0005dO-Fk; Wed, 13 Nov 2024 09:50:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tBEgx-0005cF-TP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:49:59 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tBEgv-0003CI-Um
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:49:59 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9e8522c10bso124628066b.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 06:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731509396; x=1732114196;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o9i8rVTiyYcoZex4Ipmw+6Bs18ZPMVTcpLGMM43twc0=;
 b=WUXqXhn1/ap2yRpIG4m/7wXUibuDNeXQ7IVeEfM6yah9ZM5qVpwOsdCLqq8wi7hH4n
 ymr+4/D9F3JUmj3w6mEr/yhlEObSGxvd6sD4s04qpvv2z/st8k5xlaf5zjkp99uwSVgP
 zNb2sEhGAMF4yNX6qY37Su0KjxVqZ49To5zNoMhahzmkaDew+Ynbo6KRhwef4SaH4SrH
 q8Ij1ukBIphcel+y2W3zoslubCd6QrgrvelcElsxKB7aXjEEDozxtSXh+QvXjaz1BKUl
 ZxCyRfBOJnk2uIwJS8KlKYLUbm3TBintQ8zzRMGAzarClkewB1lOcED2SSZ6UqG8FkCp
 RnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731509396; x=1732114196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o9i8rVTiyYcoZex4Ipmw+6Bs18ZPMVTcpLGMM43twc0=;
 b=k7FODWvaHQFw5KiJIWKnAjVC5jLtFSc8D4cEgbrt4bBpxhWsMt+xKqkwhA/ZnHb32q
 dZA0Dq7+iGsNvzsQ0Ogrka5k/CTZ7i9iJiu559v7DVZYKuo+LfUYoqvw0zjgo4KcZ+Cb
 7qLrB048VnA5fQ2SWF+rBnVGgrzZzDQw/yvC5I1CSPNd7kAQ16WMJ/P1DRwB5K50YojD
 yA4IJrY1KSiZ6/W8QabsURN+QP2wzlskJFrkW51ElJU6eZL+OKjr81GtC4mgi1uh/T0U
 V3vM6Pg+q57f0PL/7R71xAAEsI87IYVIV7Nofj1eDxh8YwYrn/r7J2ep6lOf7QX/op9K
 cM8w==
X-Gm-Message-State: AOJu0Ywb8MpZ2XttrPLhGI9c3UttwFHB8nFRv3x5/b9maoz5fXYVmzYP
 wM6Ec5xU7PP1z7IocKHy0hok2AKf8kaNLN1GGJic6HixqM3D5W6VKIPBwndBWz8Pr5q79UWv57Z
 LTg==
X-Google-Smtp-Source: AGHT+IEzPUha6PvG5sjDVmqyHZOgw15Y7y/W4eMrlt2+jPubPDU2xoa5rZ5pp/2iadz7sgiUm0BA9w==
X-Received: by 2002:a17:907:3e16:b0:a9a:cf0:8fd4 with SMTP id
 a640c23a62f3a-a9eefee9b66mr1769121366b.18.1731509396215; 
 Wed, 13 Nov 2024 06:49:56 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dc578bsm885753166b.104.2024.11.13.06.49.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 06:49:55 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, mtosatti@redhat.com,
 pbonzini@redhat.com
Cc: santosh.shukla@amd.com, suravee.suthikulpanit@amd.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH] i386/kvm: Fix kvm_enable_x2apic link error in non-KVM builds
Date: Wed, 13 Nov 2024 15:49:23 +0100
Message-Id: <20241113144923.41225-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62b;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

It appears that existing call sites for the kvm_enable_x2apic()
function rely on the compiler eliding the calls during optimisation
when building with KVM disabled, or on platforms other than Linux,
where that function is declared but not defined.

This fragile reliance recently broke down when commit b12cb38 added
a new call site which apparently failed to be optimised away when
building QEMU on macOS with clang, resulting in a link error.

This change moves the function declaration into the existing
#if CONFIG_KVM
block in the same header file, while the corresponding
#else
block now #defines the symbol as 0, same as for various other
KVM-specific query functions.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/kvm/kvm_i386.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 9de9c0d3038..7ce47388d90 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -21,17 +21,18 @@
     (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
 #define kvm_ioapic_in_kernel() \
     (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
+bool kvm_enable_x2apic(void);
 
 #else
 
 #define kvm_pit_in_kernel()      0
 #define kvm_pic_in_kernel()      0
 #define kvm_ioapic_in_kernel()   0
+#define kvm_enable_x2apic()      0
 
 #endif  /* CONFIG_KVM */
 
 bool kvm_has_smm(void);
-bool kvm_enable_x2apic(void);
 bool kvm_hv_vpindex_settable(void);
 bool kvm_enable_hypercall(uint64_t enable_mask);
 
-- 
2.39.3 (Apple Git-145)


