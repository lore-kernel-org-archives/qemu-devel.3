Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585F4C3DA4B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 03:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTYVU-0006nr-OO; Mon, 15 Jul 2024 23:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTYVT-0006j1-EZ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 23:05:35 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTYVR-0004tC-LF
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 23:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721099133; x=1752635133;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=simcWi/A8ibW9MAy2lxNik37ltRmM9CsXA1jvKvrI3A=;
 b=bnBg4P7Qn8G6GYx4+1h+14Su5zyeUEOeGRhS0djyNItU/ZyTcF0n9wnS
 qw87yz9+cfquNtHeO5hT1xNLhf3ScCzqRAGn+ESX0CFTwMqdbvenCNumA
 rj/RaMvro8n9vrcRKveriZ1cp1uNOap1gJ9atGL1TXCo9gsCKmZ1yFxrp
 a8bN5RnIHtPIpXCG38f0q/7EUTGYVtszBKtdDNGOoaUhRdAW1Gj21KM+p
 D+vY/VaawWWt65gxqGW4r/aOBP2CWNfLirLzBt6C32TDPu7WNVsLp37fs
 +hO5nFzyAs9U8yx2KAm0axcznlaJl76wigipoRXXk47rOZDSJe6+3L91W A==;
X-CSE-ConnectionGUID: srw9eIVLQGeUtq9XYtUnYg==
X-CSE-MsgGUID: xg+X85NfQOm5a3L9r2fdzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29923967"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="29923967"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 20:05:31 -0700
X-CSE-ConnectionGUID: zH6VH/3rSperRmrlsQYsYw==
X-CSE-MsgGUID: 5X9aYjs5Rby+HYHyJjKnBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="54390914"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 15 Jul 2024 20:05:30 -0700
Date: Tue, 16 Jul 2024 11:21:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] hw/virtio/vdpa-dev: Check returned value instead of
 dereferencing @errp
Message-ID: <ZpXnKCoz/7hRJZ6+@intel.com>
References: <20240715095939.72492-1-zhao1.liu@intel.com>
 <20240715095939.72492-2-zhao1.liu@intel.com>
 <CAJaqyWcRv53hNYXT31tZ9M317OTBsxSgQ5bJvo1y-E=VoVS24g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcRv53hNYXT31tZ9M317OTBsxSgQ5bJvo1y-E=VoVS24g@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 15, 2024 at 11:01:08PM +0200, Eugenio Perez Martin wrote:
> Date: Mon, 15 Jul 2024 23:01:08 +0200
> From: Eugenio Perez Martin <eperezma@redhat.com>
> Subject: Re: [PATCH] hw/virtio/vdpa-dev: Check returned value instead of
>  dereferencing @errp
> 
> On Mon, Jul 15, 2024 at 11:45 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > As the comment in qapi/error, dereferencing @errp requires
> > ERRP_GUARD():
> >
> > * = Why, when and how to use ERRP_GUARD() =
> > *
> > * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> > * - It must not be dereferenced, because it may be null.
> > ...
> > * ERRP_GUARD() lifts these restrictions.
> > *
> > * To use ERRP_GUARD(), add it right at the beginning of the function.
> > * @errp can then be used without worrying about the argument being
> > * NULL or &error_fatal.
> > *
> > * Using it when it's not needed is safe, but please avoid cluttering
> > * the source with useless code.
> >
> > Though vhost_vdpa_device_realize() is called at DeviceClass.realize()
> > context and won't get NULL @errp, it's still better to follow the
> > requirement to add the ERRP_GUARD().
> >
> > But qemu_open() and vhost_vdpa_device_get_u32()'s return values can
> > distinguish between successful and unsuccessful calls, so check the
> > return values directly without dereferencing @errp, which eliminates
> > the need of ERRP_GUARD().
> >
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: "Eugenio Pérez" <eperezma@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  hw/virtio/vdpa-dev.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> > index 64b96b226c39..7b439efdc1d3 100644
> > --- a/hw/virtio/vdpa-dev.c
> > +++ b/hw/virtio/vdpa-dev.c
> > @@ -50,6 +50,7 @@ vhost_vdpa_device_get_u32(int fd, unsigned long int cmd, Error **errp)
> >
> >  static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
> >  {
> > +    ERRP_GUARD();
> 
> Good catch, thank you! But removing the err dereferencing eliminates
> the need for ERRP_GUARD(), doesn't it?
>

Thanks Eugenio! You're right and I forgot to delete it. I'll post a new
version.



