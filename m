Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDFCC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 17:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFUJ-0001Fm-Vc; Thu, 06 Mar 2025 12:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqFUI-0001C3-LW
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:58:26 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqFUG-0007tO-Dn
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:58:26 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bcf9612f4so8408075e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 09:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741283900; x=1741888700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9VwvtDnWxxWjHWm12aZwqWQ/LW3Ynbl8TGhwNxgYLB4=;
 b=F2vFOvFSt60nws5V6CUEnCDI5qHOGE1bXs/sBbwFbIQKT5fBa1OWBZ9+Rp2PTgY8FL
 8wqhf+JrlTDV6p6p5DcKYGyvMYICchatuM8R1ET6MY7VIgAFSpJ5uGspZUfBOlwi+Uiy
 7PslKB7mx5nDq6+j/52ToyPdsh2TbuhvWYkgAULWkSp3jYonkB3nBuebxWvfHD+xKQyG
 aLs4dtj5ozwU0twupo5lKbh1TrpOx+6AE/JsatvXaUs184ZTLF0ZcOWcO8yOgS0szyKE
 YlWJEl4PKaguWDGOnAm4CHYS4SG3ol5ptIPfDJktU0w8QXENiboOEQeeZntL5jR2QpVt
 hpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741283900; x=1741888700;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9VwvtDnWxxWjHWm12aZwqWQ/LW3Ynbl8TGhwNxgYLB4=;
 b=u0XiEKdP4DVrnu0Mjw0G6P36HqVyYGR0Dc5S6CceZHu0Ub3x1+2x/DNQrCHRHuJxqm
 /lkGJ1hFGc/N3Lny4D2Icx6t+jmFzFItveppkUU2RRatvqww2Lssqqe2w+EmPEQmnOpM
 /Ov6IseQzby3/wlvUwRT6/KnCRLIIQanoU/Z/KyfH3DxOzO8XpbXWlkJRf/W1ctnOQ3J
 XnF7jv5kg4a68maqJoB9bx0O4qeA2hWmVV8h8wymPauqsOnf53OWTmlC6QciNR39Rb3w
 YPpt0bKtbxzJxEDRdyg2XKZfvy6EplhjnsqSihKIhDxENa6OS1fNvaFpNt1w8KxYikxA
 DISg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaSeqIkaOo6BIP99rlXO4XgoVDsK2+rv+KZru0j9oTBBiAq55usOQRO3lEiBuVI3qwMarSUAuqU/8C@nongnu.org
X-Gm-Message-State: AOJu0YxXGvWLtLPsyr6DiROJ5D8dCicMOuMdCIQL40ge1pbJ0SjF+VxI
 ex/SHT2TXI6G7mGaGKxqGFNO7/OrWty4Dxr1f91jF+OE0oyLMy1GJBCgHfVSjpU=
X-Gm-Gg: ASbGncurNXWzIHozk8+xw3xYmPLbYwo7bamz0qnIKmjCVwtYCkx6n7+Diz1sXHmN+j6
 1Ye6/C1P5MoEZEGJxvcMblLhfnfEWuPq278nHdP6w43a9ibPJmN/AwgpYvR1ZN6J756MW87nLp+
 UNiofKL78vF6Wwp+YW3fx7VTZNNVuAns1EFylJIg6gyFehXTy0nYJV6w4uSNAXMVTxr6MzM+Cyc
 3rmlenww8V61H7fP3JlMHYrFC6Pe9UEJ1bAuUbzRaUe1xYygD4gxSwk3TiWKIQyR09gu6pduIb3
 HLAzyJ+oCWfC3kbckyJ0vBWgHzYNUXGrJW8bZjyA1tGR+jVkNbcJ/u+0/CPCvmgSAjLPfXcD4gB
 LwLdS0E405pVT
X-Google-Smtp-Source: AGHT+IEOGtBDdAD18sfYjElHHabFYEAK4hG9FCCt8OtBHu6CQyPWoFisVCQvxBYwOeMEWSSxRTHC6w==
X-Received: by 2002:a05:600c:1d24:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-43c5a63023dmr3243295e9.3.1741283900253; 
 Thu, 06 Mar 2025 09:58:20 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435300esm56599785e9.29.2025.03.06.09.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 09:58:19 -0800 (PST)
Message-ID: <d62743f5-ca79-47c0-a72b-c36308574bdd@linaro.org>
Date: Thu, 6 Mar 2025 18:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/hyperv/syndbg: common compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-6-pierrick.bouvier@linaro.org>
 <353b36fd-2265-43c3-8072-3055e5bd7057@linaro.org>
 <35c2c7a5-5b12-4c21-a40a-375caae60d0c@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <35c2c7a5-5b12-4c21-a40a-375caae60d0c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 6/3/25 17:23, Pierrick Bouvier wrote:
> On 3/6/25 08:19, Richard Henderson wrote:
>> On 3/5/25 22:41, Pierrick Bouvier wrote:
>>> Replace TARGET_PAGE.* by runtime calls
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    hw/hyperv/syndbg.c    | 7 ++++---
>>>    hw/hyperv/meson.build | 2 +-
>>>    2 files changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
>>> index d3e39170772..f9382202ed3 100644
>>> --- a/hw/hyperv/syndbg.c
>>> +++ b/hw/hyperv/syndbg.c
>>> @@ -14,7 +14,7 @@
>>>    #include "migration/vmstate.h"
>>>    #include "hw/qdev-properties.h"
>>>    #include "hw/loader.h"
>>> -#include "cpu.h"
>>> +#include "exec/target_page.h"
>>>    #include "hw/hyperv/hyperv.h"
>>>    #include "hw/hyperv/vmbus-bridge.h"
>>>    #include "hw/hyperv/hyperv-proto.h"
>>> @@ -188,7 +188,8 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, 
>>> uint64_t outgpa,
>>>                                    uint64_t timeout, uint32_t 
>>> *retrieved_count)
>>>    {
>>>        uint16_t ret;
>>> -    uint8_t data_buf[TARGET_PAGE_SIZE - UDP_PKT_HEADER_SIZE];
>>> +    const size_t buf_size = qemu_target_page_size() - 
>>> UDP_PKT_HEADER_SIZE;
>>> +    uint8_t *data_buf = g_alloca(buf_size);
>>>        hwaddr out_len;
>>>        void *out_data;
>>>        ssize_t recv_byte_count;
>>
>> We've purged the code base of VLAs, and those are preferable to alloca.
>> Just use g_malloc and g_autofree.
>>
> 
> I hesitated, due to potential performance considerations for people 
> reviewing the patch. I'll switch to heap based storage.

OTOH hyperv is x86-only, so we could do:

#define BUFSZ (4 * KiB)

handle_recv_msg()
{
   uint8_t data_buf[BUFSZ - UDP_PKT_HEADER_SIZE];
   ...

hv_syndbg_class_init()
{
   assert(BUFSZ > qemu_target_page_size());
   ...

and call it a day.

