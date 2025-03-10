Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963C7C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgMI-0002NN-Fp; Mon, 10 Mar 2025 12:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trgMD-0002MH-I4
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:52:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trgMB-0005mu-9w
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:52:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so13217395e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741625517; x=1742230317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBQ/YVCUlvngj51gT+nGmhV/w3YqnO2x51QPa+teq/c=;
 b=hDfrE7SxOBc5OExLwwb8wJ1WAnB9aBKamTIFF0mybcb9fJv3UYXHXcrJxWTGBy3CdY
 pjBj6mp1d1bC0RNRF7x3TWLGyEv7Iu3yCd3u9ApoH/aQ98j5aUej47N8pBvT/2I+uHf2
 HKWaUxctR5EoNR/x9mIj8In6RFPIlUuOYe/mIbWwpyVXXD81NWsn6dAA62d4OZYSOmc4
 /nFpIfsfJz15lg1OICRLM54YjZB/7Wu3VMIMjK53ojg2JgEYa4f+Znb95KBeposg6PXZ
 Qoe5DCvLY4JCrOAKvaXB1HHfvtLK4fEowfj9D7x8DslwNA06vaooWxyiejFDu5YlzG5F
 TvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741625517; x=1742230317;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xBQ/YVCUlvngj51gT+nGmhV/w3YqnO2x51QPa+teq/c=;
 b=H94MUeNKim/WbZLXYR0m+rpLJWrQYf8t9ED+pFdxSNy7uH23659AL+QmaeC5gJL8av
 i7f0oyC/+t/eSngrq0m1r7aAWYwJ9rGsZj1MIuxRnaP7OSAaeOplWJIlxGoLqFr9rmG6
 mzp8laG7Paa/WyiZS4ynOkyoL3mc+JN+8X513fSIvWeQKFsWQsu9oh4h4J9sYvm6coG1
 /fEtpzRJXnwtVxdI0WmUUzXYTOvfmetvMAthaGCJ8d0ftnZPIYya4SIAzY7/OxuWozIW
 G/szArRgojQUXXeY52Ym4RtdqfXbfl7hoU8ALqeeBdH4mv6oAbOMrhjY6mPk2Hcnqewf
 ci+Q==
X-Gm-Message-State: AOJu0YwEGI5WqgxE1b97coX/O9kU+UX5kMaQ0UfAN2RElDx7mN/P7TQH
 gP0Ls9m1XT9x4piOPQs0+n4BnifNwL8q9nNT22P3Io0hMqMUJ4xzG1ANijAopBg=
X-Gm-Gg: ASbGnctjj2md+cZ2bhvmcb0SRBP+EtS0sCIoUOHiSD3isU8psCNeLhmc6m6pvSTETAq
 knrv8EiDJlD80i//Cfxr0SkxCv4s7U/5eLVs18kIIu28e+wFL2PLNnNqrnudVEvIeI/C847L/Vg
 jamD6p7z5x4hGXfPKwRB9nA9J1sN1bw37GzRwmg0pvJ1zHAEJSNp6qRMp6ufQKeFze9g7IoOVnL
 bOOJ3i8LuJoRNGTE1Cqhmlk/1unv9SKQ8C0RQh/K/GWVLDFGjB2WNc+XkQJscbYN9auiQlpozpJ
 3Z/bnwZyrjXyCU2Qyrifspy9CG31px00sysq73J9RpLh54U=
X-Google-Smtp-Source: AGHT+IEsbZZg+DwJcwND+qk6+cSg4ztQzlrOGXS1w4qnPv2Ub2nPuQOnkGbr6torseuO1NXZTpwciw==
X-Received: by 2002:a05:600c:5103:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-43c5a60eda3mr98405685e9.15.1741625516936; 
 Mon, 10 Mar 2025 09:51:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf27f8ef3sm55474135e9.11.2025.03.10.09.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 09:51:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 88A455F748;
 Mon, 10 Mar 2025 16:51:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Milosevic <david.milosevic@9elements.com>
Cc: qemu-devel@nongnu.org,  Marcello Sylvester Bauer
 <marcello.bauer@9elements.com>,  pizhenwei@bytedance.com
Subject: Re: [RFC] Proposal for a QEMU video subsystem for cameras and webcams
In-Reply-To: <CAFUY6-d5GZSrDzD0vUEF6P4YnstMjx=G3Q77iFGLt3eBUf5WUA@mail.gmail.com>
 (David Milosevic's message of "Mon, 10 Mar 2025 17:23:21 +0100")
References: <CAFUY6-d5GZSrDzD0vUEF6P4YnstMjx=G3Q77iFGLt3eBUf5WUA@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 10 Mar 2025 16:51:55 +0000
Message-ID: <87senk7rro.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

David Milosevic <david.milosevic@9elements.com> writes:

> Dear QEMU Developers,
>
> I would like to propose the development of a video subsystem in QEMU, wit=
h the initial
> implementation focusing on UVC video device emulation and support for mul=
tiple
> backends, including V4L2, GStreamer, and libcamera.
>
> This work is already in progress at 9elements, and we would like to upstr=
eam it.
>
> =3D=3D Motivation
>
> Currently, USB pass-through is the only way to make video devices availab=
le to guests, which
>
>     - excludes non-USB cameras (e.g., MIPI)
>     - performs poorly with high-resolution cameras
>     - does not work with USB 3.0 video devices (Issue #1613)
>
> =3D=3D Proposal
>
> We aim to introduce a video subsystem in QEMU that allows for the impleme=
ntation of various
> video devices, similar to how QEMU handles audio. The first device implem=
entation will be
> UVC (USB Video Class) device emulation, with support for multiple backend=
s. Future extensions
> could include virtio-video or other PCI-based video devices.

Are you aware of virtio-media? It was an alternative proposal to
virtio-video which effectively becomes an encapsulation of v4l to the
guest.

Kernel patches: https://lore.kernel.org/lkml/20250201-virtio-media-v2-1-ac8=
40681452d@gmail.com/
VirtIO spec: https://lore.kernel.org/virtio-comment/20250120085015.956057-1=
-aesteve@redhat.com/T/
=20

> Supported backends:
>
>     - Video4Linux (V4L2)
>     - GStreamer
>     - libcamera
>
> =3D=3D Example: V4L2 Backend
>
> Once implemented, a typical QEMU command line for using a V4L2 backend wo=
uld look like this
>
>     ./build/qemu-system-x86_64 \
>         -device qemu-xhci \
>         -videodev v4l2,id=3Dcam0,device=3D/dev/video0 \
>         -device usb-video,videodev=3Dcam0
>
> This sets up a UVC emulated device in the guest, using /dev/video0 from t=
he
> host via the V4L2 backend.
>
> =3D=3D Next Steps
>
> We welcome feedback on design considerations and integration approaches. =
Let us know
> if there are existing discussions or preferred directions for this work.
>
> Best regards,
>
> David Milosevic
> Firmware Developer
> 9elements

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

