Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D48CC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tng5B-0000YW-BX; Thu, 27 Feb 2025 10:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tng50-0000Vt-9A
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:45:43 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tng4w-0004TY-OP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 10:45:41 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2211cd4463cso21724325ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 07:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740671134; x=1741275934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJ8rK0FFD6iEbjuP1Yv2J4L4iSn5M9Hv9g172C7QGlI=;
 b=oKYdevGwFvKlfjoIK5HdETUamijr+uzAS4+2UoWQUxO5Jnrn+JQv5aLEAJyF1DDR0E
 6ozXHng5UBYKSri93g7pg0/ZhNoq7o3QHRbcHrsi0qDJN6/Dj8bgwNLvqIhBx+q4yp1j
 J41xGkrsHDkagnG4w6JXHWCMEPTu9eXLE4r4hZy64HQIeTys54O2axYu5V1oZrgAUbX8
 IjaUkdqv+/IR9xS9kCLbH3J68pCg43uFpSw3PDxy+fqe1/NhqUpEuL6+KPKPrxuqxWJW
 4e9yvqF9SiiZiW5goQXgyy70fkoz6upsl0mBgyzDeFwxRq6SVlQJRdEbxiU3PB/Lokda
 NeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740671134; x=1741275934;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJ8rK0FFD6iEbjuP1Yv2J4L4iSn5M9Hv9g172C7QGlI=;
 b=qYMPRUbXrwfDWa7q0R8PVhusRWrIAvz9+8nKpZsgFuPpskr5Wxkx8ATNc+aQ0XEK8X
 ohzRJKnyQN3ZjP0/lIL/IO/PeH2qSMv3WuNkK2uM3HAgqaA5a4suOrA7UJr89D1m8MtD
 S04TLpIwziaY89PpSJsQCageJXrqzrKm9lBx+Mon8MBh8WcoOQB9OdQEucqiFYAOh8H1
 AddUMmhpcqpllrcjo+d+bIpEkUYE8ik3G4MxurFJMSjIt9prK8sl2ZeDdQm+2WzCmigJ
 TcIroZoHTHyAry33BxJrE4qHUvrx+aJHq3Df3GNYAhN+VR3D8ZQg7zHaPxYCXhGtR5aA
 CZMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZwQ3Xhn/yl5gbSMH31hLIDcFRde7n+iICwIK2lqNIO+z4l7NOZR4Rhoc+H1XGyibFdO46BXydGacd@nongnu.org
X-Gm-Message-State: AOJu0YwbCMRu0MSqb+GTwb+ML9JvEfIDdtpKO1Os/iTGzSpskgqNAUXh
 w0Vc5O/SIRVCcpmY8hB8UxX0uESnhSFfsZpyxnmo7SoZnJgPqeyrSUQgW9Chc8E=
X-Gm-Gg: ASbGncvbHTimuw0CjcOr6oDwkxR00pqhw9wh1tr+1hGsxGkhMLXH9yLnSu+Vzu3QUBI
 z8RaryZqSSYrGIugrOnGNJ0XA88LO2feoiXg+dWYNKlQ5Hd4fhEsHQi+AQXB+yglyxefTpHz7OK
 zBuU0Yjgfpt/AuxhoYRpRAvDkUiaDyx1pD0M87kFa/v5950DX9MeWbVDRKIJe3R3B37Lte8xTpT
 ke65qY7ILupZcWh0lmeXebGsHuHHulmkPmMXNXPsRyE++9l+D0jr9bH2ckrtEolcBSQ7YBaTO9w
 HdnE+leuTiSihOGUH69lusDSSldUyuZBGwCJGFPcdw==
X-Google-Smtp-Source: AGHT+IHFXIBpNBlGID65V8Gr7B4vd0ksr4mJHJ2zXHzdeQkUaKcamY4ln8eA3BPha/IgegU/x6wV1A==
X-Received: by 2002:a05:6a21:6b0f:b0:1f0:e708:56e2 with SMTP id
 adf61e73a8af0-1f0fc24b3fcmr20780042637.22.1740671134486; 
 Thu, 27 Feb 2025 07:45:34 -0800 (PST)
Received: from [192.168.68.110] ([177.170.227.219])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7de1f7a6sm1583674a12.30.2025.02.27.07.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 07:45:33 -0800 (PST)
Message-ID: <a069dbfb-c0bf-417d-9925-e419c071eb4c@ventanamicro.com>
Date: Thu, 27 Feb 2025 12:45:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/25] MAINTAINERS: remove widely sanctioned entities
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-26-alex.bennee@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250226140343.3907080-26-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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

Hi,

A bit offtopic: we just received patches from Syntacore [1]. Syntacore
does not appear in the US sanction list website, but in a Google search
I found out that Syntacore was acquired by Yadro in 2019, i.e. Yadro is
its parent organization. And Yadro has been sanctioned.

Does anybody know the rule in this case? If a parent company is sanctioned
does that cascade to all its subsidiaries? I have no idea whether we can engage
with these patches or not.


Thanks,

Daniel


[1] https://lore.kernel.org/qemu-riscv/20250227144200.69270-1-saveliy.motov@syntacore.com/



On 2/26/25 11:03 AM, Alex Bennée wrote:
> The following organisations appear on the US sanctions list:
> 
>    Yadro: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=41125
>    ISPRAS: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=50890
> 
> As a result maintainers interacting with such entities would face
> legal risk in a number of jurisdictions. To reduce the risk of
> inadvertent non-compliance remove entries from these organisations
> from the MAINTAINERS file.
> 
> Mark the pcf8574 system as orphaned until someone volunteers to step
> up as a maintainer. Add myself as a second reviewer to record/replay
> so I can help with what odd fixes I can.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250221161443.2321327-1-alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1911949526..9cdfe19115 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2529,8 +2529,7 @@ F: hw/i2c/i2c_mux_pca954x.c
>   F: include/hw/i2c/i2c_mux_pca954x.h
>   
>   pcf8574
> -M: Dmitrii Sharikhin <d.sharikhin@yadro.com>
> -S: Maintained
> +S: Orphaned
>   F: hw/gpio/pcf8574.c
>   F: include/gpio/pcf8574.h
>   
> @@ -3627,10 +3626,10 @@ F: net/filter-mirror.c
>   F: tests/qtest/test-filter*
>   
>   Record/replay
> -M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>   R: Paolo Bonzini <pbonzini@redhat.com>
> +R: Alex Bennée <alex.bennee@linaro.org>
>   W: https://wiki.qemu.org/Features/record-replay
> -S: Supported
> +S: Odd Fixes
>   F: replay/*
>   F: block/blkreplay.c
>   F: net/filter-replay.c


