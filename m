Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0419CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTGT-0003YH-TB; Thu, 28 May 2026 01:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTGS-0003WQ-Va
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:26:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTGQ-0000xo-2c
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:26:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so7539794f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779945996; cv=none;
 d=google.com; s=arc-20240605;
 b=lI242RkkokMedfuQKI/RF+mOyoquQw1vwiSFqyKE11nToCkozaNGOidIb9hnNYSqAr
 bSsuNho03hIpARH9N7SaeDyCBbZTXoKqN4aYmcKWt2RpSmbHMQa9lWzr9qWFJA+5nbJB
 rxOY3pdSxYpZP2udWtQGb0NIjB2bnai6Q7j6kbE0YF2gLr530UgwryyuGi+GRz1xnsBt
 IxolloMzp/etGcn6SKtPZXmYALlehUwgnH8XCDUwid+Swln+CvRlhNr8lIvXjifIw9im
 lxK/G1Z5/SuBgPn9Gks5UFM60H6VAH7BqVCJ+4jqe5GnO2lAV8LuYvMREIkRrlgLnD6l
 iaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vANGD2vKWELwqFShufjM35Wn78nC95DsZ2JfSKglkLA=;
 fh=XBvXNygMbloJp+VR+lP4ESgdVtRHCxc7UtbU1PDcF3s=;
 b=P0Zt3iqtbdS17D5WpVIx0uemctxIGjS/ExHPeKdjbBY6HjU+XxBW/HcNweIvLd6Ooh
 KcZXXT6UcQruQDh+EdExxyp5aS/OwJC00roHmTgCuoJ8lkbPNnRxbvpFVNHfDR47tGWa
 y1zUG05RQGGXF/1GxS/7I8oFlIfUalK8AUTy/MlzI+KQFvJG8sEEgVn9BcPE3YBXs7pX
 axHQeYnB7QQLNAobctluOKvwpH7CynjGYD2ImdojFb3QolvIn/3CHUYDoXdr5t0Qsjo6
 w/kgN7uHoU7qgGm2sVMdZiC7TO8osAxUZZMYUp3hcOoI9fuy95goy4uo7UW1HnqeM2AI
 Ogng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779945996; x=1780550796; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vANGD2vKWELwqFShufjM35Wn78nC95DsZ2JfSKglkLA=;
 b=CZn9qSsOL8P1UKhtpIWiUITGVuP9UDHJcoGYm4uZgtsX6l2X8WaTFFd+m7yPHhXU4y
 7WBA2Y9eKofufAjp5ja5iWzVjnYKSvtVPLeWTXgYQUJ3qk9OMSmrYou1mEzCtWtc0rZV
 YFUwKO/Pa+f6/JTsPRrdaQ1fBT2iauBapBb21CfRLIy7U2mthnPhafNBIkLFWdIi5ER2
 DCC0EH8H7nfB5gExiv58Rx44DkI7r6Y51LR0uxuQ9wxcB4d99RViQWTYmO/9MeZjgj2X
 zNUqrSdonW5trSvw/wj3+jsuHV9GjJ7AHLLWiDYkPEdRPCGCua9WlqeSqegSRfHXrE7T
 fR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945996; x=1780550796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vANGD2vKWELwqFShufjM35Wn78nC95DsZ2JfSKglkLA=;
 b=Q6exBfhyLpnKXsUj4zpHSPBYkZ2+eQhunRe8CCX3q4NMF67oYyYJFdljNL+KkuqbU1
 cNR7c2UDxACaqazCaphFeoVXTuH8ReCgbrrfU/pN4hkGmMgu0f7bsex0R5PEeJIt6Gx0
 61WXCg+UEYBAIrMXs3Fa+bw71V4QIbX81Q+gfLisekHj8Xg3hPPqvHg4RGsaRVylS1b0
 tG8DIz66SZnU7VmEZU/anEPH1fMAI6hWAS3AAOOWJ9+3QUUXYFICCYi2bin1YJSERnzU
 p3tfhP6l+PGBkmOj2SiavWk/rLgiVBWjR1rMCdjEU9TJeGpGfW25z659OwivYWeKqCSA
 DsKQ==
X-Gm-Message-State: AOJu0YwqExcV6Mxg3iC19lSh+F99B/kukiy05igGIhP4KYWn/Z2XRavG
 TRbuN+61P8LapWNzyVcLszP4Fu0QA7lfDs6kEssgZ0Jba/UTdN39UYRFB/jY4m1sB44+H+5jYUZ
 zEPCpzIY3N9vBLMaD22jM39Z6dje1yXG8KGvNYf/y3g==
X-Gm-Gg: Acq92OGZHDVZVt38WCLoqvxjR0da+JrG2rHIxm6LHFyRa7jXtQ4tuCgIhWGLaBSTsEu
 lDyRZZPhbHEuoWIOnqZKk1jBcHC24tUVBJ91tpI28EkdBn54KBbnH88uVuUOeNClnuXbkma4GwP
 ZQcE6xYLBbm2sNFdSVS9mMJ1b9sgqfMTOtcwqddUUBFPamTxCFbm+dPx9Bk1V4ef8LMTXKfJuye
 7GLauY0wHS9GtC9+lQPQpKvf4kToL/GlfTqAFwb+2Q1icHfGl3kMkNknvBJgvomlzm+LO7l3dHo
 n0pkXJ01WPzPj43/61JIjfvBCzMVxnAven6ASUOEnAlO1+93SdZrFq3EO/9C
X-Received: by 2002:a05:6000:4013:b0:45e:ea68:523e with SMTP id
 ffacd0b85a97d-45eea6852d2mr838639f8f.21.1779945996132; Wed, 27 May 2026
 22:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-11-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260528051642.115721-11-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 May 2026 08:26:10 +0300
X-Gm-Features: AVHnY4Lnq7uJaaGNAHaSPUgkdNQ4b1KOFG2UyRct1meAgQqJuFhJ4sx-DGrqXdY
Message-ID: <CAAjaMXZP+VwCvntg=c6tuJg-AkTvsfhH1QtR1-OhJFmE9qAcig@mail.gmail.com>
Subject: Re: [PATCH 10/10] hw/vfio: use stub_ss for iommufd-stubs.c
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
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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
> Solves conflict for vmstate_cpr_vfio_devices.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/vfio/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index fa0ea6ecf0e..c7c31b78f68 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -34,7 +34,7 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], =
if_true: files(
>    'iommufd.c',
>    'cpr-iommufd.c',
>  ))
> -system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c')=
)
> +stub_ss.add(files('iommufd-stubs.c'))
>  system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>    'display.c',
>  ))
> --
> 2.47.3
>
>

