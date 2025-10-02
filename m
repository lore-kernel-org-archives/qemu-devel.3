Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00227CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4OlZ-0006Cl-KQ; Thu, 02 Oct 2025 15:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4OlW-0006CH-M1
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:14:58 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4OlI-000301-LS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:14:58 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso1400635b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759432477; x=1760037277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0/qdJ/HOg5ojo/pzozIFLSp8N/iQ7FUrg4DHwEIsrPs=;
 b=MGsa+P9LN0NLyJS5fo1pmFvtjDpnRIa2RWIRcRT8sXtP+P6y3Zru/0xuHMBOLt5Gq8
 S9XBYT75WN9KjQbxfNHkv+UEudsWWGooOpC+TbmUhzJLePc4nOfvH3FiUYFzkqLoyc6N
 Ddtk/ZIrwJ+zwQKM306WUOZRInNEKNpQfTmJ65stRCxtXZCg6i3sx8NPIyb+BbnfkSZg
 fEOadLguOPMQELCPA1kHv768tl+9mRDVaokCBwnLt8w++D5wxxNElWjU0Ks5YK6zYAwK
 DYkN7DYCuC4XFSAxa+d/QxdbWOYEiiOUykQlc7FlroJMXcxR9gfi0PMlBmkWQG3eQS/O
 GYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759432477; x=1760037277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0/qdJ/HOg5ojo/pzozIFLSp8N/iQ7FUrg4DHwEIsrPs=;
 b=j/3P28SV2tzKVbElzeF8kbLUBu2gYfvHiqrWEEwfmi4gNCa9Aa2EIc5H3w5ufe3T/x
 ThOeEjF4TSbhQ/LgziXZnr9HOMPezdn6kOOUjZqszZUs+7//CCxjLZQvGSD43r9nSw+q
 JVXMUmpsxz4DqkzJe46u4HaaSsxJwE6HEUCrCXyTvsfV3p45erXu3G7rXXAjQ0s30YFi
 6gjS9yEaFyndZfm4SZNvSuJuE9zH5C79U27zRXsjdvBeqzeo/hW4aUQHkE2Es5f2jNKw
 RqckhDQzJyyLuY6va/GFOEA3STO28tKh/acnR7/407K/CFsOCypqJMxq/lu07v5B7WQZ
 ZiGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSJwhJ41n8u/vlc8mFXTBVEbqnPBzLQvF1RcC+fOkDeLdZAiTgW7jwT6tdo5isAgRi7wLGOUOmjbf1@nongnu.org
X-Gm-Message-State: AOJu0YwwPKrauPXgmD7s/VhbrP9dlYxFyKJ4KPpCZZ9NP/9G2jYrwvnm
 QD0VAe3ZskHiqEp1JM8CcmygeJLTaUf2lVx/7YiulOqyHxCclx+F2r1NrIlvQV53f8E=
X-Gm-Gg: ASbGnctS32siNdbx3duraNUehKzF0VFcv1QYKr8kFT7VFf8Hr9zXGPdZUDu5K9atnj3
 /oWULx8JIpKdi49wAhbnuhIHjTmO648lsK4F3aAeq52vNiYaT2i1kj+PlVWgq3MNzfX3M81Thys
 pvh9rIWIJ4wxwTSyfgQNzAx+gZYMJ+7p2qnJdhluIi29fc9npRGMfnVxr9qVbsFGf0iVIFQ0yBS
 Z65ptumf1xVKiMSJqg5rFGUXJVBZLdM925KqRgfLLtcHXqKvZqirdKA+YMuSWwxrILv/J/ghipn
 2NUJlM1aDbR1tQcTJn/p0ARoKMyvsN0TCXajmgeZeqZZ9NPfRq3TtV+Eb97P510RwS3F4mlb82Y
 j9KebX3xjOkTbqVe9wSitOXQBti3mh/Jdt8eG/+qhV2zHdWmpOtUwMDbL2snGvqg=
X-Google-Smtp-Source: AGHT+IHVDN7JDg70p+fr5KaffFan8r8R1fbGNl+tuVHECWtbJRBJ49pFabV6osi/DaopwqFSVJP5Rw==
X-Received: by 2002:a17:903:3c24:b0:26c:e270:6dad with SMTP id
 d9443c01a7336-28e9a664540mr4044135ad.60.1759432477441; 
 Thu, 02 Oct 2025 12:14:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5e36sm28200325ad.114.2025.10.02.12.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 12:14:37 -0700 (PDT)
Message-ID: <36c41e82-78db-400f-9bba-ed8daca17e94@linaro.org>
Date: Thu, 2 Oct 2025 12:14:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/33] target/riscv: Combine minstretcfg and
 minstretcfgh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-8-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-8-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> According to version 20250508 of the privileged specification,
> minstretcfg is a 64-bit register and minstretcfgh refers to the top
> 32 bits of this register when XLEN == 32.  No real advantage is
> gained by keeping them separate, and combining them allows for slight
> simplification.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h |  3 +--
>   target/riscv/csr.c | 18 ++++++++++--------
>   2 files changed, 11 insertions(+), 10 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


