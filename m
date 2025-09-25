Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C4BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jSR-000745-Li; Thu, 25 Sep 2025 06:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jSP-00073D-Rk
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:44:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jSD-0006lt-C9
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:44:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45f2acb5f42so3964965e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758797037; x=1759401837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3oKgxz8PZ25GaoWLLeZC/ctFTDaqSXtgVX6PlaWFhDc=;
 b=Uv7oQcEmxkghugMfYhihXVxQ2KLOAJnb6HNfeTwqj2Uj4+6Rdl2ms2ryH06IeKHfin
 a/EH+gRGEMo7fLi/Chk+XQCSqqGDhd9fF/H0skrWFOKhrhJW6PDdmCbnF0qziyhoO0Lb
 6JQaKURFowi7ty4BhpW75d8DHhIpwsVdAxZE7U2QiSLTIZ1yKTvDPZGE2G7MBWLoDB/M
 HzFy2bm+dXqZvOfHVf9s36uH1SZFVldz64erLY6eX0oSBAM3Diw8RrMPXUSk7fNmWUfm
 rqHCH0EF961G60kjv9kYW5BTIMTtteGZCyJPxGnG3A5L0N1Qjb9WCPhCfyq4mIDcNaKg
 J83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758797037; x=1759401837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3oKgxz8PZ25GaoWLLeZC/ctFTDaqSXtgVX6PlaWFhDc=;
 b=ZhuHdiUw3d2ai0vAU5OIz178DqKgRxQFBdzEZ2+70g0Nyz9IekKUngxolLurFiE65f
 Z5uZfW4n0RTeN1DHnZu0cbRbEmvet+bTl0aswCwz818n8z7+Uno9AKUEw2CvE3uezsrs
 4dc5REbOzkD3zYqDQKehWjojIwpDhoMzbvMItjj0ui6jOL61SH0QUtfs8ZoAVgE1zVd+
 v9cmERJQEJQe64Jj60eRLO5YycKjWltX0jfMoLNcmKgBXfpX5ofK5cPT/57yP26lLnJa
 ilROpDLdBNy186l7Vv78zaW/jlfaJnWLEYCxX/N8Fo5Ghef0270GSooKUbCaFJ9O3fye
 djjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKtkOCyhTc7aSTrrxQtLlX8AdsbMHID1LnWjIfs5pJk0AVdZlQX8gw+JKxfiSF9eAVKMgGH8puh9Ur@nongnu.org
X-Gm-Message-State: AOJu0YyxW+g73ZHFfxPnPWPjewgBcMlzPdGMSSR4l6F+9iip4xAhDfKn
 NUxeaPNU5huza2EoU3aBTl+VJ45emte/HNz/VxY+aa+f4MNxw0shsa7jgENThn9CRWE=
X-Gm-Gg: ASbGnctX0W5UZurkqLcyQNBJPnHl5ymIRD2giWmw8C05ZCud1qpTsKVk24K/v+lwVHs
 hIoeMfP1XvEAJ5R3ueXPjqeMtQF9x4jcRZNxw/Dovtki6zw78F4+1QfZGVDXvzsy+8jEOvoWBDs
 MAA5AS4t5Sbrdl4cRDyRXFJgFwPX071NLeDNKZiA5xXzbhv4VCfaah5YtXyZU8uLjTGZYUcdMHk
 gmbb4tQ4YXXVSGadnTeD49ZcjrrwxbBWnHI6gyspntrJH9MXa9GDQvjCsxfIWgoIFVQBXk1d4db
 E6c0uffpmGqiCldNku+8BXKQyqFxK/qzroOT19x53v0B/yvecDa/oavRX+7jLgAr9KuHENThdhn
 a78cRdmo10kKVzsr3yMpCJswkLEFpLAjrAUzgQaM5P3A6sOGkCr9Wn477m7nJB4jfmw==
X-Google-Smtp-Source: AGHT+IHVW83WmJ4PInP/DKJBE5dzQ4mKOEpu4PboJiyS0fApdaBqUXR9ttiUjuzMesPaSiZ3sET0iw==
X-Received: by 2002:a05:600c:3044:b0:46e:25f2:705c with SMTP id
 5b1f17b1804b1-46e38a52eccmr3395695e9.13.1758797037496; 
 Thu, 25 Sep 2025 03:43:57 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33be3268sm29014145e9.11.2025.09.25.03.43.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:43:57 -0700 (PDT)
Message-ID: <512bed7d-b332-4f8d-889c-7b03aa7556cc@linaro.org>
Date: Thu, 25 Sep 2025 12:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/36] target/arm: Convert init_cpreg_list to
 g_hash_table_foreach
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
> Adjust count_cpreg and add_cpreg_to_list to be used with
> g_hash_table_foreach instead of g_list_foreach.  In this way we have
> the ARMCPRegInfo pointer directly rather than having to look it up
> from the key.
> 
> Delay the sorting of the cpreg_indexes until after add_cpreg_to_list.
> This allows us to sort the data that we actually care about,
> the kvm id, as computed within add_cpreg_to_list, instead of
> having to repeatedly compute the kvm id within cpreg_key_compare.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 54 ++++++++++++++++++---------------------------
>   1 file changed, 21 insertions(+), 33 deletions(-)

Is this the why for "target/arm/hvf: Sort the cpreg_indexes array"?
If so, maybe move the other patch previous this one?

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


