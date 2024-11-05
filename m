Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD7DD40CEB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Sr4-0005lJ-TS; Tue, 05 Nov 2024 18:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8Sr1-0005l1-Jr; Tue, 05 Nov 2024 18:20:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8Squ-0003MS-6T; Tue, 05 Nov 2024 18:20:51 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37ec4e349f4so3911056f8f.0; 
 Tue, 05 Nov 2024 15:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730848846; x=1731453646; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lS2XWVOq/GALEsFQPIa0+c9zUN2kaXHgCAyIz5SbNiQ=;
 b=L/AzWI0IU54TBFrF5GIZ9P41gBlkXesF9wGWZOZjmGQ1ySpYXb8Zqr+0g8TPvO96qi
 qhQzRTB5mTx7L2nyt5TNSnjYmKSpc7a4+FnSZTnTVGH2l7i79oKGjpulGcQingQVZ6qR
 CoyQ7V5HNb01PRFp8iQOBeoYfHUx8ztzy9cK77/vPIYrCepcCT+94+ZSjQggB8rPRz6v
 k/xqvKY0YvXC7ZThbTn3yBAdY6JC6dVVBjdSBSRfE1sqWhVtCkAfURBmFAeXTkIv6I3D
 50St+BPAiKNVgShdDFYlrbpMG9U/T+EJOSKb+HDcLLq9eZL3tQQosVPaRVKbOvboGUhA
 sUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730848846; x=1731453646;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lS2XWVOq/GALEsFQPIa0+c9zUN2kaXHgCAyIz5SbNiQ=;
 b=hGv+Jdj82vX+3t2jmgEr8TrOPfrjA0YKKIR9oDV1Uk9bepsj+QcfP3tt/fHgB+G4lk
 Uvmg2wgjoEdDwXY2dIEfJ2ps96LBemXrHxQKke/tQ9xkhanM0vWH4rL93670lX7XwGFG
 8pxjZEoMSDxawu8lhWFbBhNyg1SN1kA/0rIVwGLo9wFGi6MPVZDlGtJ5iQe7dtcOVy0q
 B2lCZzZtd7V0KIAlf5PtAGdxsrFo49oUMMNFYX9p6yDBQ1ILCS18tjErFTwD+DD4aN0y
 DBZ3/93Rb74pVE+SEwGhxuODFsdm+ABg2SNcIzas5gmMUVK0mxwtrfw5p41tur7bdN/V
 CE0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi7adxXODCJbAtZ8wcT2r7AfKJzgmaJSIxa2dinDD7gLgj8zVjk01HZomlyOk4Xa3logXmNWAClw==@nongnu.org
X-Gm-Message-State: AOJu0YxzcWc5EK/fDIlUXmwYN3ojz6CigyWyblE3WymslwhQ0SjTOqOc
 krbSwYbOn44TX+WlOxQGo6QFY9QUQtvscncq5eQqTbfO+9VYiHsqmcohE2ja35E=
X-Google-Smtp-Source: AGHT+IGIV43hCDzG62DoI7BM212nFNFXyC0I44oRMkXs77mCW8MKo2VcOdHIzEiSWyA7aytZ05UzWg==
X-Received: by 2002:a5d:5f42:0:b0:378:89d8:8242 with SMTP id
 ffacd0b85a97d-381c7a6c5dbmr15382226f8f.26.1730848845702; 
 Tue, 05 Nov 2024 15:20:45 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ac7dsm17419553f8f.105.2024.11.05.15.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 15:20:45 -0800 (PST)
Date: Wed, 6 Nov 2024 00:20:44 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 01/19] target/microblaze: Rename CPU endianness property
 as 'little-endian'
Message-ID: <ZyqoTD6v_ZJW2OKM@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-2-philmd@linaro.org>
 <ZyqiPrf2wjP1yAPz@zapote>
 <accdb8b5-a73e-45d0-8086-82d69c97b569@linaro.org>
 <3f61b85c-9382-4520-a1ce-5476eb16fb56@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f61b85c-9382-4520-a1ce-5476eb16fb56@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wr1-x42e.google.com
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

On Tue, Nov 05, 2024 at 11:18:31PM +0000, Philippe Mathieu-Daudé wrote:
> On 5/11/24 23:01, Philippe Mathieu-Daudé wrote:
> > Hi Edgar,
> > 
> > On 5/11/24 23:54, Edgar E. Iglesias wrote:
> > > On Tue, Nov 05, 2024 at 02:04:13PM +0100, Philippe Mathieu-Daudé wrote:
> > > > Rename the 'endian' property as 'little-endian' because the 'ENDI'
> > > > bit is set when the endianness is in little order, and unset in
> > > > big order.
> > > 
> > > Hi Phil,
> > > 
> > > Unfortunately, these properties are not only QEMU internal these got
> > > named
> > > from the bindings Xilinx choose way back in time.
> > > 
> > > This will likely break many of the Xilinx flows with automatic dts to
> > > qemu property conversions so I don't think it's a good idea to rename it.
> > > If you like to clarify things perhaps we could keep an alias for the old
> > > one?
> > 
> > Adding an alias is the safest way, I'll respin this patch.
> > 
> > Note however I'm worried about this fragile disconnect between Xilinx
> > dts conversion which isn't exercised on mainstream (in particular if
> > you get busy and can't review).
> > 
> > > 
> > > For example:
> > > https://github.com/torvalds/linux/blob/master/arch/microblaze/boot/dts/system.dts#L73
> > > 
> > > Cheers,
> > > Edgar
> > > 
> > > 
> > > > 
> > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > ---
> > > >   hw/microblaze/petalogix_ml605_mmu.c | 2 +-
> > > >   hw/microblaze/xlnx-zynqmp-pmu.c     | 2 +-
> > > >   target/microblaze/cpu.c             | 2 +-
> > > >   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> > > > diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> > > > index 135947ee800..e9f98806274 100644
> > > > --- a/target/microblaze/cpu.c
> > > > +++ b/target/microblaze/cpu.c
> > > > @@ -368,7 +368,7 @@ static Property mb_properties[] = {
> > > >       DEFINE_PROP_UINT8("use-non-secure", MicroBlazeCPU,
> > > > cfg.use_non_secure, 0),
> > > >       DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU,
> > > > cfg.dcache_writeback,
> > > >                        false),
> > > > -    DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
> > > > +    DEFINE_PROP_BOOL("little-endian", MicroBlazeCPU, cfg.endi, false),
> > > >       /* Enables bus exceptions on failed data accesses
> > > > (load/stores).  */
> > > >       DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
> > > >                        cfg.dopb_bus_exception, false),
> > > > -- 
> 
> OK if I squash the following?


Looks good!
Thanks!

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>




> 
> -- >8 --
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index e9f98806274..b322f060777 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -328,9 +328,16 @@ static void mb_cpu_initfn(Object *obj)
>      qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dc, "ns_axi_dc", 1);
>      qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_ic, "ns_axi_ic", 1);
>  #endif
> +
> +    /* Restricted 'endianness' property is equivalent of 'little-endian' */
> +    object_property_add_alias(obj, "little-endian", obj, "endianness");
>  }
> 
>  static Property mb_properties[] = {
> +    /*
> +     * Following properties are used by Xilinx DTS conversion tool
> +     * do not rename them.
> +     */
>      DEFINE_PROP_UINT32("base-vectors", MicroBlazeCPU, cfg.base_vectors, 0),
>      DEFINE_PROP_BOOL("use-stack-protection", MicroBlazeCPU, cfg.stackprot,
>                       false),
> @@ -368,7 +375,7 @@ static Property mb_properties[] = {
>      DEFINE_PROP_UINT8("use-non-secure", MicroBlazeCPU, cfg.use_non_secure,
> 0),
>      DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU,
> cfg.dcache_writeback,
>                       false),
> -    DEFINE_PROP_BOOL("little-endian", MicroBlazeCPU, cfg.endi, false),
> +    DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
>      /* Enables bus exceptions on failed data accesses (load/stores).  */
>      DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
>                       cfg.dopb_bus_exception, false),
> @@ -387,6 +394,9 @@ static Property mb_properties[] = {
>      DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
>      DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
>      DEFINE_PROP_UINT32("pvr-user2", MicroBlazeCPU, cfg.pvr_user2, 0),
> +    /*
> +     * End of properties reserved by Xilinx DTS conversion tool.
> +     */
>      DEFINE_PROP_END_OF_LIST(),
>  };
> 
> ---

