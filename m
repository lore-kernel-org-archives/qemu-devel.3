Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21D2C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNl6-0007yk-CD; Mon, 31 Mar 2025 18:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzNl4-0007yY-Ob
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:37:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzNkz-0001lf-Mt
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:37:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22423adf751so90890725ad.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743460644; x=1744065444; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pzy7fPM0LimBKejIk0gWbTSWYIijATYbtNBneOuSju8=;
 b=YOl/mFujnfJbIYp8CGbxcyf4IbRTUSBcmBdqOKTB40fww1iCEtdKZ37IsbC51hxyA7
 QUY4z1sHwDzxZW5ur4qbmgQwy48btUjh8XoacAThUiIVHHXEeNXk8iXFZVhfYzMPcMY5
 iUNtDjGfcvEYnnTpV7XmJAWuNjhOSVdtCZjJhQ9vD6RNusoJ8RK/kn7uNljJ5U00g8N6
 yWPtXwuaer4V1ns07jibPdYgkTaodKO1h+bNAvGRxdBDlGA6wUx1AxAoKZ5WlhbI1rmI
 FTpUfinFtzHhc8lbBCj6ut7Hh5oI6SKGz8Q80Q1dU/SHGu/FDiYd9Ga45vz8wc+YSK1G
 XJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743460644; x=1744065444;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pzy7fPM0LimBKejIk0gWbTSWYIijATYbtNBneOuSju8=;
 b=vHek6JcwtUCjx+Aie6Q0gXMYrb70AEp687TXp3LLX4H5TywZDXyu1sqk2QapVzEYZA
 sn1l3Hc6DKdjXb6dK7AdWtkQYMHDLYGPigaDn9ejTw/Hs7i22vqoVBQYHkkUTR2PwDk0
 bHVjVpO2Htu8lNPrmnHbhPt4kt3ajZLu48bLjokqr+YawVuBiNnxuDcT/Pw7prCkzXWM
 DEYVuJorf6fXgPy4IKrU+bXhKE6z9zDktGhxF5ITL3n/23IDwEEkPacDICSenwfI25LP
 caKzcVQvrx55aE7VE8yOQZ9GSRn9GQQEy+iy5IGux7+YwQLRsy7SHOJZvbNQI4V5ms9L
 8gQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbqU8f9YB7D6I3flRxgsKO3U5bYPAhW4tLGLYlgP2fb1R6B0+Ac5fvgSvW6Ql0iBJiU44F8joiAzkQ@nongnu.org
X-Gm-Message-State: AOJu0Yy8ag/UAgwT+KxcQl/T+D+mHxy2HiKhRQpHO9ZA2766tAOWP1Pe
 jWLQVBgu3ld8He3T8zQ1GhsLMlGTS1p5+fPKvuNPUU/CZwR+iO43
X-Gm-Gg: ASbGncuRJIt1vJUZ1/5nJtfgf134q+3QC6asZLkUgMh41uU09lw90Z++sFx6hrCrs8Y
 QRxN9NJLIF98tq4yyLkfLRz4ZAO3b/vzt83YpMP5CLE9uwrnN3kNicYdMMV+hTcfgG6GRW7IX1m
 rBeXwPMXPz8q0TGtm4UIHlFhd0obtEdKFEk4QSDftyN9kpeeQKGzsQj+HmpaoMgg8hqIacqW5TJ
 aR8r6ez2WzHJWzOwMdiTOhOWMKiKGJsrLB7a/3IOu05+KsnIgdnqoodyQF5B4x4r60lLgUONl81
 59ELr/2Q73U4orSRFFMsE5t/TXQXHjxZrhTrRKA=
X-Google-Smtp-Source: AGHT+IEFtBgDYpYWLl7uWCHyxR4XbwgNXHfW+EwbZLKPzU8otsHYnz1jqTI0b9TEkgdS7uhJ0NxAAg==
X-Received: by 2002:a05:6a00:80e:b0:736:a540:c9b5 with SMTP id
 d2e1a72fcca58-739b611984amr990479b3a.22.1743460643858; 
 Mon, 31 Mar 2025 15:37:23 -0700 (PDT)
Received: from localhost ([203.185.207.94]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970deec96sm7550803b3a.34.2025.03.31.15.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 15:37:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 08:37:19 +1000
Message-Id: <D8UT7SKP9L19.126NYIT8BU3AI@gmail.com>
Cc: "Corey Minyard" <minyard@acm.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/3] ipmi/bmc-sim: implement watchdog dont log flag
From: "Nicholas Piggin" <npiggin@gmail.com>
To: <corey@minyard.net>
X-Mailer: aerc 0.19.0
References: <20250331125724.607355-1-npiggin@gmail.com>
 <20250331125724.607355-2-npiggin@gmail.com>
 <Z-qU_5RWxK-qpGTn@mail.minyard.net>
In-Reply-To: <Z-qU_5RWxK-qpGTn@mail.minyard.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

On Mon Mar 31, 2025 at 11:13 PM AEST, Corey Minyard wrote:
> On Mon, Mar 31, 2025 at 10:57:22PM +1000, Nicholas Piggin wrote:
>> If the dont-log flag is set in the 'timer use' field for the
>> 'set watchdog' command, a watchdog timeout will not get logged as
>> a timer use expiration.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ipmi/ipmi_bmc_sim.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
>> index 6157ac71201..32161044c0b 100644
>> --- a/hw/ipmi/ipmi_bmc_sim.c
>> +++ b/hw/ipmi/ipmi_bmc_sim.c
>> @@ -733,7 +733,12 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs=
)
>> =20
>>   do_full_expiry:
>>      ibs->watchdog_running =3D 0; /* Stop the watchdog on a timeout */
>> -    ibs->watchdog_expired |=3D (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
>> +
>> +    /* Log the expiry if the don't log bit is clear */
>> +    if (!IPMI_BMC_WATCHDOG_GET_DONT_LOG(ibs)) {
>> +        ibs->watchdog_expired |=3D (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs)=
);
>> +    }
>> +
>
> Are you sure this is correct?  The spec doesn't say what this means, but
> I would assume this means "Don't add a system log" not "Don't set the
> expiry happened bit".

From IPMI spec, Set Watchdog Timer command timer use field of byte 1
says "timer use (logged on expiration when =E2=80=9Cdon=E2=80=99t log=E2=80=
=9D bit =3D 0b)".
But it also says it should disable the timeout sensor event logging.
I missed that part, I will see if I can make that work.

Thanks,
Nick

