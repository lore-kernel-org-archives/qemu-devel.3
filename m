Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0832BCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw9h-0002ym-U3; Tue, 26 May 2026 14:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRw9f-0002vn-II
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRw9d-0002B5-UL
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uziicvrsk7jl0hTc1KoJgi0g/une3PHj76G4HEaPbGs=;
 b=e3Nom/72XRFWD7z2mL3SwKuneVtHf2ijntKtpiUF+BbhDpDHe0525/djGDuZRqMtWXxJSc
 1gojxdBOte+ZiBJcXUnM0U+3YkWdZiT70Ge54PCWasnIrbqh4buC2x3bR086KZ10K7Vn3y
 PoRW9Z4MDkJDAASxO4oQ4JiJpOYG3jM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31--zWxvL-eNU6CpJgFGBnpKg-1; Tue, 26 May 2026 14:05:23 -0400
X-MC-Unique: -zWxvL-eNU6CpJgFGBnpKg-1
X-Mimecast-MFC-AGG-ID: -zWxvL-eNU6CpJgFGBnpKg_1779818722
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49047e22ed4so35664365e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818722; x=1780423522; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uziicvrsk7jl0hTc1KoJgi0g/une3PHj76G4HEaPbGs=;
 b=ACnl5YnEUNWoYVJGcMhVUyD4+WzKRq+V8OHpztov3QXdZDxfxS00xTpOTHr9E/WQ/T
 bSQc9KZIx7YkF3ELUBU5FXcDVTkWlpvruuvD283mVhdkjxaTWZv1nEKDbI9AYOwP0Wo8
 +diBJ/QfZfwoOaf3ubqpQB+3BXy+ROBKKwNcH+muFwSU9OFgH8aPXwM5apqOxdMmAjzf
 z5YFj6o7z/QPZDHjQaod+P/hzBxGPcVJiLvVuUs6OfLLzI9/qgA372k6IfhdRpBnIOhA
 vzH3Fsu+mJN+qXtNKWfr96ypF+eHBUO1cXnxp2Jx7oZGZ08SzSHKLNptlrENxViBObGk
 bh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818722; x=1780423522;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uziicvrsk7jl0hTc1KoJgi0g/une3PHj76G4HEaPbGs=;
 b=hsbeUzgu489M3oHI9QenKFHEHuixRc9UkNnJvQsTdQ9/S9FRw+5AzEEPZ+rmevt9Z2
 xdVXrahW/3pXv1mxI8rDL6PZ15qa6QBtZmCGF2aInDxAbHdSmOX8dJU6LNK5Zc7QKdsu
 qE+961jgm2n8P9dHzMQrG8j8+6NPTMEnl7O2RAY8Qh+VZ2cMrypoBIziIyRrP0n7eJaj
 NTju8u9rHuygV7uNYF4wMPXgf3+ICJi16dHkfxYlWPe4U0KMkAmyVjt5ouS0yH5cjjCK
 dpNU6z0kTz5bMbpJX7UbeJfVdihLxtg95cEdNUZNJlZXATmJi6TigZErDmfHvl4/BseA
 1iQA==
X-Gm-Message-State: AOJu0YwpdJfkEkYqSAGmcu7nECNA6EEnS3D1elJBfKS4sTgLNO3XxXhg
 UBVcjjr//KbqBVG7Or03HqvmA80L5V7T3PecqAxgV2FBLqemLy7HOiyFXMtNrtWrwWzpyZmlxn7
 FImYNb5Yl+M1GuCUWYF8iS3jas0C4Oq3CO+iFOlvY4RMlR5RqtDit2Ap5cAOQlkyM
X-Gm-Gg: Acq92OEPUMo1flX34CFOwkbLiZ0ytKFuWIyYcpI964iCNIly+S6OFvW1mmg2aBdh0yI
 GNLyvadll8u/MlrygUOqpuxefhJTNuyLDP6M0Aoa7XaVPS+gGZ0xMOo5riwmBWr2Yn6RDlYgPvr
 VCxdH9BNsdIYeVwXwB60LochGSaRdC/v64NEegQ2uBiej3nLajYMhHsTQ45tnc6CmiE7Uea8clH
 sQzMMgOOuXRe1X9VccB11vcuBliK/TJABviF9AiDDVX0QKEekk0Nuj9VOxnjT0O+oyfw0llZZec
 PMyPn/6AWzmtFU+1dSr7Zpv7ia3gJWv86UV2oYY1+7rM1Fo+x4b9IAGJEV0Yc2+A0hUftAX4rlZ
 xoOgw8kKVQybaN+9i5xd4L34/Oil+rSozDHejyn8gN2I=
X-Received: by 2002:a05:600c:8b08:b0:490:601f:d785 with SMTP id
 5b1f17b1804b1-490601fd90amr198434585e9.2.1779818722103; 
 Tue, 26 May 2026 11:05:22 -0700 (PDT)
X-Received: by 2002:a05:600c:8b08:b0:490:601f:d785 with SMTP id
 5b1f17b1804b1-490601fd90amr198433885e9.2.1779818721616; 
 Tue, 26 May 2026 11:05:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49049973b71sm100633615e9.29.2026.05.26.11.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 11:05:21 -0700 (PDT)
Date: Tue, 26 May 2026 14:05:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Quan Sun <Quan.Sun@windriver.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net,
 sgarzare@redhat.com
Subject: Re: [PATCH] hw/scsi/vhost-scsi: fix build with older kernel headers
Message-ID: <20260526140511-mutt-send-email-mst@kernel.org>
References: <20260525182730.4098543-1-Quan.Sun@windriver.com>
 <20260525183656-mutt-send-email-mst@kernel.org>
 <c783a05b-62cf-44d2-81f5-13b8e3f0f81e@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c783a05b-62cf-44d2-81f5-13b8e3f0f81e@windriver.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 26, 2026 at 10:27:57AM -0400, Quan Sun wrote:
> 
> On 5/25/26 6:39 PM, Michael S. Tsirkin wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Mon, May 25, 2026 at 11:27:30AM -0700,Quan.Sun@windriver.com wrote:
> > > From: Quan Sun<Quan.Sun@windriver.com>
> > > 
> > > On build hosts with kernel headers older than 6.0, the system's
> > > <linux/vhost_types.h> does not define struct vhost_vring_worker or
> > > struct vhost_worker_state, causing compilation of vhost-scsi.c to
> > > fail:
> > > 
> > >    error: storage size of 'vq_worker' isn't known
> > > 
> > > Fix by including standard-headers/linux/vhost_types.h before the
> > > system's <linux/vhost.h>, matching the existing pattern used in
> > > hw/virtio/vhost-backend.c. QEMU's bundled header provides the
> > > struct definitions, and its include guard prevents redefinition
> > > when the system header pulls in its own vhost_types.h.
> > > 
> > > Signed-off-by: Quan Sun<Quan.Sun@windriver.com>
> > Hmm. maybe replace linux/vhost.h with standard-headers/linux/vhost.h then?
> 
> Hi Michael,
> 
> It seems there is no standard-headers/linux/vhost.h in QEMU's tree — only
> standard-headers/linux/vhost_types.h. The file linux/vhost.h (the kernel
> header) is
> still needed here for the vhost-scsi specific definitions (struct
> vhost_scsi_target, VHOST_SCSI_ABI_VERSION). The approach in this patch
> matches the existing pattern in hw/virtio/vhost-backend.c, which also
> includes
> standard-headers/linux/vhost_types.h before linux/vhost.h to get the struct
> definitions that may be missing from older host kernel headers.
> 
> Thanks,
> 
> Quan

Alright.

> > > ---
> > >   hw/scsi/vhost-scsi.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> > > index 699863cc10..10e8fbe503 100644
> > > --- a/hw/scsi/vhost-scsi.c
> > > +++ b/hw/scsi/vhost-scsi.c
> > > @@ -15,6 +15,7 @@
> > >    */
> > > 
> > >   #include "qemu/osdep.h"
> > > +#include "standard-headers/linux/vhost_types.h"
> > >   #include <linux/vhost.h>
> > >   #include <sys/ioctl.h>
> > >   #include "qapi/error.h"
> > > --
> > > 2.43.0


