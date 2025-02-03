Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFCBC02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 23:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf5WP-0004py-KL; Mon, 03 Feb 2025 18:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tf5WO-0004pg-Pf; Mon, 03 Feb 2025 18:06:28 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tf5WM-00019V-JH; Mon, 03 Feb 2025 18:06:28 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso3923043f8f.1; 
 Mon, 03 Feb 2025 15:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738623984; x=1739228784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oh+kcSLzxagOppa0kg/pXmqP4HkISRplGCNJdaZ+ec0=;
 b=N4CeTe9s0HXBVfTG9Vi4zhL3Tw4h6E1hF6cqJpyaPoJDJ6qzKEcTI8ezd9QkVRp/tC
 u8TBnTSJ5kpqe8HSqiHkLIEPVtFxLM6Pd3GrUXe79Th5yWrehwgjcFpdlr7tAnSWGTeo
 jjB0IvAfZN8hZxmgXJxGCBq+Jdp0zpzl/JjZsh68Jjp4Gp9PrhBMRVYi0AGMZT1X6MDj
 +CL84CgVMMncRD8pH4gpoSE8/wwxTAXF8IQRo6Xy+mg8wjXvDN1+IS+wfGQdKuH0HlpM
 DffPLNaJUIXA4jk5yiyZIpZrjrKsgX6sd9iVkEUHmJsq2yUq9L0ZoTPdS+5pLLqYKJx0
 bBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738623984; x=1739228784;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oh+kcSLzxagOppa0kg/pXmqP4HkISRplGCNJdaZ+ec0=;
 b=Ys7TGq47KK8Qe+5646LjDvldcJGGfCEbWMi3xBL+wuaAW6y+x2Y8T39qUt5tojL36B
 Dsht700NlFdwRstsMQPb0ahduqKd6zwp8fXk7IsrVT1/9xJLnC/3acrbQ2t2QNY9mTYS
 iI0r097SOpeNzfmgznv5aiDWeZjdsJ3U+gXdpm+g8MUBjDh5Tmo0/P9ZutExEt0vYKA+
 rd4Jc4cS7/Yn8EYs+QlQaJWtrinaaAkqOsGpltViOGe9cIdbKhLlKW9Nz09UG3k9aDBO
 9Mg9kPeNwiYYtfK56Xl0TthVUq6ehBiyJavGhEdGP6Uz9whEj6KwOP8MwSusrW+V9v6L
 cO3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuAaYQY0azBVU7Fn1zlEep3wT16LlIiD6t4gz1hYh7u4sIrjiOcmSloowlSHUk5wQ4DfhTzlyHiQ==@nongnu.org,
 AJvYcCW8NgLW1MGGJX3L0cszYl4XPGFo0oZA2a4FievsJrl12BJVMmdAq1/LzXK/Rvy/Pb0AEPULy9Sc29iTyA==@nongnu.org
X-Gm-Message-State: AOJu0YyBGTfCZ0erMUw6atE2BAVzmq9tGllwLksBgk3ynmsUIJSqWkc/
 BJs0AjIrwMuW/ia1k2HV5RegoKTAoltDDMNLlNM5nBgVJ0VysrSQ
X-Gm-Gg: ASbGnctXBa6tn9EqdSL7rqYkKL2IGH3f7KodlDYKYIXzetZCgOWRP9HY45p+wfn0Ro0
 /aJRAsKhXhhcyWIExM/Lso4ourxPIybAsMmgA3pyjV0d6842z8Jg3UkpPO62uCKhb6Jk8EjAdlZ
 o95bWyRoPS7hoHphNiFPOKmxY4G1Heqo4xGDojybZ8YLKvjtz2bR+RHGiHwXjZq9kUdEn8xzOjY
 J/5/0waf6q6tgoekaHpYPIuBwU608tq/Gi2hBIkpdSfYviBU5sMnCLs9P0J69t1Dd5gEWDXbgXY
 tKKZqBtjAtcCPXDtmJRKVPqRo3/OzFnhDl9fLN8hu5XTLSn9cIeS1xMoU1Q2u8xLe53SPiv63g=
 =
X-Google-Smtp-Source: AGHT+IGNwJC3JTfSBeYHxOG9GSvt8GmGnOpUeTDLKpug3IQkS+TsyDoUVrZgiskBoutXAaXCZZhl3A==
X-Received: by 2002:a5d:5f50:0:b0:386:3918:16b1 with SMTP id
 ffacd0b85a97d-38c520906e8mr21962545f8f.39.1738623984281; 
 Mon, 03 Feb 2025 15:06:24 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf00430048cf2359cf0b0456.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:48cf:2359:cf0b:456])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf560sm13791709f8f.89.2025.02.03.15.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 15:06:23 -0800 (PST)
Date: Mon, 03 Feb 2025 23:06:22 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_21/21=5D_hw/gpio/imx=5Fgpio=3A_Do?=
 =?US-ASCII?Q?n=27t_clear_input_GPIO_values_upon_reset?=
In-Reply-To: <bd929bd7-88d7-4808-b801-26a2858ef620@linaro.org>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-22-shentey@gmail.com>
 <bd929bd7-88d7-4808-b801-26a2858ef620@linaro.org>
Message-ID: <03E738D0-1978-4497-AA12-6C38E3112517@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
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



Am 28=2E Januar 2025 14:33:27 UTC schrieb Gustavo Romero <gustavo=2Eromero=
@linaro=2Eorg>:
>Hi,
>
>On 1/20/25 17:37, Bernhard Beschow wrote:
>> Input GPIO values such as a present SD card may get notified before the=
 GPIO
>> controller itself gets reset=2E Claring the input values thus loses dat=
a=2E Assuming
>
>                                ^- nit: Clearing
>
>

Peter asked for a three-way reset in inbound devices while keeping the log=
ic here as is=2E I'd drop this patch then=2E

Best regards,
Bernhard

>Cheers,
>Gustavo
>
>> that input GPIO events are only fired when the state changes, the input=
 values
>> shouldn't be reset=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/gpio/imx_gpio=2Ec | 1 -
>>   1 file changed, 1 deletion(-)
>>=20
>> diff --git a/hw/gpio/imx_gpio=2Ec b/hw/gpio/imx_gpio=2Ec
>> index 549a281ed7=2E=2E25546221e0 100644
>> --- a/hw/gpio/imx_gpio=2Ec
>> +++ b/hw/gpio/imx_gpio=2Ec
>> @@ -298,7 +298,6 @@ static void imx_gpio_reset(DeviceState *dev)
>>         s->dr       =3D 0;
>>       s->gdir     =3D 0;
>> -    s->psr      =3D 0;
>>       s->icr      =3D 0;
>>       s->imr      =3D 0;
>>       s->isr      =3D 0;
>

