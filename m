Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F18C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliHB-0006IV-1R; Tue, 12 Aug 2025 02:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliGv-0006Ae-0j
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:14:09 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliGp-0004Kk-36
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:14:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so25578595e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979239; x=1755584039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVEcIVK3zD18vLzY4ziQ9G08VaHwIvJckDiKC0LiO6E=;
 b=iNfKEuzChMQB2CrIZ22NYUYmSAk0Vr79z4yLs3p8YtzwbMkCnb0EDIA5KJLLmfwV2R
 iS5CIidIsJpowcZQ5EQ+tncXxlf1ka21e5Mt4meWVrd7xX6/ySFWjAlnWcI4RpGJGFzk
 VyUXyY7H6CoybYGbakAUBNERLWbJFa4VH46aog1mPy8IE59kBEOYoXyZhPYT6djJWPTC
 IJnIlGRTow/wlGiy7zBEWepDJtdlz42Vn9BQeAuVuVCREjrI0KmvR2fl3PDpogN2lmXP
 SIPIw1MwFwQ6CqR6czBDIjdBokQnPMdY96Y7vC7ZT18ZX5GRdqClbj1me9fDxfTzyvle
 08tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979239; x=1755584039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVEcIVK3zD18vLzY4ziQ9G08VaHwIvJckDiKC0LiO6E=;
 b=aUZrJoECrAxwtpPfiGP0p+iBO1VSbhlxDk+JZ8cyjaOdQ5saNvtXz7BAw8g5TNh3VY
 4UXRDAMFozO/fELWtdIjXfUTHS4emZ9eJVPNJfOV+DBCg7rg3oUh8GQC4FPQUd+kVAEW
 gZXMmEWPb8jH3b/Zy4bdQW5rMGrRT/LPnrsW9pibSuGk0zUYOBeId/x7Vx0xaPMGq/Pd
 2qekJO0qdGItNTjqziXrEjHW2DPmyo0Zcc0ttFb6qZKr+oiByzFFoeYHgAG1m8e6nACY
 BHNs/8NpEVUf1NtxbxoB92htCJmodfbMNzfhX9ml3VQJ9VsX7LY+P+ulSFywkPshOrEY
 yzlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkwZeiTQpiUgEOJmbtVnOMUPIqQG1he8CECLBL5ugbpU9wLc8uCe8C84rA3tlsl8FQ0BmqkmCBEXTi@nongnu.org
X-Gm-Message-State: AOJu0Yw49f2twV72cDuTUSHktrxVDoUl6j3POmwJO9GGNf+kxrykx8Fa
 Uw8Mdqr8Spl4cqNXZEcYSD1C4gdICMLXsi9Ud1qzf0JGRemQa+V7IR95t7ZYItXc6uB1RZXX1nm
 D/6Es
X-Gm-Gg: ASbGncshy3N33OgIJgINOdgAIxfrDNYjFLSznHxz2WJFaLhUmkxXdapMcF5i9F3xEcD
 awVHyu912p5EVywTNdavj81f55SLOxQonn2HEUT5OYbg56/6FwBescaalpswHWYBhD22bLco3Zk
 hPmC2JoBGLzR0HsxIWJDe9Hrh31vroHrjykjzGzavVEebIyVEEKkWwcjWOJNkE5rQxVMCZk9KAe
 dQSWl08nG4oPYGc/88/koqyQzN+IkIqkrpKc/lzh67OZAyrYjKbxXDziXOlBaouuTXAsWpJuZUr
 Uq1nC8sI/Y3I4W4vH8fHKOhm8ROfurcrv3GfTpPgqftclLbOnl63QuY4d1AO47W8eFlCIdiBs8t
 K+avtsDifX+olRxR/yEhJOLjigvqkbQ07KL6hX/eE+EoeVfigq8+2XM0b7Q9/AK9rXw==
X-Google-Smtp-Source: AGHT+IFzNcv4f5spm53pIwMQNstVjmeQCj2Mpa2pQZ+V1t66UWQ+hw+7eD4mHWJBc4aCerzH48APPQ==
X-Received: by 2002:a05:600c:45d3:b0:456:496:2100 with SMTP id
 5b1f17b1804b1-45a10c133afmr21896435e9.31.1754979238778; 
 Mon, 11 Aug 2025 23:13:58 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e0e70218sm309944355e9.20.2025.08.11.23.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:13:58 -0700 (PDT)
Message-ID: <4755094b-eaeb-4729-97ad-8c761786731f@linaro.org>
Date: Tue, 12 Aug 2025 08:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/85] target/arm: Convert regime_is_user from switch
 to table
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-41-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 3/8/25 01:29, Richard Henderson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h       | 17 -----------------
>   target/arm/mmuidx-internal.h | 12 ++++++++++++
>   target/arm/mmuidx.c          |  6 ++++--
>   3 files changed, 16 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


