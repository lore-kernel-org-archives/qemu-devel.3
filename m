Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8226C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc4Qx-0002Nw-6S; Wed, 16 Jul 2025 11:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uc4Qo-0002Lc-7h
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:52:30 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uc4Qj-0008Va-Vq
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752681146; x=1784217146;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=z4TPOmjLG82jORhUsu+6u4CQtu3Y90VBMPUl8VkiJJI=;
 b=IdFZr5aCEM2TqNjdnDhRcLOwrxTWXv1cDMKuq+G2CvSkoU4CAAwko8PE
 A/qKlicKHQe3v5/rzwxs1iUC/QMUHy1gWjFJGOaL2XqhuL+tnvmJMbdry
 yG5qpjS+n5EEWUxzQY+nH3joP0APe8EuXqnjebzEhIAt+PwP4X4XShrYz
 vKgBpq1IVNbIrytNZ4GVjmsKN6dEzotgJzQyLbTpCqkkfUcxYWGiVFPfi
 l+ljaCMgLV+0lFvT8zEirF0zFLpv/iS8Rx60jlOi88UQkoG8fYAp8Y2PF
 z6GsujgmWpT++CH/90pzkK5zQ/B034MiuUfyoOk6wUhXd59JiVaanxD8O w==;
X-CSE-ConnectionGUID: 3d6+kc4fRQq1YnoH7V4yBw==
X-CSE-MsgGUID: wWL3+/GMQxWhIYxR7S31jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55080677"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; d="scan'208";a="55080677"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 08:52:23 -0700
X-CSE-ConnectionGUID: kWsXuQkMSzOZauKGvrHIIw==
X-CSE-MsgGUID: WKdXgAKAQZm1jKphjMvIRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; d="scan'208";a="161845066"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 16 Jul 2025 08:52:22 -0700
Date: Thu, 17 Jul 2025 00:13:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: boot failure on top of current git
Message-ID: <aHfPwaF+uCOG8c+d@intel.com>
References: <6c04f89b-0313-481a-9d26-1fe9e60e0616@redhat.com>
 <1331c1fe-6064-4580-8464-02dee23c1fe2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1331c1fe-6064-4580-8464-02dee23c1fe2@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 05:22:46PM +0200, Paolo Bonzini wrote:
> Date: Wed, 16 Jul 2025 17:22:46 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: boot failure on top of current git
> 
> On 7/16/25 16:44, Paolo Abeni wrote:
> > Hi,
> > 
> > I'm observing boot failure for a rhel-9.7 VM. I'm using qemu git tree at
> > commit c079d3a31e.
> 
> No and I cannot reproduce it.
> 
> What host is it (processor) and kernel version?
> 
> Paolo

It sounds like x86_ext_save_areas[] wasn't initialized correctly.

I just checked the related logic, in the previous QEMU, for x86_cpu_post_initfn(),
it initialized x86_ext_save_areas[] first, then called accel_cpu_instance_init(),
so that KVM's xsave assertion didn't complain.

But now, when we move accel_cpu_instance_init() to x86_cpu_initfn(), KVM
checks x86_ext_save_areas[] before x86_ext_save_areas[] initialization.

I understand, we should initialize x86_ext_save_areas[] in
x86_cpu_initfn() as well. Maybe we need something like this:

---
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index da7d8dca633e..c8fccabeee71 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9619,6 +9619,16 @@ static void x86_cpu_register_feature_bit_props(X86CPUClass *xcc,
 }

 static void x86_cpu_post_initfn(Object *obj)
+{
+#ifndef CONFIG_USER_ONLY
+    if (current_machine && current_machine->cgs) {
+        x86_confidential_guest_cpu_instance_init(
+            X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
+    }
+#endif
+}
+
+static void x86_cpu_init_xsave(void)
 {
     static bool first = true;
     uint64_t supported_xcr0;
@@ -9639,13 +9649,6 @@ static void x86_cpu_post_initfn(Object *obj)
             }
         }
     }
-
-#ifndef CONFIG_USER_ONLY
-    if (current_machine && current_machine->cgs) {
-        x86_confidential_guest_cpu_instance_init(
-            X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
-    }
-#endif
 }

 static void x86_cpu_init_default_topo(X86CPU *cpu)
@@ -9715,6 +9718,7 @@ static void x86_cpu_initfn(Object *obj)
         x86_cpu_load_model(cpu, xcc->model);
     }

+    x86_cpu_init_xsave();
     accel_cpu_instance_init(CPU(obj));
 }



