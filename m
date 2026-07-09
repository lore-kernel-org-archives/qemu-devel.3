Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08809C44507
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whu8L-0005gT-1y; Thu, 09 Jul 2026 15:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1whu8J-0005fz-CY
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:10:03 -0400
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1whu8H-0005dn-P1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:10:03 -0400
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca696c4b152so57118a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783624200; x=1784229000; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZzNwAU/JZWYN3S4rth1QnTO5nzIMVJgGY4FB1s4nY9c=;
 b=S//zL3NxwxrVdTGjkZ/xgfUvCUfhlnsUHxfQfmr97QonO54RFT1QnFGcg4mrftJzGk
 U3oF7xCmG6SlWZ4+o2OyNz7nMhgnWteBWydLFpUHZoSVv9yVpvHrM9dV6l1533x8pYWt
 AYKMkA7hlkFPDgy70jYCbbiykCnf8ERIAsx4CYNznzX1L6P7SVCQSff16UnjmMCs9raM
 iTplAY3P5Jg3mV6kGispzqHRBLErOvd/CdLJJ43NTBUuxb6LZszYKJLBWvLkEHNol9ET
 /7VKP9srpsR06FvFp5NfpSu96I9sfKbQqdfjvOw4ahbQM846Qjo1yPMm/YMsK2O9V9C7
 U4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624200; x=1784229000;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZzNwAU/JZWYN3S4rth1QnTO5nzIMVJgGY4FB1s4nY9c=;
 b=oKIvPSkPePgAcAO45gjs01HsnTwkrzclWNkjLVcGSSixCUezASIHBxmxToMI8Qood0
 44Xj9noS39EDZQWyfEnBGMzXgVhxiQ05DaLUQPbC41YYsfxWKL8VUYaeF/qJhr7yH76D
 y3XQNKminqTmkteKHJ7WTvL2x3EJx4WO3LiuuGTez3b7I8VyoCKjTqZSh2gs1MkpVQ/t
 j0AvXbP9ctIEvWZyauR6iq9lKI/D9nG/huSh+HdrEALjEF4PLeZ1w4EIpuR1MpMvNDIH
 I8m94Un9fE92yZSmPbmeHWR1uNYEgMja1UiOE1RySn3XkhkBQu6SowDAciW8HUCD6RHN
 z1fQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIO21LIVTHWQLEQU/DbguLo7ggFoH+bD/oluUDmi/Qa1TX9gZ0WzFwmnCrvwUTde83uQAc0OWfeUtj@nongnu.org
X-Gm-Message-State: AOJu0Yy8YaPGxrfa6mrx20Hl3QuhaUILHGdZ04535kmNrA9M7wV/fOxu
 XHkAfVusKzrTwh70m0Ev39iPnjEEPRzqPrSNUb5Ljf6j1/jfsqgVSrw=
X-Gm-Gg: AfdE7cnVrjKicgaY1MYqY12DeMhkMRZaDJyY1zEQ90DQmJcDJlvlrtj557ddlbp4yFx
 C92HhsviTFbMt11pO/6bkWjr1C+xZoyAr2x44OKvY3l4DIIPiIIQxF9xy8PKmFf8KEme0Imha25
 X0dpTOhoM6Gu4YUgDScAcO3Pz0abyWR+BagC4kB37eiZqLgQ2tpgDCLPflKS6lurtxzvWO+pOQs
 IqdnSzKqlWRmtfH2UaYx+B2YBZRDubeMhYn3QsNmAWr03tYRzDmng7KRoDh7tS2VZOuxWXeAk6U
 8ul7d7UgV2hllWbiS59SXsa43sFzlm2ErXzAQ4IA+7PHyPmngHQvypHphkY5Y0/Oo+AwIlfkvDZ
 15ryA+tEWiFfT68hdwmTD/EDXnhSkFHGse3qFwa0hyX7zgY/IMljRRv6WxaRYJ937Quz964iM/R
 SQ49s4uT+q5q8OyOo2it3G4SPjQQcPbYzCj4sUmBmb1IP9C3A1SVqlvA/Gv2gdYxE=
X-Received: by 2002:a05:6a21:485:b0:3bf:7bf7:7913 with SMTP id
 adf61e73a8af0-3c0bcead3cfmr9550804637.14.1783624199777; 
 Thu, 09 Jul 2026 12:09:59 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffe:590:ec08:736d:f5be:1a6?
 ([2408:820c:8ffe:590:ec08:736d:f5be:1a6])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b65960d88sm28697771c88.6.2026.07.09.12.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 12:09:59 -0700 (PDT)
Message-ID: <4fb182e2-9395-4bea-85d2-84d733d6b4cd@gmail.com>
Date: Fri, 10 Jul 2026 03:09:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] contrib/gitdm: add more individual contributors
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
 <20260709080040.4157324-8-alex.bennee@linaro.org>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20260709080040.4157324-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pz2-x01.google.com
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

Acked-by: Tomita Moeko <tomitamoeko@gmail.com>

On 2026-07-09 16:00, Alex Benn=C3=A9e wrote:
> I'll only add names explicitly acked here as its quite possible people
> are using different addresses than their company affiliation. Let me
> know if you want contributions mapped to a company or academia instead.=

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
> Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> Cc: Tomita Moeko <tomitamoeko@gmail.com>
> Cc: Julian Ganz <neither@nut.email>
> Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Cc: Phil Dennis-Jordan <phil@philjordan.eu>
> Cc: Jackson Donaldson <jackson88044@gmail.com>
> Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
> Cc: Roman Penyaev <r.peniaev@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  contrib/gitdm/group-map-individuals | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-=
map-individuals
> index 178b393b8c3..42bee15d933 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -46,3 +46,14 @@ amarjargal16@gmail.com
>  me@sean.taipei
>  kosasihwilliam4@gmail.com
>  philmd@mailo.com
> +soumyajyotisarkar23@gmail.com
> +tomitamoeko@gmail.com
> +neither@nut.email
> +ktokunaga.mail@gmail.com
> +roy.hopkins@randomman.co.uk
> +phil@philjordan.eu
> +jackson88044@gmail.com
> +weifeng.liu.z@gmail.com
> +r.peniaev@gmail.com
> +linux@roeck-us.net
> +tanishdesai37@gmail.com


