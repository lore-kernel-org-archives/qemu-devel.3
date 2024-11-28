Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC83D70DEF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjoC-0007Th-3x; Thu, 28 Nov 2024 14:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGjo5-0007SA-WD
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGjo1-00012h-MZ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732820637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSPAmZ5HAFl4FKfZ+Gw97zq4slJCEYHZjBM9sewyH6k=;
 b=AuP/gobf/n8piYC5SykDNlHHlaqPd+7s6iyw/sE5Z9X8O0jmo7tLLEpjWCAF8XhGUz3xn7
 2sEh0Igap6i2KY/luVgcW1c5utSf959LX7hklmGKhtAocxC0FYZioVykS3ASlRRV2FP4b0
 6cM0AfwcCt1e09LfwTkCwb2btQY8vH0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-vCIspoTxOYq1JCP9qeOWFA-1; Thu, 28 Nov 2024 14:03:55 -0500
X-MC-Unique: vCIspoTxOYq1JCP9qeOWFA-1
X-Mimecast-MFC-AGG-ID: vCIspoTxOYq1JCP9qeOWFA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434941aa9c2so6445205e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 11:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732820634; x=1733425434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSPAmZ5HAFl4FKfZ+Gw97zq4slJCEYHZjBM9sewyH6k=;
 b=j5YFTqM9i8urA4evxFSh2dG1gq4OdZOTxB5t7msoFG9kdoXKHT46xQJEavvqrDUsWe
 HeoeX1IuOxA+d9akqVuDNPM7gQ19KwfRBk0vUKSdXm+WubPrxcUjckLhs5LYfjUAXL9E
 B3RWKfss0bEw697auctR6t2pEbgO+rUtBwHi2WWJ6Aay0Ydarmds+c3L/7y0zL8RpE+h
 4/cmJt8jx/veBo3iSbpFs1YgwoJfzGzmAdSjVFXgPwLPsYo44WeZQCzJM6KDzPfh7V3I
 KQ965kjTkEgI0t0AZhXFUK+lABUea/ILU6nsS56nUgjl34LTCZ6WxDIa0pLky/jPfnLS
 iiBw==
X-Gm-Message-State: AOJu0YxP1n7pHOVRHXHEWX9Qbj8tdYOsR82vHDeunCA5N+Jfj+0EIGaj
 /Rlu5JzgGBLMwouRL7gOtLfvjwCs17g+sHksEAr3jTRv945RWqvHkxcLRT7rHuTy4EK26zc94xJ
 4x60sOHxA1me0ZxLRQAxaOH7WyioKpCLT0jOUlAqtr458y0LZ9KSmF1wb2uncG0gqpa4R4iS6en
 CykkPr98CqAyQUfITmZPXUJY1s9aQ9wfQgJ803
X-Gm-Gg: ASbGnctKKb3TezNO+CnCeGUSru3b34FRjXNXjVRGbwKxInKijsyS43qavFO85rRSmk8
 A4VWA5NqeQ374eRhUjr9Tb/bn0PW6ekSShQRqffJcCA4KgimIZFqdvLi0q+vC6bthOijeyQYjpf
 vQa2lWzlufU7I9vELIX2PV/aNQCzPzMMtdAFg+UHlbuetyKkdGcVy1LqvvuKVG5nzQ3YPHIKzK9
 ZOXfaU2PaSMu3SYIKHeucGSmgSsTbuL3O5m/atY1AphBjsuNr/AKMY=
X-Received: by 2002:a05:600c:1f06:b0:431:2b66:44f7 with SMTP id
 5b1f17b1804b1-434a9df7a8dmr86319155e9.31.1732820633817; 
 Thu, 28 Nov 2024 11:03:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeu6LYj818VoSRBb5RO3+CNSbYGZS6F2+wkLZzdjDKiXwJyusKdOwn5rIV5gbAG2R/jAe5Ow==
X-Received: by 2002:a05:600c:1f06:b0:431:2b66:44f7 with SMTP id
 5b1f17b1804b1-434a9df7a8dmr86318825e9.31.1732820633437; 
 Thu, 28 Nov 2024 11:03:53 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e5285sm61508135e9.40.2024.11.28.11.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:03:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sairaj Kodilkar <sarunkod@amd.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PULL 1/3] amd_iommu: Fix kvm_enable_x2apic link error with clang in
 non-KVM builds
Date: Thu, 28 Nov 2024 20:03:47 +0100
Message-ID: <20241128190349.541014-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128190349.541014-1-pbonzini@redhat.com>
References: <20241128190349.541014-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Commit b12cb3819 (amd_iommu: Check APIC ID > 255 for XTSup) throws
linking error for the `kvm_enable_x2apic` when kvm is disabled
and Clang is used for compilation.

This issue comes up because Clang does not remove the function callsite
(kvm_enable_x2apic in this case) during optimization when if condition
have variable. Intel IOMMU driver solves this issue by creating separate
if condition for checking variables, which causes call site being
optimized away by virtue of `kvm_irqchip_is_split()` being defined as 0.
Implement same solution for the AMD driver.

Fixes: b12cb3819baf (amd_iommu: Check APIC ID > 255 for XTSup)
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Link: https://lore.kernel.org/r/20241114114509.15350-1-sarunkod@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/amd_iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e11..af0f4da1f69 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1657,9 +1657,11 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
         exit(EXIT_FAILURE);
     }
-    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
-        error_report("AMD IOMMU xtsup=on requires support on the KVM side");
-        exit(EXIT_FAILURE);
+    if (s->xtsup) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+            error_report("AMD IOMMU xtsup=on requires support on the KVM side");
+            exit(EXIT_FAILURE);
+        }
     }
 
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
-- 
2.47.0


