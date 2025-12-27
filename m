Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B16CE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuh-0002G8-47; Sat, 27 Dec 2025 04:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuK-0002BV-LG
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuH-0006s8-EH
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hG1FuwTjSde0jNlaSR5VRL/KDZZc2NyTCbowH+IvjH0=;
 b=bFgt83sfLGWH6KgEGepXZnNRczYre5piDk6HAnGIhI8z8LVEzjDIJt0d4R1pSKOV+GLPT6
 CGC77t3uaEBhYZhghB6W8WoJ3eawNbWz+Q5ngk3J+scaqlPo1W+wM9H6JK3OgmEGkwx0Ef
 9sKPJ/zkEjDIi32GuqKoHPAwKxeI7VA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-SBhK835_Poyy_v2xxosg1g-1; Sat, 27 Dec 2025 04:48:14 -0500
X-MC-Unique: SBhK835_Poyy_v2xxosg1g-1
X-Mimecast-MFC-AGG-ID: SBhK835_Poyy_v2xxosg1g_1766828893
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47788165c97so45472615e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828892; x=1767433692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hG1FuwTjSde0jNlaSR5VRL/KDZZc2NyTCbowH+IvjH0=;
 b=iBpZjayI6fszSFiGX3BTvCLfcbD/YkQI7XmDg8sJwNGYhU/O3RHugm/KJzQ7m6Yayj
 m3CZP/BTY7mOHYacaYinKtrHDa+Ql7CYUwjwJv1csYEvvZHRYPre5Ho7irHqQTKhH+G9
 c2efBFr9QBbwK+N8236pep2fqNe3U6yf/TXDHzepjMH1wpxVHvQc4iEEd3aP2CbPJVFI
 E2NCdc3k8cJSRlMJd6ijqm7kJF9jhjrCdilRdOlC51XZI0TrPErO7l+gqVLr6zJkqWde
 WDvIzfs/qhJZMdBQKibu9iObq5ybBV1xYC0Q8jSubFzd/EOp6vXZoO9gVRleksvlt9pj
 vY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828892; x=1767433692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hG1FuwTjSde0jNlaSR5VRL/KDZZc2NyTCbowH+IvjH0=;
 b=QJr0BcHRYkTSeuzDZTbiW17vGhDRA4zpXod9ysPVN7DPYNvjEix9ZXKXVJa+D9V5Dd
 iUwdwS6Xkku1bZcO+COFeqqp+sF1VBXCWdkZ1g3Wojuet/HCtEJjw1y9XD5EeoOcwr4z
 0Z0qZURpfzZEg3a/4pYHlGmpIK/00cddssGWh5+fmzLwsAx4YsnMUoL18vwWai3dJr2e
 DpultvyKPeVXnx2wjTxFzQ2WDZAYySn0MKhslUvSnr0H2n20dTNEzkNbZw6cZ03xJ2t6
 9a38A0rXZh3zV3uDTgC9yHqIq91P+/SjqqfPV9Wu42ZiKV/NPlqgyfOabC9r4W7Vxk/h
 i3Xg==
X-Gm-Message-State: AOJu0Yyh5B4DrX5ZZZb5JJnhZue1CBPgaTTZENT/2o+/+9HQX/Ka8Wbj
 r886XrN2efMrIvSH2SWHjJmDmwipW2udjr1WErucjVQR8Fssjr6DkHg3E5Eb3/vGnV4QCVigCgs
 oznXxXgbydtpXHFzI4Og+boYRCfz/0RhCAx6xY5WNQKDsPzo8XZF4q9X7deczYXMfjWP6jMiKCv
 wFLdpHo20lEq1Gs+TLiPJsTmLx1Cvg7SEFDWq/U1ol
X-Gm-Gg: AY/fxX6d4Ixhu94gXnCij5pkFOf/cN+fiYJvNT1XuZJ825oo/oRSVXem3NetKg23c0B
 P9tgSNlUDxM6MmRPQ+IMAE3jZ0pqXy/+XIBvHFYrukunEuL82ySb3Bqf82XI10jxyljnoGFkjm0
 XhcGf+KxOvbjj71ZB0c859HlU6t/FQCcv6nDhq6OlqjhYDByXdvKKjGpV7CbyxNd6OxOE7tN5la
 meecga//Jyk5Wxyzx+cRfSlOK5btBlGTHE9GvOtbT95gZo/R9qxP5A0kW1q34EiExLCVfdqSEFv
 fZT9FU2YEMkYLSzZt/NBtKWnXTBgVAlKf66Fi/6H4W2wmPM6y0FkXW0GrPKu40k3EpaYkTW9ux5
 4okY4SVwYsNY40lqUWbRBInQrD2b4lkkq9nWih26qlBTQPPTlEMdlm1vsLltEyNPMg2KCfOQ7YA
 +fHWumMtopdl4GCwk=
X-Received: by 2002:a05:600c:c105:b0:47d:3ffb:16c9 with SMTP id
 5b1f17b1804b1-47d3ffb184amr98888595e9.23.1766828892547; 
 Sat, 27 Dec 2025 01:48:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJPO5YIbLs/L/0BrEPGLittszu20oJnPceZMetavKkmAiRo7g/Q8ptMSdU3c7oqyd+hQBZAQ==
X-Received: by 2002:a05:600c:c105:b0:47d:3ffb:16c9 with SMTP id
 5b1f17b1804b1-47d3ffb184amr98888375e9.23.1766828892074; 
 Sat, 27 Dec 2025 01:48:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm476080215e9.4.2025.12.27.01.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 080/153] i386/cpu: Drop pmu check in CPUID 0x1C encoding
Date: Sat, 27 Dec 2025 10:46:45 +0100
Message-ID: <20251227094759.35658-6-pbonzini@redhat.com>
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

Since CPUID_7_0_EDX_ARCH_LBR will be masked off if pmu is disabled,
there's no need to check CPUID_7_0_EDX_ARCH_LBR feature with pmu.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b53467eb997..5ba4d49dc35 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8273,11 +8273,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
-    case 0x1C:
-        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
-            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
-            *edx = 0;
+    case 0x1C: /* Last Branch Records Information Leaf */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if (!(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
+            break;
         }
+        x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
+        *edx = 0; /* EDX is reserved. */
         break;
     case 0x1D: {
         /* AMX TILE, for now hardcoded for Sapphire Rapids*/
-- 
2.52.0


