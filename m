Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AB0C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 03:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV1Ss-0003UI-A2; Tue, 30 Jan 2024 22:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1Sp-0003Tu-TH
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:40:39 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1So-0005Fd-8X
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706672438; x=1738208438;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KGHpZchEPOCHx/eWagvh8uHFJsiU2Zn5DZlw0pF/M54=;
 b=h0MBtEjme/9Hb+o+THFgLSnu/4KrRuKOEl1G5glIv70dtW+Z/sfdY7tK
 ExzMiFlHtu1hlangcnwEFPesUNyXlpqDoY3t0zV1BJETuaubra7Uw4kkt
 C95Iac9N3JTgu9nwkd50nGDzQqgbSXHXR0uaLt2lFozQ77QtXNG/NtJDN
 BOMmvVJDgQy5ulV2VHSdOjE9467OvsP3Q0CBQAXIC+juMjyi6Lo28nIka
 4sDsrXaR3rWC2YlPT3evL3GeBdko6Ijr4/DxVWRZvFXVgvs4SrY2VUSYA
 dg3Iaxz5lyoLKylP1P0SpJJr8hhOrvbbMT4ovWjoAUuyzW5zcwBJFnHUZ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2420096"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2420096"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 19:40:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4012490"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 30 Jan 2024 19:40:29 -0800
Date: Wed, 31 Jan 2024 11:53:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/5] adb: Switch bus reset to 3-phase-reset
Message-ID: <ZbnEVzTOHqsKjqvk@intel.com>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
 <20240119163512.3810301-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119163512.3810301-4-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jan 19, 2024 at 04:35:10PM +0000, Peter Maydell wrote:
> Date: Fri, 19 Jan 2024 16:35:10 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 3/5] adb: Switch bus reset to 3-phase-reset
> X-Mailer: git-send-email 2.34.1
> 
> Switch the ADB bus from using BusClass::reset to the Resettable
> interface.
> 
> This has no behavioural change, because the BusClass code to support
> subclasses that use the legacy BusClass::reset will call that method
> in the hold phase of 3-phase reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/input/adb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index 0f3c73d6d00..98f39b4281a 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -231,9 +231,9 @@ static const VMStateDescription vmstate_adb_bus = {
>      }
>  };
>  
> -static void adb_bus_reset(BusState *qbus)
> +static void adb_bus_reset_hold(Object *obj)
>  {
> -    ADBBusState *adb_bus = ADB_BUS(qbus);
> +    ADBBusState *adb_bus = ADB_BUS(obj);
>  
>      adb_bus->autopoll_enabled = false;
>      adb_bus->autopoll_mask = 0xffff;
> @@ -262,10 +262,11 @@ static void adb_bus_unrealize(BusState *qbus)
>  static void adb_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *k = BUS_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
>      k->realize = adb_bus_realize;
>      k->unrealize = adb_bus_unrealize;
> -    k->reset = adb_bus_reset;
> +    rc->phases.hold = adb_bus_reset_hold;
>  }
>  
>  static const TypeInfo adb_bus_type_info = {
> -- 
> 2.34.1
> 
> 

