Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0174CA101C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 11:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skLs2-0003WP-2d; Sat, 31 Aug 2024 07:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1skLs0-0003Vv-DW
 for qemu-devel@nongnu.org; Sat, 31 Aug 2024 07:02:16 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1skLry-0006Bs-IB
 for qemu-devel@nongnu.org; Sat, 31 Aug 2024 07:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725102134; x=1756638134;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dSOAk0NzL6DADSAByqKzGsIaHLXkHAZCTptM1ZIzq1I=;
 b=An30//Xf6clEQ1vWFJQ+suo8P92+GbtMlvMgiV2oZpmtEIUjDnLV8SmH
 l/RQ2Im1vVqG5hY1musIg0GDCf/SgseKgWi7jVzG+shjhFlLrQdF7TISJ
 4r5N1tRu6ZgShBAAFuA/nerW8nGEOz5HmQC9XuB68mUkZAlpoEfSu/Bs9
 8bkQSV0NWYlFeBtbBy81axkLXSg1NU28DE8ZtiF6eY5dv2dP7BCqoj8Um
 vGfKk8yuAO/svuUgq71YZatOB6COd1bv6DV9JJAd/d1DMF+qua+S7s+/U
 /ie22eUEJXYQ2zHaJkIqgwedtbMf3WgWznz7A1kfICryGQZaHD93YM8pC Q==;
X-CSE-ConnectionGUID: cssqQwoCS/GJSL+l2K3Fuw==
X-CSE-MsgGUID: Ukp5VNZLRTKn5hMhISIp9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23623711"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; d="scan'208";a="23623711"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2024 04:02:10 -0700
X-CSE-ConnectionGUID: o8XSxDjgTay1m/S7b2OG0g==
X-CSE-MsgGUID: zhBy/KFRTzGFavIZ47y9sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; d="scan'208";a="64190276"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2024 04:02:09 -0700
Date: Sat, 31 Aug 2024 19:18:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio =?utf-8?B?UO+/vXJleg==?= <eperezma@redhat.com>,
 qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] hw/virtio/vdpa-dev: Check returned value instead of
 dereferencing @errp
Message-ID: <ZtL77yZU/+WThF5A@intel.com>
References: <20240716162615.271010-1-zhao1.liu@intel.com>
 <20240820065310-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820065310-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Aug 20, 2024 at 06:55:29AM -0400, Michael S. Tsirkin wrote:

[snip]

> > diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> > index 64b96b226c39..8a1e16fce3de 100644
> > --- a/hw/virtio/vdpa-dev.c
> > +++ b/hw/virtio/vdpa-dev.c
> > @@ -63,19 +63,19 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
> >      }
> >  
> >      v->vhostfd = qemu_open(v->vhostdev, O_RDWR, errp);
> > -    if (*errp) {
> > +    if (v->vhostfd < 0) {
> >          return;
> >      }
> >  
> >      v->vdev_id = vhost_vdpa_device_get_u32(v->vhostfd,
> >                                             VHOST_VDPA_GET_DEVICE_ID, errp);
> > -    if (*errp) {
> > +    if (v->vdev_id < 0) {
> >          goto out;
> >      }
> 
> vdev_id is unsigned, no idea how is this supposed to work.
> 
> >  
> >      max_queue_size = vhost_vdpa_device_get_u32(v->vhostfd,
> >                                                 VHOST_VDPA_GET_VRING_NUM, errp);
> > -    if (*errp) {
> > +    if (max_queue_size < 0) {
> >          goto out;
> >      }
> >  
> max_queue_size is unsigned, too.
> 
> > @@ -89,7 +89,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
> >  
> >      v->num_queues = vhost_vdpa_device_get_u32(v->vhostfd,
> >                                                VHOST_VDPA_GET_VQS_COUNT, errp);
> > -    if (*errp) {
> > +    if (v->num_queues < 0) {
> >          goto out;
> >      }
> >  
> 
> num_queues is unsigned, too.

Oops, yes. The correct way is to check whether vhost_vdpa_device_get_u32
returns "(uint32_t)-1".

I can add a new macro like this:

#define VDPA_DEVICE_U32_VALUE_NONE ((uint32_t)-1)

Is this okay with you?

Thanks,
Zhao

> > @@ -127,7 +127,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
> >      v->config_size = vhost_vdpa_device_get_u32(v->vhostfd,
> >                                                 VHOST_VDPA_GET_CONFIG_SIZE,
> >                                                 errp);
> > -    if (*errp) {
> > +    if (v->config_size < 0) {
> >          goto vhost_cleanup;
> >      }
> >  
> > -- 
> > 2.34.1
> 

