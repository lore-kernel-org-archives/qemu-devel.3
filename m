Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A57FEDF17D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqw98-0007T4-Cn; Fri, 13 Feb 2026 11:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vqw95-0007Sn-CQ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:35:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vqw92-0003Wh-Tr
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771000550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvQG+w3q/EtKBb2VPD3fL8W3e3E0DPOn6yLlTsL4iDY=;
 b=X/aCteVKR0dWU/9letuGinFUIiOn1dlH0ryKzXuKJsbZY+oLjISeUs8KBul1KSzRx5lJa4
 CXjUSyJHvJJ7kNqEdG3fxYehT7DZ/5PFjGr41JBvmkC8kv5i6TBpJphlt3yRYkl6oPGuk3
 +fXkJi9j1c0sTt2+MXzkDuM+u9Jjhdo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-axgRLeHhOem14UQwoRjiBA-1; Fri, 13 Feb 2026 11:35:49 -0500
X-MC-Unique: axgRLeHhOem14UQwoRjiBA-1
X-Mimecast-MFC-AGG-ID: axgRLeHhOem14UQwoRjiBA_1771000549
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-896fb2fb9d5so52814556d6.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 08:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771000549; x=1771605349; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RvQG+w3q/EtKBb2VPD3fL8W3e3E0DPOn6yLlTsL4iDY=;
 b=eWiTq+IFHZKOI1/dO8I1i4dVGKxlnKsKcTe+S1PgryL6UDIWdP4BAyYYQYv1u8c++J
 LG63IeRV3U4IN+Mv1sA2RQqufgNpDaCuiEE6TX6um3ZLXGFP0bReQnBPuRxaeEKKRkmO
 AWVDmkhEZVyQa9DDCUQZD5WlnvZeg1B2WMMjvuso+YCVnUYdTZzidxl5njWSkmihxHpa
 6TU2n/DbW4AdILXYdtmRXITsLDHR+5MwEfqQ8kn8J9ubjl5RHoWZQnRT9SL1ZTXmLglW
 zrcGyFIsGrheeAXgJUGKWfNQFu3I2DU68H8NbXjE5zYEeYoehCcg2ahDC+GxuSTs5X/5
 x6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771000549; x=1771605349;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RvQG+w3q/EtKBb2VPD3fL8W3e3E0DPOn6yLlTsL4iDY=;
 b=bo/UjgF5U8Buy9yApK4ZL+jn7Rz9kmwmccxZeeCud8nJ/vfLEda6k/SAQov8gEgVr8
 tb49WfXLnTLBdRu5BYKZP5EBLiGGMZ/PiTlR439mM3XRd14Dtum2jmpIcT4qtI2n5gfb
 hWDAljsY5dLXp+1VfLNaCMeT3oHJbsjgeDBQ7zUzuCLYkAUUPihhZtM1W/YZL9K4/jfx
 gwdv6KwjO9x0buVKgar8GB8CWR8gkbnqTai8ZP3gV6BjyA8AuPuqX8JRsp9Icf81ktX2
 LAKZGvhiNGMGiRMnfXwHD+fWFANnslWTUMdzv6X1wVP8tYoQ317xjWt+luJC6qjkvJNe
 1CzA==
X-Gm-Message-State: AOJu0YxQ6hhCaP9qN2O9a0f3zWQyj0S8S19GLHpio4sk+4fpoHfMW5TQ
 /ZJOr1m1YU52RV3lPXABut2iSMfviq/mYkygu8qCLG8o7j2+AMoo4yZTcbaJVYqF472LYIKkYvN
 0Uc3QbYP65Mi8qoVCJJm9Pj+beHwuHzj4VVKtjytdPw8MtNw0IaEqGc4F
X-Gm-Gg: AZuq6aJUIvaapNVCFS7CPzVOavlc0SmY3wZ7ypxyrXusgiycUT5Ts1m5iR8id9eGMBw
 aT+2tIMVW0L2nsbFdQ3rD8mgCCMjRHW8Ig3xrnkUwC/ZbsVOj4hNittJ/VXPHOQkDApWg6Yh6/v
 a/egxzN51H499UkD+amjvF1Mt+HLIBLryQPUwYmpAOQw1TmkVX6lsaYZhJc/TwPrOSMJ/KLUXh1
 s3/wlfPKHUURRBFU7b+gwxPV/fdmOtbGfP7jDxE9aNczvNKSZ3dl7LhpLtbSBm+Pbn8g0cQNFqj
 ggPr/YgZkAKCQPfLLe5nWGJVa0LDDxBpfaXJM/mSLe5J/F0uHpRqklarcHtLyu6LIAzW7bvL4VN
 oiqi9XAm/XW78cA==
X-Received: by 2002:a05:6214:248d:b0:88a:277d:100 with SMTP id
 6a1803df08f44-897362e3671mr34545906d6.62.1771000548924; 
 Fri, 13 Feb 2026 08:35:48 -0800 (PST)
X-Received: by 2002:a05:6214:248d:b0:88a:277d:100 with SMTP id
 6a1803df08f44-897362e3671mr34545176d6.62.1771000548099; 
 Fri, 13 Feb 2026 08:35:48 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cd8d8c7sm77539606d6.26.2026.02.13.08.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 08:35:47 -0800 (PST)
Date: Fri, 13 Feb 2026 11:35:36 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH] migration/cpr: Include vfio-cpr.h instead of vfio-device.h
Message-ID: <aY9S2EIjP6tqPss0@x1.local>
References: <20260211171532.1556719-1-clg@redhat.com>
 <aYzTTrgqWTlY76m_@x1.local>
 <4689305f-84bb-4423-8b7a-d66e6f77f6c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4689305f-84bb-4423-8b7a-d66e6f77f6c0@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 13, 2026 at 10:05:06AM +0100, Cédric Le Goater wrote:
> On 2/11/26 20:06, Peter Xu wrote:
> > On Wed, Feb 11, 2026 at 06:15:32PM +0100, Cédric Le Goater wrote:
> > > The file migration/cpr.c uses vmstate_cpr_vfio_devices which is
> > > declared in hw/vfio/vfio-cpr.h, not in hw/vfio/vfio-device.h.
> > > 
> > > Replace the include with the correct header file to avoid pulling in
> > > unnecessary VFIO device declarations.
> > > 
> > > Signed-off-by: Cédric Le Goater <clg@redhat.com>
> > > ---
> > >   migration/cpr.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/migration/cpr.c b/migration/cpr.c
> > > index adee2a919a364244867ef190fdf29bd1fe7e20e2..a0b37007f55d6dac32bd6220ffe65d32c4e6b52e 100644
> > > --- a/migration/cpr.c
> > > +++ b/migration/cpr.c
> > > @@ -9,7 +9,7 @@
> > >   #include "qemu/error-report.h"
> > >   #include "qapi/error.h"
> > >   #include "qemu/error-report.h"
> > > -#include "hw/vfio/vfio-device.h"
> > > +#include "hw/vfio/vfio-cpr.h"
> > >   #include "migration/cpr.h"
> > >   #include "migration/misc.h"
> > >   #include "migration/options.h"
> > > -- 
> > > 2.53.0
> > > 
> > 
> > This should be better as a standalone change, thanks.
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > Some thoughts beyond this patch alone.
> > 
> > When looking at this, it's a layer violation.  Logically migration/cpr.c
> > shouldn't include a vfio header, otherwise it means when new devices added
> > to support cpr then migration needs to include headers to every single of
> > these devices..
> > 
> > Logically it should be the other way round where migration/cpr.c should
> > provide a helper allowing devices to opt-in for cpr-states to register
> > instead.
> 
> with vmstate_un/register() ?

Likely not, because the vmstate_register() API only put things onto the
global default savevm_state.handlers.  Those are "normal" VMSDs that will
be migrated within the normal migration framework / channel, not the CPR
special channel at earlier stage.

CPR channel currently saves only the special VMSD, which is currently
vmstate_cpr_state.  That should also be why the vfio early sub-section is
attached.

Logically it can be another similar vmstate_register_cpr(), then that'll
put the VFIO speical VMSD to be one of the subsections registered to the
CPR vmstate_cpr_state global VMSD.  Here subsections can be a good API
between CPR core and CPR submodules (like VFIO) because when we send a
subsection the dest QEMU will be able to lookup the subsections based on
the name of subsection.

Then I believe it means when there're >1 consumers we don't need to worry
on which got registered first, so the order of subsections to be registered
shouldn't be part of ABI, however the name of the subsection VMSD will (see
vmstate_get_subsection() on how we do the lookup when loadvm, that applies
too when loading CPR state).

I don't know any existing use case of such dynamically registering
subsections, but I think it sounds doable and maybe one simple solution for
CPR's use to make registrations dynamic.

> > Now it's also awkward that vmstate_cpr_state always have a subsection
> > called vmstate_cpr_vfio_devices.. it means we will migrate this subsection
> > even if there's no vfio device..  that's also another point that I think it
> > should be done the other way round..
> > 
> > I do not know whether we must persist CPR ABI now.. if we need, we can't
> > change this anymore without a machine type compat entry (as we will expect
> > vmstate_cpr_vfio_devices to come from an older binary that does a cpr
> > migration).  But that'll be sad..
> 
> vmstate_cpr_state was introduced in 10.0
> vmstate_cpr_vfio_devices in 10.1
> 
> commit a6f2f9c42f3a ("migration: vfio cpr state hook") already
> broke migration compatibility. May be this is something we can
> still fix without a machine compat.
> 
> I have no idea how cpr is used today, in which product ? Can the
> maintainers tell us more ?

Yep.

I didn't pay much attention when reading the series when being reviewed,
but IMHO we could have marked cpr features unstable from the start until
it's relatively solid and in serious production deployments.

Thanks,

-- 
Peter Xu


