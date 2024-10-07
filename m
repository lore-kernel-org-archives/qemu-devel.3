Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A423CED240
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxv5y-0007e3-O2; Mon, 07 Oct 2024 17:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxv5r-0007Ze-GU
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:16:40 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxv5o-000104-31
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:16:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20bb610be6aso55465875ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728335794; x=1728940594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ln56M5/7Z1rmHy7R8GToxjq0I6NsCa+9Vyn2pPN8Shg=;
 b=nZrWaphBzvqU28oY82csyEm3EJ30iqeHkXGHL7Z3STm2WJJKAXWNWdBwpkcwKZ/uvq
 Wi0MdGGYi/H6frb+QpfC7iUnZ8YNUC95e/WyzRo3VNFnRpaP0zpRwlCrXz7kKmkDlWFt
 FPfvYHNWb3aT+iC2KL8OBz3JVhSFEFw2KQp92CfG5SfZKChju0Nw1LtaE1JnhxUhNqU9
 lwHec3IfLcP03JCJjdV6xnVJ9ot+CjQ488jfdaaFIWQI0NJyTRlecTLZOejl7RbYdkke
 zWnEcnJYi6E6oQin5eTWFlg/7R6TFTyW8UD72EYKm2rkLBkAqNTN0cTHxU5/aR91YOk1
 RopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728335794; x=1728940594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ln56M5/7Z1rmHy7R8GToxjq0I6NsCa+9Vyn2pPN8Shg=;
 b=lD5JXyxllQuCx28CZGHBhZOsBAByG8sVcQoIRA13vqgWutYNYcop7y7r5CCkjZ5CWw
 VcAI78PoJ60LzvcvqCXuJDsLowH1UbEG/+zHOWIGxdiF0K/3LyIfGf3gMwUnmI1ePTcS
 BSYZb/vKAVLy3Jdee6SthE28gMI5UZrKJQiSQWps8W8vSuWgRfX4C6BwuCjbBA2BKysO
 2vNoqkEacXqCHTQn/F2klOiPi2um3qQTZjSE1PwBmpkX7S3NGhs+67UhzG4/y6qlDsfI
 KLxjqXiGVesc8Kg7oa2rJOALF6jlvJL4LtT5+b2WnmvrpxCI243ta/834HJx7NVVMIY6
 wHMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxMonUNm/c2ujEieDK5hYH0NLvEUTwncSVcfMCjOFELirw+Nj+GGD7FnVVbMXe/gjsE5kF9aa3+YJ3@nongnu.org
X-Gm-Message-State: AOJu0YxCwGSIn291A7ncsjEEdgpm0Pqcaz+crtIkwNN36UZ/VHy4LVVx
 HGGB9p4ah/bpwk5C+GWiR6OqG/yVrwIgL7WHfl5PFdDKFB0BtXVwrk+JdXw4LoA=
X-Google-Smtp-Source: AGHT+IHPuRyqkW3x2ZbtoTRay8gCRNWuUIYkLU4KnH8VRU/arghyojj9cCqZi2hzJs01mmAwKrWTkA==
X-Received: by 2002:a17:902:e802:b0:205:810a:190a with SMTP id
 d9443c01a7336-20bfde65a66mr158141555ad.2.1728335793937; 
 Mon, 07 Oct 2024 14:16:33 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139391dasm43728525ad.124.2024.10.07.14.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:16:33 -0700 (PDT)
Message-ID: <77f6c925-651a-4b90-ba41-f5f1dbf583c6@linaro.org>
Date: Mon, 7 Oct 2024 18:16:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] accel/tcg: Expand tlb_fill for 3 callers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/10/24 12:25, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 33 ++++++++++-----------------------
>   1 file changed, 10 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


