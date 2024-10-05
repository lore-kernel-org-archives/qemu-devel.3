Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494E4CFB43C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxDph-0003lo-4K; Sat, 05 Oct 2024 19:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxDpe-0003jV-M7
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:05:02 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxDpc-0001Uh-W1
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:05:02 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e09ff2d890so2818633a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728169498; x=1728774298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vRBhMSkUD8hPCFO0QZvm56jqvl/FhCYXXV35QMsLHpw=;
 b=tKkbqm7mgc+UwBb/e/KDkJwKyI7x27LACE+CUOII7d5RlkxuMeymk2DEZ5QhKbeKML
 nzecoYdgfxCG+kSNDxYja4++M0A6ajJavLk8AIamm4b0BpOspQKUc/+Iqh9olDXUGlb0
 PUFESXiEu9/gX2nfwzy2BzWO+NAZOsX6J7JZib+0eOzzqZM/gRPgeK85PHoAz+tPu3Dy
 eWOrAHMhheBDie9YIXW9UCdrc/X66Kqn1pwCnPSab6ag4Sg2959Ah1oQ7E62solF0XT6
 AvPU+sJGETtTINtuyXGB/PF49NvY3+umP9rVb01Ofl64Mz0yvSRjKT3MSiuYZ4Mhuitt
 HCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728169498; x=1728774298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vRBhMSkUD8hPCFO0QZvm56jqvl/FhCYXXV35QMsLHpw=;
 b=vz8yOAYjJF8wLoo5BaSVW5SvQCbj3ExBtrVKmR0cjykZMYMxOtB5RytBzj/arrgz8Y
 HPUghjXvo+NKthpO696WkPV627apYHMxtdpHrspMalXS5OWyk1RfrSKLd8FxO1iYa0GM
 3fUaWxzUYqtOBvJCEysL39/isfVcV2n6BFEIh45y+MVJq3nkRt0V8xWMZtk+48CFC4VC
 A3WMjyPhH+kshm+PSSOZ0lcWPrHs0oabLOdeoLZ2Jj59N7a9MW+krOyzLatYQ721o1ur
 wERhEH5ut3bMKC1/rdn0RvUnF2sN89UJ8MRwjdwJaQi/YSLu26ADWVD0ZxDM6Brc/95t
 6yDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYVspbtrGaqopywXj34UOxuBbX9UAO7/5le8AV3boo8oBLGKV5jgueGoSRapSStn7G2TZyOydnm/dh@nongnu.org
X-Gm-Message-State: AOJu0YzEyaeJBut9agNXeuCUFYq7d95Omadx6XqnEoJIPs8fYNMAa+Xd
 j6a0LyjqqMbfUdKHM3SQJvfvk911YSeH/1T5f1QXZtwQt+gBCCPFA3o6kvM/KcQ=
X-Google-Smtp-Source: AGHT+IFzweYE9PSHDOLzFygsbTSkGmvJb+7qHDHU7t0f5xACNHE2V/UvISkeXpXSlN2DWKVAHq/h9A==
X-Received: by 2002:a17:90b:3884:b0:2d2:453:12cb with SMTP id
 98e67ed59e1d1-2e1e620e10amr9495874a91.2.1728169497951; 
 Sat, 05 Oct 2024 16:04:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cbb62sm17767295ad.79.2024.10.05.16.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 16:04:57 -0700 (PDT)
Message-ID: <c9cdadc8-ee05-4e8a-9281-3b594157cb47@linaro.org>
Date: Sat, 5 Oct 2024 16:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] linux-user/flatload: Take mmap_lock in
 load_flt_binary()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240822095045.72643-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240822095045.72643-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 8/22/24 02:50, Philippe Mathieu-Daudé wrote:
> Fix for https://gitlab.com/qemu-project/qemu/-/issues/2525
> 
> Supersedes: <20240821153836.67987-1-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (4):
>    accel/tcg: Make page_set_flags() documentation public
>    linux-user/flatload: Take mmap_lock in load_flt_binary()

Queued these two patches.


r~

