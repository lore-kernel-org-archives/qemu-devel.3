Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A809CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 06:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTxv-0003S0-TN; Thu, 28 May 2026 02:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTxs-0003Qq-21
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:11:32 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTxp-0004Rq-NG
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:11:31 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45eea3448f2so102022f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 23:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779948688; cv=none;
 d=google.com; s=arc-20240605;
 b=UoiXJc0CMBvXpKln/scAIzAQmgD1EXW2qUYW1zAvYVCgaa91Upsxv0RnXYlIPtblFL
 HONPt49CceptN8iYQEucL3PYx48R+/KX3979J5xRO6BAbIEUZD+2EUJsb9RBhIop8z9H
 fs2W2W9JvOaKNX8gzpcoZO30hrlYTuJfacww0L/nzWd9AEEDvYRINIk/yZBZzXD2xr54
 704wPmisZYx1icNDTtNjJ47uElVGAzvdJb+YdQDvHc7Efobc11PPzjWJO3aC3CGilCSc
 mfnfSakRQDVGR8vPzzEecIFb0XpnvT17bRU2XbxpZKG55ROWHRRAQ9Y32SBhvSu9tMcs
 Y0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=987p3tTTfT5NU3Jz/Tj67qE9H1wl8NyOwiSvElqoVHY=;
 fh=XBvXNygMbloJp+VR+lP4ESgdVtRHCxc7UtbU1PDcF3s=;
 b=ImBtxevOmmBBbGZm+ldUEL9Dt0QGJvMtwxUzDXeH2p2Qjx2HhJu9SqTdq/NB+URm9R
 MegOijEy0OcprfQUjSzfToIrNLHL27aVvx1hUpZjwXxwv26m7qujzHVBatI7+L6nAOKE
 ri3uH+KvFoG98oFQ5swDutfFIsYj9Hi4MYp+BEOgGP8MNKdt3CLGG0qcH7/KlZ2qYtE9
 ItAGH2wBLcOJe9n3x8y+3WLn+/x/UZDSUMWW3fJI441ljAdMC/ziPFvGKcT7LJIOxbE9
 joc9MsLmHeAExTZf2VhML5HP1yE+SP7zC63WCaUrZ82Hm2CjYenMnIQpBxo2mBouraiy
 whfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779948688; x=1780553488; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=987p3tTTfT5NU3Jz/Tj67qE9H1wl8NyOwiSvElqoVHY=;
 b=uV5ZlCadyw2VGfLinawnfv+DRYwHMhuhSf1F7PTF4uECphnewgeUo0DoINdS4AFfaR
 CEMjfZx6zGqAn8laR7+xK8dWQO/JoP0I/AJRJZuaUddciqIXsT8d+s38nj9Z87cjvP1W
 Lb1cI3vlqbnE1hBMDdy3x2sMxQ7KG4E3fCUTQ/E/HjUrm5QfoFmKlouXsiHacryOy0DC
 bgHgCv6NzJaGxdqRnJdxg4e7TAbR3Nxbaj+yaD08gEIsay1C6yE3/Spu8LhEPyaxwf9W
 nDtoYIMqDpblQVV8fE8VhVMTY4NVhe2XRpHkPcWGzwOqG8t87QDIbcyMS82GtoCyBLcB
 oawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779948688; x=1780553488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=987p3tTTfT5NU3Jz/Tj67qE9H1wl8NyOwiSvElqoVHY=;
 b=bJ/D10YUZqYcJQhYxva8/4Te95a9Wh/9UvARWt+5TIdF4lco4zep8sY0D2kUwgqs3v
 /R/Yh/7k2M4yXaC4ojLAQYMXUfVXXUKr06HPeJAE2oLR5ZOjWAsHCI+edupmozgj0B2n
 soPenIK7aqfA/mdlgmb6/BHXUr+eIMPPJ8OfjkjoPT9cK+yoata4Gek9VdUaiIXR47l2
 u3V0Iv3VvF6PkZNwYcf2R1TviRcNS3b6ioltzeG7Td6ij2mX6+5F6W8wYW8rkXcgP/aj
 8w88BqSCIgu/uylpIguj35GtpM3MyTyFrplgnKu1eSdSl+7XosXL6Lw7yavCvp2euQ+P
 2KwA==
X-Gm-Message-State: AOJu0Yw3pGSUfmwpKl0KG9dj+q9i2MSeWBK8e/FtKWNxbEpdWP74gBKm
 fj3eYnx1VZscdWIU40JZdY/0wjo5OBriLZwQfr3hZk8D+SWIFoRQsIbX1F9gajdebTfn4R4LgM3
 iS5kuldvj7S9BYYPA4jSmstax6xnGncxuG5NmvfH1fw==
X-Gm-Gg: Acq92OGsS/X+7hVxF/DzrZTxs2EUr3yfnlMTs/l+EOQkS5rt6uxAheGiQFjo7jVZNC1
 ozv+CbRrOF+i0aZkfdtL/K8UUUa8CVgX1XhfXYJMpl5iOT2cSdxnQ63cxyqbuUwzq+vdriN10pA
 WD2zo0qSKQIBSDsl+sd86LkPqh7mQMwVqGGPCMBCr/6NVU6qzKXPxhi9CAOcPf/KspcokwCVzXl
 E4XxrZ50Iq4+3U+SSgdSLr54A+imTWPkPrqL0yPVNYxe+EXvVHAtPmgzYDd81mDEqey3c2zY+ll
 HsbNSjZNCRh8/6EjARxOpbFVZbAh8eRbxbL8QcLxO+9fRAEgsLG26JxqJ0W5RD68JUO3WKM=
X-Received: by 2002:a5d:5e8c:0:b0:43c:f90b:5668 with SMTP id
 ffacd0b85a97d-45eb36acd72mr41400771f8f.23.1779948687025; Wed, 27 May 2026
 23:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-3-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260528051642.115721-3-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 May 2026 09:11:00 +0300
X-Gm-Features: AVHnY4I-NlqunV7wGFvsqjvPsEW0Kz4bYN0AMsmvycIhhQ5fzxo0IqI0aq8IobA
Message-ID: <CAAjaMXaajQ0XsZmru3rtkT5G=0Zf5w0NUNdeeoq0P7pchc1iOw@mail.gmail.com>
Subject: Re: [PATCH 02/10] target/arm/whpx: move whpx-stub to arm_stubs_ss
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
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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
> This eliminates symbol conflicts for whpx symbols on windows-aarch64 host=
.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/whpx/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
> index 3df632c9d30..7385c14f534 100644
> --- a/target/arm/whpx/meson.build
> +++ b/target/arm/whpx/meson.build
> @@ -2,4 +2,4 @@ arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
>    'whpx-all.c',
>  ))
>
> -arm_common_system_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub=
.c'))
> +arm_stubs_ss.add(files('whpx-stub.c'))
> --
> 2.47.3
>
>

