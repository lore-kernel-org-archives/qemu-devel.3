Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7BEC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8OqD-0006oT-Ih; Fri, 25 Apr 2025 15:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OqB-0006ns-Rd
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:36:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OqA-0006o9-6C
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:36:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso33023905ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745609761; x=1746214561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J3huAYtXI5iVULHvm5dCVqHWOWaoYavWd5cVJr1n+FU=;
 b=Qwu60R7g8tamDCyPsIDl6yHlzfM14z0estB+zRiUIn/02YpIuIRj3ZvL4dcNBV/vor
 kg5Gfmuj+2FUDJ8AJ+s32v0aE7gZ6jLVv7nU4Yn5xqSY6OaXlYx6Wx03rB8/SNe5SB4j
 EOnhuNRdy+yQEome48qg+m5qDNgkHH5Y5wjy8Z65Bnmoa83U+fWYSVjhGZ8k2jAlVXEA
 uv9pFVpF645xUEGWv7UfhshO3fqBzF0V0F+1iCVS5u7KPC8BsnPXuiuv5FRVriJpOR7V
 kDrBSSuTuqCJaXBzrs9aTYehNws7Otkf99UBqOWkK18CvjJH30RJmW2ohIwyeIdl56wf
 9N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745609761; x=1746214561;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J3huAYtXI5iVULHvm5dCVqHWOWaoYavWd5cVJr1n+FU=;
 b=wyZxOh7y1T2FjL8H+it3FZpi7Zwa65kurfWUrlcB7hqT//Bv4LB7QLV1//FFSGTjtH
 OmW6IF6f4BfLB0r4kcUXiRDvCX/+3e8U4OyZKtP9ylBSAZeGOspeSVAj9ll13Bbs975z
 e2gfzGSnBgx6zJQIwA/Su81EwFX4XtvourgYTgdN+zPoHply9Km2ylTdWNlE+xiXhvsV
 y/bZLLhkXH8D5nTDi5RvpgzNiTA6C/7Ln+8ledqvBYW7htG8ChkoGb6Aa+gR82cnkui2
 iupIwVWmh5Z4ybrBejZ4zxm31ro2A6hUAjfBHObu495oV0yKDQ3bfG5+zq/eVC5FNShx
 cxTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp2DtkmlnVIMRNIDEuPvVo0Fo2S8Qq5vaclqBnvdaF9lYn8UzcedJXA2oEgN4KpLqobYB/5vTmF6KQ@nongnu.org
X-Gm-Message-State: AOJu0YyGpoMQEqqdq4PZFT3F6t8QiqmTSmAbPdMa0EigUYhjM9L+tOVm
 ljVktSiHcWT24MvFZUgaFknWZfwZJl2WekMdvJSOsE6QHULpn/2HZx3fAtBTJNRljQoZbuyYr99
 +b9Lt4w==
X-Gm-Gg: ASbGnctP7JSgMGZFyjYWkwD4vZsGszmMrOcKNuWMtx0AkI2TXElFZ2ZaUdITrppAv+2
 pslzasuA7gn1CJaERonW4EkHD6K2+g6c00SJl+Oy3MDOxjUSqWTgoh7bzItd1encfjzuRCJzvf4
 LOZ7TqBhXzLwm2vlRAg9avlu17TFADJmbg9rgXxIJYP47QG3otR+PS7xtuGhwHjbAzJrfkPZbSY
 Om3qsJoLd79SGOQcI+BdPXxKslnccHbulsJamk0NKiYAYc0fT6FfxSnXr5PpvUlbiwpy0iXh0qh
 QTyQxZKymWWclHl1FGL56Nl3xRqGhrGJdVRBWQh3Cp9gbj8OlRz7uw==
X-Google-Smtp-Source: AGHT+IEDu1TMWjXUB20VObciuwEgT+YV/NRUXmL1YVyAFdZprY+C6pGuzJODlyoIT7dSUt+oy5RBFg==
X-Received: by 2002:a17:903:2289:b0:224:78e:4eb4 with SMTP id
 d9443c01a7336-22dbf62c693mr49043195ad.39.1745609760768; 
 Fri, 25 Apr 2025 12:36:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7ec0c08sm3304508a12.19.2025.04.25.12.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:36:00 -0700 (PDT)
Message-ID: <3b270932-66e4-436b-b3ef-3e5e2f03d78e@linaro.org>
Date: Fri, 25 Apr 2025 12:35:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] accel/tcg: Merge tb_invalidate_phys_range{__locked}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Merge tb_invalidate_phys_page_fast__locked into its
> only caller, tb_invalidate_phys_range_fast.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 36 +++++++++++-------------------------
>   1 file changed, 11 insertions(+), 25 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


