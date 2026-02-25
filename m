Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3ABFD3774
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHmk-0005UF-At; Wed, 25 Feb 2026 11:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvHmc-0005PO-Jk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvHma-0007TS-40
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772037034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fbmfNPMmGGm2FcXB+MDAw2WjNrc2d71CHZiR7qGaWjU=;
 b=d+Ja/Hz9mVDy8pusJPtMB8RgvJ999umzfj2Ig6ZQ/9z81U/V8IicqNjYHaM6Jl86kPGBKj
 5MjROpj86HXdq97KEzxK2zAcFjuGMvRgG9XytA3X9AP0mvA56cCy6A3D3MG7Q1+xOkywER
 CQo1tyrfSLeg1RGGvjn1r+cG7t/WSbQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-b8PFhJ1TMsWiUQ-6jcdbTQ-1; Wed, 25 Feb 2026 11:30:32 -0500
X-MC-Unique: b8PFhJ1TMsWiUQ-6jcdbTQ-1
X-Mimecast-MFC-AGG-ID: b8PFhJ1TMsWiUQ-6jcdbTQ_1772037031
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-506bf83258bso756321701cf.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 08:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772037031; x=1772641831; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fbmfNPMmGGm2FcXB+MDAw2WjNrc2d71CHZiR7qGaWjU=;
 b=mr2Fn0vwnHy1i6eYhk3jNegaL6g1ZEijdf035AO7+m/P5qo5GSzx668J2eDEvhbSr2
 PsqblD6mhg34PnWQ978cPy0QKNRV2VJlDZUAoFuJOMYylSso4EjS36VXleC8QBLq8PT3
 mJKAjxdzl4Ft1iHJuzNx1munx5d4HNtTneWTrorKlcp6KD96pSGfovZgRH0SeyCuvL+T
 BCFI48N6f2Q0KTiPxuQbJcAheae6qqeGyhgjRvIlx2Sdfc0shAWKtaBjB7Ok9zWG4AjA
 V00WQ9WGRTtN01jbBeXjQV0JdjzUuo7CN0Kvzw6q0Sw9l3Awa//SwsgPsdjDXLe6O90l
 4VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772037031; x=1772641831;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbmfNPMmGGm2FcXB+MDAw2WjNrc2d71CHZiR7qGaWjU=;
 b=jyFtOLalfkX82FrzwCfg5WB/PmKuXdPr1bbEdlapU+OkxqzjpPDF75GDZW2346xBbS
 pu5ERpt4GSNPflRDlsxAF1gncrDvNSig76GYBf05qiKxUHF9nXZuDIaZeKkdUfqWzGgA
 CeVroDkexHu6nSEUO/mzTIUBzPuLB5ddHA5/H8Ou/o0RLwRI8yvHWsHD9g2MYL9JJDLu
 S+3CWkifFsC5sjgbsZJPs6x76eavjyTwdnGLXqqugg3msYeVkk/RVOjykPLCCQ8p28xo
 82f7cW86KzQb9xYbfnEMaTfovnOkEuyDSsytkgiHdzGMzf76M9GuVPCa9T5iS+aeD3eQ
 Y5Eg==
X-Gm-Message-State: AOJu0Ywamw9/cY7pyEeXRFoJrpC5UT6+90Fc48LWs2C61YLOEc44C41s
 p/tHxYw4xDZjeeDej2VhugEhpw3Q6bJLItKGYSDUtNpV0ii8jt9jlLUcadLyiKpXVEoij1+tqw9
 I8AZppUmiUOV9urN2o9Y5ZS+nvGeyPVM13ESbuAbaCubFTKCu6+et+xdT
X-Gm-Gg: ATEYQzw11lipOdYh0VgPtGFNbtYk45KjuHW0KDmQsujt3ueB+jKROVUEDnWuGffNzyI
 if9x+1Y4gN/xtXY0bHVCTvRwa0k2UtLjNH4qX6lDfVU2q0mv2BybYo06zZx9lw9TaJUs46kVrKf
 prG/3xQhDHK4tVKL2SPvZICIn1dVH/cDNaUAvu0LCrq1ijmMGlg48us8KKUjjCLKk1GDT4kdVT7
 32LWPyg5piWastwr8PzKHT4JFLSBAzzSgFLB34ldoEDqMZgC3oCvFJGSn9kjlxxsv2dPrPGPVHT
 siRnqXSVEVwR0q67GMtbwtu38Y2x7Zr5FucB2m24i3sNYDiSU+OnQrzx+sx1qsZ7rxWiGEl4K0/
 a/WiujtK5TFUaLA==
X-Received: by 2002:ac8:5fd0:0:b0:4f1:ccdd:ffde with SMTP id
 d75a77b69052e-5070bbab632mr232379511cf.21.1772037030626; 
 Wed, 25 Feb 2026 08:30:30 -0800 (PST)
X-Received: by 2002:ac8:5fd0:0:b0:4f1:ccdd:ffde with SMTP id
 d75a77b69052e-5070bbab632mr232377311cf.21.1772037029054; 
 Wed, 25 Feb 2026 08:30:29 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899a55a1b05sm47781796d6.14.2026.02.25.08.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:30:28 -0800 (PST)
Date: Wed, 25 Feb 2026 11:30:17 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/8] memory: Remove most _nomigrate variants
Message-ID: <aZ8jmaB-zuBSoQXH@x1.local>
References: <cover.1770253186.git.balaton@eik.bme.hu>
 <aZ3CQw2ad5cVc-Mm@x1.local>
 <c8a789fa-8d16-709d-eb3f-8acd6c1d08e8@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8a789fa-8d16-709d-eb3f-8acd6c1d08e8@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 24, 2026 at 06:44:58PM +0100, BALATON Zoltan wrote:
> On Tue, 24 Feb 2026, Peter Xu wrote:
> > On Thu, Feb 05, 2026 at 02:13:18AM +0100, BALATON Zoltan wrote:
> > > v4:
> > > - separate patch converting Sun machines from memory_region_init_ram_nomigrate
> > > - split helper to init ram into two functions: setup and error_propagate
> > > - also use memory_region_init_io in memory_region_init_ram_device_ptr
> > > 
> > > v3:
> > > - rebased on master after some patches were merged
> > > - drop some more line from memory-region-housekeeping.cocci
> > > - added comment to explain what factored out helper does
> > > - some more clean ups included
> > > 
> > > BALATON Zoltan (8):
> > >   hw/display/{cg3,tcx}: Do not use memory_region_init_rom_nomigrate()
> > >   memory: Remove memory_region_init_rom_nomigrate()
> > >   sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
> > >   memory: Remove memory_region_init_ram_nomigrate()
> > 
> > Could you help explain why we need to remove the above two small helpers?
> 
> Ideally we should remove all of the nomigrate variants as there are only
> about 3 uses left, everything else is already moved to the init_{ram,rom}
> variants that register the memory region for migration. The is probably one
> legitimate use that is served by memory_region_init_flags_nomigrate and
> other 3 uses are the xtfpga which I think is just old code and does not
> support migration so it will be converted in the second series to
> memory_region_new as the maintainers did not say anyting to that so far.
> Then there's one in hw/display/vga but that's gated behind a compatibility
> switch that's only set in 2.12 (global-vmstate=true) and earlier. This is
> not active any more but cannot yet be removed as there are eariler compat
> props still need cleaning up but the last visible machine version is 5.1 now
> so this is long deprecated and not used. And there are these Sun machines
> that I've converted in the first version but Mark said he'd like to keep the
> current behaviour until it's the last user left. See: https://patchew.org/QEMU/cover.1769703287.git.balaton@eik.bme.hu/b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu/
> 
> > Not saying that we can't remove them, but I don't yet see the point of
> > open-code those readonly=true setup either, or any problem with having the
> > smaller helpers when ram_flags=0.  Small helpers sometimes help readability.
> > 
> > Some of them are going backwards againist what the cocci scripts were
> > suggesting previously, like:
> > 
> > - memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
> > + memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
> >  ... WHEN != E1
> > - memory_region_set_readonly(E1, true);
> > 
> > So you suggest open-code instead.  Why?
> 
> This is temporary until the usage in vga is gone with hw_compat_2_12 then
> the Sun machines will be the last users so they can also be converted to
> init_{ram,rom} (unless Mark changes his mind and agrees changing these now
> as was in the first version).
> 
> > Is it required for your follow up cleanups?
> 
> It makes those simpler as then we don't need to add memory_region_new
> variants for the nomigrate versions that we would remove later anyway.

Personally I don't see the memory_region_new() whole thing solid yet, but
still during review.  I shared my thoughts.  So far, I'm not fully
convinced, but I also don't have the full picture to say no, either.  We
can wait for others to chime in with more thoughts.

For this series, I would prefer if we can discuss it separately from the
other work.

Removing _nomigrate() variances makes sense to me in general, it means we
want to by default suggest new devices only use RAM regions that is
migratable, with proper owner device specified along with the ramblock name
(as part of migration API).

However, we have two sets of these _nomigrate APIs:

  (1) memory_region_init_r[ao]m_nomigrate
  (2) memory_region_init_r[ao]m_flags_nomigrate

What I am still confused about is why this series used (2) to replace (1)
rather than removing both.  I don't understand how this helps if we still
have (2) around: it means new devices at least can still use (2) to bypass
migration.

There's actually one way to enforce migratable RAMs, taking ROM as example,
it could be:

  memory_region_init_rom_internal(..., global_vmstate=XXX)

Then memory_region_init_rom() should use that, setting global_vmstate=off.

Then we can unexport/remove memory_region_init_rom_[flag_]nomigrate() but
use that _internal() in relevant paths; we should also mark the _internal()
functions to say "new code is suggested to use the normal version".  But I
do not know if that is a slight overkill just for this..

If the other series (to avoid introducing new APIs) is the only reason for
this part, then IMHO this part of the series needs to be in the other
series, not this one.  The last cleanup patches look more self contained
OTOH to me, if the whole purpose of the latter half was code dedup, then it
makes more sense at least to me.

Thanks,

-- 
Peter Xu


