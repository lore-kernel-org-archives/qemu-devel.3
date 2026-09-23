Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E79AC98311
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qpc-0007jV-RE; Wed, 23 Sep 2026 13:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9QoO-0006xh-OR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9QoM-0003mD-3O
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/XXIXhr9rwnA5+ykhbGO3yVGQuL3XT8fPCd0c2xNb+I=;
 b=ebWa1CzoyB20TlNGVMSkHRtgUJMkj6Jr7yD+ZPl+fvcaurPmtBjBT9BG5qwDzz920w6auF
 +M9eddlColjPaWfqC/e3CHDJ0vVvlk3TUnA3jY7BBXbAivyjnKADtFRggqxPtl5p1s9hXV
 8QLqPjzVIQBJRcO6WWtcLa+C8OHh7og=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-Ndxdv_aiMWmvQVNTdKmZmA-1; Wed, 23 Sep 2026 13:31:05 -0400
X-MC-Unique: Ndxdv_aiMWmvQVNTdKmZmA-1
X-Mimecast-MFC-AGG-ID: Ndxdv_aiMWmvQVNTdKmZmA_1790184665
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-487038a4a88so568432f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184664; x=1790789464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XXIXhr9rwnA5+ykhbGO3yVGQuL3XT8fPCd0c2xNb+I=;
 b=MkYy5p56uest3Dw3PSZrUtYbEWfy8G2NyRyxB4yjgsquI3/tzddRFBqNFlDcfMoJUU
 J67fJEbXRI7we4AlcWg1mjVtmm2sxH6mZoYsf5rIZe4wpLWJGi5+uOSXs9gT2XZVelSM
 GDhA0JMChdwFjM6KZSILrLCNZChjqYZWmQ1QL7uRcCa/i7QiDkMCFLWg4SJSS6fOeA/9
 NuPhDVxb1apJL/m8WqLU+dnBJrxJabqvW247zZvVVMh4q8z+oK7o7TiEseNiiZp+nvHo
 /kpCYoLZNODFyHFnnPPjeWfMuXLqateAk/zC/vHmLN9ImZxswPJuyFAvMZtzRK/CaLLx
 5HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184664; x=1790789464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XXIXhr9rwnA5+ykhbGO3yVGQuL3XT8fPCd0c2xNb+I=;
 b=bD6gUPa4rg5/ohprKcGld1+DozTU7FBgXTQoy09FWdhQIx2rmm3sc1rsqBY2TX0Dyy
 CpPAqLV1v0Ibaicx2md9vdK67svgTcDz7scIlfCfrwHdaC/OUiF9yBh79570zCSzVBbG
 ZyrRyJqn52BXsC697NqMqzhHkXbLDZa0newN2nSGAKZX3TrCAejaxPxMeiFrOC5J6OPa
 4psi7uNpYmCCU9w5iPx7+A2f/bxAwTEAG0QkUmBEqod0yK1/ASuWERZl8wxAJuLjASro
 DQ9nXX+6UXMtONShXgHsq9trVeBvsT8g6ak2tWlnYshER3BsQIID82gZwCk8PC2HDud7
 qJxw==
X-Gm-Message-State: AFuF++nMJlVKWPfRSp8E6/N5Klx5P70bvPKrx4hTCOv6MHCzLFNOeDDJ
 5Cld7Dh+NquMs0Ehq58q+npt8Fp0jHv6p7tasXG8Z+PMcYh0WEubsNdawzRVanfulQx91BsHH6e
 cVlMvI8myob4t00dZAaU56UPN8tDPj21xboJ9cQAsYXO0j7dav2pvpFBzCeb3ZP36K+LAeXkmF6
 +i+HnqGitfNrAlFuCvoZzWM8tW/PMgNGbJwIsZK90q
X-Gm-Gg: AYBFou1bLjT4cO3CNZs1r/m8x9OR/z5YZ9mDloxo14ZWSy8MPoe6g7qr0+k/gujrbE2
 0NCO+OauBKXvxJSD7i2yt+1xEedExchHFUmyK0sv9y7605lQad98DDqSdB+mZwNOJtO/1YB5oDA
 upavkw+NChuS6Z87DjDCQ7DDFOyfKsUWVIbr6gPd4BJ5j1ycN4/3kWKgT2+LbAaTZVr6Tn2ls9z
 q5M3rYEVVt5q3IEA8kZtLbHaIfcdEUPFAYPU8HkgSK0rWx8zTHU5H8TP9k/DdnxHRDMBSvIIKaI
 sorsA1sOz7LZRWnnWOcnpDsYeo86YoueB/P2U3eLojf/zX4u/un+v+RisKHJSG2ZpeR/v9hLYA1
 3d0e0ZyXO0crlP1KBrE2E3OeTXHzxLTr5akjwcM3iN/0cEjv822J3OomkIgl2TP3RY+evlo4+Sn
 eCLheC
X-Received: by 2002:a5d:5f88:0:b0:485:8a46:b3cc with SMTP id
 ffacd0b85a97d-488670c51fcmr5939057f8f.52.1790184664665; 
 Wed, 23 Sep 2026 10:31:04 -0700 (PDT)
X-Received: by 2002:a5d:5f88:0:b0:485:8a46:b3cc with SMTP id
 ffacd0b85a97d-488670c51fcmr5939000f8f.52.1790184664209; 
 Wed, 23 Sep 2026 10:31:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889409sm6940538f8f.35.2026.09.23.10.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:31:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 16/17] target/i386: extract computation of no-autoenable
 features
Date: Wed, 23 Sep 2026 19:30:20 +0200
Message-ID: <20260923173021.317809-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2a69ffeda40..b6ad69d5047 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9723,13 +9723,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      */
     if (xcc->max_features) {
         for (w = 0; w < FEATURE_WORDS; w++) {
-            /* Override only features that weren't set explicitly
-             * by the user.
-             */
-            env->features[w] |=
-                x86_cpu_get_supported_feature_word(cpu, w) &
-                ~env->user_features[w] &
-                ~feature_word_info[w].no_autoenable_flags;
+            /* Override only features that weren't set explicitly by the user.  */
+            uint64_t no_autoenable_flags = env->user_features[w] | feature_word_info[w].no_autoenable_flags;
+
+            env->features[w] |= x86_cpu_get_supported_feature_word(cpu, w) & ~no_autoenable_flags;
         }
 
         if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
-- 
2.55.0


