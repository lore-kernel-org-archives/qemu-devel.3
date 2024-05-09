Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07138C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 08:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4yrQ-0000K5-TU; Thu, 09 May 2024 04:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4yrP-0000J6-HH
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:10:39 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4yrN-0008SB-QE
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:10:39 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51aa6a8e49aso652309e87.3
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715242236; x=1715847036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jMPRfd8rdH5pNKs5OTTNM86jfA0cFlcLaJJAhhHNZcg=;
 b=LixAPoyV2N5QQov57LpsaDDeSq7esau734YFiGQuA430NCaTvRN8PCg6c4TmuWMCKq
 8DgVb33aXqQ/7mH2+CcXAvr2qVytYmNJaFslF5QqnK6dHF5GtwjSw17MC6kPmD7Doir4
 Dsy7kjGR3z44MnmU3HnwZDlrkdCqGWx0enCa1/UOGMHhCsnHL2by/J0m6UQaYjeb8fxY
 us7580eCUIcbGVor92vF7dzKcidClQdj5mSONwt5Qfmu8sMyXb+AT4kvh2JqWa3Eu6pq
 SNLgAHTIyniiQ2ElyvofB0MumXdBd09s1tw51+lqhSqJ/G2wf5t6z8S+BmVcKwDC8yXq
 kt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715242236; x=1715847036;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jMPRfd8rdH5pNKs5OTTNM86jfA0cFlcLaJJAhhHNZcg=;
 b=GEVD8psOvvw2e9UErWqOT0aK2btTdDH3CXVf/3ZfIqlW5ne5MI67omW4akGxqQUjkI
 da5EuaIqm7PlaziQST/TdTKVQRuFYr3V2DacbOWWy6HvxfSW0jVQob8wYeYvVh+JRabb
 Sa7zbpkQEcVYRZOml8i1lKuMm35N/rZEg+yMSJVScRZDXtCKMDkGvcmNIu7628EUdapI
 835LD3F3aigem2X6LYlOU+6znoUaFVQGMdmfIWxFq9+zjJU7c3qpKZctN5qxR6SWpKei
 oZn6Cp8GFPSdGqU+cIGTppGUHbp2v7YdKe+YXAXo7hRRxRl6r2Y5WW4KB3qyV2JwYqDo
 AOOw==
X-Gm-Message-State: AOJu0Yw5WvJ8L9dMozOcUJupd4KuUkhUdE4mid5GS4KAhCX60YXgggZ2
 kjHoiwd1/ZJRpxllYaMNohjuwkgoR3XCbsymNcfjk1A3s6tO2GzmfyktU+zTav/c/uffOie7ip1
 QzJg=
X-Google-Smtp-Source: AGHT+IE5eAIQ+92ZMCdHFZu1RJLEuH20p542t3Y5hev+2SmUnDqogyOhMBgef/yKYH2A8/ykpKZr5Q==
X-Received: by 2002:a19:e04f:0:b0:520:b0fe:653f with SMTP id
 2adb3069b0e04-5217cd48fa9mr2616881e87.67.1715242235760; 
 Thu, 09 May 2024 01:10:35 -0700 (PDT)
Received: from [192.168.51.227] ([91.209.212.50])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f39d2babsm184221e87.252.2024.05.09.01.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 01:10:35 -0700 (PDT)
Message-ID: <8f737296-0cb8-433b-8eee-8ca6c7bfa12a@linaro.org>
Date: Thu, 9 May 2024 10:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: Update msys2-64bit runner tags
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com
References: <20240507175356.281618-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240507175356.281618-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
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

On 5/7/24 19:53, Richard Henderson wrote:
> Gitlab has deprecated and removed support for windows-1809
> and shared-windows.  Update to saas-windows-medium-amd64 per
> 
> https://about.gitlab.com/blog/2024/01/22/windows-2022-support-for-gitlab-saas-runners/
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/windows.yml | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index d26dbdd0c0..a83f23a786 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -1,9 +1,7 @@
>   msys2-64bit:
>     extends: .base_job_template
>     tags:
> -  - shared-windows
> -  - windows
> -  - windows-1809
> +  - saas-windows-medium-amd64
>     cache:
>       key: "$CI_JOB_NAME"
>       paths:

Applied directly to master as a build fix.


r~

