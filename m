Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346EBFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIIA-0003he-JY; Mon, 27 Apr 2026 05:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wHII7-0003fy-BG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:30:11 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wHII4-0007f1-4y
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:30:10 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7dc85b74so753934a34.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282206; cv=none;
 d=google.com; s=arc-20240605;
 b=GGlH0jJNZBnc0fe1+SA/n10QX4mVM6w6mq5gfVZfBpw5FTK9NgQGUOExNvvA1yqCVw
 xVDfhVHRFC3i1dNtwwG3D+/1OK5nUfNpcsqSSQ+Vq2+Liglkkrd22uIA680OIXVYQ7Hu
 A1IErYhFv29k/i8bWTImVW+Y4r43VDioRD7RCKHKwr35Dskk7VYwSNj4/9hMbEy5Fw4A
 Wt3MXOB42xERQ2d9y19khc/dvSX/YrG/DVJk7zL1tqKBSWqaGKPsMiOWHrbhH8SBo15r
 GkCMWEmIXAd3KSSLWfelo3AR/9g9YMiuIf/O7Cq+PX0bF9jAfcct3lTvMX7IP6U7kuun
 iYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sOLOqhXzMZOcqwioz4oNOOigWxocU0J8gqXyK7oPzBk=;
 fh=pvXPmE7lJGhM7Fy9xFTtHT4WT8l0mLf3K85Bz3/XsNw=;
 b=EARTv/5QutT7x+TKEn8MvHyZiZinjR9RhNpNBWsQ+cekcb9oYNT6GMGurQalrQthwn
 ucJW7nuiuON4qXbrUfi417I3Wz1TadTLKJE7SnEY663IuLwNvMatpEu7TEar7rbq83Ct
 A2oEOL++jrsV/6K6I7UyDOxRAPtxtGM5B/qhO0UkcCxP4+ouwKn8U0LW8v5GEzOyvHhf
 V8w+lNodbcSdJtK8gVjikdzoLtcAt9TB/AP/++MYN11vVVNGk6hrtYCvMkN+wuzuYotj
 +ExwFz6RgA87FYXhg/yS9+/yJIbcV7CXj2056Eq4Ned2uyG0M4skIYcJthTN5OiUmImt
 aHKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282206; x=1777887006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOLOqhXzMZOcqwioz4oNOOigWxocU0J8gqXyK7oPzBk=;
 b=xBOkpJwPWTQsHXcX0HDf4ADy/6XdH432x2cjTXuk3bLhYUUtpy1js3mTv1tu48kT/u
 m+B4/HSJwkCL4VdrBknaVCauBaW8My9rV/qvmxk6ez8BEDHeQH1En4qVQf2H82iMXC8S
 oVjunfqmlVfiCMS2RSNo1f4d+M62/xyQMPVwSeTbf/LhVgpuC9YpI4PqcmkHwfu9qTv1
 +sI8wvQs8rbOglU+IAA4SyA4MyFugHXB4tntYaBSrXIYnCJitUl2FBRMYLDa8PlGbcfv
 vVamGhW0U6WMGh6vXgsbUOqr+y+9j8MagUO/YJp1y+2lj32jAhHB2/FDOWqi3CXJr1Hr
 mGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282206; x=1777887006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sOLOqhXzMZOcqwioz4oNOOigWxocU0J8gqXyK7oPzBk=;
 b=OA9mXc7p+dMCUVGXoFdRfB+Fn8uZxpew2k6hVcyWnUIfUpZVHQqe4HSIJSx4qu+aB5
 pDn+m7LZ4xctpgiXzHfCtM+pK7KqNx6lcDSfo8745cfd/hhANzS0mGqXgiyJsPqGi/bs
 GnE3FS7aoq3Nw70+Smy4UYvNOab0Z96DBATFBrsCDWRR4BKjT/Qb4Ufx7qYthR8eYXAL
 DqiNQPSgAUYrO75JD1IOsSHetadFxCRuMQEYndUHIqkqxmTpw2miph3uTgBnp+Tppg3j
 XxS1NsSjDxgE/GpMj6CRTHFuF3GnTbfXMkkELudTbwILy87NHXK7T7CRUsvqQJi+Y9bB
 Cpxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/H3RKAveESrsatjFghAQZR/xJDya0BwsUj6zRZKVRERAJe+OaXtie96K9FbeB/jafH8E3XuWSL1Ksa@nongnu.org
X-Gm-Message-State: AOJu0Yw0j2qsTeV0qutrnyVZ4DL/gUbOxPJcymr1mMU4D+4bEPngCp2R
 2N+paV1TJSWL98aiyCEymdk2XkPWRseMJkDkm3Tu/j8/Cg8gHKH/VzXfo0Gy3fmsYatZTNHV+1V
 yUPmGbuiersSjhTgZy6G0MR8mIxcsBN2gJrY/BIInog==
X-Gm-Gg: AeBDiesWuni5lxBxsKCfhY+DtUTwCPJXpYArCJ1qcrloSskD+zN2AKux9bVIKRMwtR6
 hNAcjxXmp+AzYIYi/7JzzH8frhhH0p/W0QO8pZaMbHWnF06pQZYeoeNLikqYyD64NsogLY6BnkY
 i9zwbgm5AanrlcwzrZ739+vR/Cj2kXXPiikX8DtAeJceJDrsz3mkaXrSCVJdB2nZNSH4BdoJTDA
 XsyVP8CNmKPk0Q8dVXpQp323KEJFe15MTh0dfvmxRc6vXreJ+aoc+5sYyye9iY0DMf7F6RTZQhs
 9hMaU+Z0LeB9QXtytg==
X-Received: by 2002:a05:6820:4ccb:b0:67e:366b:a2b0 with SMTP id
 006d021491bc7-69462deeaa1mr23822428eaf.7.1777282206354; Mon, 27 Apr 2026
 02:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260331140347.653404-1-cohuck@redhat.com>
 <85948999-6dcb-4f36-8450-ab74ebb35e3d@linaro.org>
 <87h5owsw0k.fsf@redhat.com>
In-Reply-To: <87h5owsw0k.fsf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Mon, 27 Apr 2026 11:29:55 +0200
X-Gm-Features: AVHnY4KkwaIc5zAV5txSmiqZzLuEpxvetoq6gECyFpbDABWnGu9SWheu2B0YV3E
Message-ID: <CAPMQPE+_93tMXbvVyjmVR71C6xVtx=PR6uFYtYGT7jefurgLXg@mail.gmail.com>
Subject: Re: [PATCH for-11.1] hw: add compat machines for 11.1
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 27 Apr 2026 at 09:27, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Fri, Apr 24 2026, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrot=
e:
>
> > Hi Connie,
> >
> > On 31/3/26 16:03, Cornelia Huck wrote:
> >> Add 11.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> >>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>   hw/arm/virt.c              |  9 ++++++++-
> >>   hw/core/machine.c          |  3 +++
> >>   hw/i386/pc.c               |  3 +++
> >>   hw/i386/pc_piix.c          | 13 +++++++++++--
> >>   hw/i386/pc_q35.c           | 13 +++++++++++--
> >>   hw/m68k/virt.c             |  9 ++++++++-
> >>   hw/ppc/spapr.c             | 15 +++++++++++++--
> >>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
> >>   include/hw/core/boards.h   |  3 +++
> >>   include/hw/i386/pc.h       |  3 +++
> >>   10 files changed, 76 insertions(+), 9 deletions(-)
> >
> > I'll take this patch in my next PR to avoid another conflict
> > with your tree.
>
> Yes, whichever one goes first.

Merged as commit 1bfa19a3fd5!

