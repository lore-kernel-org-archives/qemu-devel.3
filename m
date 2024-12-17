Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27D1E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 21:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNfHk-0004bl-EH; Tue, 17 Dec 2024 16:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNfHj-0004bd-LU
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:39:19 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNfHh-000688-Oa
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:39:19 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2167141dfa1so1179285ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 13:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734471554; x=1735076354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bPeblPk2kcc3zCgg24pS0UuLC6a6t7ErBzoE7lpwySA=;
 b=rqHj9TTDMgVWuuWobkFxwiVSvHj5IPHElYhQoKeCHs1gIgnbcprFBGXDhRee5k/9xx
 Xa5xQ8DqHr5pmgHc5A+e5H04Iq/LbGUG35fhQ/Gg3dyBbPjL+Hcf03/SsDV/ooELy3XE
 pzGWzEuIqaQPN4W2WT0ZTHBjF2/1kCKlFXQVMjKbVxsG3M5Yiio8yZeyCqb/A0LOcP38
 9C0anmn7azGfj3YqLfu9gcwrvt+x2GwFey7pdONuwOOki/mjnBRAYUdY3ZnfhSRg65mE
 ZWqwZox8Mi89DDJiiHCnOlKHuVjZhkqhS2fflflNJhLfY7UK26nnVWHlpDtgRfAECMy8
 eo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734471554; x=1735076354;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bPeblPk2kcc3zCgg24pS0UuLC6a6t7ErBzoE7lpwySA=;
 b=nz6SActvUQuYxeTEZflkj8xmfK8adNOgc5lJA8pWUFSsqw8ZOgFWQ9NlTSI+CE67w+
 X3DU8hcy7vYrUgAoOHi2hCvqGjaA7oQ2LkTznwNcackADSRbzrQj10ORAqEtxODwLQnv
 ScKsIMkfUdvTzgAaF/X3zePSDukerK4CEJ3dJfy3rvvL2SxBFyz87QrjDkZolGczy33F
 Uj/Jxh3z8133rQ3mWtQYzGIA057z72JTNEi0ArYR9A5NPCP+y7a7VCwju/u2qtOAJ1A+
 A4iGu5v2bxewVwuWzS2/vm4fyjOxtsGk/n6S1z7taESvLFlUrJYbkKIUUCfrkXgSEvxl
 ueww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAYYNxpSeGzB8RVPBz5XzoF0+ApNDoq1pkxOt+J6iPefvjZ/gt9+1awi10d8qT1VpRg34cV/B9XDCL@nongnu.org
X-Gm-Message-State: AOJu0YymnKxzuaIfQdsxKkjMIFz4QHl6VzrHMHNb96Sert1RKhZerGmY
 iDKoJQEs6sw/MQZrqMr/MNTGRH3kKIBA6gZOl1QVf0Uhy1st80w4rQvkxZE/kpU=
X-Gm-Gg: ASbGncvDvb/Nw2uAB6QZIZkXau2TysGKxIsqfGlJyb27lYiYvf8XtfZIMxBKXycizOe
 p+GAKamSADuRU2jZ9nqhu3f0WfHDMiZHYJGJl3PhSlqDIpJu1IBYYcik99OBsvC8HhUcjjjJ0Xv
 pudzDeM1gI5sxooOO6lNgmQ3UzDVIfGowBZXXY0K1Y8+q04dbwxHelOP0BeSM/TTv90VfvxwPTn
 W1rrp34cwV3F+VW7CGOUwIayjTKWyWf2QTTGQ/1rgFMMjkR2O7SUtNBDF+nsv/64eRIgw==
X-Google-Smtp-Source: AGHT+IEnaJs7Fi+mZnsA1aSrjGXP2ZvgzaPc/joqpdzRA24w15IvBwX+tOCUjWKS0njmDi0RL3/ZvQ==
X-Received: by 2002:a17:902:c942:b0:216:14fb:d277 with SMTP id
 d9443c01a7336-218c92678d8mr73664865ad.22.1734471554253; 
 Tue, 17 Dec 2024 13:39:14 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5a90684sm6285592a12.8.2024.12.17.13.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 13:39:13 -0800 (PST)
Message-ID: <9293a180-a96d-4e6b-b9be-93afb39b7767@linaro.org>
Date: Tue, 17 Dec 2024 13:39:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] plugins: change signature of qemu_plugin_insn_haddr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-2-pierrick.bouvier@linaro.org>
 <1eebfbf0-e26f-48ba-8e31-b9f908118270@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1eebfbf0-e26f-48ba-8e31-b9f908118270@linaro.org>
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

On 12/17/24 06:41, Richard Henderson wrote:
> On 12/16/24 19:06, Pierrick Bouvier wrote:
>> It makes more sense to return the same type than qemu_plugin_insn_vaddr.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/qemu/qemu-plugin.h |  2 +-
>>    plugins/api.c              | 12 ++++++------
>>    2 files changed, 7 insertions(+), 7 deletions(-)
> 
> No, it does not.
> 
> qemu_plugin_insn_vaddr is returning a guest virtual address.
> qemu_plugin_insn_haddr is returning a host address.
> 
> I'm not sure why we decided that returning a host pointer was a good idea.  Probably it
> was the easiest thing to retrieve from softmmu.
>

When looking at the implementation of qemu_plugin_insn_haddr, I was a 
bit surprised to see that we return the host pointer indeed. So, I 
thought that returning a uint64_t would act as an "opaque" handle in itself.

The only usage in plugins we have is for cache plugin, to ensure it does 
instrument the same instruction only once, even though it's translated 
several times, or from different virtual addresses.

> One could argue that we should be returning something else, the only question is what.
> 
> Perhaps guest physical address, which wasn't possible before, but which is now stored
> within CPUTLBEntryFull. Interpreting this requires you to know the physical address space
> to which it applies. In the case of Arm, the address space varies depending on Secure vs
> Non-Secure state.
> 
> Perhaps ram_addr_t, which is *not* a guest physical address because it is not associated
> with any address space. It is more of a globally unique token with which a RAMBlock may be
> found.  It's how we stitch together address spaces under the hood.  The plugin would have
> to treat it as an opaque unique identifier.
> 

I'm not sure I want to open this as part of this series, as there will 
probably be corner cases and debates, while the goal here is just to 
compile for 32-bit platforms.

> But if we're going to return a host address, then void* is the correct type.
>

I'll stick to void * then.

> 
> r~

Thanks,
Pierrick

