Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B4CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 08:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upMjV-0003an-2x; Fri, 22 Aug 2025 04:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upMjT-0003ZQ-S6
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:02:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upMjO-0003cz-06
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:02:43 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59fso13224255e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755849756; x=1756454556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A+4/WBKGEWM/opyyZP9r5fdXUjGZcK4fRqjRViBp5iY=;
 b=jTwSK5V6V4pGAIOgecqTrvqHub2zPV0A6LTsmRxN9udXxhDvNCl3qfaQ/CagoZlOq5
 zxU5wSGO7Zub3odchO0blrrPI7a2WF04ar6d5LMll/toQj019Gmk7z034e17CxORsFw+
 pWVaot5LudrnbvIlXIbru0jx+D0ATSMsAoPI4WNVnlMc914G9ytmTYWYy6i1dnuqxFnd
 HAVQYwQRcjcySICwfuO7w8HEiJ9GTDJItVw6sCRukEzNJ3hJCueyrF3BDZiGM/wuhZ3s
 g817Rh9skKyzTNp2Hrg1IO7V5uf2Fk5RIsIWivj4ODnERHgp7rM3cLVq1kyH3etjYBK9
 svOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755849756; x=1756454556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A+4/WBKGEWM/opyyZP9r5fdXUjGZcK4fRqjRViBp5iY=;
 b=t/0qlc69lruwY/I5wOWeEgW/oqHC1LUQqVxA8ithfZQrwO/kjOd0nerTdssdxSZ2ie
 BhRmAIv2ELQ2yqF01PX0UOkPR4KvXqww619vm4OXz/EEtSxX16u+3dla3BnowzvbSssD
 UlHKgRdCg3Ne6W0OQ9OeIkDedVUDAl50w+5ztymW2xSNczhjV15vVGA12A0thNzBfFEz
 9qujugcCW9fXSqSl4Go+pByD27nwVyw5eYf6EymL/CVYPn5DbRhIBDvoiWl20XVUrECN
 FtkVLK4MegYDkTkvQ8QjXtw8bZhxUTmTgDPHBmKor+cc1SE6orXIzhyQcy03QmFDQjOw
 IY7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcVnh41Pz/eZTpV5x5GtT5vFilhqtm7YbCY6sL5hR+vAMPfGdCJKEt/vMvR5ZNq8eP/ar3fRQzLYdm@nongnu.org
X-Gm-Message-State: AOJu0Yxks0G0wxPgbD7T21V11E1z8rK8/vR65Yx2/YksV6qWlY8F5ZMB
 2G8Q3oNMfYfvoXa6UK5eLmRD+b5p7WRv/amA5Caln9uIg3sQoSNAa+9PEw37X4fS+Sg=
X-Gm-Gg: ASbGnctKzlXhLfo/xMeD28FYpAeqvyYilDJmie85XPHQQD/mMaxJ2sZ5hmsn5x0ZGO9
 jG5apZWqOg20FGA4dK+hbTkAUT+5jcCXfvl9UoUZ4yqBGKGyvVaGxM0yNQJ+tfwShdwkiMKnYS5
 dA3pUGPErbLNGnFpVQOpAmodmPUAvyYlSOeSxQTrjCqpHLrwSssreIax0JGK+TkKhC8k+LNfhJs
 MDSBefhFaczQzWA1U5MyNy9Ob3dLh6ci231WbZoxXaxPHdDjY24TboESje8P2TaPTHvkeKr5lm+
 KwuR9cYXL9xl6W46tGRNWSfPWVm6coojM94P1l0ttB/5DT+4RE8PJRHmxCtpajY06JTcp+KMh/x
 pB0iQkafxeLtOewnpXbAXQfvFuC4xDqwoEuzgGuXvep//dMujbtDRUntVFFAGH5Kx4KIZ2Rs=
X-Google-Smtp-Source: AGHT+IFMJdBW65LiBqa5J80WZOoICcRQlDlEwNDsTGppq+c4NdVMX4PTgbObSUQSaupLNKvRcFceGA==
X-Received: by 2002:a05:600c:3b87:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-45b517993dfmr13951975e9.1.1755849756166; 
 Fri, 22 Aug 2025 01:02:36 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c3fab22726sm7767025f8f.37.2025.08.22.01.02.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 01:02:35 -0700 (PDT)
Message-ID: <19d8291f-0fab-4d43-b6d2-5e48457cc3a1@linaro.org>
Date: Fri, 22 Aug 2025 10:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/max78000_uart: Destroy FIFO on deinit
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jackson Donaldson <jcksn@duck.com>
References: <20250821154358.2417744-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821154358.2417744-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 21/8/25 17:43, Peter Maydell wrote:
> In the max78000_uart we create a FIFO in the instance_init function,
> but we don't destroy it on deinit, so ASAN reports a leak in the
> device-introspect-test:
> 
>      #0 0x561cc92d5de3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (BuildId: 98fdf9fc85c3beaeca8eda0be8412f1e11b9c6ad)
>      #1 0x70cbf2afab09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #2 0x561ccc4c884d in fifo8_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/fifo8.c:27:18
>      #3 0x561cc9744ec9 in max78000_uart_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/char/max78000_uart.c:241:5
> 
> Add an instance_finalize method to destroy the FIFO.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d447e4b70295 ("MAX78000: UART Implementation")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/char/max78000_uart.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


