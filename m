Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8370EC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu2r-0004zp-S1; Fri, 30 May 2025 03:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyI-0005KV-TS
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyE-0007I2-9W
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6rnhF8ccsOc0IyQOQ+kTTtn6LraXj7NKQVTXhIToBM=;
 b=PjibNmhoZHq3k73SMEyhF+W7G5ktKd0NM/lqssegsWC9mlD+EZe2pcG+yxgxJTDJ1YRkR2
 39oAiQjteI7TIyhNgcRxWwOzs8hkXpzauQabrwF+ifUpnqnMc+O54P4e+gCeage1PsnED1
 QQEHjYA4mr9+JYxRAN1PMj0LbHGO9BE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-ZrLWcXsSM4OU7OpKQaQDOA-1; Fri, 30 May 2025 03:16:00 -0400
X-MC-Unique: ZrLWcXsSM4OU7OpKQaQDOA-1
X-Mimecast-MFC-AGG-ID: ZrLWcXsSM4OU7OpKQaQDOA_1748589359
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-604e837c1deso1448168a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589358; x=1749194158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6rnhF8ccsOc0IyQOQ+kTTtn6LraXj7NKQVTXhIToBM=;
 b=PZGtlRoCL0XsrIsSu0Ql5JhUKN1tSOumlcJm5puJ8OcUvMTkFsO1eAemAlgjXxQEtN
 YOAHY5GGzIdVJklQL/Yiia2xfUuLBz4dcHMxiKCNukZS/C2uB7NWeLALP1+9XN4+sjj/
 OW8mdDd5XMk/kDMVuavOSK8U9qOxlquZDLiy1dGlbgk+LQc/1iQnWaZZawjrPKbfaUAh
 XlC8tkZLCAZVxBGa6t2xYO+C7K8dXnWNXeUny0xjODBxzfKGLxKKZxlajo/eDICAt8t6
 a1RFVEc9QavF4HSDSMg9oAIXkxBABpMyYyZjeg6FThjzybUL8Al2mvIcGXLAxkTL2xVR
 q+QA==
X-Gm-Message-State: AOJu0YyQioEdW+ojakVGmUl73T4UCBQFEtqAlZKauIxhcf+OJHn1vuwh
 cqozbL6K2HzM5ZLHfdz6/W9hSQcdPcgPOAf6xIOoLf4adiu4U65Di9AXw9Koa9pKe1P3X5RDhN2
 HQIIDrS/JcSJqEiWQHxErUW25wamKZfc++enDCzR0zwslmK/04VIC37+Z8erlNt/prQPiAMjETs
 HUwJhz7wvJbctuAwVKqPh2VpS+Nymq4LdRVb1nRMWy
X-Gm-Gg: ASbGncs5ZY9J9Vzpktwq+n4BKjRHWeijVnCHjfvGEp5YGIjbulEoi3JqJKTLPMlO9hm
 L0cJnOr8SzvWefmYbSH8gfiDKu5ds2eE3sj/mx64PPvk5Gs1jW/UBmVOYekRJmW1W2h0zjc28Sc
 oX7kskdg7b9VZ/Jvma8DMu2HPrAIQN2FSu8CUFknGyYwr5CoWWl4zexLObYHmAFgIRd33Ju3qnv
 m3JmwneU3FMMULM63Wy8AZHOaSRao4/eXzIlVHvf4aGpB3S7abHnxZUequFg0AK91AiM4g3Kpa+
 8eeM849NLDCTdw==
X-Received: by 2002:a17:906:36d9:b0:adb:3509:b459 with SMTP id
 a640c23a62f3a-adb3509b66bmr95755266b.19.1748589358280; 
 Fri, 30 May 2025 00:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+TFC6Oz/9zd5Gy/05edUDG01AbUyet40d1cdAwasS+2wxVbEN7jmo6+R7BK9+MtMMeMNx/Q==
X-Received: by 2002:a17:906:36d9:b0:adb:3509:b459 with SMTP id
 a640c23a62f3a-adb3509b66bmr95752666b.19.1748589357752; 
 Fri, 30 May 2025 00:15:57 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fef58sm275090866b.22.2025.05.30.00.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 74/77] target/i386: Add couple of feature bits in
 CPUID_Fn80000021_EAX
Date: Fri, 30 May 2025 09:12:44 +0200
Message-ID: <20250530071250.2050910-75-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Babu Moger <babu.moger@amd.com>

Add CPUID bit indicates that a WRMSR to MSR_FS_BASE, MSR_GS_BASE, or
MSR_KERNEL_GS_BASE is non-serializing amd PREFETCHI that the indicates
support for IC prefetch.

CPUID_Fn80000021_EAX
Bit    Feature description
20     Indicates support for IC prefetch.
1      FsGsKernelGsBaseNonSerializing.
       WRMSR to FS_BASE, GS_BASE and KernelGSbase are non-serializing.

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/a5f6283a59579b09ac345b3f21ecb3b3b2d92451.1746734284.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 4 ++++
 target/i386/cpu.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 22e82444aec..1146465c8c6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1092,12 +1092,16 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
 /* Processor ignores nested data breakpoints */
 #define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP            (1U << 0)
+/* WRMSR to FS_BASE, GS_BASE, or KERNEL_GS_BASE is non-serializing */
+#define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
 /* LFENCE is always serializing */
 #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
 /* Null Selector Clears Base */
 #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
 /* Automatic IBRS */
 #define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
+/* Indicates support for IC prefetch */
+#define CPUID_8000_0021_EAX_PREFETCHI                    (1U << 20)
 /* Enhanced Return Address Predictor Scurity */
 #define CPUID_8000_0021_EAX_ERAPS                        (1U << 24)
 /* Selective Branch Predictor Barrier */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d01a808e3a3..0d1b9077788 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1253,12 +1253,12 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0021_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "no-nested-data-bp", NULL, "lfence-always-serializing", NULL,
+            "no-nested-data-bp", "fs-gs-base-ns", "lfence-always-serializing", NULL,
             NULL, NULL, "null-sel-clr-base", NULL,
             "auto-ibrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "prefetchi", NULL, NULL, NULL,
             "eraps", NULL, NULL, "sbpb",
             "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
         },
-- 
2.49.0


