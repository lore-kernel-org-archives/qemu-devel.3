Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EE9C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnem7-0002t9-HW; Thu, 27 Feb 2025 09:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnelL-0008N3-F5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnelI-0003uf-Fj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cVvubKkZS2BJDfw7tQbs/X69Fi3+CKEkqZrpaVeftvc=;
 b=g9sTrzpxdfZELWJvCWLOPJg90D5ZVmYqFqzg+p0GDsKvpYE04XychCv07pyc7FPVs6qd1n
 VLREVuxuuuZr9oX8eY8SQE7Bt3/gmKud6V+Dn03YaHVMtI72+6ZumYxf0S6VrVtYuSUaXm
 Kx+JON5Bpwoz9nuCIlSWFLjI9AQTEZk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175--vbOxG-CMu-0UZz25Loznw-1; Thu, 27 Feb 2025 09:21:12 -0500
X-MC-Unique: -vbOxG-CMu-0UZz25Loznw-1
X-Mimecast-MFC-AGG-ID: -vbOxG-CMu-0UZz25Loznw_1740666072
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abbc0572fc9so133364266b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666071; x=1741270871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVvubKkZS2BJDfw7tQbs/X69Fi3+CKEkqZrpaVeftvc=;
 b=AxcnflNndxHESgcKDo1Cm52UbSOUKkIus5Ym+kPCrHeSt1Vy3CDKnWI0/IgR78kDbZ
 B5J9ykrMWS6tsAcNlx7Ale3jaL+pLnST4Ldm+SkaVkSoTEX9G6lqUBFNFqSCZUz21AUt
 OzVLXwEgvsX62QPOEgys28YT/hHdyOFIcpVSCSkNxoJNRWqrtCGLfYK9iDj3Bx+OgDLv
 gLapeFyijN08Hzdt06jYgEXr+8acnapr3KipYUw0Bm5eDvF77WB8/2ybKx2ytrMDnT1O
 u5iGLFlXCnFdpmyFZPT1gplgIE4KNFQo6SqyArGalJ3rkaNA+CmPrzMaoc60jLytxIXY
 74Dg==
X-Gm-Message-State: AOJu0YzJ7IbkTSzv5QpxS8tdhCvWhfLv26MAd2JrIyIbzcVJU2sb6d1L
 v7p+vOYFmjV2PB2fldxyEzbLJIr3GRCnkCnf/nV2TUe+2tYbO4tW7nSKNANyglVon4T1XkI/cT0
 SkhEZ/0oAQGcboeKpovPI+brl8fmMhIz4+PCttXxGMnsl/PWtqZ+7BF0pWZk9kfzYCUYCZ960pW
 pKm6Gazmh13TBNOXDDJmXLtI/iRBhmEqSQepQcRCo=
X-Gm-Gg: ASbGncvZJwenWgnO5EoeVA2Usyb8zWuEAXS0K5nAaAPL75hQpshPrAFYUeTV8l0lIX0
 GXVlWrZGCMFrPHYVtfssFov67rye6B5z2oxznMvyKZcsmKe3s/ywc42AaLbCcrhc/sPPcYZYbrf
 Z6xP6fvOD67fBjuBm6Z9CfkqUEgjobQAohm9KzNb7eEDSFHEL2MGFjUNWS7Xpy6Kd1KvpxXnnYE
 c3ydmuimMNF+nB4Okqp4RTr8iyrou07nJegYTbOe16k7zc4GXurYeq/XPswqk0TCJLibPPGrrRD
 2XBq2oTG42zJ6GK9xhiT
X-Received: by 2002:a17:906:c00f:b0:ab7:b589:4f9e with SMTP id
 a640c23a62f3a-abc09c1a648mr2308367066b.39.1740666070913; 
 Thu, 27 Feb 2025 06:21:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKgbYxuh+MB2gM/6flbYrUCoyOvV4GP3JqiNRJG+IufQ63cI4iQKOWSCRc0svq6y6TaSmeKw==
X-Received: by 2002:a17:906:c00f:b0:ab7:b589:4f9e with SMTP id
 a640c23a62f3a-abc09c1a648mr2308363466b.39.1740666070450; 
 Thu, 27 Feb 2025 06:21:10 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf1f1d5b4csm39341366b.85.2025.02.27.06.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:21:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: EwanHai <ewanhai-oc@zhaoxin.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 34/34] target/i386: Mask CMPLegacy bit in CPUID[0x80000001].ECX
 for Zhaoxin CPUs
Date: Thu, 27 Feb 2025 15:19:52 +0100
Message-ID: <20250227141952.811410-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

From: EwanHai <ewanhai-oc@zhaoxin.com>

Zhaoxin CPUs (including vendors "Shanghai" and "Centaurhauls") handle the
CMPLegacy bit similarly to Intel CPUs. Therefore, this commit masks the
CMPLegacy bit in CPUID[0x80000001].ECX for Zhaoxin CPUs, just as it is done
for Intel CPUs.

AMD uses the CMPLegacy bit (CPUID[0x80000001].ECX.bit1) along with other CPUID
information to enumerate platform topology (e.g., the number of logical
processors per package). However, for Intel and other CPUs that follow Intel's
behavior, CPUID[0x80000001].ECX.bit1 is reserved.

- Impact on Intel and similar CPUs:
This change has no effect on Intel and similar CPUs, as the goal is to
accurately emulate CPU CPUID information.

- Impact on Linux Guests running on Intel (and similar) vCPUs:
During boot, Linux checks if the CPU supports Hyper-Threading. For the Linux
kernel before v6.9, if it detects X86_FEATURE_CMP_LEGACY, it assumes
Hyper-Threading is not supported. For Intel and similar vCPUs, if the
CMPLegacy bit is not masked in CPUID[0x80000001].ECX, Linux will incorrectly
assume that Hyper-Threading is not supported, even if the vCPU does support it.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250113074413.297793-5-ewanhai-oc@zhaoxin.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bd407146136..0cd9b70938d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7804,9 +7804,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         /*
          * The Linux kernel checks for the CMPLegacy bit and
          * discards multiple thread information if it is set.
-         * So don't set it here for Intel to make Linux guests happy.
+         * So don't set it here for Intel (and other processors
+         * following Intel's behavior) to make Linux guests happy.
          */
-        if (!IS_INTEL_CPU(env)) {
+        if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {
             env->features[FEAT_8000_0001_ECX] |= CPUID_EXT3_CMP_LEG;
         }
     }
-- 
2.48.1


