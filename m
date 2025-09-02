Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E23ECA100C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 20:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utXMx-0004gM-5i; Tue, 02 Sep 2025 16:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1utXMt-0004cg-SD; Tue, 02 Sep 2025 16:12:40 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1utXMs-0004Vr-31; Tue, 02 Sep 2025 16:12:39 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b04271cfc3eso324840966b.3; 
 Tue, 02 Sep 2025 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756843955; x=1757448755; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xlC9otL38n3gGOcAEKac82G+y/4tJMQvpAeIlodwiR0=;
 b=diNdjHGXolqrR8VXS80zFaOyZ8DIrN5VP6jb4gLkWuBUraDXbe8oK0LxNuklGQ3o2m
 OzwhUlJp5HwLJtfO8rNMPu6anX0oVE0dJsgiyF5kGY7SR6HCp8Tq5EfDFyPX4CKWaRHC
 yz+FRYwm0DFiX42Secs4B32N8XeNoLHvazVW70st59Uk2oX75jHcl6j5HGTNDr5xxCRx
 rLE2Y59qJr4UF6LFjGjwgLGZEuudxiIoUy2B7oGOgawh4V0n9oIKns9WLBshnWotarTg
 6fBr5ODkpj158s47kkSgvrWIyd/39HM+UVt0D9vcPliN1rKWmcouQ6+sdNTYh6ZpFG2e
 hG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756843955; x=1757448755;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xlC9otL38n3gGOcAEKac82G+y/4tJMQvpAeIlodwiR0=;
 b=PzqfL+EJN4UdMxRYIGEiG+wL6r5BMw7P+StjGmbrgJ8iWGfVA6oNwai/KC8lb5NzAd
 Q3clPkbKvIkinB8kdw2oKp6/hxcmR5mYfk0UFhMl3E/8uC9YB+CHtD+9H2CPOuCmzcfo
 OCHJW88IPmn/8Tpk7qJkKUdwycc7Q+RwAoDMAPvjB2yxOQK/XI8e+y8tgteHsS220b3S
 2rv3w210hWQCT8KCS2pOcPW5j3UHIHr/ddYB9DGXejvwR6UfUxEBTAB3KETbozQHgfra
 y0oFIqFsasU6I6BhdoTMdqP5y1MzQh6mIe6f1MelejUZadWMI0rZ7KFNqMUaaZKFiGyb
 aaog==
X-Forwarded-Encrypted: i=1;
 AJvYcCU64VkeKlx+THaxvIA/vu/L0WHCqUTQh1AxSZH0t+InfvKC2P6gSysp9+5tuF/NDSH/9ZqTRbmVUw==@nongnu.org,
 AJvYcCWenigq2TNyi6EWmWQ6HDxF8ymz5fxhjBolvdrz+U1hMgggWj7/5K5WwPh0tARKXtOrZFtL7QUulw6mPQ==@nongnu.org
X-Gm-Message-State: AOJu0Yx/LdsT0vPjjhrg+Fj3oTdi1ugpUDWcrOA2alrzURC+0kc0ICRM
 /CUYyTmNv+s0NSeLkbO74FEOB1GW8GISJeITUp8KD7RRgGX5fnqp8ZIp
X-Gm-Gg: ASbGncu2lGWzAzHIeRYmWIc5xy4ymiFgPeIuKMvEdaGAzukdudYgrc5drD8zk/c4qm/
 FOJurHYb5OYjhUT8NkgaCCIjPhaLQ/ZGdKdmhiDYIKZ72xAbZlDkCFxU1UTEiKMJqx6wo7l8oIq
 eLAWd9hnBHlnbuPlr2k7LoFQcRAQb51oAbIRyP1pWaNe8Brt2jH42StAIOkR6ZYTXXRooxQG7sK
 /8txAgYc+WSa+DwRiz9/BXbHMBNrotBWPZr5KVoIetBoc6OeLjdZQFnXblFNo/8qMcWtZJfpF7X
 2Cem5W5NQNWagZ8eW10KENHL62T4ZlkXLb//mMa7Ug5t3rSiA1cYhe+DHym1t4nMDOWjgu7D5dj
 mHV7xGigVdsWx/4bkBxFk10bRAav0Elln0uIxnQ5RAkeNm/n9kj4Wvv/h8YU4o6Edd7S7hpFA4M
 11m7Kg
X-Google-Smtp-Source: AGHT+IFyeWhM7atjL8zSzWgsDXpVsCMA0jC1Wdi0D+mZCeaWIwwg48LfRDk0G6+h/B6hFMbRFxeIKA==
X-Received: by 2002:a17:907:944c:b0:afe:d218:3d28 with SMTP id
 a640c23a62f3a-b01d97abd57mr1408708666b.55.1756843955410; 
 Tue, 02 Sep 2025 13:12:35 -0700 (PDT)
Received: from osama ([2a02:908:1b0:afe0:b388:5893:2f33:1927])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff104fcdd5sm1028490466b.55.2025.09.02.13.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 13:12:35 -0700 (PDT)
Date: Tue, 2 Sep 2025 22:12:33 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/raspi4b: replace fprintf with error_report
Message-ID: <aLdPsZijgFLBqH1z@osama>
References: <20250901213607.69603-1-osama.abdelkader@gmail.com>
 <87zfbdyzv9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfbdyzv9.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-ej1-x62e.google.com
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

On Tue, Sep 02, 2025 at 10:20:42AM +0100, Alex Bennée wrote:
> References: <20250901213607.69603-1-osama.abdelkader@gmail.com>
> User-Agent: mu4e 1.12.12; emacs 30.1
> Osama Abdelkader <osama.abdelkader@gmail.com> writes:
> 
> > Replace direct fprintf(stderr, .%80.) with QEMU's
> > error_report() API,
> 
> Not sure what happened with the encoding there, it seems to be non-utf-8.
> 
> > which ensures consistent formatting and integrates with QEMU's
> > logging infrastructure.
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  hw/arm/raspi4b.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> > index 20082d5266..4a5f0eb91e 100644
> > --- a/hw/arm/raspi4b.c
> > +++ b/hw/arm/raspi4b.c
> > @@ -47,7 +47,7 @@ static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
> >      scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
> >                                     NULL, &error_fatal);
> >      if (acells == 0 || scells == 0) {
> > -        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
> > +        error_report("dtb file invalid (#address-cells or #size-cells 0)");
> 
> This change is fine as far as it goes but I wonder if it is an
> error_report or a warn_report. The reason being:
> 
> >          ret = -1;
> 
> we set -1 to ret here but it is ignored by the call:
> 
>     if (info->ram_size > UPPER_RAM_BASE) {
>         raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
>     }
> 
> which implies this isn't a fatal error, but the user should certainly be
> warned they won't get all the memory they were expecting.
> 
> While these single line patches are a good way to get comfortable with
> the review and submission process I would also encourage you to look at
> the call chain.
> 
> In this case we get here from arm_load_dtb:
> 
>     if (binfo->modify_dtb) {
>         binfo->modify_dtb(binfo, fdt);
>     }
> 
> And you can see further up that function we do the same test:
> 
>     acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
>                                    NULL, &error_fatal);
>     scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
>                                    NULL, &error_fatal);
>     if (acells == 0 || scells == 0) {
>         fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
>         goto fail;
>     }
> 
> which fails and ultimately causes QEMU to exit as it can't continue. In
> that case I don't think we could ever hit this condition. As it would be
> a programming failure I think we could replace the whole if leg with:
> 
>   /* validated by arm_load_dtb */
>   g_assert(acells && scells);
> 
> and maybe remove the ignored (and redundant) return value from
> raspi_add_memory_node().
> 
> >      } else {
> >          qemu_fdt_add_subnode(fdt, nodename);
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
> Date: Tue, 02 Sep 2025 10:20:42 +0100

Thanks Alex, exactly. I just checked that and sent another patch
since it's not only fprintf replace anymore.

Thank you,
Osama

