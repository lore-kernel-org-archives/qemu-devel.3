Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D5EC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 00:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rikhK-0004zo-FA; Fri, 08 Mar 2024 19:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rikhJ-0004zd-85
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 19:36:21 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rikhH-0005qE-J3
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 19:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709944579; x=1741480579;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=o7XYyBJ/wWxSY6FlKq2b4YXRb7dNIrJaoqiuXaqbcG8=;
 b=CEwxMhXBRG8Bf69uKFRD/nqTLgDKEdQN5G6Rj+ZJ5BtM1TVncCnKhYtr
 ixh47aqk96wHo8kL8dwKUy5iVGq+uyUrX2xeyjkdQlNf3A3XxlyBtQhXH
 qizbsLNrIS9XvX2qgfCq1tq66yJN6wktvjNMziRDdNT8vApgd7avkR7rC
 tzGHD37t0v9DU02tyyQQn8amixaTKYe8l3EoFhw22uTgl/yoxPgzb7+XW
 6JFfNx3nBZADuc+jJAlkzOP6u6p1PdE1RHbT/Nf3qYT4Qt/e2ePvqSAJX
 7u8a0TvC+fZ32qIysSWggSiTXrTLiSSQfEwFj9XCNHzMM5Msi2IqP49QB A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4534409"
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; 
   d="scan'208";a="4534409"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 16:36:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; d="scan'208";a="15214569"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 08 Mar 2024 16:36:12 -0800
Date: Sat, 9 Mar 2024 08:49:59 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v9 00/21] Introduce smp.modules for x86 in QEMU
Message-ID: <ZeuyN8Eacq1Twsvg@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <17444096-9602-43e1-9042-2a7ce02b5e79@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17444096-9602-43e1-9042-2a7ce02b5e79@linaro.org>
Received-SPF: none client-ip=192.198.163.19;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Fri, Mar 08, 2024 at 05:36:38PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 8 Mar 2024 17:36:38 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v9 00/21] Introduce smp.modules for x86 in QEMU
> 
> On 27/2/24 11:32, Zhao Liu wrote:
> 
> > ---
> > Zhao Liu (20):
> >    hw/core/machine: Introduce the module as a CPU topology level
> >    hw/core/machine: Support modules in -smp
> >    hw/core: Introduce module-id as the topology subindex
> >    hw/core: Support module-id in numa configuration
> 
> Patches 1-4 queued, thanks!

Thanks Philippe!


