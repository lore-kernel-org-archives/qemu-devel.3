Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247E8CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTFL-0002Mp-6z; Thu, 28 May 2026 01:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTFJ-0002LW-Ek
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:25:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTFH-00006h-8W
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:25:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49068493267so28058575e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779945925; cv=none;
 d=google.com; s=arc-20240605;
 b=SQxDCVCfq2h7wspJmab58AH4LCnQpkgFUgbKmHWuChDS+lCo9pcwB/BjMOEKjV10q5
 DUSQeHHHG9gb41JQ7gNojlfYrMtXwh+wxfkHLPgbWT3Z0koHDnLzJrMWlyTxXO/s7Ml0
 gqhXL5kLpXYVpX7qyJ51oGrghQdGoJdHzPG545bc2HkVvNeTggUWp+Jmit5WdviEU2En
 4gzB+ZkWPSUHdqnMLvynu9WB8uQq7nIJv4aiEuKMNIB/Tw5WobaTWBo8bwnG8h7RzkQd
 jeAZw1FjzA35GvZootEO+dBLqHm1PCmOJ8w5mTIZj1s8fIA/QT5PfCbbFzoa6+4zSzqT
 U+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5TCPJ3gJwHHXYJJXNVG1joXUuyTUjoTdvOy1PVh5k9c=;
 fh=XBvXNygMbloJp+VR+lP4ESgdVtRHCxc7UtbU1PDcF3s=;
 b=d64ao6dGJxn19dNPs/0yc1vPDw9h/Re+dtW0VTZuvRSfqp/VT+RycVPlV2XNZ0jcAs
 sXqj2tAi7NTYfARUra1r5WM9o4t6cUUYs5tXShdcX3u5n8LBR6UPeOr9RaDh50x/W1HA
 2/3vrZ9Q37ygv4GKFcnVbYPMz7Ydfqu8Zat1DRc06J7+j1dcw4ajX5uHG86iH+zxsluW
 iLwDhBwDkJkVTVcNWgiRrqAagUlqLLYe7c1VekBahUWFOdNIZCmQhy2WkEEtP3a8PNqL
 bZVGoEzkrw4lznATgTC9JY8uxx0bto2aP9nQeT27DVTCDJu1nW8CZXPs7N7tD0ghljS8
 I9Vg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779945925; x=1780550725; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TCPJ3gJwHHXYJJXNVG1joXUuyTUjoTdvOy1PVh5k9c=;
 b=ecTPzw/m5qtLasVqJcVfTxXWT3xXeduE2pTMfNlj0v8RftIiLoscaYtXan6JlzQUkZ
 W7UK/rOvsfXT6m3Y8MiZON7QZa47VMiO/wAeSndDRV0oB8nt4z9FCx++ixi06cKU6zBo
 Zfm+MkbIs7JSSjkJIBTBbLNy9plQUoaMjIUiZzlN7nWQLqbEhAUYeSkjpRecw8/FQIe1
 oMMixtb4xrv74hqRDXI+aphU5RxTjcdwSKcRW7LJtgHHUz74sU8H3neuhgqTb2+nopkg
 GNHypeZj54P1+/LAjIv5E5qtxNm9L0iFghFhSun8HDvaIsRui7Tnq6RrFxiCz+pLnMuu
 OB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945925; x=1780550725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5TCPJ3gJwHHXYJJXNVG1joXUuyTUjoTdvOy1PVh5k9c=;
 b=W/JNbQbyC1+8x7GlW+0WgUa1HPpzjFZJ0tvBB7Bi1tj1oEVGsoZwen61nFmppgS0YS
 WJ3wYwlg9ksYP2T42a46/NTLlp2vK+l5ftvkw/oNK5AXzQNuKzjfvKlKUcFiqDhmeFDC
 IRkz6ZJEQXYzqEfdsW3Vm4i7dTxObdrkww4DgQQgL2tXg1F1q8p0iMzs//yGy8RpBdfZ
 MlL1whQ+mJuCYwRnVFlx/NrlZZb9DW9uApFysORfnnchiX/Lk2bLQ0R9rorIhcAvfNjs
 BfhRpNtBf07eu7nkvugkwxdRB1Z/nOk/6mEw5cqShx4Lo4E97XkLZ7YtAzZDtLqPEm5E
 iiIg==
X-Gm-Message-State: AOJu0YyvbwsH8fS03VoIeIEZalLkSg0CQkW8pEwKV4ComnE6Tt63qKba
 Gc7xnlTepGqpd2VvErOsdunIDdWXcbBb48EeXlfjD6XwxmNQrFyAySuS7RbC9Exmq4v7pZjtqbM
 ltU1QKkJ0HAZgtFT6GBaxbMB+ODO9d9vp5X7COqmcfQ==
X-Gm-Gg: Acq92OEySnWk8imLSVLvIOAc5qIeGjbYslGUVAJw637VKtfCrDwV4skN90OK+CdksBD
 fwvGsAazgYuAs/xzLEiiKWcRPAaB2pyDfOdjVk2hxaX+QsVNZZm2oOZLop0OvUEeO0pSkeQWv7M
 YEOtmQwLwMwKqe0tHSwtHXwIH/G/lfFZeqgqXCWqnsk5E6QJA7P2GTu0RpDo0M+QCsYDRtvuxYv
 qop/52l5y1HO8hRV1KFfQPgoZIHTFQt/EFXUi+Mz3sd/VWvfrMir9XphUxTSqSJe8Qa3ZqCigpx
 yooSpNK/3QZg486VPVdfmEvjGR6sXMN69R62Y2lXDGmGWoAQzOjseLKotTrI
X-Received: by 2002:a05:600c:45d2:b0:490:6237:521d with SMTP id
 5b1f17b1804b1-490623753admr265617755e9.13.1779945924980; Wed, 27 May 2026
 22:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-8-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260528051642.115721-8-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 May 2026 08:24:58 +0300
X-Gm-Features: AVHnY4JQxodVSb-Pjx9_4rMS8rjHgy485LvNcnchqEleaADjMgl5nzLDvnCqCzA
Message-ID: <CAAjaMXa8EWF-iUwCuoEd=XFBqHuZRjq1xj4hbEZzpVePgDQqHw@mail.gmail.com>
Subject: Re: [PATCH 07/10] migration: use stub_ss for vfio-stub.c
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
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  migration/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/migration/meson.build b/migration/meson.build
> index e583822dec6..0a9a5d0d374 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -50,5 +50,5 @@ system_ss.add(when: qpl, if_true: files('multifd-qpl.c'=
))
>  system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
>  system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
>  system_ss.add(when: 'CONFIG_VFIO',
> -              if_true: files('vfio.c'),
> -              if_false: files('vfio-stub.c'))
> +              if_true: files('vfio.c'))
> +stub_ss.add(files('vfio-stub.c'))
> --
> 2.47.3
>
>

