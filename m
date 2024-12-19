Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E001E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKu2-0000cX-En; Thu, 19 Dec 2024 13:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOKtl-0000YM-FG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:05:22 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOKth-0006R1-MW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:05:19 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216401de828so10718835ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734631515; x=1735236315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5oxoJg6stzH73yFVleOT/i5mY4d4J+O66bVDqRJ6Feg=;
 b=EYNSRvpeeUrnP4zRgHjmQL5UokLqORTizBLSMSFQHsD9MPP/lbRJ2GsAiwUTx18XI+
 dgBg0JGAuh+k03c6N3IVpSpg++N/rdoKySFj2k2k/5ZWmxt9jofPXz7cePG200DWvfXd
 9ik9gxmgTBIlZp/gGiZHI++cQb+OTA9lnGD7CCe9DXbGk665xzIYg1vVadsLDsUwNzEP
 PvpJbCzS330ZmjBe9AeiwBLTUzRLGWE0ft05FVc8GlH2zA0vfWIZIw1GvIftNPat3HK0
 5qKT2DUb5FLwKHBzAB0qaMqBzn1kbIai754hiiLAidC5cxmkmvY/CkArdfZx3G8hx9MO
 KQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734631515; x=1735236315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5oxoJg6stzH73yFVleOT/i5mY4d4J+O66bVDqRJ6Feg=;
 b=WLihF5qPqSsPvNFIkPTaw2U1XzsaM4N6OxbBKbymNsUQDnjsVGxZTdVJpxzDk8lnDG
 qTnCSWmn12uDU4r/mthWk69h8WIBUea8OWp1pyg4cIf+JNMPc01fzoDa5KviuQptrrvb
 n4kzsuHkjk+0lzP8hEV//MRsHc+PH6DJpCDsPiypYk8W1o78GGQisWN06gmOC7AxjYW0
 zPJo3LdYYE7DkIRRB/GI94qWI3JSMkaZJ3Ogowiu/NGHld+2CftqpueaIbbZxz61URbE
 PN5MoWQXX/4+Y+w627n1i4FsMk/9eQrNyM1t7cMb/yZnQqPhESaam6Q3tm2DiTL9jlX0
 /ilg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLMbl2maD+Dn9iGaLMvAPsE/hiqikyhF5VxyFYPMtcSW6NAKR+c/3jvguuYZd66dicSayUNJiWhIn0@nongnu.org
X-Gm-Message-State: AOJu0YzIfC8L11LpPF97+5JaCEwv2aNzqMl0qmFa3VJ/sTSPn3JLhmKb
 onTBteVlgxWDQukZZpogaj7XfscAr/Ucmuey/4uCAlW/5JuS21c2Wf2zjXKThDUcNm4YvDLETlz
 Y7oLaew==
X-Gm-Gg: ASbGncvPw28H+t7uCPbFzF/PUDO6+X6imlut46hpNEywztm+6oT4NxS2JP7yeg5aQQY
 5xG6woy/a4zSif8UqQ4ovfdemNlo0Tqq1av4uMM+dyhB3km59AKB3CrbiVF622YKl63J8pxHror
 RT41HTOemeqGxaMcAzmxJf5QG97ZbfQ5xN7BWctEzZ5uJHUGwb54kBeWVE/0W8bm1ZoTs5EZUxK
 sPmiUeE/97h7HEb21qFQl1XcEDAajPZkAjikedI9jsVaAZnfNXSLdnxoaZth+hb4yH4brI69QBR
 nQxjI5c1cvFVeNLSgLq+029d7EJJIeSO/gO/ldWMpw==
X-Google-Smtp-Source: AGHT+IEb1NyYuJtxuacy2VKM9i8Tab9gHszxmB5nhICewsjItWOxqMnuO0wj85Vgj+P1/X28QSIo9g==
X-Received: by 2002:a17:903:2304:b0:216:3436:b87e with SMTP id
 d9443c01a7336-219d96fcc13mr58922445ad.44.1734631515552; 
 Thu, 19 Dec 2024 10:05:15 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ec0:c32f:435b:9081:64c9:3330?
 ([2607:fb91:1ec0:c32f:435b:9081:64c9:3330])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9706c3sm15386525ad.83.2024.12.19.10.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 10:05:15 -0800 (PST)
Message-ID: <16580023-4b6c-4011-8088-547e591c9ea6@linaro.org>
Date: Thu, 19 Dec 2024 10:05:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert the kvm_xen_guest avocado test
To: David Woodhouse <dwmw2@infradead.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>
References: <20241218113255.232356-1-thuth@redhat.com>
 <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
 <1d4faf8e-b2cd-42b8-a6a7-9034b9512b86@redhat.com>
 <8cef1bf9ffde6779ad322534c4469e6687b9c9d7.camel@infradead.org>
 <7e6fd4ed-ee93-48eb-ab12-fd9aa30e6898@redhat.com>
 <72B07F94-036B-4789-B5DF-103CA913278C@infradead.org>
 <6b1e4f73-b53f-4929-8be4-4c07115af626@redhat.com>
 <a10f5e97da4d5d15f9d13a1a1341132419c01510.camel@infradead.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a10f5e97da4d5d15f9d13a1a1341132419c01510.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 12/19/24 04:56, David Woodhouse wrote:
> On Thu, 2024-12-19 at 13:24 +0100, Thomas Huth wrote:
>> On 19/12/2024 09.49, David Woodhouse wrote:
>>> On 19 December 2024 09:35:13 CET, Thomas Huth <thuth@redhat.com> wrote:
>>>> On 18/12/2024 23.14, David Woodhouse wrote:
>>>>> On Wed, 2024-12-18 at 16:54 +0100, Thomas Huth wrote:
>>>>>> On 18/12/2024 12.48, David Woodhouse wrote:
>>>>>>> On 18 December 2024 12:32:49 CET, Thomas Huth <thuth@redhat.com> wrote:
>>>>>>>> Use the serial console to execute the commands in the guest instead
>>>>>>>> of using ssh since we don't have ssh support in the functional
>>>>>>>> framework yet.
>>>>>>>>
>>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>>
>>>>>>> Hm, but serial is lossy and experience shows that it leads to flaky tests if the guest (or host) misses bytes. While SSH would just go slower.
>>>>>>
>>>>>> I now noticed some issue with the serial console in this test, too.
>>>>>> Looks like the "Starting dropbear sshd: OK" is not print in an atomic way by
>>>>>> the guest, sometimes there are other kernel messages between the ":" and the
>>>>>> "OK". It works reliable when removing the "OK" from the string.
>>>>>
>>>>> Nah, that still isn't atomic; you just got lucky because the race
>>>>> window is smaller. It's not like serial ports are at a premium; can't
>>>>> you have a separate port for kernel vs. userspace messages?
>>>>
>>>> Maybe easiest solution: Simply add "quiet" to the kernel command line, then it does not write the kernel messages to the serial console anymore.
>>>
>>> Want to resend the bug report about that test failing again? But without the kernel messages this time... :)
>>
>> With "quiet", the output just looks like this when it hangs:
>>
>>    Cannot get hvm parameter CONSOLE_EVTCHN (18): -22!
>>    Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
>>    kvm_intel: VMX not supported by CPU 0
>>    Cannot get hvm parameter CONSOLE_EVTCHN (18): -22!
>>    fail to initialize ptp_kvm
> 
> Yeah, that request was rhetorical. That output is useless for
> understanding anything about what happened.
> 
>> Anyway, to properly track this, I've now created a ticket with the full log:
>>
>>    https://gitlab.com/qemu-project/qemu/-/issues/2731
> 
> The patch below should fix it. I don't like it very much; it's very
> much papering over a much bigger generic problem with QEMU's handling
> of shared interrupts.
> 
> Basically, *nothing* should just directly set the system GSIs to
> "their" desired level with qemu_set_irq(). Each device should feed into
> a multiplexer which is essentially an OR gate, and the *output* of that
> mux goes into the actual GSI.

We have such a device: include/hw/or-irq.h.
How simple it is to wire that into this machine model is left unexplored.


r~

