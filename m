Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE40FCF34CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTTU-0008Hh-N5; Thu, 03 Oct 2024 17:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTTS-0008GQ-F3
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:35:02 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTTQ-0006PO-SA
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:35:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37ccdc0d7f6so1021069f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727991299; x=1728596099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=loupnG3W6pa075hHlvSurxBeQykSxRdRYDQzNCbaVIY=;
 b=hDY/RI+TLbIxyyJ1gnAs3pjljOZchxwAQ6d7dwQlLFATF1lSQgqogE9k/VEcU+kw9Z
 cU0LXJuczYSB3KCxwZF4FyCfnAbeXb1PbrYYFMI7lMbQGjQHZ/rsb52Jgnwb9jjoRpcW
 M7VXgtrmnlEPaPouQEIQAiUkBKLXaVSULnzGU+OYlpcSEz13GPZQu7jkVok9yEZ6mA1A
 L9qdV0/bWGdRnXYwYuWxqTz19GhfazkK1qIUUB1I9/iWEdlwmWVXaBjGgDmtDcuTexbk
 6eyWEGFa4TEKIvPi4Xt8EosblTUl+hcaAbUgogxAw5ty1YitlXuVMqEwG1cNrl+bO/Po
 4URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991299; x=1728596099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=loupnG3W6pa075hHlvSurxBeQykSxRdRYDQzNCbaVIY=;
 b=Of+wuzWvKXOCqBQKQqS6JHD7ki/kb0qCSdgB5dEEgSs2q5RnfV+sS1XVr9KBnkoqJi
 PhSSOwhk7P53qjp3DOQyIkQRtawssI3rRwaftKLF1A4TmnysKfrAnQIVukqPpklgyy/t
 ERjDGqTaNBwQfCHHvJXXoQlDQq9crsBYFqYg46XNcXeLJqBs+95verrf2z5qn7xhlD4y
 TiStryBe8QwAygp79B9GEujBHvTd9BC78bmM2SRFkOywHA6Is3HOTCmhKu8C/os+LJaB
 QJmVVlA60aEioCEaB1PfA8eM2JWq/mDXw1tkcJaXmRXo9UKo8O8NwW1vChTSSJyTtrbu
 67Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt6clOqV7XJ+4ZGZI85wJ3Kc9bX6LWdqLoC3NGFVQqXhgOeEZlr4//YMPOeoNBerolVOKgEC4YYQ2d@nongnu.org
X-Gm-Message-State: AOJu0YxMN4CpKy2bnq9ooAdUBdqWxQWnT41CNC/tzbVuEijIYgixhWA6
 pUUN9JMD0PFV8SaZ4whOJr7Wjz8IpRBq7EQdsDYiMxASHYmZaqAJlSkONu5chPXtklch3VcirSA
 Mvxg=
X-Google-Smtp-Source: AGHT+IEYcmtUtNBFEhzKfkXcq39S29AVT1zEwGBdYrYYdXx18Vsz/z4bYJTS82Rm/4qryG2CP7jFaQ==
X-Received: by 2002:a5d:680b:0:b0:374:c911:7756 with SMTP id
 ffacd0b85a97d-37d0e7d43e5mr341478f8f.38.1727991299280; 
 Thu, 03 Oct 2024 14:34:59 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f743esm2017140f8f.21.2024.10.03.14.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:34:58 -0700 (PDT)
Message-ID: <f2b0908d-6e8f-4625-a297-5ad189da790b@linaro.org>
Date: Thu, 3 Oct 2024 23:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] qemu/bswap: Introduce ld/st_endian_p() API
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-2-philmd@linaro.org>
 <4c8e6941-e73d-4504-b289-987ddf49582d@linaro.org>
 <39042725-ed09-4ab4-9cd2-52d4899c2e3b@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <39042725-ed09-4ab4-9cd2-52d4899c2e3b@linaro.org>
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

On 3/10/24 23:28, Richard Henderson wrote:
> On 10/3/24 13:50, Philippe Mathieu-Daudé wrote:
>> On 30/9/24 09:34, Philippe Mathieu-Daudé wrote:
>>> Introduce the ld/st_endian_p() API, which takes an extra
>>
>> Alternatively we could use ld/st_te_p() since we already
>> have ld/st_he_p() for host endianness.
> 
> That's what ld/st_p are -- target-specific, in exec/cpu-all.h.

They are indeed *target-specific*, so we can not use them in
target-agnostic code.

By explicitly passing the endianness, ld/st_endian_p() API is
target-agnostic.

