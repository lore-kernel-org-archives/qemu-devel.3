Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8C6C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAww-0000C3-Sr; Thu, 07 Mar 2024 05:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAwt-000082-M3
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:26:03 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAwr-0008Mc-W1
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:26:03 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56682b85220so937801a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709807160; x=1710411960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=geNP/OQJooksbwxXXZ/Vrl1SQVGGO+dBlZluDDAnlGw=;
 b=HKc8XDDnjuAKnJUU+mHLhOD9c7CWm0CoOlrtQJgnI0PHB5SgxM/S8aGS+5rVlFVElw
 zsbFvgm47XdZMfL4sfUxk0l8UVOXfJicmdyUMisTkA8MsdaVpaeF84t+iEQiHHqmnFat
 QfRY6Q2np0L3j0Z5Z2zZFdzd1dRAxWwARV4FnmysKuCg/cT0GCJOJpt7ZL6ZGiILCwUp
 3mBWhoQBwulytecGPofnGqj3bXDq9wnCWoRCPvRbbvTmKO6+dA/LaOHgNZra3xrXwPDI
 OTGQ7ValP7xHwuYgAX19yzzJFAjnZZ42dLX6PlC5FOMjbPQToTFSLnoIK4AN5sb2HOUv
 uMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709807160; x=1710411960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=geNP/OQJooksbwxXXZ/Vrl1SQVGGO+dBlZluDDAnlGw=;
 b=Wd1hMjmhQk1/ADv6vAoCF8e6yCJ9G+Tn01kHxm4aDFmPJehghaOncgJBVkWIY9wNsb
 SzPz0o7e0z6Bqre/ELA360L5P0ygH4mfdEASJVEhHLAma8gTjvFv1Y+KpKPRaun+nrDE
 ja1bgSoovbiQKkQPZDTbSK6NMR2TSPDj0sxzuiSaIcR6P/xvcEF3DmHK5SCAHfCZfm54
 XclFSwLH5luAbL0Fpb4NaP8DZTjWNTUn3ZkQFzTU4PNceLjH8kM6OjB34HIZ43hwt5Wh
 ylAslTaiLVmnEtI9iR+5+TUcIMfi4S0uNj2mDyKn1nvDOAnnLMPXIka/+ItunWuKa9zF
 YT0g==
X-Gm-Message-State: AOJu0Yw8eD9N2OMOmIfZKsuYs05BuIhu+aMaMPosKvOunja14e8V6KTM
 uKdKGikCR1HRpweMHijX3u9VMCVQk2j2g03WwoMW3ZTVpwnDYmprOEVoQQoD978=
X-Google-Smtp-Source: AGHT+IENpvoOqIjPy0+oxb6MMOLOvvvzXSRj6Jubk3PUyQ0UKJcweUsKc6qT1h1NaVGT+vqFySySNQ==
X-Received: by 2002:a50:bb6f:0:b0:565:dfac:a686 with SMTP id
 y102-20020a50bb6f000000b00565dfaca686mr13459670ede.38.1709807160347; 
 Thu, 07 Mar 2024 02:26:00 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 g16-20020a056402321000b00567e27c72c4sm1780776eda.62.2024.03.07.02.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:25:59 -0800 (PST)
Message-ID: <5c51ca1d-93f3-4471-8685-aeb188d932d6@linaro.org>
Date: Thu, 7 Mar 2024 11:25:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] contrib/elf2dmp: Fix error reporting style in
 addrspace.c
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-5-4f324ad4d99d@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307-elf2dmp-v4-5-4f324ad4d99d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/3/24 11:20, Akihiko Odaki wrote:
> include/qapi/error.h says:
>> We recommend
>> * bool-valued functions return true on success / false on failure,
>> ...
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   contrib/elf2dmp/addrspace.h |  4 ++--
>   contrib/elf2dmp/addrspace.c |  8 ++++----
>   contrib/elf2dmp/main.c      | 47 +++++++++++++++++++++------------------------
>   3 files changed, 28 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


