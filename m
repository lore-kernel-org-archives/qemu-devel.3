Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB2AE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 22:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNJBh-0002WA-7f; Mon, 16 Dec 2024 17:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNJBf-0002VZ-6k
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 17:03:35 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNJBd-0007Su-Lt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 17:03:34 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71e2dccdb81so2803557a34.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 14:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734386612; x=1734991412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2wWPwskAvhVkmtvynxwj1CKI6m4vnBUdD7iY/DC9zn4=;
 b=ZYVirEYMkPcp8T81n8ED9SCok3gG1oFFk8Y0ugS6xrt++XFn3LmskjU+1Ns2udDwy/
 meAY3c2BYvTK8Ardmx85GYUaH6BRz8pLYTjGGQGmWfIEfcjs63OLNEiQmP9C3trEz8AB
 58e7EP862mmjlt9ZhgCdL/pKJPY6J6rLQ2P0Yzq2NQ4rTeG48zt2cpjeqsFnyrqxh1CZ
 N7ulp/80ySJlRIDCqUCN5D6ZhcDorADlycmOHzltUAaPWmTuRcYEOjFmxduXQTlaNfdw
 qK4UDRvY3H54KHzIUIACLYSw6i63fL8vud5y4X8j7BKzdGX3DEUZocGQWmMG8NBjpZKH
 St3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734386612; x=1734991412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wWPwskAvhVkmtvynxwj1CKI6m4vnBUdD7iY/DC9zn4=;
 b=fWQNzvQ60ZJEq44TRx5ooYRPm65FXuYicwi6M868vJH07kBlpv+ZnUYcyvsyhoQdsS
 5un68mjXCgpRZ8IL1VqtECIRjV/4NXWsjTy94kzGrr9YAci8Y0J/OWNUsJBntiStienC
 mZJsutROg3qtLreblZrQlgmjRwxcV+LYHRBiZfpyZhQFATUfQXcljT3XjGzRpw6SCaek
 DvJY/drDaWMIRuXCRxX3XjxiJfNqBSYCJXzikmLOho/p1FO0aLLlOjVtKEe6OlPctwrb
 dr1KZNHxvfAqIAUApJcK8Kyn9jdMp9uzx9fr9R4oR99YN6tZPYEs/b5h8ZqircVFJYWc
 PTZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMVokjI9Wfoh39F4uubrPip6H9+KItha7lXEDWU0yfSKrEkTXYlssucMGCVsOosSVaWw7qfDJYrmgt@nongnu.org
X-Gm-Message-State: AOJu0YxN+Gsh64j158eOqc7UwsweDZcbYVY6HET7rVrDk87DrAkqMrPQ
 6AWWsGTa+b+DVDoC8RyM6OkN9IGjFy3pZiHI5dRvQvqKxJ9QObPVTcTJ5JU+rz6iTWxzG/Y6ECk
 egqq6DX5W
X-Gm-Gg: ASbGnctvPxXQI3u1lj7lXhflZBE4DNsrObQp6dWr2O/4uRLNFCgVQ45SI/YteqzvI2D
 FY/s/DB81mMKtKjKZRT7w49eq52Tb5aiSCqyz1zXcpFG44TZiHrSC1x8JDJQjMyc077H1J3td8/
 EHEIUIA96sQfbQBMCiUB/aGFTk9VaULJp6ITJJE03zimleREifg8ftxkhCk88IbJqYQHKBVR7va
 5vr7wlrhZsr2vupoUSFZSenTyz+10fjC4u8EivmKhLJvdIqsIRnb7KtkncbrFhCQdixeQ4GUK9c
 HNf7ZmO9eS5qIcotJbIFGFp60iQwzEB7miM=
X-Google-Smtp-Source: AGHT+IEpiIa02RmuKy3hmdenR2DvVnJ05PgC1yxub/k8ilNDx6NRdqZ8Tag6kmPWPplboIBsfGqQCg==
X-Received: by 2002:a05:6830:270e:b0:71d:3faf:b652 with SMTP id
 46e09a7af769-71e3b8d8599mr7698058a34.6.1734386611902; 
 Mon, 16 Dec 2024 14:03:31 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a939d95sm1688686eaf.30.2024.12.16.14.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 14:03:31 -0800 (PST)
Message-ID: <a0d4e114-7ae9-4cc2-b645-ac5b68f1146b@linaro.org>
Date: Mon, 16 Dec 2024 16:03:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Restrict curr_cflags() declaration to
 'internal-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241216214030.59393-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241216214030.59393-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 12/16/24 15:40, Philippe Mathieu-Daudé wrote:
> curr_cflags() is only used within accel/tcg/,
> move its declaration to accel/tcg/internal-common.h.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/internal-common.h | 3 +++
>   include/exec/cpu-common.h   | 3 ---
>   accel/tcg/watchpoint.c      | 1 +
>   3 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

