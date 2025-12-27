Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AB0E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuJ-0002BF-7C; Sat, 27 Dec 2025 04:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuF-0002Ah-QH
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuE-0006rp-6u
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKWJeBpGxkmOH5K5Q94L9lMVL3nCFqA7MqpJ6Eqegow=;
 b=PZHGovtekHqhvodX/zSaglVvuB89E9a1harWUfomWSN1ZsYUwWYxmRFevLtUVxETjjOBfR
 3FgviXX+dumcpbskhdkAku6+jZW/y+lKcDe0PEHuSdbU3XiVNLtt+vQEMd3KYLzNxSDjA+
 U9bstuwHe5QPqWU3dayKlqdwbWACrRA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-O1ZI_ee0PcCFri5dy2gr2Q-1; Sat, 27 Dec 2025 04:48:10 -0500
X-MC-Unique: O1ZI_ee0PcCFri5dy2gr2Q-1
X-Mimecast-MFC-AGG-ID: O1ZI_ee0PcCFri5dy2gr2Q_1766828889
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432586f2c82so3532974f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828888; x=1767433688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKWJeBpGxkmOH5K5Q94L9lMVL3nCFqA7MqpJ6Eqegow=;
 b=DDp06LCkynmvbXBPi/+R7qPmRC33zu0pNar/BRGaptkicuFQyLKOOvttbUY6nKY8Ge
 mW+IhgIXO5HvOP4aIDgFQvrfZESVgFEy8L/0Jzao+RB/Af2TGYRixbBL79Tghbyqebnl
 jGEMsDOaV7Op9uYWXjZ32Ivevf3/ZMwZa0E7GJXZCieYhXd2J4S4PFM29ar3NN0isi6k
 vfz67Np50vxZFsi0tb5XV9l8RP0MstHFF5iRpcz+G7ohNYefiaTknGE2+efDcK7dfWfL
 pA8Hlg3EoZ/X8z5QHhFdmY/Z3CtrulqJE8K8XKWT2zCX0zVTpumHgYUNtQxhefrSSofM
 nzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828888; x=1767433688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AKWJeBpGxkmOH5K5Q94L9lMVL3nCFqA7MqpJ6Eqegow=;
 b=DM/aKUM0W+NmPyUX6kavtcmsqjJf3eMMucdFA7TR3i6ae3JknH3jwTaJ7czI6733Rd
 HOLC9YN+jL/HGXF89SledDJ7n+0v4E9uz7jvYyDXXYIssTOBR40v+VKrRZk//93Z2jEn
 kbwqhUFhD6ZpIZHLF0zUFs1kgYRkCvepTvIKKn4Z4+cRMLL01ld2IbVhDiL6a6dJiHX7
 KFn18E+eMUcUtf7UKlpJRQRwW9eGZQ0QFrfJZIsZAPHedM1N2QDIUz329hThuVuFQw8C
 MigsFg55k3WTulZME8v4/QSxPmUdy+1kL6MlOSfbAgVZBBa7hIoslmtpAbdFPsOrA+S2
 xu1Q==
X-Gm-Message-State: AOJu0YwNCv5ixNTCWQtmsAFQBzWE7sj1n6EYqD1PH0VQe/gRBp9RfDLv
 VUOSrEIRmuGY+RsGKoYaQuxct1fc7Ck2pTFVkFmXr0qttoiUD5iNDRpoSMfNlMGhG74Ut3PtBlv
 q+qJ+eoTEVX55ZE+G+HuoRO34D/4nk2Sj17l+RqtUh4RedKCVP9hczTqX9sk10DUWw+76k5mA1z
 iCVwF99vmdXik9X1c3FEsVDaJfnGxM4roGt4dyCaJ8
X-Gm-Gg: AY/fxX4jE7xUMZVFJX564+kqBOtInmaMIAopaMWlZfOrI+9hVkZTKPR0OAdevuQ4tcG
 a10hciYstpHY1wpgWNlY0XhWHZ9WKAqA/z+AMfRRsrEpvHXW8ovqfsVPLxV/nGugDs5Bp/hXUdQ
 QcmNb36avLLazMiqCGq8+oYC/7CIa+tG1X8i2oCoNbHVQkv8axTNEIpklmxfyCZLGidASpj/lVh
 /2tha/SLAzEl1Pc/bNVogI81vSzh4VZJhPmFG8pMvjkxFGR3i4Y0NUJi/ZnSOKRr2xcY88TaQAE
 t5rAsjPBL9MD3BmjCs1OI8qeiSEuofINO3EsLcGxFzE4CEIadn3ww/PqJjBVgZ4hpZBpD0asgkG
 r14qhbpw14/iRHdRk96rDcD35tH2slBbMi3RmkqAc27jvFDt21OPdXLCeDjK/jxkfbO2X/omrSy
 5X8LONlUvxBfH4w/Y=
X-Received: by 2002:a5d:5f96:0:b0:430:fca5:7353 with SMTP id
 ffacd0b85a97d-432447a3dc1mr30546237f8f.8.1766828888056; 
 Sat, 27 Dec 2025 01:48:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4X3DOQWya6V5ukwmgVWcy8wdu5rM1CFgps9HCyBCJZLYhLqwu719f+SqkZbEGWrtpf9zyBA==
X-Received: by 2002:a5d:5f96:0:b0:430:fca5:7353 with SMTP id
 ffacd0b85a97d-432447a3dc1mr30546216f8f.8.1766828887601; 
 Sat, 27 Dec 2025 01:48:07 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab33f5sm50344962f8f.41.2025.12.27.01.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 078/153] i386/cpu: Use x86_ext_save_areas[] for CPUID.0XD
 subleaves
Date: Sat, 27 Dec 2025 10:46:43 +0100
Message-ID: <20251227094759.35658-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

The x86_ext_save_areas[] is expected to be well initialized by
accelerators and its xstate detail information cannot be changed by
user. So use x86_ext_save_areas[] to encode CPUID.0XD subleaves directly
without other hardcoding & masking.

And for arch LBR, KVM fills its xstate in x86_ext_save_areas[] via
host_cpuid(). The info obtained this way matches what would be retrieved
from x86_cpu_get_supported_cpuid() (since KVM just fills CPUID with the
host xstate info directly anyway). So just use the initialized
x86_ext_save_areas[] instead of calling x86_cpu_get_supported_cpuid().

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 812a2151471..f4c0ae533d0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8188,20 +8188,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         } else if (count == 0xf && cpu->enable_pmu
                    && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
-            x86_cpu_get_supported_cpuid(0xD, count, eax, ebx, ecx, edx);
+            const ExtSaveArea *esa = &x86_ext_save_areas[count];
+
+            *eax = esa->size;
+            *ebx = esa->offset;
+            *ecx = esa->ecx;
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             const ExtSaveArea *esa = &x86_ext_save_areas[count];
 
-            if (x86_cpu_xsave_xcr0_components(cpu) & (1ULL << count)) {
-                *eax = esa->size;
-                *ebx = esa->offset;
-                *ecx = esa->ecx &
-                       (ESA_FEATURE_ALIGN64_MASK | ESA_FEATURE_XFD_MASK);
-            } else if (x86_cpu_xsave_xss_components(cpu) & (1ULL << count)) {
-                *eax = esa->size;
-                *ebx = 0;
-                *ecx = 1;
-            }
+            *eax = esa->size;
+            *ebx = esa->offset;
+            *ecx = esa->ecx;
         }
         break;
     }
-- 
2.52.0


