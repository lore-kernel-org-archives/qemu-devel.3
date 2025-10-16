Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C4FCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9K2O-0007TO-Pt; Thu, 16 Oct 2025 05:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9K2N-0007Sr-57
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:12:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9K2B-0007Y0-Lc
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:12:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso3455595e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760605944; x=1761210744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xNfv9xsmmhteqxadkVhT2+fkyYPSah+3ICpJbHA4auM=;
 b=fYWxzTg75xkyqxbMA+A2hRj6d6MJ++WASzMcmYxTRgZ8gJkfnmlczf0HinOpRbDOfa
 k3bnXyPzNQrFlYhXlw1WfLprZ6rlwK0Q3oGXlA62p4Vsc5K8tpt8N0NA4KUlqzvhVub/
 Rf2wCinriQ8CM/hygso8KzvkvfLZrfc8yiqr+ugg6Nv6lyptboF/BrOx9ccbMkyRNi+P
 aUTHncu4Ya7WB4AyIlSI27xSkZBVoPKu2O2wTQWwk5ZwClD3b069bycfFgRK1j8DNPG9
 pOONqR6A2T3pQ5cEHvW9E9brdw9671HKC4qsxZGLQgUk4OHaAT/K8XlkCrjP+CCTvqhS
 0cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760605944; x=1761210744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xNfv9xsmmhteqxadkVhT2+fkyYPSah+3ICpJbHA4auM=;
 b=TazX18Fk9softcn2Gnfycf8Jp6WbFPh8ofDNEzguprgG8JKKvogTjP83/kQSM+sMw0
 5AbX0pR22jWKqy4Ry9WQhOsUWy3baPYA0kNz8/vR6jhjceO9RUIeeHRDHvyEvK2EKxZZ
 CW16JAENoMzBjW4oO95B5lc7+yhiK92klDFw3+74LX0A7LFk3RY20V4ts8wmCJA3/ni1
 8eqdZ0kqx9vjy+J8hzUnQiwzTnLvMtp4cp+y1YhX1+5IlK/w54FPIgKN0+/BFiZuHMz8
 reIJEJRsDnKAgpqxEvsYQ17IgbZawxiEhZpQ0KOQy4XRYtztv3CZo0b/Sb6CJ0WK9mHp
 K4vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbHdmVEfFnbu/GmlMZs3r+F1GY9DxQfGAPBru+bwTXxJSsIbA07nxc9iAtTqAi41pN/xYBW+w9cTj8@nongnu.org
X-Gm-Message-State: AOJu0Yz9Manl7Yq6Y1NctmF0xzg7pu2dJDi/XsKgmXspw+M/5xwZEJxz
 J3YF0oorj0QfT44h16QjwuauqXNuZ76jFAbJxbcjWHW4OMR89zOT95we9cd/jOFrlls=
X-Gm-Gg: ASbGnctUELLxvcJZMZ41wls/SSnJUkKoBL6y3/n3X4ILP+zd3OZUFGGbIc0ktBUOxw4
 gAiAQrmeKv7jWDy9JWThU3Jj4Ho9kUrsaW0FNVPhnNJ3dCLkGgoPBAiTZZi3zgYdyjWOYGOWTZ5
 J3aRpt0hmdCV/li9WsX3/X7TzTOc3NE1obGzU1lj/OhOKTV1TYwKDUuWcC1k4Dgb9F15xIS5Gga
 Mr1mBB9o6+F50lXl2qL595x/Xs5xCBGHpaTgzi2oOXSf9ptZR4xlfz0fmDRcY7zWOCj41nl7X4V
 16fjYkV3XYTHXjsWRZsvmjsjoqCL6YW5LiW8y9yqVWvpdHF/sefDEvMS698S3/HbR+ikL4mp4NF
 NK9fz9QpcBtUXliF/d1A0xQMoE64REDj1f2cm+LEzsciv9k3QUAaFZPJutETIT7yCtD98giCkaW
 jFxUjvqSJeB6FyyZNnGK4MXa1yiPQehuc/MP3eFSsYHOWa4bUFddWG6iYr4g==
X-Google-Smtp-Source: AGHT+IE80TJxnu4thgS5f+era764aCpK9tGSrOOZRfaWpeLL3Lkv72yXnMKHQ6DPJ379DWca9g9xvg==
X-Received: by 2002:a05:6000:258a:b0:425:8bc2:9c4b with SMTP id
 ffacd0b85a97d-42666abb51amr16517178f8f.6.1760605943892; 
 Thu, 16 Oct 2025 02:12:23 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cd833ebsm16015305e9.3.2025.10.16.02.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 02:12:23 -0700 (PDT)
Message-ID: <ea10c781-d15f-4346-a092-78d203f2f0c9@linaro.org>
Date: Thu, 16 Oct 2025 11:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: aspeed: Split the machine definition into individual source files
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: 'Andrew Jeffery' <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, 'Jamin Lin' <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Patrick Williams <patrick@stwcx.xyz>
References: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 19/6/25 11:23, Cédric Le Goater wrote:
> Hi,
> 
> This is a follow up of a private discussion with Patrick.
> 
> Aspeed modeling started nearly 10y ago with the palmetto-bmc machine.
> We now have 5 SoCs and 25 machines which are mostly defined in
> in a single aspeed.c file. Multi SoC machines, fby35 and ast2700fc,
> are defined in fby35.c and aspeed_ast27x0-fc.c respectively.
> 
> Since we started separating the SoCs :
> 
>    hw/arm/aspeed_ast10x0.c
>    hw/arm/aspeed_ast2400.c
>    hw/arm/aspeed_ast2600.c
>    hw/arm/aspeed_ast27x0.c
>    hw/arm/aspeed_ast27x0-ssp.c
>    hw/arm/aspeed_ast27x0-tsp.c
> 
> We could do the same for the machines keeping an 'aspeed_ast<rev>'
> prefix (and maybe avoid the 'bmc' suffix). I think this would ease
> introduction of new machines. We would be able to get rid of
> aspeed_eeprom.[ch] and move machine custom data in the machine source
> file. Which seems cleaner.
> 
> Timing is about right for code reshuffling, still 3w before soft
> freeze, no important changes inflight, but if we start doing this
> conversion, we should do it for all. See the list below for the brave.
> 
> Comments ?

Good idea, but please split ASPEED_SOC in Kconfig accordingly.

Regards,

Phil.

