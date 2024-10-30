Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA79D74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 02:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ydX-00049a-8i; Tue, 29 Oct 2024 22:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5ydV-00049E-PA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 22:40:41 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5ydT-0006pR-1W
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 22:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730256039; x=1761792039;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lz8GrKfLF5V+ioLtIjqKCp22h9psB09WZcRigAiFrU8=;
 b=T1Nz0gB3PHQX4whUlJ6isAM52LZQrwQ59tMjmre5APAxJfLcDrs763u0
 mlRW8BSB9WnIRET++uTBGaI09P0H5ojeu163rjtuzno5kIbGLKyul5NYA
 mfrKut/5GQ0bO1X8QPHiWKfPwsO099JUm9Q3LADcEYtcMAjfVdHGv76g9
 hBsZ6VbeSeZRJZqFJwPYFIsj6lly9cHgpG/rCpGS+M3tF4qg1pG02HJ4z
 QRU7/gzjmjiyyDbP+UGKYADX3Uf2PGRCWgEZNfocYix8cahq51CCEuiTv
 uZtLK1PLggXulVO+Pdrj1ArJLwncXRlwcqrdHBiKmWOPWQejIfw24FT/l g==;
X-CSE-ConnectionGUID: mIZ6czvLTECgQDfwjmYYcw==
X-CSE-MsgGUID: YRNB/QxcToyrTCEXWoc/Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30135613"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30135613"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 19:40:35 -0700
X-CSE-ConnectionGUID: ZtUGH0uqSs6JqYaQudwywA==
X-CSE-MsgGUID: fq0VWX+jQESAT7r5kkxG6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="86941863"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 29 Oct 2024 19:40:34 -0700
Date: Wed, 30 Oct 2024 10:56:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tao1.su@linux.intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 1/8] target/i386: cpu: set correct supported XCR0
 features for TCG
Message-ID: <ZyGgdYUrwg+uAhtj@intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151858.550269-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Oct 29, 2024 at 04:18:51PM +0100, Paolo Bonzini wrote:
> Date: Tue, 29 Oct 2024 16:18:51 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/8] target/i386: cpu: set correct supported XCR0 features
>  for TCG
> X-Mailer: git-send-email 2.47.0
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


