Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007D3C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 02:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkE5Y-0004aa-N4; Tue, 12 Mar 2024 22:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE5W-0004a0-Ox
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:11:26 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE5U-0008EH-TQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710295884; x=1741831884;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tnbVUwFHK3Tl9+U33DWrYSnDm5XavsttURteDraxzqI=;
 b=YHMEtHkO6M4HMLZw18qHLAy28MxzW07qb5KOVLgMhNJ4YLbXsT4vADmV
 OVQRMlXHx8A0/i2oKClNCu6dbx14u81CuZWk0AbijnYeiZT5DUBzOScrZ
 bBaaiIa7YG6SS40qpBht2TAamQLed8ziLaRYqEpIyGM5yd/VT+mG7wWJb
 KKSgCDCybPD+Q8BriWxQpqEJ/3ruN+xVljCZz7yL5z7GQqV2+kLg4vyRt
 jWUosfwT18JGLN0qAQuHHfQCPbj4hE31NcHbdOCLrSkFb4shKUCrYCRm2
 L6HGRqD2vKtMjoA+5rZP3OVDsRpSBl8QTplIAlf+z6FbBv1ckJugGY17n w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16439419"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16439419"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 19:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="49182125"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 12 Mar 2024 19:11:19 -0700
Date: Wed, 13 Mar 2024 10:25:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PULL 35/68] hw/mem/cxl_type3: Fix missing ERRP_GUARD() in
 ct3_realize()
Message-ID: <ZfEOhbmmbhq/eAL9@intel.com>
References: <cover.1710282274.git.mst@redhat.com>
 <d477d07a5d2c392c7aa99cb76921ed3e40d141ef.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d477d07a5d2c392c7aa99cb76921ed3e40d141ef.1710282274.git.mst@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Michael,

Thanks a lot and aslo this one, I forgot to update the status :/,
this patch has been merged (commit 294cbbf1753e, "hw/mem/cxl_type3:
Fix missing ERRP_GUARD() in ct3_realize()"). Sorry to make you
repeat the merge.

Best Regards,
Zhao

On Tue, Mar 12, 2024 at 06:27:19PM -0400, Michael S. Tsirkin wrote:
> Date: Tue, 12 Mar 2024 18:27:19 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: [PULL 35/68] hw/mem/cxl_type3: Fix missing ERRP_GUARD() in
>  ct3_realize()
> X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As the comment in qapi/error, dereferencing @errp requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> ...
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
> 
> But in ct3_realize(), @errp is dereferenced without ERRP_GUARD():
> 
> cxl_doe_cdat_init(cxl_cstate, errp);
> if (*errp) {
>     goto err_free_special_ops;
> }
> 
> Here we check *errp, because cxl_doe_cdat_init() returns void. And
> ct3_realize() - as a PCIDeviceClass.realize() method - doesn't get the
> NULL @errp parameter, it hasn't triggered the bug that dereferencing
> the NULL @errp.
> 
> To follow the requirement of @errp, add missing ERRP_GUARD() in
> ct3_realize().
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20240223085653.1255438-4-zhao1.liu@linux.intel.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b679dfae1c..b0a7e9f11b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -645,6 +645,7 @@ static DOEProtocol doe_cdat_prot[] = {
>  
>  static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
>      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
>      ComponentRegisters *regs = &cxl_cstate->crb;
> -- 
> MST
> 

