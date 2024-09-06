Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C32CE7B10
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZ2P-0005oz-Ma; Fri, 06 Sep 2024 09:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ2J-0005KR-Rq
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:30:04 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ2H-0008Qt-Vk
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:30:03 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5365b71a6bdso417924e87.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725629399; x=1726234199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1DwYu9QdzrUW1gsmzF/i6MG5QrT1Cpgzq2dn1Yasafk=;
 b=FpTPijpYYuvHJdG8hlfDbjeSWLqrTqcS3kdntib+TAPS1IRvpj6F685+6HPpWCIdhB
 nzRLzxNPi5jW0lXv8+8KbR68VxDxT8HfPXucbnZRS27N5GYbqT8XOcKRyoYBueD7iyEg
 SWgOajhyqRFiBZHZTFYj8GagVic5r+i6EtX85K0Jj5Uzsn1hf/wHdHR0R8PhrW/QBgU2
 srAN710Fa3HgnIk/FriVAzZoVyWCkqWykKtJLHt3YMN7YwQUyqGmq3oxW37I8lq9hUc/
 vum+XwFBifjdj3bMGGn+dK12fuFkuW1Y+I7+qH5evEZ5elLy+eQZQIpunnADKCbNsmX7
 YUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725629399; x=1726234199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1DwYu9QdzrUW1gsmzF/i6MG5QrT1Cpgzq2dn1Yasafk=;
 b=xCQex9qKuPwSNSzAq2vkj593OkWt8nGBKxH7n7CO68oXKnt6hvS7TNE6ccTQAta3Q7
 s1xHPmpqhNYnNbLSHD1RlW7HyiOBv4a91XnkkdXhFaHfyMN4mVoAtJWVLvheS212Y5jh
 vMFUUdpP4WengOMbVwbAHQ+1i35FoPrbs6bPV2Sw6AGhKnSgn4yAwS7BtNEJZOftUBxN
 a4yH3Nud+KRgj9u+AHWk1Strc3MoR5mYvq02fzi1kBOmr8NSPPkPTfBunkJ8wBQgU9NY
 UjL15bDh3TaYCBSfAs+rNB2wwMwpPdugKjYr2tL6KxjmCRrFMma4TNFG9CKcjyaxVSMJ
 3I5w==
X-Gm-Message-State: AOJu0YwlqiWn3vD3sbp05vpNZQcq3hB/k0CJxviB7UWN9tXthR587RME
 Wi3WCOjY+lhAKwrZvmZQJyUXkVdAkLgMWbfPulilu2Pqcpok7JDNIUZtLRIyKKzRT3E1Op85i22
 t
X-Google-Smtp-Source: AGHT+IFC+SsNEDOf2oqkOOeSy/S/S+2cpFdS6sL5037b1Y1Ntu/122jjFXrwYkR5m6oeRTYRpwj4tw==
X-Received: by 2002:a05:6512:4018:b0:52c:df8c:72cc with SMTP id
 2adb3069b0e04-536587f9a5amr1819951e87.43.1725629399263; 
 Fri, 06 Sep 2024 06:29:59 -0700 (PDT)
Received: from [192.168.55.118] ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a62045569sm274920866b.73.2024.09.06.06.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 06:29:58 -0700 (PDT)
Message-ID: <b556bd8d-dbde-4e1a-a172-25027a66d893@linaro.org>
Date: Fri, 6 Sep 2024 15:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/unit: Strengthen FIFO8 tests
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>
References: <20240906131217.78159-1-philmd@linaro.org>
 <20240906131217.78159-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906131217.78159-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/9/24 15:12, Philippe Mathieu-Daudé wrote:
> Replace reused bytes { 0x1, 0x2, 0x3, 0x4 } by { 0x9, 0xa, 0xb, 0xc }
> to be sure a different value is overwritten.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/unit/test-fifo.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)


> @@ -157,8 +157,8 @@ static void test_fifo8_peek_buf_wrap(void)
>   {
>       Fifo8 fifo;
>       uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> -    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };

> -    uint8_t data_out[4];
> +    uint8_t data_out[8];

Since this part belongs to the next patch, I'll respin a v2.

>       int count;
>   
>       fifo8_create(&fifo, 8);


