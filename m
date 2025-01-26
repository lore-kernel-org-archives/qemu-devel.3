Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D28DC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 14:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc43m-0007HL-PY; Sun, 26 Jan 2025 09:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tc43k-0007Gl-Ot; Sun, 26 Jan 2025 09:56:25 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tc43i-0007gS-Sd; Sun, 26 Jan 2025 09:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737903383; x=1769439383;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EOfQD7wJs/heqaF+kayW8lEZfAd8tm/HXf2yRjISUGQ=;
 b=K9n2pmwKvocriTgYZIAhMvbvtVDrEkLQQWnyU0plDEqDaHXKV5uXKerY
 22O57OsQu/dB5iWiGwEOxQ+QrgkeJpm1uZQv55fj8u68cx1RL45Ac4fyr
 +ldQz/whQh+hwcXvuswq0p8b+6U1uDEF5frR+c4IQR7ablfy5rj1Tzr6e
 QawRpmHEZR8NJtQE7PcmfPQRWX4XVLBssKTku3luXZOZuo4ul3+Ghw9XF
 eyh6r+29E8OEIgjJiazTi5yaxlSHeULQxV1fNtGyBTT9yZiAzeGBh0Y3v
 Lmf8iWiu92LwVBmJwa9ybwuxn2+et/sRid2/69I6+i/3/aAeCuhAcdQpg A==;
X-CSE-ConnectionGUID: LERZRKl0TC+vERTlfODZqA==
X-CSE-MsgGUID: /rl33qU8Qpm2twvDzd4dKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="38543974"
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; d="scan'208";a="38543974"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2025 06:56:18 -0800
X-CSE-ConnectionGUID: Hty65QKfRR+5TFQbFn+wiw==
X-CSE-MsgGUID: qgm0VFW0RtKHT7rZopBC/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112237615"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 26 Jan 2025 06:56:17 -0800
Date: Sun, 26 Jan 2025 23:15:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
Message-ID: <Z5ZRnYDZdZcgyCsR@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Paolo,

On Fri, Jan 17, 2025 at 08:39:55PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:39:55 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/10] rust: qom: add reference counting functionality
> X-Mailer: git-send-email 2.47.1
> 
> Add a smart pointer that allows to add and remove references from
> QOM objects.  It's important to note that while all QOM objects have a
> reference count, in practice not all of them have their lifetime guarded
> by it.

About the background, I have a maybe common question...why Rust needs
extra reference count guarding?

For C side, I notice for child objects, which may be totally embedded in
parent object, or may be pointed to by a pointer member in parent object
(like pl011's clock), they usually become the Child<> property of their
parents by object_initialize_child() (for embedded child) or
object_property_add_child() (for child pointer).

And both these 2 interfaces will increase the ref count in
object_property_try_add_child(). With ref count increasing, it seems
that the Child<> property also express the meaning like "the child
object is 'owned' by its parent".

So, what are the benefits of `Owned` when we also creates Child<>
relationship?

Additionally, I felt that the ref count may be a bit confusing. After
creating Child<> property, the child object's ref count is sometimes 1,
and other times it's 2:

 * With object_initialize_child(), child's ref count is 1.

 * With object_property_add_child() (usually after a object_new() to
   create child first):

   - sometimes user will call object_unref(), and then the ref count is 1.
     E.g., x86_cpu_apic_create() in target/i386/cpu-apic.c.

   - sometimes no object_unref(), then ref count is 2.
     E.g., exynos4210_realize() in hw/arm/exynos4210.c, creats "cortex-a9".

> Embedded objects, specifically, are confined to the lifetime of
> the owner.
> 
> When writing Rust bindings this is important, because embedded objects are
> *never* used through the "Owned<>" smart pointer that is introduced here.

From this description, I understand your goal is:

 * For embedded child object, its lifetimer is managed by its parent
   object, through Child<> for the most cases.

 * For non-embedded child - a pointer/reference in parent object, its
   lifetimer is managed by `Owned<>` (and with Child<>).

Am I right?

Thanks,
Zhao


