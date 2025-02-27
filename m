Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E0CC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelz-00023j-Vu; Thu, 27 Feb 2025 09:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnelC-00084L-Mn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnelB-0003t9-0u
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GiEaq4+igrWwP4fp+abzJc1rUXq1wsd/EYkNDp5ecs=;
 b=GCwsHdLoebe4X37KiLrWWMFum2gGutKHvocwa3uVtLk9JrOy1L4cPe2movJHRfTGts0FlU
 /Vv5htSy6LwxFHROf4r6olX5E2LNlqv6yNGB9P8b0zKbFxXnhTGkHI0Yla2PHzVbEeMLtR
 dgSPwGG3zKDatLLL1cm/fUjMLKhaEt8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-ugK5z9jINDutf280NJIQVw-1; Thu, 27 Feb 2025 09:21:07 -0500
X-MC-Unique: ugK5z9jINDutf280NJIQVw-1
X-Mimecast-MFC-AGG-ID: ugK5z9jINDutf280NJIQVw_1740666066
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e0573b9f60so1029310a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666065; x=1741270865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GiEaq4+igrWwP4fp+abzJc1rUXq1wsd/EYkNDp5ecs=;
 b=kraINdXZPn4zoUg6TTcZBtPE3LPpBez9zJQNdiRotW3xayzFespWT63SB0DxI2R+sy
 mevGwoWiIVWyv1y/rCce9RAQpeGOTLLrihzGScbNDVT0Fd8t6dwOsoVl+GlnU3jrUi5t
 yGCsNZygOmzbsPRNsZ/cZhu+3CYi83kgi3i6/imAWhXh1o7vkjx2rCNaqNFLWdVVHaTq
 iLh1yGyeJWlKhp03DjuDSYQm32e81/APbjKP4oFQi5BiK7omm3QVyNudioegPzpmjoKk
 4AmSnUEXQU+qCRBvYN/6SFPcAhfpdQJdCN6o145g1XpbOXDI5T52lVM2ubttRpoxxxWk
 nzSQ==
X-Gm-Message-State: AOJu0YwLun2/rhx9f+4Xr0mlhZ+e8oPL4JQXkNqF/1LAQnjGn1JS4311
 9KoWKfQ+YLpCNR4gubyVxLkZEMmjYTE8Dy83DVATOZxyrxqrHVUCqDlTagyEh447Kzj2wBKI8EK
 pLfypdtbHrjbOtklvpXCpLQBenQpNFj6MSmFijDtw/0UgZFaMxHG2s3A272stTo0mKBLdIMYN2d
 SOCOKAtxIoswj99k5Ykab1SHJdOwUpvqHt2276AZ4=
X-Gm-Gg: ASbGncsfLTgO90X0V3ooGPPhwC438c1kIGQLO3YiHmVpuBajA5DvGan2hhfzvP/9Jtq
 3WVwY+Jpi+t9bhjC6ZzOy/RV3lZCQXKdKuzEWzAX72G2nMDL1NTNRBayNnA7Zj8YnT9ouEElw0M
 JCxYJQL3kU4oUDXsj2/BizbTDIuOHqXQ24cs2hnXsRu09D9NEO3BVHsBa2DpDSuJozSQM7RDku1
 RcQDbIPOq5NpxdnZ64rO3hKWMbWvxZOFd6j/80OCDU5dXWVLgTrw7ji6XXH7rkN9cMXfcDMBO5E
 +Fo4q907o8xBiga9US81
X-Received: by 2002:a05:6402:4008:b0:5e4:bf03:e907 with SMTP id
 4fb4d7f45d1cf-5e4bf03eaafmr4860349a12.19.1740666065184; 
 Thu, 27 Feb 2025 06:21:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAcqj9YSZaFkB+23AY/L7qncTTPWc3kca6m9MNiFg2ZmVIRlsguDOEk7M9XeRoVE8HbwzdBg==
X-Received: by 2002:a05:6402:4008:b0:5e4:bf03:e907 with SMTP id
 4fb4d7f45d1cf-5e4bf03eaafmr4860316a12.19.1740666064697; 
 Thu, 27 Feb 2025 06:21:04 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb6067sm1140683a12.50.2025.02.27.06.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:21:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: EwanHai <ewanhai-oc@zhaoxin.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 32/34] target/i386: Add CPUID leaf 0xC000_0001 EDX definitions
Date: Thu, 27 Feb 2025 15:19:50 +0100
Message-ID: <20250227141952.811410-33-pbonzini@redhat.com>
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

Add new CPUID feature flags for various Zhaoxin PadLock extensions.
These definitions will be used for Zhaoxin CPU models.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250113074413.297793-3-ewanhai-oc@zhaoxin.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4279cf5cdee..10ce019e3f8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1110,6 +1110,27 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
 
+/* "rng" RNG present (xstore) */
+#define CPUID_C000_0001_EDX_XSTORE             (1U << 2)
+/* "rng_en" RNG enabled */
+#define CPUID_C000_0001_EDX_XSTORE_EN          (1U << 3)
+/* "ace" on-CPU crypto (xcrypt) */
+#define CPUID_C000_0001_EDX_XCRYPT             (1U << 6)
+/* "ace_en" on-CPU crypto enabled */
+#define CPUID_C000_0001_EDX_XCRYPT_EN          (1U << 7)
+/* Advanced Cryptography Engine v2 */
+#define CPUID_C000_0001_EDX_ACE2               (1U << 8)
+/* ACE v2 enabled */
+#define CPUID_C000_0001_EDX_ACE2_EN            (1U << 9)
+/* PadLock Hash Engine */
+#define CPUID_C000_0001_EDX_PHE                (1U << 10)
+/* PHE enabled */
+#define CPUID_C000_0001_EDX_PHE_EN             (1U << 11)
+/* PadLock Montgomery Multiplier */
+#define CPUID_C000_0001_EDX_PMM                (1U << 12)
+/* PMM enabled */
+#define CPUID_C000_0001_EDX_PMM_EN             (1U << 13)
+
 #define CPUID_VENDOR_SZ      12
 
 #define CPUID_VENDOR_INTEL_1 0x756e6547 /* "Genu" */
-- 
2.48.1


