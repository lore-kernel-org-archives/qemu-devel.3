Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B1FC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqDx2-0000yK-UH; Mon, 16 Sep 2024 11:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sqDx1-0000xZ-DU
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:47:43 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sqDwz-0008HP-Mf
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:47:43 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374b25263a3so2254129f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726501659; x=1727106459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iq68o4q1dJBRsArL1BPPmrvqHQKZ03b38ETKhLW16V4=;
 b=UBy+mIo3wgRxGVjD3uq/HMejNglZ1ECOQf8mnAlMHD2w/ykIjVHGKmzbUwXySwE0CN
 iXOoz00hiA0C7SCw5CbjMS1RegEMFX23Cp1jloCjplD19w62PSj5+SrchYscwYntkA6h
 QUKJcJ3M30qpKw3sMt8l0ohdSZOq1sBzAHo/v0HdyqmhWA0MbI+0s/C1voaDIeGeRbrZ
 iBJOKtjnTITi+y1se91vgYW7WKInIuVuviXP6V+ZQBJ7tWWPg9FxRWr6iRef0PTB3LA2
 4LjWB2uzzQAcR0PCmwrt+Mt4VguTM+Ql+jZktEo4O1XjA9MxxBnc1+Wltyeb2prtpK52
 U1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501659; x=1727106459;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iq68o4q1dJBRsArL1BPPmrvqHQKZ03b38ETKhLW16V4=;
 b=mDRct3+OlE/fXEClHzQ2h2ZCA8ECZn7I+cc7DquAFBpD0BjksN2AtBT0P6hL4D2WPY
 Gxl1lS+gKY/j9W54InvBJJnwkAu6iJiWwJ7IEbTP446HBphgGO3GjuK86OdIR3oXP1bq
 WQrSt0YjM8Rmfp9/aPHz4JhbGzz7eX4QU3iO6dUJtzhnI9iRiT7ID0zcWe33ZIEAD3VE
 kly63ClaAGbV3+btJE63O0Qd3IJv0z94TQn47X3Vdm+xjPj09/5QJ+YUhS+ySVdpYOmL
 HGqcAaMM1TG01nJzfceHtPBLqu8vG6Ca/O2T4fglRKiLOHgD1QAieVcZYypY5MfCE2+d
 yzPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL9KCnawUg7RrfWyffVcnzylRSQUtpLHq5yYE8PdgEEItbC9GQIrhaGD/mRqDyqiknWzexzMPwa6o7@nongnu.org
X-Gm-Message-State: AOJu0YxHpdL2Lv2p7o639LhKDZNw49gS2EInw55FQ5y/yFTgzhWszFBl
 +Sag1nNJqOTLtoGE64q0Pyd46wk0pQZrD0U/xLWJ84k/jcRRKcQpl1ZcmE85z7M75XPQmb6nfLo
 221M=
X-Google-Smtp-Source: AGHT+IGXy8BQUDal3DIYXKmoi5YFNt9foj+na1c8/woAhWP/blU55tgsEWaiMmmfvOlkLa04Kaij1Q==
X-Received: by 2002:a05:6000:2a7:b0:374:c2cf:c01c with SMTP id
 ffacd0b85a97d-378d6253625mr6755332f8f.48.1726501659099; 
 Mon, 16 Sep 2024 08:47:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e71f0529sm7638537f8f.6.2024.09.16.08.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:47:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F45E5F87D;
 Mon, 16 Sep 2024 16:47:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <quic_bcain@quicinc.com>
Cc: Brian Cain <bcain@quicinc.com>,  <qemu-devel@nongnu.org>
Subject: Re: [PATCH] tests/tcg/multiarch: Define _LARGEFILE64_SOURCE
In-Reply-To: <b6ef0a81-1153-4aca-9e27-570c2f0a6853@quicinc.com> (Brian Cain's
 message of "Mon, 16 Sep 2024 09:23:21 -0500")
References: <20240907023924.1394728-1-bcain@quicinc.com>
 <0298a6cc-2c75-4cb9-8f9c-146c0173fc31@quicinc.com>
 <87wmjbg2th.fsf@draig.linaro.org>
 <b6ef0a81-1153-4aca-9e27-570c2f0a6853@quicinc.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 16 Sep 2024 16:47:37 +0100
Message-ID: <87msk7fvmu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Brian Cain <quic_bcain@quicinc.com> writes:

> On 9/16/2024 8:12 AM, Alex Benn=C3=A9e wrote:
>> Brian Cain <quic_bcain@quicinc.com> writes:
>>
>>> On 9/6/2024 9:39 PM, Brian Cain wrote:
>>>> With newer clang builds (19.x), there's a warning for implicit function
>>>> declarations and it rejects linux-test.c.
>>>>
>>>> glibc/musl's readdir64() declaration in dirent is guarded by
>>>> _LARGEFILE64_SOURCE, so we'll define it to fix the warning.
>>>>
>>>>         BUILD   hexagon-linux-user guest-tests
>>>>       /local/mnt/workspace/upstream/toolchain_for_hexagon/qemu/tests/t=
cg/multiarch/linux/linux-test.c:189:14: error: call to undeclared function =
'readdir64'; ISO C99 and later do not support implicit function declaration=
s [-Wimplicit-function-declaration]
>>>>         189 |         de =3D readdir64(dir);
>>>>             |              ^
>>>>
>>>> Signed-off-by: Brian Cain <bcain@quicinc.com>
>>>> ---
>>>>    tests/tcg/multiarch/linux/linux-test.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multia=
rch/linux/linux-test.c
>>>> index 64f57cb287..4e0e862ad9 100644
>>>> --- a/tests/tcg/multiarch/linux/linux-test.c
>>>> +++ b/tests/tcg/multiarch/linux/linux-test.c
>>>> @@ -17,6 +17,7 @@
>>>>     *  along with this program; if not, see <http://www.gnu.org/licens=
es/>.
>>>>     */
>>>>    #define _GNU_SOURCE
>>>> +#define _LARGEFILE64_SOURCE
>>>>    #include <stdarg.h>
>>>>    #include <stdlib.h>
>>>>    #include <stdio.h>
>>>
>>> Alex -- what do you think about this one?
>> Actually scratch that, this is a 32 compat hack:
>>
>>    1f442da51e (tests/tcg/multiarch: fix 32bit linux-test on 64bit host)
>>
>> Is the __USE_LARGEFILE64 symbol in the hexagon headers?
>>
> musl does not define/use __USE_LARGEFILE64, no.=C2=A0 If it's well defined
> I could examine whether it makes sense to add this feature to musl,
> though.=C2=A0 How does __USE_LARGEFILE64 differ from _LARGEFILE64_SOURCE?=
=C2=A0
> Is it more appropriate to define that here?

Digging into the GNU source _LARGEFILE* is the correct define, the __USE
flags are internal. features.h says:

   _LARGEFILE_SOURCE    Some more functions for correct standard I/O.
   _LARGEFILE64_SOURCE  Additional functionality from LFS for large files.

although looking at _LARGEFILE64_SOURCE should be defined by
_GNU_SOURCE which is already set for linux-test.c

According to the musl WHATSNEW:

  compatibility:
  - make _GNU_SOURCE imply _LARGEFILE64_SOURCE

So is this a hexagon only thing?

>
> -Brian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

