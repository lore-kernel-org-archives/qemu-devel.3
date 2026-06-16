Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30581CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPTR-0007bE-8V; Tue, 16 Jun 2026 04:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPTL-0007T3-Bm
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:48:40 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPTJ-0008Lp-Qn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:48:39 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-662c360aa73so25656d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781599716; cv=none;
 d=google.com; s=arc-20240605;
 b=UwJ24CZfXPGEanV2XH3rsipXNezSQgCP6Zgc00rRe+H9l7AJpfsI/VQ+6M8Bp2B91N
 iYwxUeuylHqxOFbrCS0nMpulDE/5LLAPS7r+nPWLtPw1Qj+a0cAnpLKPkN2fGFwexL7s
 nstyQKrBOVRQgCi/UpVQO8ztrYNHyQH9MTVgRGUxJhgsdQWo04OnLH7dq2dmbpe8iCVy
 EVuiEQB2bQBKAN3r6Yf/OKLvPIHOL64y367ChLeiQiMNfiEYDvYVZglPJ7IXNw+T+Q4j
 f/9PJNfCVjCeKfaD4sPm28uNWiaOjGPGedQ7tdbgZSqi071vyZBZMiOpfH1jVJrJ0gn3
 eJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XvkHOIzaUam1/lYBeJ7E97rTLbuNkdxLaj6A96hVIgs=;
 fh=yJjJslpQ/kQiLmB0saqwszjwyG+xful5qmOT+xNol2g=;
 b=ChrbeOLunSP4z7KVCKolt5p1N1sn8g2t2tipQ1JHnIXq+twa6wI/gxmgDXXaeuQnLM
 +7czo0vlQHWSFxe5GOz5pw7QUosy6tgQxkv151RCGcxYzg+TCEuAb7Q77JruoaLUV1tD
 zM67Y2ECeVgAGWLwBB+7x4QRJuFdc+1DZk1Jixi4DnRjgMJ1diN4xJ0UjD9AMbVO/s6f
 7Ds0ngStrGqzKz/d7fI0v+p00nUccpeTqjPZjtm/wv0qdTI2035WY32+Hq5KrkcVMnQu
 Jl748sWx8hgPRqdUFoNysbH6WPfhS6frfEB0ReEKPY1ANHQ2SN9mrUzooc5hFH4TTl8+
 H6mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781599716; x=1782204516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XvkHOIzaUam1/lYBeJ7E97rTLbuNkdxLaj6A96hVIgs=;
 b=HmoR+jBIqdYqFJGchbSVSPYXXXv+OAltR/DGHiAKOrkCYVEKgV4F9tItcOIsyKs73C
 QcI4YybeLx9JMYOCPcWkawROArztl2ZDOnKAKuiAM4+Ah+HDS0is0SmPalKE5HOSuM8P
 55ANx0yIp+4l9IgUAt/m3C4+RQVCnbhhXQaJIjTEDHgg2iA1luOpMNqAg+CRHG8FblYo
 kutGt5yYlq2ULOi6JTMw22n1RgZ48UDVXSyyZRd3mczIF+pcDWNKiNA/vmIZyQqt7tev
 sEdN/Izd2v9pQ1nXQM22861cAkey4ZWqbNhmZ3lo2yBdKq0AbRclybp1/SfrETWobyEF
 YWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599716; x=1782204516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvkHOIzaUam1/lYBeJ7E97rTLbuNkdxLaj6A96hVIgs=;
 b=UjpjTTYNHFGvjX7KXg01mh0fMjFPCMMRKyIed9o3qHQI02ngg3wBe1TNh/34xe4JoK
 TdBHW5gbi/ne6zdejY4jcgCKsunYwH6ZhB1Qiwk0ygx8A0BHSv5XLHbK8Qv/4xCtvbMH
 YgFn5AEE8LUyRlSSb5veIX+rMdkZAyFZrLh9lJCSKx34zCjpgciiKwSc8fvy3JhBEKTc
 x4/YdHBG0Bx3Z9AOmPf1oD3bYLyImJ7ghsuG41y5yi9JqeIngEnaNfK1ZF2WouJ/D8N6
 yxsUGP+L0aDBp9/a7RMSnaTrMmSacm5b6Qwx+y6bEYeVyR4CTVvK2B4hTfAHH2lksodG
 SApw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bk+zxjxc8/HnghJC7k4JyYfSoMY/57Sjy2AjoMPVGHdSoIKnGATnhsnrwuf5wGVz93yY8DCzvLxQ6@nongnu.org
X-Gm-Message-State: AOJu0Yw6DIaslMiU/k8GeKA7vb8AE+YPUf26jnZlkE1/Zn5i9eGl/2c8
 v5+dIfCTOe+3MccnzrVbtO6tNDk5kESisnQ1XV9Ce8xJ4hveDWBjPq3DzQ2PNoF2GS7PbEixv5n
 TGcQFKuAU0rrOIcLpl4TtJr7nOmn3vNdN/Nvu0+PHhA==
X-Gm-Gg: Acq92OEBmqam8WedozXIw0HRcQmLoSaTPHiMH9EdqMZKTq2nqdGl98HPzSR/lgLAiYC
 R7zMJ2NRb0JblLqQuXK7DvDU7MpPz+qj14lvI7RbNgiaFgRbx5VPBp6Et1h7ZORpCdLGZsJTje7
 bATsidMGkhWDWWVkNHOVXgZ7bPOCrTkw5H6HUw6H/5xsgrCH9Y/L4k6Rhiv6m2njQbit3xKxRyk
 edio+Ob4oFWtXg/gldW14Wob2E1h+0WQqWJ6GLNHM5TlT+O7++KHMwddaqH5HlHVAAgay3CGU0w
 cwLSZ9Lae14ZoKigHEaUtYO6CwbjQeHFRP2/xxh1bsuIdEGeQJcmA49lP2LXIwXyAwI=
X-Received: by 2002:a05:690e:151b:b0:662:89c8:4a63 with SMTP id
 956f58d0204a3-662b601df10mr1932779d50.18.1781599715661; Tue, 16 Jun 2026
 01:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260608174900.2227340-1-nathanc@nvidia.com>
 <20c8948f-1933-4410-96fc-10a2d53cb40a@redhat.com>
In-Reply-To: <20c8948f-1933-4410-96fc-10a2d53cb40a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 09:48:22 +0100
X-Gm-Features: AVVi8CdxCl049mvW1EAeYb3g3IBo_qAbujdubuwkskOTdw9SqAB365ERWsrG9EI
Message-ID: <CAFEAcA-Mq4jd6Y5xOJDtLiu5BXMkz_5t8YCQEeUgYmyK5rb_wg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] hw/arm/smmuv3-accel: Resolve AUTO properties
To: eric.auger@redhat.com
Cc: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 9 Jun 2026 at 08:49, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Nathan, Peter,
>
> On 6/8/26 7:48 PM, Nathan Chen wrote:
> > Hi,
> >
> > This is a follow-up to the series [0] that introduces support for
> > resolving 'auto' for arm-smmuv3 accelerated mode's ATS, RIL, SSIDSIZE,
> > and OAS feature properties based on host IOMMU capabilities. This is
> > dependent on the series [1] for changing these property types to accept
> > 'auto' values.
> >
> > Accelerated SMMUv3 Address Translation Services support is derived from
> > IDR0, Range Invalidation support is derived from IDR3, Substream ID
> > size is derived from IDR1, and output address space is derived from
> > IDR5.
> >
> > The default values are set to 'auto' for all properties. If accel=off
> > and the values are set to 'auto' or are omitted and resolve to 'auto',
> > the default property values defined in smmuv3_init_id_regs() for OAS
> > and RIL will remain unchanged, while SSIDSIZE and ATS values will
> > remain initialized at 0.
> >
> > A complete branch can be found here:
> > https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve-v6
> >
> > Please take a look and let me know your feedback.
>
> The series looks good to me and I tested it with Grace-Hopper GPU
> passthrough
> with explicit option settings and auto settings. It collected R-bs for
> all the patches. Feel free to collect my T-b:
>
> Tested-by: Eric Auger <eric.auger@redhat.com>
>
> Peter, please could you consider pulling it if it suits you.

Thanks for taking on the testing and review for this -- I've
applied it to target-arm.next.

-- PMM

