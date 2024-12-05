Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AB6E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFld-0006HL-SW; Thu, 05 Dec 2024 12:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFlc-0006Gj-4K
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:35:56 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFla-0004AF-I6
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:35:55 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-215ac560292so12198985ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733420153; x=1734024953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Td0DZml5st5pFBZI4ZJuzH63i/pRhQ7OVJNuCDCCJo=;
 b=Neyd2PEIASHQ+/0wjPIFaUobhB9+nY3Af8yOIjjmoLUOveXYbEuqCvt7AjAbml0kbK
 whM4w8WXJhbtrrb8b7OgLGcdlAImOIqBao7r4aEt3pZSYXtRvOKVNus3zpTLx9ktmGji
 LF/45V0xOqKshtxY2TBVMfgOfkpE5STa6FuGFIu918YGW4P6BhWE3+U09qFjCckdUIc/
 PO4u92NyzdFI3edNpzH+9u8AfdMgC20CZNn8CncDRb3/Da3EuhecV1LGa10NvHuaINSB
 NVSIn+XWiuJfwDDH+dFz3WwKZ5iYd/mo7LMt3AMLSYizs2zLt2LcjParyTkoSivGzlL3
 iObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733420153; x=1734024953;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Td0DZml5st5pFBZI4ZJuzH63i/pRhQ7OVJNuCDCCJo=;
 b=CS3emXwUuEr6bOj/dNHsZAt2XJnqhR0O7OHiXt2N7FsFAqRYLJLTEPIHg23q1KfyAS
 ACJqDu9le57LsmBbjprubU6hob0keMgIgP1zqQvAR0PiCKSoZ+GvyIw4LXYQ64n/eoFO
 OM35m6XU27EoHEtrcel6QihzTvQkcB4vZrNx/GlcacmbgqvcVf2kGh5twrEpTBvp6kDk
 bmQRVJFlNusxytWcrl+tMaPgDc5SN48W7Pxp/SgwRgJHbUfJPyHS+jdoA9U3Z5mQIaky
 HRk2NiIbrZGd8BwsjEBPA0EK8AYjPD6yJ50CcV0rdoXJPKIGOLv96W49WZBCARwH+EYf
 3fdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUbws+O1rDZK9BIHffn83TyO11uEnZcVt5am0hSX+vpjSoa7PCdox2PKwcjKVIkFOhUe+c/KumaYwR@nongnu.org
X-Gm-Message-State: AOJu0YzwrAok14Xi6eDYSghftVch+9OG4UR+po9QYm/G70abD5iuVjTt
 jdAiGei1nee47wfCpUSHIWrLwhxcs68jBc8i2gw2vYvmpY0ldWGvASz6XG9na/k=
X-Gm-Gg: ASbGnctkJg5cdMeYE4gADnS992Y885ZPGGG3PUBLholab9v55X/qfqscf8PN2qOIAIt
 7PXI17/vQzvDtrDumbGDNsewFOjQk1WJz2CnBi0QNBw5pOASK58AnR5Tp16EkwH0Th94V7S/iVb
 e+KNO1Q2XfqV59yPXkjW7m1OK1/ISvlR8KdqnYPHcQB2K3XUIb/plYW4/eRt0B6Z+hUtsTb6uHm
 9OgXQmphlYJj7uSFrOzQiUEqmhO2IThIxB584wW/+ThuLpSmzT0cQ8cMwakEGaHqzccFxFDCz2U
 30sO1X0wYl0c3KHJRv5AQg==
X-Google-Smtp-Source: AGHT+IFIgRbcyLRKO6hR9+7rz+4M5tS472HlgqsvjjNmRpAgpA5VOaW4W24GRUfzSFw05HZ09Q5kiQ==
X-Received: by 2002:a17:902:c412:b0:20c:9821:69af with SMTP id
 d9443c01a7336-215bd11cb7dmr123963295ad.45.1733420152833; 
 Thu, 05 Dec 2024 09:35:52 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6490sm1532689b3a.147.2024.12.05.09.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 09:35:52 -0800 (PST)
Message-ID: <c8b34d17-a619-456b-8f6c-ffe0cee027e3@linaro.org>
Date: Thu, 5 Dec 2024 09:35:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <6f182c71-2600-4bbf-ab4c-985ed7e99f71@linaro.org>
 <67c879bcd5520d6f7bdf30b5f773436678ca8df7@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <67c879bcd5520d6f7bdf30b5f773436678ca8df7@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/5/24 04:44, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 4, 2024 at 11:45 PM, "Pierrick Bouvier" wrote:
>> On 12/2/24 11:26, Julian Ganz wrote:
>>>   include/qemu/plugin.h | 1 +
>>>   include/qemu/qemu-plugin.h | 43 ++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 44 insertions(+)
>>>   diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>>>   index 9726a9ebf3..27a176b631 100644
>>>   --- a/include/qemu/plugin.h
>>>   +++ b/include/qemu/plugin.h
> <snip>
>>> +
>>>   +/**
>>>   + * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
>>>   + * @vcpu_index: the current vcpu context
>>>   + * @type: the type of discontinuity
>>>   + * @from_pc: the source of the discontinuity, e.g. the PC before the
>>>   + * transition
>>>   + * @to_pc: the PC pointing to the next instruction to be executed
>>>   + *
>>>
>> Missing those parameters when building doc.
>> include/qemu/qemu-plugin.h:198: warning: Function parameter or member 'id' not described in 'qemu_plugin_vcpu_discon_cb_t'
>> include/qemu/qemu-plugin.h:289: warning: Function parameter or member 'type' not described in 'qemu_plugin_register_vcpu_discon_cb'
>> 2 warnings as Errors
> 
> Yes, I forgot about id. But type is clearly documented. Maybe the tool
> is confused about the name and thinks it's a reserved word or something?
> In that case I better change that to something else.
> 

The type (qemu_plugin_discon_type) is documented, but the parameter 
"type" is not. Even if the name is correctly chosen, you still need to 
make it appear in the doc.

> And note to self: also test-biuld the docs next time.
> 

I was bitten by this too when I started contributing to plugins, so no 
worries. It's safer to keep the docs enabled (that's the configure 
default), even if it adds some latency to the build, especially when 
touching documented headers.

> Regards,
> Julian Ganz


