Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD7CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPZl-0002PE-LC; Fri, 09 May 2025 11:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPZk-0002Oc-F9
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPZi-0007Qk-KC
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746804225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbfgctwTat72Vztwb/ysK4sx3FtDutARgQGzZ60JQJo=;
 b=ciuLo88IOzdGZjGQ8vko/8o8fv673kNzLH3Oaxh2W+ZjRFhmNvmP+DZuAI8dthKIzItanG
 D0RXXF8JBUJbtXtboYhNbGsCuHWqbgxsTkUJjsxMS6iKbN+DKA5uExmBC4U3O1s+NoE6uw
 K7lwo+1JWxUZE0adP3tGXbU1+BgxR98=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Vp-T0xV2PBiFwTAh3vKAfA-1; Fri, 09 May 2025 11:23:42 -0400
X-MC-Unique: Vp-T0xV2PBiFwTAh3vKAfA-1
X-Mimecast-MFC-AGG-ID: Vp-T0xV2PBiFwTAh3vKAfA_1746804221
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so10560505e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746804221; x=1747409021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UbfgctwTat72Vztwb/ysK4sx3FtDutARgQGzZ60JQJo=;
 b=kkW/DYpmCqcVpz/DZGXDnUxNv9NtyLEYUADvvGsbmSDz3b8rif3G2dXslz525Z6OZv
 ZKV4kHDZDE7YB/tk4oX0Sz0yJ048656nIZrB/qRrQSn8j+JJKvv4fusbTNd0rMV1Pd7R
 8+qMXNjB2o6apYgHedaxsMekUkZyfU7UDuZKpADk3mk/XpWmQt0F33lxWyUg9hnGDIO5
 hQVq7WoS/P4ub9b0fl0Awar+uHBAH303+l99agATTZDuOMXk7v3nertJ5v7cHziXORBh
 lkHV4ZlyHdy778HEm28e1STcbagDm8K8Y1cbzAPRfT1nek2QIXEg5QF6Ibe+WpN48v+a
 t3FQ==
X-Gm-Message-State: AOJu0YyRjDRXmoGPL9tg64bHifpS0wkB8VDhz1PwzI9Z1D1482RUCRdB
 lPlcQTpND/OEBJAt+q74+3VvDsEXut1dZ9kMUFKTJB5gTt2NWsbwMaTsXwljcIcYm4kUuG+55oh
 8FOAwopnnp/agiU1cv1c2yHQ2LzmFglMlKBDRzJwfstjK1U9StDzc
X-Gm-Gg: ASbGncunVzQEMWIJ1syD0EnEn6mhn0Cn5LxCX041dDcQz4yjuEHldiVjkV/I+MunHi+
 rDxA1q0685p6cnG+LXF2TyvvLxaypqKwReCvcfUozA4SdC2TqmRvnpL+s6DMhG/vQCTZ/2GNTh2
 w3XH+oh17XlEk5ILxpZuf2AoNd1/ZCjBerhp5I7xVsYlOy1q9Xu7sf7CAUdx5tM4ByyFG8dfH9V
 w5z/J0pUmPJwny/OTHg9Ikrru+Uh3obOxT+JFgQInfmrYBZir4mQRYwTA0Vcee4BqgEV1xsMW5W
 QvvYLBUl6Ru3GorxArkNurOQtVqPJv8C
X-Received: by 2002:a05:600c:4e46:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-442d6d3dafbmr37079515e9.12.1746804221455; 
 Fri, 09 May 2025 08:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP9pYN9puPiqkAj4uLWOelxROpw1y+p6NieMuknXnqrPphphHn4Ue+I3VMsXEnn2/RaKCr7w==
X-Received: by 2002:a05:600c:4e46:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-442d6d3dafbmr37079275e9.12.1746804221031; 
 Fri, 09 May 2025 08:23:41 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67efdd0sm32939935e9.24.2025.05.09.08.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:23:40 -0700 (PDT)
Date: Fri, 9 May 2025 17:23:36 +0200
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
 Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 01/27] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
Message-ID: <20250509172336.6e73884f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-2-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-2-philmd@linaro.org>
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

On Thu,  8 May 2025 15:35:24 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.

if these machine types are the last users of compat arrays,
it's better to remove array at the same time, aka squash
those patches later in series into this one.
That leaves no illusion that compats could be used in the later patches.
=20
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/i386/pc_piix.c | 14 --------------
>  hw/i386/pc_q35.c  | 14 --------------
>  2 files changed, 28 deletions(-)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 7a62bb06500..98a118fd4a0 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -764,20 +764,6 @@ static void pc_i440fx_machine_2_7_options(MachineCla=
ss *m)
> =20
>  DEFINE_I440FX_MACHINE(2, 7);
> =20
> -static void pc_i440fx_machine_2_6_options(MachineClass *m)
> -{
> -    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -
> -    pc_i440fx_machine_2_7_options(m);
> -    pcmc->legacy_cpu_hotplug =3D true;
> -    x86mc->fwcfg_dma_enabled =3D false;
> -    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
> -    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(2, 6);
> -
>  #ifdef CONFIG_ISAPC
>  static void isapc_machine_options(MachineClass *m)
>  {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 33211b1876f..b7ffb5f1216 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -658,17 +658,3 @@ static void pc_q35_machine_2_7_options(MachineClass =
*m)
>  }
> =20
>  DEFINE_Q35_MACHINE(2, 7);
> -
> -static void pc_q35_machine_2_6_options(MachineClass *m)
> -{
> -    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -
> -    pc_q35_machine_2_7_options(m);
> -    pcmc->legacy_cpu_hotplug =3D true;
> -    x86mc->fwcfg_dma_enabled =3D false;
> -    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
> -    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
> -}
> -
> -DEFINE_Q35_MACHINE(2, 6);


