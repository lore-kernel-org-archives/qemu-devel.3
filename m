Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21981C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTj5-0001MR-9f; Mon, 26 May 2025 05:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJTiq-0001Ih-Go
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:02:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJTio-0000Jc-NV
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:02:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so26648115e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748250132; x=1748854932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+COapwU08PssNtERgLXksu9oJt/Nq3jGVqqntcNsdQ=;
 b=q7DjVjZUR8I5t8ksW1S0zpf2Lrqff5/OzZ7ahpmd/HxE8OsqR00dREmKbVZlUHmrOj
 odbXZcM9EPdQQpOGXANMEi6+X0T9E1G6lyNeHiGUkIu0W88EtidLYpeGlyM5bqm9+yvn
 U7szWyK6wleY0F2aYdFE5jMkZ3O8r/tEqzTIML4C6eE8KvyqHD6N45d+2vmXdPkw2HLQ
 fHnis3YYlLYjsaDh/KDWfnDny62rX5hk2PoXgH7yODrZMhN3Te57e7SndJnCW34nA1O4
 dtaAxZ9A/9ZJGdMw9BSM5sy72PC9syrmL9dJKg4K9b6TGLhTohdpwBRMzaI6ui9hoHp9
 FnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748250132; x=1748854932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+COapwU08PssNtERgLXksu9oJt/Nq3jGVqqntcNsdQ=;
 b=aOOAbUHs0iFMT7Xq1VWmQ1vTl01itQG9/plXTtYuQQsHwsIsq0SpS0NlLqsUoy309d
 EX2FFq8RbH0z2A5iDJDpcJ1fCs6wSKRdeZrrY7QMNhsbM3klRzojIkVjS2O46GKRn9kJ
 EvoepCY9kRhND14xHFR8qXIZ7lJ8Q8fCRJsjqxYCG2ElI4ga4HgkQKtstCCz+nHMNBXv
 AU01tM8ddLQS3nrfz8YS69Q9HsyL3TQOGk89z7f3Pyd6kRbPDnzmzXnk8pYRNsIvWhVn
 pd6UY7dTfGo3ARSMkD7o+cJ0ckq7UpDBac8iKryTg/YdRMeDaIH/zm6B71+rY1v957qr
 tKNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrtuAdube1U64xzjAfL+YVhFpTRFbAhHVOJnF6X9T4SSJTchA943eYyoVusPbI9yKlqV4n3xPimOs1@nongnu.org
X-Gm-Message-State: AOJu0Yz8iYjvZWv5jQ6T7sINWyE63uccaJSuoUx3OYVC8dhNw5RjjIek
 n+uyaWrwnSMOH9aJaWcIJxx+v6pGkXAvwX6oKLN6upW2pYKPpRJzKGttX7MaBFh+e+c=
X-Gm-Gg: ASbGnctqBxCtApiVH9pXw+IGCMcbzeq0VkW+8Q8cNu3iHjO6cP+E3ezM2afJqa6j1AX
 fvRkHGfN/cOYbwVI7jMvi8L5FZZAOfqR+4lYCeISaBw794lQsQ9Ia4g+xCV6dRjBoxXMgUaj8Av
 5bjxRSKIqiSbSOwY1Rt4mTxzAUZr/E0cS9aTZxHdmg2H32q8ZMVe3Nowi4VNyDEwH1MCs/hOUhQ
 JSXWpiZUyRo1rjkHW5ufSOkKTK6DWylFX5GsvL3J7DvEwg/vGYfIXb6C2u3BzEblVM5wu0VLnvh
 PxPPa8UlZzSGVKF1qDofAOmYrK/mfxSAfY7yDm0PEFD/TYRpRcfBxLVEzyCOR23kxw==
X-Google-Smtp-Source: AGHT+IFkTnypBOL72qljhMoWyNtwDmBWKrnxEdpnLxaT12tNPLaWdDiHyLg1Z2xBdIGwM1IQHOWp8Q==
X-Received: by 2002:a05:600c:1d0d:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-44c9160702fmr80806465e9.2.1748250132457; 
 Mon, 26 May 2025 02:02:12 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f24b6471sm231268445e9.24.2025.05.26.02.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:02:11 -0700 (PDT)
Message-ID: <aa7b7f19-648f-4ce8-911a-045173a5fa71@linaro.org>
Date: Mon, 26 May 2025 10:02:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/25] plugins: add hooks for new discontinuity related
 callbacks
To: Julian Ganz <neither@nut.email>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <70c5a0d487731b08e803240061a97bfc110bfbcb.1747666625.git.neither@nut.email>
 <edf78ed0-7ada-467e-86de-47e2515588bc@linaro.org>
 <20250525205645.4366-1-neither@nut.email>
 <ec6f71c19f2f000844e0767e6742e7de3213e023@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ec6f71c19f2f000844e0767e6742e7de3213e023@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 5/26/25 09:08, Julian Ganz wrote:
> May 25, 2025 at 10:56 PM, "Julian Ganz" wrote:
>> Richard Henderson wrote:
>>> On 5/19/25 16:19, Julian Ganz wrote:
>>>   +QEMU_DISABLE_CFI
>>>   +static void plugin_vcpu_cb__discon(CPUState *cpu,
>>>   + enum qemu_plugin_discon_type type,
>>>   + uint64_t from)
>>>   +{
>>>   + struct qemu_plugin_cb *cb, *next;
>>>   + enum qemu_plugin_event ev;
>>>   + uint64_t to = cpu->cc->get_pc(cpu);
>>>   +
>>>   + if (cpu->cpu_index < plugin.num_vcpus) {
>>>   + switch (type) {
>>>   + case QEMU_PLUGIN_DISCON_INTERRUPT:
>>>   + ev = QEMU_PLUGIN_EV_VCPU_INTERRUPT;
>>>   + break;
>>>   + case QEMU_PLUGIN_DISCON_EXCEPTION:
>>>   + ev = QEMU_PLUGIN_EV_VCPU_EXCEPTION;
>>>   + break;
>>>   + case QEMU_PLUGIN_DISCON_HOSTCALL:
>>>   + ev = QEMU_PLUGIN_EV_VCPU_HOSTCALL;
>>>   + break;
>>>   
>>>   No point passing in QEMU_PLUGIN_DISCON_* only to covert it to QEMU_PLUGIN_EV_*.
>>>
>> It easily looks that way, and I myself stubled upon this at least one or two
>> times, but `type` is the enum we pass to the callback a few lines down and part
>> of the public plugin API. `ev` on the other hand is the offset in the `cb_list`.
>> So some translation is neccessary, unfortunately.
> 
> I just realized that you probably meant that we should pass ev as a
> parameter to plugin_vcpu_cb__discon. This we can obviously do.

Yes, that's what I meant.

r~

