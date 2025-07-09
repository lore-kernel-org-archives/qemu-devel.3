Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F843C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 13:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZVGd-0008Qb-PB; Wed, 09 Jul 2025 09:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZVGW-0008Py-SM
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 09:55:17 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZVGV-0006M5-AU
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 09:55:16 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2efc0ed41efso2482469fac.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752069313; x=1752674113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MuLxj3AyiU47b082Ox87lYnYj2X4f4EJr0NSC/OFaxE=;
 b=jopsdrA1tSdm7qMgVrIqQI821QCLVbIGbCILy3X6PR/A5AX3gGfnqMk50xEp5xw9/0
 k+ay3hZvHqqBEh+eQHOK3ckHesKMgw1GFVt4LkpY970gGErz7meh3UgFbOIEI0HNaBP5
 q7cEdH8G/hvbkmsCYxNFq+h6Lg0mWfXTjr/+rBcp+7RITQYYZerFBXL2yHtWdgcfsK+O
 tht4ng2f5ceGcYjHpNEm7DBEzewDha5s8f4GwsDwxJ6QwN/9/DmwrqHtRlLJoErI3HC5
 4mQwcfyaIWya5jiHUCnZHmQNov4XMoaZbcBEl234vG/RCvl5vQZ1wS5RkMf9OThwf3s7
 GJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752069313; x=1752674113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MuLxj3AyiU47b082Ox87lYnYj2X4f4EJr0NSC/OFaxE=;
 b=AwTV9boOg5A6XjXx3r9Oexm5ysmHx6ewPqx+HJMStmT1/Y3LqWnezfV09DWBITpl1g
 9A2Czu+9qSt/3KdiR0nXcqIT1jj6J03lSX43e3vQg2PW56UfaiiS0MP36xIObGRMRgJh
 t29u94/nYjXrsyeU5VTTlSNIqNA8dmI2k45VmCzxddXdxcTiC8OXtIPeCJ/xJvHkXUGj
 sXO6P676+usA7DeZw4ryNFvPxSu7h1S2wqjRRoS1bV4os6gEmXeWE4Ji1+dVx1b2izug
 j8koK+DjubY4f38pN632iUU9E8IDKUqZ05HbMzDt1+SrxqIHaR9X7RSmDSGtrwWGM0o2
 Trgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8GwC/dq4ToroGeJhd1XwkPd5MMvQxRwF2Mvj/xD+46npUMINjqDOEmdhhlUWJSOgGzMnTrwFpnHEk@nongnu.org
X-Gm-Message-State: AOJu0YybgPXH+LAjayj4AYd+Ec7QH9ns7XYPrn5+jOKjrVZJJNvdj1jr
 vrq/o/Cq6pdDiHHd+Hvi7Qyt3zklIgplrv4LwY4BqREz8qBkh1HDIlvg58iudN/Ivoc=
X-Gm-Gg: ASbGncvkxlDynfhN3jle4TcrmQsJaVBnEnDc6leu8Jdu3Uce5slbtvlxPMbWZRXRoPQ
 DqFEmVdEOHTbbjHl60Nrv/05+JOxhUXQPXZVDXlSYGr+6KmcDbtWO4zl7rUK4gHAnArBNQM/TxR
 zlBxQEEaI6o3k9FhALtWe8rnM1ehp7eIME3oG/Po9JYTMPRV+Be0pbuPtLlMbgDAbI3RRytBEms
 D7fxixtSkT95hHUL0Z9KWxZca6eKP3Jbj90KXVoINHwR3djTEBjUB8rFp7UrIKl9JxTdBdqMttX
 7YuvOg9uct7hImMJ4fIMTi5JCS8YjZRMJQZv2EuTZt7SELVvThPvmblIDaVm3a6i1gJe+Nef0Xb
 k2kg=
X-Google-Smtp-Source: AGHT+IE0Lhg+mXPlBbVVvW0cU/Daa1ytI5ynXWlimO6X8+tKPV5VVMf5ZftQBZUpFbuAZIsjXep9nA==
X-Received: by 2002:a05:6870:b153:b0:2e8:f5d4:6077 with SMTP id
 586e51a60fabf-2fef880bd4fmr1704684fac.38.1752069313340; 
 Wed, 09 Jul 2025 06:55:13 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7902d65f6sm3401554fac.46.2025.07.09.06.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:55:12 -0700 (PDT)
Message-ID: <6cb1e9f4-02ce-4b50-b66c-a109dce0f7ad@linaro.org>
Date: Wed, 9 Jul 2025 07:55:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Implement fchmodat2 syscall
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250708161053.853322-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250708161053.853322-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 7/8/25 10:10, Peter Maydell wrote:
> You could argue that the fallback-to-libc-fchmodat here isn't
> worth bothering with, I guess.

Indeed not.  Support for fchmodat2 is at least 2 years old already.


r~

