Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A9ACD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHaX-0002Li-JK; Wed, 27 May 2026 12:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.volkov@munic.io>)
 id 1wSH4j-0001DU-2J
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:25:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrey.volkov@munic.io>)
 id 1wSH4f-0000vL-D4
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:25:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49040362e4aso64062905e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=munic.io; s=google; t=1779899139; x=1780503939; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bhelo/g6Gj9Asn80jJVTHV1RMjn1Iys/Wy8fpC7JP3Y=;
 b=dzrWfOhfKbaN2wyAklIqc3CEhf5o1qnUr8KqWe75+F8cnKN1vUvYXxeHRF2x1PqdxL
 2OEPI+GQ8M3q/2g4GZCzHhNB3g6SyiGMYo3myuOIvus3PnFz7qddPN7MDf0VFbp/KDrm
 EtiPcJpeo/a+Y4NdbKpf5dlHX3jAqsgpxMpnk8Mo31qhsYfyRtN7XbOSHzZseiRAxBfg
 NjyC7dRU69ttLC9jLO97bilGS4CpMApMlitzUcjpjS71M56gZgcolDnwxbvxYHoJFYSd
 Iu4Ig21JPddfK5LYlFD5vHqKpk3V2jRCpw+pApdkqCgQqnuMx7nlZaAZNAsiSCntQpRZ
 K8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779899139; x=1780503939;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bhelo/g6Gj9Asn80jJVTHV1RMjn1Iys/Wy8fpC7JP3Y=;
 b=gTbV7s19ncd1hfFsAXNZpVgiDT9H94iwr8bgsWkLFrIuHeb5jcqYSn/7pCWx1Wy0eW
 d6UhpnlGIytr+s49qeEqDn9hchru7mjjC/i6L68KKwmxcSaIW66T7xEYHSctrrOyv6pv
 IP4E6dfVThwFKY1MFAdlNJYgWuWso3uFBB6qKNp/9yRa6QSkqyB8JcASf2TwNbvJ5gdj
 pTlUE7EzktiH1Tb3B1d46/MfX3IlvUaK47Z8fxtz9UVtta3neDqFx2OXwfKO8DiYIi+V
 Cc0zZunq4MiB5g0aBhMWY2B5b52Q/i+v13wHYuxBafRPnXUjT3ZjqMO8eSYpTAMDYbfb
 3eJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HPC3MbJYcb9YjFymj30ThxovO7LycT1ywfMyQP3CAoffd2g0XdwU74xbzd/CjPeIeu4da5tMmxWuc@nongnu.org
X-Gm-Message-State: AOJu0YyZ6cxgAHQAnp1tt1Wno9GFM15VZ5/J6rsTpDryPYVa1MQPqnnj
 NqmauB7fIq7Ybw/fuhRy4f3Gwix82nWnrybQ5WF8JRIJXP589SuKPkQCfKEeydwdEUA=
X-Gm-Gg: Acq92OFHBi5MNiA0OhhYofAM4gxxCuV+jDH4154KTEbJNuyyJeEHZRsybKkztDyIy+k
 ELUOp1h1ky4R99qFH09K9E4YAGyL/bGZkZiKrGG3rKBHFQHO3wTmCmoYAsP3cZ5dkgqG9SD71bp
 MkseOhqemftkaX0VoH8uCvZMJJpnp0Qtb5DLLqqcsZbYtGqKJfjZDEOlNXmvPZfOxHKrUBwm7pm
 RQBfcTuPaXXNh/rl0NyFEm7lytV9l/VPLHDGO3Nqd204u3AHSiwzZL92Qr0TX8bbD57bgFckMOK
 UnOAOWEeCYDOp/7dvQYCFoHyaZA3gn8WG/rNWiovUrH4SkpJGgWjf3kOtXxo7dYpb4LMz+U48qM
 Yi3Y5q6T3BzLgEnbwzfyjZ5bJmofAAIxzC70UowDsL9LU/5fncFi+px9sNVuUhufggiofLS6dWy
 iEf7QllX4/XlI7XiNlVVTXbEUE1/87Yjm6dlz5SHhblb1SlYS/63mNO6Fzd10yaSKTulgbiYOZR
 wtQPtq9aoi99z4=
X-Received: by 2002:a05:600c:c8d:b0:490:6869:46d2 with SMTP id
 5b1f17b1804b1-490686947f8mr200321395e9.0.1779899138536; 
 Wed, 27 May 2026 09:25:38 -0700 (PDT)
Received: from [10.42.100.36]
 (static-qvn-qvs-183113.business.bouyguestelecom.com. [89.87.183.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1a28sm7082898f8f.26.2026.05.27.09.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 09:25:37 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------wTShK8bmI0h0030tb6qHhyyH"
Message-ID: <07cc057c-61b3-4744-96fa-1d792989cb4c@munic.io>
Date: Wed, 27 May 2026 18:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
To: Marc Kleine-Budde <mkl@pengutronix.de>, Pavel Pisa <pisa@fel.cvut.cz>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>,
 Matyas Bobek <bobekmat@fel.cvut.cz>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, linux-can@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>
References: <cover.1777571962.git.matyas.bobek@gmail.com>
 <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
 <08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
 <202605271738.21722.pisa@fel.cvut.cz>
 <20260527-fast-unbiased-flamingo-5c5cbe-mkl@pengutronix.de>
Content-Language: en-US
From: Andrei VOLKOV <andrey.volkov@munic.io>
In-Reply-To: <20260527-fast-unbiased-flamingo-5c5cbe-mkl@pengutronix.de>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=andrey.volkov@munic.io; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 May 2026 12:58:35 -0400
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

This is a multi-part message in MIME format.
--------------wTShK8bmI0h0030tb6qHhyyH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Pavel, Marc,

As the original author, I have no objection to reusing (my part of) the 
header under GPL-2.0-or-later. The reason it was not done that way in 
2005/2006 is simple: only GPLv2 existed at the time.

All the more so since, as already noted, the code in question is 
essentially a direct transcription of offsets and bit-fields from the 
Freescale/NXP datasheets, which leaves very little room for a meaningful 
copyright claim in the first place.

Personally, I would prefer that this code not be rewritten and be kept 
as is, to avoid introducing subtle bugs in QEMU later on.
That said, @Sascha and @David may have a different opinion.

PS: andrey.volkov@munic.io is my correct current work address, but I 
would prefer to use my personal one for this discussion.

Regards,
Andrey Volkov

Le 27/05/2026 à 18:09, Marc Kleine-Budde a écrit :
> Hello,
>
> On 27.05.2026 17:38:21, Pavel Pisa wrote:
>> please, provide your opinion, the license for small Linux kernel
>> headers excepts seems to be the last and only blocker for mainlining.
>> See the copied code below.
> not sure how much help I can provide...
>
>> On Wednesday 27 of May 2026 12:42:23 Bernhard Beschow wrote:
>>> Am 8. Mai 2026 12:10:21 UTC schrieb Peter Maydell<peter.maydell@linaro.org>:
>>>> On Tue, 5 May 2026 at 21:21, Bernhard Beschow<shentey@gmail.com> wrote:
>>>>> Am 5. Mai 2026 18:41:52 UTC schrieb Peter Maydell<peter.maydell@linaro.org>:
>>>>>> On Tue, 5 May 2026 at 19:03, Bernhard Beschow<shentey@gmail.com> wrote:
>>>>>>> I guess the only open issue is the licensing of struct FlexcanRegs
>>>>>>> [1] which originates from Linux? How do we proceed here?
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Bernhard
>>>>>>>
>>>>>>> [1]
>>>>>>> https://lore.kernel.org/qemu-devel/202603211316.18181.pisa@fel.cvut.c
>>>>>>> z/
>>>>>> Could you say what the problem is? In general there is no problem
>>>>>> with taking header structs from the Linux kernel, as they are
>>>>>> GPL-2-only and that is a QEMU-compatible license. The relevant
>>>>>> source files or pieces of source files would need to be noted
>>>>>> as 2-only rather than our default of 2-or-later, but that is
>>>>>> doable -- we already do that for other things we have borrowed
>>>>> >from the kernel.
> This would be IMHO the cleared solution. Put these macros into a
> separate file with the proper license and copyright headers copied from
> the kernel driver.
>
>>>>> In
>>>>> https://lore.kernel.org/qemu-devel/f3cb3166-c3f8-4ed8-8c9a-cbf48b071d1e@
>>>>> gmail.com/ I raised this review question: "The following structure looks
>>>>> like being based on Linux. Does this affect the copyright of this file?"
>>>>> I was just asking for advice and I'm glad the solution is that easy.
>>>> If the struct was copied from the kernel, then it's GPL-2.0-only,
>>>> and we should just note the license and where we got the code from.
>>>>
>>>> If the struct is just very similar to the kernel's one because
>>>> it's the obvious representation taken from the datasheet, then
>>>> it's not related to the kernel code and we can treat it as
>>>> GPL-2.0-or-later like the rest of the file.
>>>>
>>>> Since Matyáš says in the cover letter here "the headers (struct
>>>> FlexcanRegs and flexcan_regs.h macros) were copied from the Linux
>>>> kernel" then we're in case 1.
>>>>
>>>> You can mark this up by having the file's SPDX tag be
>>>> "SPDX-License-Identifier: (GPL-2.0-only AND GPL-2.0-or-later)"
>>>> Then have a normal comment in the file next to the part that is
>>>> 2.0-only that says
>>>> /*
>>>> * [This struct / the macros X, Y, Z / whatever ] are borrowed
>>>> * from the Linux kernel, and so (unlike the rest of this file)
>>>> * they are GPL-2.0-only.
>>>> */
>>> Ping
>>>
>>> Any news? With just the license issue remaining, it would be nice to get
>>> FlexCAN support into the upcoming release.
>> The problem is that QEMU maintainers decided to prefer GPL-2.0-or-later
>> as the rule for new contributions and Matyas Bobek has reused
>> next excepts from Linux kernel sources
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/flexcan/flexcan-core.c
>>
>> which have license
>>
>> // SPDX-License-Identifier: GPL-2.0
>> //
>> // flexcan.c - FLEXCAN CAN controller driver
>> //
>> // Copyright (c) 2005-2006 Varma Electronics Oy
>> // Copyright (c) 2009 Sascha Hauer, Pengutronix
>> // Copyright (c) 2010-2017 Pengutronix, Marc Kleine-Budde<kernel@pengutronix.de>
>> // Copyright (c) 2014 David Jander, Protonic Holland
>> //
>> // Based on code originally by Andrey Volkov<avolkov@varma-el.com>
>>
>>
>> I think, personally, that the code excepts are on the edge
>> of the rules for copyright applications because the lines are direct
>> transformation of the offests and bit-fields found in the original
>> FreeScale/NXP manuals so there should be no problem to use them for
>> QEMU and revwite from scratch for copyright clarity with a little
>> different naming rules would make only more mess for future updates
>> to FexCAN 3 etc.
> As you target currently imx6 only, you can re-create them from the imx6
> data sheet, it already comes with "C" compatible naming scheme, e.g.:
>
> | "Rx Mailboxes Global Mask Register (FLEXCAN1_RXMGMASK)"
>
>> hw/net/can/flexcan_regs.h
>>
>> +/**
>> + * These macros ware originally written for the Linux kernel
>> + * by Marc Kleine-Budde.
>> + */
> This is not 100% correct. I'm the git-author of the initial mainline
> flexcan commit e955cead0311 ("CAN: Add Flexcan CAN controller driver"),
> but it already comes with these copyright statements:
>
> + * Copyright (c) 2005-2006 Varma Electronics Oy
> + * Copyright (c) 2009 Sascha Hauer, Pengutronix
> + * Copyright (c) 2010 Marc Kleine-Budde, Pengutronix
> + *
> + * Based on code originally by Andrey Volkov<avolkov@varma-el.com>
>
> So I cannot re-license even the initial file alone, Sascha is my
> co-worker.
>
> Hope that helps,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   |https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
-- 

*Andrei VOLKOV — MUNIC CAR DATA
*Senior Software Engineer**

https://www.munic.io

39 avenue de Paris, 94800 Villejuif — France

tel: +33 (0) 1 42 11 93 25

--------------wTShK8bmI0h0030tb6qHhyyH
Content-Type: multipart/related;
 boundary="------------03n501iz3uFMlSOE12omd33P"

--------------03n501iz3uFMlSOE12omd33P
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p>Hello Pavel, Marc,<br>
      <br>
      As the original author, I have no objection to reusing (my part
      of) the header under GPL-2.0-or-later. The reason it was not done
      that way in 2005/2006 is simple: only GPLv2 existed at the time.<br>
      <br>
      All the more so since, as already noted, the code in question is
      essentially a direct transcription of offsets and bit-fields from
      the Freescale/NXP datasheets, which leaves very little room for a
      meaningful copyright claim in the first place.<br>
      <br>
      Personally, I would prefer that this code not be rewritten and be
      kept as is, to avoid introducing subtle bugs in QEMU later on.<br>
      That said, @Sascha and @David may have a different opinion.<br>
      <br>
      PS: <a class="moz-txt-link-abbreviated" href="mailto:andrey.volkov@munic.io">andrey.volkov@munic.io</a> is my correct current work address, but
      I would prefer to use my personal one for this discussion.<br>
      <br>
      Regards,<br>
      Andrey Volkov</p>
    <div class="moz-cite-prefix">Le 27/05/2026 à 18:09, Marc
      Kleine-Budde a écrit :<br>
    </div>
    <blockquote type="cite"
cite="mid:20260527-fast-unbiased-flamingo-5c5cbe-mkl@pengutronix.de">
      <pre wrap="" class="moz-quote-pre">Hello,

On 27.05.2026 17:38:21, Pavel Pisa wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">please, provide your opinion, the license for small Linux kernel
headers excepts seems to be the last and only blocker for mainlining.
See the copied code below.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
not sure how much help I can provide...

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On Wednesday 27 of May 2026 12:42:23 Bernhard Beschow wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Am 8. Mai 2026 12:10:21 UTC schrieb Peter Maydell <a class="moz-txt-link-rfc2396E" href="mailto:peter.maydell@linaro.org">&lt;peter.maydell@linaro.org&gt;</a>:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On Tue, 5 May 2026 at 21:21, Bernhard Beschow <a class="moz-txt-link-rfc2396E" href="mailto:shentey@gmail.com">&lt;shentey@gmail.com&gt;</a> wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">Am 5. Mai 2026 18:41:52 UTC schrieb Peter Maydell <a class="moz-txt-link-rfc2396E" href="mailto:peter.maydell@linaro.org">&lt;peter.maydell@linaro.org&gt;</a>:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">On Tue, 5 May 2026 at 19:03, Bernhard Beschow <a class="moz-txt-link-rfc2396E" href="mailto:shentey@gmail.com">&lt;shentey@gmail.com&gt;</a> wrote:
</pre>
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">I guess the only open issue is the licensing of struct FlexcanRegs
[1] which originates from Linux? How do we proceed here?

Best regards,
Bernhard

[1]
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/202603211316.18181.pisa@fel.cvut.c">https://lore.kernel.org/qemu-devel/202603211316.18181.pisa@fel.cvut.c</a>
z/
</pre>
                </blockquote>
                <pre wrap="" class="moz-quote-pre">
Could you say what the problem is? In general there is no problem
with taking header structs from the Linux kernel, as they are
GPL-2-only and that is a QEMU-compatible license. The relevant
source files or pieces of source files would need to be noted
as 2-only rather than our default of 2-or-later, but that is
doable -- we already do that for other things we have borrowed
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">&gt;from the kernel.
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This would be IMHO the cleared solution. Put these macros into a
separate file with the proper license and copyright headers copied from
the kernel driver.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">In
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/f3cb3166-c3f8-4ed8-8c9a-cbf48b071d1e@">https://lore.kernel.org/qemu-devel/f3cb3166-c3f8-4ed8-8c9a-cbf48b071d1e@</a>
gmail.com/ I raised this review question: "The following structure looks
like being based on Linux. Does this affect the copyright of this file?"
I was just asking for advice and I'm glad the solution is that easy.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">
If the struct was copied from the kernel, then it's GPL-2.0-only,
and we should just note the license and where we got the code from.

If the struct is just very similar to the kernel's one because
it's the obvious representation taken from the datasheet, then
it's not related to the kernel code and we can treat it as
GPL-2.0-or-later like the rest of the file.

Since Matyáš says in the cover letter here "the headers (struct
FlexcanRegs and flexcan_regs.h macros) were copied from the Linux
kernel" then we're in case 1.

You can mark this up by having the file's SPDX tag be
"SPDX-License-Identifier: (GPL-2.0-only AND GPL-2.0-or-later)"
Then have a normal comment in the file next to the part that is
2.0-only that says
/*
* [This struct / the macros X, Y, Z / whatever ] are borrowed
* from the Linux kernel, and so (unlike the rest of this file)
* they are GPL-2.0-only.
*/
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">
Ping

Any news? With just the license issue remaining, it would be nice to get
FlexCAN support into the upcoming release.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
The problem is that QEMU maintainers decided to prefer GPL-2.0-or-later
as the rule for new contributions and Matyas Bobek has reused
next excepts from Linux kernel sources

<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/flexcan/flexcan-core.c">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/flexcan/flexcan-core.c</a>

which have license

// SPDX-License-Identifier: GPL-2.0
//
// flexcan.c - FLEXCAN CAN controller driver
//
// Copyright (c) 2005-2006 Varma Electronics Oy
// Copyright (c) 2009 Sascha Hauer, Pengutronix
// Copyright (c) 2010-2017 Pengutronix, Marc Kleine-Budde <a class="moz-txt-link-rfc2396E" href="mailto:kernel@pengutronix.de">&lt;kernel@pengutronix.de&gt;</a>
// Copyright (c) 2014 David Jander, Protonic Holland
//
// Based on code originally by Andrey Volkov <a class="moz-txt-link-rfc2396E" href="mailto:avolkov@varma-el.com">&lt;avolkov@varma-el.com&gt;</a>


I think, personally, that the code excepts are on the edge
of the rules for copyright applications because the lines are direct
transformation of the offests and bit-fields found in the original
FreeScale/NXP manuals so there should be no problem to use them for
QEMU and revwite from scratch for copyright clarity with a little
different naming rules would make only more mess for future updates
to FexCAN 3 etc.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
As you target currently imx6 only, you can re-create them from the imx6
data sheet, it already comes with "C" compatible naming scheme, e.g.:

| "Rx Mailboxes Global Mask Register (FLEXCAN1_RXMGMASK)"

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">hw/net/can/flexcan_regs.h

+/**
+ * These macros ware originally written for the Linux kernel
+ * by Marc Kleine-Budde.
+ */
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This is not 100% correct. I'm the git-author of the initial mainline
flexcan commit e955cead0311 ("CAN: Add Flexcan CAN controller driver"),
but it already comes with these copyright statements:

+ * Copyright (c) 2005-2006 Varma Electronics Oy
+ * Copyright (c) 2009 Sascha Hauer, Pengutronix
+ * Copyright (c) 2010 Marc Kleine-Budde, Pengutronix
+ *
+ * Based on code originally by Andrey Volkov <a class="moz-txt-link-rfc2396E" href="mailto:avolkov@varma-el.com">&lt;avolkov@varma-el.com&gt;</a>

So I cannot re-license even the initial file alone, Sascha is my
co-worker.

Hope that helps,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | <a class="moz-txt-link-freetext" href="https://www.pengutronix.de">https://www.pengutronix.de</a> |
Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
</pre>
    </blockquote>
    <div class="moz-signature">-- <br>
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <style type="text/css">@page{size:21cm 29.7cm;margin-left:2cm;margin-right:1cm;margin-top:1cm;margin-bottom:1cm}p{margin-bottom:.25cm;line-height:115%;background:transparent}a:link{color:#000080;text-decoration:underline}</style>
      <p lang="en-US" style="margin-bottom:0;line-height:100%"><font
          color="#1e497d"><font face="Verdana, sans-serif"><font
              size="2" style="font-size:10pt"><b>Andrei VOLKOV — <font
                  size="2" style="font-size:9pt">MUNIC </font><font
                  size="1" style="font-size:7pt">CAR DATA</font><br>
              </b><span style="font-weight:normal">Senior Software
                Engineer</span><b> </b></font></font></font></p>
      <p style="line-height:100%;margin-bottom:0"><font color="#1e497d"><font
            face="Verdana"><font size="2" style="font-size:9pt"><span
                lang="en-US"><a href="https://www.munic.io/"
                  target="_blank" class="moz-txt-link-freetext">https://www.munic.io</a></span></font></font></font></p>
      <p lang="en-US" style="margin-bottom:0;line-height:100%"><font
          color="#1e497d"><font face="Verdana"><font size="1"
              style="font-size:7pt">39 avenue de Paris, 94800 Villejuif
              — France</font></font></font></p>
      <p lang="en-US" style="margin-bottom:0;line-height:100%"><font
          color="#1e497d"><font face="Verdana"><font size="2"
              style="font-size:9pt">tel: <font color="#1255cc">+33 (0)
                1 42 11 93 25</font></font></font></font></p>
      <p style="line-height:100%;margin-bottom:0"><img
          src="cid:part1.RMpphHl4.E05mU3g1@munic.io" name="Image1"
          align="bottom" width="174" height="69" border="0"></p>
    </div>
  </body>
  <lt-container></lt-container>
</html>
--------------03n501iz3uFMlSOE12omd33P
Content-Type: image/png; name="Image1"
Content-Disposition: inline; filename="Image1"
Content-Id: <part1.RMpphHl4.E05mU3g1@munic.io>
Content-Transfer-Encoding: base64

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
gg==

--------------03n501iz3uFMlSOE12omd33P--

--------------wTShK8bmI0h0030tb6qHhyyH--

