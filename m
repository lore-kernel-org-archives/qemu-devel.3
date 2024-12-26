Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3EBE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 04:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQfXY-0001CM-Rz; Wed, 25 Dec 2024 23:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQfXW-00016f-Te
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 23:32:02 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQfXV-0002Sg-C3
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 23:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735187521; x=1766723521;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BScA6+7c2Uzy3ajDa3ywiMRMoOfFnmuh9IhjoNMF//E=;
 b=nFKX8uKIQzRBnIiMTEVpAtc4hAE/TriI6goUeOhZhU7VXuDE1URhrp9C
 2bGiRBj3r5Jab/72+qT6WVNTInzHmV/RVZBKNhRxzyZsbJxQj2T1rxdgU
 41RNxLWwkIovGJAVYjzLyBxmaWBFJgw1OG7NJVsEZkU/+zoj3D8yvJ9Et
 4Yj5f35jajdKonxaKaE5R4R8ZxcARqN45ba/3fM5bzjeDDfPvDJ/ytGy0
 8TMgcBKFg4Zf2+/Dm+OrNhQpPM9hMaYrnowEuGoMo26qf3v6u/Z/clAQ4
 xXGs7XUip7K1xCWxVL277N2qKZEp5ReqNpQmqFNpj6KC7/wmHw409Istz A==;
X-CSE-ConnectionGUID: 1vLvkv7VTkGwkPfmE9yaOQ==
X-CSE-MsgGUID: HPKhD8RyShqMBg3MxUoAQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35727024"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; d="scan'208";a="35727024"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 20:32:00 -0800
X-CSE-ConnectionGUID: /BbAoTbtRomMm0X835VNWg==
X-CSE-MsgGUID: VFbr1z/XSZaXepGytYdZVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="137177011"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 25 Dec 2024 20:31:59 -0800
Date: Thu, 26 Dec 2024 12:50:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 10/12] rust: qemu-api-macros: extend error reporting
 facility to parse errors
Message-ID: <Z2zgoSBP40LXgA2B@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Dec 20, 2024 at 03:29:52PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:52 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/12] rust: qemu-api-macros: extend error reporting
>  facility to parse errors
> X-Mailer: git-send-email 2.47.1
> 
> Generalize the CompileError tuple to an enum, that can be either an error
> message or a parse error from syn.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api-macros/src/lib.rs   | 27 ++++++++++-----------------
>  rust/qemu-api-macros/src/utils.rs | 26 ++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 17 deletions(-)
>  create mode 100644 rust/qemu-api-macros/src/utils.rs
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


