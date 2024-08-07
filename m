Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80D4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbHL-0004GC-80; Wed, 07 Aug 2024 03:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbbHH-0004D6-2w
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:40:13 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbbHA-00016Q-LV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:40:10 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so22701681fa.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723016400; x=1723621200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i4D+MtlrEuqCWaykr9f9cIXM8/yvDCiWntfzyog8lLU=;
 b=d3Zb5e8Y+087Z+dN4D/q1GyFQozl7DI0uX+obuzARD0rjT8BEYp3SZH7wF9ZsUtODI
 ANqMrEoQq8g9ayPptJCcaMwAeDiytIWkcaafqAFYcRlqOon7zBxHiyKdEciPRxqS+WAF
 7sf5r5/bOD0hIJxFa1DDYrUbrZHrIqRl2j/mo3vE9R3yIpp6fcIrSlMR6diqiEAyGg9N
 aXkXbqkT/1VgsDcRx1E86DyFVKhp0y2rXApz3rIZX6mdwAEHU4PHqagkEsOc0h+rPkoT
 Z63By974mdk0Yr8IlI5XQENfYFshp+AGSGf3s1T8ppC8PwmmBlfbFcye/RztqLAHVCpf
 4CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723016400; x=1723621200;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i4D+MtlrEuqCWaykr9f9cIXM8/yvDCiWntfzyog8lLU=;
 b=Azd2S/NPGS4iRT4RO59+T1vnaMbVziICzuyhUs2vZiact/G7TJs8I1qNK2++g4NP3Z
 phlmJqRt+skwv+idzOheoxv6IFTp7fo7ZxCX/ygxwdJDT+9zGC0uV6oRZlaUONAJlMFa
 LjZwuLH2/8ogeIF8Zxb5zkpgpnK8ZD3SGNtJ6yxkvhjJcHQX4IpVgJH1j6Hd5FfrpoL8
 viZoEtHW7frUPrc27EWmzchkvBsRIyWq+rmAd3k6zOrDWLAsLY5dScs4EZ8ovOxoqBMQ
 IfmnXRfn26pn+9a5HcFkYU699Ea7TBMRq1kcaa1L+fDlkWO4WKU45qUoF1babzSDpU2L
 9gMg==
X-Gm-Message-State: AOJu0YxnGIgaCO/unTauvXy3Xs1qdupdNiZ8TZFRbbYcFT0v8Pc+3/BT
 k80VxXgzF+C3TGfMsbhhD4Gq0TcFJQdueFceipKmd5Ed3nsjEbgZUMKBAa7bmr4=
X-Google-Smtp-Source: AGHT+IHuW5TsLmJKtJYhA4abb749J9DKy2kL7K0HUS8bAejXzIq5dth9TZ+rBWZkLWgvjRBv4iHrsg==
X-Received: by 2002:a05:651c:22a:b0:2f0:1a95:7106 with SMTP id
 38308e7fff4ca-2f15ab2a514mr142725521fa.39.1723016399646; 
 Wed, 07 Aug 2024 00:39:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0b8e7sm619013066b.72.2024.08.07.00.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 00:39:59 -0700 (PDT)
Message-ID: <2bdecfe2-d727-469e-97d1-4c011774e2e8@linaro.org>
Date: Wed, 7 Aug 2024 09:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ebpf: add formal error reporting to all APIs
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Melnychenko
 <andrew@daynix.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240806145653.1632478-1-berrange@redhat.com>
 <20240806145653.1632478-4-berrange@redhat.com>
 <208ede45-0866-4dce-b6ef-e8390c1c56c1@linaro.org>
 <ZrI_IsxXceEJewFO@redhat.com>
 <5403fa28-bc81-4208-9b16-7912a3b190c5@linaro.org>
Content-Language: en-US
In-Reply-To: <5403fa28-bc81-4208-9b16-7912a3b190c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 7/8/24 09:37, Philippe Mathieu-Daudé wrote:
> On 6/8/24 17:20, Daniel P. Berrangé wrote:
>> On Tue, Aug 06, 2024 at 05:11:55PM +0200, Philippe Mathieu-Daudé wrote:
>>> On 6/8/24 16:56, Daniel P. Berrangé wrote:
>>>> The eBPF code is currently reporting error messages through trace
>>>> events. Trace events are fine for debugging, but they are not to be
>>>> considered the primary error reporting mechanism, as their output
>>>> is inaccessible to callers.
>>>>
>>>> This adds an "Error **errp" parameter to all methods which have
>>>> important error scenarios to report to the caller.
>>>>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> ---
>>>>    ebpf/ebpf_rss.c     | 59 
>>>> ++++++++++++++++++++++++++++++++++++---------
>>>>    ebpf/ebpf_rss.h     | 10 +++++---
>>>>    hw/net/virtio-net.c |  7 +++---
>>>>    3 files changed, 59 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
>>>> index aa7170d997..59854c8b51 100644
>>>> --- a/ebpf/ebpf_rss.c
>>>> +++ b/ebpf/ebpf_rss.c
>>>> @@ -47,13 +47,14 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
>>>>        return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != 
>>>> -1);
>>>>    }
>>>> -static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
>>>> +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx, Error **errp)
>>>>    {
>>>>        ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
>>>>                                       PROT_READ | PROT_WRITE, 
>>>> MAP_SHARED,
>>>>                                       ctx->map_configuration, 0);
>>>>        if (ctx->mmap_configuration == MAP_FAILED) {
>>>>            trace_ebpf_error("eBPF RSS", "can not mmap eBPF 
>>>> configuration array");
>>>> +        error_setg(errp, "Unable to map eBPF configuration array");
>>>>            return false;
>>>>        }
>>>>        ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
>>>> @@ -61,6 +62,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
>>>>                                       ctx->map_toeplitz_key, 0);
>>>>        if (ctx->mmap_toeplitz_key == MAP_FAILED) {
>>>>            trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz 
>>>> key");
>>>> +        error_setg(errp, "Unable to map eBPF toeplitz array");
>>>>            goto toeplitz_fail;
>>>>        }
>>>>        ctx->mmap_indirections_table = mmap(NULL, 
>>>> qemu_real_host_page_size(),
>>>> @@ -68,6 +70,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
>>>>                                       ctx->map_indirections_table, 0);
>>>>        if (ctx->mmap_indirections_table == MAP_FAILED) {
>>>>            trace_ebpf_error("eBPF RSS", "can not mmap eBPF 
>>>> indirection table");
>>>> +        error_setg(errp, "Unable to map eBPF indirection array");
>>>
>>> Aren't these trace_ebpf_error() calls redundant now?
>>
>> Yes & no. Errors propagated up the call stack don't get included in
>> any trace output, and so if a caller doesn't log them anywhere they
>> can thus be invisible to someone just looking at trace output.
>>
>> I could remove them all from the eBPF code though, and put a single
>> trace event in the hw/net/virtio-net.c file instead ? Bit of a bike
>> shed colouring exercise to decide which is best though.
> 
> No problem, I'm fine with this patch.
> 
> Note from experience (although pre-existing in this patch), trace
> events can be very verbose, and a what makes them powerful is we
> can filter particular ones. The following pattern isn't practical
> to filter:
> 
>    trace_foo_error(const char *error_msg);

I guess I meant:

     trace_foo_error(const char *const error_msg);

(where the string is known at build time).

> While a bit tedious to add, having a single trace event per error
> is way more useful.
> 
> Regards,
> 
> Phil.


