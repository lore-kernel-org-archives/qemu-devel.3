Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120EFC71155
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 06:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRPtB-0002l3-P4; Tue, 17 Jun 2025 02:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uRPt6-0002jo-2X; Tue, 17 Jun 2025 02:33:40 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uRPt2-0003P4-Rq; Tue, 17 Jun 2025 02:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750142017; x=1781678017;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3fsG34tLQanptNPLfPigyxtSfCfes2V7D21oxBXw+0k=;
 b=AKW7P9pGaJx8qIA7giMpIVxsIBrWNnp+mtGlokKlFexSq+zJf8o5Rkzs
 oYQcgSEaaI4fEzUMSIYXcxIUxjGdahZnMNvvKRMN2GkCrnBZXS+2rT3PB
 xFs2/irP6mK89aZJqM8MqF+agTAGEM2V0UeM5CMYYNFdjJLN7AG36c/Hs
 gju1IJSXc767G7gVjK4Q1raO3zqLw9aCV6IX8r5Gw4JJQM+6fifm9PAa8
 UcfBX5TAUrQxe7CR49hW5ipvrReYWo685U8rckOZTeEUNpukg65fR1dGl
 R/fmX0pmPVs6k12vIz+gfwpkYGKbXzf/C0oll1/OFqBukBUFpa23MbYlA Q==;
X-CSE-ConnectionGUID: c+HY+BaVSymekUJ7hyyfTw==
X-CSE-MsgGUID: tBXgMu3QS22k0Yr2JXPdIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51526293"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="51526293"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 23:33:30 -0700
X-CSE-ConnectionGUID: 2lQFbpAMRk2pBvQc6CJIOQ==
X-CSE-MsgGUID: zIK50yEnTCyvAK5VdqNidg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="148673904"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 16 Jun 2025 23:33:22 -0700
Date: Tue, 17 Jun 2025 14:54:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?utf-8?B?Q2zvv71tZW50?= Mathieu --Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?utf-8?B?TWFyYy1BbmRy77+9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH v4 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC
 machines
Message-ID: <aFERMEuJsTTJ4tuY@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250513132338.4089736b@imammedo.users.ipa.redhat.com>
 <20250530073524-mutt-send-email-mst@kernel.org>
 <aDmfuVLXmfvJB0tX@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDmfuVLXmfvJB0tX@angien.pipo.sk>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

Hi Peter,

> Finally there's
> 
>  DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
> 
> which is exposed to the users via cache mode setting of cpu:
> 
> https://www.libvirt.org/formatdomain.html#cpu-model-and-topology
> 
> look for 'cache'.

I found this link doesn't mention "l3-cache", but it appears in
libvirt's src/qemu/qemu_command.c.

> Thus from libvirt's side 'page-per-vq' and 'l3-cache' will likely require
> deprecation period. The rest except for CPU is fine to remove without
> anything at least from our PoV.

So I understand that the file qemu_command.c contains all the QEMU
commands/properties/options used by libvirt, thereby in the future if
one wants to remove other properties, he can just check that file,
right?

Thanks,
Zhao


