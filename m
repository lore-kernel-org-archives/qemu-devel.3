Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B38DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 08:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS9z-0003vQ-1U; Tue, 18 Mar 2025 04:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuS9K-0003jn-Ri
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 04:18:18 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuS9G-0002vv-TF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 04:18:09 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so906517966b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742285884; x=1742890684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKGXm6xjTHuSvw6Gg1ZyeN//OLgt4brXp7+YcTzDfhw=;
 b=zDa45LR2fapCP6xSqLail+fBjslq9lLjBRObDGP6YUFwaNTTP4+vDRno1av6NamCdS
 RkppYpOXPwNrFSUuED49T6bnCd+X4Ab3dmwFG2si9nSilF/9l63XXX1uDjoQxRi240pP
 qIQVR8mFE/C9tWDYFk5nZeWeNvELjNIbQwhXk/KNOllDrUZNNEZ3yKXSoZTQUhNHoTvP
 wMpNWdnRbTNwTlMM0fDb8aVcS5IClT550OV4OVVlFtwRaZupPLRdfHmXeriVWPtbx6ny
 lSKP3iMXTENmbi1hiwNjYaYF6wJVBPA2I6/OYhLJtWMvgj89UfVGa/OM+rEWIb0/KaOO
 iToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742285884; x=1742890684;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QKGXm6xjTHuSvw6Gg1ZyeN//OLgt4brXp7+YcTzDfhw=;
 b=VZBD9cMDJENNkMEJHDH4HBRoHCkwFgQfvgJjqGfckLZilkbJ/eEYcWB6SZZbqLO3CO
 FUOeyJeeGfjXFoRdISOZBsu9+UpHXBPL1avUmk67BF/t2zURpmRgxvZozS9baCcYUD48
 OqEbHvORgTJfvNtjkAyQKuC55vrhYSwEXZQRaotPV+pMhIbpvf4pI3L9Tu6eY4oCHSk2
 5q9uI7cLuJTqF7oOdvxeEoEd2Nizbx/Id/JDYLbH73UG9ud5gRiUQ9+6bAreDmY1nvU1
 lhT6uHtzVUyM+m8y6H3iIthUQAV+2zCoJlupAqPLMuPbE/v10ScyE+tlpCqLVffzyv0W
 0dkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOmqLoGn2U48GdPXtH/afT0iXEdIKzXilEL50W3WNmcdlOPuPR9X1oRm4ENXuqo5rlJzjlW+zUXK0V@nongnu.org
X-Gm-Message-State: AOJu0YwCWSjlJDUBZgegI/O64QU8b0kTsovK4tInVjKt/jt9REvNZWWz
 BL5roxClQWKYvHWpn9IFE4OI5+3D4cqipdsg2WUs1bNjiSGVgC+usNVqXeUnq68=
X-Gm-Gg: ASbGncuukwMcAq+a09P+tNkp6TbANR6lbr5+7bjC1P8FRs4XnVje51+Iuggc7C61DJe
 417FVZNo+eQHH/Dp0OCyGD+L+p3XVOPDCwIg24JI4fNNzLIToXVb7PhXvenKur2qSgBmUZC7T5f
 Nd0qXabFoObn1no4WjS0onkD3g5ZfEH5+Tv9al1QGJJvSN41YADJbuYLeBuvjwW+jdtilkAKDm1
 Kisqv9erGnH8X9zXhh8PGnw647hcYs9W+LYlOAIcBuQiF0aLq/PLvfW2jdgMDQB8PSfRaxF6gNt
 3v/WnHdhFG8RRJ/igzoTY8g+D6SbHDe2XX3KAE4tF/xcqI0=
X-Google-Smtp-Source: AGHT+IHrJpYGTMujlNZFe3Mdk/dwMHoUzTu0kyvAeLHAl2hAVfJ/HPusi+lwZsOvrmhtPMqlONEglg==
X-Received: by 2002:a17:907:7241:b0:ac0:527c:9cd5 with SMTP id
 a640c23a62f3a-ac330441df6mr1717380066b.42.1742285883775; 
 Tue, 18 Mar 2025 01:18:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e8169bcad3sm7468571a12.47.2025.03.18.01.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 01:18:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A2BA65F8E1;
 Tue, 18 Mar 2025 08:18:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Saanjh Sengupta <saanjhsengupta@outlook.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  "amir.gonnen@neuroblade.ai"
 <amir.gonnen@neuroblade.ai>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: Building QEMU as a Shared Library
In-Reply-To: <ACDE2106-E0BB-4BEE-8BD5-51898274ED99@outlook.com> (Saanjh
 Sengupta's message of "Tue, 18 Mar 2025 05:40:10 +0000")
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
 <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
 <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
 <SE1SPRMB0015BDAF043E9103B24B9973CCC82@SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM>
 <67a10cba-5bb8-4dda-a7c7-c7a3637bb1b3@linaro.org>
 <SL2P216MB138053F139E1B688D2BBA201CCD12@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
 <2f1078d7-31bf-4940-aa43-30a45f7a07a0@linaro.org>
 <SL2P216MB1380316B32539524D1CCD831CCD02@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
 <ab0a0e8d-9c26-4225-942b-9d6996abfb8f@linaro.org>
 <SL2P216MB13806B5994D2A1F4DC5E5685CCD32@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
 <87bju44vun.fsf@draig.linaro.org>
 <ACDE2106-E0BB-4BEE-8BD5-51898274ED99@outlook.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 18 Mar 2025 08:18:01 +0000
Message-ID: <87v7s6n45i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Saanjh Sengupta <saanjhsengupta@outlook.com> writes:

> Hi Alex,=20=20
>
> You mentioned about a patch series; do you have it handy with you?

  Message-Id: <20241022105614.839199-18-alex.bennee@linaro.org>
  Date: Tue, 22 Oct 2024 11:56:11 +0100
  Subject: [PATCH v2 17/20] plugins: add ability to register a GDB triggere=
d callback
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

>
> If so, could you please direct me to the same ?
>
>  On 14 Mar 2025, at 12:11=E2=80=AFAM, Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
>  Saanjh Sengupta <saanjhsengupta@outlook.com> writes:
>
>  Hi,
>
>  What we are trying to achieve is that the QEMU should run for a particul=
ar number of instructions, let's say for
>  example
>  10000 instructions and then pause it's emulation. After a resume trigger=
 is received to the QEMU it must resume it's
>  emulation and start the instruction count from 10001 (which basically
>  means that the context should be saved).
>
>  I think you want to run under icount and you will need to modify the
>  trigger plugin. Under icount we run each vCPU in turn, so if the plugin
>  pauses the vCPU will de-facto be paused.
>
>  You would have to implement some sort of control interface in the
>  plugin. Or you could add an API to trigger the gdbstub. I think I had
>  that on a patch series at one point.
>
>  In the previous mail when you mentioned g_usleep, I believe this shall n=
ot work (as per our use-case) since it will
>  reset the
>  instruction count to 0 (as per what you mentioned).=20
>
>  To achieve the use-case, do you have any leads/suggestions ?=20
>
>  Regards
>  Saanjh Sengupta=20
>
>  ------------------------------------------------------------------------=
-------------------------------------------------
>  From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>  Sent: Wednesday, March 12, 2025 11:50:23 am
>  To: Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-Daud=
=C3=A9 <philmd@linaro.org>; Paolo Bonzini
>  <pbonzini@redhat.com>; Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om>
>  Cc: amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-devel@no=
ngnu.org
>  <qemu-devel@nongnu.org>; Alex
>  Benn=C3=A9e <alex.bennee@linaro.org>
>  Subject: Re: Building QEMU as a Shared Library
>
>  On 3/11/25 21:31, Saanjh Sengupta wrote:
>
>  Hi,
>
>  Thank you for the clarification. Regarding the last time
>  /"Stoptrigger might be a better fit for what you want to do, and instead=
=20
>  of exiting, you want to resume emulation after N insn. The function=20
>  qemu_clock_advance_virtual_time() can only be used to move the time=20
>  forward, and you can not stop the "virtual time" by design."/
>  /
>  /
>  I did not quite understand this. Even if I have to modify the=20
>  stopTrigger plugin, I would want it to pause rather than exiting.
>  For example: It gets 10000 instructions executed after that it should=20
>  pause and after some time it should then resume again execute till 20000=
=20
>  instructions (because previously it executed till 10000 and then it must=
=20
>  execute till 20000). How do I do this? How do I state the code to pause=
=20
>  the qemu's emulation after 10000 instructions?
>
>  By using g_usleep to pause the current cpu.
>  As well, it's needed to reset insn_count to 0 to count instructions agai=
n.
>
>  With this command line:
>  ./build/qemu-system-x86_64 -plugin=20
>  ./build/contrib/plugins/libstoptrigger.so,icount=3D1000 -d plugin
>
>  And with those changes to stoptrigger:
>
>  diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger=
.c
>  index b3a6ed66a7b..77fd413cef1 100644
>  --- a/contrib/plugins/stoptrigger.c
>  +++ b/contrib/plugins/stoptrigger.c
>  @@ -41,11 +41,12 @@ typedef struct {
>       int exit_code;
>   } ExitInfo;
>
>  -static void exit_emulation(int return_code, char *message)
>  +static void pause_emulation(int return_code, char *message)
>   {
>       qemu_plugin_outs(message);
>       g_free(message);
>  -    exit(return_code);
>  +    /* exit(return_code); */
>  +    g_usleep(1 * G_USEC_PER_SEC);
>   }
>
>   static void exit_icount_reached(unsigned int cpu_index, void *udata)
>  @@ -53,7 +54,9 @@ static void exit_icount_reached(unsigned int=20
>  cpu_index, void *udata)
>       uint64_t insn_vaddr =3D qemu_plugin_u64_get(current_pc, cpu_index);
>       char *msg =3D g_strdup_printf("icount reached at 0x%" PRIx64 ",=20
>  exiting\n",
>                                   insn_vaddr);
>  -    exit_emulation(icount_exit_code, msg);
>  +    pause_emulation(icount_exit_code, msg);
>  +    /* reset instruction counter */
>  +    qemu_plugin_u64_set(insn_count, cpu_index, 0);
>   }
>
>   static void exit_address_reached(unsigned int cpu_index, void *udata)
>  @@ -61,7 +64,7 @@ static void exit_address_reached(unsigned int=20
>  cpu_index, void *udata)
>       ExitInfo *ei =3D udata;
>       g_assert(ei);
>       char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exiting\n",=20
>  ei->exit_addr);
>  -    exit_emulation(ei->exit_code, msg);
>  +    pause_emulation(ei->exit_code, msg);
>   }
>
>  Moreover, I tried an activity where I was utilising the QMP protocol to=
=20
>  control the virtual time (with respect to the IPS plugin). In that=20
>  context when the QMP stop is triggered, my virtual time does got freezed=
=20
>  until the resume is triggered. Does this mean I am able to manipulate=20
>  the virtual time of the QEMU?
>
>  I am not sure of how it works, but the plugin interface only allows to=20
>  move time forward.
>
>  Regards
>  Saanjh Sengupta
>  ------------------------------------------------------------------------
>  *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
>  *Sent:* Wednesday, March 12, 2025 2:14:47 AM
>  *To:* Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-=20
>  Daud=C3=A9 <philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Mar=
c-=20
>  Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>  *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-=20
>  devel@nongnu.org <qemu-devel@nongnu.org>; Alex Benn=C3=A9e=20
>  <alex.bennee@linaro.org>
>  *Subject:* Re: Building QEMU as a Shared Library
>  On 3/11/25 02:50, Saanjh Sengupta wrote:
>
>  Hi,
>
>  I have a couple of questions:
>
>  1.
>     When I use the libstoptrigger.so: in that case the QEMU 's emulation
>     stops after executing the defined number of instructions. Post this,
>     the whole QEMU terminates. And while using the libips.so I am
>     assuming that the QEMU doesn't execute no more than the defined
>     instructions. Please correct me if I am wrong.
>
>  That's correct for both plugins, with the additional note that libips
>  does this per second only.
>
>  2.
>     In my case, I want the QEMU to start emulation for some time and
>     PAUSE it's emulation for some time; after it is Paused (it's virtual
>     time is also to be paused) and then let's say for after 'x' time
>     period it should resume it's virtual time.
>
>  The virtual time variable in ips plugin is only related to this plugin,
>  and based on how many instructions have been executed, which is
>  different from what you want to achieve.
>
>  Stoptrigger might be a better fit for what you want to do, and instead
>  of exiting, you want to resume emulation after N insn.
>  The function qemu_clock_advance_virtual_time() can only be used to move
>  the time forward, and you can not stop the "virtual time" by design.
>
>  image
>
>  I have added this segment inside the update_system_time function inside=
=20
>  the ipsPlugin.c. but once the instructions reach to the defined limit=20
>  the virtual time does not seem to stop.
>  Do you have any suggestions on that front?
>
>  Regards
>  Saanjh Sengupta
>  ------------------------------------------------------------------------
>  *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
>  *Sent:* Wednesday, March 5, 2025 5:20:38 AM
>  *To:* Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-=20
>  Daud=C3=A9 <philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Mar=
c-=20
>  Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>  *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-=20
>  devel@nongnu.org <qemu-devel@nongnu.org>; Alex Benn=C3=A9e=20
>  <alex.bennee@linaro.org>
>  *Subject:* Re: Building QEMU as a Shared Library
>  Hi Saanjh,
>
>  depending what you are trying to achieve exactly, plugins can provide a
>  solution. It's convenient and you can stay on top of QEMU upstream,
>  without having to create a downstream fork.
>
>  We already have plugins for stopping after a given number of
>  instructions, or slow down execution of a VM:
>
>  # stop after executing 1'000'000 instructions:
>  $ ./build/qemu-system-x86_64 -plugin
>  ./build/contrib/plugins/libstoptrigger,icount=3D1000000 -d plugin
>
>  # execute no more than 1'000'000 instructions per second:
>  $ ./build/qemu-system-x86_64 -plugin
>  ./build/contrib/plugins/libips.so,ips=3D1000000 -d plugin
>
>  You can see source code associated (./contrib/plugins/stoptrigger.c and
>  ./contrib/plugins/ips.c), to implement something similar to what you
>  want, but based on time.
>  Would that satisfy your need?
>
>  Regards,
>  Pierrick
>
>  On 3/3/25 21:53, Saanjh Sengupta wrote:
>
>  Hi,
>
>  Thank you so much for your inputs. I was able to create the .so file of=
=20
>  QEMU.
>
>  Actually, what we are trying is to understand and explore possibilities=
=20
>  of Virtual Time Control in QEMU. In short, what I mean to say is an=20
>  approach via which I can tell QEMU to emulate for XYZ time when the I=20
>  give a trigger and then pause the emulation by itself after the XYZ time=
=20
>  is completed.
>
>  On that front itself, do you have any inputs/ideas regarding the same?
>
>  Regards
>  Saanjh Sengupta
>  ------------------------------------------------------------------------
>  *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
>  *Sent:* Tuesday, February 25, 2025 6:29:44 AM
>  *To:* Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>; Paolo Bonzini=20
>  <pbonzini@redhat.com>; Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om>
>  *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-=20
>  devel@nongnu.org <qemu-devel@nongnu.org>; Saanjh Sengupta=20
>  <saanjhsengupta@outlook.com>
>  *Subject:* Re: Building QEMU as a Shared Library
>  Hi Saanjh,
>
>  here is a minimal patch that builds one shared library per target (arch,
>  mode) where arch is cpu arch, and mode is system or user, and launch
>  system-aarch64 through a simple driver:
>
>  https://github.com/pbo-linaro/qemu/commit/ <https://github.com/pbo-=20
>
>  linaro/qemu/commit/> <https://github.com/pbo-
>
>  linaro/qemu/commit/>
>
>  fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f <https://github.com/pbo-linaro/
>  qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f>
>
>  With this, it could be possible to create a driver that can execute any
>  existing target. It's a sort of single binary for QEMU, but shared
>  objects are mandatory, and duplicates all the QEMU state. So there is no
>  real benefit compared to having different processes.
>
>  In more, to be able to do concurrent emulations, there are much more
>  problems to be solved. QEMU state is correctly kept per target, but all
>  other libraries states are shared. There are various issues if you
>  launch two emulations at the same time in two threads:
>  - glib global context
>  - qemu calls exit in many places, which stops the whole process
>  - probably other things I didn't explore
>
>  At this point, even though qemu targets can be built as shared objects,
>  I would recommend to use different processes, and implement some form on
>  IPC to synchronize all this.
>  Another possibility is to try to build machines without using the
>  existing main, but I'm not sure it's worth all the hassle.
>
>  What are you trying to achieve?
>
>  Regards,
>  Pierrick
>
>  On 2/24/25 01:10, Philippe Mathieu-Daud=C3=A9 wrote:
>
>  Cc'ing our meson experts
>
>  On 22/2/25 14:36, Saanjh Sengupta wrote:
>
>  Hi,
>
>  I referred to your mailing chains on suggesting QEMU to be built as a
>  shared library.
>
>  *Change meson.build to build QEMU as a shared library (with PIC enabled
>  for static libraries)*
>  *
>  *
>  Could you please suggest what exactly has to be enabled in the meson.bui=
ld?
>
>  I am confused on that front.
>
>  Regards
>  Saanjh Sengupta
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

