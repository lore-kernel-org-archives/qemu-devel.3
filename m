Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83C4C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulPxq-0008RL-Ua; Mon, 11 Aug 2025 06:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPxp-0008QU-6t
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:41:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPxm-0004rH-1s
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:41:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-454f428038eso38399235e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754908865; x=1755513665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f3242HSrf+maEBiFnxIJjp/97eu1oUsjXSoH1Q/0ZCc=;
 b=cQIvqt7PAA2gzD+G1SsRFWMses9hLTXZX8LUL3YlhGV4WwqvNj04GVqs2M7I/KwjMA
 opkznuakxSH1O2Z4rMC9yihlMZIe1RWfgVoNZWJjv7pAX+kIQUWqKLKIJ9edH+ESOP1Q
 4bj+QX0ug6IH3erFtXif1G3S7xFxyhICNpRs6Y47RtpUn2YUQYMg+0eruGCkCrkMa6ce
 OEl1K/IhVW6L2Q0OvPZQ3pDhLJD0KNcNvJqu/lPWww3VBktWMxNAZfRg2iUYmSYnrhL6
 KffxtR1UMAxYTfntZZAhe+CKG2hkO/mOMVv2r8+tho4T64Tuq2ilw6bWrsUL+8EcmdzM
 aQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754908865; x=1755513665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3242HSrf+maEBiFnxIJjp/97eu1oUsjXSoH1Q/0ZCc=;
 b=YERvHxS20rlOH8obBjQBuudXRkqHlbki+2Z3pDSUWsnp/Mv8IbqkG6h49OYVv1Nyxi
 3M4aMbFtEY8YC9FI5kcdS5XeYu12zbXZER2mlzVYSAyLQcV5Z8TY1G4AKMs/R9XliljI
 dmhpMQpt0faL6Da1tiNdBMFUFXRpkRpKG567Ktr2Wis+9EfLu2qr5DfOCdPoVvP1YDWk
 21CJJXdYFR7XCKGXnWLzD6i05O5th1Y/eQIkV/WZc4srvS4cnWVxx1Uue0agsIPvQzqO
 pudQaG4zlmG+d0bof8+dBltCfmNG46bQA/mEOx9thHSlh6CZ3e44jOC79hYwFQw/bWKL
 w7Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU84MXAHhjOmVyXF18Qwe6gN1RNTtzGKBrZ7NW/DEe/e6ftq6miBr9ES2me6qtg9FvtR4MmyzGUR9ea@nongnu.org
X-Gm-Message-State: AOJu0YwZsEwr0ut7fklfxwQvQGTiMuXgygpsjAR5Yqiw3/y8v1CPlX+9
 CKdIEfyeTNjURdL53aBjlO9GWN0+uKF0XV0rfG98JyROnewgKD3xIprkDW8KoMVn0eQ=
X-Gm-Gg: ASbGncum4kQ1VauJzpp8fdayDX1Q9go5CrQdmIhuuKbaSpW7cbu/srPfoTuOPFjDY3S
 26yHWCnMQw0ypWtqRPSQ7MjR07S6kDqZvYmTlMkwhAIHYJQloX/WkN4K4sh6Owm0/zB1O6HEg3/
 jz6XEz1aR0Urjzg1s6fBZyy58/zoOXzthDvOe6sCC1LBUL7VJqCB+9Ty9oZUlsOY9h85b3okwIe
 VEhjTFP43w3I580dywcuwHWR1OTrFGEiMIUuitdb2CG0OjoPu9Ui+XMuXowtVjSUfwkgT0IAe7Z
 J8DUV8Fl314iAVxX3818vAE3LnIV1SDK56k7bomi4tf89DZTTJQB1AAHYywxsrfGTo/U3N3YG3m
 pLT6E2j4cQuBiwXHquvG033K0bJDMKCawUjYKUA0OMseCdNiwC10X247ZK8SklNf1JQ==
X-Google-Smtp-Source: AGHT+IHDOfv8bk13Er32V5qJi5p0Tev/TKIgt77Rqllo3oJoK7O2WDdGr0qNDpSoeeJ+eeK6nr5wbA==
X-Received: by 2002:a05:600c:354a:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-459f4f0f57fmr116790005e9.18.1754908865308; 
 Mon, 11 Aug 2025 03:41:05 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e0cd2c90sm296408435e9.17.2025.08.11.03.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 03:41:04 -0700 (PDT)
Message-ID: <61a78e65-4164-49a2-8ce4-d95730b10eaa@linaro.org>
Date: Mon, 11 Aug 2025 12:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 05/11] hw/arm/smmuv3: Support secure event queue and error
 handling
To: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-6-tangtao1634@phytium.com.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250806151134.365755-6-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 6/8/25 17:11, Tao Tang wrote:
> Following the implementation of the secure command queue, this commit
> introduces the infrastructure for reporting faults and events back to
> secure software.
> 
> The secure event queue is now enabled, serving as the primary mechanism
> for the SMMU to report translation faults and other architected events.
> 
> For more critical failures, such as an abort on an event queue write,
> the SMMU_S_GERROR registers are also added. Finally, SMMU_S_IRQ_CTRL
> is wired up to control interrupt notifications for both the event
> queue and these global errors.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3-internal.h | 38 ++++++++++++++-----
>   hw/arm/smmuv3.c          | 82 +++++++++++++++++++++++++---------------
>   hw/arm/trace-events      |  2 +-
>   3 files changed, 81 insertions(+), 41 deletions(-)


> -static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s, bool is_secure)
>   {
> -    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
> +    if (is_secure) {
> +        return FIELD_EX32(s->secure_irq_ctrl, S_IRQ_CTRL, EVENTQ_IRQEN);
> +    } else {
> +        return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
> +    }
>   }

Or using bank as suggested in patch #1:

    static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s,
                                                 unsigned idx)
    {
        return FIELD_EX32(s->bank[idx].irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
    }



