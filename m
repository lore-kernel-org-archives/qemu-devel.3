Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5677FCD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 06:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTxU-0003Di-RP; Thu, 28 May 2026 02:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTxT-0003D4-74
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:11:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTxR-0004Ep-Fv
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:11:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45eebccc346so44092f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 23:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779948663; cv=none;
 d=google.com; s=arc-20240605;
 b=VINsz6/oNba+IsY/GFYWe22xZ1bmFuOviKrSSu4obxJGj+F+ErqDX/lGHuVlCQIWop
 o3J7DXo9TFj2gY0FvX/Ibh0dXkBCdqY0LcrfWL/3xzoFzpAMwZJ5WitNOSHSBhjpOBxJ
 WBBQU8+wlgmBMvVEGMHlJ+RBSh1x5RjQnH5NCeTFEKZpfap1ufVLRZHExrft0Pw0rCV9
 ctvfQEF+ZmsXBH7ZM7lWwmE4aRZtXDu81ECC3XM0cAbjm9UbGPDC/zIkWByDSXkXFTep
 QjzLzpCkDKB8nyy6c0bSInW93nb1JTFncxQzYRY2SrN0prj3B98iKvaGwYU6ieL0QIiu
 54zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BmP2mmq5DU6SnVzp3/Y3fQwcmxPvDtZzg2yLss5TQQY=;
 fh=XBvXNygMbloJp+VR+lP4ESgdVtRHCxc7UtbU1PDcF3s=;
 b=UfrwpEFTwRsFC9AxUx9bMqpPVz+3LIBweGoDUgKX7IoscJE1CyeqaJ76g01dMJkaDy
 JH+dNZ2ieZ0fcw1uhEfnp4tZ1XcW8N+apo7chUIVOT/EZ+tDyccvgz7t22SSnCbJmlpJ
 2aAPLOvA40i5D/KNe+58kwVy/x5sLBCSq9iQ0/8LQPHgObb3UNCLY5XgVhxh3vqyaXM4
 Bc2sUNivBThMnAP2nuLIxrZSiupjbynV/XKeZZDJTu0r+cnYQl0Q1dtNHIDYCP8O/2kz
 /Dd8xCEou8FNs6eVA1gMbKZivn8leRzQXNpM4p0EUWr0wMFYwqZLpbiNHsS/SL5/aFHa
 Xw4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779948663; x=1780553463; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmP2mmq5DU6SnVzp3/Y3fQwcmxPvDtZzg2yLss5TQQY=;
 b=rKcLT9T8cPXSwpHJJHtqWah12HeEu3OwHhKYCeCpH4PLIF5Tb75OPGm7IF4BaCjxqK
 Z5D761XsMnkiQmLXotqrhWOVMoxo3F7e2ZWkCxIeXOEHhhE0box54pT3iGyhV8kl9yY1
 J+PMw+AkvvXBSw+URxdy2YnDHbmnrSRELgcNcEs+aTTCR/7EgYbiit7YWpxiKrTIPUv3
 Vp6qN47pB52PZW9mO4iHNNpfEtftxtt1TJ53YGXl7lDAj8puh5IyVOAfzd9nViGuBlTu
 ikjv2edIgKiRPYH02aI6a+xZGZAqps9PLVUWPAo7eEMkoza60f1n9l9vpjdbspinzayV
 sByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779948663; x=1780553463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BmP2mmq5DU6SnVzp3/Y3fQwcmxPvDtZzg2yLss5TQQY=;
 b=jdfkjCK6u9PVLiiRI6nONebwcP/TH/RhzsY3wf1Jng2Cw6hTiTbZo5HnP0ByrS4XcO
 awMNuJNb6SgpnYj+rGDx3bYSin/Lb7yG2O8041fD33rtgvOpSH3D6MnZtEHkKj9XzesZ
 v5w1M/5U4Z2TTSCqBNs8f/P6irDp9KH9it/PPAZ4twRjb1MnBSfxgo4fwIvK7YUbMG32
 OZIzczUoPzl1/uxmU0/ICJfkN3J5NjDD8Av98BEyh0iUTkF3JQD9F+dS4nrW7E2KS6FT
 wlPiATJL+f+z4EPP80kymVrglYrG+lSekzZiw1raokCGQj1kT3eW1VwclCAluUu2dEKl
 07bw==
X-Gm-Message-State: AOJu0YxlSPpIfKhFb0vc8/Uvaaz4DVLMZB4ngX3wtnTSEC+o+WIdplwg
 rSr9460NecSry7Ng4CWQxJ8iJZr/Wu9dZaohb/Gk3OjdhFQf0CNX5HiWjsjww1aF9v3gKqxCFCB
 JTGxVTvBNHIbCHnV/dU+OIVwxisuUK8VgqTeaBSPRow==
X-Gm-Gg: Acq92OFRx2cSiUzFUDpgBhDuf2uR1lvHHRcr77JQc44IKwsrSYNTGrhcQrH0dwWMatB
 SJpmYEruucruZrWHtGWZYh91hHgVnHq/NPo2uEJxlrQY/NdtYoy/h+3Qwca0atAbws+SOG7J0fi
 ztkcSrM7VMA+jSd7g3WLDBcxEIPJvKIL0L6VBUsFhn79JpodgdgsD4ZxFxX6bKMFhREyNThB86i
 s4KHe+Z/KAee2uiI43UyIoEIudfjKHAgfFJcVqsTPB+a5ouoQH22/vcU2HfzrC6+GJ9d45BWj7s
 /jN/LzWZfBsu4NKhS3S0QpPSxV7UEzbyWFxqy8JfYlm3urNkmJ2IwAqST82U0ndGxYeG4ro=
X-Received: by 2002:a5d:5e87:0:b0:45e:eafd:bb33 with SMTP id
 ffacd0b85a97d-45eeafdbc63mr595844f8f.29.1779948663291; Wed, 27 May 2026
 23:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-7-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260528051642.115721-7-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 May 2026 09:10:37 +0300
X-Gm-Features: AVHnY4JHzF2g7cNPKdI8yWGi-BoNXwjgTxUCplvyczRd5X9FUcNlnhGVFGoJXfw
Message-ID: <CAAjaMXZJ395DJmNGUrEivN3=+3KZRgYHxn3OPKMQw-D9Q3E3Dg@mail.gmail.com>
Subject: Re: [PATCH 06/10] hw/net: use stub_ss for vhost_net-stub.c
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
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Removes conflict with several targets where some support vhost, and some
> don't.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/net/meson.build | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/meson.build b/hw/net/meson.build
> index 31025874699..84f142df222 100644
> --- a/hw/net/meson.build
> +++ b/hw/net/meson.build
> @@ -48,10 +48,9 @@ system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: file=
s('net_rx_pkt.c'))
>  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
>
>  if have_vhost_net
> -  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost_net.c')=
, if_false: files('vhost_net-stub.c'))
> -else
> -  system_ss.add(files('vhost_net-stub.c'))
> +  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost_net.c')=
)
>  endif
> +stub_ss.add(files('vhost_net-stub.c'))
>
>  system_ss.add(when: 'CONFIG_ETSEC', if_true: files(
>    'fsl_etsec/etsec.c',
> --
> 2.47.3
>
>

