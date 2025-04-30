Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F98C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 00:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9usn-0002KO-Gu; Tue, 29 Apr 2025 20:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u9usk-0002K2-Sx; Tue, 29 Apr 2025 20:00:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u9usj-0006tw-51; Tue, 29 Apr 2025 20:00:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2279915e06eso76164925ad.1; 
 Tue, 29 Apr 2025 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745971254; x=1746576054; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp+BmmdqaPIOB7vBXabGioxQafO4oblBicMZFFr5CFc=;
 b=UOlXK5ZlpUFEZYFEE8xxhiniwp4xq8CSstulZxnPd9c9oldIPEV1um/DzWwcwPLoJZ
 l6aLUrPsPROoeZfD0xXoYhDqJxNMK8JV7cSgwa+OYXK4RLlj2EJ9bNjGQGRdynnBcaxn
 gOM2nS00jWWKCA8MgnHxiSPPXOCDjTYVcUyMo8ecxs4hyLHOsUAUfjdtha3Y4Xp2eXVW
 UUNVogZQWq5Q56ZDzdLwToL13zaPyvA6EvCMKAl66fJ4YCGWBRlVDb/mg0cDf+1oBhz6
 u02DM3243VsZsOOmPrhY4SWWUMUeB9nsGIcBW8pRo5GsRt3ilC0P8+Z3IQ2wNQw+XCVc
 pCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745971254; x=1746576054;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rp+BmmdqaPIOB7vBXabGioxQafO4oblBicMZFFr5CFc=;
 b=u0DepYoJ88T2Q3i9AI2no+ayte9yVWQTtDBSBcaBbe1wAh7VVowKZT1mveS5Jsb/Bm
 WqX7c41uZAwm5EHpbiAxmtpOa0ex/8TiS7XNS+vImH3sBmIALZLWDWBksFQITcY9tX8N
 ah8m2T+bVyG/wKOZ8XiSi08X+zTRd5g/0AdsH9kTXmct5ONXPv/Ls1g5LW7+aXyNnPqU
 92ERWtRHd90m3eOTuJrD/nsKQHFl6aiNHFWQvtZTvmc9WtfimW2RnhgcQAYaDdMDXOCq
 9pXoiiaLIGhqgzCh2g72g27R7IOnS8uStc2Wq5eEM/cVvSXviaQZ28nf97XiBGgUKBKO
 YXNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmq765EGdadWmHlf+fvLS4r8554R9kVZORTejseZ27/PlNkMBCCkfOfJODpft6K7fh0Qj5Jqp/nH3o@nongnu.org,
 AJvYcCV+nFdHNLyEqOTB5nJRVysv8FzemdZTU2+9EGNoBmUOxxhRfb3fawcaWgw9i8MVhmuHRmfAuo9jn75jLes=@nongnu.org
X-Gm-Message-State: AOJu0YynhyKeKxnrSLBhM+fmrDc2BOwNKEwXC64J0sjsNetMZWg1K9rr
 tl4TZkbBcF4gi6HdT+yUlwhEZ0OROCr95f06PJsI02w9F+FEAj6Io4BUXGZx
X-Gm-Gg: ASbGnctbpGdL0iP3ZGUvv3rz9yoR1/DEpITqCXyJ9QxpBKrGhdl12OHZBwIyGQa4MnU
 r5ooryy5z2ih5739fVQ3wmCW/Xbgz9pYNlX0+J5Z5KgSPRdW16zWdE/dcaFjfxjtwFRdeMEba3F
 ZFq0QIFOuHjrjBpMqKULy4evC/NMMN152m6bDekR0Bh5sGZtlEc87ToMK9YsQxW1yLtwltO7bUu
 LlkeZYxT+JC9I7r4AItuTDq9wjGT35W1rxf/Fwo4FFr3kVY5/1Ei4rMziuCaQdzt0phJeCI7257
 wgnzJJSxY7kzXHfkeO7WKmxcm6x0k8Uj
X-Google-Smtp-Source: AGHT+IFfdmjraXc720GT5AxlxEHu0rvJK3vKTaaq6d01gOQEhfD26p5lbdQrvJ6/cI49Ua+DkyKMIw==
X-Received: by 2002:a17:903:188:b0:224:6ee:ad with SMTP id
 d9443c01a7336-22df5861e8fmr7395985ad.44.1745971253774; 
 Tue, 29 Apr 2025 17:00:53 -0700 (PDT)
Received: from localhost ([1.145.95.178]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db51023a4sm109082195ad.167.2025.04.29.17.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 17:00:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Apr 2025 10:00:48 +1000
Message-Id: <D9JJ5IIYVLVG.2RQ8C03WHFVBZ@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <qemu-stable@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
Subject: Re: [PULL 1/2] target/ppc: Big-core scratch register fix
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250408124550.40485-1-npiggin@gmail.com>
 <20250408124550.40485-2-npiggin@gmail.com>
 <2d6dead5-f56c-43cf-b7d1-9567fef99616@redhat.com>
In-Reply-To: <2d6dead5-f56c-43cf-b7d1-9567fef99616@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Thu Apr 24, 2025 at 6:25 PM AEST, Thomas Huth wrote:
> On 08/04/2025 14.45, Nicholas Piggin wrote:
>> The per-core SCRATCH0-7 registers are shared between big cores, which
>> was missed in the big-core implementation. It is difficult to model
>> well with the big-core =3D=3D 2xPnvCore scheme we moved to, this fix
>> uses the even PnvCore to store the scrach data.
>>=20
>> Also remove a stray log message that came in with the same patch that
>> introduced patch.
>>=20
>> Fixes: c26504afd5f5c ("ppc/pnv: Add a big-core mode that joins two regul=
ar cores")
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   target/ppc/misc_helper.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>> index 2d9512c116..46ae454afd 100644
>> --- a/target/ppc/misc_helper.c
>> +++ b/target/ppc/misc_helper.c
>> @@ -332,6 +332,10 @@ target_ulong helper_load_sprd(CPUPPCState *env)
>>       PnvCore *pc =3D pnv_cpu_state(cpu)->pnv_core;
>>       target_ulong sprc =3D env->spr[SPR_POWER_SPRC];
>>  =20
>> +    if (pc->big_core) {
>> +        pc =3D pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x=
1);
>> +    }
>> +
>>       switch (sprc & 0x3e0) {
>>       case 0: /* SCRATCH0-3 */
>>       case 1: /* SCRATCH4-7 */
>> @@ -368,6 +372,10 @@ void helper_store_sprd(CPUPPCState *env, target_ulo=
ng val)
>>       PnvCore *pc =3D pnv_cpu_state(cpu)->pnv_core;
>>       int nr;
>>  =20
>> +    if (pc->big_core) {
>> +        pc =3D pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x=
1);
>> +    }
>> +
>
>   Hi Nicholas,
>
> this patch breaks compilation when QEMU has been configured with=20
> "--without-default-devices" :
>
> FAILED: qemu-system-ppc64
> cc -m64 @qemu-system-ppc64.rsp
> /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in=20
> function `helper_load_sprd':
> .../qemu/target/ppc/misc_helper.c:336:(.text+0xcab): undefined reference =
to=20
> `pnv_chip_find_core'
> /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in=20
> function `helper_store_sprd':
> .../qemu/target/ppc/misc_helper.c:376:(.text+0xda3): undefined reference =
to=20
> `pnv_chip_find_core'
> collect2: error: ld returned 1 exit status
>
> Could you please have a look?

Thanks for the report, I have a hopefully simple fix just going through
CI now... Do you know if there's any reason to exclude a bunch of
targets in the build-without-defaults CI test? I wonder if we could just
enable all, it shouldn't add too much time to build test.

Thanks,
Nick

