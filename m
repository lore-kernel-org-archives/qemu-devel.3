Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB141C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKn2-0006iz-Np; Tue, 20 May 2025 07:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKmz-0006Zw-PO
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKmy-0002zK-1y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+j85f5BC5kk8p8XZ+YdfTGU6qWtK2LXVcZTdVTr8ts=;
 b=f+HFFpE2HnlKqZCl3EtG5g0eDVdDL6kQG/oFfiyhPsWX+VU8aBkIcEiG6hpfHlwLoskVbc
 UQh/59LX+QsXxKObCR4BqSmNOMkjnguWz/i+JNeNehVA6HVLNaAXd/87oKxr3ly2X1/cOw
 JIwIcZtSDYm+szgEafo1hADaUur2wOE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-uR8oSz8xPmmo8pWnsb-7cg-1; Tue, 20 May 2025 07:05:37 -0400
X-MC-Unique: uR8oSz8xPmmo8pWnsb-7cg-1
X-Mimecast-MFC-AGG-ID: uR8oSz8xPmmo8pWnsb-7cg_1747739136
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad55e9a80acso178299066b.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739136; x=1748343936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+j85f5BC5kk8p8XZ+YdfTGU6qWtK2LXVcZTdVTr8ts=;
 b=uFCS2TStURCesNftypTvd1BntmtlxDb1wpeI2mOLGQ4ZQffQy9D3Fahiy7SZDOyU9w
 H72X3H0fRs7nBE1LvuME52XB2rX3WKflafKrV2k1NjfbLYZ7ovh/rkQczowQezYZRtv/
 3KgTA3nOnGzJKWfk331JB7DAff36lTCSE2WNwJBnrU+Wbu9XP0BOD2k55Xmy4gp2D3tB
 GPGoKV7JueoVl4DFJKDFC6u1ESzRKShj3dSK1daZaNEViOFCLMiYhMOEUNmxSNqRLeEe
 Dhqx3QXN67buLCqynNbIz55D4H4ute2MKQulIt9KjvKqnxGzLldpfc42pXVB0Dgi9Ux9
 sxzA==
X-Gm-Message-State: AOJu0YwNeGlaee4kVCUflGr7/rdaJxZ4eB84WzsW89m+tTYxqUMmto7d
 LRsRMxuFgGt3d68qeD2HIQk5aCToQw5iIgS+EmFDCShViQTrP9i2axOExb8jFd3jyevl3NOmP/7
 gK9DJtYcb7QWwJ6kUwm4fG0FE577vIGbMvGlLA9F+Rj/K/x6bOctmTHVDnuh742i9eNXqPB6xPU
 wXMyQY9/+2VQeUZV09fKODD8W3m8UHkUFipu3qzG9+
X-Gm-Gg: ASbGncsWrqkvnJUVVaVgRffK9iMytpY3CW8ds7Kpfe5hPD8v9/CLCEIsQCdSZIR+yVk
 KqkZ8WNY2rbmWNRnchFqVzw1AbOakYqXEnEvyA80JvJpWbe3qFbEGLw2RodBPKEz1jZPgapObxn
 SEfhAMUKlA4W4/5r3qnXVNfV/oFlS4wquTUhwj1zbxM+TKiOy8mnz+SbQdOC+13VZ2uoTFmEEhk
 XCgVRetcthcMwm8/stnQMnix5uaIWvAMabhko0oqsNtUraTLEmtBNKh1YyE6Le1HZMVtnYPk5h9
 ZoCxrjGZ0+MQuQ==
X-Received: by 2002:a17:907:1c0a:b0:ad2:2146:3b7d with SMTP id
 a640c23a62f3a-ad52d583b9cmr1351128566b.46.1747739136003; 
 Tue, 20 May 2025 04:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9JF5Ct4fe7EDmcELF+i3c/NBGGMXCpwFa2iLan6DP2imU7KE9jSdr7AjWwXSpWmDvPqYPpw==
X-Received: by 2002:a17:907:1c0a:b0:ad2:2146:3b7d with SMTP id
 a640c23a62f3a-ad52d583b9cmr1351124966b.46.1747739135548; 
 Tue, 20 May 2025 04:05:35 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad5572f6436sm464394466b.182.2025.05.20.04.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 02/35] i386/hvf: Make CPUID_HT supported
Date: Tue, 20 May 2025 13:04:57 +0200
Message-ID: <20250520110530.366202-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Since Commit c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in
x86_cpu_expand_features() instead of cpu_x86_cpuid()"), CPUID_HT will be
set in env->features[] in x86_cpu_expand_features() when vcpus >= 2.

Later in x86_cpu_filter_features() it will check against the HVF
supported bits. It will trigger the warning like

    qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]

Add CPUID_HT to HVF supported CPUID bits to fix it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250514031652.838763-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index fa131b18c6d..0798a0cbafb 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -73,7 +73,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
              CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
              CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
              CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX |
-             CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS;
+             CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_HT;
         ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
              CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
              CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
-- 
2.49.0


