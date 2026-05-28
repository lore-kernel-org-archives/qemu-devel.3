Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263C6CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTHP-0004ap-Ed; Thu, 28 May 2026 01:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTH9-0004Vx-2t
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:27:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTH2-0001De-Mf
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:27:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so130845595e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779946035; cv=none;
 d=google.com; s=arc-20240605;
 b=eptDCk2R9Ujll38ILejVVBqeIpP3Ta61Rc3yVFvBfYFBn+5zU2DWKt2KPkZxwCW/Au
 nrAjsinbGsn79tRjiaFJsPeWEuQlYxnYPzuOHKvhBL3dPLuNg8vghTXojUcNUL+0XWgt
 QoaWgwGoY5izY52ZhKf7z4CZUPb1ag+aK/UTHRavxItg7U9f3lWz0vkhiBYzAK80VZKh
 wjKc7F2x2MrplMTeV2xvJUHO62EKJL5QupmBB+4yYkdaWo4BCeRC/10GNff1wiB45XjN
 q/uzwbUvVZ6kRPG/dcI2zR0zVAi6fx6txmekti5jfqY9NVKtDJKuGAX/JpiJUevAioDN
 h0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dwneZHjulPfYajXGbepu2ogymN8/pZJS3s1cVepwz6w=;
 fh=XBvXNygMbloJp+VR+lP4ESgdVtRHCxc7UtbU1PDcF3s=;
 b=iO8Fk3tK6TJzh8idWY/kFA2CY5NI71P9sRMOElR6OCJCCv32P8ela5DnBm2uAktwbp
 czwH3xPePXz/kMfGrL6Om8Sd8Mx6w4Bm5Mqc37xMPAq9e4J7RhJ1sTsx7Kcvdunbz6ts
 tLgm7LgVPH7ZSoFsMPDrx49WmnVw6IobPdpXsaHc9vSLiZdDSQ+XMYSFj3f//8MWM0hP
 Zd/k6bfIPwNuYpbgF0s/bpwaVqGzlFMneH6or5NHBXHbt0EF0jvjorIBy4JJm9HCIsS1
 bHp2GkaKjtexU+ExlzOiwAizygDT8us/6/JtdMLAePD5W059fCR3XsW+vXBHMoakl+s1
 wbCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779946035; x=1780550835; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwneZHjulPfYajXGbepu2ogymN8/pZJS3s1cVepwz6w=;
 b=jyJhg2J+YGp45WJYgWrmwnTrsSP5rrSeulPrO2MjpaZ2Y5A4TsGVHR7CDCSl81o6jR
 4bmaZzMhMAdcNtnOKg9huFbx2oc2k1r3dZVZKO67dCGvN8OyT946uGvr2fOq6DBreiaK
 D9+W8dRscVJfYYTOjnJbF8/a2GTQZZchKRyyWqs9BVIP81jzAl8CfjMvp/6goq9QONB4
 dg8FGLG14l5alvHppvXATQQNB64AZFd7crr0c18Z2GAwO889Kml3GfOhN45AVq1PlGU0
 0cn8bKHZdCitl/QBzqoWPsHqGKx4nuwcsx2XqKA/89wOpjU61wKReatMU9YEm9xC/J7G
 vMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779946035; x=1780550835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dwneZHjulPfYajXGbepu2ogymN8/pZJS3s1cVepwz6w=;
 b=XFq3MniktB8RenF/6V2IDUMRmWOoYBVNiLxSbsc7e912m/02CdSu6i7Z5vt0rRIavM
 ckC143TLPlY8c1Q8drMO6RfHwUjAL5Nn++DDyPbSbLfAw8GYuRCpVYxa9SL9/XsAIGV5
 AoizTuT3M7AAX/4g7MEi9fQFQXyFxZMWyo9Jf7a/pTcjVsWTb9nGsIzNT1Ir1JS9MAlV
 MFCUJz0IUHc+L28u5ruWvwsBfbT72D9iBDF6XExWiVahJqRdVc5c7DK1Fn8TiU6wTurk
 /3cDdIvB+2MHUMrX3TUbB0OWIdtBIRgWBuLig2mJbp9TC4vRp3kxaxqo46LL0aLUGN2T
 nSiA==
X-Gm-Message-State: AOJu0YzjkJIzd33VU2caDRn/nFZHO+lcQN2Nr3j2F4GkWaDuSFMyakwo
 gmbfSKRqRvvfbflmFkmUGCFg1FaO5vbcA6z7SRoX5j50jJgc0kSlHN0OpqOQfjtTULJYcwf4Y28
 8PDSWO5mFlCDveNIoGzPskc/lgneJNJ6ix06DxnWX/g==
X-Gm-Gg: Acq92OGbFnPMie+BJOLJk0KBwjwSiD3PIQhnGET14scBpbAlMqxvpNsJ4GlvXYAu385
 zC/HXbJ7Kt8Z2wjrtQrEIb5tBMksuYCkyEu6yP8DcHJnGYFmbV8DwEkKc6DltLOZJ9ku3HJXEWG
 c9gd+Hw3inO5Pr4NFVdUSK9dFoSAqyFNpJzo+K+mwyBB2uFiMwzhD7ztQX2Fmdxsfa76PQDlYLC
 VfgqJlZAks+KMoa0fH0braDgrP2gzISaE3j27+akPRNqyqdPYVgeeGMsNZBkCibji585L1MClyg
 0c+uogfmXGbRpAlNKJBZUm+xR5CfL58ZDKbuthqa38dURJ5vngmPi5gA5qJr
X-Received: by 2002:a05:600c:a402:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-490425ad10cmr347039265e9.14.1779946035235; Wed, 27 May 2026
 22:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-9-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260528051642.115721-9-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 May 2026 08:26:48 +0300
X-Gm-Features: AVHnY4K3wXy-wxyBevY4LiAE0-Y_8HPeNuP4r4Hg7PIRx8AmadzRqnCWGRA1DOk
Message-ID: <CAAjaMXao9QRaHqNPDHt51DPyBVK=JN5B_SStPa4RbqFSw3=P6Q@mail.gmail.com>
Subject: Re: [PATCH 08/10] net: use stub_ss for vhost-user-stub.c and
 vhost-vdpa-stub.c
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, 
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>, 
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 28, 2026 at 8:19=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  net/meson.build | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/meson.build b/net/meson.build
> index da6ea635e95..9c8068b06d1 100644
> --- a/net/meson.build
> +++ b/net/meson.build
> @@ -46,8 +46,9 @@ endif
>  system_ss.add(when: [libxdp, libbpf], if_true: files('af-xdp.c'))
>
>  if have_vhost_net_user
> -  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'=
), if_false: files('vhost-user-stub.c'))
> +  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'=
))
>  endif
> +stub_ss.add(files('vhost-user-stub.c'))
>
>  if host_os =3D=3D 'windows'
>    system_ss.add(files('tap-win32.c'))
> @@ -61,8 +62,9 @@ else
>    system_ss.add(files('tap.c', 'tap-stub.c'))
>  endif
>  if have_vhost_net_vdpa
> -  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-vdpa.c'=
), if_false: files('vhost-vdpa-stub.c'))
> +  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-vdpa.c'=
))
>  endif
> +stub_ss.add(files('vhost-vdpa-stub.c'))
>
>  vmnet_files =3D files(
>    'vmnet-common.m',
> --
> 2.47.3
>
>

