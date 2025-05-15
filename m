Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129F6C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFb5Q-0001ZE-4E; Thu, 15 May 2025 12:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFb58-0001P3-Gu
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:05:21 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFb56-0000IU-DH
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:05:14 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7415d28381dso1336451b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747325110; x=1747929910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gsAQSuU1QS91yiwIYBSU6XbbaqIonEL+vZeH5chlmhc=;
 b=Eg3jioxBCCBz5VNXwxWs6g/I+JChw7I9cwJf/hZpIpWnFox+772CKY0IX9cYjg4B6n
 BHm6Jc3mMz6YWR9xz638T1X3+BTOz+n7OEdMZQPBwCgEq4xkSikA/BNMwSUSm1qW9SwF
 pjllK1d3ks2vvNaK0G1DaOCE4LwmgXjqiQHvj90SPwL7wlmDZ7Xs47GvXLRVRbc1Izgn
 XN+//ZUK/uyh6AxUZhI+8+9xJgoxaONyWvgPnCIHwFRSnwg9OuqSoQ0rnlh2vt5OF0GQ
 jGDteJE5Rmp8fd3oduOhZRrCmVMABmein/Sol7ob3pybuapfaWq+uE5aVUM1qnze0I3z
 ZrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747325110; x=1747929910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gsAQSuU1QS91yiwIYBSU6XbbaqIonEL+vZeH5chlmhc=;
 b=n67j1k4KWKgxzpiveTWiVFPV1Gbm8Ti8V97FZCT01T23zVVu6vlGE40EwNJSoBUww2
 13hvQGpE2fjnO8QLWN+kV5WNBJcxReRV2VIl6s6prCZfeYhkMfki2zjOdKMfRTycPaWy
 E+ScWCIUmvbOgb8mPR2iebAsPMcww9GNd6oPAeVOAcWQmnkrWEwypgBhfezJWAaqv2xR
 yTFYIIQPNU4wzvo6IHgMNU5uaJ+25JqgIkUVEa3rzHOYK2+nmETaAYpYIsfqshoiLLDT
 28m4h6Vu8nVYtSEK/5sagPnfYNwiWiyyrMbPvBKHU4YGMsV+l2x1cQQLfNzc2qVSvEOq
 wu+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC+2JaZDhJsynbrAde9AxYEcbK5MWZBVSVsrP0lHBcmSZjSE4Oj3CW/Q3HEepZCOi3o6jyNRmLaLSF@nongnu.org
X-Gm-Message-State: AOJu0YzIYq7qkqfREtsfSc2VGATJXLGrC/TXgbWxDw60zXCK7Na4BDL3
 fDR9wcMhGFOwzWIW7l/gAOSyx1Rgv5VZQG3l700MjYHP+0I8B8xENIZru6JPjTw=
X-Gm-Gg: ASbGncu1DAfE+I97R3hA4P6JgQudrl9izrMIh3dxhNcNOA1cLhdTeHf1vDzxjUz1G98
 XcyB/ujfndLYqza6sn61jjFzQ7wKgi4whKKezO5Rm9fJOIjFtK2Dcxd9AVKdZa2DeibKT0lbs90
 dXicPh8tKIkNK449P2bXFXrpUvx0WYVivHx8qumLX7cgXGEyv4shyk31VA7dPFC6RlrTRN19ebD
 fw0ry1ZyJRN2z9y6/okw/uTyVdl3xGlnud4S3vYH1mMgCzsse8Y0FCEdAS5snkeIFTbo17zujoF
 yU/d++Px5FMt1dLMqGivnDSBEupsq0RsX0DH1lqBrApvD+NRq+eqQ1FPcnOsGb40
X-Google-Smtp-Source: AGHT+IEdzCYszcg2w6Qe1yC7q1CY8QQlMVrLqqba8l8jDTBkVwiH8hOUjxWKYioXgGY23xVl/bMPKw==
X-Received: by 2002:a05:6a00:1bca:b0:736:a6e0:e66d with SMTP id
 d2e1a72fcca58-74289298100mr10766244b3a.6.1747325109736; 
 Thu, 15 May 2025 09:05:09 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb081aa2sm85858a12.48.2025.05.15.09.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 09:05:09 -0700 (PDT)
Message-ID: <9fca576b-fc27-47bf-affc-0aef41b6d601@linaro.org>
Date: Thu, 15 May 2025 09:05:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] qapi: make most CPU commands unconditionally
 available
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
 <20250514234108.3746675-10-pierrick.bouvier@linaro.org>
 <176d584d-386e-4c27-ad2d-57838f599016@linaro.org>
 <c206ef83-aa2e-40f5-b1b3-bada9c090f1b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c206ef83-aa2e-40f5-b1b3-bada9c090f1b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/15/25 1:25 AM, Richard Henderson wrote:
> On 5/15/25 09:24, Richard Henderson wrote:
>> On 5/15/25 00:41, Pierrick Bouvier wrote:
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 476dcb46683..c2a6e6d1c1c 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1927,7 +1927,6 @@ F: hw/core/numa.c
>>>    F: hw/cpu/cluster.c
>>>    F: qapi/machine.json
>>>    F: qapi/machine-common.json
>>> -F: qapi/machine-target.json
>>>    F: include/hw/boards.h
>>>    F: include/hw/core/cpu.h
>>>    F: include/hw/cpu/cluster.h
>>
>> This hunk should be in patch 7.
> 
> Bah.  ENOCOFFEE.
> 

I could have split that removal into another commit, but finally decided 
to squash it in patch 9.

In case you or someone else prefers to see it separate, I can extract 
the removal if needed.

> r~


