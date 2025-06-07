Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB6DC61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 13:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNtdM-0006SU-SJ; Sat, 07 Jun 2025 09:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtdL-0006SC-9R
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:30:51 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtdJ-0003Tz-Hz
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:30:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so1522917f8f.1
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749303048; x=1749907848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PpJHGwZ76daovG116+wec8HftO9e5sgcgRigb2hW4XI=;
 b=u5LzacqGY23MqQWPB/d/K3d83GOTvg7yZn0RVE1F1v1RadG4jDx0HsunDvOoeD9rAW
 cBlpySJhL8mHuJN2tCLERqN3loYwjU0SBvC7uEWYYxqcY5ZxxGCSNkW8OhIUnEFcbWcm
 d7Q9T0RIKMsqgxR45b2F3JWNvToieydC44nbqVe8t3Qy71Q/EpG/tSjvuRxWeVZ6xjWC
 CoVQMEA/jC2I8yULLYZ3PGhBtMaW0Z09xAGgfky0J7MMXyuyBllGrKswsfC6/0iEHNb8
 kBjMXxD7kIYYtj0qnYRyS55qi1lGS6d1Ny7LDUAkdHVDdk+/cx7XkS4HCznXFC16v2iA
 95pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749303048; x=1749907848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PpJHGwZ76daovG116+wec8HftO9e5sgcgRigb2hW4XI=;
 b=egb2IymZG4o+5WaqJ7Qlr1+zjHBycBAkmAeFx79hTu7AZoAeAueyUw5HrNBy+2Zkeo
 +EqWTd0MWi23EH5rK0bkAl+NVFzBjyfXlf9z/KVCfwD4aBrl4CV3IRxE46HWjGPNYSeO
 FBnzVQLrhBnJ1FCj+oLZoYI9HV0dO8deDqtoZt5jKkpYc4cMyWl/SnnqNWd3i326jDMf
 S2qHG0UyiHYLoPMj2dcbVC9SskW4WVxkaYLs1TQ7AHgiYwikyIcVHxcf+s36iwCsiSJK
 8ty2igoT7b+E/PKFW6fFHcZdUY73WikpE3IEV6ANU3H1W1y/ZqeMFrZwLMg3gyAfdBDn
 bHQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL5Ro5IrbJW8csJmT1JtqqsY+keLJ1njuxFFvzchglmOcADDUrN0vG3WEgfRxxphO9FcO7M4r1HDAq@nongnu.org
X-Gm-Message-State: AOJu0YyF2XHD5oPJNRsc68GUCnBUeGWXUg8kRgS28trNGZIborMVgrE+
 W0jrbBNkoGZVglobjLcz/NcmsPyrO3UkIhJLF2yO1mL7NR3ExKdTGKMW/6tAucW3qUs=
X-Gm-Gg: ASbGnct3DOukFNWYkiSe12RZcxwUISVA494Ig4raALyjHLvrePUvXGpuPNIvX2SuvR1
 xAhkVI2WBr0Hgnvq75aI5QzaPHgziUUb1SdlXMsnMKQDw1uQcJCFyHWgChPSY7zwn3ROQ4sr5R/
 lLWyPxnZr6rcoGfsnWeymeE0+3CV1ZIw4b02lbIAK36gkiezcZauLecZxZed6sXBGH/vDnL7OEY
 hNQ1hkojJze0dJcfx6tLeUiKHBuofXmLPdUw36gL0g9EX1LgNl7Q7PthaCv0s+1L8/wg72mkMQm
 Ctqn3L1kbmu0ecbnDtZ4b0XIO7W7aCxIN2qJ9ytKj0IBOdvDi9k9gxCJKYKCkUT4xPbf1PKUNoD
 WY5xYZHs45uxibW+4ZeZFngMR36FRydVkkqNWgEeNxkBkihoyLQ==
X-Google-Smtp-Source: AGHT+IEyrFcLXqoNAPCKfACTGTmOPNQIvV2sS5BkdaWS3GDPRtXRbKTrQHiO39rnp2VquAIvekR55w==
X-Received: by 2002:adf:e311:0:b0:3a5:3b15:ef52 with SMTP id
 ffacd0b85a97d-3a53b15efcbmr1640876f8f.8.1749303047654; 
 Sat, 07 Jun 2025 06:30:47 -0700 (PDT)
Received: from [10.10.12.33] (cust-west-lon-46-193-226-34.cust.wifirst.net.
 [46.193.226.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452f8f011c8sm50085425e9.3.2025.06.07.06.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 06:30:47 -0700 (PDT)
Message-ID: <24115b65-52f8-43bb-9343-ed1be748f0cf@linaro.org>
Date: Sat, 7 Jun 2025 14:30:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/19] accel/hvf: Re-use QOM allocated state
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250606164418.98655-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

On 6/6/25 17:44, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/hvf/hvf-accel-ops.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index 808ecea3816..f4a983d1328 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -319,7 +319,7 @@ static int hvf_accel_init(MachineState *ms, AccelState *as)
>   {
>       int x;
>       hv_return_t ret;
> -    HVFState *s;
> +    HVFState *s = HVF_STATE(as);
>       int pa_range = 36;
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>   
> @@ -333,8 +333,6 @@ static int hvf_accel_init(MachineState *ms, AccelState *as)
>       ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
>       assert_hvf_ok(ret);
>   
> -    s = g_new0(HVFState, 1);
> -
>       s->num_slots = ARRAY_SIZE(s->slots);
>       for (x = 0; x < s->num_slots; ++x) {
>           s->slots[x].size = 0;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

