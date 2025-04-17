Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27433C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MDj-0007Bb-Ve; Thu, 17 Apr 2025 06:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1u5MDh-0007BC-4R; Thu, 17 Apr 2025 06:11:45 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1u5MDf-0004Rn-6Q; Thu, 17 Apr 2025 06:11:44 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-601b6146b9cso284032eaf.0; 
 Thu, 17 Apr 2025 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744884699; x=1745489499; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yv569aO+68CR5igE+NS26WydbGWF40qimu3VHur6i88=;
 b=GddAlyGQUUg/ShuYblWNy6qFF3Xi5IFLEWqbAuK2QF1SYXcMf1sZ/RxdmIiu3xPA0K
 BJKufx5p4buEl2iegFOqocgylzwymb0yfeNq1DdPOLP+yXvB1gdmD1qKDVdz8BPF2bRQ
 vmN2vV4ZtjA5SRienlJxqkXW0mP3fywvfGpv9OL1aF1t/jWrgHJIp4I7VTdbcNaHTJqz
 Yonn4v36A+IRL49m0k/7g/ZqMZSkj4rBgnvXruCrTLIWKDaAnanImaI9dHCuS93jFo1Q
 zSRtl0zJyLPgrFP+T8+KfmXGzndJCHxMJlcG/91tkuXRn3Nkkub38vqoMF/1dZjRwwwu
 jfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744884699; x=1745489499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yv569aO+68CR5igE+NS26WydbGWF40qimu3VHur6i88=;
 b=kZA//zKvBdNdB/jUs9U5p872DYYtlfJYdfY92ZSvMMsVaBaGAWtS01LNCv49IL80ad
 4KYPVO8KPKDO6ZTn4Iyp/VvgT95p9bSf5flb7Ifj5pRoJ+pgfu8cS037300miWRJh9lJ
 b7Pyno5eC1HGq5YGRzK1m8HFhrkTplO7k3PHvcZ7q10aFdvUczs5NA3IHAzLPeO/n9eT
 gNtBBCq5jc7L3OdtG+9VtrKXuNczHS4Zp8Rs5fFAuLFqxAB1VXoKShERuIxybzkh4npT
 N1EqB/EIvOXc7muT4Vbcfib0PmmMgqoV3+y49BXBPvI+/wvJ6jq2RYumKufsmyDga+K3
 iHlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaP6NPG121RW5rGfhVzJY4cf16yFz3o3FBk3a13XNuLACoum9VkAWhUqoxR3qj9vIP4Aowca9P/ce6rg==@nongnu.org
X-Gm-Message-State: AOJu0Yw8YOxi/KfECL8nVaGWKUd6QRy+dsv8NxcWdhL4ZfRyyWKy24tX
 r4qxHUoKQxvzkLecAomDtee7quGshiYenacQo0fbKtLingWpois/5fEG/CVQ7jJYPhjLpfDyZuK
 Ipph0ePQGWStJsZAaNTyeUE03Rhc=
X-Gm-Gg: ASbGnctAot6wGaV/KFuQu256vVhy2yFVCMdbpMrBRlEjUIefvxVhAWVte8X/w68vYju
 YrhXSFvqa9tqdO9W7nC5M3s9/MVfI5NT6d+lMAjyq0GVMleK7JkTfVs2c1iV8tyc9A1IjLerWp7
 c6RsAZAF1z8WF5/XR5rVZZkURBpIviLKRXeJ6n+VohP+ZpmA2idmC+ttOI
X-Google-Smtp-Source: AGHT+IFvkqY3R8EDBSMVwwtqK6VrbvJMpORRV5SWiJ9sUZzBcDhc5XmStTHActdzZedWZP0cGc/4IqqTVc1kkPTSDIg=
X-Received: by 2002:a05:6808:159e:b0:3f7:ccac:287f with SMTP id
 5614622812f47-400b022eff7mr3206873b6e.27.1744884699242; Thu, 17 Apr 2025
 03:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250408185538.85538-1-philmd@linaro.org>
 <20250408185538.85538-2-philmd@linaro.org>
In-Reply-To: <20250408185538.85538-2-philmd@linaro.org>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Thu, 17 Apr 2025 12:11:28 +0200
X-Gm-Features: ATxdqUFJ5N0PrH4VQnHUnBQ3Rl0mizJFzNP_RgCtcQR5vJlCUVzwqIpN0xYmtpU
Message-ID: <CAO8sHcnLO8L_iYhzaQ3UBvpm_NTPpKe-AyNijJkdf-X9zRo6GA@mail.gmail.com>
Subject: Re: [PULL 1/8] smbios: Fix buffer overrun when using path= option
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Valentin David <valentin.david@canonical.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-oo1-xc33.google.com
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

CC-ing qemu-stable again to hopefully get this backported to the
stable branches.

Cheers,

Daan

On Tue, 8 Apr 2025 at 20:55, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> From: Daan De Meyer <daan.j.demeyer@gmail.com>
>
> We have to make sure the array of bytes read from the path=3D file
> is null-terminated, otherwise we run into a buffer overrun later on.
>
> Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support load=
ing OEM strings values from a file")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879
>
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Tested-by: Valentin David <valentin.david@canonical.com>
> Message-ID: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/smbios/smbios.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 02a09eb9cd0..ad4cd6721e6 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
>              g_byte_array_append(data, (guint8 *)buf, ret);
>          }
>
> +        buf[0] =3D '\0';
> +        g_byte_array_append(data, (guint8 *)buf, 1);
> +
>          qemu_close(fd);
>
>          *opt->dest =3D g_renew(char *, *opt->dest, (*opt->ndest) + 1);
> --
> 2.47.1
>

