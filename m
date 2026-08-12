Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21611C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGH6-0005Un-Rv; Wed, 12 Aug 2026 17:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wuGH4-0005Tj-Mn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wuGH0-0006sB-Uj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786569245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jLCNCwndmRGYwkn8drh249fvKYzwAy15snYpSaVQ/ZA=;
 b=CIHbVd8w7OlxZ/u/mFje3bGcYb2VS1Q5ltFcPJPwB/2V8MD/rKBpzCjDpYW4frW7S63GI0
 uzF0pY8bg7BP+zUumCo88/n2d8GZhcqpVhYgv8fwMpb0LuU9+b7kgeMxvBhjD6Skm9yvPc
 6ZJTet0g+kcQnV3HVHj11oQYHfj7p+k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-Rl-yVLvcOhemdR54MOG5iw-1; Wed, 12 Aug 2026 17:14:03 -0400
X-MC-Unique: Rl-yVLvcOhemdR54MOG5iw-1
X-Mimecast-MFC-AGG-ID: Rl-yVLvcOhemdR54MOG5iw_1786569242
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47485fde05aso16966f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786569242; x=1787174042; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jLCNCwndmRGYwkn8drh249fvKYzwAy15snYpSaVQ/ZA=;
 b=KM4BkyuMjLOhCn5dTqF5594ikBMHZbLiaacnEPrTiPFjasMNWbc+NwgQcGqUp+bhdF
 iYuAPxN10UTTFWhOfot+KolVZN19CPrSM0x+oQkjXHzDktUx+6AonT8njS9XBOD/hptQ
 l6/NpcSUxrXi2Ex2+fBHehw9r8WyaULs52Ln9KC++7QGu9ktTZpcA5dTEMtCCo+qcUbY
 Pb7c+P8lTUKzjNL4XABhGnc/tzi3uOqdkVTb6Ri3c1b4HlUmUPmJJrnCtnpj0+2BzJIy
 GHr7fd9IyKz36BntSueHXKzkiouhr+rNmcGe6o6w7zHhn1+pjiHoG9JAxnI08HxmEjXT
 jGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569242; x=1787174042;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jLCNCwndmRGYwkn8drh249fvKYzwAy15snYpSaVQ/ZA=;
 b=HoUZdq7OWBBZtS0pIddsOKRu35ar6TwY18Hni1ueu4uFUNAg0lH3CTg1s0c8fuyuoK
 rYd/gyt95/toAg1aT5DFFem0E/2stWd/RMSPnE4DW9kWeipE78gZ1QvJkfJTZKtH4Gjw
 82/sGnThp4zVOM6JiDpHMu8Twx5IHqCeJT2NnVik520m6bzacFfXfq9vvKvs9pH5KJuT
 7uJ0yi9TblSqs/j97TIgbHbc4lpf05ay/i4R5/SqdmDp7feN17ZtAvapFjS7WHYMcjg4
 hUM7gVYHOAItN22utPNJEUpAtuaWm4LXAqbUFKfXxV4tEvxGHcNa1fQEi/HxfeDwoTU1
 o+Vw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTeWHkH7Q3yscCq/vhpJUaJNq+GlQVO6kNYIhyp1qm9IFcRTxjfhuha6XJpvj8Q2H0KoY0FnFnco+x@nongnu.org
X-Gm-Message-State: AOJu0YzTjNkM5DjP4boOv/OfExZg9CcsgednaYDI7y0vznpug4Q/Mr2e
 wJh06ajJOPf6UdvliTLY2IHEXSBT7RlbNVK38MqkCHcFNkgH7R7efFcA59IrgbN2jWsKqzQRI1E
 eaKbwwf6aHliSJBhdTOg0jjC6eR7f1JZOTCjlEbAFhfffPuRjxBRQuV6Z
X-Gm-Gg: AR+sD10hDyapLvxI1NRCKu/sukfKmRm7Xa2fTfthPlLQT1/6fpWdFeHXkjuE3Q5//ju
 VifZKmKfvH1KlG0k2tKGa47CleMUWPs9tNIehgUW3jMJAwXU7yNsM3kcqc4AFah35T9FjiTC4SW
 6EBKREBiD9wcVSa/UTaiAFgjmNBbSEy9jN4SgZBKkYnJ5AKMrBX2VlugsmlUiSiVAu09IbyPXia
 rae+AI5m/nNS5u6i/5qWi99Ya7fAs+1oaNzdiAa39ZfAtszeeanc/Vlyhuv0vhPX7vhvD5H5/bX
 xEmzB94HIV0H7RLelRPHeVscLEQUH5Nk0j1kFk/OtWchpJwIQG8YBVgFolp1T+t7iERDanjluj5
 /BIGegHqSi7Xbzdu/C/6AMA==
X-Received: by 2002:a05:6000:1841:b0:481:3db1:a62f with SMTP id
 ffacd0b85a97d-4815a01c6d7mr1091353f8f.17.1786569242206; 
 Wed, 12 Aug 2026 14:14:02 -0700 (PDT)
X-Received: by 2002:a05:6000:1841:b0:481:3db1:a62f with SMTP id
 ffacd0b85a97d-4815a01c6d7mr1091306f8f.17.1786569241630; 
 Wed, 12 Aug 2026 14:14:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5b6f94sm501843f8f.32.2026.08.12.14.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 14:14:00 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH for-11.2] hw: add compat machines for 11.2
Message-ID: <20260812171349-mutt-send-email-mst@kernel.org>
References: <20260723163806.368127-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723163806.368127-1-cohuck@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 23, 2026 at 06:38:06PM +0200, Cornelia Huck wrote:
> Add 11.2 machine types for arm/i440fx/loongarch/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/arm/virt.c              |  9 ++++++++-
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 13 +++++++++++--
>  hw/i386/pc_q35.c           | 13 +++++++++++--
>  hw/loongarch/virt.c        | 11 +++++++++--
>  hw/m68k/virt.c             |  9 ++++++++-
>  hw/ppc/spapr.c             | 15 +++++++++++++--
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  include/hw/core/boards.h   |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  11 files changed, 85 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 219597cabd0b..e7a56e37f731 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4441,10 +4441,17 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
>  
> +static void virt_machine_11_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> +
>  static void virt_machine_11_1_options(MachineClass *mc)
>  {
> +    virt_machine_11_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE(11, 1)
>  
>  static void virt_machine_11_0_options(MachineClass *mc)
>  {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 805148678d57..354b93c62037 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,9 @@
>  #include "qemu/audio.h"
>  #include "hw/arm/smmuv3.h"
>  
> +GlobalProperty hw_compat_11_1[] = {};
> +const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
> +
>  GlobalProperty hw_compat_11_0[] = {
>      { "chardev-vc", "encoding", "cp437" },
>      { "tpm-crb", "cap-chunk", "off" },
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f064aa2b3e32..e9e4fc262b83 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -74,6 +74,9 @@
>  #include "hw/xen/xen-bus.h"
>  #endif
>  
> +GlobalProperty pc_compat_11_1[] = {};
> +const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
> +
>  GlobalProperty pc_compat_11_0[] = {};
>  const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
>  
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 82457bdb167a..223a19cc4bbc 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -428,12 +428,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
>                       pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>  }
>  
> -static void pc_i440fx_machine_11_1_options(MachineClass *m)
> +static void pc_i440fx_machine_11_2_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>  }
>  
> -DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
> +DEFINE_I440FX_MACHINE_AS_LATEST(11, 2);
> +
> +static void pc_i440fx_machine_11_1_options(MachineClass *m)
> +{
> +    pc_i440fx_machine_11_2_options(m);
> +    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> +}
> +
> +DEFINE_I440FX_MACHINE(11, 1);
>  
>  static void pc_i440fx_machine_11_0_options(MachineClass *m)
>  {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6c1e4eff5f1d..94cd71124b18 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -383,12 +383,21 @@ static void pc_q35_machine_options(MachineClass *m)
>                       pc_q35_compat_defaults, pc_q35_compat_defaults_len);
>  }
>  
> -static void pc_q35_machine_11_1_options(MachineClass *m)
> +static void pc_q35_machine_11_2_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>  }
>  
> -DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
> +DEFINE_Q35_MACHINE_AS_LATEST(11, 2);
> +
> +static void pc_q35_machine_11_1_options(MachineClass *m)
> +{
> +    pc_q35_machine_11_2_options(m);
> +    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> +}
> +
> +DEFINE_Q35_MACHINE(11, 1);
>  
>  static void pc_q35_machine_11_0_options(MachineClass *m)
>  {
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 6693dea647be..9cc79929a8ab 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1465,7 +1465,6 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>      mc->default_ram_id = "loongarch.ram";
>      mc->desc = "QEMU LoongArch Virtual Machine";
>      mc->max_cpus = LOONGARCH_MAX_CPUS;
> -    mc->is_default = 1;
>      mc->default_kernel_irqchip_split = false;
>      mc->block_default_type = IF_VIRTIO;
>      mc->default_boot_order = "c";
> @@ -1546,6 +1545,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>          MACHINE_VER_DEPRECATION(__VA_ARGS__); \
>          if (latest) { \
>              mc->alias = "virt"; \
> +            mc->is_default = true; \
>          } \
>      } \
>      static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
> @@ -1600,7 +1600,14 @@ static void machvirt_machine_init(void)
>  
>  type_init(machvirt_machine_init);
>  
> +static void virt_machine_11_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> +
>  static void virt_machine_11_1_options(MachineClass *mc)
>  {
> +    virt_machine_11_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE(11, 1)
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index 51158ce1c08c..274970978ffb 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
>  #define DEFINE_VIRT_MACHINE(major, minor) \
>      DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
>  
> +static void virt_machine_11_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> +
>  static void virt_machine_11_1_options(MachineClass *mc)
>  {
> +    virt_machine_11_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE(11, 1)
>  
>  static void virt_machine_11_0_options(MachineClass *mc)
>  {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b79828b4e90c..7e284edd7d0b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4763,15 +4763,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>  #define DEFINE_SPAPR_MACHINE(major, minor) \
>      DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
>  
> +/*
> + * pseries-11.2
> + */
> +static void spapr_machine_11_2_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE_AS_LATEST(11, 2);
> +
>  /*
>   * pseries-11.1
>   */
>  static void spapr_machine_11_1_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_11_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>  }
>  
> -DEFINE_SPAPR_MACHINE_AS_LATEST(11, 1);
> +DEFINE_SPAPR_MACHINE(11, 1);
>  
>  /*
>   * pseries-11.0
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 25a9fa495540..55131c1a4445 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -925,14 +925,26 @@ static const TypeInfo ccw_machine_info = {
>      DEFINE_CCW_MACHINE_IMPL(false, major, minor)
>  
>  
> +static void ccw_machine_11_2_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_11_2_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE_AS_LATEST(11, 2);
> +
>  static void ccw_machine_11_1_instance_options(MachineState *machine)
>  {
> +    ccw_machine_11_2_instance_options(machine);
>  }
>  
>  static void ccw_machine_11_1_class_options(MachineClass *mc)
>  {
> +    ccw_machine_11_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>  }
> -DEFINE_CCW_MACHINE_AS_LATEST(11, 1);
> +DEFINE_CCW_MACHINE(11, 1);
>  
>  static void ccw_machine_11_0_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index 29c68931d8a7..a436d48c8e52 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -815,6 +815,9 @@ compat_props_add(GPtrArray *arr,
>      }
>  }
>  
> +extern GlobalProperty hw_compat_11_1[];
> +extern const size_t hw_compat_11_1_len;
> +
>  extern GlobalProperty hw_compat_11_0[];
>  extern const size_t hw_compat_11_0_len;
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d4b6d3ed57fa..ac03da97b645 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -209,6 +209,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
>  /* sgx.c */
>  void pc_machine_init_sgx_epc(PCMachineState *pcms);
>  
> +extern GlobalProperty pc_compat_11_1[];
> +extern const size_t pc_compat_11_1_len;
> +
>  extern GlobalProperty pc_compat_11_0[];
>  extern const size_t pc_compat_11_0_len;
>  
> -- 
> 2.55.0


