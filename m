Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE8BC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 07:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujuxJ-0000hx-1z; Thu, 07 Aug 2025 03:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ujuxC-0000fg-Gi
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 03:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ujuxA-0003SY-N4
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 03:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754551338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZoqUMfuLr36jU4N7WyerqxicuBRGy8xhBE8b1n/ppg=;
 b=hnUiFM6ulICb4zYulGG2Fli5s2zyxvVeH+F9zGLdqssRFTrKLVrp7Bou4iZtM0+SFgA3fi
 tjD+yHumHvPIRxIxIRS6G6rYjxIWYHInUbp3qFlYfNxYg1/++qGbfYHY8PFWUv1U3mDQoQ
 zVognU+Sf2TzaxFH5K9SRKMv/AzWAz4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-DJm5CIY9PyCs2W0nLHWoNg-1; Thu, 07 Aug 2025 03:22:16 -0400
X-MC-Unique: DJm5CIY9PyCs2W0nLHWoNg-1
X-Mimecast-MFC-AGG-ID: DJm5CIY9PyCs2W0nLHWoNg_1754551335
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-242a1390e9eso14469145ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 00:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754551335; x=1755156135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZoqUMfuLr36jU4N7WyerqxicuBRGy8xhBE8b1n/ppg=;
 b=DfSjHmMWPauDMG1w2gWFn5cLyWFSNRJIZlQAaYWArnGchZbOmr1fnpw9YSzGiMMp5Q
 GnIY9lC0moa5M0TdGFHXg5SSPMcjltn6RIfFyvFTcilPeSCT8YiQWjczjp7s0sEoPTTp
 tahWXlHaPwfT+1MY6cPPfKvmEEdxUXnfOAU+W956/mVfNLHKBb1Nu3VBB5s6ChctZoFn
 UwCc2LYiDHHCsYdkM2CqB8V+imBXTPoxZAg0aZzRABuxPbpwu/ApvNAt47OMJt4Oj76K
 JOySPSAdMpXJu1MzfFNwmz9+sud26LzNjVbjfJKkcxRkQ42B2h98j1kHJj6u1CYsw6ME
 MSMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAzefZNaUN7p2npxCHBJSNFBCMa3OcsMw/0w2rFNOSeXRlMVTBR0GFITtH0DUfVL76G3C52iipK3lI@nongnu.org
X-Gm-Message-State: AOJu0YyCcrUXA4Of2P055YZ8YDb6gHnUXK+g5N1/aa+pMDW5FOtPonbe
 GX0PWK3lQDjSDOzEQVgPQdsvG1HIK5zw33xBHqEUv8CE9XvhvOLFnU7Zg+/Qbr4hTPcR4uDV4SC
 WVyAWKxOO/k8EgZSAtzR3aw/8nD5ihvWe2gTz7vdN10ugsClCesPMwYnln9jXE47pX1QPMxCKSs
 5BMkEFuYsLojC7PBDkOUeYbqRuIjUe+Lk=
X-Gm-Gg: ASbGncuArunMae7R9R3KQsr/75RuxjBxfSOomEOlnbnO+MKUYmC+BO0JXQjwYCLtNGo
 2MubgOLs61F+vJfoIowDk88DfwfxffdpoeSZX5RLU671XFphAytQcQxejF+J+1dfsN1ErVAfJXn
 TT/3dHnIufAKQ6WxKVYgvS
X-Received: by 2002:a17:903:1b4c:b0:240:14f9:cf13 with SMTP id
 d9443c01a7336-2429f5a47e7mr83038325ad.51.1754551335123; 
 Thu, 07 Aug 2025 00:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuISjJg6Y8skPxzkFfqcxymNaC6vtPIxt61N9unD4WjeNw/dHLkshylFxF9QTgQ3iNY2eZQK49fqZBaS7AbZk=
X-Received: by 2002:a17:903:1b4c:b0:240:14f9:cf13 with SMTP id
 d9443c01a7336-2429f5a47e7mr83038115ad.51.1754551334667; Thu, 07 Aug 2025
 00:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250805081123.137064-1-aesteve@redhat.com>
 <aJO3ywz2Ej_kToU_@x1.local>
 <6c254144-a5ee-4536-b0a1-844fb5281b7d@redhat.com>
In-Reply-To: <6c254144-a5ee-4536-b0a1-844fb5281b7d@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 7 Aug 2025 09:22:03 +0200
X-Gm-Features: Ac12FXwYg-P51b_wBolF5eQi-Ap4YtC6mgW2M53LEU7niYVyKw8E0ofjmtDM0zs
Message-ID: <CADSE00L=qrAffQYfkCLg5W=OVv9cr+m6QxVO=if4q1wFdBFxuQ@mail.gmail.com>
Subject: Re: [RFC v2] memory.c: improve refcounting for RAM vs MMIO regions
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 pbonzini@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 6, 2025 at 10:36=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 06.08.25 22:15, Peter Xu wrote:
> > On Tue, Aug 05, 2025 at 10:11:23AM +0200, Albert Esteve wrote:
> >> v1->v2:
> >> - Added documentation
> >> - Explained the reasoning in the commit message
> >>
> >> In the last version of the SHMEM MAP/UNMAP [1] Stefan
> >> raised a concern [2] about dynamically creating and
> >> destroying memory regions and their lifecycle [3].
> >>
> >> After some discussion, David Hildenbrand proposed
> >> to detect RAM regions and handle refcounting differently.
> >> I tried to extend the reasoning in the commit message
> >> below. If I wrote any innacuracies, please keep me
> >> honest. I hope we can gather some feedback with
> >> this RFC patch before sending it for inclusion.
> >
> > This seems working.  Looks like so far all RAM MRs are fine with it, bu=
t
> > I'm not strongly confident it's true or it'll trivially keep true in th=
e
> > future too.
> >
> > Besides, this still adds some trivial complexity to memory_region_ref()=
 on
> > treating RAM/MMIO MRs differently.
>  > > It also sounds like a pure "accident" that the shmem objects to be
> mapped
> > from the vhost-user devices are RAMs.  I wonder what happens if we want=
 to
> > also support dynmaic MMIO regions.
>
> Is this use case realistic?
>
> If there is a reasonable way to prepare for such hypothetical use cases
> them while solving Albert's immediate use case, I'm all for it.
>
> >
> > Would this work even without changing QEMU memory core?
> >
> > For example, have you thought about creating a VhostUserShmemObject for
> > each of the VHOST_USER_BACKEND_SHMEM_MAP request?
>
> You mean, adding an intermediate object that remains the parent of these
> MemoryRegion?
>
> Could work. To free a MemoryRegion, I guess we would unparent that
> intermediate object, and that object would then free the memory region
> -- unless something still references that intermediate object. Not sure
> if the memory region might keep the intermediate object still alive (no
> idea).
>
> Certainly something to explore, Albert, can you look into that?

Sure, I will try this. Thank you both for the time and help.

>
> --
> Cheers,
>
> David / dhildenb
>


