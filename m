Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AD7C54E5D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 02:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkEHj-0007u2-Au; Tue, 12 Mar 2024 22:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkEHh-0007td-4i
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:24:01 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkEHe-00024Y-Gb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710296639; x=1741832639;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=103WNR9Tq5V2kEuaDw0lKTdeXjmsghR9/+rk3Saa028=;
 b=ZDFtzgcWGTYde4PYGdAYmpcD3IxWnmr2Y322n3pf4uiH4c2dRTqnvslq
 AVQsmMWo4/DbfcuUbZ7k7TN7DUuzkILT+YD5UTTOjBeVma126rGX6vjWQ
 UVfsgrgyHe+H4eIOI9EDtlNufjVBtyWma/B3QUlnltMHA+4F+wfy3L3yT
 EDlyOStu3WWLyVAcOsHVo75jgQkqRS2BVQMiJtxl9e/Ofl4qGJwRqqsOs
 oIoKPaJw50+VECnhn/GXv7aema/Vgx+zrcpU7p2EqFOzkVzA/24hoi17Z
 WRd5cAJHUOcip9wlsRS+8I2eCwb6PBiMxbteBIwVydm7TyjDl4lmrDXI5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15765342"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="15765342"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 19:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16471550"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 12 Mar 2024 19:23:51 -0700
Date: Wed, 13 Mar 2024 10:37:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 39/68] hw/intc: Check @errp to handle the error of
 IOAPICCommonClass.realize()
Message-ID: <ZfERc2NDHZWrMuZX@intel.com>
References: <cover.1710282274.git.mst@redhat.com>
 <0f9c30350bdf9d062609a15124f30f6c2b0a4b60.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f9c30350bdf9d062609a15124f30f6c2b0a4b60.1710282274.git.mst@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

Thanks a lot and also this one, I forgot to update the status :/,
this patch has been merged (commit 4a9fafb478b5, "hw/intc: Check @errp
to handle the error of IOAPICCommonClass.realize()"). Sorry to make you
repeat the merge.

Best Regards,
Zhao

On Tue, Mar 12, 2024 at 06:27:32PM -0400, Michael S. Tsirkin wrote:
> Date: Tue, 12 Mar 2024 18:27:32 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: [PULL 39/68] hw/intc: Check @errp to handle the error of
>  IOAPICCommonClass.realize()
> X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> IOAPICCommonClass implements its own private realize(), and this private
> realize() allows error.
> 
> Since IOAPICCommonClass.realize() returns void, to check the error,
> dereference @errp with ERRP_GUARD().
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Message-Id: <20240223085653.1255438-8-zhao1.liu@linux.intel.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/intc/ioapic_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> index cb9bf62146..efbe6958c8 100644
> --- a/hw/intc/ioapic_common.c
> +++ b/hw/intc/ioapic_common.c
> @@ -152,6 +152,7 @@ static int ioapic_dispatch_post_load(void *opaque, int version_id)
>  
>  static void ioapic_common_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      IOAPICCommonState *s = IOAPIC_COMMON(dev);
>      IOAPICCommonClass *info;
>  
> @@ -162,6 +163,9 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
>  
>      info = IOAPIC_COMMON_GET_CLASS(s);
>      info->realize(dev, errp);
> +    if (*errp) {
> +        return;
> +    }
>  
>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->io_memory);
>      ioapic_no++;
> -- 
> MST
> 

