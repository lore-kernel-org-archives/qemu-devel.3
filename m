Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718C0C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7WeD-0002Og-B5; Thu, 16 May 2024 04:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7WeB-0002OG-FW
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:39:31 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7We9-0003Nj-7U
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715848769; x=1747384769;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=03XT5JQio/eh9g4gJ4rzt/gMN7AOyjNu4+d2a4FCEKA=;
 b=Eh4aERFrgZKHKVGTDlBsi9qcWWAkBACy/aAHlJ+GKDUvYe/VdKwGP07G
 zCEUZGBnzUfkDmsfUiiEUfNYMWUh64O4/BF4G3pzcxp75y7JwIpS6K4c0
 SHvGWxhGp6i3dPljHg7tEvBP4lGeLnlK0jG6/miYKe6q020dlhxIe9p3X
 +Bgygpv36ucFHDtmlajedkBJULgziwygyVvo/175HmddYiJVhtbjKncSE
 RB6nYyD9UUSqfHAJsnGVEgzvouTvBdhHjxB4BIsKRh5ws0bZBUVigsORa
 Lrw1BboEDE1GQMTZcmvpLttT9y+VylL5/lETjOBI1sDup81hRYmN/84QB Q==;
X-CSE-ConnectionGUID: DuDFGw6RQr+8xDExejz8ng==
X-CSE-MsgGUID: ZyK/J0lASF+drRoZ5mYpEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11754281"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; d="scan'208";a="11754281"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 01:39:26 -0700
X-CSE-ConnectionGUID: n+/azNr/SQydQsnOc4BoYw==
X-CSE-MsgGUID: 7LFRak9CReS/clwG4W/34A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; d="scan'208";a="35869054"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 01:39:23 -0700
Date: Thu, 16 May 2024 16:54:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 1/2] hw/core: allow parameter=1 for SMP topology on any
 machine
Message-ID: <ZkXJ0r9tomQBWBqB@intel.com>
References: <20240513123358.612355-1-berrange@redhat.com>
 <20240513123358.612355-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513123358.612355-2-berrange@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Mon, May 13, 2024 at 01:33:57PM +0100, Daniel P. Berrangé wrote:
> Date: Mon, 13 May 2024 13:33:57 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH 1/2] hw/core: allow parameter=1 for SMP topology on any
>  machine
> 
> This effectively reverts
> 
>   commit 54c4ea8f3ae614054079395842128a856a73dbf9
>   Author: Zhao Liu <zhao1.liu@intel.com>
>   Date:   Sat Mar 9 00:01:37 2024 +0800
> 
>     hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP configurations
> 
> but is not done as a 'git revert' since the part of the changes to the
> file hw/core/machine-smp.c which add 'has_XXX' checks remain desirable.
> Furthermore, we have to tweak the subsequently added unit test to
> account for differing warning message.
> 
> The rationale for the original deprecation was:
> 
>   "Currently, it was allowed for users to specify the unsupported
>    topology parameter as "1". For example, x86 PC machine doesn't
>    support drawer/book/cluster topology levels, but user could specify
>    "-smp drawers=1,books=1,clusters=1".
> 
>    This is meaningless and confusing, so that the support for this kind
>    of configurations is marked deprecated since 9.0."
> 
> There are varying POVs on the topic of 'unsupported' topology levels.
> 
> It is common to say that on a system without hyperthreading, that there
> is always 1 thread. Likewise when new CPUs introduced a concept of
> multiple "dies', it was reasonable to say that all historical CPUs
> before that implicitly had 1 'die'. Likewise for the more recently
> introduced 'modules' and 'clusters' parameter'. From this POV, it is
> valid to set 'parameter=1' on the -smp command line for any machine,
> only a value > 1 is strictly an error condition.
> 
> It doesn't cause any functional difficulty for QEMU, because internally
> the QEMU code is itself assuming that all "unsupported" parameters
> implicitly have a value of '1'.
> 
> At the libvirt level, we've allowed applications to set 'parameter=1'
> when configuring a guest, and pass that through to QEMU.
> 
> Deprecating this creates extra difficulty for because there's no info
> exposed from QEMU about which machine types "support" which parameters.
> Thus, libvirt can't know whether it is valid to pass 'parameter=1' for
> a given machine type, or whether it will trigger deprecation messages.
> 
> Since there's no apparent functional benefit to deleting this deprecated
> behaviour from QEMU, and it creates problems for consumers of QEMU,
> remove this deprecation.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/about/deprecated.rst   | 14 -------
>  hw/core/machine-smp.c       | 82 ++++++++++++-------------------------
>  tests/unit/test-smp-parse.c |  8 ++--
>  3 files changed, 30 insertions(+), 74 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e22acb17f2..5b551b12a6 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -47,20 +47,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
>  However, short-form booleans are deprecated and full explicit ``arg_name=on``
>  form is preferred.
>  
> -``-smp`` (Unsupported "parameter=1" SMP configurations) (since 9.0)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -Specified CPU topology parameters must be supported by the machine.
> -
> -In the SMP configuration, users should provide the CPU topology parameters that
> -are supported by the target machine.
> -
> -However, historically it was allowed for users to specify the unsupported
> -topology parameter as "1", which is meaningless. So support for this kind of
> -configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
> -marked deprecated since 9.0, users have to ensure that all the topology members
> -described with -smp are supported by the target machine.
> -
>  User-mode emulator command line arguments
>  -----------------------------------------
>  
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 2b93fa99c9..eb43caca9b 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -119,75 +119,45 @@ void machine_parse_smp_config(MachineState *ms,
>  
>      /*
>       * If not supported by the machine, a topology parameter must be

Also need to change this line as:

s/must be/must/

> -     * omitted.
> +     * not be set to a value greater than 1.
>       */

Only the above nit,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


