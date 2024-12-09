Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070CEE77181
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKknC-0006K5-3w; Mon, 09 Dec 2024 15:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkn9-0006JW-ND
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:55:43 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkn8-000532-7O
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:55:43 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1988237f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733777739; x=1734382539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vVih/yCMHZs0OCxV6rX2JiJV5YrIg231k8R+fg6SUNY=;
 b=khCBSpfu+G/Of2vmGsnpPTUbpLo0EVxQ17YRIR3+u0hODWQoATRen8tjibx8AgHaZ3
 7cS16mRt6j3zSE7t+vbJzfE5kwgJyx8x9FxZgT4bQoaTFeAQpN1Af8wCfNrYwdH4mlwI
 jf8S8IP6H0pLjKsxXMF/LaUSli9O6UetOwNrkrNxE6Sa2TZnr3DNZEX93GFuMByBN93u
 0XDoG4hJEN5pKNeivZg8TtSdeN6WVu6crk4XbSgNlGVG1qVI3TlAfvdFEGiVwNh6al8C
 8jugJJFnutsXclsP50LMoP/jGNtdhi9iDt8d2X5G5Gpugnf59tcLemzi2a8MfFm6Oilw
 SMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733777739; x=1734382539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vVih/yCMHZs0OCxV6rX2JiJV5YrIg231k8R+fg6SUNY=;
 b=YnU5wyhuLrtMOPoRNldAkzr0E+1XJCbry40GzVbqJ6H2JBqjmewvdUr28H/FG31lBi
 aKqd5J6hjLie23w7gvaLNUT1lHk2twVX77tot3steP1f4AzjC2wzE6TxqaUkaM0qb14K
 kqEik2Her70s1DQLK71ugjMui1yvTsCVkWHx7J8ES22FqsrBLQ40xwhItKgPg5k023Kp
 OT1ODXKFiMh0MIRpyvooColftcI/Dx41UF22WzyCpKhD81eR97hr0WQt55ijYzdPbqtt
 sf2pcY+GVLMD11Rh6X1RXqjF0P9T0ftFmLr1TErQH+bc35GTu5Crl72s9VvvIyfEfrSJ
 y2Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAeiTugMlYpTWZQEIR3tSt4A9EOjQsUgzRhqiBjRPzl1+O5qJwdnRZrQQZb/3grXUj/W0qVMmviThA@nongnu.org
X-Gm-Message-State: AOJu0YzG5jDC/HNNJnfYcB8nyviqG6MhW18726qN6Mt30KLLnodiitUs
 dey/ajpVebM9gCH17gj5fqsNUASTR57U3DubYV0Hg+WvEHnfOEoWAesSDcUcVdo=
X-Gm-Gg: ASbGncuhoOGsyPXwWQ+G3PHuyxxp76WicQOOASiZO0NbNKzS1qJ8YP/FD6xRcx/TjQn
 6VKkK0EWtClpe1fRh5P/rouKZjqLLImy7brDgLGvmilivq8fwXCdDp2uhEVBYXLDgryDpuxKZE5
 DKDEiUiIkeKc2lMb0jExe8L1Rp05b7MQ9DdxwG7vFvOFSvd9xM/d1994bYOerpMsaIvgewqyeJV
 yUp2X9irnRR249zJxi/68zhhpwlANZgzTDI2Vgw/RnAzotk8YpqtC+JK2defYnGLGrHrbe9Sq80
 0IcV6ZdrNPBJixTcmtqLcJxhlqYNJCWu
X-Google-Smtp-Source: AGHT+IGzEZQ+br59+1ZICL8ZuAqM7TEu7zmUJlWj0bADvCfW/lP3aqto7o4vvIvCcw73H22MTFQuEg==
X-Received: by 2002:a5d:47a7:0:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-386469abaf7mr555572f8f.15.1733777738952; 
 Mon, 09 Dec 2024 12:55:38 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f981880csm49196075e9.44.2024.12.09.12.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 12:55:38 -0800 (PST)
Message-ID: <7ad94711-21b7-4350-a340-351ceef0438d@linaro.org>
Date: Mon, 9 Dec 2024 21:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] hw/intc/apic: Fixes magic number use, removes
 outdated comment
To: phil@philjordan.eu, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-11-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209203629.74436-11-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
> This changes replaces the use of an explicit literal constant for
> the APIC base address mask with the existing symbolic constant
> intended for this purpose.
> 
> Additionally, we remove the comment about not being able to
> re-enable the APIC after disabling it. This is no longer
> the case after the APIC implementation's state machine was
> modified in 9.0.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/intc/apic.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


