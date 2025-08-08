Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7285AC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHBH-00081Z-BC; Fri, 08 Aug 2025 03:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukHBC-0007ua-D5; Fri, 08 Aug 2025 03:06:19 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukHB6-0005i0-LE; Fri, 08 Aug 2025 03:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754636773; x=1786172773;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yVQb7GzZ+6mRw2zoMaUmO0SwVuUfkzOoA0gOIt6c0sI=;
 b=WP2Q0tds5IRZWqhw4aSD24MycJVXhg7oyXYPvbo5hyyZGs8+ND4CbB1V
 mFh+Duy3kFB5KoYayc6Ngt0DGTEhNtKzoaCsgE4NuE6YwtJpxekOEmnRj
 aUUyVrjXJCpzoUuaVI3Z0bnS5FRFXNQi9l+1mIkBA/hc4WkR6I0ygzx01
 9W/vmM05qdTtmjUI+p9AkdSi6L1BG3n8Y47t9MGQTTKJ+Mxxwovqu5Zv9
 YfgIspjEq9YrOIVz8VGv4PKqLUnZ37a79xsofqcyfwTN8lxM8WR/+XluN
 ItcxdB2H4oxwK+sR+glO/cBmgt9AoIzxb99HKXtFWZdRFEdJkdtMn7trv w==;
X-CSE-ConnectionGUID: Y7GP1yVVR7G02cJk2ANaeQ==
X-CSE-MsgGUID: 0jbVo7ZASVmaoasGz7ZCzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56185613"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="56185613"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 00:06:07 -0700
X-CSE-ConnectionGUID: R+NkKz1gSxi7GCka/HlDrw==
X-CSE-MsgGUID: 81lNukn0SJm+zrlFcvmK4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="165279225"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 08 Aug 2025 00:06:04 -0700
Date: Fri, 8 Aug 2025 15:27:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 01/26] rust/hpet: Fix the error caused by vm-memory
Message-ID: <aJWm737GvsHtz/On@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-2-zhao1.liu@intel.com>
 <4cc91b3d-ce3a-46fa-80da-fa5039f6a490@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc91b3d-ce3a-46fa-80da-fa5039f6a490@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 07, 2025 at 03:52:37PM +0200, Paolo Bonzini wrote:
> Date: Thu, 7 Aug 2025 15:52:37 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 01/26] rust/hpet: Fix the error caused by vm-memory
> 
> On 8/7/25 14:30, Zhao Liu wrote:
> > error[E0283]: type annotations needed
> >     --> hw/timer/hpet/src/device.rs:884:55
> >      |
> > 884 |         self.num_timers == self.num_timers_save.get().into()
> >      |                         --                            ^^^^
> >      |                         |
> >      |                         type must be known at this point
> >      |
> >      = note: multiple `impl`s satisfying `usize: PartialEq<_>` found in the following crates: `core`, `vm_memory`:
> >              - impl PartialEq<vm_memory::endian::BeSize> for usize;
> >              - impl PartialEq<vm_memory::endian::LeSize> for usize;
> >              - impl<host> PartialEq for usize
> >                where the constant `host` has type `bool`;
> > help: try using a fully qualified path to specify the expected types
> >      |
> > 884 |         self.num_timers == <u8 as Into<T>>::into(self.num_timers_save.get())
> >      |                            ++++++++++++++++++++++                          ~
> 
> Oh, interesting.  In this case, you can write:
> 
>     usize::from(self.num_timers_save.get())

Ah, yes, this way is simpler! Thanks.

-Zhao



