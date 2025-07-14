Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E38C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH7M-0007yU-BI; Mon, 14 Jul 2025 07:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzO-0000hG-Em
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzI-0001ay-DM
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpzjtWFSpDez/U9osH7Y6wWYZcHylcUeV56dHdPFJUo=;
 b=NzZzvgAmicL2cA0ej82ll03KvGlohaHrrIIl96pzDZqlhVA7OmRPsA8HhZwk5PPXiYFiEW
 Ceioa4tzL26lSyCL3r3+Sz+kF0BN9Sa9PHbYG+en/Tr/qRSpSrzyaO44yTDjYF1aohAsZh
 uc6bRcUjZ+qtxLp5fFj6uxO3fXuGX58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-zpG4uavCP3uVPw75zEEW0A-1; Mon, 14 Jul 2025 07:04:46 -0400
X-MC-Unique: zpG4uavCP3uVPw75zEEW0A-1
X-Mimecast-MFC-AGG-ID: zpG4uavCP3uVPw75zEEW0A_1752491085
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4532ff43376so38559455e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491084; x=1753095884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpzjtWFSpDez/U9osH7Y6wWYZcHylcUeV56dHdPFJUo=;
 b=PU3hQTp53K2PeDFipKDi9reFhxAsiGD3aEjREbo3d7aKalwdmMFm4a5beMBUiJOnOb
 5Ybf3nQpVbSxoYcSp6f2b56emIv1JIfUJdIK1+xTBxFBS/9DmXkeW7RINcVNetouODoF
 k/+9IqOFYWGMv601sLv7M3UF65xAYKzBa4xb8kp6atxuKp3BHauSJMIlYxWnlhWqEPPO
 MsCmE+RtYz5Fml7hL1ja467+MXkp8VwvqrQGOdGJwmyHHUC7agJIESUgdY+RrEDJo5Ha
 UPktsnvsWMeePpedQ/hb6xl4ARlQYPRUTeG59QfQqtsss1I6KZ+Hqy7z+XQml4VIKDdQ
 yX1g==
X-Gm-Message-State: AOJu0YwbIQZo0QC2U9D/mval5SIawnUAyAKl4jXeiYM0X7HFFaNlhkSD
 w5Nt2/xeAGDda3eQ95AMHyyksoWkoioqWZwP2mHzhgWVOWBQdNufEa8mnI9wtBA9tDqzxNn2glE
 lMQbmxSJrqHeSn1rRUCv9KGZHUkGHsIp7Vk1sDLWtkwwyhhsoc2bQDEj94dhq/TW2gWzet7dkmJ
 a92faQo/Nnw4ePY0uMRHNAj6RIQp4w1x/M0yEFI/IL
X-Gm-Gg: ASbGncsyk0OD71UUZ6WkGYl/YOWKmygY4jQEgKonyYmUV0n+p2YtW5Sz7Ur1lOjB32o
 evcrmSbYKHd1sR4lS2eOo4ml6Ikdrj+J1+yTkKECSPno2r3zyMUoG6rAVRw+3WTU4knZLRTehgm
 /K3y0V8csTGE3kp4urZPbiRwj+GYS8VdN4AJDGhrQvYf7RS1CV24Ui8GCj/l9IqPdDiEGddsnTP
 pYYQs3aOmvZC39JNJh7QY+mqNd2E9DXKaO3ArJESOCyvdTH7VYRemUWEsNTNk8tkOC49v+P48V7
 H9aVecGQGgvGj+Mw4SlJrlnnpk/QjX+boopyAITnFl4=
X-Received: by 2002:a05:600c:34d1:b0:456:1d4e:c127 with SMTP id
 5b1f17b1804b1-4561d4ec409mr18193465e9.8.1752491084576; 
 Mon, 14 Jul 2025 04:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo3K4lSseHXvnH24+hSc89FkJbum17dHS+rRDyjbBi3ORFtjRjOQGWF8vuqhu0Xp5HlHWM9A==
X-Received: by 2002:a05:600c:34d1:b0:456:1d4e:c127 with SMTP id
 5b1f17b1804b1-4561d4ec409mr18193215e9.8.1752491084139; 
 Mon, 14 Jul 2025 04:04:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd537785sm131264925e9.23.2025.07.14.04.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 13/77] update Linux headers to KVM tree master
Date: Mon, 14 Jul 2025 13:03:02 +0200
Message-ID: <20250714110406.117772-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

To fetch the update of TDX

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250703024021.3559286-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-headers/asm-x86/kvm.h | 8 +++++++-
 linux-headers/linux/kvm.h   | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index cd275ae76d2..f0c1a730d9c 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -963,7 +963,13 @@ struct kvm_tdx_cmd {
 struct kvm_tdx_capabilities {
 	__u64 supported_attrs;
 	__u64 supported_xfam;
-	__u64 reserved[254];
+
+	__u64 kernel_tdvmcallinfo_1_r11;
+	__u64 user_tdvmcallinfo_1_r11;
+	__u64 kernel_tdvmcallinfo_1_r12;
+	__u64 user_tdvmcallinfo_1_r12;
+
+	__u64 reserved[250];
 
 	/* Configurable CPUID bits for userspace */
 	struct kvm_cpuid2 cpuid;
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 0690743944b..32c5885a3c2 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -459,6 +459,10 @@ struct kvm_run {
 					__u64 leaf;
 					__u64 r11, r12, r13, r14;
 				} get_tdvmcall_info;
+				struct {
+					__u64 ret;
+					__u64 vector;
+				} setup_event_notify;
 			};
 		} tdx;
 		/* Fix the size of the union. */
-- 
2.50.0


