Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F22FD9E1E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvkJU-00005T-SU; Thu, 26 Feb 2026 17:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vvkJL-0008Vr-7b
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:58:24 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vvkJH-0003nN-3W
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:58:20 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-676e5c56fe1so630747eaf.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:58:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772146689; cv=none;
 d=google.com; s=arc-20240605;
 b=b65j6Nfe8HtYeaoEmSrpGRhmGzbO8Z/tv7gNHfzttftEw4SkmKH9fkk7I79xvWQVM8
 UwTTuZBq2fvSfZ6LIEya9yXQK2HAyZ6mXx0a3OlgnZ3YaoicMavL/brP98cM/aKlgNPU
 SuVRiyZ6RNSeqe9BWUkSMaQhiPFV6m+PBDZaThlhUiU9yZyRInO2XhOuLSg8zfZVeeNH
 BIJr/0jXzoWiEh6dh7sOkkaj0w37c+42a9h1fA4WtD8gpS4stFG9REe89zyGlUrzgOGf
 vmlhvMdUge/9HGW6krNJq3QyQe3EOdyrj9ha6I6RpJLW6TNxBoydsvUdvY8XgekSjgFK
 cfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EBRp8p80T1snmvTc4ktLOTQF/BMGqN6RfuNaAVYqdPA=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=iB/8eF4y5GMOZ7UtnA63wTVxRjV2f2rz9Hymmy5SaDwT+5Bjd+0KR7Yu4DKBVmSG3I
 JtFdXf1ONtV1/IhOAG+D84dywowfNxi0xSAOU69Ov6ElnSGA7gV8hiGPS+1BOQF/ZMlF
 WuUgSGEcJsFXYHIalUGSc+bcrniWnqY3mwFLxiBfSO8zKPR/wKY6h+33dwQ9zYsm6sDR
 EWha6gFNalfB86CeME35LIeJNtN+glrygZ+9rrtdXULo9BlqVoU3x69LFTfayqdtoCrU
 PwHfVXCi9d/r0Btj+hBOSbJoX6+vujtCySU+9KQIhq3pAWq8n/M3da8I0G8cQo2Qq75s
 HefA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772146689; x=1772751489; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBRp8p80T1snmvTc4ktLOTQF/BMGqN6RfuNaAVYqdPA=;
 b=KuvRuxOu0n8IFGJuV9ugqsBtPuFJxg1/u7YkaH0zEP3s3akxHDqh7q2jn+pTZVpT96
 uvV0oEmTPfk5NDiJaYthzuqpLYJOzkqOml8xQAdiWoqTbo265BUhC2fD3F8HWozkE5IE
 XOxuryC4D682bEtNQKa/xIehNfMdpTyLHXwFdtquGAcW5DWK3hY6wxo31zfag2GypPeK
 IOgY+knjBLvuSrtNt5B6NbMVYcH/GOrPHkDe2Y34lzbnZ6Sr2KQOts5RBz0FQc0GbHGE
 9mNn3mRDnWF4CLOQ4xARfKyw/XhqP+mgh6rhRnrpfE0yTsUHxziCA3aTNr+WNSkCfsVW
 D5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772146689; x=1772751489;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EBRp8p80T1snmvTc4ktLOTQF/BMGqN6RfuNaAVYqdPA=;
 b=MLYN9iTc4N322mEhRanBK1rcT7zLoXAa98dwpNJgK2hWlXgaxI1LEttpS0O1orXqwR
 QY8dZk/6YCa4uDOBQjIVW2cAWVM8yfcHQpTvlonldEQeEBppkzXlsYxAJan+Ef4qBTFf
 XsuOUcQg5l3Asai01DH5+Tu07O4iLGete+dWFzldi4cv2hTrZh/VqM1fdDVjiCwTKCRo
 tvmVzsuxWdnWkEACZjmVKj92Xe7zLhnAWdHrfCDfynuil3EarAZBIL265lH7IEAb9xex
 /LQzybtDT1T8PY0MLirdvPOi4GlNS1UGOb+IUoy/sdhQAMIT98gZLFXBlKctaNMI9Aqi
 G2ig==
X-Gm-Message-State: AOJu0YxTnpy65+nqzlOgbPGDoD6q/KEjSnv+uu7KgHBhjWvxJAe+t5IO
 yo0egIDYKZux0b7VICaQ8jjAEBwZ2BgxKX5epDdnt4finbk+ZmEkKv02/Dm40BEC4S9/3j5xDVp
 cX8EoTYS/VDx3aMmIFQ/y3OjLFKzT1+SUFY/39/dkYx3k9GGjUuG5fniEKg==
X-Gm-Gg: ATEYQzxFld9Dfo7Ml614Pv9CRlHkjeIZ7vzt3FL+B1YGC+eV2LQSk8VALVAP+QatZLt
 /Baxj+6f+RS+IYSad6n7Y8ZLoJOucTB3iRQnft3KVLl6IrenpBmMn0nQ90PfB2f2JCxesaOZJ2M
 XAGxGSqK3pgmgkHcMjpZZ9JHX5WmxoQBWflWOJKZK5bw4ORfSypHXTTrcT4B2LCQGCtSqh93mfW
 7dqLdRe9CTEQVo4D+DB9F0R5okQ6Zxa8v4YAMnr+tpYa+P1BX4S5Wc9DA12vd8cbXOpARl0j8Bi
 5HFMbU8=
X-Received: by 2002:a05:6820:2298:b0:679:9654:9db6 with SMTP id
 006d021491bc7-679f2212e18mr2839362eaf.6.1772146689424; Thu, 26 Feb 2026
 14:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20260226224842.36130-1-philmd@linaro.org>
In-Reply-To: <20260226224842.36130-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Thu, 26 Feb 2026 23:57:58 +0100
X-Gm-Features: AaiRm52v9TL7aXLtCQKuVPOo17RCV8ku-R-bF1b6j3eDEBDpsZ2Yt72s0Haw5Jw
Message-ID: <CAPMQPEK869_LWc4hYmdDfb6qKopHBnevVtAXQED+q0CpaMJjjA@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-oo1-xc34.google.com
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

On Thu, 26 Feb 2026 at 23:48, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> gdb_static_features[] only contains strings, nothing target-specific.
> Instead of generating one file per target, generate a single file
> with a single gdb_static_features[] array. Remove the stub.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  meson.build       | 25 +++++++++++++++----------
>  stubs/gdbstub.c   |  6 ------
>  stubs/meson.build |  2 --
>  3 files changed, 15 insertions(+), 18 deletions(-)
>  delete mode 100644 stubs/gdbstub.c
>
> diff --git a/meson.build b/meson.build
> index 451cb28149f..6d73ee40ea3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3867,6 +3867,21 @@ subdir('linux-user')
>  subdir('tests/qtest/libqos')
>  subdir('tests/qtest/fuzz')
>
> +feature_to_c =3D find_program('scripts/feature_to_c.py')
> +gdbstub_xml =3D []
> +foreach target : target_dirs
> +  config_target =3D config_target_mak[target]
> +  if 'TARGET_XML_FILES' in config_target
> +    gdbstub_xml +=3D config_target['TARGET_XML_FILES'].split()
> +  endif
> +endforeach

Hmm I need to check gdbstub_xml.length() > 0.

> +gdbstub_xml =3D custom_target('gdbstub-xml.c',
> +                            output: 'gdbstub-xml.c',
> +                            input: files(gdbstub_xml),
> +                            command: [feature_to_c, '@INPUT@'],
> +                            capture: true)
> +common_ss.add(gdbstub_xml)

