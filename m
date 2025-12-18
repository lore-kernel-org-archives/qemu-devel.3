Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E8BD6D22D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 14:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWF4e-0001t2-5C; Thu, 18 Dec 2025 09:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWF4c-0001sN-4D
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWF4Z-0002oH-3c
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766068420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2jclgT+hyK8+FgcLN0D0cFPi3FqzWtgZmEYfXHS49I=;
 b=O+iVhhd+3jQAj5AOVfYoyQel66CIvJ/MwF3DCwj3leLPv4hXKROxpV1YDcdqdh11ZiCA7j
 eA2BKjricdiT1X4Ep67D3STaBIxOwY13gQEIt/VVvYzpDSU4mdL5zObLDdOZaUrqydjzQI
 EU8TOxpOq/Yx6EuKx4QGr+QQRTx11D8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-g4H9GNiQMGaNT7MPOCC7mw-1; Thu, 18 Dec 2025 09:33:38 -0500
X-MC-Unique: g4H9GNiQMGaNT7MPOCC7mw-1
X-Mimecast-MFC-AGG-ID: g4H9GNiQMGaNT7MPOCC7mw_1766068417
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a0ddd1d4so5292055e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 06:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766068417; x=1766673217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2jclgT+hyK8+FgcLN0D0cFPi3FqzWtgZmEYfXHS49I=;
 b=E8s2GHn8TO94firZGhe7eZnj8k2s8oGL7kkuJWUzNJMKQSZhZT/vIJFvTTHxk4FN/h
 dX76C9sCh6CqoRAMrfac41UdX/JewmUsHFiM5HZax2L71enSDojHcT4nd/Toak6a7Hvm
 tDze+DY/rEdKom/VBpNA2S+dn/g3YvcOW/oUcE9bdcCabudSQd8HY/m5HRCr70ackyg5
 tlAze0bSAAq+o47lOB9IIw8NXB9mCPziuWlx6tYksSjyiptEgRjKkvNbXNs9SyXo/AyF
 DubnLPp8ybUMwN9uvKGck/hM8UuXJpav5sFd2xm0z8GN21+Ks2evTxII6MYN4f+v4W2n
 Xt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766068417; x=1766673217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o2jclgT+hyK8+FgcLN0D0cFPi3FqzWtgZmEYfXHS49I=;
 b=bZ/R08W9vcvgaoQFPW8weZ/P1tTgSxv2zNDYAkokSdElH6jbRn7PI+VxkVbXY7jE2/
 qdONL15tvZ16q67FDsM1p2zz8VAVb4d4i3fIjRZ8paf4knzZNNQR/ZrP+ZHY2Bh+vRFM
 ye+y0Zkhos6Y7WHOtRDC++W7+HaI+eSYHIMiT2GGoYkcpDDE563hM2BYk5q/RpNajykH
 DxBf5UvwSQAu4yQpvQ+rqSj4o+7PIGufFs40Ul1A9EHHopZO5i3UGM6sGmts+abWAAx5
 38srVtiwVEn3dMzVo+heYk/N8mJWqDxYO/G3Hluls5Q0FF2j/1NV1apYJ4VOSESmp7Ke
 dPOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfh+S/b5LsMWDvPd736WEe0wPoLDRPbWEvATWrf+K/W9D9MPacC7NkD573Ij7HVA7lc0Ef8ILuKDJ5@nongnu.org
X-Gm-Message-State: AOJu0YzsrkjhAKVTr/kZKF1Nuq9vq752c2HSStEBCz94PRUYpHI9Fadz
 gk7kRhMU/wW6MdNjzjkdLAx5Eo53HYSSa3dZRa9Rj6ZMyR0owP4+y1TSALhy2+nmTlDy1pLddcb
 ketrWj46EXG/aTpFZRUpkKdaScmh7klLfvxfHcihOw9ttWaCb63Ze8KHf
X-Gm-Gg: AY/fxX5XHmmR45hV3dv13DBdtbHoTuFuRavkq6DjOAN6e+nxm/3sap8VsHODO6kYuZU
 JCmbPHEmTvYN3NDoA+J6GEMrMTMKF/fNX4asmUQuvuaoPikdTEc2OFZ1HFo3FabhZWBOOI5WFWp
 JKl7/FNb3s1z6Ds5CQYWA6Vfv7IDZ27lE6LNZu3Eqjwl89jzfpApeNTlkLXp4V1qx8Mrd7uWLWX
 pORUZL6RdiAhxxKlR3x1n+niB1ZYJ20l3u+k5Bq8WqLnBUHC+JlgsrF3CRV0isRUv2pR+4aFXB1
 dQoEOxPqeDE/Kjjq9sJoULi4qy7xwjXYqcn49gb12P39xRuvtkVDnlEKsQmFkKahJxZsFg==
X-Received: by 2002:a05:600c:444b:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-47a8f91561cmr213460085e9.35.1766068417028; 
 Thu, 18 Dec 2025 06:33:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHkM8I8rGTbj5vVhu+IFR0KTxVCJf2Bqm0R9jiEdZksNnyLIDlDTrsToVkrXGVL7udw2ORQQ==
X-Received: by 2002:a05:600c:444b:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-47a8f91561cmr213459505e9.35.1766068416567; 
 Thu, 18 Dec 2025 06:33:36 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a0fb5bsm15679935e9.1.2025.12.18.06.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 06:33:36 -0800 (PST)
Date: Thu, 18 Dec 2025 15:33:33 +0100
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
Subject: Re: [PATCH v5 16/28] hw/i386: Remove linuxboot.bin
Message-ID: <20251218153333.6cb6e080@imammedo>
In-Reply-To: <aUOxBg3bVii1HAOx@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-17-zhao1.liu@intel.com>
 <20251217155530.3353e904@imammedo> <aUOxBg3bVii1HAOx@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 18 Dec 2025 15:45:10 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> On Wed, Dec 17, 2025 at 03:55:30PM +0100, Igor Mammedov wrote:
> > Date: Wed, 17 Dec 2025 15:55:30 +0100
> > From: Igor Mammedov <imammedo@redhat.com>
> > Subject: Re: [PATCH v5 16/28] hw/i386: Remove linuxboot.bin
> > X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
> >=20
> > On Wed,  3 Dec 2025 00:28:23 +0800
> > Zhao Liu <zhao1.liu@intel.com> wrote:
> >  =20
> > > From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > >=20
> > > All machines now use the linuxboot_dma.bin binary, so it's safe to
> > > remove the non-DMA version (linuxboot.bin). =20
> >=20
> > after applying this patch:
> >=20
> > git grep linuxboot.bin
> >=20
> >     option_rom[nb_option_roms].bootindex =3D 0;                        =
           =20
> >     option_rom[nb_option_roms].name =3D "linuxboot.bin";               =
           =20
> >     if (fw_cfg_dma_enabled(fw_cfg)) {                                  =
         =20
> >         option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";       =
           =20
> >     }       =20
> >=20
> > perhaps it should be fixed in previous patch =20
>=20
> Thanks, I find this change was included in the previous patch (patch 15).

Yep, sorry for confusion. /I forgot to apply #15, hence it led to a stray l=
inuxboot.bin/

>=20
> And I have a GitLab branch and hopefully it could help apply and review:
>=20
> https://gitlab.com/zhao.liu/qemu/-/commits/remove-2.6-and-2.7-pc-v5-11-26=
-2025
>=20
> Regards,
> Zhao
>=20


