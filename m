Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6134BE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBAH-0003u9-G3; Fri, 13 Dec 2024 14:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMB99-0001LM-Di
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:19 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMB96-00084A-Pj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3863703258fso1940015f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117375; x=1734722175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uicfoBdfU7Y1ImJEXuskPUk972PWZx8TOVaU2IsfvTg=;
 b=G3Id4zmkmDe7CgZPzx809oaJ+AxleCzKJEK/1OeR+Juxe97ZsEHo+2J3M/xqlfxZpH
 mrjD46NawAJjHqkuIL1HAnAc+k314dmqZa0cLZzT7icl+jLegFds1I4Ln9DXKo/VA0qJ
 ZpXsoBDy5o48MQjAxJD279XJsJNempZGmVZ1kWnuRREcIOi35l3IltPvv1uwfJ1+N6Tb
 IOUvg8NT8PsafvvQLQeuRa0dSI2FgP6U6JW4vwkGcf8rKIoxJY00dHrasETHi9iQqztG
 dumh59+mKRSnBWEv16XLyDrf67w7+Q8e86/sQDdfAgPiGtMBYcCT6YiPUB7Oqmqfedw4
 URdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117375; x=1734722175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uicfoBdfU7Y1ImJEXuskPUk972PWZx8TOVaU2IsfvTg=;
 b=jG1eV/bLmWtOWDFDe89ovo0OYfq4my6BivdqjptHKXzaHvvuuLAdRd1unarJ+O96xS
 NxrEGJu3qOTEa26J0BwrH5MaBKSx4Cin7CWyOnhjubVmxlyGwvY0b7S+LY848HUIpzDC
 8qDUZGprdERGEoYbyTHoAYfERR7wYPRUMBJf94EcKDUnP1/hHAnEh4Z2rL2GYgAGwVQK
 z45whPG6IOpopAi2QpH3iCwQt+UA9xmTUjDewmAlFABV1QdFfe2fhaSaqT4KJTSoVBFn
 jpxTUB/BX/CjhSE/L7o3J/dALHq1tAVGlgu/1I5jj+0psUkCpur5gKH0l+8QmDG17FLM
 txdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQBtrm56kf06AMhdXrdVTe2bsQU0VFKp6+AZwD63gtu5Nk6h2OiWCTHjwViRzhLoIig6Y4uTeYj+DY@nongnu.org
X-Gm-Message-State: AOJu0Yz1Su4VLdkx2nkGc1FJhkkycbLk1zBtIyR/iXpqA0bnB492nwKI
 C9Tpl1cVQRnDWNSrO25dL6Eh5g/puroT9RDFCO3ZDd4DsjzGvIW/smgoct6yNOo=
X-Gm-Gg: ASbGncttoatizLlsetnTLVTw8cg20Z5hNSIpSjWlrWVqnj1QTyNoDmO2H1DUXV1dDBM
 bJ/AijSe9oRfGWHKYmzSwkb/SL+kbUMufYKcZ2Xwe0fltwkKXNsaXsJetXW/on6M7y6AbmEhRpl
 uM2/6mWC0ET41OlwL+fdyi2JrI5kwKxTCeCSNusJRx2qZSHfDemUNj6sd272CS4U72tLPSKOjGV
 X0ELeIOKtiHya2CcRkGzAKyyafiaNlp+mV+Lq3kxLYyW+MdR5IaarviGlZiIiMeTCAR2ltpvCrF
 B1nUi4g0jywejLBCjiJ6
X-Google-Smtp-Source: AGHT+IHbhBs81qVoYYvj2EK5neAJcOWSB33ABkTTIIJ5FZfiZSnBHg2i4TEWPirxrXFmGA2v0JF2jA==
X-Received: by 2002:a5d:648c:0:b0:386:4a2c:3908 with SMTP id
 ffacd0b85a97d-388c366fe30mr2974639f8f.17.1734117375110; 
 Fri, 13 Dec 2024 11:16:15 -0800 (PST)
Received: from [192.168.224.213] (127.47.205.77.rev.sfr.net. [77.205.47.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046e6dsm298462f8f.84.2024.12.13.11.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 11:16:14 -0800 (PST)
Message-ID: <a26b1ed0-2128-40ae-b7bb-38b4c4253f00@linaro.org>
Date: Fri, 13 Dec 2024 20:16:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/nitro-enclave: Fix terminal commands formatting
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Cc: graf@amazon.com, pbonzini@redhat.com
References: <20241109122844.24057-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241109122844.24057-1-dorjoychy111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 9/11/24 13:28, Dorjoy Chowdhury wrote:
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>   docs/system/i386/nitro-enclave.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Queued, thanks!

