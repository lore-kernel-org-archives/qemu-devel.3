Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C88C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTTB-00076g-Jq; Wed, 27 Mar 2024 09:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTT8-00076R-5S
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:37:30 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTT5-0007eo-KO
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711546647; x=1743082647;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=DBCL+reECrvjOWNSp6i56CdrghRVVqoP1mWDf0+0uY8=;
 b=W2WLd8fzAqdNHF98BMhsLy4mPLwhB9+BG3RNKMthcH+eCLCd6EsrPRCA
 Yi6+eKmLjR7j9QPqFJ06rv4AbZjeSb1Q0BsaAmazVUbWV5PpLKOksDuue
 G7Bkqb6z4TcekiyR49teotZZ1BPbTFwenk2kpomfkB31pQHn4r/9SI8WR
 QQAgmiKFFgwVk+FFQQLBEFUYUJtHYMIfpzVtp1/FgiezKQ1rzZIb0xR3o
 z0B+JRsR7mBxmLIxgupBD369ypHMWkcKZYbE+bJnmXe5GLFUuJgC3sQbT
 9GLxph/WOa+4RQZzIeWpxwQ0KO4HHeicN/5xCv1TmQ5A1awj9OqGKj/r/ Q==;
X-CSE-ConnectionGUID: G+E1QU9gQpCBQxC/ci8nCg==
X-CSE-MsgGUID: zVLqPjovS5GTGkWo2Azrtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17277776"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; d="scan'208";a="17277776"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 06:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; d="scan'208";a="16331457"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2024 06:37:22 -0700
Date: Wed, 27 Mar 2024 21:51:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.1 v2 09/21] hw/i386/pc: Remove
 PCMachineClass::smbios_uuid_encoded
Message-ID: <ZgQkVZMiZnDrjeiR@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-10-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Philippe,

On Wed, Mar 27, 2024 at 10:51:11AM +0100, Philippe Mathieu-Daudé wrote:

[snip]

> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index d802d2787f..f7c2501161 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -63,8 +63,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
>  
>      if (pcmc->smbios_defaults) {
>          /* These values are guest ABI, do not change */
> -        smbios_set_defaults("QEMU", mc->desc, mc->name,
> -                            pcmc->smbios_uuid_encoded);
> +        smbios_set_defaults("QEMU", mc->desc, mc->name, true);

Since this parameter is always ture, then we can drop it and further
clean up the static flag "smbios_uuid_encoded" in hw/smbios/smbios.c.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


