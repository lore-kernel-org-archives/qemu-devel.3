Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83D7E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2w-0000xA-SZ; Fri, 10 Jan 2025 13:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2O-0000HR-Av
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2I-00019f-9p
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lheQe9oBiSwdA3AEighJH8+9qG+im1PfUhZWsSUYH5o=;
 b=WKy0OlwwazpGG7z+dWAsO3RTT+RotdIy9jZQfu/oHSYHnbWwkOjw3VhTkH9mKB3Axs8sKR
 h1OZ0CXngYYvr0NW7ckJJulPQ52lCx0ZEVPtHC91fF1Ks8SETYNVe+fMy1tLStd2nslGd7
 qN1xntgJeiDrZzydhJJlzicSekrY+cE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-NxLL07ZxPcG-Bde8gCqCqA-1; Fri, 10 Jan 2025 13:47:07 -0500
X-MC-Unique: NxLL07ZxPcG-Bde8gCqCqA-1
X-Mimecast-MFC-AGG-ID: NxLL07ZxPcG-Bde8gCqCqA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa66f6ce6bfso197519066b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534825; x=1737139625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lheQe9oBiSwdA3AEighJH8+9qG+im1PfUhZWsSUYH5o=;
 b=XXy4NDBbyrYXFe3WgvnTY3BYl7NZESaf77FJjk+ZORFdyWCkHjdNAzrCWers7PpVH2
 ehw7wCN2MIjDeQX/6us36FuSzQpdXxz4oRi7oKvjrP32ElrLVDn3jMAnJU3XV6xY/rqI
 WKoSPgwuyGKyoDaFzP6oSwceXYq1nbWO/tY5HZr4uDtBlZ+QFv3SVh9GY1ZEI5Uhcw92
 ZvnQYtEzVlNVu4s73gnyMdJDri6RWnIAbrGKTzZsEJyMY8rhM90s7i76Zd5aaI0YI5wF
 NtcKH3kuAqnVB+5X/0ZD4L4UODw7ANaMeu9WQCFELBEKuXbHf1wGxSUVpHeg9G71wPsk
 XSuw==
X-Gm-Message-State: AOJu0YzVjgzW9k49GBWI8XR5pCY+dsne4jgiBMvFYdREPLxd2GE7lAAz
 6pX+RYSyz+vN17Jsm/jgH2YLUEuXCZmUcmc8kqi1K6ekBBkVPMzwvloY9p2+FgOLNM+psZn85Wu
 G002cJUUei4NPEqu4wJYAVn/2OyJfdim1L+lCfri8I35/Io6BzqVhcTVpAdMDTcs53yFpWrIRQt
 W5yphQVHtfL2gOh/x7BpzPGe3q3u6n4LLT30OffCs=
X-Gm-Gg: ASbGncsSF4b9Z9bUZL52U6LOD03BucOKSrJfqlcM31cA83hGZxs47djXlYf1ULjUMhV
 o8DpUU0o+PMk8ftETGg28eQIUmpTPQ3JeF9VMBL15jCHVCFdkotFGLoscnlVU/urv7fEFNLKXLn
 2rmdDJxO38vk7hHqs1wMQYFTJp0o5JN+PABlrDnPYWNJrYbfrAX9JxbqVIho7gW3d0913cec4qm
 dRCJBJ91M6lrdD/Xl+ymqruwtIZnSH4MI+QPll8rM9/BfwefMwD5s3SznM=
X-Received: by 2002:a17:907:60cf:b0:aab:92bd:1a8f with SMTP id
 a640c23a62f3a-ab2ab6fd014mr1014827166b.26.1736534825033; 
 Fri, 10 Jan 2025 10:47:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQSbyE0lVRU+apt9SfK90NVRCicY/pU3NyB9MxKJa39+IGoQLl3jKVvSXJhkXuisJ1e5Xe4A==
X-Received: by 2002:a17:907:60cf:b0:aab:92bd:1a8f with SMTP id
 a640c23a62f3a-ab2ab6fd014mr1014824566b.26.1736534824555; 
 Fri, 10 Jan 2025 10:47:04 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d4f92sm195595866b.57.2025.01.10.10.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-stable@nongnu.org,
 Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 19/38] i386/cpu: Mark avx10_version filtered when prefix is NULL
Date: Fri, 10 Jan 2025 19:46:00 +0100
Message-ID: <20250110184620.408302-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In x86_cpu_filter_features(), if host doesn't support AVX10, the
configured avx10_version should be marked as filtered regardless of
whether prefix is NULL or not.

Check prefix before warn_report() instead of checking for
have_filtered_features.

Cc: qemu-stable@nongnu.org
Fixes: commit bccfb846fd52 ("target/i386: add AVX10 feature and AVX10 version property")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0b639848cd6..579d9bac955 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7719,8 +7719,10 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
             env->avx10_version = version;
             have_filtered_features = true;
         }
-    } else if (env->avx10_version && prefix) {
-        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+    } else if (env->avx10_version) {
+        if (prefix) {
+            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+        }
         have_filtered_features = true;
     }
 
-- 
2.47.1


