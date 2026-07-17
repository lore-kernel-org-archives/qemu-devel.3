Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B10BC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiO8-0003SE-0c; Fri, 17 Jul 2026 09:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkiO7-0003Ry-9J
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkiO5-0005NF-96
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784294036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xv4ZFl0FCCdV4zExj0hUAxtDSupY8BlDuwGzGHVbDmo=;
 b=K8fNTtpV4xRjXd+EuYbOH6FUMeNWUqLRK1RrszVfvQ1l0OjRs4yxz3a+Yndp1j7Uufacp6
 GMwg2glijrfz9ebEqyF30UjwU1EetCSwp1c3AapX/oYf9h974abPXzn+WFeOgJSo+xUV7J
 xrdOBfSSeMhcerFRcxG6oL9+cJ/RxLE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-GNOuosuGPHiaUvOuGBZipw-1; Fri, 17 Jul 2026 09:13:54 -0400
X-MC-Unique: GNOuosuGPHiaUvOuGBZipw-1
X-Mimecast-MFC-AGG-ID: GNOuosuGPHiaUvOuGBZipw_1784294033
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso2286973f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784294033; x=1784898833; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xv4ZFl0FCCdV4zExj0hUAxtDSupY8BlDuwGzGHVbDmo=;
 b=Ad1zggxCpQuzAtGOuymHh1zoqr7lEziV8/zcZaY27LDyFNPfFQFl3Isg+TP/XEdZv9
 VUQPAEj5CnUfw1a1cddLk34quzBVvEEs0Yt3JiqNlosVM/lQRozEJ5J3pb0goRiWDpI9
 e2EOtMez7iH+wumTCB88o7ecuEYHXP+EihWdKeMay0vzvr8qyQb+CQlEAjlzXHAhOuzd
 rZ2TX/ZnedIb9clBsz8+PgzlOoFRQ+HBDR2LGrqo8MA4nx1iEOmYwZUoenCImr4qSjYI
 u++gUyN8hB+KMg+RRymdVgdl9/Exr9UZQXoBoHahPzkF98dJ2YpFRoySK/Q1qFX/+p50
 eajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784294033; x=1784898833;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xv4ZFl0FCCdV4zExj0hUAxtDSupY8BlDuwGzGHVbDmo=;
 b=bX6te174peYvw/PzR1D1DsQJ6SdEtNU8K6c4I0Bun+yXc+zjvL+7QaL70oLsAuPf5/
 tmaopwGk+3rN7y6+DnN+AkTbvped/5VDHrj9vNPPkSO9llQIkMiZlHWXUz6MjPcDIX4p
 8xETcdA02Vn2dCAuO+7ZYdXd4n7cFfyY65EbOUxGp/FDqh+RLj9lZ11CQdt7O4OiAbfa
 1H8Lfb6IkD8/AzoFXp2UXcLWD30cnN0xLFv0ZdLWwMBYx6UD+iHpDdLU9IEygpn2MMDo
 jBcIgEVpOYC4varrTk1q6hwlMrhefQT2zfn6fzluDms5MjDuqKBjzhgZkqMibqYeOyY/
 7I+A==
X-Gm-Message-State: AOJu0Yw+RyV4qljvURd2oBUBd4rWTqrA32E1ZSUvru0a4uyutfPuT3zm
 FWkeQ6OPW2j4oxj5nMFO9MKn0y//jQnuqM4Hky/UnUcgmYjmAkb3TIcvbxVOVXb5I8U7KqsT3rO
 /B8CZgM41rrnoMBLFQqMUW0zqohaKQq0SOpFiQKP6GX7Z+RVbJ48ce/wn
X-Gm-Gg: AfdE7cmvDfiUd0yzjj2pRQaU6RJNkslWesfHNJKWQWiCbgp46k+shd1dZosofXp9S8y
 Lwr5tEA+itCCAknkl12/GSfIjYMR5h7K6stED0EHibFoYmsE8UCB9iiK5cja3fXbqVL1mOQHNar
 X1PEXpbZ1HmuLa6QvZohIgb8VmSAM8pGkfyhS7vjEDgB51sIGGliYOrI3z8PyOoZ+xMxsSzXbGJ
 7c7dOfG4ZOf+4/Bq2z00IZn9HL/LHlNpLJiiebNuXHMWZIXP5eX+hP18aeTMDVkzbHdo14pLreQ
 LPWaSV0++530Hesmp9xG9L2V8yTC3kF5XuuqP9HaYwy/EADY7+2IezZupWc=
X-Received: by 2002:a5d:5d09:0:b0:462:fdf2:3a50 with SMTP id
 ffacd0b85a97d-47f62326ddbmr3830350f8f.32.1784294033363; 
 Fri, 17 Jul 2026 06:13:53 -0700 (PDT)
X-Received: by 2002:a5d:5d09:0:b0:462:fdf2:3a50 with SMTP id
 ffacd0b85a97d-47f62326ddbmr3830296f8f.32.1784294032837; 
 Fri, 17 Jul 2026 06:13:52 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7f55sm3500889f8f.18.2026.07.17.06.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:13:51 -0700 (PDT)
Message-ID: <7cd279e6-f79b-40e5-94a2-610a60d57fdc@redhat.com>
Date: Fri, 17 Jul 2026 15:13:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-xhci-sysbus: Fix OOB heap access in
 xhci_sysbus_intr_raise()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
References: <20260717113006.172612-1-thuth@redhat.com>
 <CAFEAcA_0q+3fi406hhVaj-W6e+XgkAU0jACVQvAS5FnSUnq+fA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_0q+3fi406hhVaj-W6e+XgkAU0jACVQvAS5FnSUnq+fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 17/07/2026 15.02, Peter Maydell wrote:
> On Fri, 17 Jul 2026 at 12:30, Thomas Huth <thuth@redhat.com> wrote:
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Some machines like the microvm machine instantiate a "sysbus-xhci"
>> device with just 1 interrupt (by setting the "intrs" property to 1).
>> xhci_sysbus_realize() then only allocates the s->irq array with one
>> entry.
>>
>> Now the generic XHCI code has at least one code path that could call
>> the xhci_sysbus_intr_raise() function with n > 1, so this function
>> calls qemu_set_irq() with s->irq[n] pointing to a bad heap address.
>> The qemu_set_irq() then tries to call an IRQ handler via a function
>> pointer in that heap space - which either causes QEMU to die with
>> a segmentation fault (if it's a bad address), or even worse runs
>> some unexpected code if the destination of the pointer is executable
>> code.
>>
>> Fix the problem by checking for valid interrupt numbers before
>> calling qemu_set_irq().
>>
>> Fixes: CVE-2026-16043
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4001
>> Reported-by: Tristan Madani <tristan@talencesecurity.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/usb/hcd-xhci-sysbus.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
>> index 19664c5985e..7ab2f8527bd 100644
>> --- a/hw/usb/hcd-xhci-sysbus.c
>> +++ b/hw/usb/hcd-xhci-sysbus.c
>> @@ -8,6 +8,7 @@
>>    * SPDX-License-Identifier: GPL-2.0-or-later
>>    */
>>   #include "qemu/osdep.h"
>> +#include "qemu/log.h"
>>   #include "hw/core/qdev-properties.h"
>>   #include "migration/vmstate.h"
>>   #include "trace.h"
>> @@ -20,7 +21,12 @@ static bool xhci_sysbus_intr_raise(XHCIState *xhci, int n, bool level)
>>   {
>>       XHCISysbusState *s = container_of(xhci, XHCISysbusState, xhci);
>>
>> -    qemu_set_irq(s->irq[n], level);
>> +    if (n < xhci->numintrs) {
>> +        qemu_set_irq(s->irq[n], level);
>> +    } else {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "unexpected IRQ #%i raised on xhci\n", n);
> 
> This doesn't seem right. If we've told the core XHCI code that
> we only have one interrupt line, then it should not be calling
> this function for a nonexistent interrupt line.
> 
> In xhci_event() we have code that (a) has a special case
> for numintrs == 1 that means all events go to interrupt 0,
> and (b) have a bounds check for an out of range interrupt number.
> 
> It looks like the call path via the ERDP register write
> is missing an equivalent check.
Yes, the ERDP write is the critical code path. I can move the check to that 
part of the code, fine for me! I'll send a v2...

  Thomas


