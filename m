Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AA3C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWfh-0008Cl-8H; Mon, 10 Feb 2025 11:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWff-0008AR-3m
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:30:07 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWfc-000448-PK
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:30:06 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f3e2b4eceso85775535ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205003; x=1739809803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t+Dw9neIWJ5eRvSzVDblBF6ZL5LXiA/ErQeZkCGQ1Cs=;
 b=r6lhI21fXEVK3GarsTDPnZXyyAT9GzqX5kySloRYlqj94yiJtFjWp7o4NvImEJ8AxO
 8Tq68nNcQ4wJR7vu7b8xWgPbEAtAtxHcFKKRmIj8vaZ+R/m8usVPaQK3Wu+4Wt28Qxo0
 J6fw1qHG4CauOTzZncHJsA3Ka+uqEu+S7zX3wH28ESZV0MMAWgCX5pehQ8ayzxb+SrZ3
 NJnyburs8MFDXyqmqW5c4AuCQX7qamoyiDISqYWjn6op3CpLYsDGptLgFhlOTcW+QmnH
 Bo992MvJlO4wqLvxCr6KC4IjHHeed2/JkeoG0292a7yW9VFJVmLhnl9kSTX4/3TIKYOt
 hJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205003; x=1739809803;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t+Dw9neIWJ5eRvSzVDblBF6ZL5LXiA/ErQeZkCGQ1Cs=;
 b=p2ebeRSePckOLq1pH4hRfYi1vi8onpQkWyXqvFMpmcEInSKIHFbj2coYGkg/mDilu/
 c4lV85k89l7B1SCP5tuPfj22eQGVA73cdMXzEVISU8g5chC7vyGZKSyMRHpM6iszUyza
 A7d/ykdeL4AZauvfdWl+2RATBHB3pwgx4+CsC/uff7uwbcFDeJNBaYpCqFhrx5W83Q1v
 FrLIKRQ/0oRHOWDvr97qcH7fW6ZjXIWmT+9d9L9lqZBEx0lmrYiSCn++iWL7gAIda7tD
 kD+SvIHCSkWzsJu3q+VuSqY7W/6hAW1SWccFmt5KtHga6vmsKai17Z83FStZzUqOAOwu
 jpvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVncj2u+nNRgrjHUcTLKJxPnVHLam2umRoyugbYumksSKvpHCCisLbylRcRwK9jerDK0dqi9QJ19utb@nongnu.org
X-Gm-Message-State: AOJu0YxI+moZccTB4FNhCxl4f0q6T5ReXfWeKTmlnKh3/YHDXQVdvv0+
 hgF3fE9qSoMjfLPRIf0jNntRBS+K+mj+aazpzgcSxZjPmzE2xiIpiFmBg2Il2Ck=
X-Gm-Gg: ASbGncszxO6EU+fkSNbXOrIk2WnqjuopQFH/4aKXoVdsE5ppA7D4710w22g7L/YKYiu
 D/IsXV3Ix7k1kL2TtJsx+cjJ0vwKquPExHVDjgINH/uYC/tl7RaZRoghKHfUBQbYFXi/sS7cg5X
 t/XS7R836CnSlx2Kepuh8oAkYzUTpfufsjgksR7al8asC60ic8lvEmyrH62xRV1QStyHpIIL2A4
 SBA02xdPEL8+M8WBgf+RyTh8lNtGqTY9rDzd6DSeF3x+eB++8VzX0VzefW2hnm3Hd2mCbSpuuVS
 29wHIZvC0MZDeHzlM9YcvVa6Pc3g3YebNzxFNJv5/GQ5tJITSwl84H4=
X-Google-Smtp-Source: AGHT+IGzVls1vG6BX4pBYrRkRlYcVZFNMcghQBa+Z9nNud8q45JeeI9RSlC4RDzS5ix/uK+zyG1yTQ==
X-Received: by 2002:a17:902:d484:b0:21f:617a:f1b4 with SMTP id
 d9443c01a7336-21f617b009dmr197765435ad.45.1739205003064; 
 Mon, 10 Feb 2025 08:30:03 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d6e5sm80633555ad.141.2025.02.10.08.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:30:02 -0800 (PST)
Message-ID: <d351ce19-e197-42dd-b528-f25b2439d039@linaro.org>
Date: Mon, 10 Feb 2025 08:30:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] target/i386: Constify X86CPUModel uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/cpu.h | 2 +-
>   target/i386/cpu.c | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


