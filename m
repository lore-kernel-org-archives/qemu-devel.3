Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD8DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPjP-0004zv-Rc; Fri, 09 May 2025 11:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPjN-0004ni-BW
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPjK-0000em-FF
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746804821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxYNx3ojouceqPK+Dr7auESWb9mDE/VjwCaYTP8lEmw=;
 b=cl22f+jIhOLr4F4dEys0mGoMisZnsQWl+tKxpxXBHLd8MNk9vd2DLO2A/DmKSuqbxDWXY0
 VnMOtMpJSxLYL9p5GE+bWnoEYQsI0sEFYqY/m2LYaAwbOgJ2a7dC8b/4euumXRB/POK0pP
 NaVW6PGrteOK2/HPg0TJhRVArtd7MTs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-uja6QKUcN06-rFWVHCXtbA-1; Fri, 09 May 2025 11:33:40 -0400
X-MC-Unique: uja6QKUcN06-rFWVHCXtbA-1
X-Mimecast-MFC-AGG-ID: uja6QKUcN06-rFWVHCXtbA_1746804819
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b662be0cso1302959f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746804819; x=1747409619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxYNx3ojouceqPK+Dr7auESWb9mDE/VjwCaYTP8lEmw=;
 b=nGtMSayb+bl/yf2e2C+/MUVaMBkoR5yb9ukx6zgzbJwyJnt1xB+Wy0+RM8EGJtA0eq
 HxSAIFwXUzwPwMjlBpy8L1SvvadYFspaSdGlTI5CvKqVWIWPs2GKh/eF4giTfD/gdge5
 RPhtwsUQE1zGSG2sKTOgFnu6qZL6hTmh0lOUn6S6TAOeO0+EmdsAA0DC3sWoLMiMiODd
 OIz8J++18EGSvKvVvIes8KLkpDsFWWBlDX8YvSXLkLNkucB9t5cf1xuVzPo+WIfX8T3t
 kOOPyUTQzpx/XCmdEb7+I5KIVXVXRFBu8WdiPHG0BPopEgS95m7OhfhahgiAls7pcJ/e
 siSQ==
X-Gm-Message-State: AOJu0YzOnNNzmyRpuu+sQPq8588ZHAKV9IcOs99nz1TFreRGt5r4qDgR
 IM8FpduWLhzMJyB1H0BN+NpZnOKlC8HGxnB6hn7BzMBve/AGwWo8bjHIuXrOzLHFQ22PHzOdzIy
 bAhS4s1gDc5JfAt+JXT8n/pVbv4sM5+Zt3cqxx6CTGOxIwvbg7/jF
X-Gm-Gg: ASbGncsxjMoP9KR3juKeKfkQpZ0srpR59Ll1xoYG5OoPVXpBVAV+qTZ6BaV14TUn0I0
 0lQTnn3hQ9mreI3TWghjN+P0bvCE0ngOgasbcV8TLC//H0XlmxfWRBqUQP+Y3FZyxQJlCQEdVHz
 JUI9ROV5B9e2Rvh1ZbMQ70PMKYnbb+thqX2rTjgrotd5E59ouCqJ9t7S6MW8vi7KJyHy/lmbCkB
 fBFRdX4ttupYX5CI3e3MNnVJb+JLT6Y89ThC+ZL9w96v/yLZjET8uYm6DHbTG9Y4IWdkCS8bvsS
 XN/T77SwZ2YMdQZtct8r1cy3J/syysOA
X-Received: by 2002:a5d:5f82:0:b0:3a0:7af3:843f with SMTP id
 ffacd0b85a97d-3a1f6432cb9mr3198023f8f.19.1746804818928; 
 Fri, 09 May 2025 08:33:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAfD/C9+Rd/HZglAXP5B2WMfZsTezpKhI7nWOkj4yUnpGfRvi8xCrHDa7gf8c/nYw5T+r/1A==
X-Received: by 2002:a5d:5f82:0:b0:3a0:7af3:843f with SMTP id
 ffacd0b85a97d-3a1f6432cb9mr3197999f8f.19.1746804818536; 
 Fri, 09 May 2025 08:33:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d14e6d74sm66226135e9.21.2025.05.09.08.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:33:38 -0700 (PDT)
Date: Fri, 9 May 2025 17:33:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason
 Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 03/27] hw/nvram/fw_cfg: Rename fw_cfg_init_mem() with
 '_nodma' suffix
Message-ID: <20250509173336.637f0ed8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-4-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-4-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  8 May 2025 15:35:26 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Rename fw_cfg_init_mem() as fw_cfg_init_mem_nodma()
> to distinct with the DMA version (currently named
> fw_cfg_init_mem_wide).
>=20
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/nvram/fw_cfg.h | 3 ++-
>  hw/hppa/machine.c         | 2 +-
>  hw/nvram/fw_cfg.c         | 7 +++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index d41b9328fd1..d5161a79436 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -307,7 +307,8 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
> =20
>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>                                  AddressSpace *dma_as);
> -FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr);
> +FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
> +                                  unsigned data_width);
>  FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>                                   hwaddr data_addr, uint32_t data_width,
>                                   hwaddr dma_addr, AddressSpace *dma_as);
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index dacedc5409c..0d768cb90b0 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -201,7 +201,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PC=
IBus *pci_bus,
>      int btlb_entries =3D HPPA_BTLB_ENTRIES(&cpu[0]->env);
>      int len;
> =20
> -    fw_cfg =3D fw_cfg_init_mem(addr, addr + 4);
> +    fw_cfg =3D fw_cfg_init_mem_nodma(addr, addr + 4, 1);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
>      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ms->ram_size);
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 54cfa07d3f5..10f8f8db86f 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1087,11 +1087,10 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>      return s;
>  }
> =20
> -FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
> +FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
> +                                  unsigned data_width)
>  {
> -    return fw_cfg_init_mem_wide(ctl_addr, data_addr,
> -                                fw_cfg_data_mem_ops.valid.max_access_siz=
e,
> -                                0, NULL);
> +    return fw_cfg_init_mem_wide(ctl_addr, data_addr, data_width, 0, NULL=
);
>  }
> =20
> =20


