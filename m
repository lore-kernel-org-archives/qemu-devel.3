Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68188C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 19:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7gAP-0008BJ-Sc; Wed, 23 Apr 2025 15:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7gAH-00089o-G1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:53:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7gAF-0002bZ-P8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:53:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394a823036so2483475e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745438026; x=1746042826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VTuq8enfw1VwLtOzAqkyMa0faqWVbnd1neng2gPJUlU=;
 b=iBjJsAtbyQE4xuNhIjJjzgcGROblW0MaZUCRxm24/lsj55NsFVrfY0BmvC0dJgc4Yb
 wDM26jiB1wE/ccMBBJ7w2eJozf3dE9ozOT8ZwfsWZeFP1LEWoc6DWh99p3jJdy7FcOkA
 7GcnRrs9AgjjBTMAZlh0LxnurMps4ZK3IiG5a2P/VdF+uwD8ispqC3WlKc+a+QOlQu3f
 wPziA7NyNo0w98IaMb2nfISMUQtXvxUB1tIApwKRtSx6qBqWVwmEWPZ/S5uq1FEX1Hhr
 Bjp0lGT8+T8pWdYH22Guhqpxxnc5Bf667ESz8ppsX5ZLisBNJy1milvdaFLXN/cqg7O9
 E2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745438026; x=1746042826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VTuq8enfw1VwLtOzAqkyMa0faqWVbnd1neng2gPJUlU=;
 b=HqoG+YuP+fAseuphD8R2xa3cKVdPzdIOh9C0+lShaKfUGnO5yUcMABtebDe97rEJUz
 b0Rn06VVLobbxJisJMBv7AAA62r34wcT/YHQdPq0fCa6CNMfXNHmdEZVbQwg9XO6Y+kJ
 yWQ0Z66YBZLRoPb1pe6Mdm/cEpm8KLNmHePrMJvOL0pknUwETW8PTZVf9/nrR5PYznxy
 qqBgrsXjbTRbF/iXnJlAKtA26eEaxvD+ElKvY0C4JbLpmzmotsm7AFu+/LMnTDLEk/om
 oCYXG6zSeM+TzEAs1YN/9Kbo6ZJKlAIiAbp1WpBAkwMC65bbPLXle8qMVYo7HcaAbmrf
 oH+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+pgH42s4K7J1TlaFm51sdg+NMHZUTQmFUGMlhy0YeWJa573ZuwzJ7sblUipDEO62Zo/Y2SPFbL7M8@nongnu.org
X-Gm-Message-State: AOJu0YxuLIXl9Sw9zDTV7T/pfw+p5pywNLYNTvnTCHXVEQisia4d9IeN
 wvfgWGaBxsfZfoWupoR8J8nOLzwasitCsQb/hS0FjxJu3hJG+jIJzCim3sYDrhQ=
X-Gm-Gg: ASbGncv5nZQ7pgDVdltekLIg4cvicIBM2GYUq6d9xDl8hxZqQH7PUoqYI6rOMFzYjXw
 r6Z9g278LpZiJ1m/cqqvcFXdP05pfiVz2HkP3QF9ZiJoP3oy5UmVnH6b7JxrryeNUov8Y2v30+e
 9pKGaPAVP9i0dZHZOUozAu/hjTzw2MCnWURXImhkfcK+xRztS6FTvrlYNItwdQZSkLMWlD7SPt5
 wovyso4eKr1YIHfcMbxgv/QtfmqvKWJUiloeTkWOORkYnT4cfc7gLFrQAMeW5YszSLvrzQB14rg
 rBfGq2NMVFjRqn7wniEF6tn8JrI5no5+DM4hsfCUjRydvrRDAFFy1v24mfT+4tcLNq7xodR9FVX
 ozJK5iWUNY7nVjA==
X-Google-Smtp-Source: AGHT+IEGSKOZyN/N5M8xOmjIIk4hxd3HxuAAWRb12hi4GjVOP+gOLcGXFeUl9ExQCj2n9A4ZjfDzeg==
X-Received: by 2002:a05:600c:1990:b0:440:6a37:be09 with SMTP id
 5b1f17b1804b1-4409a0e9aa3mr7013905e9.16.1745438025699; 
 Wed, 23 Apr 2025 12:53:45 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d16ca2sm36951745e9.8.2025.04.23.12.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 12:53:45 -0700 (PDT)
Message-ID: <ee9d6b5e-0a38-4237-aa4e-2aebbe9785d8@linaro.org>
Date: Wed, 23 Apr 2025 21:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
 <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
 <0d3d3209-4513-4366-a105-6b71aa9caa88@linaro.org>
 <1937ddb0-a87d-4a87-ac73-3be72ded0c55@linaro.org>
 <6f2805ef-2fcd-4525-a7fd-cad59c64f38c@linaro.org>
 <213ba7a9-6c86-48cd-b595-38954d938665@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <213ba7a9-6c86-48cd-b595-38954d938665@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 23/4/25 21:33, Pierrick Bouvier wrote:
> On 4/23/25 12:12, Richard Henderson wrote:
>>> @Richard:
>>> Is it a concern regarding code maintenance, or potential impact 
>>> on .data?
>>
>> I was thinking of impact on .data, especially with so many.
>>
> 
> du qemu-system-aarch64 optimized and stripped (in kB):
> 31880    upstream
> 31896    upstream + this series

FYI same tag as a branch with InterfaceInfo constified:
https://gitlab.com/philmd/qemu/-/tree/single-binary-hw-arm-rfc-v4-const

> So we have +16kB which is a size increase of +0.0005%.
> Even if we project something similar on other architectures (let's say 
> x10), the final impact on binary size should be < 0.005%.
> 
> Maybe it's a reasonable impact considering the trade off on coherency 
> and readability through the codebase?
> Else, in case we make this array const, can we expect the linker to 
> deduplicate it? I'm not familiar with how final .data section is assembled.


