Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203B7C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqe30-0001Sf-CV; Fri, 07 Mar 2025 15:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqe2y-0001SQ-7T
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:11:52 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqe2w-0001c9-Kj
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:11:51 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2239aa5da08so38095555ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741378309; x=1741983109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tziCB6KixSvp/APiMKBq/lNqe8hWt3np2/KNQjLlTKg=;
 b=JgUqie4A1m+jo4X/fZYSvHrmriYR9d5C8OlDsd6/0ZlDTXv+f/bWFmcoN0nAgqP9AT
 j7eeRgiMgX2IMzgpire1PvHqew6fFBM3GtinS044+1UlalnMbEYnS5wxNmp9tfdAsi5H
 QbZijjIR3EJZnbiJMTSsN4tSLitdUsFbAR7WD8ESm+Vq/uY4IpR14+uN6bO2R0hE5GVD
 UDa86gIYPfgk+nXqjzmOl7SJ1edGBnAt5cIAq6jinREn80kHsC9m9wj2lKnwM5fqtcZA
 IAk/t8cF9YM3LTWzostQfGDalZWkKzP49YbksDz0FS4LBBzvaRWeG3XbWHY5EYd72slj
 FEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741378309; x=1741983109;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tziCB6KixSvp/APiMKBq/lNqe8hWt3np2/KNQjLlTKg=;
 b=kPAMOifCNgt6BCM4RBZk3y0q/K4NRgDvspJsO8IfYJXgJHcogsIuixu7k7didHYbY7
 nf0q+9Dmckw8dkXZh6PY+0klbiuuUGFdgiQsMSeDCA35Y3KAkofR3ggVFHjLcqfPkzVp
 Mo2TbO/hKkm460Uzzi3OXgvx6IEzrWLKlDpEptH0VBmqDQLi92kejTM70X9xmeBu+ZHw
 JFQF0LQtF9D4rTOsj36qPAOZiwZ5TnyXbCweCFJgbE76joZv42o9oA1ASKRuC4008ttD
 MNoqJoqrwdX+fifkOw2X/dE2LAgVnNCXH6m49lc6okfgC7pQdmo3DfCJcc8nJ6usRbTq
 Sixw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCmdCook/g6sIB5+MSitX5gn8MG2MmBc7pjhf1BQzmViv4p7/GnSg9pzL56IV644dX4GzUP7FwCyhW@nongnu.org
X-Gm-Message-State: AOJu0YxzEZ1oVMPnyK2HBU6zi1pY6Ob6CzILgWJXaKrvYk+puB2KJJta
 BeEOqxfK3Y31LwuL6Et03+CjE/kXAPkIx6ujiSBom/sJ9hr4pXOE26gN+xpYziDkRhw1wqnnVGe
 6
X-Gm-Gg: ASbGncvz4upCrXOu4wIgMQNwr21kRaMd8fSV+K5AE6cFptJI64HRh38HczVsJFu65fv
 nYvS465/47g/EZAl48zd1/h4isY4JP1Bvsn+bagrimLNiupLT1Zx7MK8rL8BBClSu415A+s/d8j
 8r6qSTnXY5z2ymcstdGe/2DoJdMs6EsBDBa3Poy3klaecf3q7JvDytvX15OKFHLM6hYL/phtKDB
 jLa+WjbrWJnSzBMy+dnFQUm3Y0VczOYEWNwh4minuLDgisMViuNrHp6kwsKgOpJZf6bRK7+YSq8
 +WEvBmXx3ccJFWWdMaskL+RgTBWow+Jwe9jg694O4gADT7oDUYyMqrQGx1c+iQAf75vLgsmcCaD
 f6FOtA9DR
X-Google-Smtp-Source: AGHT+IECqiKOD59k5pemfYybny37XB7kVMBqpvAwhgYVb/90H96Vbi12ikYsPRCrXEfJhvWBtXNRhw==
X-Received: by 2002:a17:902:ce87:b0:21f:5cd8:c67 with SMTP id
 d9443c01a7336-22428ab58d8mr71692095ad.31.1741378309109; 
 Fri, 07 Mar 2025 12:11:49 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f7efsm34311965ad.132.2025.03.07.12.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 12:11:48 -0800 (PST)
Message-ID: <00150fae-87fb-4434-aec9-57098fd5d0bc@linaro.org>
Date: Fri, 7 Mar 2025 12:11:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] hw/vfio/pci: Convert CONFIG_KVM check to runtime one
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> Use the runtime kvm_enabled() helper to check whether
> KVM is available or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/vfio/pci.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

