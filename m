Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049B4C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 06:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHeNo-0002JB-UV; Thu, 13 Jun 2024 02:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHeNk-0002Ir-W4
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:56:25 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHeNi-00043Q-Jp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718261783; x=1749797783;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aCam3PViCpM8DdraXfcSgE9gy+VAs4Jbi/oYNCofGWI=;
 b=DbdfYizQsKAYUX1/iTS4+uhB3A2hQ1s+r28sF6mbMzz8VATc3Sten8V2
 2mSZnjn3WjiubsN3mZbK0gfWvnJlGS6ijXnHvP2ePSlieZ+nM+By9yJGw
 KFCwHzWzPeiX7N0oDq9gygUVxiallget3bufAMuVc8MhO7bed2W6qPib4
 1oG197epUhW6Grmjj9kkBtqQu3vfAxcbmfOq3HrskCbMKlUP9Yk7dxLRL
 dUojO+5tywBnkQgAqTqZ2VbnmQHMGsfTBo2vhxZtWmDM2yFpxDg8vi+Yt
 NE+V0oHxDaAkxfRatAEUoWeUScz1yOjEO+QAzco+mDUL4H75k83r8hwzl A==;
X-CSE-ConnectionGUID: Daaq4V6VSDCGayI0YxEoHA==
X-CSE-MsgGUID: iTiNsd+tS36nWDiKffnGsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15214405"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="15214405"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 23:56:20 -0700
X-CSE-ConnectionGUID: fNLFrMJhTzC1k/HYhUz84g==
X-CSE-MsgGUID: ydyVExa1TXaD/U4j79RDKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="39902419"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2024 23:56:18 -0700
Date: Thu, 13 Jun 2024 15:11:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 3/4] i386/cpu: Enable perfmon-v2 and RAS feature bits on
 EPYC-Genoa
Message-ID: <ZmqbtLToD1ac7VO+@intel.com>
References: <cover.1718218999.git.babu.moger@amd.com>
 <1dc29da3f04b4639a3f0b36d0e97d391da9802a0.1718218999.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dc29da3f04b4639a3f0b36d0e97d391da9802a0.1718218999.git.babu.moger@amd.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 12, 2024 at 02:12:19PM -0500, Babu Moger wrote:
> Date: Wed, 12 Jun 2024 14:12:19 -0500
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH 3/4] i386/cpu: Enable perfmon-v2 and RAS feature bits on
>  EPYC-Genoa
> X-Mailer: git-send-email 2.34.1
> 
> Following feature bits are added on EPYC-Genoa-v2 model.
> 
> perfmon-v2: Allows guests to make use of the PerfMonV2 features.

nit s/Allows/Allow/

> SUCCOR: Software uncorrectable error containment and recovery capability.
>             The processor supports software containment of uncorrectable errors
>             through context synchronizing data poisoning and deferred error
>             interrupts.
> 
> McaOverflowRecov: MCA overflow recovery support.
> 
> The feature details are available in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
>  target/i386/cpu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


