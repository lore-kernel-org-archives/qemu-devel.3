Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83DBCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jQO-0005vS-Kk; Thu, 25 Sep 2025 06:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v1jQK-0005v9-JS
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:42:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v1jQA-0006S5-06
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:42:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so3039905e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758796908; x=1759401708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtD3T6Td+hGxnXh33G/XfNcgPIrHWR+0s5Th1KPZ90E=;
 b=rMCPYTslkZHMY0D3befXYqRf27uz3mbhBiq/WC2ns2Wes21mPx0M7LBnmt3nkgT8dI
 c0jIFggytGH/jokv3Fn1aQjSrHCKK9UzurqPsBuYP/mfr4wk08u8gZXNcEG58U4BWCuX
 MFJCY4+0E4OSqcQa2GZuKq/tsjaNMwFsGvdg1pmEcNWnM+wh4A7m47uMQLJS1B4PqLvK
 zO+MLjlPSA7deik9v3huRZwUAfJIYM+1cjgCVULi9mRu2U5Td6e7PTscMargVVV1xMQW
 S6LXf7W/zVhx4RnesbE7E4hHNu++zf+RdbU+3guvdJQAGagaBDQeYK/xp2uU8ls/MQeB
 X+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796908; x=1759401708;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QtD3T6Td+hGxnXh33G/XfNcgPIrHWR+0s5Th1KPZ90E=;
 b=iqVSNEJ31Y5cdSP740udrbkdJzxd2LD7LWEXaO/WLpMtUZR+vb0t4rkEMz+gADm1Vw
 9/SWv4xqPoU/6hrsz9dxmiMO+4UhDGDizA0m/Ftwrv2BF7rKitOMil1AdfUNBIEvCODm
 AGVE7P024J/7SnVgaYKZEFm0QPh0VawuW2n9qPg8IvHycCSdrY344pkz/btSkIVNTkip
 jCywoSixNf0GUWJ7iN2bzqtmDWUMqOgbDqY6GYzh6g3Wn1j9m7gmopuF50XUJIQrViLm
 090OjDQYROXNS1Rzv+VCIxXpm9AnwIo6uhz0lRSXfCc8tsxqmG743jHtvTeebraG32JZ
 3alg==
X-Gm-Message-State: AOJu0YzSJ5a6MuRkle0F9GvPgvuEz1CUhSxfgHcBuEE2AdBb81Gkobu4
 XiqNQXfjsrjxP7K+Bm2hOcm5AbKPLPt0MtrdYnxx80tFEgvwOIOE6XY1csYGSD1KNXs=
X-Gm-Gg: ASbGncuV/VeEWauRUIvhOXMUmU1BzpmGczix6fc1n+2/JR/N14Sc2+6z3yBPanX+4Cm
 m8Dx0JGITO5Fl/HFGbysNGx607WymOMVEwj3JXjPRZmJnksIx2V3qosUpZhUDHuNwPkmM4vGjhn
 8LqREk79jCOG0xb++Ll/xKppIwVme0gxzxI6YnavUZ43Mky1ZwhsjDwv7xeQL/nzalnD2IwFW6l
 RxEV7/HRrAgJ80QZ/nJ4o4DpNFnkPu5RU4CQ1bS5wKOJt0zJpJsYUvCZVB4WZoXHqiiynFqieuW
 tn65ZPKfm6ubwxnVERIouh2R4qfSw0f1PJvY5HUy33oau3VruW2ROSH3qC5D9aR6zWxG04EiMwS
 htmFPxYqJ8f1KLhPvHBzm2c0=
X-Google-Smtp-Source: AGHT+IFCYXBZ3h4j049XWa/Rm12sfkR/q+N6+j5TYXHjLGbNGrlmlPSnoZg0JhSS1yPdXVNRY86E7w==
X-Received: by 2002:a05:600c:4fd3:b0:45e:598:90b0 with SMTP id
 5b1f17b1804b1-46e329ba780mr30319565e9.9.1758796908101; 
 Thu, 25 Sep 2025 03:41:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc56f7badsm2427065f8f.29.2025.09.25.03.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 03:41:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 08DA75F8AC;
 Thu, 25 Sep 2025 11:41:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Julian Ganz" <neither@nut.email>
Cc: qemu-devel@nongnu.org,  "Pierrick Bouvier"
 <pierrick.bouvier@linaro.org>,  "Alexandre Iooss" <erdnaxe@crans.org>,
 "Mahmoud Mandour" <ma.mandourr@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 23/25] tests: add plugin asserting correctness of
 discon event's to_pc
In-Reply-To: <359dc52bc7ebe3ea8a3d549f23d42a592066d685@nut.email> (Julian
 Ganz's message of "Wed, 24 Sep 2025 15:31:41 +0000")
References: <cover.1757018626.git.neither@nut.email>
 <073cad7dd8ae509ff64a2835fd146833b60c1f60.1757018626.git.neither@nut.email>
 <87segf69f6.fsf@draig.linaro.org>
 <51342318ee32c932dc2a867c808989ea627d874f@nut.email>
 <f7f5cfabe46ede28ea57e49ce36c617aa774ec0b@skiff.uberspace.de>
 <359dc52bc7ebe3ea8a3d549f23d42a592066d685@nut.email>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 25 Sep 2025 11:41:45 +0100
Message-ID: <87bjmyke52.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

"Julian Ganz" <neither@nut.email> writes:

(add Richard to Cc)

> September 23, 2025 at 10:29 PM, "Julian Ganz" wrote:
>> September 22, 2025 at 12:11 PM, "Julian Ganz" wrote:
>> > September 21, 2025 at 6:46 PM, "Alex Benn=C3=A9e" wrote:
>> > This is firing on:
>> >=20=20
>> >  =F0=9F=95=9917:35:50 alex@draig:tests/tcg/i386-linux-user on =EE=82=
=A0 review/tcg-discon-v6 [$!?]=20
>> >  =E2=9E=9C make run-plugin-catch-syscalls-with-libdiscons.so V=3D1
>> >  timeout -s KILL --foreground 120 env
>> > QEMU=3D/home/alex/lsrc/qemu.git/builds/sanitisers/qemu-i386
>> > /home/alex/lsrc/qemu.git/builds/sanitisers/qemu-i386 -plugin
>> > ../plugins/libdiscons.so -d plugin -D
>> > catch-syscalls-with-libdiscons.so.pout catch-syscalls >
>> > run-plugin-catch-syscalls-with-libdiscons.so.out
>> >  Aborted
>> >  make: *** [Makefile:226: run-plugin-catch-syscalls-with-libdiscons.so=
] Error 134
<snip>
>> >  (gdb) p report->str
>> >  $2 =3D (gchar *) 0x51100001fbc0 "Discon target PC mismatch on VCPU 0\=
nExpected: 8057369\nEncountered: 805736b\nExecuted Last: 805736b\nEvent typ=
e: exception\n"
>> >  (gdb)=20
>> >=20=20
>> >  I think this is where it is going wrong:
>> >=20=20
>> >  IN: _dl_early_allocate
>> >  0x0805736b: 89 c2 movl %eax, %edx
>> >  0x0805736d: 8d 1c 28 leal (%eax, %ebp), %ebx
>> >  0x08057370: 89 c8 movl %ecx, %eax
>> >  0x08057372: cd 80 int $0x80
>> >=20=20
>> >  Thanks! I'll have a closer look.
>> >=20
>> I probably didn't configure the target I need for this test on my
>> private machine (which uses musl, so some targets are awkward).
>
> Turned out I just ran `make` in the wrong directory.
>
>> Could it
>> be that this doesn't run in system emulation mode and the exception is
>> somehow handled natively? I did not account for that possibility and I
>> don't think I'll get the testing plugin to do anything meaningful
>> outside system emulation.
>
> As expected the plugin ran in a qemu configuration in which the API does
> not behave as expected. Which I could have figured out by the logs Alex
> provided if I paid attention. Sorry for the noise.
>
> I added a check to the plugin that bails out if qemu does not run in
> system emulation mode (which I thought I did, but that was only for the
> contrib plugin).
>
> Even if we cannot test the API for user mode, it may still provide some
> utility,  so I suggest _just_ letting the testing plugin do nothing in
> that case. In fact, I'm considering removing the check from the contrib
> "traps" plugin now that I saw that the API _is_ triggered in user
> mode.

Is this just because we are missing the hooks into the linux-user
run-loop? I assume int $0x80 is a syscall so we should report an
exception type at that point?

In fact I think you could probably generate the event at
qemu_plugin_vcpu_syscall()?

force_sig_fault() and force_sig() might be the other places that should
be hooked. Or possibly handle_pending_signal() where all the other
signals affect the code flow.

I think that can avoid patching every arches run loop.

Richard, WDYT?

>
> Regards,
> Julian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

