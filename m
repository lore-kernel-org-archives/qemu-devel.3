Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D79C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbIV-0003Co-9v; Thu, 31 Jul 2025 17:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb7s-0006vx-B1
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:47:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb7q-0002Mj-J0
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:47:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76bc61152d8so1484310b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998460; x=1754603260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7QBEXA5a6d96IwpWSjPCwyfgUMGeM5xQOxDD3K4XEFk=;
 b=Aqah3+1QDOQShyo5NPjqf01DCtpKKWFUe00xuRMzDR1Q/zsz9fqUdKvVSqmTIHYkZj
 VC96PGehxlmkp8yTC081wrAP9+nQUCqQ3aCq6vABjR0ce3Y+rAev1LadDogqC1UZ8Xbf
 sgiWKd0ct+ST1lopn4o71sQdAb4IQxo16UVxukWWG062DcY79H0777Z+JeB5oe/1U7hG
 lQQbXTkgxWOlI8XCBW7frtVTRSYx+UhJEUyao5ZUNufc2JNPS5DBI1EBt5aZPm/doZ/g
 bY8xpmPVNvtASrSuVK+7VRbOQx95MLOvRSJT1tXXuIwVRoYRg/ZJ56kmjNxq2Zs2ICo7
 edhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998460; x=1754603260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7QBEXA5a6d96IwpWSjPCwyfgUMGeM5xQOxDD3K4XEFk=;
 b=iN7VClzvm0MsPv7978fT3tuRT8zjKBi6DQhzVyleiZTJV5a3nSRd9wsOwYzCdDq2GX
 ZS+cp04m/DPXhiam3r0aIM3Xe7dMJShQ9HgcIpCWaQagXp2Wx0lKKuR/TxNdTky85KnQ
 ZOoBIhqcUkJWC1W0S9nMEs9965AsGLviS4c2XrBH/a9Un9pHAKPrmKRxZbelU6n4H1DA
 9vQU24rPbafQHern+mjh3hTtBudnWkBPzP0eb2+ZWaKoDGwOrK2hqBc2zaFkhNpEg6H4
 bL//RtTLfDhn/MC1CxFkuG3H3l1WmysZfA7UIowoVdP3qJYWWGTggXbzzARlsQmDPDl7
 99xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOL4GuKCB95N3PO/yGRVDCsXKbdcyVECmWnqqZ2nGo/FmLR3r9+778TgtxF1Fym7mp6icju3QzAZbu@nongnu.org
X-Gm-Message-State: AOJu0Ywl+s4nM6BnmawYpXTkkB5noRAOMEKDYkbOrqCnxsoVbci2+9R7
 f1rOdms0CTynh3gjsh6yYdIHdPVKK3sTOak29FvheWqMRV+TQvayQ0UW+qqX4GDZHfwH5CZ0b7O
 fXHnx
X-Gm-Gg: ASbGncvtyLkG8Y0eYnRVgkRHwVC+zRZUGf9UMot7kA/w+jvV1lJ7fh0obro5SKvmXAA
 3Q+Xu8C+U2WqVBtXpVqrna4wvi1ShSNr3ON6kPr1I0oh8f2KhbZejcidOe5RcNsuU0gynzx/2jj
 96BMScoQJTrs/8nD23yUItjUHNjneLzVHRRW4y/RnjoRWjDo/FF8FoSdBCt41He2mU9ZcKh6EdW
 Nt4ZuNoLCybmhs4KkIcT5H+BmlaF2DJJheKuEpGqTty9eoaPgQ2aNQEc/xYS5nokBlIeGi+FCEy
 Q7S0u8kCx2voEKEKIBcZoj90qhr0z6mhwQbYSAkIj9KqSP0/mo1UXoJDOH7ZTJ2pp/iJhvdl+jU
 DHI+MzY3hmhOlubE70porpTtlWaPh8icN98A=
X-Google-Smtp-Source: AGHT+IEPmoxSrNL4ddykhuqWpbHnvwIdm+H7mDqhN8oQPZG7MKmUAytMfhBHo5H6zcO4A4aNhhXfrw==
X-Received: by 2002:a05:6a00:368f:b0:76b:8b13:e06a with SMTP id
 d2e1a72fcca58-76b8b23273fmr7836914b3a.14.1753998460561; 
 Thu, 31 Jul 2025 14:47:40 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfecf3fsm2425467b3a.131.2025.07.31.14.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:47:40 -0700 (PDT)
Message-ID: <53dd9790-ee5f-435d-9a85-081173329561@linaro.org>
Date: Thu, 31 Jul 2025 14:47:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 66/82] target/arm: Load gcs record for RET
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-67-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-67-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


