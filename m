Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09821C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5br-0004fQ-LA; Thu, 22 Feb 2024 04:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5bq-0004eC-4i; Thu, 22 Feb 2024 04:43:18 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5bo-0005Aj-M2; Thu, 22 Feb 2024 04:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708594997; x=1740130997;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=IBPgxBEpIJj/+jCChNv2u4FJt0jG9vpTC9/aQPVRmx4=;
 b=HvxZ7SSyeph8bpabyZqrCUgC/jjJ1qGIYquPXEwOfjLC17ZrTUHlWY1Q
 F8ZZFSTtzHeqo3bYj/I54au9il9JCX1NvqHeHmOjsehs94o5svEDVuchb
 PfRODSRGBpfa3BnsYbGrz/WEv9C86sOMeQINL4oq7cylY3D65rvQzDyqj
 VPJUufM2AQNroK0ZApzgRIKoe9oD4R+9/JJhDObPetQfAMLAkJ2LNlISF
 6RTv2t4IZo2rYmnVHyOU6Qjs40qJ1eD4tzvxQgnev5m9D64ZdNIMPsrFE
 /5OqP1UiGwsvgKROPRVOjqO7fK8BAD5STpSdFu5I1l9JxpWB00ZnxXUgM A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28250062"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="28250062"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 01:43:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5402604"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 22 Feb 2024 01:43:10 -0800
Date: Thu, 22 Feb 2024 17:56:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 03/21] hw/ppc/spapr_cpu: Use qdev_is_realized() instead
 of QOM API
Message-ID: <ZdcaYsPpzGp0Rej8@intel.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216110313.17039-4-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

On Fri, Feb 16, 2024 at 12:02:54PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 16 Feb 2024 12:02:54 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 03/21] hw/ppc/spapr_cpu: Use qdev_is_realized() instead of
>  QOM API
> X-Mailer: git-send-email 2.41.0
> 
> Prefer QDev API for QDev objects, avoid the underlying QOM layer.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/ppc/spapr_cpu_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 0c0fb3f1b0..40b7c52f7f 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -245,8 +245,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
>               * spapr_cpu_core_realize(), make sure we only unrealize
>               * vCPUs that have already been realized.
>               */
> -            if (object_property_get_bool(OBJECT(sc->threads[i]), "realized",
> -                                         &error_abort)) {
> +            if (qdev_is_realized(DEVICE(sc->threads[i]))) {
>                  spapr_unrealize_vcpu(sc->threads[i], sc);
>              }
>              spapr_delete_vcpu(sc->threads[i]);
> -- 
> 2.41.0
> 
> 

