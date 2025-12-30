Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D00AEE4988
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 16:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaco9-0000Zf-1B; Tue, 30 Dec 2025 11:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasha.tatashin@soleen.com>)
 id 1vaco7-0000ZT-VB
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 11:42:51 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pasha.tatashin@soleen.com>)
 id 1vaco6-0001RY-Bf
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 11:42:51 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64b8123c333so14868263a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=soleen.com; s=google; t=1767112968; x=1767717768; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUx1dwRpB9x+C+GHXgrsd6etfsxRhj2Yi9akRYZPEpQ=;
 b=KkKh/MGF5Xe5IhJm5NIPvsTnyRNRgLItoWPhhO+xDH4ZFpZA4O45iCzHskL6/NlGFM
 zvCWgriYLl4JCGxZc7P0brP5AlKLm7S82uJL8SFnP8pBtlesf2PsH1ITQuUXqZZ4jOmZ
 0bPMel1TFDSVDnyIUXS8Esx84vSxMtrpLYbwqEbI150DLk436VcRAaRdqYIlUMs7bvsb
 LhwSkzCXMeFe/W5GA7/H33OSmAF5AACOdQDmbLR9kCbTRwoFezmDJh6/RtdeD1pfdsmL
 aqAUUt4czBW+sU2ZD5cVa8py1R7pAYWbS7ARoB4rvOb51QJmsqhD7CA5tHoYFiiM8hQj
 az9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767112968; x=1767717768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aUx1dwRpB9x+C+GHXgrsd6etfsxRhj2Yi9akRYZPEpQ=;
 b=rcAfMAUdZUuO2csxi05sInINCVx4Pr3yXqC4wV43smAwxffEHSBANMsDiTEku10GPW
 +zWJrfzfawkanp9Dc6TKyX+jrd65NGkHZyQRDydhIlfYaoxm1nr3cRxoYZZEsuBOpvV+
 pEKBfFvP1Neie1c35eBp7d0zknPLvanWYEJ9TV3oFaOvTgblHxAb7+we/YnRRafswedm
 vt5mZtm5YLSVWEwrs2ikQMrRmD/G9JojQ8IhGFyhrHiKsamM8viS9ryLz59cUv4kRAcC
 mB0UfmmX8cGa5hULk4KHFMgV+yAMqBRSjj1LtUnxJBTHbcAlnrtvA1TEyZd6Yt+zR4mT
 EoyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmdr5bzF8/+GShbGn3gUxRlnfq0HPOKzX2j7zYLxgc8qxny2ToPbAGpUETYTxVSOFqWFeK8dxXprJh@nongnu.org
X-Gm-Message-State: AOJu0Yx/X8s7zLM9OFZ+XtSCT9PG61YJa2VMrs+8J7cWMsgwi8wmQFDC
 w80Z4tlx6zlmAN4ilr0M87a/iHmwBY/MH2tkJh5tFugtBu35AsqDW8sysQXtsHbHYWrLZjIT56J
 837anYPsNEsTYAW+UKaqywwEiqP7mmnwishuPF8W2SA==
X-Gm-Gg: AY/fxX5x9ZtL4cEE3FmAYc99+Pl81hvUtct0dK89SRzUJPugk1wiJVCeWwGa8NRCeo1
 FigcDJf0Tt+wXlDEx2NnGqbCVUoQdmF4tYVpj+Np0iC9ydp47xPl9emeSa6PJeuRIjLe5wI1t8i
 R00t6bNZqKfv4RemgUn/fx4e4jR2v7YBNdMmASNUbamehol/8AWi3uQ2F6weptrUs8gTv/UGXPp
 K+eSvZ+66S7MTFzQWZuBAoFT6zaFmxn4f88NFCgAdheFTA2xStIf2m+hiANFxnlcbwdCuse3cz2
 Iw9SzmyNjs4uN7P0VelmM9gnPg==
X-Google-Smtp-Source: AGHT+IEalSwHXlSyP0XIVEIOS0vVwiNaX3KH41ieJB+8/YYSB0lKoi0vJB6BuvETI8wSKFNZEjcgFjJQ/GJe+QmQlGM=
X-Received: by 2002:a17:906:f58f:b0:b7c:e4e9:b10e with SMTP id
 a640c23a62f3a-b8036f5aa24mr4010245766b.18.1767112967776; Tue, 30 Dec 2025
 08:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20251229120839.89817-1-me@linux.beauty>
 <CA+CK2bA1Xv+asZ3d2jALk+VePDdDg+4ao0Y72CWV2i0rg3GsyQ@mail.gmail.com>
 <19b6e60dfd2.187d822f1751681.8912147399180739154@linux.beauty>
In-Reply-To: <19b6e60dfd2.187d822f1751681.8912147399180739154@linux.beauty>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Dec 2025 11:42:09 -0500
X-Gm-Features: AQt7F2oM-pg5mgu9YhN6e53Vv0e13rpVZEhhUkpJI8x-6pPd4Yj3Dmd_GE8ChvE
Message-ID: <CA+CK2bC0N7v7MnC6LybAzE_oJPWeWK0v9xVng-JgEnvC6ay+nQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] CPR: shared RAM with /dev/fdset for LUO kexec reboot
To: Li Chen <me@linux.beauty>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, David Matlack <dmatlack@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Alexander Graf <graf@amazon.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=pasha.tatashin@soleen.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 30, 2025 at 3:30=E2=80=AFAM Li Chen <me@linux.beauty> wrote:
>
> Hi Pasha,
>
> Thanks for the detailed clarification, that's very helpful.
>
>  ---- On Mon, 29 Dec 2025 23:50:35 +0800  Pasha Tatashin <pasha.tatashin@=
soleen.com> wrote ---
>  > Hi Li,
>  >
>  > Thanks for the series. I have a few comments regarding the interaction
>  > with the LUO agent and the broader architecture.
>  >
>  > > In the LUO/KHO update flow [1], a LUO agent coordinates a host kexec=
 reboot
>  > > while keeping VM RAM content intact. LUO creates the guest RAM backi=
ng as a
>  > > memfd and passes it to QEMU via -add-fd on the initial launch, so th=
at
>  >
>  > I am currently working on the LUO agent (LUOD) documentation, and the
>  > intended behavior differs slightly from this description.
>  >
>  > Rather than the agent simply passing FDs, the design involves LUOD
>  > opening /dev/liveupdate and creating a UDS socket (e.g., at
>  > /run/luod/liveupdate.sock). Live-update-capable clients connect to
>  > this socket, create a LUO session, and preserve their resources into
>  > that session. Once all clients notify LUOD that they are ready, LUOD
>  > performs the kexec reboot while keeping /dev/liveupdate open, ensuring
>  > the LUO sessions survive.
>  >
>  > After the reboot, the restarted clients reconnect to LUOD via UDS and
>  > request their preserved sessions. The sessions are passed as FDs back
>  > to the clients. From those sessions, the clients retrieve the
>  > resources, restore them, and resume suspended operations. Finally, the
>  > clients "finish" their sessions, fully reclaiming ownership of the
>  > preserved resources from LUO back to userspace.
>
> Ack, and sorry for my cover letter text over-simplified the design.
>
>  > > memory-backend-file can use it as the shared RAM backing. On update,=
 LUO
>  > > checkpoints QEMU, reboots the host kernel via kexec, and then re-lau=
nches QEMU
>  > > to restore vmstate while reusing the same preserved memfd-backed RAM=
 FD.
>  > > Today LUO only supports handing off guest RAM via memfd [2].
>  > >
>  > > To re-attach that preserved RAM backing without reopening non-persis=
tent
>  > > paths, QEMU needs to let memory-backend-file consume the pre-opened =
FD using
>  > > mem-path=3D/dev/fdset/<id>. However, memory-backend-file currently u=
ses
>  > > open()/creat() directly, so /dev/fdset/<id> cannot be resolved throu=
gh the
>  > > fdset mechanism, making this workflow impossible.
>  > >
>  > > This series allows /dev/fdset/<id> for file-backed RAM, documents th=
e setup,
>  > > and adds qtests to validate that x-ignore-shared keeps RAM transfer =
minimal
>  > > in the cpr-reboot path.
>  >
>  > Sessions become particularly relevant when we look beyond guest RAM.
>  > For complex resources like VFIO or IOMMU, simply passing the FD is
>  > insufficient. These resources require specific ioctls to be issued by
>  > clients after the FD is retrieved, but before vCPUs are resumed or the
>  > session is "finished".
>
> One question: in the intended LUOD/session architecture, do you still exp=
ect
> clients (or a wrapper) to inject the retrieved guest RAM memfd FD into QE=
MU
> via -add-fd + /dev/fdset/<id> at QEMU startup? (as this patchset does)
>
> Or is the longer-term plan that QEMU itself connects to LUOD over UDS, re=
trieves
> the session/resource FD directly, and consumes it as the RAM backing with=
out
> going through -add-fd?

The latter, I expect QEMU and other VMMs use their LUO session FDs
that they receive from LUOD to retrieve and restore the preserved
resources: memfd+iommufd+vfiofd and resume the suspended VMs.

>
> If the latter, I think we'd likely need a QEMU-side interface to
> consume an inherited/pre-opened FD for RAM backing during early machine i=
nit.
>
> Regards,
>
> Li
>

