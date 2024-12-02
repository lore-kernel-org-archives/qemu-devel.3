Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6FBD4979F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 06:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHzfk-0007te-TE; Mon, 02 Dec 2024 01:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHzfg-0007tS-Uh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 01:12:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHzfc-0003P9-E7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 01:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733119945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7z4C4qXWu4847BgXLaVdx6k9c1sivKtGDzMQzZfE5+c=;
 b=RLJHiSRewLO/pY9RYxSxQKJZKfVk4SsMB7didpkxWVH+IBTsOK2l+cRdSiagijnmYz8DoA
 b0rPv2qIjBfseTVcKalOCm1nK+W+bLfFoS/CQMdizOYzc6Dj30EUbqD+j0KfFMtQ7BEnqO
 igKoLaq2G2mIQMjebNC3MS9W1cnf2MY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Hud5LhyeMVSktBJ28gsmtg-1; Mon, 02 Dec 2024 01:12:23 -0500
X-MC-Unique: Hud5LhyeMVSktBJ28gsmtg-1
X-Mimecast-MFC-AGG-ID: Hud5LhyeMVSktBJ28gsmtg
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-29e5d14524cso120845fac.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 22:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733119943; x=1733724743;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7z4C4qXWu4847BgXLaVdx6k9c1sivKtGDzMQzZfE5+c=;
 b=pCG4hVCQ7kJtRPdSEUsnqjnkBFK6A+lhMnzclNj5s+/wAg/uiiRkkgKzWvxnKkOHTp
 kIK8uM7oVeGPmv2yYyhxl3N8xwmQNh4NzPUN5sXWev+5c3Na9MWemVY5ICvzbV/7J0Yv
 8XLiS2hE9rlv03L1Veuip9ziLum1u+N1nDXWoxpzNvurtJtS0/+VEL2yJb+HccKeOH32
 BuR8TmyEzbr6U8XRmsyn1ZYJOiY+WbvDHHRLgiVlNy3ByKcwRtLn0wHAPwC+mH59DNxQ
 D6Rv1zleUlG/zy0K1u6b1r+UnEK8ib7knU4hckkRSfAk6ozR73bkNahtI48oficKoIha
 GzDg==
X-Gm-Message-State: AOJu0Yw272v9E65Wv5dW3wEnU3D245M44ewa+y66ln/rXEKS2ir0ZskX
 1gbFSQ0yOe5u5C1khq5a6T/EJ8fleoHvoOinz1BKaIat6Ru6S27wS+HvSW5FAA4e6kLUEdxVv1b
 t2WGdvc5y2cQjk/sc8l163rVFui3exDNxmJWVYt53Gy7jMQ3GQTjQ
X-Gm-Gg: ASbGnctaqcG06dhIpf6XWwyiRhuJ2Xc+9tQzWVB1eRkaxuoRnHIc26a8RBUuO4XGqQC
 euu7XECs5VKhwAXTXZ5/B/rGnCYUqViV3nHDrcQesi4/gn5/cWmfYM7ypVC4rwDA9Gn0qQKzaHW
 67+P1Y1d9X0lCnfBzK0u8HSAAen8pYSCc943uwImgpWrLn3qwCcBFdjxJ+t6yDugirvbcO5Udla
 M8mxMMJRWXDLpmc/xypOzkq/Am3p8h6QDE7W5MqPW1CTlzhyMljaQ==
X-Received: by 2002:a05:6820:1c82:b0:5e3:b1fe:b1a with SMTP id
 006d021491bc7-5f20a171476mr4351683eaf.2.1733119942969; 
 Sun, 01 Dec 2024 22:12:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbIyolYTxR7RbEA932Q0FDkPxUZvmvVAnkw+Xn8csTqFEGWrJGrvXN4PsHMybdOUHsJtP5fQ==
X-Received: by 2002:a05:6820:1c82:b0:5e3:b1fe:b1a with SMTP id
 006d021491bc7-5f20a171476mr4351675eaf.2.1733119942569; 
 Sun, 01 Dec 2024 22:12:22 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a3ab1d3sm2138869eaf.23.2024.12.01.22.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 22:12:22 -0800 (PST)
Date: Sun, 1 Dec 2024 23:12:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <c.koehne@beckhoff.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 1/8] vfio/igd: fix GTT stolen memory size calculation
 for gen 7
Message-ID: <20241201231220.02358a6b.alex.williamson@redhat.com>
In-Reply-To: <20241201221129.03ea9577.alex.williamson@redhat.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-2-tomitamoeko@gmail.com>
 <20241201221129.03ea9577.alex.williamson@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 1 Dec 2024 22:11:29 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon,  2 Dec 2024 00:09:31 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
> > Both intel documentation [1][2] and i915 driver shows GGMS represents
> > GTT stolen memory size in multiple of 1MB, not 2MB starting from gen 8.
> > 
> > [1] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/3rd-gen-core-desktop-vol-2-datasheet.pdf
> > [2] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf
> > 
> > Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> > ---
> >  hw/vfio/igd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > index 4047f4f071..e40e601026 100644
> > --- a/hw/vfio/igd.c
> > +++ b/hw/vfio/igd.c
> > @@ -268,7 +268,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
> >  
> >      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
> >      ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> > -    if (gen > 6) {
> > +    if (gen > 7) {
> >          ggms = 1 << ggms;
> >      }
> >  
> > @@ -678,7 +678,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> >  
> >      /* Determine the size of stolen memory needed for GTT */
> >      ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> > -    if (gen > 6) {
> > +    if (gen > 7) {
> >          ggms_mb = 1 << ggms_mb;
> >      }
> >    
> 
> I'd argue this should be rolled into patch 4.  It's not really fixing
> anything because igd_gen() can't return anything between 6 and 8.  This
> only allows for several device versions that we currently consider to
> be gen 6 to align with i915 kernel driver generation by calling them
> generation 7.  We'd previously lumped them into generation 6 because
> there's no functional difference we care about here between 6 & 7.
> 
> In the next patch you replace this '1 << ggms_mb' with '*= 2', which
> would be equivalent to 'ggms_mb << 1' and matches your description that
> the increment is doubled.  Is there a separate bug fix that needs to be
> pulled out here?
> 
> Also, please send a cover letter for any series longer than a single
> patch and please configure your tools to thread the series.  Thanks,

Disregard this latter comment, I just wasn't copied on the cover letter
and didn't have it in my inbox to root the thread.  Thanks,

Alex


