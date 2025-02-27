Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9F9C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnem3-0002TA-81; Thu, 27 Feb 2025 09:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnelB-0007yX-8I
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel8-0003sx-H2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQLxNgYdZM0KSbKDqppJfoYhlJo1A1+kCjsRcdbWf5w=;
 b=TGPc0Dh8XB0NcujX5PrtJB2CNrjNQJQWCM+nhuDA12dQqNrLSgU44E8prPV+1IsaKpPdi0
 zKFrwIt+ehWPRYkbGY/zOZykJHjgJJLG6HRfauknCAtHeNwuAlxU8FDmqZK8QNIGVhDcte
 dNyIy7JNnQQaTyhGnHGCfvucV17oH1o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-r8dWTlaUPMqaMfcGmY5pIg-1; Thu, 27 Feb 2025 09:21:04 -0500
X-MC-Unique: r8dWTlaUPMqaMfcGmY5pIg-1
X-Mimecast-MFC-AGG-ID: r8dWTlaUPMqaMfcGmY5pIg_1740666063
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e4c2618332so1105360a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666062; x=1741270862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQLxNgYdZM0KSbKDqppJfoYhlJo1A1+kCjsRcdbWf5w=;
 b=nnip8UO2AGKeyshov07r2CrDIBYYlEzdQD1u9vnF8mnv2rWmNW4+gC3CVQfNOu5tPD
 SdBrqzX8NxN6mEkaGeanqhNYniDZygT6I0BNpBohIyMC5VTAmuF2+9dBmlosueE9pAZs
 qgSQozUghOVK0EYzaJ7KBUIoihh1jU7foo8IvQVPkCJ6YORVY6DqoMNgzP61uJ1/Nobc
 NI9haKt+C61QjakU+VzPdb7ayy5MTYomiv+9w+j7LuzIsP1v1kDNk3hB+JlQahPWMD/P
 ZOs9bJcQB4OQmWvyHKsL35NJkDDlGHTQFQVliQV6usuvjYVK3oV1Ydkw8MHH2HxnbgSN
 uhyw==
X-Gm-Message-State: AOJu0Yy8OS+tySohcXJ332Xg7foPhqoUyK1CjZ5ZWdobCXxbasLTV5bN
 muZUEix602Z5s5xvytzVaGYT2wHFI4QdLpg/4r2lR2YvY3/V5s3zE9oPY5geptJ/1SFGTklpf0O
 07v1Ff5YSwMjPmCYMwJo3UObMQT2p0UyHlBXOpQ6UthotMo7igX4/uSB8h/fp41gwSjudo/qM7u
 87/sItI0W4PSikEPIKeHgSKFiJkQalg92DMRmEu5g=
X-Gm-Gg: ASbGncvSBxlysvgOc1pZIj/LOJtN/XURYrdyrjcpEeh7aELqjBHjI8IVQNJvwoHL5iU
 xWAWufAJhaQ/egHlo4aq3JAK1eAGJ4Wr1Ezxn8A9kaYPjBdqN9cr4eRRB/CLP2u/skSW68mhdw+
 67npcLX/kGopHIh1Q0ZGalKS2chXEK5nb6JuzhA08L3M1wcQq5anTum7HrxuezL6gTr7BxIE1m9
 gHLx8NJMMmx9Xo41Br2IkXOIFQl3+NO7nVxlJS4fGLzxAVyBDBwImu8ZtKztTrVyvPEsqhiCtA3
 o0HxhQ5MTqDix7uczUDF
X-Received: by 2002:a05:6402:13d2:b0:5e0:2ce6:3d50 with SMTP id
 4fb4d7f45d1cf-5e4a0dfc587mr8748723a12.23.1740666062366; 
 Thu, 27 Feb 2025 06:21:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCxQV2zq3REPKF+9zeoHJgyF+JRF/UdepBUbu59xs1Yz8FPQaNnVqb30lOQv+FZCBkFCVC5Q==
X-Received: by 2002:a05:6402:13d2:b0:5e0:2ce6:3d50 with SMTP id
 4fb4d7f45d1cf-5e4a0dfc587mr8748697a12.23.1740666061853; 
 Thu, 27 Feb 2025 06:21:01 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb44dasm1162171a12.62.2025.02.27.06.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:21:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: EwanHai <ewanhai-oc@zhaoxin.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/34] target/i386: Add support for Zhaoxin CPU vendor
 identification
Date: Thu, 27 Feb 2025 15:19:49 +0100
Message-ID: <20250227141952.811410-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: EwanHai <ewanhai-oc@zhaoxin.com>

Zhaoxin currently uses two vendors: "Shanghai" and "Centaurhauls".
It is important to note that the latter now belongs to Zhaoxin. Therefore,
this patch replaces CPUID_VENDOR_VIA with CPUID_VENDOR_ZHAOXIN1.

The previous CPUID_VENDOR_VIA macro was only defined but never used in
QEMU, making this change straightforward.

Additionally, the IS_ZHAOXIN_CPU macro has been added to simplify the
checks for Zhaoxin CPUs.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250113074413.297793-2-ewanhai-oc@zhaoxin.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34fc..4279cf5cdee 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1122,7 +1122,16 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_VENDOR_AMD_3   0x444d4163 /* "cAMD" */
 #define CPUID_VENDOR_AMD   "AuthenticAMD"
 
-#define CPUID_VENDOR_VIA   "CentaurHauls"
+#define CPUID_VENDOR_ZHAOXIN1_1 0x746E6543 /* "Cent" */
+#define CPUID_VENDOR_ZHAOXIN1_2 0x48727561 /* "aurH" */
+#define CPUID_VENDOR_ZHAOXIN1_3 0x736C7561 /* "auls" */
+
+#define CPUID_VENDOR_ZHAOXIN2_1 0x68532020 /* "  Sh" */
+#define CPUID_VENDOR_ZHAOXIN2_2 0x68676E61 /* "angh" */
+#define CPUID_VENDOR_ZHAOXIN2_3 0x20206961 /* "ai  " */
+
+#define CPUID_VENDOR_ZHAOXIN1   "CentaurHauls"
+#define CPUID_VENDOR_ZHAOXIN2   "  Shanghai  "
 
 #define CPUID_VENDOR_HYGON    "HygonGenuine"
 
@@ -1132,6 +1141,15 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
                          (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
                          (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
+#define IS_ZHAOXIN1_CPU(env) \
+    ((env)->cpuid_vendor1 == CPUID_VENDOR_ZHAOXIN1_1 && \
+     (env)->cpuid_vendor2 == CPUID_VENDOR_ZHAOXIN1_2 && \
+     (env)->cpuid_vendor3 == CPUID_VENDOR_ZHAOXIN1_3)
+#define IS_ZHAOXIN2_CPU(env) \
+    ((env)->cpuid_vendor1 == CPUID_VENDOR_ZHAOXIN2_1 && \
+     (env)->cpuid_vendor2 == CPUID_VENDOR_ZHAOXIN2_2 && \
+     (env)->cpuid_vendor3 == CPUID_VENDOR_ZHAOXIN2_3)
+#define IS_ZHAOXIN_CPU(env) (IS_ZHAOXIN1_CPU(env) || IS_ZHAOXIN2_CPU(env))
 
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
-- 
2.48.1


