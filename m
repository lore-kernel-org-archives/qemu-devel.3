Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B34CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9GoC-000500-4b; Thu, 16 Oct 2025 01:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Go9-0004yz-4s
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:45:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Go7-0005f2-0e
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:45:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so133350f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 22:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760593545; x=1761198345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ACxglyy5HvSCuOzcTlFOXNff5zPdyAKS0uWNYhEcFxY=;
 b=dxWZRmAMaeJyZLYcZzoaYaAGQ/eNEwWImyNBbJfg08SZqAdve8CfEcdzkv9JegEtb6
 ePAFgT9IzI+ODo5arok9NHnuTthnklhs/MAotr2E5GVkaYzqVEQhZpE75F5A34DntSSL
 iJjWXvbL5wRBoVnznwmWZVxckIfDa+QeNY6rl7UAYQPyGvsCxaNEEcGa8ua6j7JnsntN
 CwyIz6ItTTdEAfstii0qdgP3KN97/1q+idDW6Fug+ofBkAUK5lLIoUvw2FoB5eqE04Gl
 4brSyLsaXR6ZwADzCzFiWoriwU6/sQtBia4s9oqUHZnJ3vG9qSWppt9ZejyRTw6WM75B
 a29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760593545; x=1761198345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ACxglyy5HvSCuOzcTlFOXNff5zPdyAKS0uWNYhEcFxY=;
 b=K0fZiOOF720pqLwIaYLK4bnvk5BQELOqmohCsjQwY8J3G3+jVaiTAhFf/6dK+N8sJ5
 Go5LtjKZhNqfoMiHc2GO05UfPif3bMTC2awtWUAcVNRadPKlGQ7pVlj3Fy6JMukh0viF
 Ha/CAXER/fxR3nGvdg8pClkkvr+U61UrdcDCqql9uy5xhDOdLC1z2/W7bJjhRCzOSiAm
 g/nAPr/WqFN1/WJnG6YMQfrTWxgR6RU8p1QDRaM96jPA7kVM0Ew3Sg9dNFTsGcBFs97u
 6f2jUrW4cwu+kEWmyE3FF6jG4fmOKb/kN/oNmxIKa+RdfEMteLh48ZEAeCnOa3IAVNLW
 5VCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDVAbqH6Z+PUiMRPsvm4/pusfIOLqnSQvhlySeSKmbiqgXvdHTRq2ttx2dkLAsTr2XpOz+RGFAJCiT@nongnu.org
X-Gm-Message-State: AOJu0YwfqJ0rKLVMWqQ9FENtigH4zxXXY9qiORltNUuSn9kG3/H0ZiXm
 eb3Ws7Ae2eOIhbSD3/Zk5dRVKsDdZFQLomFMLYfjcJ3XTtAS6YPRmz4uO3UQAn/mOtc=
X-Gm-Gg: ASbGncss+bJ8NGwfobHMvoiVOlXXfGVG5HecwkkgPRgWnDMicr4lNXq4eyF4vXqahCC
 RKThTFZzMhojO9sUnaAYBZcCYvuSiJUnU/Si++GiGrq0AvowHrnC76B7FxSxXCtIy3znL4gf7wQ
 JvgnnY+iojDyI6e3towpCmukzAuhrRRM44cIgM5ovE6SGHeKC0loMSQQyBEbG7UhUjv5jzJCaoU
 Y6c6/jIs/lLpJ7MPhxxiQHLEXB49uO7U8AXZppNQsOw/XpQocJBz2QitIJxqXR3Ox0b8TrX2SGf
 7+qCV+CicBQ006igXi4w8yO7btmMptyfsKne+y6oR8O1+21co0VHpEV+wOta7vNp4XCUXhW9eNP
 iHa/QbxsEV6QwVuUdxBGRCMUN9MhxPNfNiX2Cu8igdHMhUCUIYnkKYKBcFJEfSxetaOeviogEF9
 uNUBlaHHMFdDWHM8jjCAoHEXR+Zh8HNkcfP8E+WM3yUB0ZYonjsm0t4LHQYg==
X-Google-Smtp-Source: AGHT+IECpXA5HG3jcMLpTL2+QvLnqFjLPX/eNEi/raveDVQmYSgF4rj71NuHl6Ojx7+KSWrsYw57rA==
X-Received: by 2002:a05:6000:2907:b0:425:7165:3d3e with SMTP id
 ffacd0b85a97d-4266e8e448emr22681400f8f.60.1760593545023; 
 Wed, 15 Oct 2025 22:45:45 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe4esm31320312f8f.26.2025.10.15.22.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 22:45:44 -0700 (PDT)
Message-ID: <b76bace1-9f51-4dc6-a927-6f75e1b28202@linaro.org>
Date: Thu, 16 Oct 2025 07:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] contrib/plugins/uftrace_symbols.py: generate debug
 files to map symbols to source
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20251015232809.628043-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015232809.628043-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 16/10/25 01:28, Pierrick Bouvier wrote:
> Enhance uftrace_symbols.py to generate .dbg files, containing
> source location for every symbol present in .sym file.
> It allows to use `uftrace {replay,dump} --srcline` and show origin of
> functions, connecting trace to original source code.
> 
> It was first implemented with pyelftools DWARF parser, which was way
> too slow (~minutes) to get locations for every symbol in the linux
> kernel. Thus, we use `addr2line` instead, which runs in seconds.
> 
> As well, there were some bugs with latest pyelftools release,
> requiring to run master version, which is not installable with pip.
> Thus, since we now require binutils (addr2line), we can ditch pyelftools
> based implementation and simply rely on `nm` to get symbols information,
> which is faster and better.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace_symbols.py | 116 +++++++++++++++++++----------
>   1 file changed, 76 insertions(+), 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


