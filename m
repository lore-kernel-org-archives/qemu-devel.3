Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08356C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 02:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkEJZ-0000U2-OG; Tue, 12 Mar 2024 22:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkEJV-0000Td-99
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:25:53 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkEJT-0002Tt-M9
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710296752; x=1741832752;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=msriSvhbRNvObn1erYgNq2mAv/qIsx+Qqjj3uJFT3D4=;
 b=B5H/vB/EjRmOPldrm/Cyz7VTN9n11iToCSu/hbYObV9MsQXN3X2g+51V
 QnI/evXgRVnoVQJzp386eaYJJrSta2Y8IlaBIa0q+SdHr8fCMz69dHraf
 As/UFZBMWMsBelfAmWA47OkoQ0ebr58radnJ+Qixe1OazAJptUdbS7MPX
 ZG2Z+LISewldp7ElZSlRF8yjqIZlR6kfix1XECKXmYBUH4b5b6H3di+OF
 ltwOxfxRvTYOCYLzyf/7jQV55oMgnNUiDZVz1qticJsgJDUMnpbj/dcgc
 yJ7jujBSytOVxUlMQf0i9bp/CF/NyMdigwVyvt+ySyE3m3jppAVlwqu6I A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4891050"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4891050"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 19:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16411068"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 12 Mar 2024 19:25:47 -0700
Date: Wed, 13 Mar 2024 10:39:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 38/68] hw/vfio/iommufd: Fix missing ERRP_GUARD() in
 iommufd_cdev_getfd()
Message-ID: <ZfER6NXPpzWJOHjj@intel.com>
References: <cover.1710282274.git.mst@redhat.com>
 <ccd1fd0c5d4f4cba7fa8642ab466a82db3e9f093.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccd1fd0c5d4f4cba7fa8642ab466a82db3e9f093.1710282274.git.mst@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

This one is needed that it doesn't merge. Thanks!

On Tue, Mar 12, 2024 at 06:27:29PM -0400, Michael S. Tsirkin wrote:
> Date: Tue, 12 Mar 2024 18:27:29 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: [PULL 38/68] hw/vfio/iommufd: Fix missing ERRP_GUARD() in
>  iommufd_cdev_getfd()
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
> But in iommufd_cdev_getfd(), @errp is dereferenced without ERRP_GUARD():
> 
> if (*errp) {
>     error_prepend(errp, VFIO_MSG_PREFIX, path);
> }
> 
> Currently, since vfio_attach_device() - the caller of
> iommufd_cdev_getfd() - is always called in DeviceClass.realize() context
> and doesn't get the NULL @errp parameter, iommufd_cdev_getfd()
> hasn't triggered the bug that dereferencing the NULL @errp.
> 
> To follow the requirement of @errp, add missing ERRP_GUARD() in
> iommufd_cdev_getfd().
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20240223085653.1255438-7-zhao1.liu@linux.intel.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/vfio/iommufd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 9bfddc1360..7baf49e6ee 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -116,6 +116,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>  
>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>  {
> +    ERRP_GUARD();
>      long int ret = -ENOTTY;
>      char *path, *vfio_dev_path = NULL, *vfio_path = NULL;
>      DIR *dir = NULL;
> -- 
> MST
> 

