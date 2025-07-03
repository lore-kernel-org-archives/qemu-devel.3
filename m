Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785CEC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 23:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXTL4-0004Xv-3k; Thu, 03 Jul 2025 19:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXTL1-0004XH-Mq
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 19:27:31 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXTL0-0006B5-4u
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 19:27:31 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40ba3c10b3bso177678b6e.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 16:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751585247; x=1752190047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZXqytMu0wdCH+SYu3GrpXsxyh0GMIXvcrYNbvw4+76I=;
 b=Kx1Jjz2KrCWUyxZelz5VeG9KgXyDsbECe0xLMvXdcruJqENunnMu5sulYp6hFiVLOS
 rhsawtw3nxBK4E65dPukn8JmV97v6WI9xXi5bMSr7NB45hb791rb7+1abu0FvP8Lt5Oj
 x8MA3qtBvu1zGLUqfFEorsK97yjrTydU3fQax5ou+o6msVPKmJp/gx7xzVMelFO5zULM
 UWC5RH2NRnEzfFa1yXzXcrh502NVeBoPlYIya754vP8bt12hHkDTwIGcDihznKd7KAWk
 P6arZ+eJbHTHXmpkcGirpW6/LP7lrgu+Z8y6hxKVxaZK6UbRjPW3ciPSgtUXNnGcPkZd
 fvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751585247; x=1752190047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXqytMu0wdCH+SYu3GrpXsxyh0GMIXvcrYNbvw4+76I=;
 b=JdqToVz5H4H93/96Wg5y2Y7yQXLccmW/tyB/Xv46uKCh4vQ33A61aBqc8H4dNdzEHS
 0rHhFa4XhGl7PhFhaAtZJDk9v6xencko939lFHZDW4e8cchThoivGHedUqB+BP4uW+4b
 W6R+qNGrGF8RDYw3KIKXyjcVTozfR23/EIo4YrbWqMygHDd4AkpUkkmYbdknccxZuuI/
 lR4pQ8Mv4/OSlOQNEFmZIU7aGX6j4+M5FN8+qxdamB4khQyEPAu1D2yj8b309Iuue98a
 JBPP1DGvuiPLQCfT3uQ5QlzmeG0exX4l5Ph8TiJRaJ6qFlPy4sLCAbCn102KL3NMWl8v
 vOBQ==
X-Gm-Message-State: AOJu0YyM0D4uDxLkSO10Mapsrx36+Z7EYECcE08Xz4RnN/x1QToaRDhw
 2GwTVPmPTeVhkL+q23r7amU2KNVmp8x+xZ9nzBcIFB0Gkax5dSUN69A+rimvXmO+v40=
X-Gm-Gg: ASbGncseC5j+BuRhewOJklazE3EZbMXKt6419Ig3p05hkXqqQvVxYs6SvMx4OeYw23W
 tFOGm4mIHy3aMvWSuVuab0I2Wy/FXvbbOnDjRHND8H4epYfMVFlu+IpGntZpF9grxRiPLbCPkIl
 0wsOslpAss/5j/TXG4WZRMP1j2mLADpbmoPNESdJ5O++yGtujMnZnSod+j1OlQNzzVXraXLQTXE
 dWNs+mkGfXw//0ReiK/CCO5ZK3jfvF0yf63z7uko2pm8T/I2Usgq3un4o2kjH++C29zOdw9Fdkw
 8glex4tRqVayb38S8GW2mPLzJx5YRWEDVRdZ+RFnxIUunDduETCcVfDFKXjCw2Ggs7/BSepXFfU
 4sOZVjf9caRTdmGFdjoltE8rPzcufdLBwQAqTzNw+
X-Google-Smtp-Source: AGHT+IEGK7ipaBkvB3r1MbwBWqMPYwFnZFm6sj1+ctUQ9GnB2yF4Y4NYPjyRm/puUSI3+MPA9jMQ3w==
X-Received: by 2002:a05:6808:6f8f:b0:406:7a21:1ae9 with SMTP id
 5614622812f47-40d044815afmr585591b6e.37.1751585247029; 
 Thu, 03 Jul 2025 16:27:27 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02ac74e5sm118767b6e.35.2025.07.03.16.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 16:27:26 -0700 (PDT)
Message-ID: <fd02ab69-c157-4538-b180-42eab6ca8a8d@linaro.org>
Date: Thu, 3 Jul 2025 17:27:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 79/97] target/arm: Implement PMOV for SME2p1/SVE2p1
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-80-richard.henderson@linaro.org>
 <CAFEAcA837SedaYqtKaDOFSuZjZ2H=6YgZuFOVs9pSoLN5GZ8vQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA837SedaYqtKaDOFSuZjZ2H=6YgZuFOVs9pSoLN5GZ8vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 7/3/25 07:24, Peter Maydell wrote:
> On Wed, 2 Jul 2025 at 13:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/helper-sve.h    |   8 +
>>   target/arm/tcg/sve_helper.c    | 317 +++++++++++++++++++++++++++++++++
>>   target/arm/tcg/translate-sve.c |  93 ++++++++++
>>   target/arm/tcg/sve.decode      |  17 ++
>>   4 files changed, 435 insertions(+)
> 
> Given how much code we end up with here for insns which are
> implemented in the pseudocode as a two-line loop, I think
> some more comments on what's going on would be helpful.

This one was hard for me to think about, and even now I'm not sure I've got it right.  I'm 
going to re-implement exactly with the two-line loop, and not think about how it might be 
"optimized".


r~

