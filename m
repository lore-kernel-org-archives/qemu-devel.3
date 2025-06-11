Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9576C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 06:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPFCb-0006B7-NS; Wed, 11 Jun 2025 02:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uPFCa-0006Ay-8j
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:44:48 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uPFCY-0002rB-Ca
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749624286; x=1781160286;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kyFVcr15UkVGosPdopATwr02JiC80NtOEbhs3Jswq74=;
 b=DtCA2pCOzj2nBTu3Xum2yuX6XVYtZo6YyI2+FPAA5KQ5DTYrDxVcEyHY
 8hjwnmK5/LA8znz+h1AjzwTMojZ7jhAYm2GMKfhCWNYpCxCgVNtl/vjSG
 LLt6CyyM801GAY+PdeFEiftK+k+UZQc41l23KRm4qzXkfZA+2ffdnoTM/
 yeL5Dec+E6Y1u0lmU+r3E7NrG9GESO1HnD0wF7ySTc0e9VnKBqg0Kjven
 hqMTMQyD3sNj6aGfnKeFRZ9a6h3ReAYduvyAP8B3fC2wktJ2XXxn2rQrU
 VZtU7gp6WUXHb873SD60HeY9GD/BKGSqE2UiE6ZC4T2tKzcAXHponY/nx w==;
X-CSE-ConnectionGUID: yqkoChePSBSJ7+f/r7nlDg==
X-CSE-MsgGUID: kq2zIGHSTU+yAmzBNz1/0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="54384344"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="54384344"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 23:44:37 -0700
X-CSE-ConnectionGUID: VXtxiStERDq3zWuZ67ZhCg==
X-CSE-MsgGUID: qriKYZIeTdmUSdHnRQ5zGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="147990543"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 23:44:36 -0700
Message-ID: <dfd6dc01-f45e-4c71-934e-272499666663@intel.com>
Date: Wed, 11 Jun 2025 14:44:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/31] i386/kvm: Prefault memory on page state change
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <thomas.lendacky@amd.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
 <20250606123447.538131-17-pbonzini@redhat.com>
 <92c90e43-35a6-48a9-8634-0075aed2988a@intel.com>
 <CABgObfbg5yZ_7xUsotSpbDtU=tKWTu-PONJcgnH98mkSx+PxDQ@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CABgObfbg5yZ_7xUsotSpbDtU=tKWTu-PONJcgnH98mkSx+PxDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/11/2025 2:12 PM, Paolo Bonzini wrote:
> On Wed, Jun 11, 2025 at 4:56 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>> Paolo,
>>
>> This one is not supposed to be pulled until we fix KVM as you said:
>> https://lore.kernel.org/qemu-devel/d0983ba3-383b-4c81-9cfd-b5b0d26a5d17@redhat.com/
> 
> The bug was understood and fix just a few days away, so I included it.
> I'll send the fix to Linus today too.

I thought kernel fix will go in before QEMU's.

Anyway, it sounds good that you will send KVM pull request today.

Thanks!

> Paolo
> 
>> BTW, I have sent the KVM fix:
>> https://lore.kernel.org/all/20250611001018.2179964-1-xiaoyao.li@intel.com/
> 


