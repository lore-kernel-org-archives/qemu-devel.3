Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549D5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uElX6-0006w6-GS; Tue, 13 May 2025 05:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uElX4-0006v1-Ti
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uElX3-0000cK-B2
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747126956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HE5E63A6rmg07JemaPIfncFI01OB8TrlgBKDzNGQzCc=;
 b=A3gyZAjpLLKkSCg3Dy3xlqXp0sMIP4dz3LQK+Zs0R/vMJMytdk8rLDpojKzh+O7WOAeedT
 uwPb0eryk85ukZEE9Kf8HPY33S5SrMFzlAjh29IoFQHRdCsJ3V0qTN3AXAl4xcR1AslFsZ
 L3oAy5vzuqKylNjGo1RksPu88r9SmYo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-29aGm_mBNAKJOWdl0sRyRA-1; Tue, 13 May 2025 05:02:31 -0400
X-MC-Unique: 29aGm_mBNAKJOWdl0sRyRA-1
X-Mimecast-MFC-AGG-ID: 29aGm_mBNAKJOWdl0sRyRA_1747126950
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a1f7204d72so2232293f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 02:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747126949; x=1747731749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HE5E63A6rmg07JemaPIfncFI01OB8TrlgBKDzNGQzCc=;
 b=VUEGVj1VoHJixNJSBLqTM5FHL/uh3XDt/HMG7t45rYCxI2lM/+jfIm+yeLaMYbftOS
 3e0mVbcF3uvHzCe1tePXN0e3J8iD9Bf6JsNO245J62DOYrWCpI9/eVWfFOZkCipTHHmH
 bFxa8M/w+Bhaiy7WA+tkgeK5oDbHwGOpCEj2lR6ZEzuy4RG49KSTbQ526tPABkiUYgQ3
 pfRcJyTajeqEnUW9BF/rVdo41Et3NQjKgCi0KLr9ukwvIXfvTSax6nRHolu9txXLKB0P
 M2cGez0LXEWBi4DOWMZWSZpL88c+kVM0qQUAq/ZBMD1iEhU+XNfbQw/6mc/7SQTGERR0
 40QQ==
X-Gm-Message-State: AOJu0Yy8Hyd6EWU8KTd3EFGawZbwxUgT1bFnjBdTGX8h7bweq4+TvAnK
 4HFXktfwGVq3Adi/BP3whGsRs/ceQGrzRrqo/z0yYosD5c3afUNLIihh+LVLVIyccA5JPgdq+h6
 m/AyfUolmwwu6DdNJETsk6Cv6Gx/hbiL+9QcjkQWN1Kqq6WyN01hl
X-Gm-Gg: ASbGncvSK6n0fAJ5CWESn5xZYsfci+EWRH+uYaCBkmtMZidaOHcbONlWYHs/cJ02tG4
 AmqYLL2h3NAcSWxQaeDGKPjcVxb3AUE6oV9g8OUV2nmhR90Ir5jfZrOWJprbmG59uvXXuuLavlS
 abG2QiW3fe5se4PqYh7wUZfJ22F87Pwhm41Nv+Z7HDTERkQw5f1WjTtnq/xVzj1KBFu9Lsi377o
 ibVtz/xfaVfxbA51o6Rb6+Nrnn1AQAr3EIyHMgUXhOAyD0qXrnYoMeFEt+YMKCW2WCYv7T+RbeX
 gSd4Hjw9tenEI7lKgj7LddCDBnK5uuHs
X-Received: by 2002:adf:f687:0:b0:3a1:fa6c:4735 with SMTP id
 ffacd0b85a97d-3a1fa6c4838mr8573365f8f.35.1747126949660; 
 Tue, 13 May 2025 02:02:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuyZeASJoiDIgAZ42Fslx6v9M83ncZUjLwgaiHV4EALKZNgG04LuVa4ibD678KGNhv6DCCrw==
X-Received: by 2002:adf:f687:0:b0:3a1:fa6c:4735 with SMTP id
 ffacd0b85a97d-3a1fa6c4838mr8573329f8f.35.1747126949240; 
 Tue, 13 May 2025 02:02:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f296csm15256712f8f.47.2025.05.13.02.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 02:02:28 -0700 (PDT)
Date: Tue, 13 May 2025 11:02:27 +0200
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
Subject: Re: [PATCH v4 21/27] hw/audio/pcspk: Remove PCSpkState::migrate field
Message-ID: <20250513110227.04d709b2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-22-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-22-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

On Thu,  8 May 2025 15:35:44 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The PCSpkState::migrate boolean was only set in the
> pc_compat_2_7[] array, via the 'migrate=3Doff' property.
> We removed all machines using that array, lets remove
> that property, simplifying vmstate_spk[].

same as 14/27, it should be safe to remove without deprecation

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

=20
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/audio/pcspk.c | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index a419161b5b1..0e83ba0bf73 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -56,7 +56,6 @@ struct PCSpkState {
>      unsigned int play_pos;
>      uint8_t data_on;
>      uint8_t dummy_refresh_clock;
> -    bool migrate;
>  };
> =20
>  static const char *s_spk =3D "pcspk";
> @@ -196,18 +195,10 @@ static void pcspk_realizefn(DeviceState *dev, Error=
 **errp)
>      pcspk_state =3D s;
>  }
> =20
> -static bool migrate_needed(void *opaque)
> -{
> -    PCSpkState *s =3D opaque;
> -
> -    return s->migrate;
> -}
> -
>  static const VMStateDescription vmstate_spk =3D {
>      .name =3D "pcspk",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .needed =3D migrate_needed,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT8(data_on, PCSpkState),
>          VMSTATE_UINT8(dummy_refresh_clock, PCSpkState),
> @@ -218,7 +209,6 @@ static const VMStateDescription vmstate_spk =3D {
>  static const Property pcspk_properties[] =3D {
>      DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
>      DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
> -    DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
>  };
> =20
>  static void pcspk_class_initfn(ObjectClass *klass, const void *data)


