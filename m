Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B3DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesNC-0006dP-3M; Fri, 16 Aug 2024 04:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sesNB-0006a9-7T
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:31:49 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sesN7-0005S4-UJ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:31:48 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-530c2e5f4feso1757657e87.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723797103; x=1724401903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mWpE7NvxfAae1g3LoLAhBZ7iStPc3mji+hgy7WriXvA=;
 b=Vl4Y/qJz1sqHVAT49Oei96qDrOdpyVWrZl3xBSEacWwsFTg+67f9FSJJNOjHhTwfAH
 BDFUuMxz6F18h/8FQ2zrWFtV8JVQqMnplng5L2aaxDgyRPEoXkyBT69ZTDsifN6JGkBZ
 oyncwN/y7cWKwv5iVng12tV8NdNopk11WGqr9DAu22WJ0Dgyd03Khlm17jxkAW0UUvX2
 TxYuEo4CtJr95R5inMT3W7XoRywQxXR+HRQqe7SNBxvTYbEkqI6rLOPxJw5Xyv2DkBoE
 2uSWtw8oACFjh0SYWluxfY2sUHKgjN2mj31mga0rOESp+DgEFX3le/N4XYtWCjY/K69Q
 +HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723797103; x=1724401903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mWpE7NvxfAae1g3LoLAhBZ7iStPc3mji+hgy7WriXvA=;
 b=R0qhDKCguq2tIpqSfEgTF+TxqwmZ/8eRGbFbrDYJcLmGnD8coxeFe7yO9Ifl+VtX3y
 uAhg4cY88n5RRQZVcVIdTSJM1d/Gx1rQWesAzrSSRKoMparK5jOhRJpTtNuPuvx1mDFI
 ujIVeIWoA4IgPX6ix+8kBpU3H+ZvJ7e1o1IBVpLDWaWgYRa0iGXp2TmP+bqXQLLxpyNl
 /5fDmHtFPQV2fAkpMW8AnSEPkAMJhxfRzen2mWJO9ZgXdllNE99Nhi4bzdlMGDuvSbFb
 UqIbYz9sN5nS43YQbHIpxTbpCErmT5ra5H/uAKJab1oDhYnKfLD3XVRnN2Fiq6g6wlBp
 Jhow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlzddfa5l0I3WNRd4mgLnH2W46ISlv2K9tItul7YJ2FcTcbjqEVf/Zu35QYKAJrMC0ul+iSHPHl1a6@nongnu.org
X-Gm-Message-State: AOJu0YwHg7ozyVt+w2fLsxrF5OvjRjzWp+czFpOb01XFsn56YmTjFcxb
 WnZvFq72qjqZzzl9D083fdUzpCP/mq0aCDkx4WVDaGRqdG0Z2pH0VI4lXuNGymM=
X-Google-Smtp-Source: AGHT+IHSI4Zli0y/kRm9ffl4mnXa+7sNdsF9YQxiK7LwOrEjbTO5z75vPwk8p49VarrU7mivoQGkzg==
X-Received: by 2002:a05:6512:6cd:b0:532:c197:393e with SMTP id
 2adb3069b0e04-5331c690098mr1387316e87.11.1723797102371; 
 Fri, 16 Aug 2024 01:31:42 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a57asm3150007f8f.2.2024.08.16.01.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:31:41 -0700 (PDT)
Message-ID: <e00fbc1e-866e-43ba-b757-7044247d0d30@linaro.org>
Date: Fri, 16 Aug 2024 10:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2] hw/i386/pc: Ensure vmport prerequisites are
 fulfilled
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Joelle van Dyne <j@getutm.app>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <CJaQOvoJMl8P04F7-0Pk23paXt29GnSt2ICM-xlruQ9rGsMHocU_xH3RRaRRJEQpqUxGo63sATZb5St7968jHLV0r7NORODN3zHgi_qxpPE=@szczek.dev>
 <fca41463-b835-4958-9c08-dfe7d09654ff@linaro.org>
 <8k4duf_dozKAnKnCqWFNJpiQCk0RMmMvDXMzPMOuZB0weL6yxhJuDTRLWLdZAcIxFkEAdGjSUfjHZCnuRQ4DKxjQi660jJF8PgMrSxcBlaA=@szczek.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8k4duf_dozKAnKnCqWFNJpiQCk0RMmMvDXMzPMOuZB0weL6yxhJuDTRLWLdZAcIxFkEAdGjSUfjHZCnuRQ4DKxjQi660jJF8PgMrSxcBlaA=@szczek.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 16/8/24 10:27, Kamil Szczęk wrote:
> On Friday, August 16th, 2024 at 10:22, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>>
>>
>> On 16/8/24 10:01, Kamil Szczęk wrote:
>>
>>> Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
>>> to disable PS/2 mouse/keyboard'), the vmport will not be created unless
>>> the i8042 PS/2 controller is enabled. To avoid confusion, let's fail if
>>> vmport was explicitly requested, but the i8042 controller is disabled.
>>> This also changes the behavior of vmport=auto to take i8042 controller
>>> availability into account.
>>>
>>> Signed-off-by: Kamil Szczęk kamil@szczek.dev
>>> ---
>>> hw/i386/pc.c | 8 ++++++--
>>> hw/i386/pc_piix.c | 3 ++-
>>> hw/i386/pc_q35.c | 2 +-
>>> qemu-options.hx | 4 ++--
>>> 4 files changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index c74931d577..c99f2ce540 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -1075,7 +1075,7 @@ static const MemoryRegionOps ioportF0_io_ops = {
>>> };
>>>
>>> static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>>> - bool create_i8042, bool no_vmport)
>>> + bool create_i8042, bool no_vmport, Error **errp)
>>> {
>>> int i;
>>> DriveInfo *fd[MAX_FD];
>>> @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>>> }
>>>
>>> if (!create_i8042) {
>>> + if (!no_vmport) {
>>> + error_setg(errp,
>>
>>
>> Is 'errp' available? Does this patch compile?
> 
> It does and works as expected.

My bad I missed the whole context.

>> Anyway, I think you want to call error_report() & exit().
> 
> Hmm, the error.h suggests that error_report() & exit() is a legacy approach, hence why I've used error_setg & error_fatal ptr. As far as I know both approaches are equivalent, no?

Yep.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



