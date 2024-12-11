Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96106E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZP-0004Cd-Pe; Wed, 11 Dec 2024 11:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZN-0003sR-2r
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZL-0000Q9-L2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5J96IsavK0+zLTS8zAT5ylnqyelCMG7OfRE3uftyvc=;
 b=CgNoblda7PuARx717CTc6Iig9VQpXkIUx9/nuSiRu1SBYJMj9EEjC2J76C92ZwZdvlRCYL
 BxCShxsUQXx2LgFzUdP7sYgOm4mW7hcEJ1fv0afrfY1++mGG7nIYmx+S/9kkTwv3yerTAS
 gmBRi8u0Op7uiHy4tzoTH8FHEpSi9Wo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-s2RBuASKNOGSQww_RXLZSg-1; Wed, 11 Dec 2024 11:28:09 -0500
X-MC-Unique: s2RBuASKNOGSQww_RXLZSg-1
X-Mimecast-MFC-AGG-ID: s2RBuASKNOGSQww_RXLZSg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa6a1bf7a82so259386166b.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934488; x=1734539288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5J96IsavK0+zLTS8zAT5ylnqyelCMG7OfRE3uftyvc=;
 b=KQJR1bXjO1SG5/QpZ1zblcxtgkGqp8A9hVt9spVhFrIDkUQ5W13HZUJr8G/Ldbp9Zp
 HKgI/iAJY9nhb6+1BBTCH5ZG1StYL13aDdwZkKHaEs+1NYh3rCs7tPMjau3a7F4fKJ+E
 sRsCYL4j/L4JkIPHG+BDPpBzpF2nIMPcqVWM8hGWqHb1tGWAT2Ah8rngkiwhTvzRds+l
 ftGZmh5CbaDHpHEnK2DnGI+aQ3+KckYhdnaYGwXbV0PItcNggqsZW/Cwixn2Yoq0GE+N
 QFgXnDf0kKfT3MTMpREVyofMU6MkaUn9HpkPHqYi7A/DXOtdbK4Q9nAGIluvVPMapgAT
 SKEA==
X-Gm-Message-State: AOJu0YwRwWDPyXRYtpUW/oWqyE6BoDpMdbuTbJMl9XuB5Gqty6B6m2BK
 VeJxeJ66EmhOKemsFhEDRyyMdqCiunCVTmducOlXVV/XS//rO6/JjTXgsPXz/8kwDFX6mfpeQ8v
 yRK/r9NZg7ARD2zXCIF4UD0OuWQIcJ7A7Q+fPSFz7xZW+KmckzaAe3mM4bvy+7bQcdgHiLJxpif
 E1z0ZrklLThSfa5WebqtwUMWhmSBWUzu7FgZ9X
X-Gm-Gg: ASbGncu4T0KrGAvEy+4K4Gt5nwonhS56owjhv1z8r6HlhHJUo+GxCrVv1i7n6y6INh3
 B3AzIYW+Qkmy3mJi/WqY7WoFcCqdXtrgQZcMlKudT9KPZTE6OSxqtVtwT24vfE2tT9yG19AMsnG
 u4OACEcLCKT5Ny285Jf/GYM4lA0z/FvqxJGCPfF5BRRSimrZo35wDK85biApGTk0Sd03e5+hmcJ
 WM0J2cVRGKpAeyMrA3BxbWCJ9jzAHhDZBP/VPlYfG4kYgrWGwrbIlQt
X-Received: by 2002:a17:907:b1b:b0:aa6:b926:c102 with SMTP id
 a640c23a62f3a-aa6c1cf1b14mr50108366b.43.1733934488227; 
 Wed, 11 Dec 2024 08:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn1Bo58DoK8n8mo0K3lhk8bd2RzSerin38VigwmRR8DfvHf8J4ZxtUTLl0sbJ7UCdBG9xcEA==
X-Received: by 2002:a17:907:b1b:b0:aa6:b926:c102 with SMTP id
 a640c23a62f3a-aa6c1cf1b14mr50105166b.43.1733934487777; 
 Wed, 11 Dec 2024 08:28:07 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa68880b344sm480539466b.184.2024.12.11.08.28.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/49] kvm: remove unnecessary #ifdef
Date: Wed, 11 Dec 2024 17:26:48 +0100
Message-ID: <20241211162720.320070-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm_i386.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 9de9c0d3038..7edb154a16e 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -13,8 +13,7 @@
 
 #include "sysemu/kvm.h"
 
-#ifdef CONFIG_KVM
-
+/* always false if !CONFIG_KVM */
 #define kvm_pit_in_kernel() \
     (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
 #define kvm_pic_in_kernel()  \
@@ -22,14 +21,6 @@
 #define kvm_ioapic_in_kernel() \
     (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
 
-#else
-
-#define kvm_pit_in_kernel()      0
-#define kvm_pic_in_kernel()      0
-#define kvm_ioapic_in_kernel()   0
-
-#endif  /* CONFIG_KVM */
-
 bool kvm_has_smm(void);
 bool kvm_enable_x2apic(void);
 bool kvm_hv_vpindex_settable(void);
-- 
2.47.1


