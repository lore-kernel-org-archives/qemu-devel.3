Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798C3C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 20:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9nG-00071U-Pa; Wed, 15 Jan 2025 15:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9nB-00070h-Ak
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:15:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9n9-000742-9v
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:15:09 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so1061475e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736972105; x=1737576905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lRbBZ545PRHJsSwIB9/7Z8S4si8TGqLA8SQWKq6ELEs=;
 b=WZYuz4Fav+A/ISU10J1clIP1xopQwyIRBUpUrdgM1gzW65oaAEuf0597Q3cS8ISkIa
 j5XrcTtyBDWgecHp+GDS9Lx7kNCPY7T7OdZdprMUV9ZbRzNLaLY9xwa8nga9Ff9YF9/g
 SFrRZt6crlg4bfDkd4KVTiIwx0qpUtLxFLsv67/iQUH7z8upV8arcEt/Nxrf0qwC9L53
 GzNDc+pTqFMFi/Q9GQqgbwhQfcQe+M4CcyX4u1LCJiWMXZxonuR5DfIDRGK0AZ4NH5Nb
 7dk3fLwtuY0j/K6Vj74I2m490w6MK6OfeuS7A01k4FI34bq23xMKdPr1fu3NFUOWAGet
 BrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736972105; x=1737576905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lRbBZ545PRHJsSwIB9/7Z8S4si8TGqLA8SQWKq6ELEs=;
 b=tC3w8DLQo3UHb2OulmtCFVKx0G5QBXd3icNL0q+VqoNOSldEBO6lggaYcihh0tHCBx
 GOBeDR99WdSJZFtCzPxp2KhrDd+ESm/a5CH2MPko99VJQWDdXHz9E/jU+LLc/0AGnr5T
 wqSumxLd2KtR+EbhIczwzKZ66DmPnfwd0Y4UEetM4fOrmAgPMYs60GfaopdUJ8PtR7sE
 23kY7dNfn9iat1g4JuaOPtKPL0k/ZTayjepuwUBsFKynj77x26lbaH3N4hLd4HgkM2n3
 vZfZ1AtaIzPxzggy4UGM+zEA3QsLMoQV14tQ604Eud/RxJlAu106OoWkor2fUIAMFuo4
 ebIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDb52/OZzCwaeOFofAOcSbzfbrgtT/vjeJV8av8I6i3aaUsc0JefvXoc9bq5rairjGJMA7PWMsFwUF@nongnu.org
X-Gm-Message-State: AOJu0YyfCum5cbYaLhcBqqDyAjxQK4MTz4+Fffg1i72VAGv7+vxTYrAo
 67OkLhDQsmsrv8XzWX+nA/M26OCJIwuuJ+anf0TFdrvwoR2NpEqspE/LmSQYRJw=
X-Gm-Gg: ASbGncs5lcBW9UFG3Hsbphif1jLpYWH0OEpTaicjHpKsT0Bogx8+t/A+VUT5IURmvhS
 dhQ/e/AAnfAPQsabxzl8XS6oo1UPfhI+bEcZ8jedd9rmXFSK7+KmUnkW8SS/Mq+rNtVFAnR6bUM
 BoU6JGxM3Q3JqQva0WKOd87SeiClqvhJAcOrc3RsQBf3FnCIomABn87ExXHG8Hi0UmBqTBFO2y8
 lA6kVgGWmEFdt3pVX9DagQ0U4fa8QEj8qA1lvlj/Z3BfLEXU40kXt+ZIbNa2BX0dKSB6d6xa57o
 wrWOrtLHkd4b4KrK3/8BiNYR
X-Google-Smtp-Source: AGHT+IF/UPEYkeXcGmaIaSeX4FKwfvdz8S1ZuBrb3slIpMVAOXG8bp3U5yzbM082AbIqLiumdFIhag==
X-Received: by 2002:a7b:cc8e:0:b0:436:faeb:2a18 with SMTP id
 5b1f17b1804b1-436faeb2c2emr119260025e9.6.1736972105414; 
 Wed, 15 Jan 2025 12:15:05 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c16ba82csm29692365e9.1.2025.01.15.12.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 12:15:04 -0800 (PST)
Message-ID: <83a99d78-a48b-4f30-9639-64151890424b@linaro.org>
Date: Wed, 15 Jan 2025 21:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 46/81] tcg/tci: Remove assertions for deposit and
 extract
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-47-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> We already have these assertions during opcode creation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci/tcg-target.c.inc | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


