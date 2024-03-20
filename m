Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1919BC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2xd-00018X-7z; Wed, 20 Mar 2024 16:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rn2xb-00018N-VL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:54:56 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rn2xY-0004oG-EZ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710968092; x=1742504092;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=z+uhnrXGcV33J9cLFUCMuRjcEsixfuEkrkh6l1QzBWA=;
 b=cYQVu/MKA6h8aNl+/jvHUH6OUAiruEDNBv69BEsXezfYLyJ4sv6LAQ5L
 pDgmm37JCTAkpGZzp55Dd2zukkBJARTjyBhpitmveS0QsCMdti9L+QTCD
 UyqS4f6qEcE93Bs4xdocLHJyaYlsf7fsROP/saIfNb2KNMZYyjCFVO+P4
 3NkODtXcUS1vSEG8EUriSA9sbt4fXHKMnimsRJVCFCR0cbYp6pe2CkK3M
 /pw4q2N+RJyI0GGHFpndhSRRmX55j9ZAMlw/C4+NPNL+dnrpx2v6sStuf
 iAR/oDa1mMELOmhrx2KZUYw00/I521vefGueyKUUeeyu8dPZuDg3AsdDp g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6052207"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="6052207"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 13:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="14929346"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 13:54:48 -0700
Message-ID: <5c9ee0e8-efbb-48bb-ad8b-804cf80e3bf8@intel.com>
Date: Thu, 21 Mar 2024 04:54:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 00/49] Add AMD Secure Nested Paging (SEV-SNP)
 support
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <eea690c2-7d2f-4a35-b5c3-078c12ef228b@redhat.com>
 <CABgObfYzNksaaHgZ5kozXohwWWyDgfw3ue2juEbZmVteb5Trqw@mail.gmail.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CABgObfYzNksaaHgZ5kozXohwWWyDgfw3ue2juEbZmVteb5Trqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/21/2024 1:08 AM, Paolo Bonzini wrote:
> On Wed, Mar 20, 2024 at 10:59 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> I will now focus on reviewing patches 6-20.  This way we can prepare a
>> common tree for SEV_INIT2/SNP/TDX, for both vendors to build upon.
> 
> Ok, the attachment is the delta that I have. The only major change is
> requiring discard (thus effectively blocking VFIO support for
> SEV-SNP/TDX, at least for now).
> 
> I will push it shortly to the same sevinit2 branch, and will post the
> patches sometime soon.
> 
> Xiaoyao, you can use that branch too (it's on
> https://gitlab.com/bonzini/qemu) as the basis for your TDX work.

Sure, it's really a good news for us.

BTW, there are some minor comments on guest_memfd patches of my v5 
post[*]. Could you please resolve them it your branch?

[*] 
https://lore.kernel.org/qemu-devel/20240229063726.610065-1-xiaoyao.li@intel.com/

> Paolo


