Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A32CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIgo-00080O-PW; Tue, 21 Oct 2025 16:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIgn-0007zs-EW
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:10:37 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIgl-0001Qj-JC
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:10:37 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso146840f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761077434; x=1761682234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8DeKayB3rUV/2TwSJN5N7AYFxngbIR1RSPDKVmKK66c=;
 b=OTpjnP2Te2eTs5TUIfQsvVPOuG4EjBdUyOjZghg0Xwkz/IarIKgg7ZYNhTsAqysVcW
 hbFChUvI42csW1Q/Em/46HRSyiT2vDNjrkr+C3axxVWFgnbKoWoxpa6vc+uNRJksEigh
 Fz6dBk8N5H7kS8PBSpoBsP4wRWHVlHRyMRsNsIi8JlZaLKzT3ggjBUt7aLYrB4IlGguo
 +t0BCN2hKlH/RrN+a1Ybxah3AKM9yw6Kt1nG77f00o6VVKNIsmaU4e0ANdt+STv2iTMC
 LuIM0qQ+pqy1dN5yLPNpULhk3A42MMnl56lXrgbKF5T9hjlkoYbob37JBmFW6AnpBve5
 dybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761077434; x=1761682234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8DeKayB3rUV/2TwSJN5N7AYFxngbIR1RSPDKVmKK66c=;
 b=LSKPjT78bqjVHGjcL3e91qNAqT+HHJyfcFLSj6vSy7FxMwoLuYW6Tp9H0cf99N8Jlk
 v6tTbTQJc3b9L9fr7HNwZMCB5/GqDwJi52BS8ggV01rU6bYM2nfuiUeYYGWO/PU7aKgP
 7udUwPopACk536cQSe4oCzT0UxpYgMeWjvcHoxPGHatd6E8wOK4Bfu6VApBJDV7wdCN3
 08AeHmtdBK7vFV9pn27VePNJ1MA+xYg/fskcL57v9VTHRKwzlU2TmoRrBZzT0R1PwWxo
 FDc/kDjXjrjai9TePGVvLAMeUloMKNR/mIrkT4imv2CiOpi6gJyP+GWV6iSgmegbjRuo
 ncxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEW/rpDffJhl1GjVJwl3uBJUvVcugDicCjE68OahtV+L0fTjC1DAkFl0EMAs8HiKDV9DL/AHFe5xDP@nongnu.org
X-Gm-Message-State: AOJu0Yzf9qkn0QK0yLl3zDt3FJR10s98rley+AlOtnm16E87mrLsA4Yv
 DT9e6QhGB+wqOIvWaXIFdvVx6sK6jY9kz2bfSdUoUpQEg5exyaWywcGURMNIFbsNe7E=
X-Gm-Gg: ASbGncsV31TKGbRlqYeiQJl47yLZBpFuVlEsC5PxIylWnKCP4s+zszeO4F658GvfzrT
 4Ba6jq90bzL8m+DSJSowbKrySwJzI64/SDg8nMym3IIe8w2FCl15Gv5CNSHkje1RsnExhkUlb+4
 blIy/cMzeUV9hl/9vcINWnUZyodxKWqkALMmJLWPLqEIw44No/cmtU6L1LGooA3wiAhJ6vw8owL
 QaBWbJFt7NXTpvT0b/EB/9wWx32MVNYeZz+PRXTgyAXeaCVvxXTFXLa58TxxZelvK6sONWuwUBf
 xX4gpFFLeqJAacY56U0ZYJMh7GqVXJoNKl+vi88Edakl6SAy1VD1HUzbsk0HHXVpJGb0wySlJ3+
 MEyOpW+eQ8RAExSDa6kCD3J1GDiSPtGHHqnyXUyjjBYBBQqQO4Toq6uvTO3piigHFQMTi7pTzxe
 1TYQVkSiB3bLmNmW0ccGRL1qNAnoz1z3cBxR5Xe56/EMh/rxVLQUWvNg==
X-Google-Smtp-Source: AGHT+IFeRmDbVP6jbEV6EjyG7vXJTBXd4NCtgscg+2i6SktcEvvX9SgJPKDGNX3hH9GocJygxfW8tQ==
X-Received: by 2002:a05:6000:4313:b0:3ec:42f9:953e with SMTP id
 ffacd0b85a97d-428531880c2mr777047f8f.7.1761077433694; 
 Tue, 21 Oct 2025 13:10:33 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9fa8sm22240594f8f.38.2025.10.21.13.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 13:10:32 -0700 (PDT)
Message-ID: <46315adb-ba18-431c-ba5b-1f987d5c8a16@linaro.org>
Date: Tue, 21 Oct 2025 22:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/25] target/avr: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
References: <cover.1760884672.git.neither@nut.email>
 <81eae4d94240303cebbbc8638841249bd7536ede.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <81eae4d94240303cebbbc8638841249bd7536ede.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 19/10/25 17:14, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places the hook for AVR targets. That architecture appears
> to only know interrupts.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/avr/helper.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


