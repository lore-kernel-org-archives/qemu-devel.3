Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0412DD12663
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8FUU-0001Ok-TR; Tue, 05 Nov 2024 04:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t8FUS-0001OI-Ue
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:04:44 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t8FUQ-00028M-Kl
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730797482; x=1762333482;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+A9FoRB9Gu/ZJdhFBBI6LpQfR5TKV9eM2U2d7K5Suxc=;
 b=f3Cfh5MSaejyEYg1ZZRT2KlZqVTsKIa2ow1GUBUIDwkAIZj7Mvo5sjq3
 BVtHu3pNUuu2R53mjkMrclN6r0Y0NMZIBnbOBb08NgIg5lwuVJUWFBORA
 eFKXplSb7QPMPdKX2pdX1aq/ITUeiFkTsUBrxvfCvEH9x2A1RuMt0m3On
 bdknpvEh7BJHYW4/Vbtiq07xwzRJtxQTyzDhSvGKWs+q24jAmbyZBYAab
 uUq40Ru/LFc//ob2TFIhkW5UJWUYBPUfglCIzDuisV4PlHCJ5F9jH2w86
 apl5ZvBxJhXcSA9yegyVOv/ats45Uq0BuVuTHggOGFIqO2uWyn6/T8rCL w==;
X-CSE-ConnectionGUID: m0dB0w7gRkatFbMBGNTsqQ==
X-CSE-MsgGUID: RfFH4h3uSaqlDn1MQ39roA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="48038422"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="48038422"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 01:04:38 -0800
X-CSE-ConnectionGUID: ZlO6kOQyQQCmYFM5c3b8cg==
X-CSE-MsgGUID: SvLLfuONQJakd2yeMGjQzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="87878207"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 01:04:37 -0800
Date: Tue, 5 Nov 2024 16:59:31 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: add avx-vnni-int16 feature
Message-ID: <Zynec96wQspSA4A7@linux.bj.intel.com>
References: <20241105082848.230020-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105082848.230020-1-pbonzini@redhat.com>
Received-SPF: none client-ip=192.198.163.8;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 05, 2024 at 09:28:48AM +0100, Paolo Bonzini wrote:

> SHA512, SM3, SM4 (CPUID[EAX=7,ECX=1).EAX bits 0 to 2) is supported by
> Clearwater Forest processor, add it to QEMU as it does not need any
> specific enablement.
> 
> See https://lore.kernel.org/kvm/20241105054825.870939-1-tao1.su@linux.intel.com/
> for reference.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

The patch name is still for avx-vnni-int16.

LGTM,

Reviewed-by: Tao Su <tao1.su@linux.intel.com>

