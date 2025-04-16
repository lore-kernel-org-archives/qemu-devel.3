Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36661C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 03:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4tGQ-0002Vk-CT; Tue, 15 Apr 2025 23:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u4tGO-0002VT-VD
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 23:16:37 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u4tGM-0003oO-UB
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 23:16:36 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so2829954b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 20:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744773392; x=1745378192; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFUPBZRAfipWI2IhgFTKirKDKIIaY6khLK6b2Z4CfVg=;
 b=i/zYM7c4Jw0X263YZLyFtYCv+HRMXADVxNG7huqF7G+o9Cpa5VBq2F+fAKOyO83IYT
 OfljZUp1HsjMKxqFCaV9Mkw9F3qqvH3RFR+W22uFf5QwYF2X2lbjAlDc2elh8xWPcCpT
 hNzYxSyTFCUKswGJi19M+Vm07g7UAsWIZBb0xX7B6MAzC/TsEU3XqDvabvseNImMWdez
 qRGHiwhBSr4IkLauEuNI0M0HVI1lp+K7KfzwVlrB0edUdZunPqZMNcDbtwPFl58/hCsY
 12fEjFmKayo6FxLJi+X34mAMVcz8X62mok2It2BlTS78vqL7fRGpFfIF8wBCKA8aZ0IJ
 rL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744773392; x=1745378192;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kFUPBZRAfipWI2IhgFTKirKDKIIaY6khLK6b2Z4CfVg=;
 b=YIXPAQDk3KmAWYLJCWdDunDbXz8yXus+VbKRouklaU94lHWb+8aDJ8dgvQzj3D7I05
 m0P4AWCffMGOPHX/FowsyyBDXb0UNLBj4gdXfl+yV9gER9ucFHuY4sEpAfWge1Aj3FMV
 xlWDH9kC9xye0Z0rufbAu+Vr4i+YPXW4i/tmLnCdj4Rwkfu8f6lBev/u1zAgMc9Bvj70
 oHDfcUBGh7NJGrv4CXWi5uGgBLHqKEIIBaaKWPJxstYdj66JLX10iVNafpw58NgVj3iK
 twr6swxmlX3IUAMnxUMWL0j+g1+fwc/H9ZJD00UHx17tcafFHH0LC1NFPSQTYLGHwXaJ
 eiaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv7oekDNGdUlLRwUdee/G7vptFGw2/G4BcX5qyn+a0ccpIwrzwrEPD1J2ypVAtyRFE1dXQ0tWHOyMz@nongnu.org
X-Gm-Message-State: AOJu0Yy1QdM84R0HFEAZRlPEdLmEHq4khGMBXC4U4jGtY6imJDjsCNcG
 fy9sN2IkQEeWDklv6oKxUr7eGc+9lOdL86jm51/iSzZVSJ6/BLer
X-Gm-Gg: ASbGncuxlhlSrg0Qj9sClvgwVb2yNMQZLg7sdCw7bSZzMoBPWpQ0WU6lXDY0UO4qxXD
 ZPKW3gBXwCGONpER/M3Qu0SIjIo1eTEr8DChZA5pHgngb3wYJRPD5WtgRSW5kbZIIdMxkFYUQA0
 0hqYh6Zdrs2FRTsDgGpmCvV6fi6PEyGEqLGthO9OYaMb45QT6KBBAwO4UJ5DFpA+iom+odbwiFR
 vd/gy7MhzXriiZp9MgLxFJaekwete1l1te2a5W3JgV8PcA3U53iur83JEJfBQjgxjjqUWA4z8hc
 5QGBGycxfazwWB6fTELPT9yneMR0DHc=
X-Google-Smtp-Source: AGHT+IEk509I+8vInsGMWf+RbWnb0s6+nobMCaEFeszILo0fXkklbwyiGJYF1Ln2QUXGWTXke7L0+w==
X-Received: by 2002:a05:6a00:1da6:b0:739:3f55:b23f with SMTP id
 d2e1a72fcca58-73c2671803fmr317949b3a.14.1744773392165; 
 Tue, 15 Apr 2025 20:16:32 -0700 (PDT)
Received: from localhost ([1.145.6.120]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b2221eb8bsm286011a12.75.2025.04.15.20.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 20:16:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Apr 2025 13:16:25 +1000
Message-Id: <D97QJO5Z909K.368VVIBFA17TA@gmail.com>
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Stefan Hajnoczi" <stefanha@redhat.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Phil
 Dennis-Jordan" <phil@philjordan.eu>
Subject: Re: [PATCH 1/2] system/main: transfer replay mutex ownership from
 main thread to main loop thread
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250410225550.46807-2-pierrick.bouvier@linaro.org>
 <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
 <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
 <dee088aa-436f-48dc-8a28-f675de42767b@linaro.org>
 <5cac93d4-e5a6-42b0-8f7b-5a273168a450@linaro.org>
 <D96V6HTTNOF1.3DDO2NQ0AUEA0@gmail.com>
 <f8a90e7b-daa7-4c87-9702-e80e9d5b162e@linaro.org>
In-Reply-To: <f8a90e7b-daa7-4c87-9702-e80e9d5b162e@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

On Wed Apr 16, 2025 at 4:31 AM AEST, Pierrick Bouvier wrote:
> On 4/14/25 19:41, Nicholas Piggin wrote:
>> On Tue Apr 15, 2025 at 1:24 AM AEST, Pierrick Bouvier wrote:
>>> On 4/14/25 03:25, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 12/4/25 19:24, Pierrick Bouvier wrote:
>>>>> On 4/11/25 22:30, Nicholas Piggin wrote:
>>>>>> On Fri Apr 11, 2025 at 8:55 AM AEST, Pierrick Bouvier wrote:
>>>>>>> On MacOS, UI event loop has to be ran in the main thread of a proce=
ss.
>>>>>>> Because of that restriction, on this platform, qemu main event loop=
 is
>>>>>>> ran on another thread [1].
>>>>>>>
>>>>>>> This breaks record/replay feature, which expects thread running
>>>>>>> qemu_init
>>>>>>> to initialize hold this lock, breaking associated functional tests =
on
>>>>>>> MacOS.
>>>>>>>
>>>>>>> Thus, as a generalization, and similar to how BQL is handled, we re=
lease
>>>>>>> it after init, and reacquire the lock before entering main event lo=
op,
>>>>>>> avoiding a special case if a separate thread is used.
>>>>>>>
>>>>>>> Tested on MacOS with:
>>>>>>> $ meson test -C build --setup thorough --print-errorlogs \
>>>>>>> func-x86_64-x86_64_replay func-arm-arm_replay func-aarch64-
>>>>>>> aarch64_replay
>>>>>>> $ ./build/qemu-system-x86_64 -nographic -icount
>>>>>>> shift=3Dauto,rr=3Drecord,rrfile=3Dreplay.log
>>>>>>> $ ./build/qemu-system-x86_64 -nographic -icount
>>>>>>> shift=3Dauto,rr=3Dreplay,rrfile=3Dreplay.log
>>>>>>>
>>>>>>> [1] https://gitlab.com/qemu-project/qemu/-/commit/
>>>>>>> f5ab12caba4f1656479c1feb5248beac1c833243
>>>>>>>
>>>>>>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2907
>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>>> ---
>>>>>>>   =C2=A0 system/main.c | 4 ++++
>>>>>>>   =C2=A0 1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/system/main.c b/system/main.c
>>>>>>> index ecb12fd397c..1c022067349 100644
>>>>>>> --- a/system/main.c
>>>>>>> +++ b/system/main.c
>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>   =C2=A0 #include "qemu/osdep.h"
>>>>>>>   =C2=A0 #include "qemu-main.h"
>>>>>>>   =C2=A0 #include "qemu/main-loop.h"
>>>>>>> +#include "system/replay.h"
>>>>>>>   =C2=A0 #include "system/system.h"
>>>>>>>   =C2=A0 #ifdef CONFIG_SDL
>>>>>>> @@ -44,10 +45,12 @@ static void *qemu_default_main(void *opaque)
>>>>>>>   =C2=A0 {
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int status;
>>>>>>> +=C2=A0=C2=A0=C2=A0 replay_mutex_lock();
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_lock();
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D qemu_main_loop();
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_cleanup(status);
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_unlock();
>>>>>>> +=C2=A0=C2=A0=C2=A0 replay_mutex_unlock();
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(status);
>>>>>>>   =C2=A0 }
>>>>>>> @@ -67,6 +70,7 @@ int main(int argc, char **argv)
>>>>>>>   =C2=A0 {
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_init(argc, argv);
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_unlock();
>>>>>>> +=C2=A0=C2=A0=C2=A0 replay_mutex_unlock();
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_main) {
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QemuThread=
 main_loop_thread;
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_threa=
d_create(&main_loop_thread, "qemu_main",
>>>>>>
>>>>>> Do we actually need to hold replay mutex (or even bql) over qemu_ini=
t()?
>>>>>> Both should get dropped before we return here. But as a simple fix, =
I
>>>>>> guess this is okay.
>>>>>>
>>>>>
>>>>> For the bql, I don't know the exact reason.
>>>>> For replay lock, we need to hold it as clock gets saved as soon as th=
e
>>>>> devices are initialized, which happens before end of qemu_init.
>>>>
>>>> Could be worth adding a comment with that information.
>>>>
>>>
>>> In case someone is curious about it, changing default state of lock can
>>> answer why it's needed, as it crashes immediately on an assert.
>>=20
>> That all sounds reasonable enough and good info. I'm not suggesting to
>> remove the lock from qemu_init() by assuming we are in init and init is
>> single threaded (I agree it's good practice to keep locking consistent).
>>=20
>> My question was more that we should move the locks tighter around
>> the operations that require them. Move the unlock into qemu_init().
>>=20
>> Commit f5ab12caba4f1 didn't introduce this problem, cocoa_main()
>> already immediatey called bql_unlock() so effectively the issue is
>> still there. The original design before cocoa I guess was that qemu_init
>> would init things under the same critical section as qemu_main_loop() is
>> then called, which is reasonable and conservative. It would have been
>> good to see this bql split get a specific patch to epxlain why it's not
>> needed across qemu_init and qemu_main_loop, but no big deal now.
>>=20
>
> Looking more closely, bql_lock ensure vcpus don't start executing=20
> anything before init is completed. So we really want to hold the lock=20
> through all qemu_init().
>
> Concerning replay_lock, during init, icount_configure calls=20
> qemu_clock_get_ns, that calls replay_save_clock, which expects to have=20
> the lock. Thus, we should hold the lock, at least during icount=20
> configuration.

Sounds reasonable.

>> The patch is fine for a fix, could I suggest another patch that
>> moves the lock narrower and perhaps adds a few words of comment?
>>=20
>
> We would still need to acquire locks in qemu_default_main() anyway.
>
> For bql, we definitely want to hold it anytime through init, so the=20
> scope is end of init.
> For replay_lock, it could be moved around parts that expect it during=20
> initialization, but what would be the benefit, considering only one=20
> thread is running during init?
>
> Moving locks narrower is usually made to allow more concurrency, at the=
=20
> price of increased complexity. In init phase, only one thread runs=20
> anyway, so there is no benefit to do anything around here.
>
> What we could eventually do is move those unlock at the end of=20
> qemu_init, but IMHO, it's more readable to see the lock/unlock scheme in=
=20
> a single place, in system/main.c.
> As well, I think it's better to have a single code path for lock/unlock,=
=20
> whether we use a background thread or not (vs adding a bool parameter to=
=20
> qemu_default_main() saying if we are in the same thread, or a different=
=20
> one).

I think the benefit is just code clarity. I think a function returning
with a different lock state that it is called with generally is not
desirable if it can be avoided.

qemu_init() caller just releasing locks immediately doesn't really serve
a benefit. A comment can be added to say that when qemu_init() returns,
bql is not held and CPUs may be running. This would be the same for any
configuration of background thread or not.

I don't want to bikeshed it too much, if you prefer not to move it. It is
nly one specialized case. Adding some comments about the purpose of the
locks is more important than if you release them here or in the callee.

Thanks,
Nick

