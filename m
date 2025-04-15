Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB94C369B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 02:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4WFI-0000Ir-E7; Mon, 14 Apr 2025 22:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u4WFC-0000IW-Pd
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 22:41:50 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u4WFA-0004hu-RI
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 22:41:50 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227d6b530d8so48269625ad.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 19:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744684907; x=1745289707; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2+5yJsSyqWliMgVLnyA+8CDIJW89HvFx89ssRLzPb4=;
 b=KojvCtcprpTAhswO3wkRbiADG0A7gqhymRR6UnX+p74DCzgTzv4FL1NvWT1gB9FMHY
 l5YXII/bxvdl+6Fo2d/KDphfvJwNHsFZaq2ZbqhdD/tzMyWYlTIw/OLe2PMlcRRR4cz2
 9MnZAD6c7aRPoaZGI340Z1bBaCMV9sAJVEI1ewTJvwZHMoSF1F0WiQ0Ifty5NfI/7V73
 bWajsyU4SbC1nLoVsiieylW/ib28B2X/pICQaj0UX0bwN+JwYy9jb12jMwvrXKURtLns
 brwSf5FcCMMsVsDlwm0VD6/1Q2ybI4ld/Ln1KhIUT2hlBbIHSr/sMczC7kiK3fafhjxR
 PCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744684907; x=1745289707;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x2+5yJsSyqWliMgVLnyA+8CDIJW89HvFx89ssRLzPb4=;
 b=SnRe2FFCx4Vqpt+x3Kepaa8cM0MQMN0q3b4xpk3nu4zf3ZQMT50MJ1J3HZNLbmpTHS
 ZUfRU/sL1+R0cnyk1RupTROFquqD5gA08B9TgCBYQIORegY5CvYZyJCPEomXAyWGPx3N
 wYn4OqiblQ9dh5CHbgFWRx+qPbeLigLV0vSzqbnRSNRcZvkADUaG2R852POHk6cBjVUc
 t8uSW4ORQll5hy5fssVG+2ZXQ1Nvd3Hgn3kwewfGNKpdHt8IMESz2traO8LgjdBtdInW
 NvDVYqEZBqCZgLv4A7CVWTpZv7Z0utE1cfVPkAfB2xvAiaIvk9bDYKle/WjFgzdRynzp
 /0xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFzZDDvJXrk/QLckOcsGPoy8FSxK1bAAXI0cKiJrFMQKgTrH5MYz8kGeYw27gOAreyvlFDn+I09DUq@nongnu.org
X-Gm-Message-State: AOJu0YyqQfOUzBqAZdw/QNTdwLz9mm0ueL3hqJaufRbyRPFjyinaEl6b
 3G3W1mSmhZ117fQisceISYJeEv39exXLSZduQ/GawBPYcfqsXlaz
X-Gm-Gg: ASbGncshsPVkYqfwcN7XADQloe35MxMhsha5VvBaq2CPO62kiUjaLLbQJyyrTwa0x8c
 qu8Nrvun/l2gmyVE4V8q/b//ifzbhuZQgvNGVei4RASLWmgL2iCWjW3L+L/pk34Mq61N3nRp7xh
 0IQqlj/vfjN8v6p3wEh0Vl+XXrc3vWhdyFtG5GBs0R/zWWCs5+THxwBKtFIdhDOHmsjLGm2OT/H
 cPgM80OpYp2JPng7BiirPu40Ofh/cZl5zW9gKOx8sdTyw184t3itdwp0cg4RQ3c7TUUy8+fKsTi
 kTwl+bear/W0W6cCB4wAEEVLqszmalFp
X-Google-Smtp-Source: AGHT+IFpnPceht0rMRD1rFyyYjNCKjIktfadngwwKNTyfMXazaQlz5zcFgLCkpIjwigpXwaJr2xttQ==
X-Received: by 2002:a17:902:e547:b0:220:c911:3f60 with SMTP id
 d9443c01a7336-22bea4fd182mr195374855ad.47.1744684906938; 
 Mon, 14 Apr 2025 19:41:46 -0700 (PDT)
Received: from localhost ([1.145.34.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c9937fsm106747075ad.155.2025.04.14.19.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 19:41:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Apr 2025 12:41:39 +1000
Message-Id: <D96V6HTTNOF1.3DDO2NQ0AUEA0@gmail.com>
Cc: "Stefan Hajnoczi" <stefanha@redhat.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Phil
 Dennis-Jordan" <phil@philjordan.eu>
Subject: Re: [PATCH 1/2] system/main: transfer replay mutex ownership from
 main thread to main loop thread
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250410225550.46807-2-pierrick.bouvier@linaro.org>
 <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
 <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
 <dee088aa-436f-48dc-8a28-f675de42767b@linaro.org>
 <5cac93d4-e5a6-42b0-8f7b-5a273168a450@linaro.org>
In-Reply-To: <5cac93d4-e5a6-42b0-8f7b-5a273168a450@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Tue Apr 15, 2025 at 1:24 AM AEST, Pierrick Bouvier wrote:
> On 4/14/25 03:25, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/4/25 19:24, Pierrick Bouvier wrote:
>>> On 4/11/25 22:30, Nicholas Piggin wrote:
>>>> On Fri Apr 11, 2025 at 8:55 AM AEST, Pierrick Bouvier wrote:
>>>>> On MacOS, UI event loop has to be ran in the main thread of a process=
.
>>>>> Because of that restriction, on this platform, qemu main event loop i=
s
>>>>> ran on another thread [1].
>>>>>
>>>>> This breaks record/replay feature, which expects thread running
>>>>> qemu_init
>>>>> to initialize hold this lock, breaking associated functional tests on
>>>>> MacOS.
>>>>>
>>>>> Thus, as a generalization, and similar to how BQL is handled, we rele=
ase
>>>>> it after init, and reacquire the lock before entering main event loop=
,
>>>>> avoiding a special case if a separate thread is used.
>>>>>
>>>>> Tested on MacOS with:
>>>>> $ meson test -C build --setup thorough --print-errorlogs \
>>>>> func-x86_64-x86_64_replay func-arm-arm_replay func-aarch64-
>>>>> aarch64_replay
>>>>> $ ./build/qemu-system-x86_64 -nographic -icount
>>>>> shift=3Dauto,rr=3Drecord,rrfile=3Dreplay.log
>>>>> $ ./build/qemu-system-x86_64 -nographic -icount
>>>>> shift=3Dauto,rr=3Dreplay,rrfile=3Dreplay.log
>>>>>
>>>>> [1] https://gitlab.com/qemu-project/qemu/-/commit/
>>>>> f5ab12caba4f1656479c1feb5248beac1c833243
>>>>>
>>>>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2907
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> ---
>>>>>  =C2=A0 system/main.c | 4 ++++
>>>>>  =C2=A0 1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/system/main.c b/system/main.c
>>>>> index ecb12fd397c..1c022067349 100644
>>>>> --- a/system/main.c
>>>>> +++ b/system/main.c
>>>>> @@ -25,6 +25,7 @@
>>>>>  =C2=A0 #include "qemu/osdep.h"
>>>>>  =C2=A0 #include "qemu-main.h"
>>>>>  =C2=A0 #include "qemu/main-loop.h"
>>>>> +#include "system/replay.h"
>>>>>  =C2=A0 #include "system/system.h"
>>>>>  =C2=A0 #ifdef CONFIG_SDL
>>>>> @@ -44,10 +45,12 @@ static void *qemu_default_main(void *opaque)
>>>>>  =C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int status;
>>>>> +=C2=A0=C2=A0=C2=A0 replay_mutex_lock();
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_lock();
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D qemu_main_loop();
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_cleanup(status);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_unlock();
>>>>> +=C2=A0=C2=A0=C2=A0 replay_mutex_unlock();
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(status);
>>>>>  =C2=A0 }
>>>>> @@ -67,6 +70,7 @@ int main(int argc, char **argv)
>>>>>  =C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_init(argc, argv);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_unlock();
>>>>> +=C2=A0=C2=A0=C2=A0 replay_mutex_unlock();
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_main) {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QemuThread ma=
in_loop_thread;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_thread_c=
reate(&main_loop_thread, "qemu_main",
>>>>
>>>> Do we actually need to hold replay mutex (or even bql) over qemu_init(=
)?
>>>> Both should get dropped before we return here. But as a simple fix, I
>>>> guess this is okay.
>>>>
>>>
>>> For the bql, I don't know the exact reason.
>>> For replay lock, we need to hold it as clock gets saved as soon as the
>>> devices are initialized, which happens before end of qemu_init.
>>=20
>> Could be worth adding a comment with that information.
>>=20
>
> In case someone is curious about it, changing default state of lock can=
=20
> answer why it's needed, as it crashes immediately on an assert.

That all sounds reasonable enough and good info. I'm not suggesting to
remove the lock from qemu_init() by assuming we are in init and init is
single threaded (I agree it's good practice to keep locking consistent).

My question was more that we should move the locks tighter around
the operations that require them. Move the unlock into qemu_init().

Commit f5ab12caba4f1 didn't introduce this problem, cocoa_main()
already immediatey called bql_unlock() so effectively the issue is
still there. The original design before cocoa I guess was that qemu_init
would init things under the same critical section as qemu_main_loop() is
then called, which is reasonable and conservative. It would have been
good to see this bql split get a specific patch to epxlain why it's not
needed across qemu_init and qemu_main_loop, but no big deal now.

The patch is fine for a fix, could I suggest another patch that
moves the lock narrower and perhaps adds a few words of comment?

Thanks,
Nick

