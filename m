Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA36C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 02:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkE3o-0003uj-DS; Tue, 12 Mar 2024 22:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE3k-0003uJ-40
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:09:36 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE3i-0007uL-Gg
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710295775; x=1741831775;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jO1rAYn/qYAPO5cNOGyBvCoTmkPeVpEg9iQYHUxQ2DM=;
 b=Q0JnAS2+tcKdFenT1aW45oo0BqsX3tANpy6L2Ei/s3mxKKTrEmF36U8N
 2+dkcIrxXmJRO82hUQ7Wu64xB8eLg/LhWl2De7WuG0NEDGe2f86KsEQs7
 t8dTGA1WIzezU9rKzhq9qhOKzzKa9+90u7rnT1rfevhcoqK4OZAaID6a+
 YqEMf3pb0WvSV6dQlTvUqf+wjGtaX+Fhzz+4kn3j/SIwYMY2YzJQ+IZGG
 26pGBomPe9XxYdi3rtWxHUXYnPaH21tsCRgOOXLusLBeQSVwc8L1DluYN
 w1xeOwp+Q7Tfr11UmzG8jMYxRITl/eiYWI/14liLtXpY3DA/Z4e8zDDJF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5171918"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5171918"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 19:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16339369"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 12 Mar 2024 19:09:31 -0700
Date: Wed, 13 Mar 2024 10:23:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PULL 34/68] hw/display/macfb: Fix missing ERRP_GUARD() in
 macfb_nubus_realize()
Message-ID: <ZfEOF36Y1JbveUPx@intel.com>
References: <cover.1710282274.git.mst@redhat.com>
 <5aa4a6417b0f7acbfd7f4c21dca26293bc3d9348.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aa4a6417b0f7acbfd7f4c21dca26293bc3d9348.1710282274.git.mst@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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
this patch has been merged (commit d470fd6acd60, "hw/display/macfb:
Fix missing ERRP_GUARD() in macfb_nubus_realize()").

Best Regards,
Zhao


On Tue, Mar 12, 2024 at 06:27:16PM -0400, Michael S. Tsirkin wrote:
> Date: Tue, 12 Mar 2024 18:27:16 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: [PULL 34/68] hw/display/macfb: Fix missing ERRP_GUARD() in
>  macfb_nubus_realize()
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
> But in macfb_nubus_realize(), @errp is dereferenced without
> ERRP_GUARD():
> 
> ndc->parent_realize(dev, errp);
> if (*errp) {
>     return;
> }
> 
> Here we check *errp, because the ndc->parent_realize(), as a
> DeviceClass.realize() callback, returns void. And since
> macfb_nubus_realize(), also as a DeviceClass.realize(), doesn't get the
> NULL @errp parameter, it hasn't triggered the bug that dereferencing the
> NULL @errp.
> 
> To follow the requirement of @errp, add missing ERRP_GUARD() in
> macfb_nubus_realize().
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20240223085653.1255438-3-zhao1.liu@linux.intel.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/display/macfb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/display/macfb.c b/hw/display/macfb.c
> index 418e99c8e1..1ace341a0f 100644
> --- a/hw/display/macfb.c
> +++ b/hw/display/macfb.c
> @@ -714,6 +714,7 @@ static void macfb_nubus_set_irq(void *opaque, int n, int level)
>  
>  static void macfb_nubus_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      NubusDevice *nd = NUBUS_DEVICE(dev);
>      MacfbNubusState *s = NUBUS_MACFB(dev);
>      MacfbNubusDeviceClass *ndc = NUBUS_MACFB_GET_CLASS(dev);
> -- 
> MST
> 

