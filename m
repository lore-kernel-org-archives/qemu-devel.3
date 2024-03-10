Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F08FC54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 19:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjOOW-0002U8-9U; Sun, 10 Mar 2024 14:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rjOOV-0002U0-2R
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 14:59:35 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rjOOP-0006xw-Nf
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 14:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1710097154; x=1710701954; i=deller@gmx.de;
 bh=KrFhO0e7lj6xqjHfJPITMC42Flh29740wbymCXR18ns=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=dHBVItIiaHAnusZZpAMcJBK+RrTsD/G/7X1sECTwCWPsgQf1E8floovwS+jRiQfx
 tzJM4aPuj1ouZOXb34BzTFThVaLyy+hh6ban/hiodwnjAjjEu/dDyTC1UgoudF8Z9
 Ojghx4nxgJtNAGqCE+Vb8q7GjhU9CX3EbH+JuH8YFqb438gMLINy6eYAaRvRVsGoR
 SYQIdGPjVEOoonMIsphG2yrpCoN6U0XV7T0Mo6A4fgjivU1w+RqJ1r9Mza6qhRkyD
 iF6q/OHpwEZJjAZIFITUz1fHClAZUphlED1571UrBQzn1U4/DdPZW8kQ97E6KC2lA
 Kr7WscwbiH1lUgtjVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.144.99]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1qh1bj0EmL-013Qd7; Sun, 10
 Mar 2024 19:59:14 +0100
Message-ID: <74408454-65dd-4c93-89ce-b5c4b1e9585e@gmx.de>
Date: Sun, 10 Mar 2024 19:59:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/scsi/lsi53c895a: add timer to scripts processing
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Sven Schnelle <svens@stackframe.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
References: <20240304163727.2320861-1-svens@stackframe.org>
 <353bf0b3-abd2-4468-a4db-d83483dbe0e5@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <353bf0b3-abd2-4468-a4db-d83483dbe0e5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eMRquHHgY99uNWS7MG4HQ57m3pnKdAZPZ3HOLMGOLnp6uC4KD4G
 WnMYfX7B9YiS/QHhohBsz1SaoIl9Kvd54RPslrPLjjJPWYy48Oun3OoNQfZFNC6gwHZrynC
 XzpRL0MXxLqOw+bpFjtzFzV7buWIeCT9cq8nBXfKBbdDo0QeK9BcRYJ4qlDuTrVz9k7cL6y
 tyPFM64sPhzOwgThlGo8w==
UI-OutboundReport: notjunk:1;M01:P0:HzSqiIBxIP8=;Q7oO1DJSlyaugp8yJdl5w4EKewB
 vyPV8aOzjf7YSqy9SBkwGX6Yl9OnizlrnOsW01vf4NMsiD2enDJ+WbpmItUpUpsWV+ewRANSI
 3dihxr/rtd3yyv7gR4EMyvOWD4w2b7GjTgCXUOopc9r70QhzfFMRyy4Oyfgx7M9E8TbC48jcJ
 XZ6SFGMUdzl4xlkQmMDGm5y1Aok1NjURBeV2sVadpRYi0yvmZDYhhm328ExRTttjwQdMYTC6g
 9kLIW3hloORvSxDrE8Gofl+XyIzvzx5MNpZ6BB3GFqFPoDu6xwDkQFi/R2zCmVVXDp/elRRIf
 UpKbJJv+iC0u1IdUw9ssqURfQvl/VjMHzJl7YMF+DOppef4LL0el5xQDbq/TehssMAiol3xWI
 3Rr2xpkKbB5f+wmCvtrdJd9HFyVrHyaQHx6ld9gaGBJNmLsdaTvcyZfUJMaTtu9+rHxOVkjJa
 T9vDQFzlpzW8HrqjT78Hi0ofbBVNSx2M+Th+PJUdBZXgonC8wsrFEkyrO7i6ZDv3P4X1PrIpr
 bft6l5m1rQKE4XhmgBPL+0Id5UnQ7ZHCuxQc3WNnhIgAmdqh7KYZ6hmrV7OMw9ekrqmeX/mkb
 XW6ZsYzVLmeN9ucSnMVRc099LiYAOF8QijyiCtNSDIpZ6wgIyZkc8Z35cj3ssuCI1/Wi2qfJF
 o2gZ8m66+j535KwqS35g046gUZa39NAQ8Jx7egc+azhDZavFUdk1vX/7CQn+Vz8gkRP8tMKaJ
 bIk4ZiPYoOaTCQlWY68AgoV/nK6/vaOfVRFe2IHIYVoEmO5ucUzXPfrQfZ+wDH1lTkDWx9fOZ
 InBbMBu5mD1EV8LnqhfCJ3tY854pDnJ8h9aaJ2YIDcEfk=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/10/24 16:35, Michael Tokarev wrote:
> 04.03.2024 19:37, Sven Schnelle :
>> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
>> under certain circumstances. As the SCSI controller and CPU are not
>> running at the same time this loop will never finish. After some
>> time, the check loop interrupts with a unexpected device disconnect.
>> This works, but is slow because the kernel resets the scsi controller.
>> Instead of signaling UDC, start a timer and exit the loop. Until the
>> timer fires, the CPU can process instructions which might change the
>> memory location.
>>
>> The limit of instructions is also reduced because scripts running on
>> the SCSI processor are usually very short. This keeps the time until
>> the loop is exited short.
>
> This one is a bit large(ish), yet, - is it okay for -stable?=C2=A0 From =
the
> description it feels like it should be picked up, and it applies cleanly
> to 7.2.x too (after picking up the forgotten 8b09b7fe47082c692
> "hw/scsi/lsi53c895a: add missing decrement of reentrancy counter" there)=
.

Please include it in stable.
HP-UX feels incredible sluggish and slow without it, and even with Linux
guests the disconnects can be seen sometimes.

Helge

