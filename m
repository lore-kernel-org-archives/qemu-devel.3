Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C49C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzENu-0000Pj-Sy; Mon, 31 Mar 2025 08:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tzENs-0000P2-J7
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:36:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tzENq-0007I5-Eb
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:36:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso41271565e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424612; x=1744029412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ise6kFs+Bk9HvZp8Y/NAwr6k28qs0LjsdtQM3/5aZRs=;
 b=YI4g999ldOwv2pi1XL9S5nO3vKW+C0tcK8WaYfv2mS0C04G2JtbC7mse6oK/cR5RUn
 Mk7txVuw2ZNZ9EyA5Y6QCwFYb8tIxxdxqentO3R0tw5TUBWVW6uX/Cj7Zj0NETmaFlcG
 F2rnGPEPXOYLPHNJTg1xKoEk7IYsa9CcWxF9EEaNFm35xHc9s5IyPbYCpapSXS4jYumf
 2LuCcQCL0yp7rbY/0Bbo22zpDh8iqF+1hTcMOy4X6j72UWnoZVo+1MTokXyi8Ra2WYfg
 fYwCQS2HBnep/AXicEnbeX5RidBZmE95CteCujkKFtZtqcdMO5DnKzHJysqgJlQ6PEYM
 sH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424612; x=1744029412;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ise6kFs+Bk9HvZp8Y/NAwr6k28qs0LjsdtQM3/5aZRs=;
 b=ZquzFlG8Y7ybVe4aE2DAMIJBtYYkXRWTsThw0L0fj8DT2l5w0M5K/inCDg0KIS80hd
 JsXqkYN91UeJWcVi3RmdmzFINwIp+YR9Tv+nkBYw29LWBpb03d1V/TXe1deyLVFc2j3/
 wqu+8nku7QS1dPpG6SoAi/msxZDJQuCxwpQM7oylhlv3QkDTj+80hMV9oW/kVmoBEWX1
 IFmfKeM70CjUxSGDNxwtijxLWcSOf+FEy1f1CETR1/jHY3lmfA7xCAuzu1T9sDGwttw9
 bwS59WZ8v82/QIhkTLQuju8PRM6Q0tV4lM2a+P7ilxT+CXHr7URPFRydbpMKEuKcPMPo
 yEKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbAq3cCBAWmAvTiA/1PgChocxQcFNHS5Qe7OoQTk0NJuJa976gDovEwMaYUctaOhdElorr3rJVnDVc@nongnu.org
X-Gm-Message-State: AOJu0Yyec4bbDkV0v+8om8R3UoEWsJ9JzlEnMtaWHAHs3VsgVpW8/osC
 MKNIigEv9v1pUs7v8ZBWnQQ75sUQoiuhe92P8RvYpTsGdyMz9/NhU70+H7LfwpA=
X-Gm-Gg: ASbGncteKFnd5PJZebJtKl4bHpZ+XoHTgGtw/4DoWOf2NgEw6T/cSBe5f4RBuWYnWIu
 atAwXbbR45Dfx6nXsAo/pOOaiHMJq3H3FjNLrBVrLT5awNtKCxQIjQZWQlVAp0/u4Ei9TXZ9CK3
 jWVFY5tHQN/Tby7WdLUJ0ilCraajh6Lz6uN8TULbM8krWH5mWJtcZb+wkWNoEzrL4FoXy985lgl
 we7aAc5oLqsKv8Fi7mVQaG135Ehp6j2gQIxjSi6NB1dCnytjNV9BT9qsbOlPBN4ABOFwBapEokf
 bI8XPfqPKecCxQce8aSEF7eWwsxQQNqEoeU8i0BO2bNvLB0=
X-Google-Smtp-Source: AGHT+IGISowd1iMuLNmrzCa8B/xCpLWjevxA2URko9uRdlwBGYeLcU6CR4bEnHadtTGpS4ZA1/RFWA==
X-Received: by 2002:a05:600c:4593:b0:43d:23fe:e8a6 with SMTP id
 5b1f17b1804b1-43db61e037emr74333555e9.5.1743424612045; 
 Mon, 31 Mar 2025 05:36:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff042bcsm119988695e9.28.2025.03.31.05.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:36:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BBD5D5F88A;
 Mon, 31 Mar 2025 13:36:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Rust VMM <rust-vmm@lists.opendev.org>,  QEMU Devel
 <qemu-devel@nongnu.org>,  virtio-comment@lists.linux.dev,  VirtIO Dev List
 <virtio-dev@lists.linux.dev>,  Bill Mills <bill.mills@linaro.org>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  David Hildenbrand <david@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Dmitry
 Osipenko <dmitry.osipenko@collabora.com>,  Matias Vara Larsen
 <mvaralar@redhat.com>,  Sergio Lopez <slp@redhat.com>
Subject: Re: Central repo for VirtIO conformance tests?
In-Reply-To: <CAJSP0QW6=SvLwkuTsZTKqCH9OQJdH8XV32hDZ9Z4o6AbCbOqiA@mail.gmail.com>
 (Stefan Hajnoczi's message of "Mon, 31 Mar 2025 07:58:22 -0400")
References: <87semtpjrt.fsf@draig.linaro.org>
 <CAJSP0QW6=SvLwkuTsZTKqCH9OQJdH8XV32hDZ9Z4o6AbCbOqiA@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 31 Mar 2025 13:36:49 +0100
Message-ID: <87msd1peam.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, Mar 31, 2025 at 6:39=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>> The unikernel utilizes rcore-os's no_std VirtIO drivers to discover and
>> initialize a range of VirtIO devices.
>
> https://github.com/rcore-os/virtio-drivers
>
> I noticed that VIRTIO_F_VERSION_1, VIRTIO_F_RING_PACKED, and hardware
> device support are missing according to the readme. Those are
> important features for real-world test coverage.

At the moment most of the testing is around feature negotiation so we
don't get to the point that we are need packed virtqs. However it would
be useful to upstream such support for their use generally - I know
there are some downstream projects that have stuff to upstream in due
course.

The original idea for the feature bit tests was to utilise the kernels
kunit framework. However that was outside the scope of what kunit which
is really focused on testing kernel internals rather than the HW
interface.

We did consider expanding the kvm-unit-test uni-kernels but that would
either involve importing kernel bits or a fairly big C re-implementation
of it. At least by expanding the rcore-os drivers we will have two
different driver stacks in two different languages.

> Or is the idea to use the unikernel for low-level device
> initialization and the Linux image for tests that do I/O?

So far the rootfs images get by far the largest coverage because they
can more easily trigger a whole range of conditions. While VirtIO is
intended to be OS and hypervisor agnostic Linux remains the system with
the widest and most functional coverage of the interfaces.

>
> Stefan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

