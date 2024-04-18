Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8E6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 13:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxRl7-0001WH-Ff; Thu, 18 Apr 2024 09:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rxRl4-0001Vs-Ia
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:24:58 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rxRl2-0007u5-JU
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713446697; x=1744982697;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=uDt0ypVwqt15fqs2rxgaI31ylg2kn4nX3adYrJPhYQk=;
 b=SldPYhOwSm1gOP+sm6QLohTq/6o40Lz/AK+f/nIZEJBPTLMSSbAMF9iC
 zsTrDXvoMWe0BEkj5l7hyB6L/TbjWgHxpYweBtWhzjbbtfmDv26TPsf5/
 2aQOKFTUwGiS+F/PdQQvEVagkTwtBhMb7EtExGvLb7nDW0pIFO/yUB/fi
 XjrfVMXFbS2HaN5LgcpM6srkeTp6Nz05TGkUZ+5haFmxr/R4xOgPPIcCy
 TN0krBqDhOfg5GDmcwDOEgR2LGd92bH55J9duXhf+uwawEUXrKmCyxpoI
 5QUEbaPjoU59jTNIk0WbVqkxzFgQpekibbdnNTh7p3pDMHkns/jO973Mo g==;
X-CSE-ConnectionGUID: X3PeSh9OR+uLVb0D86qxxw==
X-CSE-MsgGUID: mbQ5Ew4wQ1O/+rmrt2Vm7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="31474403"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; d="scan'208";a="31474403"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 06:24:53 -0700
X-CSE-ConnectionGUID: yVOK9IIfQy2q3lL4h9pOBQ==
X-CSE-MsgGUID: 9+qOKqpkQRuW3yJr+867KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; d="scan'208";a="23070748"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 18 Apr 2024 06:24:50 -0700
Date: Thu, 18 Apr 2024 21:38:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 3/3] hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return
 boolean
Message-ID: <ZiEibgRPOE1RYNke@intel.com>
References: <20240418100433.1085447-1-zhao1.liu@linux.intel.com>
 <20240418100433.1085447-4-zhao1.liu@linux.intel.com>
 <619e668a-67e0-4d25-aec8-9cc13a5c15de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <619e668a-67e0-4d25-aec8-9cc13a5c15de@linaro.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

Hi Philippe,

On Thu, Apr 18, 2024 at 02:06:15PM +0200, Philippe Mathieu-Daudé wrote:

[snip]

> > diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> > index 5012fab6f763..945ee6ffd045 100644
> > --- a/include/hw/cxl/cxl_component.h
> > +++ b/include/hw/cxl/cxl_component.h
> > @@ -273,7 +273,7 @@ hwaddr cxl_decode_ig(int ig);
> >   CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
> >   bool cxl_get_hb_passthrough(PCIHostState *hb);
> > -void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
> > +bool cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
> >   void cxl_doe_cdat_release(CXLComponentState *cxl_cstate);
> >   void cxl_doe_cdat_update(CXLComponentState *cxl_cstate, Error **errp);
> 
> Another candidate ;)
> 

I guess you mean cxl_doe_cdat_update()? ;-)

It's a special case since it has only one use case and in that case,
&error_fatal is passed as @errp. So then it doesn't need to check the
return value.

Thanks,
Zhao


