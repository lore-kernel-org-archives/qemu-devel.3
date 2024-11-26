Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2FBD3B996
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFweR-0006xY-6Q; Tue, 26 Nov 2024 09:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFweN-0006wn-Ls
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:34:49 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFweL-0003nU-8e
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:34:46 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3824709ee03so4111192f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732631682; x=1733236482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kd84w85kLEPEiBmjrzJ02AtQs4ZYLhpRXTdWpYd4MqI=;
 b=FgIssMrLmliqE1SToFsPXSNs/dCHhRlZMUSNUL/F0T539troXQrmqqkdF0bFB6+dUQ
 4Wne5cPYYOKDRFsqRORKiESzKWi/RzGitjUPHZx8C9rEPn1zOjaJiwv3NdDneK4+njsR
 IkyxPWDN+Zb5xHHsS04x/pR/9BrlvfZBWawDIKUYRmQG/whgEs9YE8lYcDlO+49bHGWh
 i8mtky1muFR/Rinq34znHMg4PWQHj/1jgJwIzrnhRws2ERrbZ6839Pxf0GLtVsFJK/JF
 bIxUfxKeq0XvBfWOO/+owTjJIX0VcPWz1mYUzsP1BvVTfXdlY8m5dAXWbke9wbFnn3mi
 v/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732631682; x=1733236482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kd84w85kLEPEiBmjrzJ02AtQs4ZYLhpRXTdWpYd4MqI=;
 b=s2bDBdj3kt3W4PPmAhmrez8FFrt0FU3gLppLKSTJkaXaH0XW4kf7K9oYsxIu0beIoB
 TlkEVKgIypNcdG9ALdJNgEAh8Pk/DqRDofX5HLQN/jlS1xHhkmG+dd2SzTQ3eBInYy1v
 12XsgauGEiqA7R8RUOnOEq/yZJ7yUQhvxgtAMvjr2oVvX4duVsZWj0iAXR3NLOnEzA5i
 BHzmosf+jcieRJecUiXF15o8C+XKtXoEaR4KcjaI0BBVCvXgpXVjTjt0XzXCCdcIwQ7U
 TlrfAdGUGXYhQvoXel7GwIcysfvyNY++Ax5l9qB98frMOt2abWPIdJxOocIoYIUm4b+6
 yRRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXowTUXz8n1AUFptlXTRnXgYX70Q8nnLSbOWSBJMOCDNzVYSaTFQ9Hl7hfiw4OEb3OEEaOU/S3Fh8lH@nongnu.org
X-Gm-Message-State: AOJu0YwKU7J3wEP0FYcJquOXSnGkTu2+NbBaKjvJSCwnoq1PPxbWo7Vf
 B0XfmgBeH0r/H2XkqkOWexy3rSnUpt5Y5V8r4kW7MIFJ/HvHa9pcn3br9y1tz1k=
X-Gm-Gg: ASbGncsMk1yFSjPA4hb+KJuJfmY0weVWzDZ0qDqgJMIbljvFREPSZUmffwPebE31NjH
 4kO63hNubUhc9wzRaLxv6gGjAxvAh1zI3lCOxUd1cF+i6TcrGaPpgCddVHTph+0JbmmjhNxThCu
 AOjzeRnZozbCVCq3OubBIFmxYKQwLjlZUj+tZ0R/qC9uehvPliyTQHcPHbb9G8JSJp1H46Gq/yo
 DE528Sr161VK/2fwWybRcOWm1OELiPOdZDtRmqhP1ZuOMWC8SQWeciFjqeb883TwQ==
X-Google-Smtp-Source: AGHT+IEX8Extxn6UX6yDjeFMHGXjpfBi0qth/ebQFmxVLBxvedc0HauXPtR+cTjNXhPqDKYDkE1D7A==
X-Received: by 2002:a05:6000:1acd:b0:382:5351:5bbf with SMTP id
 ffacd0b85a97d-38260bcdc5cmr14270518f8f.41.1732631681826; 
 Tue, 26 Nov 2024 06:34:41 -0800 (PST)
Received: from [192.168.69.146] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a81f59d8sm14137845e9.27.2024.11.26.06.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:34:41 -0800 (PST)
Message-ID: <25361bd1-c5cd-4949-8b86-1d7e4e833a83@linaro.org>
Date: Tue, 26 Nov 2024 15:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/mips: Declare MXU registers as 32-bit
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-12-philmd@linaro.org>
 <44952443-3928-4430-8fd1-23c2bb4c00b4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <44952443-3928-4430-8fd1-23c2bb4c00b4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 26/11/24 15:18, Richard Henderson wrote:
> On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
>> MXU extension is only built for 32-bit targets,
>> so the MXU registers can be directly declared as
>> 32-bit.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> While the mxu extension is only enabled for 32-bit targets, the fields 
> are unconditionally present in TCState and the vmstate.  Thus this 
> affects migration.
> 
> Since there's a migration breaker, I think you might as well extract the 
> mxu state to a subsection, enabled only when mxu support is enabled.

We don't have MIPS versioned machine, so I can just bump
the version number.


