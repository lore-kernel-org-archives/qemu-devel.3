Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD80CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 05:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smnoJ-0008Ah-AA; Sat, 07 Sep 2024 01:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnoH-0008AD-NI
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:16:33 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnoF-0007vb-T6
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:16:33 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374c6187b6eso1528710f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 22:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725686189; x=1726290989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G+Reo3JPGTpw0VlFUCvaXA+sF/OpZMFOwWYFO6iN5vI=;
 b=xPwvNluJAeN7mVvU2L+HWyqaPy3ypQspQlgxHzGXEktArmQkfrBt3tnE3S+8OhznyA
 c8cFvompVAMphZ8EHvpwaYE/1U8SRvLctqpiC/HUY+R5MyuD9NxBggY4+S8/e3KyNW1J
 1Y7t6ukYyyazV1fA5a+pCADrQBVggJnd93TQlWvqAWM+4rQvX0aC1BF9sxtV1uBohrJ/
 1sXZhTD6J8otiKA1sr4rhYP1Q9vce9iwjSHoIvRFYsQrS84eKeWP86JqWnvMcOTN8pEm
 a7bye8K3LAqiLYvNedzJQrql7/z23Aqai0EHLlYul9OyUDkNV2dNUwD0z6oqjxM1bLLM
 9Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725686189; x=1726290989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+Reo3JPGTpw0VlFUCvaXA+sF/OpZMFOwWYFO6iN5vI=;
 b=aq1ggBZn5/4Kqeon+Ah2l7yyzaGDxMVGSRjX5aD9y19K4+639FfpVy3cZfsblms6I8
 ZPQKshRdgl9OfKnBChDcuwa8nCC9WUjaXS5GgesrQu3oob8CuzhSQEmO7VAFlqQ0muXt
 xs0ucFNdqrFjUy+vgQxRLRXqjbwtxY0MFKE/7v0ldMisN9VhX5EybuyeyHF64qkRYNVF
 cj0DjKBuNFVn5dGvdkwBPNset+EUSLzrkAgNOu7p68P5jymyLq0PvfpoFNSHJMACXZt0
 JsTLs6NIb1MNZJmf83Q9cvOLoI5ZEkRt2H5QfQJCv/EUqMbJXsE0tgFIo0TwSqsLOHyV
 IL1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQtVNYicj/5rgGTr8uWzmUAEgsReREoz9f44OCyGYUlEP7ZiBNaj6bGhEau3Uza/iQM407215isGWR@nongnu.org
X-Gm-Message-State: AOJu0Yzw+iuBYq0bqktQS/oEbnajsDQLRTfZN3f1gcUr+SuZn8zFQmJ4
 4W9ZVZH4HGGSie7oi+vt+l52QAHJGWpHfJ4QCO1LI7ZclD64DAkh9eQOBY5kplo=
X-Google-Smtp-Source: AGHT+IFG+TMWwOFkXmzgV5coF0eUGx0rWYvOpJPEqormIPeAn9OrVmYrvnDu70+yXnbKdplY/uynag==
X-Received: by 2002:a5d:46ca:0:b0:377:9867:9028 with SMTP id
 ffacd0b85a97d-3788967aaffmr2781898f8f.44.1725686188741; 
 Fri, 06 Sep 2024 22:16:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835abbsm29122966b.9.2024.09.06.22.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 22:16:28 -0700 (PDT)
Message-ID: <be2b7849-6e38-414a-9812-f91454d63300@linaro.org>
Date: Sat, 7 Sep 2024 07:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] escc: convert Sun mouse to use QemuInputHandler
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, chauser@pullman.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20240904102301.175706-1-mark.cave-ayland@ilande.co.uk>
 <e828e000-664e-48af-ae33-6e323e28d167@linaro.org>
 <6317769b-2d90-4c72-a3fb-1de88f6dda6c@ilande.co.uk>
 <77003778-0917-4326-ba95-3034316263c9@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <77003778-0917-4326-ba95-3034316263c9@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/9/24 22:55, Mark Cave-Ayland wrote:
> On 04/09/2024 12:19, Mark Cave-Ayland wrote:
> 
>> On 04/09/2024 11:53, Philippe Mathieu-Daudé wrote:
>>
>>> On 4/9/24 12:23, Mark Cave-Ayland wrote:
>>>> Update the Sun mouse implementation to use QemuInputHandler instead 
>>>> of the
>>>> legacy qemu_add_mouse_event_handler() function.
>>>>
>>>> Note that this conversion adds extra sunmouse_* members to 
>>>> ESCCChannelState
>>>> but they are not added to the migration stream (similar to the Sun 
>>>> keyboard
>>>> members). If this were desired in future, the Sun devices should be 
>>>> split
>>>> into separate devices and added to the migration stream there instead.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2518
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> On v3 there is also an implicit:
>>> Tested-by: Carl Hauser <chauser@pullman.com>
>>
>> That's true, although I'm hesitant to add such a tag without a nod 
>> from the tester. Carl, are you happy for me to add your Tested-by tag 
>> upon merge?
> 
> I've received confirmation off-list that Carl is happy with the above 
> tag, so we're good to add it to the final merged version. Phil, are you 
> able to queue this in your next PR or would you prefer me to send a 
> separate PR instead?

Patch queued, thanks!

>>>> ---
>>>>   hw/char/escc.c         | 88 
>>>> +++++++++++++++++++++++++++++++-----------
>>>>   include/hw/char/escc.h |  3 ++
>>>>   2 files changed, 69 insertions(+), 22 deletions(-)


