Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1907C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 23:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUCwW-0004RD-8B; Tue, 24 Jun 2025 19:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUCwV-0004Qq-20
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 19:20:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUCwT-0005VP-Bg
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 19:20:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7481600130eso7063301b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750807239; x=1751412039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z5lvGgpIc1jtCoNTVAzYRoEKan8R2l0PS0uUqtJs/z8=;
 b=aitlw6gcZFb2BXa9z3DPw6EdSsrNJUCNC2zXDPaxn/otAnsBz4S9w4oEnlsAWEoMqi
 F8syt9c1q+M+00VhFuBiaqp4T/kAIPMRclRyYfpey7Zv5swXc6cOQjSTGjuEJjpTNBiH
 bMoFSjjg4W+prAU41jvc4mhvg40OMDgY2NLa5i21exKKo6piHm24wC8yORelHEbuRUkY
 O5qtEEsoI0rtnX79PuHzXoRYSbpeeHQetGJhU7RYBuV99RJWmovrADGwLB8tqpd8SFF3
 yH4bRjNjk90nchW1+tsRerQBp1DEDNwdiwH0nG/SKj7SR10k8/iYe1dEzniPAqziAxvA
 7zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750807239; x=1751412039;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5lvGgpIc1jtCoNTVAzYRoEKan8R2l0PS0uUqtJs/z8=;
 b=Nif1ysKsp9Z9VHvhQ6YUo4Dzt9px7fTiM4Wmon1k2+lKmFj3j4riK3fwmZI8gwy5LZ
 6dmsSid20BCvlJVAV+2gnNsO49BdXeui0aFsBh1ObpllIxMtb1G+aruhQ5hAkWhSZzwF
 215XoK1WNu12dgXQbYAJ0Oa7Gr3oWmVbZTRnq4fKseOWdJNYyOaahEXkLyCTtnC51aux
 7/SrMYqWOX2E9ivz+hKjQCuYHouaD/QQ8gZtroJrXeIRyAKillmqDCXB3L/85LCpaJ3+
 H6327VYTs3cQhVlKmmDcmOIyhlW/YKVbJUzr0F9WIUEopYTLOK61lCNg8bEjotisMNQ7
 0x0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe/XVAVuvlrq8c1fqc1pE4kORPcvZ9p57LYIsMdOhaaPOcFIe957gs+wpfr2gXE399oVdvKqBivwzn@nongnu.org
X-Gm-Message-State: AOJu0YyH/RJBgjTdN52P6mKqT35O8lcnNuIwYsM8MUXXq5AKiF09WrQd
 5axW3Lh72u888zlwe0HZ64bkiB2rgAJaSPN8WASt5tfrUmzTh+tqWHJa/MyCqG9tzz0=
X-Gm-Gg: ASbGncuDoTeLc4XEOKiIaueei6QpBirU2HKylvyOzHzkNZ2kU4uzprNsQRdzv5enENT
 bPypam0EsJVDLp8iBc8j+T6TEDG8eN7wbeIPlbdXLON1vSIe2+htnlqi7xAioVMSEzo8e5iyQcC
 FAEjiGB/xFt3Z2MbL90SIspi4Y5RFepYPf03GK7uJJGW3Y+HxPeLgEAsfqTzPdB/PP+isST/isL
 ud3Wlu9v7t279zsVZuSDNZwva8jpCQ88KHHPo01YD1uFNfrxKyLShM+CxfuhnDn4HhJSt7MJFWy
 AOBpM56CLSntN+Ez2mpKGTCFmHMvXbyna9UTOEUrTO3YbwzCOA+W4nUZAF0z98OYQYYFxyN7vDQ
 =
X-Google-Smtp-Source: AGHT+IErEDi/pE7WHAB9lZV9+Qn7nfz2XaHbS6o5LDe90SzsQ0YCRbqCCRfFkRnNmYNINxNSzvvBdQ==
X-Received: by 2002:a05:6a21:6b0a:b0:21f:bdd5:d71b with SMTP id
 adf61e73a8af0-2207f1c38afmr1371146637.2.1750807238975; 
 Tue, 24 Jun 2025 16:20:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f11aba2bsm9713690a12.33.2025.06.24.16.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 16:20:38 -0700 (PDT)
Message-ID: <8c92e2f0-e814-4109-8397-f318fc7cdc21@linaro.org>
Date: Tue, 24 Jun 2025 16:20:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] tcg/optimize: Build and use o_bits in fold_andc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
 <20250505202751.3510517-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250505202751.3510517-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/5/25 1:27 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


