Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A78C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHAT-0003ax-8i; Mon, 14 Jul 2025 07:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0V-0001QK-I9
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0T-00021q-O9
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Oo3Mq8d89aj4RwZyYW7r9/QmVUY360NGuFe7tGChvw=;
 b=I7QPBGSk6q5GYrKt3unufrhPFhtJH5SPXzVAWchg6IieytcHEKczgML12r6rZvavRS9iOs
 gC/KC3E53Iq2G0y3zc2ll+E1/FvyYTBdZ6WTFqJijw1V7kfse65oHnNuY62dMYvjllKubs
 g3aIBLzvcKtlbQUvUvYQHYT5iq/mIzo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672--VcftfWtPM-OC40ooK0sag-1; Mon, 14 Jul 2025 07:05:58 -0400
X-MC-Unique: -VcftfWtPM-OC40ooK0sag-1
X-Mimecast-MFC-AGG-ID: -VcftfWtPM-OC40ooK0sag_1752491157
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so11251865e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491157; x=1753095957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Oo3Mq8d89aj4RwZyYW7r9/QmVUY360NGuFe7tGChvw=;
 b=i5/Hv1BSAeR9QsBCuUYRGo7onl/UZNJ1yb4NhAB6+Ju2vIGjCGgSjsWhuc/g8PPSzR
 oM7JJfT6m7p00Bzo3MRhWc47qLyFX7dR5bf5aT0T2NtPhdzNw/ZCmr20qdf6D844Yx3X
 VPRTrf/JhTgqzEmOLDYB0ulw5xiBhbzXdmi1qzYy1asStqr3LKJBpgAJZd5DDsiOGVfS
 tt4pSXfk0OEWZS+hfvvpxkKsPFReIbXQYkbhjez5wg0XvO2qjUhJl06fW45mowbH0zLm
 xc4EnA39C6xgmuMt7FNPszWgMmj0KhQYAlCJtODsjSkX4FB3Q1tuk5AABNAEKgAkEdrV
 zEFA==
X-Gm-Message-State: AOJu0YwLdKAfNJzLpaImIc7+AIfMDJUUmP4ZIZwLu9WyrKXi8p83ch9Y
 ehUp3NdqUSgjlJaffVkcZ1WXNHXoSDbGnbhE2uUUpxzCmmxQWTZNOQQB/hILZN/fpmWXkUCvIBh
 izgoPtZdJ97bEfTBY8lMzJUVdfnkCZqwKQVCQmdYP/WLgRaqzSj7Xzxh/+TQ60JWRsEMOKmrU3W
 bf5EHQXdP53uvsUWCFA06Mb63aCE5KBoFmYGqrODxR
X-Gm-Gg: ASbGncuDyMwz6jQZA+0rCEopdVQLBZ2rbbM+U1jRuKF/uIvgJPkQMgKTiJBSWjUsj6A
 5ZOyorPD2vCpkRrO17tFtG0jLM8tILaIh9NbJ7XeiCdUbslhKq4K/5B10dT5Dhn7ugnFJN6YBc/
 0m2hofCuGUNUq/5gD8dSpb5OxZBi5G2EACna8qLMXZ845lQbCbR1sqXca4Q2hIrmdagOiGNw1Eb
 8kJZjDPq9JAxwhYod8EUUsSX7/s2M8a7SYo97Xp0A2db+0VdAt6XxOSnWeA8RolZd7+DPzhU+mF
 NzNf5/LWGBEG2KzOlFNUya0ePi9NhRQKfNCyWBhujAU=
X-Received: by 2002:a05:600c:3481:b0:456:1442:86e with SMTP id
 5b1f17b1804b1-45614420b46mr36808255e9.21.1752491156797; 
 Mon, 14 Jul 2025 04:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEng2ALQiQcclffqdjxyYchlIAMr7NEzhnsIKAkQtPbbwVT/TCRO0GPJXkTYXNigqqSY1yA+Q==
X-Received: by 2002:a05:600c:3481:b0:456:1442:86e with SMTP id
 5b1f17b1804b1-45614420b46mr36807935e9.21.1752491156284; 
 Mon, 14 Jul 2025 04:05:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561752340esm39317585e9.38.2025.07.14.04.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 41/77] i386/cpu: Add descriptor 0x49 for CPUID 0x2 encoding
Date: Mon, 14 Jul 2025 13:03:30 +0200
Message-ID: <20250714110406.117772-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Zhao Liu <zhao1.liu@intel.com>

The legacy_l2_cache (2nd-level cache: 4 MByte, 16-way set associative,
64 byte line size) corresponds to descriptor 0x49, but at present
cpuid2_cache_descriptors doesn't support descriptor 0x49 because it has
multiple meanings.

The 0x49 is necessary when CPUID 0x2 and 0x4 leaves have the consistent
cache model, and use legacy_l2_cache as the default L2 cache.

Therefore, add descriptor 0x49 to represent general L2 cache.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f107e586734..4386b60ff6c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -129,7 +129,18 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
                .associativity = 8,  .line_size = 64, },
     [0x48] = { .level = 2, .type = UNIFIED_CACHE,     .size =   3 * MiB,
                .associativity = 12, .line_size = 64, },
-    /* Descriptor 0x49 depends on CPU family/model, so it is not included */
+    /*
+     * Descriptor 0x49 has 2 cases:
+     *  - 2nd-level cache: 4 MByte, 16-way set associative, 64 byte line size.
+     *  - 3rd-level cache: 4MB, 16-way set associative, 64-byte line size
+     *    (Intel Xeon processor MP, Family 0FH, Model 06H).
+     *
+     * When it represents L3, then it depends on CPU family/model. Fortunately,
+     * the legacy cache/CPU models don't have such special L3. So, just add it
+     * to represent the general L2 case.
+     */
+    [0x49] = { .level = 2, .type = UNIFIED_CACHE,     .size =   4 * MiB,
+               .associativity = 16, .line_size = 64, },
     [0x4A] = { .level = 3, .type = UNIFIED_CACHE,     .size =   6 * MiB,
                .associativity = 12, .line_size = 64, },
     [0x4B] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,
-- 
2.50.0


