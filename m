Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D42C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 19:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sifbV-0000cX-OG; Mon, 26 Aug 2024 15:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sifbT-0000Yf-FD
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sifbP-0000SS-2i
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724701330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=boFz7/tNpSvKRWQqI5iLbO5Vr5fl7hKnlbrJL3JKvYI=;
 b=dAuslKT88A6Rwu40R2qCEh2AZ1M4sb+deb9fizvtT/oRYBp1rYSnB8JTNXUCyxVOdQD2CD
 6ZOfyVfPJQq9O+6svvo256nb6bRW/oeGasrclpjYjbFVi8y3FwqXqG951kTqG4vnPHpcVO
 S77O3xnq0p6AYzJs3XiFvsnr+QNJFLM=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-rMsyRtl9O7-IVI62LVuFRw-1; Mon, 26 Aug 2024 15:42:06 -0400
X-MC-Unique: rMsyRtl9O7-IVI62LVuFRw-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4fd04abe4a4so934921e0c.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 12:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724701326; x=1725306126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boFz7/tNpSvKRWQqI5iLbO5Vr5fl7hKnlbrJL3JKvYI=;
 b=J7in2zWppqyh2T7Z+cf9ndFNPpNc7k4uNQGKlbtcMk1VpBOITW37GfvO5eALW+h7Kj
 gVoaUCIx10pFiZ949nCiqehKdUUfXPpeJR4R8dRcl43EnsFP8IiNSfP7xWBbcNUdEQGL
 AzVVSrp8FNuRpGGnj0Rq/L0fd8ZhuGH7qSYbNqZBL8gkkeSsqPF3Acb4NU82BGF4I1Zi
 66KeA9xftJ2qYPVWK+UiJDwW31h+bK0U8CCsmquRppUaGpqCdMfcYZkHkdV/lpHeFyLo
 hLq5tIp7y4NmMvN9sD78IZl6QJTRdIwbta2kxO5CO5e1e3wXCTitOh/eLRASdQsYSGgA
 LS6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxGxPXMcBfaLMqmyiFM0B0IpAm0waY/GyJfs3B2pNLgHtJOkTkM/RdQCfx06aJl3CfyWBSVHeP4Qe3@nongnu.org
X-Gm-Message-State: AOJu0YzUVlCzTXspM94/TLlDtJ2Gu5kY/Qg0uQxlvy+O5j0iooGyXnMF
 kCIdArlRZHwWpLjiivJ95Ejbc6OiLCJq5mX2Zoa4jplGr4gXv1YwUmSZHyIYkRlYQirj+QCkRT/
 aIxe6tu3q+jO/Gtc9+yyeWN1uK/hjOhbrp3XiA+zUpR8D9/C39YVw
X-Received: by 2002:a05:6122:2205:b0:4f5:202b:6220 with SMTP id
 71dfb90a1353d-4fed5a8c626mr1150233e0c.0.1724701325873; 
 Mon, 26 Aug 2024 12:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnLa7RFFj6tXWaOBm/X1pO0jF4oDZKkf1twY225qFJiWFvpM9FA7G2I0ucOPLoX76tlgwICA==
X-Received: by 2002:a05:6122:2205:b0:4f5:202b:6220 with SMTP id
 71dfb90a1353d-4fed5a8c626mr1150203e0c.0.1724701325481; 
 Mon, 26 Aug 2024 12:42:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162db09a7sm49673566d6.95.2024.08.26.12.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:42:04 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:42:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 6/7] memory: Do not create circular reference with
 subregion
Message-ID: <Zszain3SH5cl9ohH@x1n>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-6-a24c6dfa4ceb@daynix.com> <Zsydli9ME1u79A9X@x1n>
 <CAFEAcA_uT3Db22V=Anqci_k6zOaAV7Qua2S1OVFxW_DQyh3bAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_uT3Db22V=Anqci_k6zOaAV7Qua2S1OVFxW_DQyh3bAA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 26, 2024 at 06:10:25PM +0100, Peter Maydell wrote:
> On Mon, 26 Aug 2024 at 16:22, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 23, 2024 at 03:13:11PM +0900, Akihiko Odaki wrote:
> > > memory_region_update_container_subregions() used to call
> > > memory_region_ref(), which creates a reference to the owner of the
> > > subregion, on behalf of the owner of the container. This results in a
> > > circular reference if the subregion and container have the same owner.
> > >
> > > memory_region_ref() creates a reference to the owner instead of the
> > > memory region to match the lifetime of the owner and memory region. We
> > > do not need such a hack if the subregion and container have the same
> > > owner because the owner will be alive as long as the container is.
> > > Therefore, create a reference to the subregion itself instead ot its
> > > owner in such a case; the reference to the subregion is still necessary
> > > to ensure that the subregion gets finalized after the container.
> > >
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >  system/memory.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/system/memory.c b/system/memory.c
> > > index 5e6eb459d5de..e4d3e9d1f427 100644
> > > --- a/system/memory.c
> > > +++ b/system/memory.c
> > > @@ -2612,7 +2612,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
> > >
> > >      memory_region_transaction_begin();
> > >
> > > -    memory_region_ref(subregion);
> > > +    object_ref(mr->owner == subregion->owner ?
> > > +               OBJECT(subregion) : subregion->owner);
> >
> > The only place that mr->refcount is used so far is the owner with the
> > object property attached to the mr, am I right (ignoring name-less MRs)?
> >
> > I worry this will further complicate refcounting, now we're actively using
> > two refcounts for MRs..
> >
> > Continue discussion there:
> >
> > https://lore.kernel.org/r/067b17a4-cdfc-4f7e-b7e4-28c38e1c10f0@daynix.com
> >
> > What I don't see is how mr->subregions differs from mr->container, so we
> > allow subregions to be attached but not the container when finalize()
> > (which is, afaict, the other way round).
> >
> > It seems easier to me that we allow both container and subregions to exist
> > as long as within the owner itself, rather than start heavier use of
> > mr->refcount.
> 
> I don't think just "same owner" necessarily will be workable --
> you can have a setup like:
>   * device A has a container C_A
>   * device A has a child-device B
>   * device B has a memory region R_B
>   * device A's realize method puts R_B into C_A
> 
> R_B's owner is B, and the container's owner is A,
> but we still want to be able to get rid of A (in the process
> getting rid of B because it gets unparented and unreffed,
> and R_B and C_A also).

For cross-device references, should we rely on an explicit call to
memory_region_del_subregion(), so as to detach the link between C_A and
R_B?

My understanding so far: logically when MR finalize() it should guarantee
both (1) mr->container==NULL, and (2) mr->subregions empty.  That's before
commit 2e2b8eb70fdb7dfb and could be the ideal world (though at the very
beginning we don't assert on ->container==NULL yet).  It requires all
device emulations to do proper unrealize() to unlink all the MRs.

However what I'm guessing is QEMU probably used to have lots of devices
that are not following the rules and leaking these links.  Hence we have
had 2e2b8eb70fdb7dfb, allowing that to happen as long as it's safe, and
it's justified by comment in 2e2b8eb70fdb7dfb on why it's safe.

What I was thinking is this comment seems to apply too to mr->container, so
that it should be safe too to unlink ->container the same way as its own
subregions.

IIUC that means for device-internal MR links we should be fine leaving
whatever link between MRs owned by such device; the device->refcount
guarantees none of them will be visible in any AS.  But then we need to
always properly unlink the MRs when the link is across >1 device owners,
otherwise it's prone to leak.

-- 
Peter Xu


