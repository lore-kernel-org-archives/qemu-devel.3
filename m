Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B291C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCv5-0002GW-UW; Mon, 29 Jun 2026 10:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1weCv1-0002Ew-MH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1weCv0-0006yD-2L
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782743099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o1SGRQ97Wd7W6nQ8LHQ2jzgGx518tnCjH/1CI0VlI+M=;
 b=S6hFbNHALcL9ng54ve/CVwY5ElczdgylfscW15BHCRabONE57ewIkS6JMZMBoFQKL/8aCR
 CGIBv9WvIrxkp7/CCd4WEg1DTlxdRxy18hHFQczYSk3tLcDnhMCbCDlhMkpo3CYkBYCzQa
 8FyMD529aW7/3VeYSDyo6fRB3bRAB28=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-dl0ZBKdjOO6IvEWv0chS7Q-1; Mon, 29 Jun 2026 10:24:57 -0400
X-MC-Unique: dl0ZBKdjOO6IvEWv0chS7Q-1
X-Mimecast-MFC-AGG-ID: dl0ZBKdjOO6IvEWv0chS7Q_1782743097
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92d1cae5740so194159185a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782743097; x=1783347897; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o1SGRQ97Wd7W6nQ8LHQ2jzgGx518tnCjH/1CI0VlI+M=;
 b=CdWVU9+6wERFDl/chkg4wl+yAC6c9JD+ms2jtuJ+wMMFcAln5UiZhCoK/LXL3JPjQk
 hMUyO/3GaydK83G+WI+nlqdrtozYBHQpGriBTTmdi4JlH3GfnceECbGD/znXlOOsmKAJ
 iPXy521GEbSkoPefJyMTWUUER8/gkniIM4b2dYB1KvFp09//ePmfUCYtb/l29taprQnS
 WozxkFRhBhUZWQOwag4u+mINm3/p3DNEppBOH5qU8nLRECvW8cRRNskUhZHym9YOLG9H
 gfT3mjwG6CW/odma1QDSvBvof5cK/VM9sLpWYp4E2QjqRr0nlLEhZB0d5tHKPmpho19s
 f6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782743097; x=1783347897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1SGRQ97Wd7W6nQ8LHQ2jzgGx518tnCjH/1CI0VlI+M=;
 b=SnBRGCb8QX4x2jwjzVpsW6Vsn9N6wy53W8d3Y3poXYN1/9dWzGRiVwu/uknzcoqvP8
 3vrj0AAHzxpFHgxhwMxOHwcgwX3bIJOAtu0b0weOaDhVE74meeeiq8uX2MTME3JQUhiS
 dtH42bKlTls0QE8yLyakcRwMlNya+kS84ks30cSvHdYFLXYMS/XTVPYI+jKAA7BGnThT
 pBJ1NXLZXxUkO1xNaNeEhuWXAI5kT3YYkx6U0IVmIAZdELmFBozOSrNcxXo1I5Ftvsta
 hHLr84FHVXdi/TDF1WzFliJIyVy8iZPMOuR2yt7km9VhmOWDHldKoQArdSws1pDDY9U8
 jWbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+npbs/LDIaHHRegKWl6ftAShxowx/978FaqPO9sDtbF0W8fOYt6JKTuJPi7dr0MuLOAYuBg8/2YLyH@nongnu.org
X-Gm-Message-State: AOJu0YwmblBsfnPftImgv6GF+MM5FrRch0GeGuSJ/yAgdAmwq2kXnvFm
 P9zAYIJpwvORPr8SeptbIPPAYBp+o7tRYsKlQQXp8kUGr3odTuEWWJXL4S2y6svdVtLEwfprEeD
 XMipgHiSAKq+FlvqrayV2ZRONjno+Bx12iOpXfOYCnidGqBRKFPame3cp
X-Gm-Gg: AfdE7ckx+23fy1o32BTRZ+eyFLY3BzsTQUGubHBcbcqyktE46X7+U5ykbLXSpwhs5lZ
 M2eAxn5bxN6iHzTJOsJPNzJd4etgjhjJNMjGsEzNzHHriodmo+lfHngRO7QNuLdvFx33TpcUr/M
 xoRlJZsVtNdnWIlhNETappOZVIjFTNsW/dykkrbpzjsZXYX4Rstgv9L3Wd/yDKxbqf4VcSNfyYR
 Av7nHRMlucmk5xkZJdPSE2hAG6zwrOscDNZZ9t8I8bkphHytbhsTzDSt5Dj+/FBzKaDc71amkSF
 jUg8M+t1hC9fTQqR9HJIoSpbt+Mhf+VrDU8gEbfan3yJWNnwy+a0MI1J/HOk+ets0ZYkbi5byl7
 3n3c=
X-Received: by 2002:a05:620a:f0b:b0:915:87ad:d5b1 with SMTP id
 af79cd13be357-9293bb44956mr2770817485a.15.1782743096914; 
 Mon, 29 Jun 2026 07:24:56 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:915:87ad:d5b1 with SMTP id
 af79cd13be357-9293bb44956mr2770807185a.15.1782743096144; 
 Mon, 29 Jun 2026 07:24:56 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92600a87303sm2110073185a.42.2026.06.29.07.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:24:55 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:24:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH] runstate: don't move to prelaunch on reset if postmigrate
Message-ID: <akKAK598q8IRWd0I@x1.local>
References: <20260627122234.657179-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260627122234.657179-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jun 27, 2026 at 03:22:34PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> As comment says, runstate can change in parallel. We check
> for FINISH_MIGRATE, but actually migration may proceed up
> to POSTMIGRATE.
> 
> We should check for POSTMIGRATE as well, otherwise there is
> a race, if reset is in progress, and source may finish migration
> in PRELAUNCH state, which is unexpected for user.
> 
> Seems correct to handle POSTMIGRATE the same way as FINISH_MIGRATE
> in this logic, as POSTMIGRATE is continuation for FINISH_MIGRATE.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


