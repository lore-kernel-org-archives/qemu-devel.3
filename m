Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8A8D0EE18
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0vO-0004qT-1V; Tue, 25 Nov 2025 16:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0vM-0004c6-1g
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:50:12 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0vK-0005aF-AJ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:50:11 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b3ac40ae4so3423415f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107409; x=1764712209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FTSbfE2LLbK4RUlSnjZZdILYXJWSwi+rjtYHlTnF9Ws=;
 b=FxsZWDkiKgnxd7uH//K3jmDgVSKvvpV3j4+fKaTqLbllryrkPD+1m57lXhhUfqNukt
 YngI0pqjzUvDNFQYJkRzZx61wNM8a7AAaT+0dc+7+aPvo8Lwl407BCWh8/RmtokIZqBk
 hes34x5OjkoEnBvvfUJtIuaXBfqPuF9HkdrnZ/m8sICcxT0tDIhZoJYZzZxw7c2DAcoe
 czRn1DddCHutWuABpkqFB9D80gQZ5qWkH2AKSTdWMF7msp5xztPj7zv2e3sZQrEtMQe3
 l6Aa3YXXsGTmXnqtP0llv6S0S/scbdLO1QgwPpjEzBXNpjHiDgKg4o1b38/TcQqQVM3i
 FP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107409; x=1764712209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FTSbfE2LLbK4RUlSnjZZdILYXJWSwi+rjtYHlTnF9Ws=;
 b=FYYgaZ0BKoRZ95xNz1raY7agbmQACyOu21e8/rFRA8KSzpu080gjTjvlmZ0PcLAcEO
 J1iQZ5ySl7aKroPlPzIv/Bpn6/JXXYOt6ryU8c+ju88RLhgvM2h4lsviJrcevnNVUNtu
 zbB+GDZUXUr8vkh6hwLLBHYihERA2N5zfYOlJ/VuJVHEKtvXiTuzDHy7M+qBNoRzsFWF
 9YK3L1nOoOpwkjGMOUVu/Zw3b4SzUQuYzxcUNaotbmmxRsK7rnTqmiG6TotyZZr8PHS9
 t5e5dGttJ/gGeIxcWOGWO9O+vSx5nwh/KViW6G0tvgAIJTtOTRqGYQfD1axL1UKiNLsW
 25TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn+CwqrRt43x/C6ZnAYYK/Gx47YvFUD4u15gwUqYCzOMewcqlAcCv0d+AAzsUIgs0wnW4qdHU14iFw@nongnu.org
X-Gm-Message-State: AOJu0YzYRFa4ifKgfChVv1KBdNQIHTiuO+OxYVoBgD3ulDb2Tu5aazx7
 t3Iv6QNLoFO7c0VRZi7md/pm/jDJSUTOyQLvE8e7ObyNENrJMgwwBeoQfw8DrZngQZk=
X-Gm-Gg: ASbGncsh7clmRP0LRypVkz/kqXf8CkRZmfiPkddacq/FmmUh2jafeAf0/Bi/5xiX12w
 94TVMuj6Pr/gzPsenr39grF2tdtQAbN/480B04fKnUiFrvjBtfpyYNg9KWOsglQmsi9HFrTnlz+
 8AdOcn4QrVO0QKX8rG9o23TZphA8NsLts9gLdAh5SA8KTfsfwuxDBdP7gGoskwsPWmu6RwJKaH5
 x9n+3bOhvxxaUiE9oC+tP033nhxP6PPAxkTKBXxhV1uWXhRddDX6K4hieT+uQBOGUi6fm2I8sPK
 G2lslZ1Bc+Y6SikxR+Yj593omZxUR3OxPPmtCg1HLTNDZHPFkRkXoMpNm6KgZ6DqyJ5T8zNf4lF
 xk6fZcehYJcgKpedS1IXUBMi9LupyItE6CUhERiZpdQTVITjbJeC3P2eOunLyfcUDopOykLuBpb
 GcG5l0hkjtMtAyRCbl2xSUMGMfvJroE79CK74mkGxzHyQkaLC3eU6HwQ==
X-Google-Smtp-Source: AGHT+IF3rZGAu+jXI5RpuCWvLQzo0HR0iiZAGWtBuhRQbOyBo3eN789TTWPgzmKV2tJHco2nW19u0A==
X-Received: by 2002:a05:600c:840f:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-477c10d6d13mr194666975e9.12.1764107408712; 
 Tue, 25 Nov 2025 13:50:08 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0c3a28sm8378165e9.9.2025.11.25.13.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 13:50:08 -0800 (PST)
Message-ID: <629271fb-325b-4c15-a036-03b3a3f97338@linaro.org>
Date: Tue, 25 Nov 2025 22:50:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] machine: Provide a description for aux-ram-share property
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251124191408.783473-1-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251124191408.783473-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 24/11/25 20:14, Peter Xu wrote:
> It was forgotten when being introduced in commit 91792807d1 ("machine:
> aux-ram-share option").
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - Fix spelling, s/auxilliary/auxiliary/ [Fabiano]
> ---
>   hw/core/machine.c | 2 ++
>   1 file changed, 2 insertions(+)

Queued, thanks.

