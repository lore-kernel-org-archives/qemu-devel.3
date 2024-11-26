Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22E1D3B9B5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxz0-0001Ie-6U; Tue, 26 Nov 2024 11:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFxyx-0001Ge-Fv
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:00:07 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFxyu-0006Md-71
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:00:07 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5ee1e04776cso2849277eaf.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732636800; x=1733241600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+jnbnUj+karSCmkoADV27u+VSThBfnxq6NIlT2P/GBU=;
 b=tdQ96ywKpyuNq68TV9lGy25vhwrO7c9yWJioN118QdID3yUJudNHasedV5oKQD1Tcs
 K2VmyNKnxGJBtbIY2O09GoVPxn/qdjyU5dW5Ag/g1qGUP+Zi8aV5GRGjnpkswKI49bVm
 Z9Z3sIaDp/iVtP7m2gFhcR8UQ+s4p1P6pTIKwOyUFFGDd/H5WnT07JU1EGxEWb53eU+d
 AspHBmvOfhAunFwO5K34o+CO8MfQuBVw+meZfb/FdtDt2+lJrtPvrgY1t3aUE4NPh4lp
 RK+iwP+wpnpXlT7S1MTTbb4HnqI9OWOf4SW1AM6Jw+zgz/1I6Fd6W0JE0RfGN5PdypcN
 Go2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732636800; x=1733241600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+jnbnUj+karSCmkoADV27u+VSThBfnxq6NIlT2P/GBU=;
 b=Py83GSJU2sQUW3Y3LPEeaGmQqxxzJrhcYP1/LRKyYilUas1AWEggPi57zlpLK4JUUQ
 t0rpcYZ7VcesYSqWeQiFzipgyFRix5+ApaSZ6zoOvnak4q5eDJBVDjMTXvGBFw80UgLd
 tFEd1NbF+e3V+j1w3F6bJH3Ewet3I2B/RAEk5xL1WeLSVPd2KQCEL99QiSESTpfsU2tH
 xTuahYxzJdOUwVKhgls63djMS9ExMplnijb6/R2dcKhtMpOhAOx2+6zS2dxHpKATkpOw
 TtB+1+ru220Ti5pAyyGbeAZnY0tYCdXy2nc9t4DFt2TFmG2Gq1oRa98BUaHudBzVeAbc
 wutw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhEq+qszfTY+gBi9UQZ3GHi/iIHg0dWJjjYC6kqb7W1DIuOCPVHabk5HxrAvKpdbW5EWZ09oo6VlBU@nongnu.org
X-Gm-Message-State: AOJu0Yx+ofPZdHp/R53+8fCpHpphDE7ODzhkCreGStH+rn4iLBOTtzq+
 gzkqoeoofOI6bk7PRqjZfHf3kL+oCqncQJpWii4YfJOSWP9rsmumYZ8jz3NetJE=
X-Gm-Gg: ASbGncsH2lLbUznuD6VrjsYIwWdZYN9YNinHe7NRPGv8KfOuvWkOwgRb2RE7qbz2xlN
 1dKBNmUXV/AgA0f7MqyHbZjxk5wHZLC7FCICEjnHbLzwK6ldDXxkfp4hO+Jn5iFYB1vCNiKrKYB
 P1wSOvdFkx1DnILCBj2JvWw+Ep0fk4Htq29D/GV9xKYssPqmj/vu/8RSmZx82YknikeK4IVdh/6
 eJW/Sci03GJQHUngqLgwYMF+9ZDSUntqJIp/Odeqahy9DorrlCnUbLOGPmN5A2jxw==
X-Google-Smtp-Source: AGHT+IFT/vm2c3ICfMo0eIjPr7XwsubxGxz+SqbDh/chzkdJWyWzsPCYhRvsxZmkZF5hrt+RnzYgFA==
X-Received: by 2002:a05:6820:1b8d:b0:5e5:941c:ca5a with SMTP id
 006d021491bc7-5f06a90bfadmr12668927eaf.1.1732636799743; 
 Tue, 26 Nov 2024 07:59:59 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d493906fdsm1536241a34.56.2024.11.26.07.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 07:59:59 -0800 (PST)
Message-ID: <1ff51945-b0a1-42a2-8039-3c7d826d8bb7@linaro.org>
Date: Tue, 26 Nov 2024 09:59:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/mips: Declare MXU registers as 32-bit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-12-philmd@linaro.org>
 <44952443-3928-4430-8fd1-23c2bb4c00b4@linaro.org>
 <25361bd1-c5cd-4949-8b86-1d7e4e833a83@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <25361bd1-c5cd-4949-8b86-1d7e4e833a83@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 11/26/24 08:34, Philippe Mathieu-Daudé wrote:
> On 26/11/24 15:18, Richard Henderson wrote:
>> On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
>>> MXU extension is only built for 32-bit targets,
>>> so the MXU registers can be directly declared as
>>> 32-bit.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> While the mxu extension is only enabled for 32-bit targets, the fields are 
>> unconditionally present in TCState and the vmstate.  Thus this affects migration.
>>
>> Since there's a migration breaker, I think you might as well extract the mxu state to a 
>> subsection, enabled only when mxu support is enabled.
> 
> We don't have MIPS versioned machine, so I can just bump
> the version number.

Yep, that works too.  Leave "improvements to vmstate" as a separate project.


r~

