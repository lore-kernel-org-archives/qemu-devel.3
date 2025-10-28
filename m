Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A6DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDf9X-0006mU-F0; Tue, 28 Oct 2025 04:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDf9T-0006mH-65
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:33:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDf9P-0004iM-5b
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:33:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so4788356f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761640431; x=1762245231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pENJ5iu9jgj9JgaxTjpZl4Oe5YJ1Evw2wd929Co6kMY=;
 b=toyiqhEXoLX6BhnxIRduur/Dex5ceqgNZpsHHmJrtlI9hHOY074kcJ/GEDvH3lwzjA
 abBoyibB6QSfWe89T08HumdZkTKpTKq4AcN1nmj9cbt5f72Kx6wpPoKEomtggBGY7YiJ
 40yFOOFmZgY9wFiy48t/8KB0FUK35LKbk34D1lSnaS7o1sbH+sNCQUa/+6f+i2Qyyyhr
 f+FobIJX17iiogESwyVvxHPSo6Ktfiwmkr6xSmgsOcGWr1jF3zQZNa4nI0WUTn0BmuwI
 /TIbfQW79Y/VyoVMPa23LmrdLZc4xOmiF0GDYN96sijK/9xGjHc1FBzfzxvhkshn0LfY
 lFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761640431; x=1762245231;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pENJ5iu9jgj9JgaxTjpZl4Oe5YJ1Evw2wd929Co6kMY=;
 b=PU27xSkeEvC2KS8Vv5dVSj3H9xavNCFxrbypLD8TneIYNx/TAwWYajIKLj1aALfF5o
 FnhxwCqx8svaYiHFFGrZs9a3ws1awQPvcKYYLRakfXXXy8nmQ3M+aPCGVg/nCSOTtynM
 mIYflpsOHVExq4SYm5VEp97a0gPF0abmFNkZNa5cyzDowRh/FwITGmdPNuQVkgD6s1/4
 LfbuCODxKiLZ+NiIEJAtKbMWouMKIx/VP5mS+wo71arBggWzlwWd6yyTKiom3x6DHkln
 AXC0PDm69kfmPkAdvp2HJoJIltoKrUwkj2Yr0XP4BNENnSepzSys8etpCnTo4Xm99hae
 IrlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjmi02CmAnOA/EAPWc/bsBXXLHhKI2WzwNnUkVsT3/+lo61k/ZfC54PeL2lISeCEuYVkPTL6MQeJf+@nongnu.org
X-Gm-Message-State: AOJu0YyKLatBajeJb/VfTMV65YmVQKvn7qv9HxUKbHkzWB94Pori4SFp
 cKcFKxaHaFcmPx4dCoE/rpH71zsEfKjECYKpVyx7cd3AVWT6uaT95wYnOGNjRys17GU=
X-Gm-Gg: ASbGncuhJRRk1H0XPVqzlnSHDtEcxtfHlB0mneKQDjgQM3Qv1ttwz013UIIl4w1Y0PJ
 4usQN/BSrgt561H+mp/KGiVYDDOv9Z5Z9tsYx8Hp4rmeL7ltgVCcJkfPi6sWzYDC6KvysrgAf5y
 ZvFsiwyAtgWlh3cYtcHvQ1CnkgA5fqqsOInuLC4yWWecfAu2JoKe2vX+m51trYxmJe6EM+taMFU
 fciy1mslD2/AFtc0lXnuDEQqteLTT+GL3rOCcbMzdTkJOdvAyT4rSII64GCjzg/hX9/m1LVA9o1
 V2NOrSrbnU+U0jjnKsrxZfQ8twRA3ZdXpwhu1lRYpepE4KsLaHzBMyIBr5SvM2az9hdCJVMCzB5
 lWTYxJiCDcS+5W/zDtzAdQmyYXzR2i4R9nFV6+fvuS+ST1A9Fj3UnAloPG6O+cfuoszROeUBGP2
 zWcDckU4QrxtWF7qyEx6N70PBYtgARgsKB7LaPa1Nj/9KJo+/VAo4mGmURrQo=
X-Google-Smtp-Source: AGHT+IH75QcNUZiiMCd1jOvtzdcVMfiakcYt2YXNh+FYppaKKv9iJaUNAmqFUCuxZirhoURT4ZL3Pg==
X-Received: by 2002:a5d:5d0d:0:b0:3ff:17ac:a34b with SMTP id
 ffacd0b85a97d-429a7e91bd3mr2330920f8f.42.1761640431337; 
 Tue, 28 Oct 2025 01:33:51 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db839sm19691922f8f.34.2025.10.28.01.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:33:50 -0700 (PDT)
Message-ID: <7ab9ffda-0229-4357-a4d2-aec451c1e301@linaro.org>
Date: Tue, 28 Oct 2025 09:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/ppc: Fix memory leak in get_cpu_state_data()
Content-Language: en-US
To: Shivang Upadhyay <shivangu@linux.ibm.com>, peter.maydell@linaro.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 sourabhjain@linux.ibm.com
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
 <20251028080551.92722-3-shivangu@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251028080551.92722-3-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 28/10/25 09:05, Shivang Upadhyay wrote:
> Fixes coverity (CID 1642024)
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA_Bm52bkPi9MH_uugXRR5fj48RtpbOnPNFQtbX=7Mz_yw@mail.gmail.com/
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   hw/ppc/spapr_fadump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


