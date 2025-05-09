Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A54C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPof-0005et-9y; Fri, 09 May 2025 11:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPod-0005db-Go
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPob-0001Ey-Vt
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746805147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XjfMm92yDrp8r2ZOJnfR/TKWAwp/QZ0ox7aMgUojhHI=;
 b=Gha0TWpyheRvDQ4tY+1h+TdhsWk4KAVepKeWwTvwgaoWM1VzWr1Mgu2BeLaxEbXK5uWp1K
 MKiZLChnniYBtQ9hS/jK5/t9pBJC1gZAZdFksiNtMFsJI2GvP0ZDVo0W83PO98cDj4JKXF
 N2gTHVGoXY3Eaf7z+a3HSwY7z2ZNw3o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-5Zm0k3m9OSukZEPBbyQRYg-1; Fri, 09 May 2025 11:39:06 -0400
X-MC-Unique: 5Zm0k3m9OSukZEPBbyQRYg-1
X-Mimecast-MFC-AGG-ID: 5Zm0k3m9OSukZEPBbyQRYg_1746805145
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b7cd223fso1158860f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805145; x=1747409945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjfMm92yDrp8r2ZOJnfR/TKWAwp/QZ0ox7aMgUojhHI=;
 b=qDiJI8MAUeb9lRqEzH+KhDY5e6AFeLaxY3RmQ0VSLKFNBDxjk6L0oJvYCdccZLTupG
 aLRnS16h41Rb++AffI93N3wDrtYwmdv1o9F6Ag+fMHMmT8JYrCaof68iU57EXX26U3s+
 stGop9ljlnOpYaaZDscNlzswyjTroVfu5wKO4cC3mef/8r8UGXpG3+Angqaq4Q+0jxkV
 QrghZvKdJPfXter5ns997SRm2SDbL76esPL3VErjT5OeHVt64mYD2wtAku8gDPKYjTTD
 8JKL4WM+D6XYn3S9uh0KB2mzo3/CzV1dSanwWGs2KW3cuMcW7gAonRP42UVa+uFv+4Xg
 xUNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFg9o5kacNhMHKlFV/7rUFTlBWjrBtLEkC7ZT3Ze1LffrOdTgWRhhcrFmkNuvCDngN/mVMUd81R2SI@nongnu.org
X-Gm-Message-State: AOJu0Yx+bXgWnHOzCT/ou64gyqbOTxHKHHMmOyC3utt8pp21ft+1dx82
 QVPE48m0z0NZ4tHuJsXDQweIv2/5a22elzuQ0oG3sy45G2zi8S2PTT9D3yr+OgrZo/1LvRANMya
 rrU2xmVYC/OHJUc3AezLR31Kx75LwVqpSaYBRs33C2N7o6XxP3oE4i+KiYPpTjmE=
X-Gm-Gg: ASbGncsjOLpYKT5fsI/IYwEVR1gL6kTP13LiNVP8X31DYOScYyTJLXWgtS7DSLcExrE
 IUc8yPE11nLxNrbz4RttI6go2QcBrU8Ikk8ikcYJJrXTGslQ+6Koh9PNSbylyZAmpeRvPZcS6Vj
 gMNE1N95Kwc37bEBa1ro315OglYoDAYsA9oCv+uk0v1KQ3hhUoo2EzybxMwssaastoTAduo4dhY
 0FxWBZipWh8ne+c1P0UJwXwEPzc1H1WYry4yLCr0x3NwwJDv1rpoiHIDZXfRLVmXvtvi0pKMENi
 UVBSrLjVl+JUqVPMvvbdX5u4yzhHmEsT
X-Received: by 2002:a5d:64ad:0:b0:3a0:b4f1:8bda with SMTP id
 ffacd0b85a97d-3a1f643ac2fmr3272171f8f.1.1746805144990; 
 Fri, 09 May 2025 08:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhKPmGTam1SWc4Gq6m5qYczHRHd+/PPrONEzG16dZjSMP8SZ3aFRBc8dbuayiDSu1cWlR1ag==
X-Received: by 2002:a5d:64ad:0:b0:3a0:b4f1:8bda with SMTP id
 ffacd0b85a97d-3a1f643ac2fmr3272131f8f.1.1746805144552; 
 Fri, 09 May 2025 08:39:04 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57de001sm3565183f8f.20.2025.05.09.08.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:39:04 -0700 (PDT)
Date: Fri, 9 May 2025 17:39:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Yanan Wang
 <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, qemu-arm@nongnu.org, =?UTF-8?B?TWFy?=
 =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Huacai Chen
 <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 06/27] hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide()
 -> fw_cfg_init_mem_dma()
Message-ID: <20250509173902.718c2dc5@imammedo.users.ipa.redhat.com>
In-Reply-To: <aB2l25PwH4e0jaTb@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-7-philmd@linaro.org>
 <aB2l25PwH4e0jaTb@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 9 May 2025 14:51:07 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> On Thu, May 08, 2025 at 03:35:29PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Date: Thu,  8 May 2025 15:35:29 +0200
> > From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Subject: [PATCH v4 06/27] hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide(=
) ->
> >  fw_cfg_init_mem_dma()
> > X-Mailer: git-send-email 2.47.1
> >=20
> > "wide" in fw_cfg_init_mem_wide() means "DMA support".
> > Rename for clarity.
> >=20
> > Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  include/hw/nvram/fw_cfg.h | 6 +++---
> >  hw/arm/virt.c             | 2 +-
> >  hw/nvram/fw_cfg.c         | 6 +++---
> >  hw/riscv/virt.c           | 4 ++--
> >  4 files changed, 9 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> > index d5161a79436..c4c49886754 100644
> > --- a/include/hw/nvram/fw_cfg.h
> > +++ b/include/hw/nvram/fw_cfg.h
> > @@ -309,9 +309,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uin=
t32_t dma_iobase,
> >                                  AddressSpace *dma_as);
> >  FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
> >                                    unsigned data_width);
> > -FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> > -                                 hwaddr data_addr, uint32_t data_width,
> > -                                 hwaddr dma_addr, AddressSpace *dma_as=
);
> > +FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
> > +                                hwaddr data_addr, uint32_t data_width,
> > +                                hwaddr dma_addr, AddressSpace *dma_as)=
; =20
>=20
> There's one more use in latest master:
>=20
> git grep fw_cfg_init_mem_wide
> hw/loongarch/fw_cfg.c:    fw_cfg =3D fw_cfg_init_mem_wide(VIRT_FWCFG_BASE=
 + 8, VIRT_FWCFG_BASE, 8,

with that fixed:
  Reviewed-by: Igor Mammedov <imammedo@redhat.com>


