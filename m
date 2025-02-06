Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06823C02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 03:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfsE1-0006Og-7p; Wed, 05 Feb 2025 22:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfsE0-0006OU-HQ; Wed, 05 Feb 2025 22:06:44 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfsDx-0008Ll-Mt; Wed, 05 Feb 2025 22:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738811202; x=1770347202;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=y0Z9R+38t3DIqdjo7tymkl+VihsQu+D1LwW3LVsDQeo=;
 b=knkdso5MOkqcr0qsGxlMl1CYYI/tqZpKiHX3xZj5hoI6F/+2zoFFNstU
 RfUa5/rLMVn2dN5CJbDPSQIqlvS1cN3/jbqaqNpLfQb7j+BA96nLK4WM1
 UR5f98RsUWSD2KDbEtPvPzXD8EQWj2pVxtOqqPFKnR/mxOnRx2geBcdza
 JkghC588vxedYAfo7edhjizo+PUqw0M6V6RBKbpiitgiQp2Yh15wMauno
 6bCbVSougO/KeCJ/M3eKzxxSeAfDiX/UuODsuV56+6fxufKmC/gh6OTxm
 gDbczQxb8S2YUMJkPQxOcCQek4/dO2Don0UxZWbF37AB0Ame7x5GqsxK2 Q==;
X-CSE-ConnectionGUID: LM0J+fELSBi92nQMh5oW/Q==
X-CSE-MsgGUID: 6OdTb4w7R6C5tpoIsnnAtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39534137"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; d="scan'208";a="39534137"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 19:06:39 -0800
X-CSE-ConnectionGUID: LWADxBl8SWqNJn0V0AUmVQ==
X-CSE-MsgGUID: uMEhz41PQvytT7lySjtuxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; d="scan'208";a="110920875"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 05 Feb 2025 19:06:37 -0800
Date: Thu, 6 Feb 2025 11:26:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
Message-ID: <Z6QrzloVEEpi/9p0@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Jan 17, 2025 at 08:39:55PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:39:55 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/10] rust: qom: add reference counting functionality
> X-Mailer: git-send-email 2.47.1
> 
> Add a smart pointer that allows to add and remove references from
> QOM objects.  It's important to note that while all QOM objects have a
> reference count, in practice not all of them have their lifetime guarded
> by it.  Embedded objects, specifically, are confined to the lifetime of
> the owner.
> 
> When writing Rust bindings this is important, because embedded objects are
> *never* used through the "Owned<>" smart pointer that is introduced here.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qom.rs     | 121 ++++++++++++++++++++++++++++++++++-
>  rust/qemu-api/src/vmstate.rs |   6 +-
>  2 files changed, 125 insertions(+), 2 deletions(-)
>

Revisit this patch (with Paolo's explaination), LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


