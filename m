Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3B1C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 17:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgSCy-0005Th-Bv; Fri, 07 Feb 2025 12:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSCm-0005S0-Fj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSCj-0004U4-Pq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738949508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+hVGKphc923ntstltAqx5jv6k2i5+FfJvtJtSEAHpU=;
 b=AFwR2bfVX5wD1wrqJFFxQdxJ0FRTu/qWwLUonPDgVeAdL2YnTAFmBB5RdAZ3JCNrHR9T7q
 j6vbtgMmAjiZNbf7IYRl2JwqeDmXSHNHL176ocmtAlHyJAQ0eVldFG0xmeBKGMQMS07W7f
 gWZja2V/ISvP+eZzyqiuMjHinjdFQwk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-lPUTPmcMPBW0sofZYZT1DQ-1; Fri, 07 Feb 2025 12:31:47 -0500
X-MC-Unique: lPUTPmcMPBW0sofZYZT1DQ-1
X-Mimecast-MFC-AGG-ID: lPUTPmcMPBW0sofZYZT1DQ
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e4237b6cf0so31693666d6.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 09:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738949506; x=1739554306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+hVGKphc923ntstltAqx5jv6k2i5+FfJvtJtSEAHpU=;
 b=vMU97VJIqFa9kbC80Q0Lfdb0nwmfAVvEjXRU6zqzy3cZCgF+zFQbiZNtfBtXPajt1A
 L7WzhyXR8aV8VrhZJjX0jki7aO7sVsiIHHvphcEA2MhZOrkZvi8tVh8gE8MOT06Ddsb+
 2Hm3sc3TuchpmAsf6ovJ3LrlKGxGjWZsYspZ4KVvJ8mRQfWjC4ADCKkDsTYUmKv4ZgrJ
 hWGu1cuhn+coxj37v5oqqjuzYuWLvg1za8RsSm2Hb0Iqa7cGoepM4+EUq7Qf3rU9mP2o
 RwLmngSq4DGaZ4/zTo5psJ8fZvOiITk6p0xsL3pAE38Iw/Iye1/lM8Z8zfjteSsUJAkC
 Q0mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA+X8M/0ImYHS53v2vPNjpkxgftVBUky15MFT/XtisMbIQCwXeGStTeXXX00j/GnYv/Et6A5INbHKY@nongnu.org
X-Gm-Message-State: AOJu0Yyc/qI5YrmCe656aLm4MaMpO6l5QJDir/9JcUTluNFhypDf7H6/
 c5lwArRKbbLYqi5YQyo/1gktliZy9mFvvcNzZLgb+TY2MIbLYIVlJUofW4PwBGv1Qlaf9O18fnA
 03q14IyJbqrS20SnudlkVjmp3nIVsG9U5mpLjU308qBkxBWKMLeg6
X-Gm-Gg: ASbGncsH2v3IB4Z2mZhP4zQb2Pv3wKIAeKtPo435AQpnZdDgg9kexjm5gsEWjm6ZTWP
 0StelhxBF/OVnXAkQFwBtmcjCcUa3/B5+4QW3uQT0sOZHnchFYF+u98OBv0U1aiXRgPSI/YjPBG
 3oBOLTsFy3O23uZebar1Ys+pxPC/Pv4ImcCg4XajeDCx7V1CqgFBGIweiXrgbr4GLdtaU5scGUC
 c3u5NB4c0RZkGRXGX1Q2ilERx9koAohLXxmWz1LZihZVa7fEaIWynhx3RDBOkQcDmdhychRvHpU
 pXunxBEyDklOxR08qRsTnLzW1XPfkmJnJ7AZ9bAh3bmspHyZ
X-Received: by 2002:a05:6214:1d0d:b0:6d8:9a85:5b44 with SMTP id
 6a1803df08f44-6e4456c11ddmr53841516d6.29.1738949506592; 
 Fri, 07 Feb 2025 09:31:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdMrpiPUC/DSlsohXigBkE/YxGFEvwTpAqihXSUKAEp9u5z35o2+vL305yAGCOfAB+CFrVpg==
X-Received: by 2002:a05:6214:1d0d:b0:6d8:9a85:5b44 with SMTP id
 6a1803df08f44-6e4456c11ddmr53840976d6.29.1738949506188; 
 Fri, 07 Feb 2025 09:31:46 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e44c1aba8asm5395596d6.42.2025.02.07.09.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:31:45 -0800 (PST)
Date: Fri, 7 Feb 2025 12:31:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, imammedo@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: Re: [PATCH 0/5] Fix vIOMMU reset order
Message-ID: <Z6ZDf2K0YsqVRE5T@x1.local>
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <Z6Y6sf064FBWT5G1@x1.local>
 <CAFEAcA9ETg2+Xa+e3quJhGG3KsNuH+DW3puuWaJi-q1psUdw6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ETg2+Xa+e3quJhGG3KsNuH+DW3puuWaJi-q1psUdw6A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Feb 07, 2025 at 05:06:20PM +0000, Peter Maydell wrote:
> On Fri, 7 Feb 2025 at 16:54, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 03:21:51PM +0100, Eric Auger wrote:
> > > This is a follow-up of Peter's attempt to fix the fact that
> > > vIOMMUs are likely to be reset before the device they protect:
> > >
> > > [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
> > > https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/
> > >
> > > This is especially observed with virtio devices when a qmp system_reset
> > > command is sent but also with VFIO devices.
> > >
> > > This series puts the vIOMMU reset in the 3-phase exit callback.
> > >
> > > This scheme was tested successful with virtio-devices and some
> > > VFIO devices. Nevertheless not all the topologies have been
> > > tested yet.
> >
> > Eric,
> >
> > It's great to know that we seem to be able to fix everything in such small
> > changeset!
> >
> > I would like to double check two things with you here:
> >
> >   - For VFIO's reset hook, looks like we have landed more changes so that
> >     vfio's reset function is now a TYPE_LEGACY_RESET, and it always do the
> >     reset during "hold" phase only (via legacy_reset_hold()).  That part
> >     will make sure vIOMMU (if switching to exit()-only reset) will order
> >     properly with VFIO.  Is my understanding correct here?
> 
> Yes, we now do a reset of the whole system as a three-phase setup,
> and the old pre-three-phase reset APIs like qemu_register_reset() and
> device_class_set_legacy_reset() all happen during the "hold" phase.
> 
> >   - Is it possible if some PCIe devices that will provide its own
> >     phase.exit(), would it matter on the order of PCIe device's
> >     phase.exit() and vIOMMU's phase.exit() (if vIOMMUs switch to use
> >     exit()-only approach like this one)?
> 
> It's certainly possible for a PCIe device to implement
> a three-phase reset which does things in the exit phase. However
> I think I would say that such a device which didn't cancel all
> outstanding DMA operations during either 'enter' or 'hold'
> phases would be broken. If it did some other things during
> the 'exit' phase I don't think the ordering of those vs the
> iommu 'exit' handling should matter.

Yes, this sounds fair.

> 
> (To some extent the splitting into three phases is trying
> to set up a consistent model as outlined in docs/devel/reset.rst
> and to some extent it's just a convenient way to get a basic
> "this reset thing I need to do must happen after some other
> device has done its reset things" which you can achieve
> by ad-hoc putting them in different phases. Ideally we get
> mostly the former and a little pragmatic dose of the latter,
> but the consistent model is not very solidly nailed down
> so I have a feeling the proportions may not be quite as
> lopsided as we'd like :-) )

Yes, it's a good move that we can have other ways to fix all the problems
without major surgery, and it also looks solid and clean if we have plan to
fix any outlier PCIe devices.

If there will be a repost after all, not sure if Eric would like to add
some of above discussions into either some commit messages or cover letter.
Or some comment in the code might be even better.

Thanks!

-- 
Peter Xu


