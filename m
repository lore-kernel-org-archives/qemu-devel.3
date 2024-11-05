Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0E5D2C115
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KmB-0003do-IJ; Tue, 05 Nov 2024 09:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Km9-0003dR-U3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:43:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Km8-0007J6-DS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:43:21 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso43838375e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730817799; x=1731422599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XDOl+TuEOx/lFkWG1d5xEHgNJZl2BZtMitSjw0tp/Pg=;
 b=jQXXy+xSo5NJIvpojfYUOtzAexGk5diS0bRW2zEMXUo8S4IHl/wI9XVWR07UHdcdJr
 IpjnLKiLi7qkQMngxT2G4bJwCUzNrR1jEOS2+3uuPDFFe6lLByi+KeiKfPrQbwU2zsbu
 6E0kT+vCeeWB3KuaKa9e0+o/gumEfPf4K2fYLOQM0y41GcXF+KJRMhHR6B3mFg1C/A9Y
 F4kNKB24L4P+8Ehk0rxzHvgHa2uxbEO7yXWSUdcq17lWDHZGW7mxIBpwRHRPCoq29Vnc
 moi94BbTtu8WoXlnMMjEX0RUEyvwJ0fgfOCcZBl01mZ18Fi96LmstqufxZyNvPoPxZ47
 UJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730817799; x=1731422599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XDOl+TuEOx/lFkWG1d5xEHgNJZl2BZtMitSjw0tp/Pg=;
 b=Pi1Z1VU3Nli55TgfzznzLzm3e/UgMlKDnuOx0rB92NLsTGNbH6IDn7nARI1hFnDiO5
 tD6aLNh+Lo2aDZ/zITXmZOqOa8KhC0oj6cSQNGj5PS/1TIosC9M0x8tXLKfBxMzqgpPi
 +r0qg7/f44W/o5v70yi0BHrxuayLK+l/JiPoJM+1tGEVs+Do2phDu1MmZC6EvYDbDTCt
 YUUSz0hIN/9LEkjqDWQuOnJRIcXWAe1pTiPmjcTX01xfdXZXGFNT3QFUq+nu7FLtUw3N
 mNgSoD+LIOPjMZK3LzJKqf54cD9KBFWJ4w7dSsxEYth86Dj7mBuVaoWSbYNk8l6O+216
 0jXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcTUPJX+Nt73zYzIA8bvSgEadPybfA69TVAHaKOqq2jjSEs4vWCGcbwvHNoyKJJmbERqxbK4UJNAQ7@nongnu.org
X-Gm-Message-State: AOJu0YyOZRK8V6ocUpd7Eez3bcfDGu2lKazGpMV7mfFrBP4Ec6b8F5h5
 aj+vcbWjVDO+c2Cyec51yGQhoTAIRDFEz5Sy80qTcILMCEuGiUpXseBJ35DcAsfLYqHPpyZX5Zn
 r3yY=
X-Google-Smtp-Source: AGHT+IHGqwOJAWq0RdAH3L+uhHnnxVwjH6VzX/erK+6hH6auXA8Y70YKOXkUaOpSER3E9A8Y3+1Tnw==
X-Received: by 2002:a05:600c:1d01:b0:42c:a6da:a149 with SMTP id
 5b1f17b1804b1-4319ad048cdmr338184625e9.25.1730817798671; 
 Tue, 05 Nov 2024 06:43:18 -0800 (PST)
Received: from [192.168.21.227] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a26a7508sm22178645e9.0.2024.11.05.06.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 06:43:17 -0800 (PST)
Message-ID: <917743c1-5331-4bec-a6e2-4ff6b1c67c86@linaro.org>
Date: Tue, 5 Nov 2024 14:43:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] user: Introduce user/signal.h
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-4-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241024200031.80327-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/24/24 20:59, Ilya Leoshkevich wrote:
> gdbstub needs target_to_host_signal(), so move its declaration to a
> public header.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   bsd-user/signal-common.h   |  1 -
>   bsd-user/signal.c          |  1 +
>   include/user/signal.h      | 23 +++++++++++++++++++++++
>   linux-user/signal-common.h |  1 -
>   linux-user/signal.c        |  1 +
>   linux-user/syscall.c       |  1 +
>   6 files changed, 26 insertions(+), 2 deletions(-)
>   create mode 100644 include/user/signal.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

