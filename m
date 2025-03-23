Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73478C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twT1q-00022B-Cz; Sun, 23 Mar 2025 17:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twT1n-000219-2h
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:38:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twT1l-0007qL-Hw
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:38:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso19758855e9.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742765920; x=1743370720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FGux32snqHn3bqJOYrxFFPjAfbQwgpQ5jftH10hxwHI=;
 b=xOBLgRoZCtxByevxwYFULkXzgsgDIxFv2ApC3kUYVGSnmeXQQtBP2RXx41RDjkKFf7
 4FsGsKcD/xYqZ4IivCTQWlyx+3wi9luPAoUOjIZPdiALB0M2KuY48QOJ8euwaTS+S/IW
 n0YNYKFaNl4IqtzZlQ1YpDNagPwhOs6oPdZ/k8eM81FHOrGyrQ9C6WAZAQ4VyxKGS1cD
 3Iu4K6h8aUY9LguUsrfDwgZuI4WPq6MtMgcOlcJxzd8A1QLNT7RIzJE1NUHQTcPLs2a7
 hDCZalUr/zSMeQL/a7A5MkiOqv6g1jOusFVk5ZlVeHv2AprmEzsZuyWWnDi4ZLbt0NEI
 iVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765920; x=1743370720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FGux32snqHn3bqJOYrxFFPjAfbQwgpQ5jftH10hxwHI=;
 b=jczWCv/SIEDBRpKCkY5KECY//byfx7LGmjkguVQ8gJPhyTjmkcvC5uiVNiukZEEmXz
 7fzWqHWb98CjAOCcznNgjJp4HwLArFmw3dHjOl7PmWPLi6b6L3NoSaxuUMcp2PetgeJI
 z81J7CH9oTYyJeBjuHu7ninnFy5nJKTXVE+eSU1fn77zrmGl7jSJCrxpRSf96bDb0lYl
 g+z/sNCiSTkzFXSyQUvLPHSpzRxM0BRPkNjEdPU02qFc/SKTnzSsF2gfot8pM7NQg0v1
 hoyZ3HNuvclgAt8Mq4/vpNLMkKO29tS6aN1Xrd10yVNpQteEQHsL2Q24aPsjgUfxnijU
 cLjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZe8NHsFKPFd0i/mqHmSTBAd+etDiGN73hBzgh/7Z5w/38BoR7OaNnQR7fTxgcnbpeN10wfMqGw7Ua@nongnu.org
X-Gm-Message-State: AOJu0Yz+9NQjeskPrC3h3Zf901kk5d2TWXfZQP56q3r6+mXE58DUwiwQ
 ODfBIGIrGc+/+/uj0oPEfqifvGyNOtckcLEGOBcEo3vgAHzwUEZnBAGHtIKelzk=
X-Gm-Gg: ASbGncsCQOC0uEyb72yOsaQ3ZySah+hp7DYL1gSL2/hFmRXvxVUA8BCzgceg4qiT2Ib
 Xd/Wvm3bwSKpvuX7wMv4G5Lbx2BW3+d20Z3I/p8tM3VWYmfSj1cdVxmllbRPyWZvpsQAKJ/vBKQ
 ILt5chJBINDYAH/bDaCV9aozkD58zWpSGiWli/IlND0aNClNUB9JSFAxu5dzTpykgJ4WW5aicDP
 yNPWKl0hya+ayXwH9mgRhrMORV4B5wKR28BwJqLrRfB+EW87ZxyYO8/ZC67OPnEMdtljZbdtdB9
 0+wzwseabzb80UeSqm2RBjo7sCuyaDCUkBSnqUMVmD1bYZ7cXUHjiEzp6uyq40F9e3GcFzf5/KT
 rnSSvqRNMuzB6Vd0bDw==
X-Google-Smtp-Source: AGHT+IFyDo4G7gskzuBAovIlQAW9qwF5mh1ONdJnj+v6FMVM8+n5FeuguKqcRkazwSR5c0LcuKu7XA==
X-Received: by 2002:a05:600c:4584:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-43d509f433amr92665955e9.14.1742765919987; 
 Sun, 23 Mar 2025 14:38:39 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd277c9sm101077565e9.22.2025.03.23.14.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 14:38:39 -0700 (PDT)
Message-ID: <91a89395-c2d4-4835-b286-9374a88362de@linaro.org>
Date: Sun, 23 Mar 2025 22:38:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] hw/avr: Pass mcu_type to class_base_init via
 .class_data
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250323173730.3213964-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/3/25 18:37, Richard Henderson wrote:
> We want to be able to do more common work on MachineClass.
> Pass the class name as a string in .class_data.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/avr/arduino.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


