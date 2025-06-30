Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B14C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 16:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHhR-0006Sk-3Y; Mon, 30 Jun 2025 12:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHhO-0006Mr-Lu
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:49:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHhN-0000oW-0S
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:49:42 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-23694cec0feso45289655ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751302179; x=1751906979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tTo9bQDZX/TKUpXWrNBeXrsYKdrS8YGynbPu15MH34w=;
 b=NR5r7vq32of7gF6ZSx/ei5mREVFTPCnxyedPd4EgsfdvGD0Tb9E0tbHPqL0RfmdcZ1
 f3/9qfwasUTKZa+wOpqlvF6BKdD5Wx7ofCScszQP889j3fYEXwVcS9NY0HY2yj0/Pay5
 zeO1wlG4Ry09JkmnNOlVOg0fjY8/unKq6wdlugO5Cqm+7ZZvjzMkWnxOU3mb+pkgpY8t
 4yQzDPfObUb2xsQZ7sO62r0dXwx5IGu+1+d2XnPXQwgD7GXR69IsccYXhXpj+En+aKZH
 aHohw7GRp+VkmuyvVGNeAZKuEAbbCJh5cgL32HGEl+9HoL8M/kaBJk8H5tGjz5D8QC7e
 Nc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751302179; x=1751906979;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tTo9bQDZX/TKUpXWrNBeXrsYKdrS8YGynbPu15MH34w=;
 b=A5VlGxAjOzK7ua3AloA9bfcYDWeL87A/Kj2ZqtRJMVcRfw9/buz5lL1NzU9RSLRuZI
 bJcg8QuiaBVM5ZshciR0pQA90VGQcR7FygbsN9LKYtzuWroJnE04cfF8NMSRSflj9Jd0
 eN+WQxbVQ/vrtLVqBr+RG6ZG8gqjj2dZCzFAXwhPG25fLox6MWV1iG5imbBD+qcph4eO
 57wOH80Muzo/iW9FfS1sCF7I/9vpwo1L9tdvo1c4Sz67cVSaN/zIuErXd9l4snTnuMkY
 OJ8AQv9fYOHIFtDG5NafcyJ6uaE4G0hKfJjw54yf+5yl3oNyOrsopoB6vJkaKRCMauD1
 pTJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9tZDwvxW1OSlH4mAvhk055vXKYCuTtqBd/8EBh3KpxALdCAZFpgRKig2QBDVuqq4uWf/OBR0aFWFt@nongnu.org
X-Gm-Message-State: AOJu0YzBdgEAKPJY74S43b3kteriHvCu81sDdfmdy4GCOzfWj0etLNbY
 5wZd59yNfRYBexb0TvRD6pDMCnjO9uMEREpBXPbXzq9Vr+jw7/GbdQBumlZpPN0dd/w=
X-Gm-Gg: ASbGncvt71dvFQXPf2Zlwv1Lp58DkLnSGhZ+va7BrsDeAmYzkBhTCdkyknECKzFT+eG
 tDEQkISJRj4e7R1qzkA3C91aNVutx6zxQZzz7rB2BX1IXNi9VIN753EFwRz5ej4vlxnaG6kwW3A
 oMyWHlqHjFRwuLzbh4O7EmAx4KWD9XfJlS0HMoX+qEw310os6JaHuz3Q4GmmOTfJBzN4TDU1OKz
 YgGRUnzgwdNU5djH+LVvb+aVd2I7ul/jS3T4lvWqSo10dapbyxdRvLOW4xp/4Pibzgl/HK8msK/
 9wbpGqR0uZjM9U6xwRitWZOo6Vd6TtTvDwDxttBB8ZQP1tidVk+c63Qj36vvk9MQgrrkg26Op4M
 =
X-Google-Smtp-Source: AGHT+IGPfHLB9AxOoQRn5fGAquUwskyga5GmnnfuIof5rLxfJcrVSIOEtWlNjeuenDmD0x7Ikv2tsg==
X-Received: by 2002:a17:90b:1d4d:b0:312:db8:dbd2 with SMTP id
 98e67ed59e1d1-318c92cd016mr17612576a91.19.1751302179343; 
 Mon, 30 Jun 2025 09:49:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f5426bd9sm13675903a91.27.2025.06.30.09.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 09:49:38 -0700 (PDT)
Message-ID: <c4745999-9863-40fc-b507-f6b937430d08@linaro.org>
Date: Mon, 30 Jun 2025 09:49:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/arm: Only allow disabling NEON when using TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250630130937.3487-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/25 6:09 AM, Philippe Mathieu-Daudé wrote:
> Only allow disabling NEON when using TCG.
> 
> This avoids confusing user experience:
> 
>    $ qemu-system-aarch64 -M virt -accel hvf \
>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>    qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or neither
> 
>    $ qemu-system-aarch64 -M virt -accel hvf \
>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>    qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
> 
>    $ qemu-system-aarch64 -M virt -accel hvf \
>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>    qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=off: Property 'host-arm-cpu.vfp-d32' not found
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


