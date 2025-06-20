Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18F9C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 06:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSVd8-0004qq-Lg; Fri, 20 Jun 2025 02:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uSVd6-0004lo-QJ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 02:53:40 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uSVd4-0004JV-VS
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 02:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750402419; x=1781938419;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=a0A43Ym2BBwMlVuVIb5lSd7sc7ViDhCAPSQnXKut+GU=;
 b=mqX+aPkxuw09z4V5xPPhKrfOle03l1QnuLZs+cwgj4CQx3BmeQrAx89c
 0ny9Pcd7fCAU/cUBNG2z5eTS+8WiS6S8ZHUvAVDXlh1+C1FVXTdHnMdWR
 NiiX9qsPEr7bXDn7OaGszGwsx5Dm90By0JGmhD71ySivIcfh1NiRP0fT2
 GrMxgtPiizWTE2ogNi0svnQvWbf4eLbeC87u9xpfMCZ4tSdjh5iRPym/H
 +WUuKJQwimEicG6AjR+SdQraNfJGvpCn8VCdL7WCkUrONV3b5esvRghCg
 1g/xItTaaG1weY4VIRsTtuGysUJi+c9VKLgAjXzqnXHbSAK1v2SoOmJB+ Q==;
X-CSE-ConnectionGUID: USjwrrmvQZOpWJuXBqhEWQ==
X-CSE-MsgGUID: 0zyZ0GB8QFmROn7KFvd0cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63703730"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="63703730"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 23:53:37 -0700
X-CSE-ConnectionGUID: QxVNLJmZQcOkureIHw/aGQ==
X-CSE-MsgGUID: J1XrvVFaTOaiOZqcGtV/ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="174442470"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 23:53:35 -0700
Message-ID: <9622c3a3-1be6-4548-821d-9522edab5ad9@intel.com>
Date: Fri, 20 Jun 2025 14:53:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] TDX attestation support
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250619203351.393786-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250619203351.393786-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

On 6/20/2025 4:33 AM, Paolo Bonzini wrote:
> This is my update of Binbin's patches from
> https://github.com/intel-staging/qemu-tdx/commits/binbinwu/GetTdVmCallInfo_fixup/,
> updated for the proposed userspace API at
> https://lore.kernel.org/kvm/20250619180159.187358-1-pbonzini@redhat.com/T/
> and with a few tweaks to drop the remains of the
> quote generator QOM object.
> 
> I am not sure of the state of Daniel's patch to parse the
> GET_QUOTE request and repack it for the quote generation
> service.  Here I have just squashed it into patch 3.

That looks good to me except one issue of the check of 
QGS_MSG_LIB_MINOR_VER, as I commented in patch 3. But that's instead a 
QGS issue, as I think.

> I have not tested this beyond compilation, but I wanted
> to send it out before going on vacation---and possibly
> even include patches 1-2 in a pull request.

I tested it, and only found some small issues and commented in patch 3.

I think maybe we can pull all the series with the issue I reported 
fixed? since it's in the development cycle of QEMU 10.1. If any new 
issue appears, we still have chance to fix.

> Paolo
> 
> 
> Binbin Wu (1):
>    i386/tdx: handle TDG.VP.VMCALL<GetTdVmCallInfo>
> 
> Isaku Yamahata (1):
>    i386/tdx: handle TDG.VP.VMCALL<GetQuote>
> 
> Paolo Bonzini (1):
>    update Linux headers to v6.16-rc3
> 
>   qapi/qom.json                                 |   8 +-
>   include/standard-headers/asm-x86/setup_data.h |  13 +-
>   include/standard-headers/drm/drm_fourcc.h     |  45 +++
>   include/standard-headers/linux/ethtool.h      | 124 ++++----
>   include/standard-headers/linux/fuse.h         |   6 +-
>   .../linux/input-event-codes.h                 |   3 +-
>   include/standard-headers/linux/pci_regs.h     |  12 +-
>   include/standard-headers/linux/virtio_gpu.h   |   3 +-
>   include/standard-headers/linux/virtio_pci.h   |   1 +
>   linux-headers/asm-arm64/kvm.h                 |   9 +-
>   linux-headers/asm-x86/kvm.h                   |   1 +
>   linux-headers/linux/bits.h                    |   4 +-
>   linux-headers/linux/kvm.h                     |  25 ++
>   linux-headers/linux/vhost.h                   |   4 +-
>   target/i386/kvm/tdx-quote-generator.h         |  82 +++++
>   target/i386/kvm/tdx.h                         |  19 ++
>   target/i386/kvm/kvm.c                         |  15 +
>   target/i386/kvm/tdx-quote-generator.c         | 300 ++++++++++++++++++
>   target/i386/kvm/tdx-stub.c                    |   8 +
>   target/i386/kvm/tdx.c                         | 186 +++++++++++
>   target/i386/kvm/meson.build                   |   2 +-
>   21 files changed, 795 insertions(+), 75 deletions(-)
>   create mode 100644 target/i386/kvm/tdx-quote-generator.h
>   create mode 100644 target/i386/kvm/tdx-quote-generator.c
> 


