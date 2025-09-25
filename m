Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C99CCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jub-0006Uv-Sk; Thu, 25 Sep 2025 07:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1juZ-0006UG-D1
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:13:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1juR-0004xw-TS
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:13:19 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so812887f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758798784; x=1759403584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NhZuQwQAFTSR+0Vufm5kEzl2Dpt/3sHKp8GiT/Bgf3k=;
 b=QgO/Bu6LZ02G5aTuD5gasJYGbhKjEHpDxPOQxaptikRSZwOfgIIyMYJNnoL18aPzGJ
 6q57RD55fRvMaoSzdVQv2OH4JtYH3ErS8Vx4M5ihQjiBwQUIgalW1CWjnbUDs41X94NH
 NHRK9Wyj8zkYGIKzisiGWXQPV3PsCxLceszqgXNydbc/SlB+z/ZlU0TFLdDVtnc1VMc/
 RF4BwmSSaQKvNUusCF2wYOPB/w7huWqXDgunqsQx4gNKp3mK1+17sVJtIqNkxNjQpP4L
 QSozK1Jk/6djz70U+74jLZutHvzgndwO2B75tSNmy1vTv8xUdo6lRYc/LBgnxiKJUvOL
 1t4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758798784; x=1759403584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NhZuQwQAFTSR+0Vufm5kEzl2Dpt/3sHKp8GiT/Bgf3k=;
 b=WLRHo21kiWyGQQC3cNEvgzC7N+KPReHzHfU+VYq2yI3kSdf4Zov28h+CrBd86qeFO7
 epM6rRURSznGvpBTEJxyG7ntXfLgU521px33n1yBsCZHxVvfaXGF7w7fYFKha1z8Q1SA
 qe0YXSda8kIZ1bXfyi0aAvtogNFn+fQpxLU8Zd2zC+4A1WqAAB646+KbRpYWbXgO94uH
 wWyIyTZBa+iZlyO3F5iOld9zChkYa89jm9u10M7XwBpzwQubGOxL8XymcvT+DJP7UvlC
 izQs9ksCZgCrF34rPJAp58GvQGfRSf6nadzcvSyrriRaHrK0lENANIHz9wpM6uhZFk0H
 hV7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVZMo6t0f5P4AIEsOYVxyGnEk4T3Ghs3YTD4op50AFyjkNnTMGGTFjlZ0WWOXHIVoRCoV3/YAbgjhh@nongnu.org
X-Gm-Message-State: AOJu0YyaU45lrqlfpeG7BXV+aszXl7XTvBZIL6GKfWRCfxKzDhHURMqB
 NAyhk0oxq3z4lAEmQyaByMh+G32zfqpxcZbIuOFqzYGBx0zkdZKkgPmEQjZrv1sUvTo=
X-Gm-Gg: ASbGncscwS/Uqwg5yca0eXnNyyHUEgs6QEcBxcacaS1hlt/xNayemwa84rOOHB9Xnha
 BMnwjY7A3lzR6agSmE74zvYCp1mMsPlqEtw9jToHx4Q+jT8vgBFX7jgsBTrXCLWh7CVajVQ/WSm
 ql7aVvo4w3qxIesfq2yWwzM9STCOcsHwBoFj4HatP0IdYFOaxDu+OmpEDEZ437rBPh+8FdLI/7H
 iHRNBg8fnJrln/4aJzwgS3cdTMtn80GfkLhNB0pHLcP2qxuDD+wBuQEstGNWsxq7lCKm/tLkKEm
 snvMGViabHm7KmR4GOm0EpDpE3f/mYRzeluu10ZdKyL5VuccGhJuAO0iLDRHE1m8mOroH8utbA/
 xYMqOVAE8ZunNps4k8LEmglnd/HoomrS8b1c5uLPPsbsJHpuZABKPTiR8I5yX/8hf2w==
X-Google-Smtp-Source: AGHT+IFIbd13axiSM2dClMjoc3wmlNbwFk/8orrCid4bLtVdOroIspl0IjsneDQRyHg/D9qQ9HTnBw==
X-Received: by 2002:a05:6000:2285:b0:3ec:a019:3936 with SMTP id
 ffacd0b85a97d-40e4accc5b4mr3096587f8f.55.1758798784545; 
 Thu, 25 Sep 2025 04:13:04 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb74e46bcsm2632565f8f.8.2025.09.25.04.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:13:04 -0700 (PDT)
Message-ID: <75c4b581-26e6-4e55-a589-883fab71ab6b@linaro.org>
Date: Thu, 25 Sep 2025 13:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/36] target/arm: Hoist the allocation of ARMCPRegInfo
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> Pass in a newly allocated structure, rather than having to
> dance around allocation of the name and the structure.
> 
> Since we no longer have two copies of the structure handy
> within add_cpreg_to_hashtable, delay the writeback of concrete
> values over wildcards until we're done querying the wildcards.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 97 ++++++++++++++++++++++-----------------------
>   1 file changed, 48 insertions(+), 49 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


