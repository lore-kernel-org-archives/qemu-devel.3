Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BB3C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYitS-0006B8-3X; Tue, 30 Jul 2024 05:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYitF-0005qZ-Ii; Tue, 30 Jul 2024 05:11:30 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYitC-0003es-Km; Tue, 30 Jul 2024 05:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722330687; x=1753866687;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Jt/KW4ijgn/wS46aVdfpJ4SG7pm8ZRBktxlKrLmiT2Q=;
 b=MN/i80mHQPoJOAfIyXHqGK2OGBmYWcAGTZ+BsYkorHjVkxxdS3dKGHGK
 oFJw3UZcM+gcHsyWkiZWxai4scGIhx+UbQg68YVmOHmGOtcQFLnZqVZKf
 K/FJJiCfPHNexYiYIQJ79/tbKWrjhsil9WFJVfo2wHiNPdogC0aoJAiIZ
 3gSt6yDgm4v0xn0g0X/ALZE2lZ9IM2VJR81DXjVpyOC+jJfJzh3jcKGlX
 QGwIfvRLKUcT5TkkFMzQTs9bRAdPbveWmhThu3eWijiOAbz5B2bFlYmfr
 3mTboNQnuLGjwVw/5O4YXrMXEZ4Y1sj81+TtGr48WEcxh3sK4uVIUCvz1 w==;
X-CSE-ConnectionGUID: WEkYle1kRdieVeDptXoU1Q==
X-CSE-MsgGUID: 0ESCV2z1TbqSthMraOHjKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20082660"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="20082660"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2024 02:11:21 -0700
X-CSE-ConnectionGUID: yNTegJrdQRCBmSsq7OI9IQ==
X-CSE-MsgGUID: thjTxyPDR4qq5CRxhP60Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="54182560"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 30 Jul 2024 02:11:11 -0700
Date: Tue, 30 Jul 2024 17:26:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com,
 andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com,
 den@openvz.org, eblake@redhat.com, eduardo@habkost.net,
 farman@linux.ibm.com, farosas@suse.de, hreitz@redhat.com,
 idryomov@gmail.com, iii@linux.ibm.com, jamin_lin@aspeedtech.com,
 jasowang@redhat.com, joel@jms.id.au, jsnow@redhat.com,
 kwolf@redhat.com, leetroy@gmail.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 mtosatti@redhat.com, nsg@linux.ibm.com, pasic@linux.ibm.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, pl@dlhnet.de,
 richard.henderson@linaro.org, stefanha@redhat.com,
 steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 09/18] qapi/machine: Rename CpuS390* to S390Cpu, and drop
 'prefix'
Message-ID: <Zqix4UGgy4adBVFG@intel.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-10-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730081032.1246748-10-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Tue, Jul 30, 2024 at 10:10:23AM +0200, Markus Armbruster wrote:
> Date: Tue, 30 Jul 2024 10:10:23 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 09/18] qapi/machine: Rename CpuS390* to S390Cpu, and drop
>  'prefix'
> 
> QAPI's 'prefix' feature can make the connection between enumeration
> type and its constants less than obvious.  It's best used with
> restraint.
> 
> CpuS390Entitlement has a 'prefix' to change the generated enumeration
> constants' prefix from CPU_S390_POLARIZATION to S390_CPU_POLARIZATION.
                         ^^^^^^^^^^^^^^^^^^^^^    ^^^^^^^^^^^^^^^^^^^^^
			 CPU_S390_ENTITLEMENT     S390_CPU_ENTITLEMENT

> Rename the type to S390CpuEntitlement, so that 'prefix' is not needed.
> 
> Likewise change CpuS390Polarization to S390CpuPolarization, and
> CpuS390State to S390CpuState.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/machine-common.json            |  5 ++---
>  qapi/machine-target.json            | 11 +++++------
>  qapi/machine.json                   |  9 ++++-----
>  qapi/pragma.json                    |  6 +++---
>  include/hw/qdev-properties-system.h |  2 +-
>  include/hw/s390x/cpu-topology.h     |  2 +-
>  target/s390x/cpu.h                  |  2 +-
>  hw/core/qdev-properties-system.c    |  6 +++---
>  hw/s390x/cpu-topology.c             |  6 +++---
>  9 files changed, 23 insertions(+), 26 deletions(-)

[snip]

> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 59fbe74b8c..beddea5ca4 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -47,9 +47,9 @@
>          'BlockdevSnapshotWrapper',
>          'BlockdevVmdkAdapterType',
>          'ChardevBackendKind',
> -        'CpuS390Entitlement',
> -        'CpuS390Polarization',
> -        'CpuS390State',
> +        'S390CpuEntitlement',
> +        'S390CpuPolarization',
> +        'S390CpuState',
>          'CxlCorErrorType',
>          'DisplayProtocol',
>          'DriveBackupWrapper',

It seems to be in alphabetical order. The new names don't follow the
original order.

Just the above nits,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



