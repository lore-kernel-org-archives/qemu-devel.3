Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9F4CA0EE3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 08:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umTcV-0004kk-Md; Thu, 14 Aug 2025 04:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1umTcT-0004jf-Iq
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1umTcP-0007Ou-S8
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755161247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yDCNqfpNLuSsU5r86do4gtj/UKYg37bc0CFiMJNQQw=;
 b=ZYL7LBOKxPPmxGA6Y07dEopl+wIRu+519oAcXQLXNKE3NTbuZe0/URLpCYLIk5iN6ehlZF
 iL2Q8PFrzHiysv9R7WvesIS4bIoknf8egciOqH++vJqKccYtD89oZ8j968SBg7IguCRTAx
 NGZpbcRUhUgZBgIxSgUBNnqfoh+T9i0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-AAmtzHwNMbShopyUd1SgTw-1; Thu, 14 Aug 2025 04:47:25 -0400
X-MC-Unique: AAmtzHwNMbShopyUd1SgTw-1
X-Mimecast-MFC-AGG-ID: AAmtzHwNMbShopyUd1SgTw_1755161244
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-244581950a1so8658845ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 01:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755161243; x=1755766043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8yDCNqfpNLuSsU5r86do4gtj/UKYg37bc0CFiMJNQQw=;
 b=AnXauxyuLLhkkDHYB5t0NaBKRznlibXlALNiYRoTXtCV4INwhaIQuAc8E3SYwdmTD5
 TWbkXHYS6Vn5kGGWGfKekNSqMq7B1p1iG1Qwfds3xIzQ6BFnTLHb4VhsURj06E+gcZXy
 +joiLaGGy0lJeAjH6Q25+dTM8lLDRCmfVMjL3fyKyHnR2/qe1gK/BIfn//LhV5vJ/Ugg
 uHne0XWUieEhSAIW4UQqvcj3+Ur0EuqiJGQO60NWUuC5hgXEGdsXzIBfux/Dh/0/8PyS
 g7zPaw1FiSnJN3VLw0exX2W5tj+kbByyC86y+14ubel0n+b+O0J54fNxsR/NZ6yeRM25
 e+Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjh3d0qJE1XE/XF8VU/GTZfZRgO+iFaf7dbch+JX7BtN03Ev/5N13XKOhQt71qC6/chOYEo0bKjyWo@nongnu.org
X-Gm-Message-State: AOJu0YyXrgNqlupL4zvqsqH/8kAwXZjGa+cGAw0J+AX3x0s8qIElu8v9
 HUKu5G9EEKHCRurVTuJdOFEmS1CoGI3Xv9TF/1uICLygonm8hc8l4NFrdvrbO1UNyemdTuL5hSR
 rKIOj0hu/+wp+UqJYGo4+m/rR6azDpOJFYdJncVb2ZnDFRpLmNtVTQ+62hEJIO88jBPApkP+FvX
 avgQTX3/d+u2iq90R7Ryap6yxDjHIpJDRbx+6QXHU=
X-Gm-Gg: ASbGncvKMCuERR2I5M5xMArW9QVoZFmhSHmdPRb3h7J1/ZiIyftDTeLQXqVV86lVYYQ
 5okUpVdWdL9tCTCfvyeDOwofLKrS7aTcPByUwszCqwNKmO4NyN7pNkgHA93Td4A82qNt1jxEA+/
 bHFCUTOoVSoz6Sftud22la
X-Received: by 2002:a17:903:2c8:b0:243:7cf:9bca with SMTP id
 d9443c01a7336-244586ed222mr28952955ad.55.1755161243285; 
 Thu, 14 Aug 2025 01:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtVdKSUtWMr+nM4drzy1n98jbsHs6b5heX1hfb0OzHfKDXSCZFTRXE/nDBVTxH+gdYXSgxbQGcloutWMlCqKI=
X-Received: by 2002:a17:903:2c8:b0:243:7cf:9bca with SMTP id
 d9443c01a7336-244586ed222mr28952765ad.55.1755161242861; Thu, 14 Aug 2025
 01:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250805081123.137064-1-aesteve@redhat.com>
 <aJO3ywz2Ej_kToU_@x1.local>
 <6c254144-a5ee-4536-b0a1-844fb5281b7d@redhat.com>
 <CADSE00L=qrAffQYfkCLg5W=OVv9cr+m6QxVO=if4q1wFdBFxuQ@mail.gmail.com>
In-Reply-To: <CADSE00L=qrAffQYfkCLg5W=OVv9cr+m6QxVO=if4q1wFdBFxuQ@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 14 Aug 2025 10:47:11 +0200
X-Gm-Features: Ac12FXwTBsspSBRHPR-9XEqnatA2OuZpCEn_2G_raAmHSqD1q9-uKB67HOltWWE
Message-ID: <CADSE00J0xx4bBNaOtbNkrBgZgkwpy4HxhfTHcbnEKc6FH0Vvew@mail.gmail.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 7, 2025 at 9:22=E2=80=AFAM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> On Wed, Aug 6, 2025 at 10:36=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 06.08.25 22:15, Peter Xu wrote:
> > > On Tue, Aug 05, 2025 at 10:11:23AM +0200, Albert Esteve wrote:
> > >> v1->v2:
> > >> - Added documentation
> > >> - Explained the reasoning in the commit message
> > >>
> > >> In the last version of the SHMEM MAP/UNMAP [1] Stefan
> > >> raised a concern [2] about dynamically creating and
> > >> destroying memory regions and their lifecycle [3].
> > >>
> > >> After some discussion, David Hildenbrand proposed
> > >> to detect RAM regions and handle refcounting differently.
> > >> I tried to extend the reasoning in the commit message
> > >> below. If I wrote any innacuracies, please keep me
> > >> honest. I hope we can gather some feedback with
> > >> this RFC patch before sending it for inclusion.
> > >
> > > This seems working.  Looks like so far all RAM MRs are fine with it, =
but
> > > I'm not strongly confident it's true or it'll trivially keep true in =
the
> > > future too.
> > >
> > > Besides, this still adds some trivial complexity to memory_region_ref=
() on
> > > treating RAM/MMIO MRs differently.
> >  > > It also sounds like a pure "accident" that the shmem objects to be
> > mapped
> > > from the vhost-user devices are RAMs.  I wonder what happens if we wa=
nt to
> > > also support dynmaic MMIO regions.
> >
> > Is this use case realistic?
> >
> > If there is a reasonable way to prepare for such hypothetical use cases
> > them while solving Albert's immediate use case, I'm all for it.
> >
> > >
> > > Would this work even without changing QEMU memory core?
> > >
> > > For example, have you thought about creating a VhostUserShmemObject f=
or
> > > each of the VHOST_USER_BACKEND_SHMEM_MAP request?
> >
> > You mean, adding an intermediate object that remains the parent of thes=
e
> > MemoryRegion?
> >
> > Could work. To free a MemoryRegion, I guess we would unparent that
> > intermediate object, and that object would then free the memory region
> > -- unless something still references that intermediate object. Not sure
> > if the memory region might keep the intermediate object still alive (no
> > idea).
> >
> > Certainly something to explore, Albert, can you look into that?
>
> Sure, I will try this. Thank you both for the time and help.

I did test this approach with a rust-vmm modified backend
and the buffer were created/destroyed correctly.

I just posted the version 6 of the SHMEM_MAP/UNMAP patch.

So unless there are other issues with the other patch series
implementation, I think we can discard this RFC.

Either way, thanks for the feedback and suggestions!

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >


