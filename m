Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD74CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNg8-0007ee-2A; Sat, 30 Aug 2025 11:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6oM-0004Vo-4p
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:39:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6oI-00007K-Tu
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:39:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-244580523a0so26507485ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756503541; x=1757108341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iMCIi3z5edR6MVDUP2g4UOv8RXSM/sAGgqJ3ufSyAO4=;
 b=hB8ycX2bcjadoVloVkTCyobbb+Z63AV4xZhAa7D9a8Nd6SAtCXhG6MKLcwL3ga6du9
 R+j2ii6KKYvljolTUaOj6FTPo4dUrKsj7w+3Y8rsCUk8BdJcOefD59gCykr4a3zJrcWx
 fTcvyIo+qSjhEbQ6anrHPNOE+ITGUZofPuwvlfFyYsLnD9207Y0NAiOe14YHoqXvgveq
 Ry5yeFpv5EP4S9/RuGiz69WqS6LwZ37y869jGb2L32oLVnYSyqj7sOF9WHfT8pg+Y/Rp
 R6f9ScV/pXK/yJIRFYdAsK0rDzg1Lxr+3PBQslkwIXyZH8Gqf5lxNxjpY6YroBpj5RV/
 PzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756503541; x=1757108341;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iMCIi3z5edR6MVDUP2g4UOv8RXSM/sAGgqJ3ufSyAO4=;
 b=NgTGpGyn/2I5JnOKmTWdv4nzUUWkdZwQNNwZfMbO8iuphzCzPuhJgBGXz9I4JKvwhn
 KieLvdhDVQICS7fWvcj/Ogpd4Z63ITpPhPbGjdfiWZnKrngxAIbojYj51e4aq03jgmP5
 pa1LVcydBEjaozheXvvPtf8My64oR/JdxM9IOM1w8SoTRbMBeuA8Ro2VKOGYIdQWC7Fl
 PfYMrIavwERmPIYsvFp5LQekpFXaRBA3CuwzWSgXk6s2MFvtohR0iz3MIbueftxquxEK
 7ayGl5vFYuTsoHLZvYPSC7bJV1dazdRkm8RpSPgEkGDQMCtacKsaQ9uTlXj68eLnOyLZ
 x/Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwqepkyGu3rDNnlK823iejNctbZAnEIx/bm6VyahAFfsxBkCObH8yJLSOgT7MTGhN/I4mCIYyTyVRu@nongnu.org
X-Gm-Message-State: AOJu0YwDyX5lK5eOVJiJzbtFF3KwUr8pJeDYeUtlYQc9sjiGZADR+X3u
 2S/VOVEWSQMdn5VVbz4Z/6+eObW9xmBx+R1Kyo9JtIWAvwOJMCDLgOJqFFCVRa+Fhv0=
X-Gm-Gg: ASbGncv3iHaeY8zTmLV7Vjn2XLkjhSkUSxRNqI2fL07Bl17EEjUIXbbSHZt0udvcrIt
 14bpJwN59aOQL0TbhGMk7xiLnklsGjmO563Xl/ZNGVn5X+e73PiGqeRjpon2gVskRY5NB216gH0
 QxykqOBeH6MqdxHqFQrYvme1eL7wb3ihVHeEM+AOJXUO+52zf3f294AU+F0Dp4nzk5FPnqzAgzs
 3z5U/stUww2w9jxZ+2HYu9MfKRVSj9VNP6EyxvzezhaJ3Y2dIrKnF6a9L09Se6YSYVQa9k+GcJR
 gi4Dl/XwdeDpgt97ll/VySmACJw88rEhhI+WK4H0dbEBnjtcMn0Wi7fR2zAKHkN/beCQuFhL+VH
 WF+sq6WyCz5tWh8iophkV83DRe8IOwunGGmSa1+NbLHxKgCvlj12PLPoOITyTGuf/K8qv4o/AJs
 V+bdczYg0=
X-Google-Smtp-Source: AGHT+IGCdga0s5dtkCfKGsd3TgqoQ7aUWkiYKENmw7+ZVqxzS0S0YYvMwH2jBBnfNnzzV99y5DwZLA==
X-Received: by 2002:a17:902:e80f:b0:240:968f:4d64 with SMTP id
 d9443c01a7336-249448f9c33mr1442465ad.11.1756503540929; 
 Fri, 29 Aug 2025 14:39:00 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24906596416sm33568395ad.118.2025.08.29.14.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:39:00 -0700 (PDT)
Message-ID: <2f5c6c14-ca41-4ce8-8a19-3d40e2589385@linaro.org>
Date: Sat, 30 Aug 2025 07:38:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] cpu-common: use atomic access for interrupt_request
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> Writes to interrupt_request used non-atomic accesses, but there are a
> few cases where the access was not protected by the BQL.  Now that
> there is a full set of helpers, it's easier to guarantee that
> interrupt_request accesses are fully atomic, so just drop the
> requirement instead of fixing them.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   include/hw/core/cpu.h |  1 -
>   hw/core/cpu-common.c  | 12 +-----------
>   system/cpus.c         |  3 +--
>   3 files changed, 2 insertions(+), 14 deletions(-)

I guess we didn't need SEQ_CST, but since we don't choose to play with relaxed atomics 
elsewhere, it would simply complicate things to start.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

