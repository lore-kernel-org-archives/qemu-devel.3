Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34793C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIqG-0001wY-Ji; Tue, 06 May 2025 10:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCIq8-0001u9-G1
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:00:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCIq6-0003Zb-7F
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:00:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a064a3e143so2614035f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746540004; x=1747144804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XqTCNii3Dn6d1aMdRAWs9D8a6j5aY67lVIkqlQngXu0=;
 b=TO8iUUPHchSuDxqg/uj8VXcCpW9ZLDgGEzBX55MQTass8KBUKEr9YNuWreu4tKy8JS
 MCWR9I0SvCeXJAIN+of07M1mb1FmGACirty++i/f+FlmAKyGQrv65/hdDOUD10f+Svt6
 JRCP5af9YVqp94ygNxnIdrQGHdDt3R7veccJK5Jd+KSpEaZv6wz0bi8Tc4wA9XBBqnIf
 K4RfiiR9OF+rJiOSanPrPuHVLqGSGgZsH1NSZAhwbgvh2HpuY/knCHCtA5yjAyd7PCkO
 pILaJJ1K17EofJW8kWFW4rygDpoDHEFNjfFky/08WFxTGGGMWriCpbR6P5IoEP1tqZME
 EYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746540004; x=1747144804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XqTCNii3Dn6d1aMdRAWs9D8a6j5aY67lVIkqlQngXu0=;
 b=vG7gGjx8rauvyhcunpkzfBm/LBWvXBVfHBNLa2Dd56IXlYmfXhyTkd/vjLQZTu81bD
 elCvEjPMlJ8Foqx5JnCazD5b7errMdDPNo5wDTl5150gVty/vcAPKdU9YO/jS/nx+hTD
 V46/3avKdGn6EwnL3NGieNEWMxBRxz7TITokto3Xs21oYAsAXAu98TYpdChiaOc43wc2
 9+Hj9WPFByAwUu4P0gvPmegF+pxwioFrUhmCjj4Sr8BvtnvoRI1D8BUpuEl25yNqZThX
 GJ3qWWoN+nxQkPkhBzrv7o0JI3bfVi/IMkKK6S1B8+hK1pcC6SHvBfqkeEerVK/TmIDn
 l19A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Zrtu7FCGeVubSjhRrnRbOXRYE+1av2Z6kTxvTxWP6F1kyOGjPI5oMChs7afh6oKygrEUOtGdmIQF@nongnu.org
X-Gm-Message-State: AOJu0Yy3xr8OBZgoeYzHfugZBNqz0O6+dRqkM0JbIeMW/+rsC6RtqUir
 qj/M/RW4URTG0aZOj5qP8ThOukiGcu3RKFv6zDaBfx+7CamHyubmkcch4DP5biI=
X-Gm-Gg: ASbGncuhnVj07y/BBeTpr8581lNb9o6h8cE4Ld0jTSkjCYPzBWVaIRO8FeoL6oesRpb
 EUTbgT4aETz2UZZMTdpsUTX/0jxOyC5KCv20jkv1tHj82KBqV0i2qQizhged4+4+CRXcKAe0B0n
 mJQKBNhKlRijeJUOJjJOXpYz0YywkTAGuO0MA4kYrSc/j5XUv9rH7xAPdp9+VUE3flwlA8n9v5y
 JdyRAIRzkQEeMg3pUA+N0Rv6vJ5ysr6YVNukfebfrPto/uTO4jTRYTleubrfkUKpR4jIOc09Qey
 /m0Zd64agJ9cAm5OD8ooCQ8fS5hMgZ3Eotx1aXtRUR3sdlubiJFksIciBGO4j6KY6a0VdHKfhoH
 EJjdHJA==
X-Google-Smtp-Source: AGHT+IFQ3mxsCOX2c/COCr3whEBaLlrwdQaqm9iTH/JFzYXTeyjcuiYmVXVlbkqLiNjMX+rsewmAnw==
X-Received: by 2002:a05:6000:2284:b0:39c:c64e:cf58 with SMTP id
 ffacd0b85a97d-3a09fdd9844mr9701862f8f.55.1746540003745; 
 Tue, 06 May 2025 07:00:03 -0700 (PDT)
Received: from [192.168.1.82] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b10083sm13916055f8f.62.2025.05.06.07.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:00:03 -0700 (PDT)
Message-ID: <33b848fb-37fb-4ef5-b511-ebdf4212738f@linaro.org>
Date: Tue, 6 May 2025 16:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/pci-host/designware: Remove unused include
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>
References: <20250501183445.2389-1-shentey@gmail.com>
 <20250501183445.2389-2-shentey@gmail.com>
 <e7088647-aa76-4f64-b443-0ca354df8f24@linaro.org>
 <CAFEAcA-8A_r9TooHUcrt26hvP0w5cH+mbjo5wiP+=8VX0chDVw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-8A_r9TooHUcrt26hvP0w5cH+mbjo5wiP+=8VX0chDVw@mail.gmail.com>
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

On 6/5/25 15:03, Peter Maydell wrote:
> On Thu, 1 May 2025 at 20:02, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 1/5/25 20:34, Bernhard Beschow wrote:
>>> The DEFINE_TYPES() macro doesn't need the qemu/module.h include.
>>>
>>> Fixes: 13a07eb146c8 ("hw/pci-host/designware: Declare CPU QOM types using
>>> DEFINE_TYPES() macro")
>>
>> The 'Fixes:' tag is for bug being fixed.
> 
> No, Fixes: is for indicating the commit being fixed, so this
> commit message is fine. We use Resolves: for gitlab bug URLs (though
> gitlab itself will parse a URL out of a Fixes: tag too).
> 
> We mention this in
> 
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-meaningful-commit-message
> 
> with an example of use.

OK, TIL.

