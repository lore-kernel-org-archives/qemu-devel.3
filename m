Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97181CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 23:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8oHI-00024t-VJ; Tue, 14 Oct 2025 19:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1v8oHG-00024d-7I
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 19:17:58 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1v8oH9-0005ln-DG
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 19:17:58 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7bc626c5467so4496487a34.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 16:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1760483867; x=1761088667;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nHl1l6mDrvKMN+LZ198a1t3pE7ZiFHa+vTzHsc/1rsg=;
 b=F2a8p4IS4pnImnTyFb62nYqlG1B9qKYGfjOKDgGDQmP0Nt/PAA5ALWL54w+W9tsCr5
 8Gp3hICGU6vB0T4TZ7ZedP2u4RzhQFc2xCOSWz/BsNbq1L7SmEZboaJYiyiT4/HVLCFU
 1xYiGC8bwwYvB1h3FggJAoM6PM3NRiq45JomYPQyIB/pQSkp7YlKISnTs9qjOm07uCB0
 feBeAGAV+um2zZ0WnvNYLxRe4uvBzmPQBQHydW4n6rdnsMakZ3gqeUctzMZTDWhcBLeX
 3xo0Lni6ehg2wTY2qhaUR0Gwnh3BLWXhEhnXHBn+botEXg6crLFYN0iYzi0DwY408Cr6
 3T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760483867; x=1761088667;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nHl1l6mDrvKMN+LZ198a1t3pE7ZiFHa+vTzHsc/1rsg=;
 b=T12kcc/XoMWcZ42rstYPf97s5YqdSJuVo+TZhFRzq55oRH+MJqGifjGgvClX8Zi3zh
 GfSZaJxvx0/lSVeQunuKzeYDWpD9yYZjMrklwr4wdkMRuoFdCZhqDL2iXJpBhd6FAlw/
 ZrP5SGbnv8jA/DH2GjNf4jg8D22rVT5UE7xWUQMeAQ8+0cffs5HZntx3iG5JfIPaa5Cd
 SbosVs63xvjHruYLS07dCklGF2R8dQ3doA03pQf9Jq4Qd2z8z52yoau50uFw6ElPbbVT
 VPfdM4/W9mBs0kfYatLhJqhxdqsVoM6y4QjIVCx2A6/sduD0QzjOCU2nEE6yYGaynTJK
 LLqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeFVv+1En1X9c9oXHXzzKj+xDaZaP7lV3f4MlV1FzmVjEAu8KZi1pv2kRuNzhDZ9dSrGMsu1OLqxgi@nongnu.org
X-Gm-Message-State: AOJu0Yy8Na9T6KugwLpjp7dPvYCwTrGRC+sR9DQmH7qeq8P1dYnwtTnv
 bvanRp2HW0YFHPjLvjNoi7MgForZHPdX9KbUrVYtwEQBsFAfpWCkDj7t/7VDHbg9boo=
X-Gm-Gg: ASbGncswoERCETLsnjElle1XHRSdHFRVqsOa5veNSOJPKG1pjk2TUQXMSCO/TxhyGfT
 Y3p8ooQ+rh45Srm5TE0nVvwhrJG7AW1bLfHZSMxUNpAAk6ztxmtoXt6NW/SgsWeC2MQOj1e9Ozg
 TkcRP7EwoU4aA4hoP/+Y1EWRJ36B3y2JebEhvmhwXvRR3EqArA76fUmWNq54TV3ps+Ow44+IjuL
 mzXtPggiWV6MlLLrEKUS+/TMHZ7pxUtIfKRNt/9VwhHAdADivRf5OvZRDr5gO1JE0HjJUeoyMlI
 VaC7WYvxP8fLPz0ZDSN1P/uNN9+gnPlriHqdblYe08pzjU4k7LusyvS1iGjHmos/7MrNr58QFJ8
 DHColIwJoD60ZH2pDnS3yE+0M6KlzzPThizNdvXNgC9vU2V0Xesw0fq8=
X-Google-Smtp-Source: AGHT+IEbRn6/MJaEF4nQxdjT10+AEIeDJCWVaLsusj3oC6mF+3HpStMYb4jhYqQ3wmO2gwStcPdv5Q==
X-Received: by 2002:a05:6808:6d91:b0:43f:6f82:e16f with SMTP id
 5614622812f47-441d360ec0dmr5637983b6e.12.1760483867146; 
 Tue, 14 Oct 2025 16:17:47 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ad63:63fb:ee1c:2ee9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-441cc9a25cesm2391449b6e.26.2025.10.14.16.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 16:17:45 -0700 (PDT)
Date: Tue, 14 Oct 2025 18:17:39 -0500
From: Corey Minyard <corey@minyard.net>
To: Yunpeng Yang <yunpeng.yang@nutanix.com>
Cc: "minyard@acm.org" <minyard@acm.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
Subject: Re: Add support for retrieving fake LAN config from `ipmi-bmc-sim`
 device
Message-ID: <aO7aE3bAbrVqUUx7@mail.minyard.net>
References: <BYAPR02MB502953334AA7CE0A695C373C8545A@BYAPR02MB5029.namprd02.prod.outlook.com>
 <BYAPR02MB5029F83A450ED347FF69345F8520A@BYAPR02MB5029.namprd02.prod.outlook.com>
 <CAB9gMfoVgdoWV1Y=-hkTcVJoKHe8SPBH4z1UqqrXavTE-9T+TA@mail.gmail.com>
 <BYAPR02MB5029684C2548598399A1784785EBA@BYAPR02MB5029.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR02MB5029684C2548598399A1784785EBA@BYAPR02MB5029.namprd02.prod.outlook.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=corey@minyard.net; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 14, 2025 at 12:19:53PM +0000, Yunpeng Yang wrote:
> Hello Corey,
> 
> I hope you are all well.
> 
> I've finally come up with a patch for implementing the fake LAN configurations for the device ipmi-bmc-sim. My apologies for the long long delay. And thank you for your patience.
> 
> Please find attached the patch file. The patch is base on commit: bd6aa0d1e5 ("Merge tag 'staging-pull-request' of https://gitlab.com/peterx/qemu into staging"). Could you please review the patch and let me know your opinions?

The patch is mostly ok, the general principles are sound.

A few things:

Can you put the patch inline in the email instead of attaching it?  In
general, it is hard to deal with attachments when commenting on things.
Use git-send-email or git-format-patch or something like that.  You can
look in the Linux kernel docs for how to do this.

I could not find a check on the lan.channel value to make sure it is in
range and doesn't conflict with an existing channel.  If a check is not
there it needs to be done.

I would like to keep the behavior as close as possible to the current
behavior.  If a channel is not defined, get_lan_config() and
set_lan_config() should return the same value as if the command was not
defined.  I think get_channel_access() is ok as it is.

You need to add documentation in qemu-options.hx.

Can you copy Cornelia Huck <cornelia.huck@de.ibm.com> on the next
version?  The IBM people are the biggest users of the ipmi code,
and I don't want this to catch them off guard.

If the patch gets too big, feel free to split it into multiple parts.

Thanks,

-corey

> 
> Looking forward to hearing back from you.
> 
> Kind regards,
> Yunpeng Yang
> 
> 
> 
> ________________________________
> From: Corey Minyard <corey@minyard.net>
> Sent: Sunday, August 03, 2025 14:22
> To: Yunpeng Yang <yunpeng.yang@nutanix.com>
> Cc: minyard@acm.org <minyard@acm.org>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>; Mark Cave-Ayland <mark.caveayland@nutanix.com>; Jonathan Davies <jond@nutanix.com>
> Subject: Re: Add support for retrieving fake LAN config from `ipmi-bmc-sim` device
> 
> On Sun, Aug 3, 2025 at 6: 16 AM Yunpeng Yang <yunpeng. yang@ nutanix. com> wrote: Hello Corey Minyard, I hope you are all well. Could I ask for your opinion on whether it is worthing implementing a fake LAN config for device ipmi-bmc-sim ?
> ZjQcmQRYFpfptBannerStart
> CAUTION: External Email
> 
> ZjQcmQRYFpfptBannerEnd
> On Sun, Aug 3, 2025 at 6:16 AM Yunpeng Yang <yunpeng.yang@nutanix.com<mailto:yunpeng.yang@nutanix.com>> wrote:
> Hello Corey Minyard,
> 
> I hope you are all well.
> 
> Could I ask for your opinion on whether it is worthing implementing a fake LAN config for device ipmi-bmc-sim ? (Details are in my last email, which is also included below).
> 
> During my work over last month, I found that QEMU already has ipmi-bmc-extern which supports comprehensive BMC simulation, including LAN config faking. But ipmi-bmc-sim is more light-weight and easier to set up. So I think it still has some value in implementing LAN config for ipmi-bmc-sim . Could you please share your views?
> 
> 
> Well, there is no LAN interface, so I didn't see any need to add that.  The values would not be permanent.  But it would be harmless to add, so I'd be ok with a patch to do this.
> 
> The external interface with ipmisim from the OpenIPMI library provides a pretty comprehensive solution.
> 
> -corey
> 
> Best regards,
> Yunpeng Yang
> 
> 
> ________________________________
> From: Yunpeng Yang <yunpeng.yang@nutanix.com<mailto:yunpeng.yang@nutanix.com>>
> Sent: Friday, June 27, 2025 18:13
> To: minyard@acm.org<mailto:minyard@acm.org> <minyard@acm.org<mailto:minyard@acm.org>>
> Cc: qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> <qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org>>; Mark Cave-Ayland <mark.caveayland@nutanix.com<mailto:mark.caveayland@nutanix.com>>; Jonathan Davies <jond@nutanix.com<mailto:jond@nutanix.com>>
> Subject: Add support for retrieving fake LAN config from `ipmi-bmc-sim` device
> 
> Hello Corey Minyard,
> 
> I hope this email finds you well.
> 
> I'm currently adding LAN-configs-retrieval support to the QEMU ipmi-bmc-sim device. And I hope to merge the modifications upstream after it's finished. Could you please check the attached patch file of the draft code and share your opinions and advice?
> 
> In my work, we need to run tools like "ipmitool lan print" on a VM for testing purposes. However, QEMU internal BMC simulator device (`ipmi-bmc-sim`) does not support retrieving LAN configs from it. I have to implement two IPMI commands so that the device can now work with ipmitool. The LAN config values are faked, but for testing purposes this is not a problem. I believe other people may also have the same need, so it's worth getting merged upstream.
> 
> The fake BMC LAN config values are currently hard coded into the code. My plan is to add a parameter to the device, which is a file containing user designated values. The device then reads the file and returns those values as LAN configs. This is similar to sdrfile for sensor data and frudatafile for FRU data.
> 
> Looking forward to hearing your thoughts.
> Have a nice weekend.
> 
> Kind regards,
> Yunpeng Yang



