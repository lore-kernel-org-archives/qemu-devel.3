Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD1DC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6dI-0008Gv-Ku; Fri, 15 Mar 2024 08:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rl6dH-0008Gb-5b
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:25:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rl6dF-0005Qq-6s
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:25:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41403b203e0so1680045e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710505550; x=1711110350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3BN1N6N0KvJh7B/oVj292iIgD+UIsCS4UlVg0JoZ8Y=;
 b=tFTU5cFVRaCO/g64YKNaqvaIW11jCOjJnXRQ4hRc+xUjGjj8v46ubmZZ29Xi1LwVOd
 OXP6v3BYhlBgc4loTSlBAagGPUuiniR/igoqHWGrfMhezfDk0a0JIMd2oQ7I32gqHF8x
 PeBF6XXqa+8f9DYiEaeKyTAzRmUFO2QGz7LZs1pH2NG0vS4H4o/zujoy4wFaLnODkOan
 lpQozBXDfO3UP0GvozAptZ9SLoCQuKDSHKVZHSWjNd+gOMued2yMAt7HGpxteZRZj/Rq
 sHFhcZEDEXLtLToEldgL9ZQBp3TfuYR/Ijf+LZE5185X4rjGgPPP3ut1CeU8j7Z+zeVf
 Qj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710505550; x=1711110350;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N3BN1N6N0KvJh7B/oVj292iIgD+UIsCS4UlVg0JoZ8Y=;
 b=wEj4o86hrdICVRHLWTkzWyp3HK21IVqm39YH2l7qjah3pKZ9u0LrvyaZWAZ2QIxFfi
 8SulNIMgIX2v+CpWEyVGqW+7CIexSCqI4qigw+C+omxEZModNcjM3Ivkznqf9jwz3e5X
 BgJvvVvF8QXj5kO58O0paZdpZwsrfwThFtUtjsrXQpBHxiJMy5qiQt9g4J2mfHBWL2VP
 fwuubCqNct6P+/QvCpZMV2OaCdKduLboSHM+J1l2/fjRNd29lZWK29Q9U6n7iEJQdX/j
 bUfU5fM1vw3KBHsIipOSCoY047/JqOKOOMc4LD8gOqkXLXs4iLRFibbxeKXYpiqbp3mq
 GgHA==
X-Gm-Message-State: AOJu0YyKC6GOiUx86gPD5+MDgblZwfK35vIPGM9P8w9DEOEfzqcWsEvz
 WkL1/Ig5nQJteyLC8HCUE0fyNIPWZ+K+io8Wy8G10qqFMfXk7/cnzQhl9NCAw0s=
X-Google-Smtp-Source: AGHT+IEuGiQtQVPYA3SPs6/K+XPBBXFzISBgl15s/4g/tKYUI3nWkYbkr3QxzNF7I/re+ANwd40hTQ==
X-Received: by 2002:a05:600c:4f91:b0:413:2852:2835 with SMTP id
 n17-20020a05600c4f9100b0041328522835mr3476838wmq.17.1710505550239; 
 Fri, 15 Mar 2024 05:25:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 hg25-20020a05600c539900b00413f08c4d2asm5556574wmb.37.2024.03.15.05.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 05:25:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2FB025F8A0;
 Fri, 15 Mar 2024 12:25:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?J=C3=B8rgen?= Hansen <Jorgen.Hansen@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,  Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>
Subject: Re: Another CXL/MMIO tcg tlb corner case
In-Reply-To: <33748BB7-E617-4661-BDE3-5D29780FC9FF@wdc.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?J=C3=B8rgen?= Hansen"'s
 message of "Fri, 15 Mar 2024 09:36:16 +0000")
References: <33748BB7-E617-4661-BDE3-5D29780FC9FF@wdc.com>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Fri, 15 Mar 2024 12:25:49 +0000
Message-ID: <87v85n3cmq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

J=C3=B8rgen Hansen <Jorgen.Hansen@wdc.com> writes:

> Hi,
>
> While doing some testing using numactl-based interleaving of application =
memory
> across regular memory and CXL-based memory using QEMU with tcg, I ran int=
o an
> issue similar to what we saw a while back - link to old issue:
> https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=3DEpz3_+CheAT8Crsk9mOu89=
4wbNW_FywamkZiw@mail.gmail.com/#t.
>
> When running:
>
> numactl --interleave 0,1 ./cachebench =E2=80=A6
>
> I hit the following:
>
> numactl --interleave 0,1 ./cachebench --json_test_config ../test_configs/=
hit_ratio/graph_cache_follower_assocs/config.json
> qemu: fatal: cpu_io_recompile: could not find TB for pc=3D0x7fffc3926dd4

Ok so this will be because we (by design) don't cache TB's for MMIO
regions. But as you say:
>
> Looking at the tb being executed, it looks like it is a single instructio=
n tb,
> so with my _very_ limited understanding of tcg, it shouldn=E2=80=99t be n=
ecessary to
> do the IO recompile:
>
> (gdb) up 13
>
> #13 0x0000555555ca13ac in cpu_loop_exec_tb (tb_exit=3D0x7ffff49ff6d8, las=
t_tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffc3926cc0 <code=
_gen_buffer+464678035>, cpu=3D0x5555578c19c0) at ../accel/tcg/cpu-exec.c:904
> 904         tb =3D cpu_tb_exec(cpu, tb, tb_exit);
> (gdb) print *tb
> $1 =3D {pc =3D 0, cs_base =3D 0, flags =3D 415285939, cflags =3D 42783211=
52, size =3D 7, icount =3D 1, tc =3D {ptr =3D 0x7fffc3926d80 <code_gen_buff=
er+464678227>, size =3D 176}, page_next =3D {0, 0}, page_addr =3D {18446744=
073709551615,
>     18446744073709551615}, jmp_lock =3D {value =3D 0}, jmp_reset_offset =
=3D
> {65535, 65535}, jmp_insn_offset =3D {65535, 65535}, jmp_target_addr =3D
> {0, 0}, jmp_list_head =3D 140736474540928, jmp_list_next =3D {0, 0},
> jmp_dest =3D {0, 0}}

with an icount of 1 we by definition can do io. This is done in the
translator_loop:

        /*
         * Disassemble one instruction.  The translate_insn hook should
         * update db->pc_next and db->is_jmp to indicate what should be
         * done next -- either exiting this loop or locate the start of
         * the next instruction.
         */
        if (db->num_insns =3D=3D db->max_insns) {
            /* Accept I/O on the last instruction.  */
            set_can_do_io(db, true);
        }

and we see later on:

    tb->icount =3D db->num_insns;

So I guess we must have gone into the translator loop expecting to
translate more? (side note having int8_t type for the saved bool value
seems weird).

Could you confirm by doing something like:

  if (tb->icount =3D=3D 1 &&  db->max_insns > 1) {
     fprintf(stderr, "ended up doing one insn (%d, %d)", db->max_insns, db-=
>saved_can_do_io);
  }

after we set tb->icount?

> If the application is run entirely out of MMIO memory, things work fine (=
the
> previous patches related to this is in Jonathans branch), so one thought =
is that
> it is related to having the code on a mix of regular and CXL memory. Sinc=
e we
> previously had issues with code crossing page boundaries where only the s=
econd
> page is MMIO, I tried out the following change to the fix introduced for =
that
> issue thinking that reverting to the slow path in the middle of the trans=
lation
> might not correctly update can_do_io:
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 38c34009a5..db6ea360e0 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -258,6 +258,7 @@ static void *translator_access(CPUArchState *env, Dis=
asContextBase *db,
>              if (unlikely(new_page1 =3D=3D -1)) {
>                  tb_unlock_pages(tb);
>                  tb_set_page_addr0(tb, -1);
> +                set_can_do_io(db, true);
>                  return NULL;
>              }
>
> With that change, things work fine. Not saying that this is a valid fix f=
or the
> issue, but just trying to provide as much information as possible :)

I can see why this works, my worry is if we address all the early exit
cases here.

>
> Thanks,
> Jorgen

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

