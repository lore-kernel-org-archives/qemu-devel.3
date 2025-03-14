Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CA8C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt2Lr-0007ML-Ub; Fri, 14 Mar 2025 06:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tt2Lq-0007Lt-Jj
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:33:14 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tt2Ln-000627-MM
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:33:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224191d92e4so39061605ad.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741948387; x=1742553187;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wasqm4rQgtyHXlL0+HYi3h5zBeRTN1ns2DnLk6iH5Dc=;
 b=cfpGUw2jbgixal70GVRH7dfAkelKOGtWtwoeDT1Q0WA1jXl4mpO55IOjSz4mo+Uuei
 47JMYEvXCg3O5vvb1omfdAZmeEM476W0bpr7WmuZmELrC7MxePJXEZaPrbPsBTZLjkdI
 Wk3UA13iZ3NZB6KjhuQE1aWg9I/wUq/U3RG4DJS+PnPEjqLqfQSU7ym8lzuSFbcwk4ng
 YgXfAK/N8fOAJ+eYmG1cPtNthfR3VNDZaSe/3nmXRBiLvm0XA9PuSn/a5cRyFxOla3Kw
 zK27Nlepc5Y0ZgQKDTLSclkijyPIk0z80a/VzDHVjGRoDUoEfdVCZSsgVwH3OQRsLw+U
 Nsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741948387; x=1742553187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wasqm4rQgtyHXlL0+HYi3h5zBeRTN1ns2DnLk6iH5Dc=;
 b=IQtbnY1uTfE/J62C1nNFpnPof/UTcg4CuW5cJi2H37iydO6R+EyZcaQM0zGo37xWtF
 5vbv4iaF4nwqKwCqY4kEKp6gCi6rGcDFcFKBkjR4ajzoXEGPfqvfS8nJZ0IB52E7Ktc/
 cGMUIwRnyCRVewc4OEcY+ES7bQvghId066lQx1EnDQFvicExKVzhODqcby6dyG3bv4QZ
 n+ks2/c3Aw5IynpGSS5W78CfgvzG+voeYjLjiS6iul+cXrS43PX+792yfLkVTYPKWCk1
 B8Up/KBaRD0JdfuiCc7dLB+a7YmG+s5qelG6lfZYHBBOLFTaiDzQqNXHYFZW4fbcsCZN
 ZTNg==
X-Gm-Message-State: AOJu0Yx7f/tYEpnRlOdsDCjAo9VhMbTi0yTezt0bN2iJyH0D7n66+mWQ
 stRrg8t0TAhOkUkDLTRYyulLYtNQTxzK+CH+OYSRWxPLfNql2cAZagLB8cvQ0o0=
X-Gm-Gg: ASbGncuzMwUq+knOY7OTULOFbDm4UDjeEjGAoHNcGqt7NhEl6Y5bszHBLRbjPZN7qF2
 d0K8cEGao3qYqpz7FNoS6yTlk3D9ni+yR47CJ24mUMqvb/ExILXsjU+6kVbEIwDyO8NTiGYQ882
 NEXCMKxMNPHH/aLc+d1REb/feUHE79NKCKiq4VEibqk+6z1Qluiu36woyVkGtBwlzhvly2jnnA6
 175Gk4Jf5VIjYmKjNHsPTS7SBBdGtVvbi2SfxdWRLQofIRRuqBG8isyXkVHPcOH+uQAMpd27M1K
 xJG1E8jTCXtrxXLJyfg6VvyuTlYz3gz+t+o80BogyJ0mVvkIYCOqXs9i/g==
X-Google-Smtp-Source: AGHT+IEn8Q9jsS+HBFs8lUQOD4eie8+eCuApB80litRGORO0LaPGC52kxBk0Dp6yzwRHxaX5PNON9Q==
X-Received: by 2002:a17:902:f686:b0:224:c47:cb7 with SMTP id
 d9443c01a7336-225e0867fa5mr28353405ad.0.1741948387120; 
 Fri, 14 Mar 2025 03:33:07 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbca77sm26123815ad.167.2025.03.14.03.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 03:33:06 -0700 (PDT)
Message-ID: <945b9614-9b94-4d16-ad65-9215a8f56471@daynix.com>
Date: Fri, 14 Mar 2025 19:33:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Define raw write for PMU CLR registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
References: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
 <CAFEAcA9yKETtDhJroC7RD5itUjsYAkj0fVXHJaUxoU_bce7Gvw@mail.gmail.com>
 <52ffbdcb-abdc-459e-8d49-a0c9e1a5de92@daynix.com>
 <CAFEAcA8KVogRXr1PAocWPJzj0nLzCiQc9SQ1n9rWHHF3P=ZEVA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA8KVogRXr1PAocWPJzj0nLzCiQc9SQ1n9rWHHF3P=ZEVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/03/14 19:29, Peter Maydell wrote:
> On Fri, 14 Mar 2025 at 10:24, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>>
>>
>> On 2025/03/14 19:22, Peter Maydell wrote:
>>> On Fri, 14 Mar 2025 at 08:13, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> Raw writes to PMCNTENCLR and PMCNTENCLR_EL0 incorrectly used their
>>>> default write function, which clears written bits instead of writes the
>>>> raw value.
>>>>
>>>> PMINTENCLR and PMINTENCLR_EL1 are similar registers, but they instead
>>>> had ARM_CP_NO_RAW. target/arm/cpregs.h suggests this flag usage is
>>>> inappropriate:
>>>>> Flag: Register has no underlying state and does not support raw access
>>>>> for state saving/loading; it will not be used for either migration or
>>>>> KVM state synchronization. Typically this is for "registers" which are
>>>>> actually used as instructions for cache maintenance and so on.
>>>>
>>>> PMINTENCLR and PMINTENCLR_EL1 have underlying states and can support
>>>> raw access for state saving/loading. Flagging a register with
>>>> ARM_CP_NO_RAW has a side effect that hides it from GDB.
>>>
>>> No, the CLR registers don't have their own underlying state:
>>> all the state is handled by the SET registers, and it just
>>> happens that you can read it via the CLR registers.
>>>
>>>> Properly set raw write functions and drop the ARM_CP_NO_RAW flag from
>>>> PMINTENCLR and PMINTENCLR_EL1.
>>>
>>> I think the correct fix is to mark all the CLR registers as NO_RAW.
>>
>> My understanding is that ARM_CP_ALIAS is ignored for KVM to avoid making
>> an assumption what aliases KVM implement at cost of migrating one state
>> multiple times. The CLR registers should also remain as possible
>> sources/targets of raw values.
> 
> Why? There's nothing you can do by doing a raw write to the CLR
> register that you shouldn't have done by doing a raw write to
> the SET register instead.

In theory, KVM may choose to expose only the CLR register and hide the 
SET register. There is no guarantee that both the CLR and SET are exposed.

Regards,
Akihiko Odaki

> 
> thanks
> -- PMM


