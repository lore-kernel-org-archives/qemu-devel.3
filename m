Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8865EC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkj4Q-0001YR-EV; Fri, 17 Jul 2026 09:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkj4O-0001Xj-M1
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkj4N-0003BY-7s
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784296658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zcX2252eS8e714fJbZOpfkNV3KKpKJ5LTDzul03GN9Q=;
 b=UMyh54HmW+VeWK9TVLlMkz4OjAICble/dbT2vPJ1A3tN1Puhbv9tNyHZL5uSzEL/KLrYSm
 ZHAhwfVWp5pGuNcHILhY6Q6EVDACOQ0bOGmCU2mVpJaFWW/R5c98ytzL+DTC9qbbX+W7Pp
 quMQbv/C7Jam0C5dXWPx2JifY1Y234M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-oeBZXzNhP_qypW6mr8UB_Q-1; Fri, 17 Jul 2026 09:57:36 -0400
X-MC-Unique: oeBZXzNhP_qypW6mr8UB_Q-1
X-Mimecast-MFC-AGG-ID: oeBZXzNhP_qypW6mr8UB_Q_1784296655
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4784d0fb9cfso3121128f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784296655; x=1784901455; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zcX2252eS8e714fJbZOpfkNV3KKpKJ5LTDzul03GN9Q=;
 b=m6Rt54sqH3HDjeQToviHSMOvDBc0aq6o3lGpok0XVugT6NN9nOs7CR/AU+oJQ7ABHV
 5SBySU64zTNN5ZxJq1q9Gdwe/KXpY2xCgIshLEbO6AokPdPEzYfnUcPKH61gx5f62iXK
 iba0ioAWdyCbfGo0gaY+cT9BAJTBFP0Xp6YsHha7or5xgQhUiAX5VvH/Cpvfzu8yFpGs
 VD7EU1NlX+cUt54C2wYTCUa1xfFUpMD10XN9Y73TjsbhdcYscgINCzPUFcghlV8zKVFk
 1ai4NLOZ0IzR60s3PEiAmnXNtp3Qq90cHhbrBV+vHwyfJ1WwZQztjSvi7WWa7XBJFQnn
 TC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296655; x=1784901455;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zcX2252eS8e714fJbZOpfkNV3KKpKJ5LTDzul03GN9Q=;
 b=ouo26E49U2QHW6RBWjHz9mOILrcPoc2Je+vGNqNjqmwW+lRyyUXJPCpmFcZmNR3TpP
 GXS8lJc4/0NVt+XVLqG6QE7ppiqe5IyWG7iJVYWfugQMCAZcXlZJo72s9vdY72w1xJP6
 nGOhHVf0QG/pkRQQncJ3jh6rl65gK0bSufgf4j92P7+ZamVWlSuErAoKxBuuhdkCSEJO
 KTNVAHVMDHcIihWbcE3J8otAwSRirdJT8iivq2oy0nwxy88/KpDn5zTdqqaov94RkRlk
 0//vEVDZBfaeoBGX54vLI2dxoa8l5asJK9pvE5vgV1/q3DpoFJtq5XGTaHdkUPsRFpio
 /ugg==
X-Gm-Message-State: AOJu0Yxhenzr6FHoHcHPb+2YLw5DJmoDr+57MtYu3k4sLWH7Oz968cQ/
 l+TNStbIuPlyvUEFGyHSUW1Qb0922VzdV/9sH72hHdOinC34Xco4vzEieg1ZR1xTYHDqCedW2Bo
 Sdav4Yt1M646H9UloC/DDaxuxjntY9traEcZcq/O1qHM7jB6RQIg7C0lP
X-Gm-Gg: AfdE7ckoHTNh5Lg9HGRYhD2ENKTzU2n9Zs+fqJeaxXR64arBrLZ+3MWA+r8Phos9Huw
 ZgK+uGo1UURHix2UfafCW3ja8JPPveEXFtVvNQF49C9s+XJMOuO9Up2cL12mRfkSPggbK6TtgYr
 x6gWnTpNxZI7qy5lBQxEDEuQoIoh2EhUaR0m/K1lWfzSMcAFna7SvnpsGO3HzLYOUXbUiRQCBVd
 0AA6/hFIpbmLW0k5Z2Jy4VdxJVJ1RrRiG+O5qy8g5Ke1WGXilTtOx00j8wr1Q9JBjLRKVrhsfj8
 VSL6LcQgvicZylUjh4ruRDBRD8tRsOjCAGguy2ic5BnF8E3G+cA5VTocdnGJPdcszsVuz1IrDA=
 =
X-Received: by 2002:a5d:5e8f:0:b0:47f:4893:d198 with SMTP id
 ffacd0b85a97d-47f6233ef03mr4384215f8f.56.1784296654976; 
 Fri, 17 Jul 2026 06:57:34 -0700 (PDT)
X-Received: by 2002:a5d:5e8f:0:b0:47f:4893:d198 with SMTP id
 ffacd0b85a97d-47f6233ef03mr4384175f8f.56.1784296654521; 
 Fri, 17 Jul 2026 06:57:34 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eddd27sm3920223f8f.28.2026.07.17.06.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:57:33 -0700 (PDT)
Message-ID: <e8e48554-35f9-44a4-99ef-f580c83d04c2@redhat.com>
Date: Fri, 17 Jul 2026 15:57:32 +0200
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
 <7cd279e6-f79b-40e5-94a2-610a60d57fdc@redhat.com>
 <CAFEAcA_9Ps1xWqnDan17D5uzxFKQ9g=r2pGRPjmHtubEbF4TCQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_9Ps1xWqnDan17D5uzxFKQ9g=r2pGRPjmHtubEbF4TCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 17/07/2026 15.48, Peter Maydell wrote:
> On Fri, 17 Jul 2026 at 14:13, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 17/07/2026 15.02, Peter Maydell wrote:
>>>
>>> This doesn't seem right. If we've told the core XHCI code that
>>> we only have one interrupt line, then it should not be calling
>>> this function for a nonexistent interrupt line.
>>>
>>> In xhci_event() we have code that (a) has a special case
>>> for numintrs == 1 that means all events go to interrupt 0,
>>> and (b) have a bounds check for an out of range interrupt number.
>>>
>>> It looks like the call path via the ERDP register write
>>> is missing an equivalent check.
>> Yes, the ERDP write is the critical code path. I can move the check to that
>> part of the code, fine for me! I'll send a v2...
> 
> In particular, looking at the xhci spec, the registers
> involved here are a set of registers for each interrupter,
> and the spec says that it's up to the implementation how
> many interrupters it has.
> 
> So I think that in xhci_runtime_read() and xhci_runtime_write()
> where we do:
>          int v = (reg - 0x20) / 0x20;
>          XHCIInterrupter *intr = &xhci->intr[v];
> 
> we should be checking v against xhci->numintrs, and make
> the access RAZ/WI if it's out of bounds. Compare
> 
> https://docs.amd.com/r/en-US/am011-versal-acap-trm/Port-Status-Control-Host-Interrupter-Event-Ring-and-Doorbell-Registers
> 
> which is an implementation of xhci with 4 interrupters: there are
> 4 registers of each type, not 16 (XHCI_MAXINTRS).
Yes, I agree, I was also just looking into my local copy of the xHCI spec 
and I came to the same conclusion.

  Thomas


