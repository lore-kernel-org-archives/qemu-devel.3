Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B51CAC5BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3F0u-00027h-8n; Mon, 29 Sep 2025 10:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3F0q-000271-Lz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3F0e-0008Qo-HW
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759156659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a8gD0i1Fk+fPeHePBG0bepSlaIiDsJf/xQ2vt97Bzzk=;
 b=fe6/9f56E5A1a3R3ogpzD4YfVpPu9HlWjV0cPLCFsHF8YoOz2S8GqcnlHegsaKRxjYGSEa
 oSHgvHhN4fDEXWAvVBJcOidQEL+8ifRsA+6JAXdQQACVDDmzWpxPKHWiQ3DaDO8BIK6F7b
 Du9qT2R2CBeHwJdBGKg84P00Mc6feb0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-T2g7RKzdNBuwV4tsNmFUsA-1; Mon, 29 Sep 2025 10:37:38 -0400
X-MC-Unique: T2g7RKzdNBuwV4tsNmFUsA-1
X-Mimecast-MFC-AGG-ID: T2g7RKzdNBuwV4tsNmFUsA_1759156658
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-78e5b6f1296so84425626d6.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759156658; x=1759761458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8gD0i1Fk+fPeHePBG0bepSlaIiDsJf/xQ2vt97Bzzk=;
 b=j+SlcD0k4j7Dlzry1LYBDv37xrqYE4ZjRmfs2vFPFpvmdP6ia4bVA0k9DuyYXZftKK
 WqyxQdyyCX6mEkmdiBNky/YBjo25fBztjg2+hy7z5uco0zfCEc+DyaxJAyOdcZodagox
 Z3c8R073aWTEg+nF2lRsntLT87sdOUCMgPb0vXWTpIimhI8JHbhgDKKm0n2CTOPpckSC
 NVH49fyzmx2lKxh7Jz6apMDp2UVY0gEwB4jMhGvAqfK062x0vUpzKeHlO35omy9ufzDd
 uVBd2fM3MvLLpjuHkSyai7tJpu35dyAjssI+K/nTYcoc6VHhEOcwmGClGOIb05kER7pY
 G6lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Q7ismPSLkHeDhwhlBiaDV5c/5kzqDJiGj8SV2RU7Uniz4h+K/6R6zB0f4ziW6kFjqWjROp22nwn+@nongnu.org
X-Gm-Message-State: AOJu0YyFowhY5dCJi9JlhePqgiC6B+Gufv/nWIZkoIQD2pqMp3Y2vAtb
 C4b8sj4w3N+cpgg4a1jFvtj7fkO77ljBrkMhwtKNTf/nk24PVOj/QNEkmwNMcOQd6lhPdUA0a7X
 Q/CfxMBL1FWem1g1nC62UsyCn3hAf+QFhJX7JDID7ZOAjGk6+kgRD5zlr
X-Gm-Gg: ASbGnctK1LftbT01BA7TorLCzS118/IenzHqhEe7Ehh9XP/6m5Xw4eXBLC/VkijUBXy
 IjfOExSE2x9rgXrQalfKmSLCpLt8QkhsLmTfCqx90ltSs+EjZPfI3C8LJB/aj1a/Ehg5+wjx4dN
 vLUz13q9FFDU0IQrEE7L7xBZFtpcQ8bGihWb2D9TfLW0tCSjyK4SoWvLOMjRLeZL8nX28cf+XxF
 /2NrfIE+LR+tpiVMaGvp3YB7yyNxYysIv3ns/EdM+1UZSOUdNcwdZB9I5ur6lasKHT8RXQm+xkc
 aXqj4imJvs00Nf2NeJaHpZDxO7/gMwb+
X-Received: by 2002:ad4:594c:0:b0:785:c20b:f602 with SMTP id
 6a1803df08f44-7fc4515b7f1mr227612686d6.61.1759156657571; 
 Mon, 29 Sep 2025 07:37:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh5AwldQG7h3lDp1rao1YTszKy98M3ZiyEHYnc3TUgJws8RB3MU+/Oe1qxHX5YhmL7kQP7Nw==
X-Received: by 2002:ad4:594c:0:b0:785:c20b:f602 with SMTP id
 6a1803df08f44-7fc4515b7f1mr227611766d6.61.1759156656842; 
 Mon, 29 Sep 2025 07:37:36 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80135b5462asm76059506d6.13.2025.09.29.07.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:37:35 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:37:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
Message-ID: <aNqZrEagWEQ-up-Y@x1.local>
References: <aMHxhTIw2EGRyD4-@x1.local>
 <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNMjetBDJfBiThl@x1.local>
 <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
 <aNRfHQoBgwBMjK04@x1.local>
 <CAFEAcA8wTsZiihr8-LKucTmeZwPBdnkdA-o3mUgaW1WzrADhOg@mail.gmail.com>
 <aNWgnBV-9p6UnsYT@x1.local>
 <CAFEAcA8qdWtdX0Xc0WAuT9eZsXbudV2g2=Da8pK6tEfytdMbpw@mail.gmail.com>
 <aNauXSMiP0LUWQ5J@x1.local>
 <CAFEAcA--K0=EJNNvj98i=ewGY=tN3u4S0+fNb9kJpYynzjHEhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA--K0=EJNNvj98i=ewGY=tN3u4S0+fNb9kJpYynzjHEhw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 29, 2025 at 01:45:05PM +0100, Peter Maydell wrote:
> On Fri, 26 Sept 2025 at 16:16, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Sep 26, 2025 at 10:09:29AM +0100, Peter Maydell wrote:
> > > On Thu, 25 Sept 2025 at 21:06, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Thu, Sep 25, 2025 at 10:03:45AM +0100, Peter Maydell wrote:
> > > > > On Wed, 24 Sept 2025 at 22:14, Peter Xu <peterx@redhat.com> wrote:
> > > > > > Side note: when I was trying to test hotplugs with i386/q35, unfortunately
> > > > > > I didn't really see when the address space was destroyed, maybe there's a
> > > > > > bug somewhere; I put that info into appendix at the end.
> > > > >
> > > > > This is https://gitlab.com/qemu-project/qemu/-/issues/2517
> > > > >
> > > > > I got blocked on that because I ran into a weird "I have some
> > > > > memory that needs to be freed by the RCU callback, but only
> > > > > after the callback has freed some other RCU stuff". I see
> > > > > Paolo made a reply on that bug -- I would need to get back
> > > > > to it and reproduce whatever it was I was doing.
> > > >
> > > > Thanks for the link, right that looks exactly like what I hit.
> > > >
> > > > I am curious if FIFO is guaranteed for RCU in general, or it is an impl
> > > > detail only specific to QEMU.
> > > >
> > > > The other thing is I feel like it should be OK to reorder callbacks, if all
> > > > the call_rcu() users can make sure the rcu-freed object is completely
> > > > detached from the rest world, e.g. resetting all relevant pointers to NULL.
> > > > With that, it seems the order won't matter too, because nobody will be able
> > > > to reference the internal object anyway, so the two objects (after reseting
> > > > all referers to NULL pointer of the inner object) are completely standalone.
> > >
> > > The specific ordering problem for cpu_address_space is that
> > > there's a g_new allocated array of memory which contains
> > > the AddressSpace objects (not pointers to them). The ASes need
> > > to be RCU-deallocated first so they can clean up their internal
> > > data structures; only once that has happened can we free the
> > > memory that holds the AddressSpace structs themselves.
> >
> > If it's about cpu_address_space_destroy(), then IIUC it can also be done by
> > providing a destroy_free() function so that instead of trying to serialize
> > two rcu callbacks, we could easily serialize the operations in one
> > callback.  One sample patch attached to avoid relying on order of rcu
> > enqueue.
> 
> I figured out what my problem was here: like the existing
> cpu_address_space_destroy(), it wants to first destroy the AS
> and then free the memory the AS is using. So it does the
> obvious thing:
>     address_space_destroy(cpuas->as);
>     g_free_rcu(cpuas->as, rcu);
> 
> This doesn't work, because address_space_destroy() sets
> up an RCU callback using the 'rcu' node in the AddressSpace
> struct. But then g_free_rcu() tries to do exactly the same
> thing and overwrites the info in the 'rcu' node: so we never
> call the do_address_space_destroy() hook.
> 
> (1) Is there some way we can make this "tried to use the RCU
> node twice" assert?

Good point.  Maybe we should assert node->func==NULL in call_rcu1().

> 
> (2) I think the simplest fix here is something like the
> patch you propose that does the "destroy + free" in one
> RCU callback.

Yes, I agree.

Note that Akihiko has another series to QOMify Address space.  This problem
should be relevant there too. Currently I believe it's similarly broken in
his series, but I think maybe we should fix this first on x86/arm hotplugs.

Thanks,

-- 
Peter Xu


