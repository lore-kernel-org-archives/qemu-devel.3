Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B64DC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 06:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWqjD-0003OR-FI; Wed, 02 Jul 2025 02:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWqjB-0003Ng-ID
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:13:53 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWqj5-000748-Li
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751436828; x=1782972828;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZRjDfu3Eo1kq6glHmDbWpF7kNZYyBuliP3tTJzzdXTA=;
 b=Us4BkugwElNsnZ2t6BzEjC5aYU22oxPf55iIU7riwtfjhMZVsgOo3rvv
 /vChoTkm6mnih1zqDdbJQhgzNTRva5IGgQZzpJxumyrX7kF8TZhn1emFv
 sybNUyAmYKyCsZ/3NSGQkF3HOUXKxRcq5MAmCsUJbDmY4rbvvBfQgDjs1
 iE2munwi6x+Os953Y7mkvhebdiqueN+DN70MTv3xXVEpB4wZwfbJArrJl
 A9XkAYtZmZSjSdiWQ0u1ydMe1ua5Dlo6lO8gV5KwaMNlb3faQQWkAq7ak
 B0eulM7ADZGjkU2KS8aIflsWoxZWV2diTzYELTFQH3NwRdLsTDqrsHYjt g==;
X-CSE-ConnectionGUID: hcBE2i14THypwNFvqd142Q==
X-CSE-MsgGUID: MBqiwqLGS7a2vAnZESC3dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="52950499"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="52950499"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 23:13:42 -0700
X-CSE-ConnectionGUID: AugRwZ41Rpmb1CtDSNhvEw==
X-CSE-MsgGUID: PRNxl9A/Quyp3h9PDA6ysA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153608850"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 01 Jul 2025 23:13:39 -0700
Date: Wed, 2 Jul 2025 14:35:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>,
 Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/8] i386/cpu: Introduce cache model for YongFeng
Message-ID: <aGTTGP+92oL+5rbf@intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-5-zhao1.liu@intel.com>
 <7f2b589b-589d-4d72-9ecb-26bb5727f724@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f2b589b-589d-4d72-9ecb-26bb5727f724@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> > +            {
> > +                .version = 3,
> > +                .note = "with the cache info",
> 
> I realize that my previous use of "cache info" was not precise; "cache
> model" is more appropriate. Please help me adjust accordingly, thank you.

Nope, will fix.

> > +                .cache_info = &yongfeng_cache_info
> > +            },
> >               { /* end of list */ }
> >           }
> >       },
> > --
> > 2.34.1
> > 
> 
> Hi Zhao,
> 
> I tested the patchsets you provided on different hosts, and here are the results:
> 
> 1. On an Intel host with KVM enabled
> The CPUID leaves 0x2 and 0x4 reported inside the YongFeng-V3 VM match our
> expected cache details exactly. However, CPUID leaf 0x80000005 returns all
> zeros. This is because when KVM is in use, QEMU uses the host's vendor for
> the IS_INTEL_CPU(env), IS_ZHAOXIN_CPU(env), and IS_AMD_CPU(env) checks.

This is a bug:

https://lore.kernel.org/qemu-devel/d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com/

And we expect we can change the vendor with KVM.

> Given that behavior, a zeroed 0x80000005 leaf in the guest is expected and,
> to me, acceptable. What are your thoughts?

Well, (with this bug) since VM is "Intel" vendor, so this is correct.

> 2. On a YongFeng host (with or without KVM)
> The CPUID leaves 0x2, 0x4, and 0x80000006 inside the VM all return the
> values we want, and the L1D/L1I cache info in leaf 0x80000005 is also
> correct.

Nice!

> 3. TLB info in leaf 0x80000005
> On both Intel and YongFeng hosts, the L1 TLB fields in leaf 0x80000005
> remain constant, as we discussed. As you mentioned before, "we can wait and
> see what maintainers think" about this.

Yes. I suppose Zhaoxin also uses 0x2 to present TLB info like Intel does.
To support TLB, I feel like there is still some work to be done, and it
depends on if it's worth it...

> In summary, both patchsets look good for Zhaoxin support, I don't see any
> issues so far.

Thanks!

> Btw, YongFeng host also support 0x1F, does YongFeng need to turn on
> "x-force-cpuid-0x1f" default ? I think maybe yes.

OK, will add it.

BTW...my colleague reports a bug that Intel/Zhaoxin CPUs with cache
model will meet assertion failure on the v10.0 or old machine.

So I think it's necessary to drop all the assert() checks on
lines_per_tag directly:

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 18bb0e9cf9f6..f73943a46945 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -491,7 +491,6 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
 static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
 {
     assert(cache->size % 1024 == 0);
-    assert(cache->lines_per_tag > 0);
     assert(cache->associativity > 0);
     assert(cache->line_size > 0);
     return ((cache->size / 1024) << 24) | (cache->associativity << 16) |
@@ -520,13 +519,10 @@ static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
  */
 static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
                                        CPUCacheInfo *l3,
-                                       uint32_t *ecx, uint32_t *edx,
-                                       bool lines_per_tag_supported)
+                                       uint32_t *ecx, uint32_t *edx)
 {
     assert(l2->size % 1024 == 0);
     assert(l2->associativity > 0);
-    assert(lines_per_tag_supported ?
-           l2->lines_per_tag > 0 : l2->lines_per_tag == 0);
     *ecx = ((l2->size / 1024) << 16) |
            (X86_ENC_ASSOC(l2->associativity) << 12) |
            (l2->lines_per_tag << 8) | (l2->line_size);
@@ -535,8 +531,6 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
     if (l3) {
         assert(l3->size % (512 * 1024) == 0);
         assert(l3->associativity > 0);
-        assert(lines_per_tag_supported ?
-               l3->lines_per_tag > 0 : l3->lines_per_tag == 0);
         assert(l3->line_size > 0);
         *edx = ((l3->size / (512 * 1024)) << 18) |
                (X86_ENC_ASSOC(l3->associativity) << 12) |
@@ -8353,7 +8347,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
             *eax = *ebx = 0;
             encode_cache_cpuid80000006(caches->l2_cache,
-                                       NULL, ecx, edx, false);
+                                       NULL, ecx, edx);
             break;
         }

@@ -8369,7 +8363,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         encode_cache_cpuid80000006(caches->l2_cache,
                                    cpu->enable_l3_cache ?
                                    caches->l3_cache : NULL,
-                                   ecx, edx, true);
+                                   ecx, edx);
         break;
     }
     case 0x80000007:




