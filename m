Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE09DC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 16:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIryO-00025m-Ej; Sat, 24 May 2025 12:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIryN-00025a-9t
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:43:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIryL-0003Bg-Lf
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:43:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442f5b3c710so7517435e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748105024; x=1748709824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=THJd5Q5AdeLLJm63T7bvXc3xm9kM4DiKTrpqtlSUKU8=;
 b=hw71Th0gYOeu44UEpQXoaoudYdvhrsOO7xH/F++SIPzZhBHCiFA+EPJR1XNStJeYhw
 bCel0RRCQ71w+i35mY3gmX6ELn+kr3alDHEJfQJDrIQXY4oM3oVWB4qCEPp8sLhexcBj
 ByonoAUeGE60FIRe109J//7iGRdB9OrJa8YfcvSp08dijBpE1cAxWLhWPdbTVXncyX2F
 R92iCAecS34I7a17cy3U22urJi5y3PjC3Cf6VG+qCsf3eWg7ZrY6+KHGbyR1vbpbGkLY
 ntUkIE7Hvtv60R6g1rSi3TTKfnwJsclp4e0dT2/s20W8Q7knzbLLuoZ9qtE7p3aVHl7Y
 FvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748105024; x=1748709824;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=THJd5Q5AdeLLJm63T7bvXc3xm9kM4DiKTrpqtlSUKU8=;
 b=Y7AZEegwEzUp95emPV3oxJwsmf2UyxFrZXHnUqTzqE2PXN5arW+2CbgVvN/ecqRY9X
 ltH37d2nC+wcvEBYhSZGesOUG21horPBnZ2qicCJOwFtJBCobTbJFVe5Ao4aDm7KkgR2
 5JKzWFA1s1z1u4yHja7WFwEsKCBB7dKNTu98pzCIvmV4uchR9eZYjjQlU8jJ3KmNtmb5
 Xw7Kv7/FMZk2eaThJxnFFt7P4YmuZmi5q3iHKSA459ePX7VmxADV83DdFmGeY1NucYMi
 sf0sRb64iEDZjVAy3EiEL+PrqY7r9/KxpKcLY1OStRK4hbDKrCKrnExDQbAc4O2riFTa
 kIww==
X-Gm-Message-State: AOJu0YxkpytBvzumwz58d0H5gFLOjV2kMelv+ZPxGMLyClV/92NA0x/X
 18Y2lz9iViGn7Sp+bN83WwGvBdtvCGSMO/0MWfFfWWOjWjSKU8iaj8P+wFSvFH0YXqMJC/k/tGc
 mINf8Ht8NKA==
X-Gm-Gg: ASbGncu72ErVfcb4VTR6pq1+bc8jjnS+zQoQUN5t5QWQNYSxxwaGHdAD8sDS+ci1noi
 h1uB1KnBU6+fU47Y5+KIqMApOJOlUtKF1FQBsJ5zU6Yd33+fZ2jezbfmysdwpFaLwQ/PObVWuVv
 BYbzJ4Q+AfzvyuqxdEBEuR+Wlt4VYuKPu5OtTA+cp1dWKeUJ1kuhxq0jE86l0/Odu/PwHX1koeR
 bn86YXeaiX1BUlNKwsULOOAhHIm9P9oXNRXUaliWVPicEpEDU6ENxAc7EumDpmsppFVniAGtOEE
 /TmZ2aKy45f39lhBSFMGL8MnHahbGLKRl6dF0yIm7hTJ4Qhv1lv47i5AAwkF9mBunA==
X-Google-Smtp-Source: AGHT+IF1g4aLHOEU9iQyjq+/ZACjux2TNKheqeedfOQG+AfOPjYfVEJl9dfLdQVDOlpfFgfsH4T6yQ==
X-Received: by 2002:a05:600c:4f41:b0:43c:fe85:e4ba with SMTP id
 5b1f17b1804b1-44c91dd10ebmr36166045e9.15.1748105023719; 
 Sat, 24 May 2025 09:43:43 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f0552esm179627815e9.11.2025.05.24.09.43.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 09:43:43 -0700 (PDT)
Message-ID: <5f75db65-d158-49e5-bb04-c01462fd8ea2@linaro.org>
Date: Sat, 24 May 2025 17:43:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/25] plugins: add types for callbacks related to
 certain discontinuities
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <08cd73b30ee74d4b264890e193ef56d2270c04c0.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <08cd73b30ee74d4b264890e193ef56d2270c04c0.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. However, traps of
> any kind, i.e. interrupts or exceptions, were previously not covered.
> These kinds of events are arguably quite significant and usually go hand
> in hand with a PC discontinuity. On most platforms, the discontinuity
> also includes a transition from some "mode" to another. Thus, plugins
> for the analysis of (virtualized) embedded systems may benefit from or
> even require the possiblity to perform work on the occurance of an
> interrupt or exception.
> 
> This change introduces the concept of such a discontinuity event in the
> form of an enumeration. Currently only traps are covered. Specifically
> we (loosely) define interrupts, exceptions and host calls across all
> platforms. In addition, this change introduces a type to use for
> callback functions related to such events. Since possible modes and the
> enumeration of interupts and exceptions vary greatly between different
> architectures, the callback type only receives the VCPU id, the type of
> event as well as the old and new PC.
> 
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   include/qemu/plugin.h      |  1 +
>   include/qemu/qemu-plugin.h | 44 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

