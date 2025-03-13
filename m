Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAD1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfdN-0002TG-7V; Thu, 13 Mar 2025 06:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsfdI-0002Rp-Am
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:17:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsfdF-0001xE-6d
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:17:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so13427445ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741861059; x=1742465859;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wMhTTQ61mKQNqSQE0KV6JpDfbQPEI3gfLvzpVRnTiD4=;
 b=W8hlwkkhk43aHEOV4XgjfNiklqh4m5pQ78/xFF5T+Z5UWznOVUCoLn+J4nupwG8rWY
 jBJ3D7ORMOWpt0VT2VuELa+3VYtDb+/YRVkmUriATOSRX2/3G4p5hMTEXnEgmixorqsl
 pEyLyVnrK+HlWe9q4/vPmZAa/yoavo5zvcGhYsPA5j0Sw2cKfD0Z3fXNV3WtU1cq5TCy
 sMBvZ3cpFQ8YFfu+Q7MfiH3qvz4w0Xx1n0tu5mLfkCkMdYDOL69/JRJ8YuYTORZSgUpZ
 ZUAfT65J19AkXAHNmw8hkHluSjrYX0A0bGI1RHbSQ2M3Cdjmft+ZoyvE5MOepi9/tslF
 /uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741861059; x=1742465859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wMhTTQ61mKQNqSQE0KV6JpDfbQPEI3gfLvzpVRnTiD4=;
 b=asarEAePrGvqob047EF9jdsDD0UiwkMXhyieRkWxG3Pi+WzR31eUazUVXVwE8mGkfb
 J2DslH76uxufDQbLOyznyNNpDq3vHK6zVlEl9iJeOiNNiWqzLpLYaMTKgfWf1khqkY9W
 Ly/+dWWGzM7+ANV3s5PmATH5XGzkBm2uTbzdVM+jm7Bm5zgrTVa/EMTZtUDFNr6nfWN/
 R3BPkMtErdHUeJGl58IZVtqw6tbGLnh1HFpK5E0DtW0e+bSfFYXwqxUhvSVEWfnFKGGU
 /LuwnV1G3hoAwgWDi5Cxsf/tMRq/YC8O85PuPI/Mf6EH8iXhgPqTTW5GO4xVXvUQ0ejD
 4GtQ==
X-Gm-Message-State: AOJu0Ywfm1cCPw3yz47ypN/IBuuNrevYZBZjL7vaLEesv4KhCUTyJcCE
 5timQVwtrCsx4eGntJd109qGaXWZCywzp5RFvyB5dopIQfX77hHatmqrzf7SPWw=
X-Gm-Gg: ASbGncscFrMZ+W2EEttBxN2YeqvstaoMDMU24zGOeQl1qojjRbALGTEMkySnvEDAi5T
 j0jD9JVYQKWFdK+ps0EHBUyhQb0aah/7mGEpdBlJwoR2Jxj7kZt5RMm2QZX1F4/FUzg3OBOrHUu
 Ut01LIU2H6CfvmknTTX1P+HcdbNFHfgRxK/cX/adPkiE6+vEqWI4bUmxzdqlcb7dfm7GKCs6GfZ
 R52QarKdk+QRq900AvSs7LG1Pydvy7VscXoHE+uTwH68jahccqJMdfR9i4DJJtg9BKrG9bQy4QP
 1FY+f4lNbFaacrvhfkrmhi4QtcVW6BNziGBeQScObuVSU+S2jfW5eLDOaA==
X-Google-Smtp-Source: AGHT+IEVdWJmaR7I9JYKLfufrJTQWtvBGT2l4QW6Y2aTBvgON86XTM7rk1mKmusR4EVyHXGNYLhfVw==
X-Received: by 2002:a05:6a21:7002:b0:1f5:7fcb:397d with SMTP id
 adf61e73a8af0-1f58cb1bea7mr17683997637.16.1741861059127; 
 Thu, 13 Mar 2025 03:17:39 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9c9441sm943721a12.12.2025.03.13.03.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:17:38 -0700 (PDT)
Message-ID: <52cdb990-1361-48bf-8449-8fb678b5f0b8@daynix.com>
Date: Thu, 13 Mar 2025 19:17:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Define raw write for PMU CLR registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
References: <20250313-clr-v1-1-2cc49df40fe9@daynix.com>
 <CAFEAcA9Gvg2S63_pXKG0bJ1A7bndQNd3meUDeQFiJCwehOgMUQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9Gvg2S63_pXKG0bJ1A7bndQNd3meUDeQFiJCwehOgMUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/03/13 19:13, Peter Maydell wrote:
> On Thu, 13 Mar 2025 at 07:16, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> PMCNTENCLR_EL0 and PMINTENCLR_EL1 clears written bits so we need an
>> alternative raw write functions, which will be used to copy KVM kernel
>> coprocessor state into userspace.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Nice catch. Did you find this because it caused a visible
> problem/bug, or was it just code inspection?

I found GDB always says PMCNTENSET_EL0 and PMCNTENCLR_EL0 are zero 
regardless of the actual value. This is because the value gets cleared 
when PMCNTENCLR_EL0 is written back from KVM.

Regards,
Akihiko Odaki

> 
> thanks
> -- PMM


