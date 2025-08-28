Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE0CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 02:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urSgW-0003oH-B5; Wed, 27 Aug 2025 22:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urSgU-0003o4-RV
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 22:48:18 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urSgH-000175-Jc
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 22:48:18 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7720f23123dso478726b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756349281; x=1756954081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4uUWDdrVcwibnqUAKCIIKrJnH/duUO6OqA8ZAfwmew=;
 b=y5kmu8nJQeIHI7Gis9QP2m28QMEcBg1ABhhfsq5T0lC0imYBADiJttJ26xH//VBkDU
 LREPpdJtvEFYeWYmJBoM0OSsxrNr9SlF4YELnsGokK9HVm1KRyKGiBIHuI/86AVDtSd/
 32eKnIkt/VCaQyNvmgg2qoee/ZZpXKTtvimX1OM/VXNRJ4HUQnuGiLE+65YQ8e79+whe
 SGnKH6GJVuzA2qwOFX+odjDFubY2X3iPnaPW/w1+frOIh3sNuST9LnH7XGhiGhuAmv/2
 fttIfJtWTwvU41viP6rCQSJh32g6ueeM5cnLZoqc/IPLs6XN2rUCAP6f8qYwBoZaMV8q
 BDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756349281; x=1756954081;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4uUWDdrVcwibnqUAKCIIKrJnH/duUO6OqA8ZAfwmew=;
 b=mYBQlGsFcfalwb8TPbKZ6VPnMJcoLlztoNjwcRFW7+f1rSuHmGJgy6ubbMRiKrBYl0
 S4kQ5CvztKdDUH6oyI/aAZ2xjnfKdpbhnWzoRknBfnhLQrRXXpjWYfIndmnX8Ij4Vo77
 bx5QJfLehwRJhIyLy0yfmcDBFVqpMhboevX7joRL6VCQJqlPV/ADiFUR4+MJXmxWy9Ot
 jOohmU12TZYZByQxX4ErA0dgpRTij7awamrfPIBajAxkrvzJMrNvCneYRfpPquwZKFyc
 j9Xd2aK2hCjcBohRBZhOkUs4+LFkQmwI9OppsMAlMdyBIYI+1P5QoNRuPGSpPF4osOOk
 8KJQ==
X-Gm-Message-State: AOJu0YwXgUMFbX2PmgX48jcngzeEMAhhz1GNeR7R89RMXfWn9B6qDYcz
 BzTSsaBc176rJc+pvrksQDMPoM/Q16/W1blBqG/rx00pUQzA1DjgUUBE91dPSJnK2kOB6RPC1Bk
 6rkipfMA=
X-Gm-Gg: ASbGncvpm65tNmt9nKTNIQS1g3Z5b6CjwPnJuZusxpv90g5dOVca6BxvyUpb9dNFtE2
 PbRoBMgepagfcd9W6s/ThR1IFyuREJCR2kkNoPv2oPQsZ+kpZc/WIEDzEMLxqo45i/lTJ99V6kF
 k3LhIsztLFMB0xcL8CnRcDjCe+4VrNvvVsUFIU/F0cx7Tshi2DITNVTvgBc6SwX36BjzDVHvWbn
 eCy/rCo+GeRigM7ggHmTT69TfwTGz3QIlfoR76deJ3q/Iskzlj8Krnp7n7VAcbmRh5FWObrtxa9
 Uhc1M6tr2Dd7WhDnTdj3Ppl/9bC11ThGE+yzCn/mpO1jZzaRakaURZCy61rCWCaXFfAWOw+q9B4
 WVBEJ2CLe4/2cLogyNuKxdm+PEgIqCo+cjrEHBnQvTNB9oHk=
X-Google-Smtp-Source: AGHT+IHrbrIAq++w0EZsytH3KHRb6QgZIqUO2nod3Hsk+lEpJINw5Kzul0X7YEuuXRQwoisJ7nqm7A==
X-Received: by 2002:a05:6a21:3284:b0:23f:f493:7666 with SMTP id
 adf61e73a8af0-24340bca388mr31217264637.12.1756349281127; 
 Wed, 27 Aug 2025 19:48:01 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3276f57b1fasm3355041a91.5.2025.08.27.19.47.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 19:48:00 -0700 (PDT)
Message-ID: <bf3f0f9f-81c8-4ac1-8fad-c3754c465a3e@linaro.org>
Date: Thu, 28 Aug 2025 12:47:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/46] linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250827232023.50398-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/28/25 09:19, Richard Henderson wrote:
> The following changes since commit 5fc03d4e28258fdf6a926a59c6b5e1edc23e6d5d:
> 
>    Merge tag 'pull-request-2025-08-27' ofhttps://gitlab.com/thuth/qemu into staging (2025-08-27 19:11:08 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-lu-20250828
> 
> for you to fetch changes up to a5fbf1c617c5b51082d317601e0d4cf5eea5c140:
> 
>    linux-user: do not print IP socket options by default (2025-08-28 07:33:34 +1000)
> 
> ----------------------------------------------------------------
> linux-user: do not print IP socket options by default
> linux-user: Add strace for rseq
> linux-user: Move get_elf_cpu_model to target/elfload.c
> linux-user: Move get_elf_hwcap to target/elfload.c
> linux-user: Move get_elf_hwcap2 to target/elfload.c
> linux-user: Move get_elf_platform to target/elfload.c
> linux-user: Move get_elf_base_platform to target/elfload.c
> linux-user: Create init_main_thread in target/cpu_loop.c
> semihosting: Retrieve stack top from image_info
> semihosting: Initialize heap once per process


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

