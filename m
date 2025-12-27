Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF9DE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQx7-0002cX-G7; Sat, 27 Dec 2025 04:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQx5-0002Lf-CT
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQx3-0007SC-Mx
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9gjyL8USiwzdUn7oC+UbtyBicl+JcEyV9qqRSLygs8=;
 b=LY23Q0ztVsjDR1VkUamU4ekCbUb081ZpwMt1g9agL85V/jIxkf2rGuWWwoTXYIbY/BDlDy
 p+RHOnb9hGQkt7ynRWbsQNWZ8yh0XF46AHLTc/Qu8a8ZammWMmCshqHCf4cdSuYzOyH8R/
 U9SMRizvxF5Ew5OQP0P7rKVToPnv7mE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-dvCoQyZXNECuTafGZMYgGQ-1; Sat, 27 Dec 2025 04:51:07 -0500
X-MC-Unique: dvCoQyZXNECuTafGZMYgGQ-1
X-Mimecast-MFC-AGG-ID: dvCoQyZXNECuTafGZMYgGQ_1766829066
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47910af0c8bso53737875e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829065; x=1767433865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9gjyL8USiwzdUn7oC+UbtyBicl+JcEyV9qqRSLygs8=;
 b=OhWwISX0QuZf0AFSalOZlTOxiekvwBHq+GOoWL6dYQ5wrODkBuG/AlP7/odT/j/N2q
 X86YVLWFjt6j1iK98HKDl5paR46LzD/TxmJzVyM7gwWpVTxLEbr1U3PI6rT0Yzyly8yw
 HIMbd9QXk49FSaF1OG+9kLEx9t6gQwob1hW3lWtGVS4lANLDNKq9d4vOKvG5PsBcfU51
 FFiQv6mJCfIJjQYgQPwSoCf/u/gi1RXhHlFjaLRCz2yOy0UarOxhvTQVZu8uUAWZzgYs
 Cj9J+DFM+F1+fh8DYWS53y/vC69a9Eq0z4CGEy+9hOkmV0vEJMrG0ZRQUrMceo8R+wpX
 K+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829065; x=1767433865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q9gjyL8USiwzdUn7oC+UbtyBicl+JcEyV9qqRSLygs8=;
 b=og7Il60vTG8v4Pwd+O1S2F0azqjXa6H8/TFcoQOD+iplzwqgHNEBVq6QuA2Sw5JHiD
 BZFDJK9GCS/ykllkwTEXfRvf8bTVwY/vzD/OsWtweIfOfLc2+BogztTnPDZOo4h8DWyh
 RV+CM7Z5smVGD76hzD9uFe3sRZRmI8oNoSP6MoHwL9wvi2oefwCZOUbPow7tfYZm4zvk
 6XGbNJqY34S2nBaIaIRkCAzTW5tXrP5/QiSTa2Cqfq8Rmjt6TNAqrHKb0vN9H4jTeqce
 2k5k0Hk1LoHAHgRCo1vJwtileHLnph8Z7RLzGqMm3RvRxc9U5VI1lkcV8FHOwXtxojdh
 VeiA==
X-Gm-Message-State: AOJu0YzKsVJ9XfIPUKnJhS3E8X4I/iIdgJ2fR3SnPlRg+afvBA1YDnQc
 Sc5GB+hyONyW/I4hmuEl/chge142US/PvaTeN3NeoRapMgtkeS0gw4AAVuPOpCdpi3duiADjdi7
 Y1X7xo2vQP4Ql2c3SEwRT7fydVPJWPQZlV8/fncRp/30JF8WIUV40+wqfXcObnNhqtmcrN6fe0L
 r/ZWU54y/t3A1JN/+pgZ74zd6CmEXI6vt+rdls0O3H
X-Gm-Gg: AY/fxX4Y7DexuA2nQOeXHbKwJJpGAYdk7USC5EpwlHfwSOp3P9wQzqYEmZ89Y5k/Foi
 WbhdPUHg2FgWj0jsOxQxJtOqNBZCKg60oas1cHdG4Ne77vnMXY+bjO4pS5ns+Wx8dB+gRST9pZp
 eQupyqnHD91YE34h2Gzkkp7JJr8xGyGAtJc2D6m8nLfDe8l8c40nxDx8oTIcz4lsJKJesMVKTl8
 0nNNut/Pvy0fGIIsmZ59b+euxomZaQk2jfo48uFBREahWSZpZdgjrGGLTRE4nVOLAXdNltzWjBY
 MLZ7r8tBUS8cM0XzuhP7QzwadcK39h40DfdojBsO94/Sg8X+qSkRTb0PCV7CEm+F1b+JU83ZLEH
 YA9BlO+/zYdrpvPCb8IfE3eTBI0L/ez1FLwQadbqYPTSVOdlYZvixNfGNJG0kMtLBkwpXfHxcFW
 D/tsmrHJUHTrkz+nc=
X-Received: by 2002:a05:600c:3ba3:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-47d1958c90cmr284205675e9.28.1766829065222; 
 Sat, 27 Dec 2025 01:51:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAZNBMuSIwCI1paZYa8PAhN+YkhoKV04J2hhHIWfd9mlUAeA72TwfydfMqJyD7dm1vSAFhsQ==
X-Received: by 2002:a05:600c:3ba3:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-47d1958c90cmr284205405e9.28.1766829064684; 
 Sat, 27 Dec 2025 01:51:04 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be26a81b6sm499639985e9.0.2025.12.27.01.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 136/153] i386/cpu: Add support for MOVRS in CPUID enumeration
Date: Sat, 27 Dec 2025 10:47:41 +0100
Message-ID: <20251227094759.35658-62-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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

MOVRS is a new set of instructions introduced in the Intel platform
Diamond Rapids, to load instructions that carry a read-shared hint.

Functionally, MOVRS family is equivalent to existing load instructions,
but its read-shared hint indicates the source memory location is likely
to become read-shared by multiple processors, i.e., read in the future
by at least one other processor before it is written (assuming it is
ever written in the future). It could optimize the behavior of the
caches, especially shared caches, for this data for future reads by
multiple processors. Additionally, MOVRS family also includes a software
prefetch instruction, PREFETCHRST2, that carries the same read-shared
hint. [*]

MOVRS family is enumerated by CPUID single-bit (0x7.0x1.EAX[bit 31]).
Add its enumeration support.

[*]: Intel Architecture Instruction Set Extensions and Future Features
     (rev.059).

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 2 ++
 target/i386/cpu.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c0bf51448e2..be430a73bdd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1043,6 +1043,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
 /* Linear Address Masking */
 #define CPUID_7_1_EAX_LAM               (1U << 26)
+/* MOVRS Instructions */
+#define CPUID_7_1_EAX_MOVRS             (1U << 31)
 
 /* The immediate form of MSR access instructions */
 #define CPUID_7_1_ECX_MSR_IMM           (1U << 5)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 67769200d0d..817f78a0c20 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1266,7 +1266,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "fred", "lkgs", "wrmsrns",
             NULL, "amx-fp16", NULL, "avx-ifma",
             NULL, NULL, "lam", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "movrs",
         },
         .cpuid = {
             .eax = 7,
-- 
2.52.0


