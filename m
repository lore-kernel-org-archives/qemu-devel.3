Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54733D2FFE1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jRO-0005CG-KN; Fri, 18 Oct 2024 05:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jRN-0005Bm-1Z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:38:37 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jRL-0001Fq-I8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244316; x=1760780316;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8N6XJkvIxCUrYlpPA1j6bw7LR3wdIeRUkmt8MuqZ67g=;
 b=AoUOQ8konkPQwnVJ4aDcdtswpDLyQO1txptr0htcvMwXfvXuF22jMLo+
 HvJjeui3d0U8DJGNaB8x2oPDSjcXsWtCiJy1DWTXl/iIsVRCm+34CqY0h
 b+hNNzHBqT1v7N8S83qHo/CqOdSpymsMfFK6tRfRoIgx05u7/YQcEP8y9
 0pPtKrWDSVfghZOhWQT6L3o0ZwfNCX5DsZO/j4RC1zRfTt3vYYdUreP1o
 8qFSxc9Rb72DLJM50WycquKETsSi2uU8OYZZGXikCUgflwvQ1XKAHmWT2
 Y+dRnZPG9WQ2VMgNjhr2xGNke38xKSUGLb1mALYdgcyjVpcQ/3gURffKk g==;
X-CSE-ConnectionGUID: 8lwYwFhdTAWu+cl0TNEE2A==
X-CSE-MsgGUID: iuGKEROqRCqxtpuSxAM9CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39310972"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="39310972"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:38:34 -0700
X-CSE-ConnectionGUID: DJ0Lr5ljT6q3fohSZ0Km3A==
X-CSE-MsgGUID: jkEmjDbPTEOLEODpQ9lLHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="116276056"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 18 Oct 2024 02:38:33 -0700
Date: Fri, 18 Oct 2024 17:54:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 09/31] hw: adapt to new import path for qobject data
 type headers
Message-ID: <ZxIwaIA/abIvoQjQ@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-10-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-10-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 17, 2024 at 12:33:21PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:21 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 09/31] hw: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/arm/aspeed_ast27x0.c         | 2 +-
>  hw/arm/mps2-tz.c                | 2 +-
>  hw/arm/mps2.c                   | 2 +-
>  hw/arm/mps3r.c                  | 2 +-
>  hw/arm/sbsa-ref.c               | 2 +-
>  hw/arm/stellaris.c              | 2 +-
>  hw/arm/vexpress.c               | 2 +-
>  hw/arm/virt.c                   | 2 +-
>  hw/arm/xlnx-versal.c            | 2 +-
>  hw/block/xen-block.c            | 4 ++--
>  hw/core/machine-hmp-cmds.c      | 2 +-
>  hw/core/machine-qmp-cmds.c      | 2 +-
>  hw/core/qdev-properties.c       | 2 +-
>  hw/core/qdev.c                  | 2 +-
>  hw/hyperv/hv-balloon.c          | 2 +-
>  hw/i386/acpi-build.c            | 2 +-
>  hw/i386/kvm/xen_evtchn.c        | 2 +-
>  hw/i386/monitor.c               | 2 +-
>  hw/i386/pc.c                    | 2 +-
>  hw/net/rocker/rocker-hmp-cmds.c | 2 +-
>  hw/net/virtio-net.c             | 2 +-
>  hw/net/xen_nic.c                | 2 +-
>  hw/pci/pci-hmp-cmds.c           | 2 +-
>  hw/ppc/pegasos2.c               | 2 +-
>  hw/ppc/spapr_drc.c              | 2 +-
>  hw/rx/rx62n.c                   | 2 +-
>  hw/s390x/s390-skeys.c           | 2 +-
>  hw/s390x/s390-stattrib.c        | 2 +-
>  hw/usb/xen-usb.c                | 4 ++--
>  hw/vfio/pci.c                   | 2 +-
>  hw/virtio/virtio-hmp-cmds.c     | 2 +-
>  hw/virtio/virtio-qmp.c          | 4 ++--
>  hw/xen/xen-bus.c                | 2 +-
>  33 files changed, 36 insertions(+), 36 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


