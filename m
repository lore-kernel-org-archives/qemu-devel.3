Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE198C54E5D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 02:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkE1P-0002z6-GH; Tue, 12 Mar 2024 22:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE1J-0002yn-5h
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:07:05 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE1F-0007Zn-GD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710295622; x=1741831622;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sDKdpmYDknCRqkTtYqOPv/twxHzJcv/JElPWusc+v7c=;
 b=NYk2/8oljFBKltee6c6BBYTZAm4/QndHDsOdXGorbQrpDeRwmXtCDLtn
 u17zaBlkAg5nZPBMvNamIKc3CwIJ/+OrhWyKYRvup9T53kHgN8Yrw8XkM
 zJ7JHKxiGuNZ8xQG95nWFG1cSJu4gi/9zAhqlZg6WSSa75Ady/8x6Rc8i
 Q42xJinxwr5WhuxGUTDGPPF7zg+CvxemCLutHX8nD+Cf/NO5Km7Iwlg84
 tJApzoQXYUgEAZ9CkfOHWpS/1pMrlk1DgTUbOsbrelsNVemQrmXKm250l
 oEAI0KNtE1RvsLajFsyYMwUzKXFDDzzR44QUUP7UIdL3dO6owJZ6YwXc6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8858969"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8858969"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 19:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11639312"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 12 Mar 2024 19:06:55 -0700
Date: Wed, 13 Mar 2024 10:20:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PULL 33/68] hw/cxl/cxl-host: Fix missing ERRP_GUARD() in
 cxl_fixed_memory_window_config()
Message-ID: <ZfENfGpMKwlKmGw+@intel.com>
References: <cover.1710282274.git.mst@redhat.com>
 <2a0e0a35002db7ac64f4e82ea2a4ad2fb6d934b0.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0e0a35002db7ac64f4e82ea2a4ad2fb6d934b0.1710282274.git.mst@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

Thanks a lot and I forgot to update the status :/, this patch has been
merged by Thomas (commit 5c7eedf53d44, "hw/cxl/cxl-host: Fix missing
ERRP_GUARD() in cxl_fixed_memory_window_config()").

Best Regards,
Zhao

On Tue, Mar 12, 2024 at 06:27:12PM -0400, Michael S. Tsirkin wrote:
> Date: Tue, 12 Mar 2024 18:27:12 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: [PULL 33/68] hw/cxl/cxl-host: Fix missing ERRP_GUARD() in
>  cxl_fixed_memory_window_config()
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
> But in cxl_fixed_memory_window_config(), @errp is dereferenced in 2
> places without ERRP_GUARD():
> 
> fw->enc_int_ways = cxl_interleave_ways_enc(fw->num_targets, errp);
> if (*errp) {
>     return;
> }
> 
> and
> 
> fw->enc_int_gran =
>     cxl_interleave_granularity_enc(object->interleave_granularity,
>                                    errp);
> if (*errp) {
>     return;
> }
> 
> For the above 2 places, we check "*errp", because neither function
> returns a suitable error code. And since machine_set_cfmw() - the caller
> of cxl_fixed_memory_window_config() - doesn't get the NULL @errp
> parameter as the "set" method of object property,
> cxl_fixed_memory_window_config() hasn't triggered the bug that
> dereferencing the NULL @errp.
> 
> To follow the requirement of @errp, add missing ERRP_GUARD() in
> cxl_fixed_memory_window_config().
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20240223085653.1255438-2-zhao1.liu@linux.intel.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-host.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 2aa776c79c..c5f5fcfd64 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -26,6 +26,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>                                             CXLFixedMemoryWindowOptions *object,
>                                             Error **errp)
>  {
> +    ERRP_GUARD();
>      g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
>      strList *target;
>      int i;
> -- 
> MST
> 

