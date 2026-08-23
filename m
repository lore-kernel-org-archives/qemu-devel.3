Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB47C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 08:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy3yv-0003NX-Jz; Sun, 23 Aug 2026 04:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3yt-0003Iq-SJ
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:55:07 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3ys-0004Wf-8x
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787475307; x=1819011307;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n6VFAnBXcNjuJGOFr6OMzXoYlpDVurWKsqexkPLYQRk=;
 b=gjjAEfcQoACrn6GWTu/r/pNGPYeZFjFllNM9nvPcIlE2WSlj+bxM3r8B
 eid3CTYTg1gx70Nr00JgCierH4RZ/1lihU6e4hkyUOsVHsbUVkaj3Vkv3
 DlYdorwDxnhDzKSRG5ngIPFsISgkQh4rgsGPKbRafef5RgxtZ1gWKeqEu
 xkOLSKnK8xUB/cpsnoko25/RP3YqqybhuJYFmPO3xdvQug50wqINIi0U3
 XG/u4AldKWb/+8cZK/Fgm/BYjflWWzDJ4fdRrcZohe50IGv74+qCKNvLu
 7Kqc+MXDXuvwT5pJj9Afw0q19ENbjA47fTFNJXK6GssCYog7PBsD+NdN6 g==;
X-CSE-ConnectionGUID: GG/MDft/QFqYDKY9lmdncQ==
X-CSE-MsgGUID: /zYL2vMaSSuYRZTVmcdv/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="105333094"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="105333094"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 01:55:04 -0700
X-CSE-ConnectionGUID: iMgrhqd9R864fBDPngSsuQ==
X-CSE-MsgGUID: sSqU5W35TuuxMPLjPDgbSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="263022686"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2026 01:55:02 -0700
Date: Sun, 23 Aug 2026 16:55:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 6/9] target/i386: Do not broadcast injected MCEs for
 Hygon
Message-ID: <aoq1ZT66amRjhuNa@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-7-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-7-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 10, 2026 at 04:29:53PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:53 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 6/9] target/i386: Do not broadcast injected MCEs for
>  Hygon
> X-Mailer: git-send-email 2.43.7
> 
> cpu_x86_support_mca_broadcast() excludes AMD CPUs because QEMU handles
> AMD injected MCEs as local machine checks, not as Intel-style broadcast
> MCEs.  Hygon Dhyana missed that exclusion: it is not an AMD vendor CPU
> and its family is greater than 6, so QEMU reported MCA broadcast
> support.
> 
> This affects QEMU's synthetic MCE injection paths.  KVM memory-failure
> injection uses this helper to decide whether to set MCE_INJECT_BROADCAST.
> HMP 'mce -b' uses it to decide whether a broadcast request is valid.
> With a multi-vCPU Dhyana guest, QEMU could fan out an injected MCE to
> secondary vCPUs and populate extra bank records.
> 
> Linux routes Hygon through the AMD MCE feature initialization path and
> does not use Intel/Zhaoxin LMCE broadcast handling for Hygon.  Do not
> advertise Intel-style MCA broadcast support for Hygon in QEMU's injected
> MCE paths.
> 
> This is limited to the MCE broadcast-support decision.  It does not claim
> that all Hygon MCE/MCA behavior is identical to AMD.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


