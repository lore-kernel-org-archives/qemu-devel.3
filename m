Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C182EC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbEO-0008I7-7H; Wed, 07 Aug 2024 03:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbbEJ-0008H7-RI
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:37:08 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbbEH-0000t2-Nj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:37:07 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-530e062217eso206949e87.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723016224; x=1723621024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Icy4KpnuB1CQp5vKGnB98q3O2cFWJ51ElJJ16nHXQIg=;
 b=ff6G/42I9fyKxkFR68wViZywgBXlfOd/PGbIdyKUbw26WtmeoqYzCBEIQ7Ccgaj17M
 RBHZ5PH9bPjBaFvS0XlUqkeaQz3pT/5FbfjKNU3O6GniVtF+aVKdJ2PxiKt8oX1GDR9B
 8Ld4BOvb2UZtQZS248R9/S0oK224VRubi/ju/5qAkvOgLgMovDxhlapLrVSmJcio+v+M
 dnH+cNJnY+elp1HuvnXX3mvE6GDlUn/dCwFtC5vcHncSeqhQIUlXSw1FGprHMjS6F0FJ
 ZMVpE+08RplV81cwBlYLIOIW4JQiyt+OYvRqek0QvgZPHaF4hE30Kla9yAEoOiCJ1eut
 z+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723016224; x=1723621024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Icy4KpnuB1CQp5vKGnB98q3O2cFWJ51ElJJ16nHXQIg=;
 b=rWXJDZe32ct55qyXOuOx48rgTlJMHqUTGM9v6ODq8Ssu55/9tO4rskhZq6aR+Jo914
 goLcoO7ZPdwCJsKbmImlnlVDb+GvIRD3zDnT3Ww/5cDrgXXU95t2Slc1THIcZnm2k5Rl
 JzGvFeHTy1mykBBF8zVV2DpEsR22BCsUOld411Bc2WuYC8qzoK/mVk9QiK2pq+g7WgbW
 iXWctA876q2P1874cZqO38gctYYQTOruB/cRgKuiQJASAxHLb525dDkOedKdpLjFd4jf
 2aJjlqitOFZ720wuJYkbh+a9CkL4EgKfMQAdlk9bSLjEyEXsXbeyT5xZoZcPkfUA4NM/
 MULg==
X-Gm-Message-State: AOJu0Yw7WqZBIULEl1JC+PoYJG0Bd49BosxYEherI7Kv4E7cx+U6AXkA
 38foguc9IT/3UtnnOgFohWR5KjwqyZh7mpopNex9+yAJnaz9G4ZTHx1I3ILbJIE=
X-Google-Smtp-Source: AGHT+IFx8/Zng1M7Y+ly/JNASxOa1bL7XvyiqHQSKZH835+Vw+AlYeCB0/qY4FLwEY+3wbDWGriiZA==
X-Received: by 2002:ac2:4c50:0:b0:530:abec:9a23 with SMTP id
 2adb3069b0e04-530bb36f1b0mr11862208e87.17.1723016223704; 
 Wed, 07 Aug 2024 00:37:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83b92b970sm6776381a12.72.2024.08.07.00.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 00:37:03 -0700 (PDT)
Message-ID: <5403fa28-bc81-4208-9b16-7912a3b190c5@linaro.org>
Date: Wed, 7 Aug 2024 09:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ebpf: add formal error reporting to all APIs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Melnychenko
 <andrew@daynix.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240806145653.1632478-1-berrange@redhat.com>
 <20240806145653.1632478-4-berrange@redhat.com>
 <208ede45-0866-4dce-b6ef-e8390c1c56c1@linaro.org>
 <ZrI_IsxXceEJewFO@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZrI_IsxXceEJewFO@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 6/8/24 17:20, Daniel P. Berrangé wrote:
> On Tue, Aug 06, 2024 at 05:11:55PM +0200, Philippe Mathieu-Daudé wrote:
>> On 6/8/24 16:56, Daniel P. Berrangé wrote:
>>> The eBPF code is currently reporting error messages through trace
>>> events. Trace events are fine for debugging, but they are not to be
>>> considered the primary error reporting mechanism, as their output
>>> is inaccessible to callers.
>>>
>>> This adds an "Error **errp" parameter to all methods which have
>>> important error scenarios to report to the caller.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    ebpf/ebpf_rss.c     | 59 ++++++++++++++++++++++++++++++++++++---------
>>>    ebpf/ebpf_rss.h     | 10 +++++---
>>>    hw/net/virtio-net.c |  7 +++---
>>>    3 files changed, 59 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
>>> index aa7170d997..59854c8b51 100644
>>> --- a/ebpf/ebpf_rss.c
>>> +++ b/ebpf/ebpf_rss.c
>>> @@ -47,13 +47,14 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
>>>        return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != -1);
>>>    }
>>> -static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
>>> +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx, Error **errp)
>>>    {
>>>        ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
>>>                                       PROT_READ | PROT_WRITE, MAP_SHARED,
>>>                                       ctx->map_configuration, 0);
>>>        if (ctx->mmap_configuration == MAP_FAILED) {
>>>            trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
>>> +        error_setg(errp, "Unable to map eBPF configuration array");
>>>            return false;
>>>        }
>>>        ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
>>> @@ -61,6 +62,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
>>>                                       ctx->map_toeplitz_key, 0);
>>>        if (ctx->mmap_toeplitz_key == MAP_FAILED) {
>>>            trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
>>> +        error_setg(errp, "Unable to map eBPF toeplitz array");
>>>            goto toeplitz_fail;
>>>        }
>>>        ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
>>> @@ -68,6 +70,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
>>>                                       ctx->map_indirections_table, 0);
>>>        if (ctx->mmap_indirections_table == MAP_FAILED) {
>>>            trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
>>> +        error_setg(errp, "Unable to map eBPF indirection array");
>>
>> Aren't these trace_ebpf_error() calls redundant now?
> 
> Yes & no. Errors propagated up the call stack don't get included in
> any trace output, and so if a caller doesn't log them anywhere they
> can thus be invisible to someone just looking at trace output.
> 
> I could remove them all from the eBPF code though, and put a single
> trace event in the hw/net/virtio-net.c file instead ? Bit of a bike
> shed colouring exercise to decide which is best though.

No problem, I'm fine with this patch.

Note from experience (although pre-existing in this patch), trace
events can be very verbose, and a what makes them powerful is we
can filter particular ones. The following pattern isn't practical
to filter:

   trace_foo_error(const char *error_msg);

While a bit tedious to add, having a single trace event per error
is way more useful.

Regards,

Phil.

