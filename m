Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2201C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHLj-0006in-R6; Mon, 14 Jul 2025 07:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0b-0001UW-2Q
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0Y-00023U-LY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrhBM4PLka4qCB+6dapcsxkCed2Jrk/vEA3dhxvtRFQ=;
 b=Q0bOt0+5KxeZlx9w3rEW9GSVevliCnoa33qqqAfs2R4Pv1i5qwF/4UEfTDb2BHUoG7Jot7
 U11Re8ncOaC2v/gk9W9beu7T12atwvx6TemFl1otw4zRMunJaQujJOTHAKsPJrcvhNuVE4
 Uf0jLrt7TA6F8EbCUT/OkOXfZh3J8SU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-5Ep95CLpMaKodsWvzf354w-1; Mon, 14 Jul 2025 07:06:03 -0400
X-MC-Unique: 5Ep95CLpMaKodsWvzf354w-1
X-Mimecast-MFC-AGG-ID: 5Ep95CLpMaKodsWvzf354w_1752491162
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso1844393f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491162; x=1753095962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrhBM4PLka4qCB+6dapcsxkCed2Jrk/vEA3dhxvtRFQ=;
 b=nn+dAwcwO3ownJruT/Zv7Br7ObVFcYA5LmO72dBze5uRbCYhHHR9n0Cmy8tEYpQF4l
 6WUczcv0PCYC/sb9aadjrsVwrAnNS5XovRoZpcde4481J6j0sfBW7BUgkZcCRD3OikoR
 jgNxbtfiJ44/R+IgiQy9riqUmwBSWtruRpZFrwuk6SqNU7wwGnyyfLCM6CG9j6zziQp1
 S9fNMD/ZfRGMtRDNoRs2R9cC5GifQR1Pj+QrLdwMcHBV0zzSLJiDq+BJ5X2bVmvYNBOs
 blnOo+xVT37Aemhwrceqej3Xv5+79bEPVQPxJJpkOKmi2H2TKH/9tayY1Bb+HkXRhRAJ
 eOwQ==
X-Gm-Message-State: AOJu0YzFHoU9Vi2nth2zP20kGFIt2wUXVIIXwM0LOoSwDhrMv/Xm76QH
 XT64wesIFTHAvyeS3hDT/Akf3jFbNjnLKKIHtn7n93py0KkqxFhmc8cbYetNQ9alW3UGBH6AfMb
 DYvXXCF+TNjQLl2yHTYZxJQ0JO8EJh7QkwPthDcKQtYFyFbiVF8xEi+7ue/g3EQ0xcGmJHtIUnI
 T1eAnfUXnhDEZLZIckKyBHoTOFTUvtux4frVGR882H
X-Gm-Gg: ASbGncsWxKlWm2FJvqHFpyT9KJOSHPkELof9C7MTa4EePUELi5IM7FzvyFspmXUGJ3n
 SzXTA/iK43CJqUIJS64Qs0PmkaORBASMirxJurXaRA6U5tWKvpbZAdoz1ODVpdhpQ3LrAvge3qw
 TuX5rTNt3Aj7/FP8BblXGV5sD6wgk2OxSOOVO7b0C1y+U/CRi3JFR1MtJgykdxsKrn1BQAZBrjo
 mvhmUTq6V6NpHs7L5OiCEDXI+nuUguZpIo6g5hgh9VH24oEDhV3Nera4wKNVho0X3u61TjlgsiR
 kL1zATG5elR4aF06uYFhOLyFz0BZsQSlpQJ/mdVTwdI=
X-Received: by 2002:a05:6000:21c5:b0:3a4:f7e6:284b with SMTP id
 ffacd0b85a97d-3b5f187b24dmr6902547f8f.10.1752491161874; 
 Mon, 14 Jul 2025 04:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGEm8iTEvNvNWXppw18Lqz1Vp+Z1FflH2t/Sf0jQj2ljdG7EUunm/s5ySBo5mRiCoXilOoTQ==
X-Received: by 2002:a05:6000:21c5:b0:3a4:f7e6:284b with SMTP id
 ffacd0b85a97d-3b5f187b24dmr6902518f8f.10.1752491161307; 
 Mon, 14 Jul 2025 04:06:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560ceb130fsm65208045e9.26.2025.07.14.04.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Alexander Graf <agraf@csgraf.de>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 43/77] i386/cpu: Present same cache model in CPUID 0x2 & 0x4
Date: Mon, 14 Jul 2025 13:03:32 +0200
Message-ID: <20250714110406.117772-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

For a long time, the default cache models used in CPUID 0x2 and
0x4 were inconsistent and had a FIXME note from Eduardo at commit
5e891bf8fd50 ("target-i386: Use #defines instead of magic numbers for
CPUID cache info"):

"/*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */".

This difference is wrong, in principle, both 0x2 and 0x4 are used for
Intel's cache description. 0x2 leaf is used for ancient machines while
0x4 leaf is a subsequent addition, and both should be based on the same
cache model. Furthermore, on real hardware, 0x4 leaf should be used in
preference to 0x2 when it is available.

Revisiting the git history, that difference occurred much earlier.

Current legacy_l2_cache_cpuid2 (hardcode: "0x2c307d"), which is used for
CPUID 0x2 leaf, is introduced in commit d8134d91d9b7 ("Intel cache info,
by Filip Navara."). Its commit message didn't said anything, but its
patch [1] mentioned the cache model chosen is "closest to the ones
reported in the AMD registers". Now it is not possible to check which
AMD generation this cache model is based on (unfortunately, AMD does not
use 0x2 leaf), but at least it is close to the Pentium 4.

In fact, the patch description of commit d8134d91d9b7 is also a bit
wrong, the original cache model in leaf 2 is from Pentium Pro, and its
cache descriptor had specified the cache line size ad 32 byte by default,
while the updated cache model in commit d8134d91d9b7 has 64 byte line
size. But after so many years, such judgments are no longer meaningful.

On the other hand, for legacy_l2_cache, which is used in CPUID 0x4 leaf,
is based on Intel Core Duo (patch [2]) and Core2 Duo (commit e737b32a3688
("Core 2 Duo specification (Alexander Graf).")

The patches of Core Duo and Core 2 Duo add the cache model for CPUID
0x4, but did not update CPUID 0x2 encoding. This is the reason that
Intel Guests use two cache models in 0x2 and 0x4 all the time.

Of course, while no Core Duo or Core 2 Duo machines have been found for
double checking, this still makes no sense to encode different cache
models on a single machine.

Referring to the SDM and the real hardware available, 0x2 leaf can be
directly encoded 0xFF to instruct software to go to 0x4 leaf to get the
cache information, when 0x4 is available.

Therefore, it's time to clean up Intel's default cache models. As the
first step, add "x-consistent-cache" compat option to allow newer
machines (v10.1 and newer) to have the consistent cache model in CPUID
0x2 and 0x4 leaves.

This doesn't affect the CPU models with CPUID level < 4 ("486",
"pentium", "pentium2" and "pentium3"), because they have already had the
special default cache model - legacy_intel_cpuid2_cache_info.

[1]: https://lore.kernel.org/qemu-devel/5b31733c0709081227w3e5f1036odbc649edfdc8c79b@mail.gmail.com/
[2]: https://lore.kernel.org/qemu-devel/478B65C8.2080602@csgraf.de/

Cc: Alexander Graf <agraf@csgraf.de>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 7 +++++++
 hw/i386/pc.c      | 4 +++-
 target/i386/cpu.c | 7 ++++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a580562b3dc..a3ebd3e08ce 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2259,6 +2259,13 @@ struct ArchCPU {
      */
     bool legacy_cache;
 
+    /*
+     * Compatibility bits for old machine types.
+     * If true, use the same cache model in CPUID leaf 0x2
+     * and 0x4.
+     */
+    bool consistent_cache;
+
     /* Compatibility bits for old machine types.
      * If true decode the CPUID Function 0x8000001E_ECX to support multiple
      * nodes per processor
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 432ab288a87..a6fa7923688 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,7 +81,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
-GlobalProperty pc_compat_10_0[] = {};
+GlobalProperty pc_compat_10_0[] = {
+    { TYPE_X86_CPU, "x-consistent-cache", "false" },
+};
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
 GlobalProperty pc_compat_9_2[] = {};
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3278d5de5a7..1f27fcf3ee0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8935,7 +8935,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         /* Build legacy cache information */
         env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
         env->cache_info_cpuid2.l1i_cache = &legacy_l1i_cache;
-        env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
+        if (!cpu->consistent_cache) {
+            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
+        } else {
+            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache;
+        }
         env->cache_info_cpuid2.l3_cache = &legacy_l3_cache;
 
         env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
@@ -9461,6 +9465,7 @@ static const Property x86_cpu_properties[] = {
      * own cache information (see x86_cpu_load_def()).
      */
     DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
+    DEFINE_PROP_BOOL("x-consistent-cache", X86CPU, consistent_cache, true),
     DEFINE_PROP_BOOL("legacy-multi-node", X86CPU, legacy_multi_node, false),
     DEFINE_PROP_BOOL("xen-vapic", X86CPU, xen_vapic, false),
 
-- 
2.50.0


