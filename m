Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08108E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKklg-0005YR-D5; Mon, 09 Dec 2024 15:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkla-0005Xr-B2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:54:06 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKklY-0004nN-Rt
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:54:06 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862b364538so1978226f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733777643; x=1734382443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l8OZJVPf1eR/P41c1vpif+GjHJOS8hkL9Hr9jdSU3/0=;
 b=zHTNuiP79K0qu1XSfgj9TK4CFtEN9Uk+2cGKMNeYZs0jMQQtVrXIC5uB/Ft1UYtI5N
 7UH85BmYoenkfG2uXF/4/h3KHcBAiwEVYMSJLW3B5nzHqsddA8UEkuXEpWcHGQq3kF7h
 MqqlNRBGoF8aJIp7lTSOTmczjotv0jsQGhfh0/kLVTf1dZsMlL7LP+dgNvPFM3PF7qxj
 IcbPWFQrtvldhJ/trsY8iPHA6Z+rBtHN1+fRTGIL/BWEZNq1Abi8s2+Si2MCDfXixomU
 q6fxqb2/1Z+b26Ldhe1RPr582uW2O5wJPJ1ZN9mS4vLq4B3OGuW3uVRYtr6n2Uo0F8Wz
 Nwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733777643; x=1734382443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8OZJVPf1eR/P41c1vpif+GjHJOS8hkL9Hr9jdSU3/0=;
 b=nIk3xBme+qpQJfpmVtRm1XKeD6GkUbo4gmKbGKj0d5dXokHjYKaiNGh/6sr7gazNDR
 fZl73r93CPnMnUositw5B52/wm2zwYsaKSaxCB7izBAY0vC+DLXohCWbLvFi6tqVxona
 +bxh4ztAesrOaGO0rIYBpcnnguZMIR95rz0BDfSUwaDI4DKC9OspJL/6fW1r9yxXN9jE
 Z8+IlWAKYIkZsmcUm6nytPZ8Z6gSNLQxZiVQjmdZFIof3KioPhKQx3Ii+aVR0cU5RLRV
 yE4qa6O+doMt/ra3h/DLWIoh0eqUmQDMmlAD5I8Fhbrx6Xh8iAzWX5H7vGAA7PtZLGbS
 sWDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaqD4UNT9lbsX4euEpcSLnmyMtYMF5Fg8Ortlk6Duj6rX8JhR7/4jTxBljR20H2wSeDbkOGX2IIYBq@nongnu.org
X-Gm-Message-State: AOJu0YwbudvMM7fbnBjIEl1/1TuxzamLGCBG0Fmsc6/p95Qjds/x1l4B
 P81PtWusJU+O+ehUNWcMINoaP2QyXX48oB5xhOCVRSbiJ6qruhI+2sHjV293OXM=
X-Gm-Gg: ASbGncvHi9+ag2n5Qr9wh7d/7azcmWrO3IkQvPw0g0rzQE9vaYxePYbl8oe/VcoZoTG
 CkPEU26uSmYNHPSYY8+qZ9lYNpqoMpmb0oAE74UGbb87JaZvkGFwx2z062iKBlj4S62x+nJSSLH
 ZIRu24pLSnQHSFsUqz5513B3Vr7/yt2R6waGekjZNCBMvgsFBJSIQD3HrbvQqEx1eJhHIVym5s6
 1wQmrS/qimfMqQ5bWTuRF0xyEnshmtcB60zDdNlpG3+MKXBRv1WM+JoHjKwr9RlcWmiwedNo40V
 Q5OcWi6iAxtOjKu/8IjCpUb16jQuKITX
X-Google-Smtp-Source: AGHT+IEEcLXA3mFkpCBn57BrBECGs6qkyLPwZ+CNkH62pnxkVk3NGxIwKahkhnLl+mKPYc6+GL9mLA==
X-Received: by 2002:a05:6000:178e:b0:385:f7e5:de88 with SMTP id
 ffacd0b85a97d-386469a0b15mr579423f8f.3.1733777642869; 
 Mon, 09 Dec 2024 12:54:02 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38621909644sm14375777f8f.76.2024.12.09.12.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 12:54:02 -0800 (PST)
Message-ID: <3d0d87b8-d86f-4411-b1dd-7e825ec237e4@linaro.org>
Date: Mon, 9 Dec 2024 21:54:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] i386/hvf: Print hex pairs for each opcode byte in
 decode error
To: phil@philjordan.eu, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-10-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209203629.74436-10-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 9/12/24 21:36, phil@philjordan.eu wrote:
> From: Phil Dennis-Jordan <phil@philjordan.eu>
> 
> Printing a sequence of bytes as hex with leading zeroes omitted just looks odd.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   target/i386/hvf/x86_decode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
> index 6c7cfc820f..f8d37f2d53 100644
> --- a/target/i386/hvf/x86_decode.c
> +++ b/target/i386/hvf/x86_decode.c
> @@ -30,7 +30,7 @@ static void decode_invalid(CPUX86State *env, struct x86_decode *decode)
>   {
>       printf("%llx: failed to decode instruction ", env->eip);
>       for (int i = 0; i < decode->opcode_len; i++) {
> -        printf("%x ", decode->opcode[i]);
> +        printf("%02x ", decode->opcode[i]);
>       }
>       printf("\n");

Maybe we should use monitor_printf() here?

>       VM_PANIC("decoder failed\n");


