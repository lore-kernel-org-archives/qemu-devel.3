Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC1FCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOC7-0002qL-Rl; Tue, 02 Sep 2025 06:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOC5-0002pg-GN
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:24:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOC2-0008IG-Vk
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:24:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3d4dcf3863dso1487972f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808689; x=1757413489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uNmI3tZMETaJqoi9B2ndK7YvGtg5WNz+0IzW+JlczKo=;
 b=oEWslW6B443BjKBEtmEywc/w6TywgFDdt3I5rwfD+TsNHru0XXX82prYiT8WtvOl8m
 59cdbmP/7bvEgNfYAgDPUgcRjsgC5s9lPmQXtpnTw8iXVwBfXEDAoJRxa4Ev8l9zVAgR
 vmlj9/7c6aXrIbG9OM4luzTO54Clx7ZBU8aW0sotBnYgXxpH/ANwPBovMlin9KBaCDUc
 0TCclANXSW5QTnTcLwwrRTWOImgdzUUvlJO8K/mkjgOLsCmhTtxaALF/R1uRoJ+SFyh2
 8cVoUZImv9XfNMizonH6Y7qLKrqBHk1Rl8sSscDBAisDviAned4lkAmXvHzhlTHL6T/C
 H7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808689; x=1757413489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uNmI3tZMETaJqoi9B2ndK7YvGtg5WNz+0IzW+JlczKo=;
 b=bfq1SQwPZ/HwZVvwNi3teeM1ipsWru9sBJba8H+cAEBkEzbV1xqTyOL4L84NwXy3PR
 gU13k++Ic9Y7El+rleqvXEUNfRmOBPOl98v4ts7qFV4DRkM9zo4tw7RDBh2GuPzxXNR0
 B5yuviOuUrdg2b5r8mhmNhD4HijSJUvxWEDvuUpN69Q2EDP3/LP6VBKwsvTsFSa2lBcC
 WDcf00OG7zt21+PlrCU2ybHZ6tAaQLuim0yWppSjMW8lR013xQUYPSwq+UnnqW9ZCLBj
 ylB9Ubqu+TR36/2qxurtSuilMVpmLhPizuNmaIhnPJxVICzAti+hEmLVj6CLoFWx0iyP
 WWEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5JMKOM9JDITP3hv66O3D8Tj+tEbNTSt7RoqAbOG7fqiWpS0hUxMthh10XLpKNkbIpbaZmMvCkip9D@nongnu.org
X-Gm-Message-State: AOJu0YwruixU3rPo5sBhn++/QhqhCXtSrZXVaiywzDzanreb6IamSUsV
 WBz/mQbHZCw+h/rdWEwERVGUNNRHMGCN6VeEKkKKn9FjwTeNp5QbAYTmf8lJb99VCi7h6Ki/woS
 8Stuo
X-Gm-Gg: ASbGncvQe/GuIvRroDiDLMh3VxnFzg3DHSYIYbht7J05ef7mLPoB0gD8VEKGGPBwOTr
 WZSlOldDIgZzUxykPBxV0Yq5psZQ0Zw9ldu5pY+QgQxJQk/YTamfGirMJEbrvCgtdLZfu5ELr8n
 B6gEs6QQ8Hfy/BqWn+fufuHZCC+QeMFRFopsVMeJvM2WK43XMDvqFs6UJkqtXGvgjsuOOVdR+q+
 k5em4u7NemGI9+pM85O5JeTDahbB8JiPpnFw4FFjW7qhGqwR8IFI0RzeqWB+Wmj6WP8uaYvlY2g
 s6zaLUOXG5SAE6tonfVgFH+pWThMLiU04dAaxkxyhHhPy7XPBT2hV9C3RUE+ShfIGM2Dhd0FfkX
 ynLeM2IvpO3wOcZKDpJVfcwh/aGIYRRgXRBKtwsmORlVVmdqxs0H8FmJfgWLbbtIK4QAVMovS8e
 nt5kFg4HnHuyk=
X-Google-Smtp-Source: AGHT+IFp28tvGBJPynlfoBqnPILEEN7JZZUiPMm9HpNlGsQC82BBpvnVa7R2sFALufn0lEhyVmagVw==
X-Received: by 2002:a05:6000:18a9:b0:3da:84e2:c076 with SMTP id
 ffacd0b85a97d-3da85016655mr1189598f8f.55.1756808688825; 
 Tue, 02 Sep 2025 03:24:48 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b732671b7sm135389315e9.3.2025.09.02.03.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:24:48 -0700 (PDT)
Message-ID: <8f6bc1f0-402b-462b-a5b8-a8fd229399d3@linaro.org>
Date: Tue, 2 Sep 2025 12:24:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/ide/ich.c: Use qemu_init_irq_child() to avoid
 memory leak
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250821154053.2417090-1-peter.maydell@linaro.org>
 <20250821154053.2417090-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821154053.2417090-4-peter.maydell@linaro.org>
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

On 21/8/25 17:40, Peter Maydell wrote:
> The ICH9 PCI device uses qemu_init_irq() in its instance_init method,
> but fails to clean it up in its uninit. This results in a leak,
> detected by ASAN when running the device-introspect-test:
> 
> Direct leak of 96 byte(s) in 1 object(s) allocated from:
>      #0 0x58f3b53ecde3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qem
> u-system-arm+0x21f1de3) (BuildId: 8dcd38b1d76bd7bd44f905c38200f4cceafd7ca4)
>      #1 0x72e446dd5b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1
> eb6131419edb83b2178b682829a6913cf682d75)
>      #2 0x72e446db745a in g_hash_table_new_full (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a
> ) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #3 0x58f3b7c6fc67 in object_initialize_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qem
> u/build/arm-asan/../../qom/object.c:568:23
>      #4 0x58f3b7c6f670 in object_initialize /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/ar
> m-asan/../../qom/object.c:578:5
>      #5 0x58f3b7c6611b in qemu_init_irq /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/irq.c:48:5
>      #6 0x58f3b5c6e931 in pci_ich9_ahci_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/ide/ich.c:117:5
> 
> We could call qemu_free_irq() in pci_ich9_uninit(), but
> since we have a method of initializing the IRQ that doesn't
> need manual freeing, use that instead: qemu_init_irq_child().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/ide/ich.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


