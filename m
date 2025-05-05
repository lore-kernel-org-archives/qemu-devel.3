Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F76BC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpRM-0000cS-BA; Mon, 05 May 2025 02:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBpRK-0000c8-JK
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:36:34 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBpRJ-0006TB-0w
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:36:34 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso2693833a91.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746426991; x=1747031791; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SWPkD5zxAA4ONnMqlHIspgSg1wYu8cDdeZXonxizZ0=;
 b=gIfLDovGaF5xBKsUnQba6fAK2RxLoTwUsHRLJc623CHqyZsNgFtI3RJfO0XhjCd8tW
 UOph7hyTXU1v63CQRd8HTxZnOQ7uazoCEzS1udXLXGNpRKEWIr67qHe79JNYbHZdONJH
 2owpOP4DIU5KeWIPzaPyKtfjgj/iZz40+th3CboxBnHRhir/epV0cntuXS6OAkhwCFSs
 l0H3vQV4OqCKCNsvWm1nn55+g2egKrztY9T0tABwrbN4OzmzXEOVw4wfnzLA+ubVYPCy
 5QMXcaZUi7klHh8NnRmOTdHel0N7TYm32/bMzdaQtVAtfW9K3QH1t2Mp6rMy7f0kFGPz
 Vzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746426991; x=1747031791;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2SWPkD5zxAA4ONnMqlHIspgSg1wYu8cDdeZXonxizZ0=;
 b=myxHvl6hooWwzyO8x8cpEoaXKurYcJfBED86SM+yOF5S8ruudrPPmcn78ksB4Kn2n3
 +C8yX910vvJ/1IL/3bO8C7Hb0SfI5gYxyN1oEbqCX2H7a3ZbKea7HRtpAv8f6CV2Z+pL
 FLGt5A06CPgtVu6e9YWuWCnV0zkCKxPfpww9c8v4sx8wTtAj8N2Ab4bk57nP8TJ030YT
 Pxabvps8VvYIuq0iC33PvFMxoDlMr96/jLz+5IodH0RC0Pz89T8LiEFkwgaZcfU9RkGd
 KpF+4I5Tpt8hyw21FakfwkdEQkvIKIQqSUcsS21pwRjJQjrJBcG8UtxS0FsQwHLgxyx4
 pXZA==
X-Gm-Message-State: AOJu0YyKdAqwH8k4CXbCucsdyKzEktddFK4j0AbbncvmP1wpiUGLZ6Ce
 8EiNeZEoM2dtz/47xbWqQIqHqzd5lMjCmuEexhmPb3cSOdTKxxqT
X-Gm-Gg: ASbGncu+a2MUElUi0hPrZLLd8x69ZJcHla4C6VXtWqEaNzj7N71O5Ayb78pyB1Wd9AG
 C8YfVX3U7SGgIhild7oVJ6YYMl4LSRIpNn5igO9vpU8x67H0fCN56gZaWy6RRpBThE+vYZTV4JD
 a+siTpoJp1sQTq6GIVlYdr4bUne1Kmp8pkPlKNn3p6xofpgWYnWd7/Dh3k02r8V8bHwbnJt5MDT
 QprSW7tjUgXwMU+coh84K4UDhIMeFVL3iTC5CcI/gNtxz7Sus5ObgUdv36Z0h08wOkYg8mcPYk9
 FMkrTrBPpSwGm4sp4K+hsS9rv2Aeo/5N
X-Google-Smtp-Source: AGHT+IGWjK6Y5JjzO7MgWImpmRhNmDhpQQbtTZ64jzX+Z+iuaG8zywObQst0HUlISRFQayTz7UutlA==
X-Received: by 2002:a17:90b:582e:b0:2fe:a8b1:7d8 with SMTP id
 98e67ed59e1d1-30a4e6221f8mr17667628a91.25.1746426991380; 
 Sun, 04 May 2025 23:36:31 -0700 (PDT)
Received: from localhost ([1.146.78.151]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a3474896dsm10758374a91.19.2025.05.04.23.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:36:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 16:36:23 +1000
Message-Id: <D9O0P4IGPARS.2WFBSONJTYNNK@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>
Cc: <qemu-devel@nongnu.org>, "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Jason Wang" <jasowang@redhat.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Laurent Vivier" <lvivier@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 02/12] net/e1000e: Permit disabling interrupt throttling
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250502031705.100768-1-npiggin@gmail.com>
 <20250502031705.100768-3-npiggin@gmail.com>
 <ca80c0c3-e921-4f60-8a23-fcae0805e756@daynix.com>
In-Reply-To: <ca80c0c3-e921-4f60-8a23-fcae0805e756@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 5, 2025 at 3:41 PM AEST, Akihiko Odaki wrote:
> On 2025/05/02 12:16, Nicholas Piggin wrote:
>> The spec explicitly permits xITR register interval field to have a value
>> of zero to disable throttling. The e1000e model already allows for this
>> in the throttling logic, so remove the minimum value for the register.
>>=20
>> The spec appears to say there is a maximum observable interrupt rate
>> when throttling is enabled, regardless of ITR value, so throttle timer
>> calculation is clamped to that minimum value.
>>=20
>> EITR registers default to 0, as specified in spec 7.4.4.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/net/e1000e_core.c | 25 +++++++++++++++++--------
>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index 24138587905..96f74f1ea14 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -51,8 +51,17 @@
>>  =20
>>   #include "trace.h"
>>  =20
>> -/* No more then 7813 interrupts per second according to spec 10.2.4.2 *=
/
>> -#define E1000E_MIN_XITR     (500)
>> +/*
>> + * A suggested range for ITR is 651-5580, according to spec 10.2.4.2, b=
ut
>> + * QEMU has traditionally set 500 here.
>> + */
>> +#define E1000E_DEFAULT_ITR (500)
>
> The cover letter says this version changes "initial ITR as well as EITR"=
=20
> but the ITR value is unchanged here. Forgot to commit the change?

Hmm yes I must have, thanks good catch.

Thanks,
Nick

