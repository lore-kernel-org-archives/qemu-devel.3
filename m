Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FD0D5B161
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 06:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVOxg-0006xG-4n; Tue, 16 Dec 2025 01:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVOxT-0006ux-QV
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 01:54:58 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVOxP-0006Vm-VV
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 01:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765868092; x=1797404092;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8G1fPLDj5eYCEf8XGsgbifuL6duzFNMKf58vFby9ed4=;
 b=HE2gcgOiZjL2YsVdY7T4HbPtP5wJlt6aTeAunU1azlpM3CzcxWO8WEUm
 yN+sNn0e3jmkGiui/yFZ0u1eL7BizQDvbOC/Sb/PKXvhD2V6esjoUJ1a5
 Enc4XtLzxNMj5Z3PG2SebwO/KJSGIYdEuje+ufFTxXLoTwmOcUeJ89kgr
 gvByt7gMD50xiS1wTuG9Fl/B1GqXkS4f36CnTAxt1r/cIwupcNTj6/76b
 posgfzwDust7tBuxe7qXKtdsu80edAlSt3KsKSD9oBdyGEvc9NHv78GVI
 kDx1nj7JDu87+Wzdh86mmeMGLYedPPQJTLj7lEekdIVqFPQamym7DnxLj Q==;
X-CSE-ConnectionGUID: JfVsaYRjSxWJLDrhAXSzpg==
X-CSE-MsgGUID: mqmPvV/RS+qUw5DjLnrB2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67661907"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="67661907"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 22:54:49 -0800
X-CSE-ConnectionGUID: wpn6cA0KRGKcehra2TE//A==
X-CSE-MsgGUID: YjlUoNvcTjyZZZaVdm2p0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="235337889"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 22:54:46 -0800
Message-ID: <67bcefc0-be27-47c2-a2a5-fd3f339e12a7@intel.com>
Date: Tue, 16 Dec 2025 14:54:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] hostmem: Support fully shared guest memfd to
 back a VM
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-9-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251215205203.1185099-9-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/16/2025 4:51 AM, Peter Xu wrote:
> Host backends supports guest-memfd now by detecting whether it's a
> confidential VM.  There's no way to choose it yet from the memory level to
> use it fully shared.  If we use guest-memfd, it so far always implies we
> need two layers of memory backends, while the guest-memfd only provides the
> private set of pages.
> 
> This patch introduces a way so that QEMU can consume guest memfd as the
> only source of memory to back the object (aka, fully shared).
> 
> To use the fully shared guest-memfd, one can add a memfd object with:
> 
>    -object memory-backend-memfd,guest-memfd=on,share=on
> 
> Note that share=on is required with fully shared guest_memfd.
> 
> PS: there's a trivial touch-up on fd<0 check, because the stub to create
> guest-memfd may return negative but not -1.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

