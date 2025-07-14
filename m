Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CA9C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubR5s-0006lq-S9; Mon, 14 Jul 2025 17:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPS1-0008C2-Qz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:07:03 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPS0-0006OZ-2Q
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:07:01 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so2723767f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752523618; x=1753128418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HnGuHvjonix1TgErAzlhDeOfGgZDuvfIQJU1S3KJiag=;
 b=PU7n7AdWLVpfUJQSnRSbaarumIXl2vDT0gfYi92UVgpBQWlWw05PyAeHXwnUwPR6lI
 GSKXFKddIJnDtd6RiSjxqsbKEPCshQcBgyevPRqOBwU6ehBUNsMuIZy6xR4LVu+9nxdu
 GZdKde3afa3MakJCTivFKZcpAFyNvWmEQexa6SNI9Y08Qz+o0Am2cxoDxcl0PxLQU0lx
 YqXEXdjg3JH8wILs5Nm64j8JukF6H8P+R6heSkZZDHkpUwMLaw0OwHTkFqZ5j9MUc7wb
 cBL15TdX3q4ZaMhnQq4Hc60AVyoOcCaekbtVlcfNV8nADkU4j1k7+Xc4C8E9kW0izMnC
 ukIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752523618; x=1753128418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HnGuHvjonix1TgErAzlhDeOfGgZDuvfIQJU1S3KJiag=;
 b=MfM/ZRulUaaMPP3dyQnyhciM5+k7hydvXZtGvhNKooDIMueBqfJgVCGTgz7kAg5XF4
 06wkPaRL+rApcDUqbJyc+bhXh40XBF/RoVclS3uJgyqvKmrit6V0iVAZKzSLcRFKv4iP
 y0nXtcTstVbWTBne+OBt43dYDF2RaGHiBi21iplhiD294QL22gVayuLv+mGBZmDEWF9c
 Xez7mzgvmTd7n+p1q9Oh2p7QpF/ph00o8cBbwDQmcIOmjvp5k1RzOWneQR0HlqPEbAYS
 B+yw+dunPsm/Uf+Oe01syjiettgiiLu5jYlOUG+GzmTUSlDo7BdAyCGCV7OxykI1E1kF
 zelg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBkrVbEuSqhhmA2Tr6XXY4QFvqZNjaqlaJ3GS+T5dW73hzFG3Kp6Kdq/gSfg7KvJPfufXAl7oK+3f9@nongnu.org
X-Gm-Message-State: AOJu0YwJb2+a0emL3Jx2G142wvY4t3kMzFR/1lzAY7sg4HIOdjzMI6RA
 00CxhlXE9SKjPkD+a+MRQTQEKC+yd8Wf8510NUlDl3SyyqiMmOf1v4NHf8AQznrRZKw=
X-Gm-Gg: ASbGncvcyc71+Ljq6MvzY3K+q2YKNq6u37QlUy3fTG06jMSdTWRftPxJs6YH2uMDX90
 UVsWkO9mr9Y5Rj4yd4tQfNKE6aGngdKJw9WWxz0MGoKdt4NQiEaWoKvS7Of34Be/CX4pLNSU5oG
 lep8B1OVBRXHZdO4XlybLizwUkYHJFtC9eutQnMh4V/kfSbWlGGj9N4ET/r/nEVtP0ZETeOrzVd
 2hV2nDJYmPbCJrEHGxvymF1xcwxp2XAAoBeRevpzGEpNv1cqqRrDI6V0ZxFZ7z7OFuSUsyIWwct
 AWfezjO94MrY31e4lpC7S3Xj4Pco9qDDcu3oLmS1OffIWlRBCC1S2Z7zk0a++l9O9mB4gYFz6fW
 F3S79C+/Jic/FVlnJoIWLlEraTp0ec5tuarXT48AlITZbrBm3USAfikGEGOvLL3y8Fg==
X-Google-Smtp-Source: AGHT+IHvvkxTfUYFzjGFZYZThFJQ0Fo+kLEO5mtI6Cz1NsTYN6C3+cPekXTGxz0L3Js4DxK/n3cBYw==
X-Received: by 2002:a5d:54c1:0:b0:3b5:def6:4e4 with SMTP id
 ffacd0b85a97d-3b5f18dc957mr10427699f8f.46.1752523618024; 
 Mon, 14 Jul 2025 13:06:58 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26ee3sm13491852f8f.96.2025.07.14.13.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 13:06:57 -0700 (PDT)
Message-ID: <9f73dd64-5fd9-4b92-b146-74e94408d437@linaro.org>
Date: Mon, 14 Jul 2025 22:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/net/npcm_gmac.c: Drop 'buf' local variable
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Jason Wang <jasowang@redhat.com>
References: <20250714165523.1956235-1-peter.maydell@linaro.org>
 <20250714165523.1956235-5-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250714165523.1956235-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 14/7/25 18:55, Peter Maydell wrote:
> We use the local variable 'buf' only when we call dma_memory_read(),
> and it is always set to &tx_send_buffer[prev_buf_size] immediately
> before both of those calls.  So remove the variable and pass
> tx_send_buffer + prev_buf_size to dma_memory_read().
> 
> This fixes in passing a place where we set buf = tx_send_buffer
> but never used that value because we always updated buf to
> something else later before using it.
> 
> Coverity: CID 1534027
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/npcm_gmac.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


