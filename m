Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F096C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd4yv-0006NM-20; Thu, 22 Feb 2024 04:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd4yt-0006Mw-OK; Thu, 22 Feb 2024 04:03:03 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd4ys-0007R8-6F; Thu, 22 Feb 2024 04:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708592582; x=1740128582;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=pVCsK+Qv4FAZytRcJKKh5xEgXldDFEQHKJuro//Rm0c=;
 b=EsXl89AEbW/bX7NmHEtOv36M80Hv9WIWVIDti1q6l8HcKpTO1Nnj8M5n
 GdV5MI1yJyBfNKgmX3N4EPP84hE1gK1RhBWR1IPWqMAen151xx9HVw9U4
 qKqx+dXxjk/9RzKl+cmjoJ5gFCbUfN1qaLpw1N2qTO6M64A7WfaFjqXzJ
 l3rxdBNiZ3jarMnH1zpSRg58/LZbMB+CEI6Gxoui/rpC9fcspJG7hIz05
 9Edzlew0CMDM/UmJyzU8XpAY6/qEOhOkxL1NJX9fnSFfH9bZnEDcudhJ1
 u91p51TS/RSL3Thj/kLAsqySJs/6qXTh3jweAZ5Xl5mGTLyY+bBFltyXc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2956273"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2956273"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 01:02:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="36260438"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 22 Feb 2024 01:02:55 -0800
Date: Thu, 22 Feb 2024 17:16:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 02/21] hw/i386/pc_sysfw: Use qdev_is_realized() instead
 of QOM API
Message-ID: <ZdcQ8wk6rPmivHWO@intel.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216110313.17039-3-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 16, 2024 at 12:02:53PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 16 Feb 2024 12:02:53 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 02/21] hw/i386/pc_sysfw: Use qdev_is_realized() instead of
>  QOM API
> X-Mailer: git-send-email 2.41.0
> 
> Prefer QDev API for QDev objects, avoid the underlying QOM layer.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/pc_sysfw.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index c8d9e71b88..3efabbbab2 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -107,17 +107,15 @@ void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>  {
>      char *prop_name;
>      int i;
> -    Object *dev_obj;
>  
>      assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
>  
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> -        dev_obj = OBJECT(pcms->flash[i]);
> -        if (!object_property_get_bool(dev_obj, "realized", &error_abort)) {
> +        if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
>              prop_name = g_strdup_printf("pflash%d", i);
>              object_property_del(OBJECT(pcms), prop_name);
>              g_free(prop_name);
> -            object_unparent(dev_obj);
> +            object_unparent(OBJECT(pcms->flash[i]));
>              pcms->flash[i] = NULL;
>          }
>      }
> -- 
> 2.41.0
> 
> 

