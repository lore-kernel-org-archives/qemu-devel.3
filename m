Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5F1C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 02:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkE8Y-000635-7T; Tue, 12 Mar 2024 22:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE8X-00062i-23
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:14:33 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE8R-0000Gv-QS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710296068; x=1741832068;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UTwnCQDXKoBtbmUnlGbzfWtkd0l5Zr2nzxkwADCNFkY=;
 b=WGzYW+VlvtU319JE65OWegL1+jhfxPnjDB/8yZMGsLh7fz2ribs3S5P6
 6YXYhghO+7x7MnzrJW11k5iod2bHtovgcdTNoD9he0LLyfEwYJmu5Rfl9
 KyQfkxTPJl2K/Xgb7LeJAi266A4X7ra4AaJ6BiX18MfBawC9DCIPJhQxj
 KfjWoDoDSeNJ05nkVqjM1w7uNcQazJnHALu9y7dJ63WWZKE0uf0MbotG/
 n4t1iUYduGqiNeWlJsKlzTAmP6O0It7V0ot5OGWIUkOwvbFpMtzyc25s/
 FwDieTElt0stbu4/CfywJEL6kbiesCHvDsNZRph2ipOuxkU/+8l+ABrkr g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16182804"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16182804"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 19:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11674651"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 12 Mar 2024 19:14:23 -0700
Date: Wed, 13 Mar 2024 10:28:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PULL 37/68] hw/pci-bridge/cxl_upstream: Fix missing
 ERRP_GUARD() in cxl_usp_realize()
Message-ID: <ZfEPPUKYxVNQ9bvB@intel.com>
References: <cover.1710282274.git.mst@redhat.com>
 <4f5a3f49b934ff24227ebc95b3f9177f0147ff52.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5a3f49b934ff24227ebc95b3f9177f0147ff52.1710282274.git.mst@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Thanks a lot and also this one, I forgot to update the status :/,
this patch has been merged (commit 8cb84d7d6bd1f, "hw/pci-bridge/
cxl_upstream: Fix missing ERRP_GUARD() in cxl_usp_realize()"). Sorry to
make you repeat the merge.

Best Regards,
Zhao


On Tue, Mar 12, 2024 at 06:27:25PM -0400, Michael S. Tsirkin wrote:
> Date: Tue, 12 Mar 2024 18:27:25 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: [PULL 37/68] hw/pci-bridge/cxl_upstream: Fix missing ERRP_GUARD()
>  in cxl_usp_realize()
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
> But in cxl_usp_realize(), @errp is dereferenced without ERRP_GUARD():
> 
> cxl_doe_cdat_init(cxl_cstate, errp);
> if (*errp) {
>     goto err_cap;
> }
> 
> Here we check *errp, because cxl_doe_cdat_init() returns void. And since
> cxl_usp_realize() - as a PCIDeviceClass.realize() method - doesn't get
> the NULL @errp parameter, it hasn't triggered the bug that dereferencing
> the NULL @errp.
> 
> To follow the requirement of @errp, add missing ERRP_GUARD() in
> cxl_usp_realize().
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20240223085653.1255438-6-zhao1.liu@linux.intel.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/pci-bridge/cxl_upstream.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 537f9affb8..783fa6adac 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -289,6 +289,7 @@ static void free_default_cdat_table(CDATSubHeader **cdat_table, int num,
>  
>  static void cxl_usp_realize(PCIDevice *d, Error **errp)
>  {
> +    ERRP_GUARD();
>      PCIEPort *p = PCIE_PORT(d);
>      CXLUpstreamPort *usp = CXL_USP(d);
>      CXLComponentState *cxl_cstate = &usp->cxl_cstate;
> -- 
> MST
> 

