Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367C5FED3D6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGHeZ-00038p-Te; Fri, 24 Apr 2026 10:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wGHeW-00038S-RY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:37:09 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wGHeT-0000Tk-Dh
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777041417; x=1777646217; i=deller@gmx.de;
 bh=GAinCfHAFP2X3LEIScCO6+xYsGHC/WEEiBgfteQbZOA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NR+agAvJx9JmCeYSc0KRjk0lWhpn8HNzz487CMcMzUEmarlSxqUCofUeQZ33EaZK
 e4K6SZadijFlBpHJpeYb7DBMJ/FDVG4JG2V9dAkUetvxhH51DkINaR8LPNA7vxMIr
 RuXkXjctLGj5SvEmfdHkj8Kns6NQ4O4NA2fowCgQNOl5OzJgrh1PVh5loLlPcZd6E
 uEj5TGU3jK0RhyJzqeo1iv6lC4rkmBNwMs4OEsCeIKGgCTWkUlId+HV6O9GVQbNPT
 XltxMTos3EquvCtcLoSykbjjY33eDZt9Rw3pJiwQs0IehVOFmVN5i0twEXqt3NF+V
 F54+v/7e2VvidLjPJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1vrfOt2fn8-00PL85; Fri, 24
 Apr 2026 16:36:57 +0200
Message-ID: <2e676b2c-073d-405f-9354-5b1a456fba83@gmx.de>
Date: Fri, 24 Apr 2026 16:36:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix CLONE_PARENT_SETTID when using fork-like
 clone
To: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20260424132824.27733-1-deller@kernel.org>
 <CAFEAcA-CwZZrSVHE5qPSGw0gCM_0Nh6e5X5-W_EDSSkv62LAyQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA-CwZZrSVHE5qPSGw0gCM_0Nh6e5X5-W_EDSSkv62LAyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CnUJPySzVOECnLlRQQn9dKGETUjlok9wXDqqlTaOWX4Oc9+kVZl
 8AfhekI1DzBMyYO4Prs7l97DULqqZvaVnWhRku94JuG7DOXGZXmEB8jnYZ5fvXgOWBSfKHD
 AY9MQbL9C5JNweQpBubIYayEMQ6rFRm6erzVQzGqQxt/MIWA9v8VJfGilRBEDOX7e+hm8+Z
 UVJQISMyNJv+AfVsojDEA==
UI-OutboundReport: notjunk:1;M01:P0:tpP8sFF6azE=;o5TTJfvtZo+h/kfyAFS2txVgFf4
 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
 uu3AZobNLHZpUthVDUj6gDs9YV/JYc9ilEXQ=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Hi Peter,

On 4/24/26 15:39, Peter Maydell wrote:
> On Fri, 24 Apr 2026 at 14:28, Helge Deller <deller@kernel.org> wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> The CLONE_PARENT_SETTID option requires the implementation to store the
>> child thread ID at the location pointed to by parent_tid in the parent'=
s
>> memory.
>>
>> Fix our implementation and move the code from the client side (where
>> fork returned 0), to the parent side and store the return value from th=
e
>> fork call (which is the client TID) in the parent_tid pointer.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3340
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>   linux-user/syscall.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index d0390e04b4..910a4da0a6 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7050,8 +7050,6 @@ static int do_fork(CPUArchState *env, unsigned in=
t flags, abi_ulong newsp,
>>                  the child process gets its own copy of the lock.  */
>>               if (flags & CLONE_CHILD_SETTID)
>>                   put_user_u32(sys_gettid(), child_tidptr);
>> -            if (flags & CLONE_PARENT_SETTID)
>> -                put_user_u32(sys_gettid(), parent_tidptr);
>>               ts =3D get_task_state(cpu);
>>               if (flags & CLONE_SETTLS)
>>                   cpu_set_tls (env, newtls);
>> @@ -7059,6 +7057,8 @@ static int do_fork(CPUArchState *env, unsigned in=
t flags, abi_ulong newsp,
>>                   ts->child_tidptr =3D child_tidptr;
>>           } else {
>>               cpu_clone_regs_parent(env, flags);
>> +            if (flags & CLONE_PARENT_SETTID)
>> +                put_user_u32(ret, parent_tidptr);
>>               if (flags & CLONE_PIDFD) {
>>                   int pid_fd =3D 0;
>=20
> The clone(2) manpage says that CLONE_PARENT_SETTID stores the
> *child* thread ID -- shouldn't we be storing child_tidptr here ?
Sorry, but I don't get your point.
Even before we stored the TID of the child (sys_gettid())
at the location "parent_tidptr". Now we still store the TID of the child (=
which
is the one returned from the fork()) at "paret_tidptr".
Why are you mentioning child_tidptr?

Helge

