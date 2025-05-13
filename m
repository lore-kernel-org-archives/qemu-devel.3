Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B64C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 08:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEl7q-0008A7-RO; Tue, 13 May 2025 04:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEl7o-00089G-Gv
 for qemu-devel@nongnu.org; Tue, 13 May 2025 04:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEl7l-0006in-1B
 for qemu-devel@nongnu.org; Tue, 13 May 2025 04:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747125387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVAl0zVgqH87YvdqKchpA84YKh5NANrF4mrLmsOjL/k=;
 b=fEx7j+gaeARsUcHEOV2MSwTXCCEVdiISPfdJB2F+KVpRNm3wblc6NfEzjiIL9h0kSA3acN
 GprJrHKMx+lQMRxw5DknWi09aPdhifXFxotri/MJyH4SqUnBD9nzEA+SX/Yt4xtJogTyOW
 WvaAyovX5rS11KC1ru7mJstzJWCb5WA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-FP2WxvW3PtWILaNN0TmwTA-1; Tue, 13 May 2025 04:36:26 -0400
X-MC-Unique: FP2WxvW3PtWILaNN0TmwTA-1
X-Mimecast-MFC-AGG-ID: FP2WxvW3PtWILaNN0TmwTA_1747125385
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a2057d164bso708666f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 01:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747125385; x=1747730185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVAl0zVgqH87YvdqKchpA84YKh5NANrF4mrLmsOjL/k=;
 b=k/u22qtzw9zokZlMJ345FqqvM2CTjmzYPzbtvQQlcLiKoqlnC7UKGHEqvl+OktH1Gs
 3X42DJlfrh3/+bztIw9DEEMINEpSKNOG8wq5LJLgkFt2TpwGWyyOHIDhZib9GUxAbEyE
 Ge06HtoO5d84SBLw293+W1QqRv2PdYh7wXbCfdc46czo+Y2qpNNgva6g4B53rHccCugE
 IEG8i8H9Zd4r26ICcfQptbhF+Yrg7KqKUxytNMpY+QSyE4u8CV1/RNjJD5VM7LAT51ks
 tZGFRMmr5VW7L3+mrTv7W57UdwbJKUqJQyj0plhkhLcS9YDa9/56+P90GXjCVso38Tk5
 5QMg==
X-Gm-Message-State: AOJu0YxLah4mlV2YRkpzGZJYdfvoRuUdYAiUrke9v0aknAZ4j/YI8V6T
 AUoUuK28CklRgzE+1N5GxHjfF2J4PwC1f990xVJ9mNuNvc2bhUkbvgJhxB5/RRAhX+/x/6Znwzo
 tK52cDfai8bJzuYZalWP6KvcYD0PadKuj4UNXwSTgS3zGLP3C6PqY
X-Gm-Gg: ASbGncuA7j0fL3nPw1jjg7Jnj3EpZEJsJ2mpuFBrSlzsuUSb/td1Z31CZF8weEv0EuF
 EXEiTtBUxb64U3fwMVBTIIplucSxrzD9mqMrlXuKg6HMb96GsZKD79l2DhLAnTcH0qw5E49NFts
 pCjfafmRvvX8+VIkd2hqTq2+/AdX59QENlBCjS3NrR78cStRDn9UhT4br7cfYCkTHFEUbifhdvS
 j2woLHORR3SIePelDmq5BVgdo+hRsRPLLKMj8XW8IuuLW8IeEb3NCDirLjt568Vnh2QqbiVhtJT
 N3G+9gTkrCH6vX1EZvrE2SaEZ1JZHIJS
X-Received: by 2002:a5d:64ac:0:b0:3a1:1229:8fe0 with SMTP id
 ffacd0b85a97d-3a1f6482c15mr14480687f8f.38.1747125384923; 
 Tue, 13 May 2025 01:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgEYDVr7iQlgSKGrFECgtHY6riy1T/KVm0n7Q+QhUYIat1jVjUcti8+9lRaaJT6mKdrN8lsQ==
X-Received: by 2002:a5d:64ac:0:b0:3a1:1229:8fe0 with SMTP id
 ffacd0b85a97d-3a1f6482c15mr14480634f8f.38.1747125384492; 
 Tue, 13 May 2025 01:36:24 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddde0sm15646436f8f.14.2025.05.13.01.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 01:36:24 -0700 (PDT)
Date: Tue, 13 May 2025 10:36:22 +0200
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
Subject: Re: [PATCH v4 15/27] hw/core/machine: Remove hw_compat_2_6[] array
Message-ID: <20250513103622.07e2fce4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-16-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-16-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

On Thu,  8 May 2025 15:35:38 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The hw_compat_2_6[] array was only used by the pc-q35-2.6 and
> pc-i440fx-2.6 machines, which got removed. Remove it.

see my comment in 1/27

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/boards.h | 3 ---
>  hw/core/machine.c   | 8 --------
>  2 files changed, 11 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 5f1a0fb7e28..a881db8e7d6 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -841,7 +841,4 @@ extern const size_t hw_compat_2_8_len;
>  extern GlobalProperty hw_compat_2_7[];
>  extern const size_t hw_compat_2_7_len;
> =20
> -extern GlobalProperty hw_compat_2_6[];
> -extern const size_t hw_compat_2_6_len;
> -
>  #endif
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index e7001bf92cd..ce98820f277 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -275,14 +275,6 @@ GlobalProperty hw_compat_2_7[] =3D {
>  };
>  const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(hw_compat_2_7);
> =20
> -GlobalProperty hw_compat_2_6[] =3D {
> -    { "virtio-mmio", "format_transport_address", "off" },
> -    /* Optional because not all virtio-pci devices support legacy mode */
> -    { "virtio-pci", "disable-modern", "on",  .optional =3D true },
> -    { "virtio-pci", "disable-legacy", "off", .optional =3D true },
> -};
> -const size_t hw_compat_2_6_len =3D G_N_ELEMENTS(hw_compat_2_6);
> -
>  MachineState *current_machine;
> =20
>  static char *machine_get_kernel(Object *obj, Error **errp)


