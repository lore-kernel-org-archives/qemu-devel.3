Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6D4CF8552
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 14:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swiz3-0004Rs-GA; Fri, 04 Oct 2024 10:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swiz0-0004RY-Dy
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:08:38 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swiyx-0000sr-I8
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:08:37 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71def715ebdso146976b3a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728050913; x=1728655713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8JSCnQ8SYxrbdZPcHm9s/rH7Vy2jKxBgnq1ydegV0C8=;
 b=DS3Ro9XvveeURxHbTjNWekoI/ohr/HIMqAI/2T1IRKVGR1qd19+CrvhqOfjcjyPROu
 xuTqSc3S7gjdMAR62ps98vJZjhKXBuku9NUeygobEdSpLlBQv44vBA6X0R2fZo1jHcuK
 sUZlcOVwpHIZFM6W+Co4eYfk01e8c5Z9cf5AT7Eu+j2H/TqOBmzwD7emgdLlekd64IKX
 C7Tu/80w7wsTNRBFYXAAahwzQ57ezevKNiwyjxiF8jowGkZjHzkksQPxQaUNwwu7CNJW
 0z3C/iUeYYXjmfqGIG0lj9Lh4PAO0V+ohJpTXX74ld4NoGrtE0IkvbagKxT24G+RhOzN
 ylLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728050913; x=1728655713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JSCnQ8SYxrbdZPcHm9s/rH7Vy2jKxBgnq1ydegV0C8=;
 b=hAp785c6w1PqjiQ7/XTf6woyhgNRmxklCCz1KIQe9lKcKnkC+pXUXegwOByuuTVjO5
 UIRE/YdUZG1Ku5/0+z0oGR9NMMccEfDFe3VaiMGxiDJ+JTv55TQourqJSpm9xvuDLJ9W
 hUwYYTnZyh4aooxbQDyqMi1KVbzhNqLjacQv7Tbw4KSjDlzYoVY8qEvyDUwvb5IL/3lo
 wjdqRJWpfCRTUbDMMLxyEs3wyiFbvp6uxtEl3PNp+giflFjZu8sKTmZimA2yXzQKmRuq
 1E7GFAcVSA12VGbjq5mcZpuX7lpJnIGxladMjCIs+6BE0mRRazpW+7Lo/NJeKOKxXFJE
 FE4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Vu8WtsLLIxKlO0vCxmRNKiDbDvUE7aYiEZUvvt93Fb6ekWuBY3DQW6K13WvUzFSW9rR36dW1iRtS@nongnu.org
X-Gm-Message-State: AOJu0YzmLd2PPk1jcjgDaQS+1n3TcDGh66w9tx4KKgLKpBsF2REeNzSH
 iyTnpA25UjeSdvEvfyYfJjin3LVcyETKh0lHsGqPn9KB7CksDYlLPW3RcWOBCZY=
X-Google-Smtp-Source: AGHT+IGKPyeP0lcvJBQRcEqDz3N3Klki2WmGGasdSw611ITdh0+qy8SOpZMd2iN33QE9MWRDOY1Uew==
X-Received: by 2002:a05:6a00:2286:b0:719:8f48:ff01 with SMTP id
 d2e1a72fcca58-71de239d691mr4800426b3a.6.1728050913630; 
 Fri, 04 Oct 2024 07:08:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9df50ecsm3227125b3a.181.2024.10.04.07.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 07:08:32 -0700 (PDT)
Message-ID: <4c281169-c415-4382-9fc7-3fd5943170b0@linaro.org>
Date: Fri, 4 Oct 2024 07:08:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/xtensa/xtfpga: Replace memcpy()+tswap32() by
 stl_endian_p()
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-9-philmd@linaro.org>
 <257b0de0-6744-4ae8-a2c5-f05eec29a3f0@redhat.com>
 <0c28a435-0af6-450f-8558-14dddc6cb6a6@linaro.org>
 <a14cd43c-087b-4a5d-b036-39aa6a80e691@linaro.org>
 <f20cebfe-027a-4664-82f0-3769c7047e38@linaro.org>
 <aeb88605-989b-4c26-9371-15fbe44a9e3a@linaro.org>
 <46ea20fd-c6bc-411a-b8e2-ab7179c00185@linaro.org>
 <a1a67f7c-553c-42d4-b852-2cc26e7181a0@linaro.org>
 <448beb47-c05f-40aa-a1a0-87ef27bfb494@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <448beb47-c05f-40aa-a1a0-87ef27bfb494@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 10/3/24 23:44, Thomas Huth wrote:
> On 03/10/2024 23.40, Philippe Mathieu-Daudé wrote:
>> OK I guess I'm seeing Thomas point now; this series cover was not clear
>> enough. The goal is to remove TARGET_BIG_ENDIAN so we can build half
>> objects and do a little step toward the single binary.
> 
> Ok, that piece of information was missing in the patch description, indeed.
> But the tswap function should already work with common code, see the target_needs_bswap() 
> stuff in include/exec/tswap.h, so maybe this change here even is not needed at all?

The current practice of target_needs_bswap() merely restricts the scope of 
TARGET_BIG_ENDIAN, allowing devices to be built once.  It still requires TARGET_BIG_ENDIAN 
to exist.

For the goal of single-binary, target_needs_bswap() cannot exist, since there may be no 
one correct answer across the system.  We will need the sort of infrastructure that Phil 
is adding: endianness being chosen by the machine model and/or the instantiated devices.

What is left is deciding on the exact API to use.  The ld/st_endian_p interface with a 
boolean seems reasonable.  It interacts well with TARGET_BIG_ENDIAN as an intermediate 
step, as well as with the virtio legacy cpu mode dependent callback.


r~

