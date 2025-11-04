Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02707CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHlE-0000d1-Bn; Tue, 04 Nov 2025 09:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGHl9-0000cV-Kd
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:11:43 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGHl7-0003mO-Qc
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:11:43 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-640c6577120so3470954a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 06:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762265499; x=1762870299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xwmPbXAAhBV6jVn1buwKJR6G9pVvYjuLW6bCrItipB8=;
 b=j9JMiq9aodrnoXcVk5wQGDZW+XqreYsumKiEQgWHZt9D+e+YcEXsHKivHjiA4+i8Y4
 9blZW4fteAxhMhjcpaarxYl8vg0nMFj0ogtfoOsDOjB6TfKPR7ohwgsRin8NEvHWeoQ5
 WS/iwFITpJEdrvrEk+at73JFazNJspwAKgb/Uhz2M8SoHnAoTWnNLcazj6q79plmRjCf
 aFQAqfthgOeSKU2wvow2yETwkWsEr+1kU3LjLlD7iW7wMy4vBViwNOxuJSqU5+oritoa
 bVGYE6HxSc9043r5r6HSR6Bo8M0/xlrJd6l6Y3cqiy0vKHC9/MkAeEA60AsRi/xmo0om
 K03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762265499; x=1762870299;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwmPbXAAhBV6jVn1buwKJR6G9pVvYjuLW6bCrItipB8=;
 b=i7R9wXK+5ptjSO6U+ws09jluw+9gYREIDuBe3UzEc+3djmUsOPlP5/YQhTGc4tBRkb
 eKcXwFXat3s3syviYYk/0Ch5WaILr4H8JCYm+mEDQUAqor1WgWuiXbgHdNpT1AO3XL/m
 PpUvFRI9HOgM1Tg/sB5f5v5+ijJOnJVZj6yX8j9brs8pWhFZmi/jE+rHricX9XWiWrzd
 7WW2XEUZUKZIGMKyuL9SZPYCe0+zomFLEyp73dAW96yZAipTjDlOEMtFbu0a2LWsVlsQ
 3bcE/o39UzZJacdeiZstzQGjmUOvEdeFPzXOD+qvBLKURi2ClokgSDTnDQErEF6hVVp6
 5F0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCViCN/mPMCf8iEHFWd9xDpzKbIHeOvkJdMa0xFOk8NfB+d4GyDv68lPAuSsIKtMsi2onCatPjMwcswS@nongnu.org
X-Gm-Message-State: AOJu0Yy9rxeCtmwQJjsc/rtcinbYAFj6/Q2NUfHao/rBhwWUQVHK5rKm
 WkDc/pD4pCdn9vZU6jZw4NZn9xA/Q+w3cLrDVxnaIkQFJO+5JjUMeG5Ik46jqJiqusQ=
X-Gm-Gg: ASbGnctRlHixne3ryay9qgYxQl5M2D/4n7BJgT+3voZEhy7s97PaK6DC7dSU1/wMH20
 SW9dSer/81+Ss8uaNU7TFYFhx732LahXOBjvdq1IE8HpSk8flX4DmwTlCkHJ2ddixceWZViUzFy
 UUOerLMlGigmxrxEdC3LvgyP71wfSrnKEHFwuvuSZ6ak1WfogGbiwPP9MzE/lBlSNn4hymsNd6E
 pshEJ/Uh2v+Ngx86yLtZ2sAB+8QAyWoILEK2QRLqH/1QsmB4WEaL9K0ehfVsEn5kwXC5G92j/He
 ax6TmY858lIs0jC+fjhJsFsDhEUAYc5yHYlTy90Jk4xTWgfC+9ZiDjSyCoC3NZLBaOciRg5iVVX
 1i5MkeOGL4UL91VBifAXDJbRoaVVhzoKkTYXxF26A53Zt2ADISxw9bzT4bdFKm9WkJFCvAJ2Xlj
 7sdyBBef59O+UVB9J+Iu8YO3Q8CxCUbQtgUUQaQQ==
X-Google-Smtp-Source: AGHT+IH+wim3NQ8IMWK8ddgW7r/qA8a5o/WgiSrJtkAGntA7Iw8FrCvYkINtO+6FAtIELXQeTVhZgQ==
X-Received: by 2002:a17:907:6d0c:b0:b70:be84:5186 with SMTP id
 a640c23a62f3a-b70be845e68mr697321266b.44.1762265499474; 
 Tue, 04 Nov 2025 06:11:39 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723da0e6acsm222559266b.29.2025.11.04.06.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 06:11:38 -0800 (PST)
Message-ID: <8374b2ef-6edf-4a22-8c4b-8c1ccb56851c@linaro.org>
Date: Tue, 4 Nov 2025 15:11:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/3] i82596: Implement enhanced TX/RX with packet queuing
 and filtering
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Helge Deller <deller@gmx.de>
References: <20251103132029.6725-1-deller@kernel.org>
 <20251103132029.6725-4-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103132029.6725-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x534.google.com
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

On 11/3/25 14:20, deller@kernel.org wrote:
> +static void i82596_init_dump_area(I82596State *s, uint8_t *buffer)
> +{
> +    memset(buffer, 0, DUMP_BUF_SZ);
> +
> +    printf("This is the dump area function for i82596 QEMU side\n"
> +            "If you are seeing this message, pleasecontact:\n"
> +            "Soumyajyotii Sarkar<soumyajyotisarkar23@gmail.com>\n"
> +"With the process in which you encountered this issue:\n"
> +            "This still needs developement so,\n"
> +            "I will be more than delighted to help you out!\n"
> +        );
> +
> +    auto void write_uint16(int offset, uint16_t value)
> +    {
> +        buffer[offset] = value >> 8;
> +        buffer[offset + 1] = value & 0xFF;
> +    }
> +    auto void write_uint32(int offset, uint32_t value)
> +    {
> +        write_uint16(offset, value >> 16);
> +        write_uint16(offset + 2, value & 0xFFFF);
> +    }

Doesn't build with macos clang.

https://gitlab.com/qemu-project/qemu/-/jobs/11967951995

../hw/net/i82596.c:1468:5: error: function definition is not allowed here
  1468 |     {
       |     ^
../hw/net/i82596.c:1473:5: error: function definition is not allowed here
  1473 |     {
       |     ^
../hw/net/i82596.c:1478:5: error: call to undeclared function 'write_uint16'; ISO C99 and 
later do not support implicit function declarations [-Wimplicit-function-declaration]
  1478 |     write_uint16(0x00, (s->config[5] << 8) | s->config[4]);
       |     ^
../hw/net/i82596.c:1503:5: error: call to undeclared function 'write_uint32'; ISO C99 and 
later do not support implicit function declarations [-Wimplicit-function-declaration]
  1503 |     write_uint32(0xB4, s->crc_err);
       |     ^
4 errors generated.


Anyway, nested functions doesn't seem like a great idea.


r~

