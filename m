Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D474CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 14:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKzlu-0004lN-Jr; Mon, 17 Nov 2025 08:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKzls-0004kt-2i
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 08:59:56 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKzlq-00080h-Hy
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 08:59:55 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso21619655e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 05:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763387993; x=1763992793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b3Y9xwpTLZXScegm/s3JtqBGrblu6twRCJDYSui8Cps=;
 b=FFwPq94xJOTr9U5+2vbqs4cRy+h/wU5DSebFYglvoLFo/1jqVldhMqpWHYRdf6NRi3
 x+308xXLck9z89qPKYqCzg99afth4f2FSzHd1fxbBDj0Gd5rdsVpBO7jMSm1i0oFltej
 zpmSSTfccPomllEkBnTiPp5iRVtgWbt6D3pzjEbvEv7vvgmDgKQzDVp+HohRrqR1kCIm
 bTBGTAW5XJIrzUFh1ohPOOyIq5oU5NTZkBlqaVEE0BN9qZdgyPSxuV5tkNrhyvN7MpMM
 ZWS4GYK7zQ81/8djTuj75pjejAJmF55PIbJjTlHbWZ15+Y12iFNBztcbkbICyUSQqBNW
 VYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763387993; x=1763992793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b3Y9xwpTLZXScegm/s3JtqBGrblu6twRCJDYSui8Cps=;
 b=uEaPUO54PHFUVDkgnygGTaPHYSeTmeskaQVHuGvN4/mIIXA8g1WEH8vFxamqPJ9Nzn
 aX9w6rysY/2cTrzjwLmtjV1ShxzB/OdWad4Ck+kYn8DfFYm/3vMj7v9HvmOq8+9cxWed
 Brc8fdJEZTD3sNm4C5bIypS0QuK5KPT5U7iocoziAVZkloKHw92Vo4oCyFAvTtCSQiMa
 +Dfd6GTMtJWVuN8OBOf7pyZ+XTxRAsD1v4/C0yW4ts/H+/dhAqwAzV8wbVZiSfG5dLcx
 ZytE5i0ZKFP3Ij18tt1S1hCkR3b+tdm4pvfN93ttGRVz9E1NhUQZM/ikkvM0RO1QjhsB
 xxPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbKgb4UthAmq4G5iQmaDGS6WzIliHqxgXFaOukmH+L9b7qLLbfbF0TIkM7Cupg55FWJV23g65H3oaA@nongnu.org
X-Gm-Message-State: AOJu0Yyt1dmXsHcURoMqiHx3kBOe470AOnZ/D1EZYYmSKUY3z2nfwFO8
 cJLl9hDoWpOzb0mdeivUj4lSsU2dyOkiMgW7Umn8hxpCosQy8byTtRcAB9Z6RpSfj7o=
X-Gm-Gg: ASbGncvEZqcQoIPRl7P6weL3+IW6eIxyRm4pp9yyphqwJDNCiUQz6zMZGT9axA/TPzu
 qWpXX850fISJWpw+EgX8PPAeS1JyyihjoJwMYclkkyJuGeXwIE3m5fyVl+hOsh1GVMSYYJLwNVn
 V3x6t90rCldGb6f2itgriKvatfWIsLFL74YKISIzyz7dgFxwSGEAz4+cUMrgaOe0CYQu0fq4kG6
 pGsQ0BJkoVeuphTspOWqAZZNT/wRBRCadem4PEJuomv3+zjuJx8m9mqv//XAP5pFGq8G/y9YfC6
 6LA2Ju9EA79pZ8zMqOWAN3p3jjaykw+wkCYs0TcbHQP9/H3Uc52onG0qgoB6vh2jwPvH405p22X
 9wAgR2b8kdM1QM89ZpJURSd5PQ3eMsgVlfWQS9e2zudKW2ZJI1xhPFXyGzmwu07B0mtfTfgxgjm
 nUlc3+St6+tMCk7pIka8Cn9oSCH+ZGj/R6fPFBtkjU5OwK9SJn3ll3xQ==
X-Google-Smtp-Source: AGHT+IHvPKIJIVCxqujl4TCB4nTGhlGhqkX2sWMMSOq09uy5N7X3OLBL7t0SaJEpigzsE6VVnOjHmg==
X-Received: by 2002:a05:600c:1f92:b0:477:73cc:82c3 with SMTP id
 5b1f17b1804b1-4778fe9b3c4mr121531705e9.26.1763387992724; 
 Mon, 17 Nov 2025 05:59:52 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bae1122sm119065935e9.0.2025.11.17.05.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 05:59:52 -0800 (PST)
Message-ID: <52339e58-4366-4b7c-872f-b28e05370a5d@linaro.org>
Date: Mon, 17 Nov 2025 14:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: ancilliary -> ancillary
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
References: <44f5010964049b9988923ce1429652e0a9e8ebaf.1763380540.git.mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <44f5010964049b9988923ce1429652e0a9e8ebaf.1763380540.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/11/25 12:55, Michael S. Tsirkin wrote:
> My dictionary says the former spelling is incorrect.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   docs/interop/vhost-user.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


