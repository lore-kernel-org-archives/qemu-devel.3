Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B915EC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 17:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCiqe-0002Qq-2i; Wed, 07 May 2025 13:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uCiqb-0002QU-KT
 for qemu-devel@nongnu.org; Wed, 07 May 2025 13:46:21 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uCiqZ-00060x-Nj
 for qemu-devel@nongnu.org; Wed, 07 May 2025 13:46:21 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5faaddb09feso139932a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746639977; x=1747244777; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgMVa7sDt87N3TPcfQG+K6Uc7xbs9+98ICSsFeYihP4=;
 b=ZBK9LTn0V11ZL8aq9ERvknTFTAAoqFaywpmsfb/mN+lzhyppd/xdb3O4stHQ3QL/Bl
 LlKtwb3GRjV/bSaN65i0A2W4kkTF2V04eadSPM2Do3Ef9TPsgcIGRg+bPY0cQHVM+lKc
 TPq8jkWTGjn0A8+8eAKJr/hw6ZEycKkT2N92+V3OVt7hHxwrQ+kEpF1AC/LjOX3zqImg
 HdwB1vJFOhQfqwwFzRHtHbsh5qaK4BzII3DxKbLTy0LB5e0YPo1hEJlzty3cLNs7m5gb
 UgDDQrvAoiGsJux4MSVuH4LzGnxE4mtFOrGdG0uGJLvQ3Pj+bVpwbKjqOvU3O7+ya20D
 9aRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746639977; x=1747244777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgMVa7sDt87N3TPcfQG+K6Uc7xbs9+98ICSsFeYihP4=;
 b=WaF0dbZ4mg84qHbQN8DvBFpURsgTbKBaN6v8GZP1AMOTHoqQlgZXVB7qs044kk6W4f
 t4AWANZ0xD5sY2ITNEOORVj9zc3ovvuAnXmXGR3dVYmo9LJByaZV3JRs0GH1biy2TN+W
 tvOhTtqysG6SJOUyDGl06NQHffN3PaQE/Nca0Qwu6HTm+Fmy9BgZakfdFOkhNgLjJr9x
 5rLonNJnZ086XZSLKOUCMM0jVvn8s6RaYbOJrmNF83C4ttGACMZhqIpBRkZbMZpI734p
 4y07Z0Qidsb8J5bftAuBxti2ko4ZiZnc4BauztsVns1jc0cRtQvaj+M6dwCavfuKe+Sn
 XqbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKAEJv6GCdJIe15BB+RrEcpg8RISmy9j/57qVqibmBJt8ba2Jefpr/zLW9b0CtQ1RMn36tZsBRhBaC@nongnu.org
X-Gm-Message-State: AOJu0YzftqXu30nFKBC3jO9zKwEoFsNAmnuXa+59mjvfOYbZGqBBRJZt
 RhZXn1sjNuUycyO6m2cL9RBE8XggQSeC+rNxt1L2riv24kNHV68apKA1Z/mcGRbuLSNqQcBoxAh
 +j8s18XcwdG/B4AvSJr6PZX/qAQM=
X-Gm-Gg: ASbGncutVOf0AsxnKqqSMIBXRtf9tJncWVt0P0yaAXhveTTpmbogPS6OADe9Tkc+wko
 ar+1OsM3ngvE7IjeRqpbawnP2RhXEuiOZtf3bzxGe04YtMLxhLKxhFOoT12WfP9A4y1ehutbvxG
 r6tlz0MXCAaPPSujEniW4uq+1ILjeGeL0=
X-Google-Smtp-Source: AGHT+IGIpWlorl6aFkhYPdtH1t5R4sUey/g9tSQvGT48QMAyuVSAVY9jib/J2qWw3f0I/ToNhAut5kAV67mi8ALVn5M=
X-Received: by 2002:a05:6402:40c1:b0:5f6:c638:c72d with SMTP id
 4fb4d7f45d1cf-5fc34e582afmr466043a12.7.1746639977367; Wed, 07 May 2025
 10:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250430185012.2303-1-alifm@linux.ibm.com>
 <20250430185012.2303-3-alifm@linux.ibm.com>
 <0e1bcc40-7429-4aec-8632-31cd49f9d333@redhat.com>
 <986a9cff-708f-496d-81d9-6c465674699b@linux.ibm.com>
In-Reply-To: <986a9cff-708f-496d-81d9-6c465674699b@linux.ibm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 7 May 2025 13:45:53 -0400
X-Gm-Features: ATxdqUHls0pmn8SMDPuiiZNuuvRgSm95erKuE8kwGkSkzKUbaQtIn8F0Ur3XAb0
Message-ID: <CAJSP0QXuXtGnqa+JZLGEGakw36qCC-PCTjCZ8SkWCe-u8MH2-Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] include: Add a header to define host PCI MMIO
 functions
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, 
 stefanha@redhat.com, mjrosato@linux.ibm.com, schnelle@linux.ibm.com, 
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, May 7, 2025 at 12:16=E2=80=AFPM Farhan Ali <alifm@linux.ibm.com> wr=
ote:
> On 5/5/2025 2:38 AM, Thomas Huth wrote:
> > On 30/04/2025 20.50, Farhan Ali wrote:
> >> Add a generic API for host PCI MMIO reads/writes
> >> (e.g. Linux VFIO BAR accesses). The functions access
> >> little endian memory and returns the result in
> >> host cpu endianness.
> >>
> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> > ...
> >> +static inline uint8_t host_pci_ldub_p(const void *ioaddr)
> >> +{
> >> +    uint8_t ret =3D 0;
> >> +#ifdef __s390x__
> >> +    ret =3D s390x_pci_mmio_read_8(ioaddr);
> >> +#else
> >> +    ret =3D ldub_p(ioaddr);
> >> +#endif
> >> +
> >> +    return ret;
> >> +}
> > ...
> >> +static inline void host_pci_stb_le_p(void *ioaddr, uint8_t val)
> >> +{
> >> +#ifdef __s390x__
> >> +    s390x_pci_mmio_write_8(ioaddr, val);
> >> +#else
> >> +    stb_p(ioaddr, val);
> >> +#endif
> >> +}
> >
> > Cosmetic nit: host_pci_ldub_p() does not have a "_le_" in its name,
> > while host_pci_stb_le_p() has it. Could be fixed up while picking up
> > the patch, so no need to respin just because of this.
> >
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> >
> >
>
> Thanks Thomas! if there are no other concerns with the patches would
> these patches go through the s390x tree or the block tree?

I can merge them through my block tree once there are no more code
review comments from others.

Stefan

