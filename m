Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCA3C98305
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 21:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgrY0-00074C-3Z; Fri, 16 Jan 2026 16:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgrXf-0006wc-8A
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 16:39:43 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgrXd-0003nK-IO
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 16:39:39 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso16264385ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768599575; x=1769204375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+OXoxZ2yz8oyfYThqMVUMHPVV+vhIYYi6AFoyqRa9I=;
 b=CCXILDAnzKFvTQMg00PLWfTcEzL/0e3CDsZuWmJyW1jPJ5Qpbij0UG2r5W6ZQvuf1t
 Ta3iKGZ9l8sSzdS+ZFH1IOzAbkzgNuDy2RsHOYdOvSkRzldRczGpCemag4y4yNXF2FRP
 4gs3m6TxYs8H3CjifsybqEglg9EW0tIVxn2ScjLnF/tyEKnb337YU176eZVMB7gKDHZW
 UiM5Y+oA1UiaI7GnFhq8kLaJVRx3wawDA6kktYi/CjqdnxkCH6cfUVDUGi9un9DTQQft
 3AI8UOe84n2yjJKpd8cB8C+PA3o1xsYf//vYQH/5nOvAeSnbtQ8I6/evkejqPgUdJt2x
 NZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768599575; x=1769204375;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+OXoxZ2yz8oyfYThqMVUMHPVV+vhIYYi6AFoyqRa9I=;
 b=jEzbnqYYyZmfFo7UT1+6gi8Uk+ZSukcg1Rfxe2ZvouYbg+NX+ZIdpYfqgnZdeVjHV5
 za4QOmOOnc0qOu6bzb00IT63/yqQDdHDbnLUEC7sCDGvPQVPFyHIJKJHdlcOFoRfM0kj
 VWpO6PA6P7sko/hYuxuD5H/QJwTPcKxQIayk0+XA56fIP1GTGkwtapm36Y+y7rOU06PU
 MtB7pW4nPuCBAezGFHK317KI0fcUF00oCpXE8gtD9suJThDYryupM4qhf8zc9j0o7coq
 +1O36X4p9cpu5Qpshn0gnWBVxiX2tQJbVB5LKK3HdWJXwIxpLak+BYHvDcK1kRCsO6EK
 fYLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg4NoreKZdQGDgFsKMZrSq0Rav1o/XasZWGe822NhGjYpiVarZ+JmcJPPWAK8TR9dKM5LfoTNwtF/2@nongnu.org
X-Gm-Message-State: AOJu0YwZxxNA5FbCfWTrowtOEVzG1o99UcthHzI2Mt1oEXMBhEBz+eVx
 pUuQWG0qRnudJr+fG9dQKOEyNFOabq9biIOYncim8uoIoE5l4acfQdkzlwEQ7DWO4Vk=
X-Gm-Gg: AY/fxX7mWgMltBtzCJ8BMtXD7z4fL9DpfZt6adNBW4ELzvvTPtkjPHUsCYbzZsU6ibJ
 KfQvfgOwUQ4JLxykMQhW3w74K0Gr+fBG3KB0gJ94uGPE7W6yS0rm89qVZWlx19Rm2us3YHWHp8j
 FyqImkc07O7VllA6OTH0rtzl4spVX5ljI0F7FkMz3YS2yrZdTmeA5x+Qy3DJlCersNUweToyHGv
 GaXXE6OszQHBsMGJqJWlXjkEuhDf/U1gkSgYiHZKni0plT/b+JXYufs4AwJnRxaL0p1HHzm0JeT
 gZGIHzy/GSnv0XgGNWcvYpqxRT4efxKUgB/hdSy/hf0nxu9QU99xeQJa1RRle74WHrC8iJ9wfP2
 z95byVlhhrtlzbXHVF+Esg2o4HAN2y27zzYMOIyc34NB7G3O0iXLpT9Lc76dIFmLlOznse1Sokj
 4j6TUwlQcOZEbiuFbFz0ee0/DYI8xlMVZZ+npaQ5iXzNeFM6/P8xqZqBUcWmAcU7jEW5s=
X-Received: by 2002:a17:903:2ac4:b0:2a1:2b5f:d16b with SMTP id
 d9443c01a7336-2a7175cc0bbmr37222915ad.31.1768599574898; 
 Fri, 16 Jan 2026 13:39:34 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm29258415ad.56.2026.01.16.13.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 13:39:34 -0800 (PST)
Message-ID: <3d9c9fbe-711c-4be1-84f6-5fa3cc18d2a8@linaro.org>
Date: Fri, 16 Jan 2026 13:39:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: correct docstring for write_register API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
 <0d32ba74-9171-425d-ac0e-1303d6ca154a@linaro.org>
 <0458a52c-b86b-43e8-84f6-ec75b012a9a2@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <0458a52c-b86b-43e8-84f6-ec75b012a9a2@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/16/26 10:48 AM, Florian Hofhammer wrote:
> On 16/01/2026 19:24, Pierrick Bouvier wrote:
> 
>> In practice, it may return anything else than 0 (see arm_cpu_gdb_write_register for instance).
>> So the right (vague) description should be:
>> On success returns 0.
> 
> Hmm, it seems to me as if the code is a bit inconsistent here: the
> plugin API in plugins/api.c returns -1 if it detects an error directly,
> and the arm_cpu_gdb_write_register() (but it's similar for other archs,
> e.g., x86_cpu_gdb_write_register()) returns 0 if the register is unknown
> and the number of bytes written otherwise (in the arm example: 4 for the
> general-purpose registers).
> That means that currently, both -1 and 0 as return value indicate an
> error.
> 
> Thanks for the catch, that made me dig into the actual gdbstub code a
> bit more!
>

Indeed, same for me. I've been reading too quick when answering through 
your first email, and missed the nuance.

> In order to make this consistent, there are two options I see:
> 1) Change the plugin API function to return 0 on error (but then it's
> inconsistent with the qemu_plugin_read_register() function which returns
> -1 on error), or
> 2) Change the arch-specific gdbstub functions to return -1 on error
> instead of 0.
> 
> What do you think? I'd be happy to prepare a patch for either option.>

For sake of consistency, we should make this use the same interface than
{read,write}_memory_vaddr, minus the len param.
bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
bool qemu_plugin_write_memory_vaddr(uint64_t addr,
                                    GByteArray *data);

So it would be:
bool qemu_plugin_read_register(uint64_t addr, GByteArray *data);
bool qemu_plugin_write_register(uint64_t addr, GByteArray *data);

This is better and unambiguous, as no one needs a documentation to know 
what a bool return is, and data already holds the size information.

As well, writing this, I realized that existing write_register is broken 
by design: we never check the size of data array (except > 1) and 
blindly an arbitrary amount of memory from it, which is wrong.
Even though the doc mentions it, we should just fix it, detect when size 
< reg_size, and return false.

This comes from the fact gdb_write_register itself has no notion of size 
and trust the pointer. so it would need another refactor also. And while 
at it, change gdb_{read,write}_register definition to return bool also.

> Best regards,
> Florian

I think it pushes a lot of changes just for a simple comment change, so 
I would understand if you don't want to do this whole refactoring beyond 
plugins interface. I can pick it up, or let you work on it if you have 
time/interest. Feel free to let us know.

In all cases, thank you for pointing this.

Regards,
Pierrick

