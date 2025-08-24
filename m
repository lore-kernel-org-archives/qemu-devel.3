Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052A2CA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 16:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqDHe-0002as-8r; Sun, 24 Aug 2025 12:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDHS-0002RD-AX; Sun, 24 Aug 2025 12:09:19 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDHQ-0008Sd-CH; Sun, 24 Aug 2025 12:09:17 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-55ce5097638so3921512e87.0; 
 Sun, 24 Aug 2025 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756051753; x=1756656553; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gcWgU4uJKCQi5G4rMilEpP8ql/dVsMsGLckek1G1ulw=;
 b=FvlR6YyjrvuVn3H3ikhKaRiPsj+75dUUZxM2J690QJNWkz5biH0LoamEsHI5Thouai
 j/I5p6hIQXzPIf2J5XYSVYoBAu7uTs8OWIzokZRKP07x5uTF5M0V2Gw1jJU34pmUrkSc
 iOUC8dUS5UIlYDYiApSMl2K+/WF/KqvJeoiBHxZvfdpOo0tst/sZJvYbK8Z2XtHRk+3U
 VPkQhvDv8e9SSrYat0L1EUhkAm9WffTIhEtMKA8899u38wscgPPoj4lAQtAyz1TcOllG
 7pxSWzfH4VkofVTWBAA0Pt/ec6UNuaDE8jk80/BCjXownjcLWNNLZPZtDbDwJqc5SPgo
 XbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756051753; x=1756656553;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gcWgU4uJKCQi5G4rMilEpP8ql/dVsMsGLckek1G1ulw=;
 b=ars4MYtpadNmCg7vdDvu0mfrverCP/UOyS+qlpjkGWId4qAd9RwnbidBLnEJV8uuI6
 RwRuL5Hvz4b35SbUdZO8duWp9e+1WxRH2Nfx4fPWAJP8mP1DTk58+X4GFNctl4C4dYuc
 yX7XkDAs7KvWCjiVD+1j4wjwdIY4yVhroet1UzML4ZkPoI2WbDyyRa5Z7gIajohGegCr
 0jBT4LFpFr6DW00J7QRBtA3QrEj70vOSlupqvUFcw/tTC+MAFKASaQn8nEIV9MnB92Di
 /JvEYLIJPLItB9qEUrx/hwVb0d0rjfJfuHOLUYr2LxZtbhCNqdbJjKYYBQVy7T4G2X65
 Ni/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd+OSdM5SVMUN0B2OcH1vkdTUv2a+6ChdV3NoYrQE9n+v8ixLEFJcNa0f8wlutBDq97dwBb8RoaQ==@nongnu.org,
 AJvYcCXr6HSQY5OuIpf8b4m1itOtEQeyvRWDy08u6dMvbaq1LujtJ+w+bzPQL94Vld4vh5hvqe60DJfeHnZB7Q==@nongnu.org
X-Gm-Message-State: AOJu0YyoVWqsTiZ8rEOroIuU7IJXOyBGQkGNGeHQ4WXJxRYJeIMFoWgH
 /WxWxJ+MQiHhUcMzPiPDYK08sqQNOg1FTjOgQgmln7bCylXmWs1VFobW
X-Gm-Gg: ASbGncsDoitL6vrdj0clHb0+tCWtXn4aCnc9ro4GYXZehmxTN4fiBmvlDsU9Sxisr/4
 R41Tff+bYhwoS+xB4a9glRepTzzgzIX90bFdtb5e8NARQil2rsZKOgBGUPVL6/xZCH/hFDevN1p
 QNndJcrKBgPxITyD3798nGwGrZ6u4DibYPHU2UPr9E1kUk4L48M5vmk//uQEEMiR/Wf6iqsTEXi
 EXUKjo1WD8WsYIm6pBDKbKiLIwYF6mYh6k/kydsBJelHd6FQnDGs9QGlRM2r08LHSODYqzJKC+M
 z1GJvFJcq3V8EsROkaFIpPfej1GUAiX4aW/NJ7ud2A+9ijLKpOybsuhBgGlEO2nxyjkiDgMLEBW
 DbBuhIOz4emteaniXheZtm2cpNLEu5nfbaqlDNfL0hygDVJz8cemhM69LBnOR+Y8S1BGu5Q==
X-Google-Smtp-Source: AGHT+IG1ZaOofk4kssSmwo6UIeXhajJjGPQRXqZOEvSHlRmCUwwP3M/NCLQrcUi6DNRHPvtd3V11GA==
X-Received: by 2002:a05:6512:6094:b0:55a:4ca6:d72d with SMTP id
 2adb3069b0e04-55f0ccd36b8mr2925650e87.30.1756051753153; 
 Sun, 24 Aug 2025 09:09:13 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35c1222esm1136208e87.49.2025.08.24.09.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 09:09:12 -0700 (PDT)
Date: Sun, 24 Aug 2025 18:09:12 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 05/14] hw/dma/zynq: Ensure PCFG_DONE bit remains set
 to indicate PL is in user mode
Message-ID: <aKs5KHb3SnrMJMf2@zapote>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-6-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815090113.141641-6-corvin.koehne@gmail.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
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

On Fri, Aug 15, 2025 at 11:01:03AM +0200, Corvin Kˆhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> All register bits are clear on write by writing 1s to those bits, however
> the register bits will only be cleared if the condition that sets the
> interrupt flag is no longer true. Since we can assume that programming
> is always done, the `PCFG_DONE` flag is always set to 1, so it will not
> never be cleared.
> 
> Signed-off-by: Yannick Voﬂen <y.vossen@beckhoff.com>
> ---
>  hw/dma/xlnx-zynq-devcfg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index f28d0015e6..60ea351494 100644
> --- a/hw/dma/xlnx-zynq-devcfg.c
> +++ b/hw/dma/xlnx-zynq-devcfg.c
> @@ -188,6 +188,8 @@ static void r_ixr_post_write(RegisterInfo *reg, uint64_t val)
>  {
>      XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
>  
> +    s->regs[R_INT_STS] |= R_INT_STS_PCFG_DONE_MASK;
> +    

Looks like you've got some stray spaces in the empty line.

I'm fine with this but another way to handle PCFG_DONE could be to have
some state that goes true after the first programming. e.g:

s->regs[R_INT_STS] |= s->pcfg_done ? R_INT_STS_PCFG_DONE_MASK : 0;

On the other hand, for direct Linux boots we may want this to be always
one...

Anyway, with the whitespace fixes:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



>      xlnx_zynq_devcfg_update_ixr(s);
>  }
>  
> -- 
> 2.50.1
> 

