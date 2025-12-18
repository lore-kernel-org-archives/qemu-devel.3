Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9C8D6D22A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 14:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWEy1-0000So-O3; Thu, 18 Dec 2025 09:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWExv-0000RY-SS
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:26:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWExt-0001Ov-HB
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766068008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82hiJN0/5F2+dRtrDEgVb12FI+OynQXRA4CdmhTgEHQ=;
 b=heF1tdcwbMTD59v9CytuaT3AoxixjUXWCqq8uP2oW6TEtN5tW2NLwIYInJ0nYB/32LNe++
 ATlTOZqT6M8iTzv/EkgulSWl56BgX7uiqZaHG6DvbyMF6peYdPAHuqBd036iQrM2aun7uY
 9kGrsfE/iRMzNSf55uo4JpJFRejaQzc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-O_PRjFiTNI6f6iebozH0Rw-1; Thu, 18 Dec 2025 09:26:47 -0500
X-MC-Unique: O_PRjFiTNI6f6iebozH0Rw-1
X-Mimecast-MFC-AGG-ID: O_PRjFiTNI6f6iebozH0Rw_1766068006
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b7d28772a67so75893366b.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 06:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766068006; x=1766672806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82hiJN0/5F2+dRtrDEgVb12FI+OynQXRA4CdmhTgEHQ=;
 b=NHj1Pl/P2OyELqejQW+bNMFo7vkvtabYqPxyE+lC0qkKLQrvdjCVSAC6sX+MVulFHs
 K0WAqncXXCf2NRj1ue9n34HT/iy9jQgdtSEVuIN4XL2RgkV9OjY4pvxepVTMfEk5eUvi
 zVLYt5TYnAQ4rjJXndnjkG11XDf3EWFwkFFFW1QkQp/oBx+o2X00z20E50nC1/DjK+Ss
 hGvJV7kzGKGrhBPhqxXOp+HxstFnOkKKeF3rj9A0+kaa+0pCZbvjjFyqQTyOA07+vf+w
 VQ4suWFahsEwLVKpNKRKqi33xPMIdwfo+BhIdK7zh2eaVVpC8B1Xkl9+NiV4uMCmJoqN
 0xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766068006; x=1766672806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=82hiJN0/5F2+dRtrDEgVb12FI+OynQXRA4CdmhTgEHQ=;
 b=Ke+5007mfkezU8O8HUX2oncZtyYRMnU0InlBqio5B3YV79jTyOTzsaN21hOkj9zWiw
 tKYdafoa7YEBJ/h0A5PCX7t5bBnF2C8e3yfaNACkGAW4s0l6rhfdPkVx4dusAg58QB1k
 JwF3mFrsLdxlETxKFaj/LPGddXTceMUFAQfKXgoLr+VHC1nYJjuvOKgjInm86qvt9nMt
 jhp/W2XQX4EfgkXPYvyp25BkHT82sATsseUDOU06sM7HT/5eppskWOXLEa5c6MAEacfy
 uSOl7IRpte+N/HjcXRdxUYgTJ5uYrCe6x7uUHRXSct2zLuJa5o/llurIM2v4ANn54C8v
 JUjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYm7oOxrA3IlE6YymkYcGiZ3GJThi8AiK3r5SLPh7pPmQVkrvxdCqZcKut3svgp5qHxnYCZLWt46LM@nongnu.org
X-Gm-Message-State: AOJu0YxOz8VWtxO6dotl0yjD9bGw1z+EdHydzrOc7pCKISSeirRL1vTs
 nNSlfUj+9Bs2j+qe0yzgfsS0/ODcQoSWiKfVyeFiqJvawXA//9rt6ntxZVDjGtA/6K1gMlfxMnf
 F1dftHwffJ046KOjoGapXbBL/+ggP4OUO8e8oOAgL7CknmCJkV87YOghZ
X-Gm-Gg: AY/fxX4GpN8116fF0qJJWjj/fBSjJYO7W8u58kmvLs8aRTnvvQNSp1M/B6U83JNnKkL
 QhioZhZfiZtuL538Y2z1uomntjbzEIMQOmwNL0LNSxNJBg5WTndPlvUBILciTAzQhRc8izCl2lS
 cp15ThzszUJfP0jFaUAa3Wtw3Ea9tEFosu0y/rZBh3Hjobfd2c4UjHsUsmdROrsdB8ltlCthA3S
 sZALsmyUvHKIwtFGgun3vO0nHCALZgwLSLHfjJg1MBrZ2ensyULTqFAuobiCHEMTuMXC8qB8++F
 yvXU4jIodFXXfpHmlZBbMCtM+RphwqGpvPidW55KDaP5mcshntWLTONK8y676DCQhPV7ng==
X-Received: by 2002:a17:907:2d89:b0:b73:8639:cd96 with SMTP id
 a640c23a62f3a-b7d23668f88mr2273370866b.24.1766068005927; 
 Thu, 18 Dec 2025 06:26:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz69NP3JT0pAAUlXIjoFd1NFW/0F7KYZI/65Y+y5uNeHQ2bp0ZijtV0N1YN8UJawKqiCLYCg==
X-Received: by 2002:a17:907:2d89:b0:b73:8639:cd96 with SMTP id
 a640c23a62f3a-b7d23668f88mr2273365566b.24.1766068005406; 
 Thu, 18 Dec 2025 06:26:45 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b80234a2ee4sm238557166b.57.2025.12.18.06.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 06:26:44 -0800 (PST)
Date: Thu, 18 Dec 2025 15:26:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas
 Huth <thuth@redhat.com>, qemu-devel@nongnu.org, devel@lists.libvirt.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Richard
 Henderson <richard.henderson@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>, Amit Shah
 <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Yanan Wang
 <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Ani Sinha <anisinha@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Huacai
 Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>, Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v5 28/28] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
Message-ID: <20251218152641.007ddd92@imammedo>
In-Reply-To: <20251202162835.3227894-29-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-29-zhao1.liu@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed,  3 Dec 2025 00:28:35 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> The VIRTIO_CONSOLE_F_EMERG_WRITE feature bit was only set
> in the hw_compat_2_7[] array, via the 'emergency-write=3Doff'
> property. We removed all machines using that array, lets remove
> that property. All instances have this feature bit set and
> it can not be disabled. VirtIOSerial::host_features mask is
> now unused, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/char/virtio-serial-bus.c       | 9 +++------
>  include/hw/virtio/virtio-serial.h | 2 --
>  2 files changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 673c50f0be08..7abb7b5e31bf 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -557,7 +557,7 @@ static uint64_t get_features(VirtIODevice *vdev, uint=
64_t features,
> =20
>      vser =3D VIRTIO_SERIAL(vdev);
> =20
> -    features |=3D vser->host_features;
> +    features |=3D BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
>      if (vser->bus.max_nr_ports > 1) {
>          virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
>      }
> @@ -587,8 +587,7 @@ static void set_config(VirtIODevice *vdev, const uint=
8_t *config_data)
>      VirtIOSerialPortClass *vsc;
>      uint8_t emerg_wr_lo;
> =20
> -    if (!virtio_has_feature(vser->host_features,
> -        VIRTIO_CONSOLE_F_EMERG_WRITE) || !config->emerg_wr) {
> +    if (!config->emerg_wr) {
>          return;
>      }
> =20
> @@ -1040,7 +1039,7 @@ static void virtio_serial_device_realize(DeviceStat=
e *dev, Error **errp)
>          return;
>      }
> =20
> -    if (!virtio_has_feature(vser->host_features,
> +    if (!virtio_has_feature(vdev->host_features,
>                              VIRTIO_CONSOLE_F_EMERG_WRITE)) {
>          config_size =3D offsetof(struct virtio_console_config, emerg_wr);
>      }
> @@ -1156,8 +1155,6 @@ static const VMStateDescription vmstate_virtio_cons=
ole =3D {
>  static const Property virtio_serial_properties[] =3D {
>      DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_=
ports,
>                                                    31),
> -    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
> -                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
>  };
> =20
>  static void virtio_serial_class_init(ObjectClass *klass, const void *dat=
a)
> diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio=
-serial.h
> index 60641860bf83..da0c91e1a403 100644
> --- a/include/hw/virtio/virtio-serial.h
> +++ b/include/hw/virtio/virtio-serial.h
> @@ -186,8 +186,6 @@ struct VirtIOSerial {
>      struct VirtIOSerialPostLoad *post_load;
> =20
>      virtio_serial_conf serial;
> -
> -    uint64_t host_features;
>  };
> =20
>  /* Interface to the virtio-serial bus */


