Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7D5C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 15:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYp95-0004Vd-18; Tue, 30 Jul 2024 11:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYp92-0004Un-Uw
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:52:13 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYp90-0005lN-9T
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722354730; x=1753890730;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=p/tLlN/qwup38E3LddVS8cc5hG/xzQuRGM9UBru5vCQ=;
 b=c8PNXhgKW5n5Uj0AKsuZUbxjFOoP0tUOvEyAdkS+SHAeC5R8SrzHA21x
 NawyklPx3NOqmpRA3oD3P6wWNctnNVMsRX74KpboLMo2fmsKb9Jqz+np6
 nI83x4vK7VAc0FYpIIYzfeFgaRm1cjzFNqe6J9ybnHQSIDzdJmimDNCBm
 GzXCf6sdiFrceZWOi0GgFzOrxnTnluWa6hMKRqMY85vBCE4c+IfOjNfMa
 ZkTLICkTk5xNhNhlwwqLGqi4jxdFOm0702u04EmP9EuXraBk3GNbxPkrz
 KkKDGFu4hXn/8aAgunjN1biAw0Mr4/1bcvfu0kl5YL0ZrX06Pei6CSUWh A==;
X-CSE-ConnectionGUID: L/KUmv/WS/uwVIFXP9enkw==
X-CSE-MsgGUID: 6/OYUh2+Smam8cVssHnWFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="19985975"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="19985975"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2024 08:52:06 -0700
X-CSE-ConnectionGUID: Gajo/mNgTDOk/94tm/4GOQ==
X-CSE-MsgGUID: cXui3QsJSn2MKZJDm19DZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="85016642"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 30 Jul 2024 08:52:05 -0700
Date: Wed, 31 Jul 2024 00:07:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] i386: Clean up SGX for microvm, completely
Message-ID: <ZqkP15oEyDyjvWSv@intel.com>
References: <20240730045544.2516284-1-zhao1.liu@intel.com>
 <20240730154430.69879-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730154430.69879-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue, Jul 30, 2024 at 05:44:30PM +0200, Paolo Bonzini wrote:
> Date: Tue, 30 Jul 2024 17:44:30 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 0/4] i386: Clean up SGX for microvm, completely
> X-Mailer: git-send-email 2.45.2
> 
> Queued, thanks.
> 

Thanks Paolo! BTW, could you please have a look at another 2 cleanup
seriess from me? :)

https://lore.kernel.org/qemu-devel/20240716161015.263031-1-zhao1.liu@intel.com/

and

https://lore.kernel.org/qemu-devel/20240619144215.3273989-1-zhao1.liu@intel.com/

Best Regards,
Zhao


