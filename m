Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B05C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjnP-0007Ip-EU; Tue, 19 Mar 2024 20:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1rmjnN-0007Ic-0L
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:27:05 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1rmjnK-0004Te-MA
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710894422; x=1742430422;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0ZIgM47+0dPHNGTOp2N3vc3VAyk4OgBWsOoYIEdKJUQ=;
 b=dIhL3UQ3jihImjB8wCLjHZdU5qRZNnq6zCrDgmw1PyuizA2Qdo4Xo2+s
 Wl0o3N9TIvYCc6t9RPYrJMLdH++66wJZyqcQ1sCEATE8ntUEuk3jwII1/
 S5MEYcs+PH1u53oEKDUfkwB6odKJFOuUlRQjEFqW5/WFXIGbcymN6D+3u
 gczmWP3DdLTlXdDJD0yCEUQmpYecgXmaL/T9QXsi2bpjY7vgI/0lNZ4Yi
 DQGr7xoq4DFzvYo5aizRq49dCBiFB7AB9sxeHKDIjqW4WQGNzSq+OTJRo
 bzMMMSZj23nrAhHCegUXfFg7+QakL236zi3K4xooiaKVBukHp/GiWcGoP w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5646634"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="5646634"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 17:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; d="scan'208";a="37104166"
Received: from kruthisr-mobl.amr.corp.intel.com (HELO desk) ([10.209.29.224])
 by fmviesa002-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:27:00 -0700
Date: Tue, 19 Mar 2024 17:26:53 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Chao Gao <chao.gao@intel.com>, antonio.gomez.iglesias@linux.intel.com,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] target/i386: Export RFDS bit to guests
Message-ID: <20240320002653.po7mqtzhwpr24rer@desk>
References: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
 <7de64137-d11f-4029-b296-3b8a8be35178@intel.com>
 <20240319150851.kllaqhbfysfkqcey@desk>
 <1f06acaf-c63e-42b3-b355-3024ded1fd8e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f06acaf-c63e-42b3-b355-3024ded1fd8e@intel.com>
Received-SPF: none client-ip=192.198.163.19;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Wed, Mar 20, 2024 at 08:23:39AM +0800, Xiaoyao Li wrote:
> On 3/19/2024 11:08 PM, Pawan Gupta wrote:
> > On Tue, Mar 19, 2024 at 12:22:08PM +0800, Xiaoyao Li wrote:
> > > On 3/13/2024 10:53 PM, Pawan Gupta wrote:
> > > > Register File Data Sampling (RFDS) is a CPU side-channel vulnerability
> > > > that may expose stale register value. CPUs that set RFDS_NO bit in MSR
> > > > IA32_ARCH_CAPABILITIES indicate that they are not vulnerable to RFDS.
> > > > Similarly, RFDS_CLEAR indicates that CPU is affected by RFDS, and has
> > > > the microcode to help mitigate RFDS.
> > > > 
> > > > Make RFDS_CLEAR and RFDS_NO bits available to guests.
> > > 
> > > What's the status of KVM part?
> > 
> > KVM part is already upstreamed and backported:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.8.1&id=50d33b98b1e23d1cd8743b3cac7a0ae5718b8b00
> 
> I see. It was not sent to kvm maillist and not merged through KVM tree.
> 
> With KVM part in palce,
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks.

