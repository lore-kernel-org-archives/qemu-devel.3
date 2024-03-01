Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DB2C54E49
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 06:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfwNh-0005WB-Ml; Fri, 01 Mar 2024 01:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfwNg-0005Vc-Bx; Fri, 01 Mar 2024 01:28:28 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfwNe-0005et-L9; Fri, 01 Mar 2024 01:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709274507; x=1740810507;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vQrMYMHRQEZiqak/tZDG0mKUk3sLJGMAfizDJSvvIvU=;
 b=Em6JAvujoCO4BOGVTUEvn7hrAEZcCWcTFw0+2+W4CHjPvPPBgGgzcCPq
 z/uhBYKr9CEHw+ZIfVWlcxSToPjVAZ0st3T6970wfOe0pEmT8bHltZtj3
 WQjqnAcsE54INOiKYVkZ7b3v4GxJih+K4FUryxrMI9WA1OdQPhNTKKnq2
 CMq8/aaKGtoC+L8nhICVHb8/L53TqR+wBlI75aZ2q775HR0t4YGcMXlgd
 N+bMs5HZ0Wkum2xufN4sXk1absDqJy8Es+hQvZqJOTNNwVh1VQ1NmrXgq
 3ktaCS1N0JGyiIKI+AM6HWuDjdpYi9eBJDZQabLEqZJQneAlgyKiQjdHi w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15231155"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; d="scan'208";a="15231155"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 22:28:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8646200"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 29 Feb 2024 22:28:19 -0800
Date: Fri, 1 Mar 2024 14:42:03 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 04/17] hw/scsi/vhost-scsi: Fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <ZeF4u7DXVFiDt05E@intel.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-5-zhao1.liu@linux.intel.com>
 <def17d13-34b2-40ee-a237-a80fe8002f81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def17d13-34b2-40ee-a237-a80fe8002f81@redhat.com>
Received-SPF: none client-ip=198.175.65.12;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

> > @@ -220,6 +220,7 @@ static int vhost_scsi_set_workers(VHostSCSICommon *vsc, bool per_virtqueue)
> >   static void vhost_scsi_realize(DeviceState *dev, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
> >       VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
> >       Error *err = NULL;
> 
> I think you could remove the "err" variable and the error_propagate stuff in
> here now.
>

OK, I'll. Thanks.

-Zhao


