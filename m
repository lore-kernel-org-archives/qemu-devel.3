Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05998CA0EDC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 22:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulxYF-00038r-Bz; Tue, 12 Aug 2025 18:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxYD-00038Q-MG
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:33:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxY8-0007sc-66
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:33:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso5228005b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 15:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755037972; x=1755642772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9UPIjDCWCxcVmU8TZuNSyD52F/QtiVOiZgntG6bKBpg=;
 b=Fx7FqRK3kQB8cPXlhKzfeQHc1xQQuHZ1P4uedm2pPZIP0ECcK77FjRfZb+lfA4MXyb
 w2jIE+dZp5Fcwanp7Ql5fNgBogfv6KR4VJXIT3Si4ZSLLLrpcK9PW4diy+vKSfJ2PiOW
 SMHKYHGpxNjhFu4A2RTQ6g3qSeXDvR26d6XJTJ5mPXZ9M0QoWSN5/QKnzSmW+siH/GtN
 lEu8SZSxoo5dLMW19rta9K4vBgmRtj2hnp8t1Oh6dHWHs5GbKhtd330qxUMfMzawah2o
 c6sdKbthQhz56kHbvTS8JADqoY8QRqZLSikT5nuaQolkwDYwYWc1FBf6ZVbkG0LR6USQ
 Lteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755037972; x=1755642772;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9UPIjDCWCxcVmU8TZuNSyD52F/QtiVOiZgntG6bKBpg=;
 b=FVP63v3b0cIokkXZTq/YPLkPzLMXqmlhoQDno9VfhkslvoFjt9BJ2S59i+e6ZM0wrL
 aC/NDqry3ww4KthfLymbs1n7H3zROQ6vNNMGBnrrQj0dOEkDNHte7jnKKczLxFqak91/
 Jlw7e49Vr8ZIzwDfD+HnUojN648mgZPhwMYbqBNIWxw0+2QuBgdZgAYw7xJFG6/lvwBo
 Hi8mf2HB64B8tPU2u+ZSawnSOASw+sYv60lk4Qnn4LLadIYENaowDBLYt1T8A2Vnp+Jp
 XMW/O6Yi9rV62Whjdb6aatQ3m06LqYJH7gcUC4Y9EIDpEFs0SLKe4wUJbdl873pGFqfd
 1rpQ==
X-Gm-Message-State: AOJu0YyjOcMedUCxuTAa+I+mKpkAOwWn3+jdja0xh+jp1HcT+Xx3N2Jn
 5IzY8gHOBvhE6lMFM0L30thXUeu1l22b92vfnH/PfUI2uhhOICgyBm4zmDI4eEfNOqBSLxSpzlm
 HPpQ3p5Y=
X-Gm-Gg: ASbGncvzf8OlowiMlLHJrp4MbcAJwQnGjieJ+MfeLuMdcaui2tH8ESM23sahiw9SS53
 IrXOp5thfQBfJsyaZPItSUdOc+zogr9ceDA1yIefqJQTzN3HbIhTdiu4I41kSetHRDDH7UKkLC6
 dgjJqhBJnMqNSPcLwP6QrjQ5xwizcuIpIb21LK2bsh4Qym3y2beZDdMm2wvIvg+w+Qpelg+Fbcb
 byOfIqY7V0KQt6jUXqNrRzeURVtFk+PkTw8OOVZS2Ne3r6Qhr2+nV2YzOQ2Dqa4aNsEBXucMYeT
 ZuTYhQqdQfayRzEdfZ1tjThgKDdkSwxCE0dPfZHQaZPVc/qtC3Qkt/7y/s2YHfVZphtB75Yo7dh
 m6N5w6hWQS4Sz7z8VnIFwS+UkztR61tkXSBryZXY8
X-Google-Smtp-Source: AGHT+IGdCDAVjL2ykx5IFaMnquPy+h1/c/j42Ol28LxxdvjBmx++OSAN0SDrWOXT0wfFPsVujHQwIQ==
X-Received: by 2002:a17:903:4b07:b0:242:9bc4:f1ca with SMTP id
 d9443c01a7336-2430d22e1efmr11244595ad.57.1755037972331; 
 Tue, 12 Aug 2025 15:32:52 -0700 (PDT)
Received: from [192.168.4.112] ([168.140.255.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0f576sm306862205ad.47.2025.08.12.15.32.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 15:32:51 -0700 (PDT)
Message-ID: <36a2ddd6-6858-44ad-880e-a9448db87956@linaro.org>
Date: Wed, 13 Aug 2025 08:32:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 09/10] target/arm/hvf: Consider EL2 acceleration
 for Silicon M3+ chipsets
To: qemu-devel@nongnu.org
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173157.86934-1-philmd@linaro.org>
 <20250812173157.86934-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250812173157.86934-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/13/25 03:31, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Just a proof-of-concept...
> ---
>   target/arm/hvf/hvf.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

