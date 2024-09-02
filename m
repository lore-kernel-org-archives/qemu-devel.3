Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC97CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 17:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slBEI-0004UW-DT; Mon, 02 Sep 2024 13:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slBEG-0004Ta-S7
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 13:52:40 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slBEE-0001rh-MV
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 13:52:40 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8692bbec79so506416766b.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725299556; x=1725904356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNDWjy6mbPbjIH2YfzrdrpGXdc/GT+l4ztQDl81a08w=;
 b=SLxfwvhlWyIecSNCFDZOeAB5BJAEG1knIySOGstwdayQz92dn3C6kGoYXe6+uOhHiB
 eifn3Cz5ilC/Q9bCWvivHeYRgwfE9VSPxierxZPv/cot7NTcC003UYWFq+QUOZ4W0XQO
 weh76RPo35JrX/1DPf6F+BWwioXWkTe8GJDQb8hqBsdnCAp4W4cK96u1VGFXxAQxEHTj
 xVEHG5Q4dTz04+wv2s9o0v84dg4hJKfJ68s/WcK3iGmFdB60+Cl/i7nZiC49DUciIWHF
 Qbz+ZilTNq+VzWpGWZEgoVXm0+LLRrOP6E82VdgI62a5pRumR094y3Qv995jZMPtdHxS
 F7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725299556; x=1725904356;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WNDWjy6mbPbjIH2YfzrdrpGXdc/GT+l4ztQDl81a08w=;
 b=PJdjPtjw0m+HV9b0RHql0ejjsTowsJCNr60lsiYcCDDlfy/h97qlrxGbEsEjDsjV7N
 Ct5IgSN7Tdm5NlJgMgptkfH2JzFmUc4GWLq15Osc3e6NJCZgt66ZGCHfomuGBiJ2jovd
 Im/EhQ5trw0w6emZbU4aeelHolQeexFCpy83JLOQ1QCE2zlQ0KQ5k50tT28OVEQHUgCS
 ewp5mr8ekJSGlnCog/Hntge7LxC6m97L93cWfdYpjYbJWcQKwVhU6g9XQ9xnAWZdBYYp
 f6JESMD9fCCTjCewQDV2CD6S3OzmjzTW8HU3GtKyMY6wXD9XWIbFEIYqeG+wDG603OOT
 7fwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+2CY2A3o4BogNbbg3RLyzRur6+v0Bj8HjHTmz6W518oyoCSyfqXoI6oThduri4YxWSegZIiIN81v1@nongnu.org
X-Gm-Message-State: AOJu0YzWxs8G7oWuGsavG4bKGv1sXJDuALPHKs3DE/+ap6ADpVLrKaGo
 aFd1olnYW/zG/O6PobfjEUSMtWgIGtyEovj2gyJAvJMkt5/jrzEjwhZOWxqLYLE=
X-Google-Smtp-Source: AGHT+IFxqZTybzELfRxZ6b40Tm0THAFw88gQ5KSmDSd5okxq0JlxnG6r7WdsjvprA4SHcd5l7/54/A==
X-Received: by 2002:a17:907:9723:b0:a86:88f7:679c with SMTP id
 a640c23a62f3a-a89a37a7ff3mr638665866b.41.1725299555927; 
 Mon, 02 Sep 2024 10:52:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8988feb9c6sm585903566b.24.2024.09.02.10.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 10:52:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9556E5F835;
 Mon,  2 Sep 2024 18:52:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Xingran Wang <wangxingran123456@outlook.com>,  qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH] plugins: add two events for cpu_restore_state_from_tb()
 and cpu_io_recompile()
In-Reply-To: <592a0bc6-fbf0-4189-bd47-7b7cc6fc7681@linaro.org> (Pierrick
 Bouvier's message of "Mon, 2 Sep 2024 09:08:24 -0700")
References: <SY8P282MB4322879DBA2E5E3E3B72B383A1912@SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM>
 <87mskqcp5n.fsf@draig.linaro.org>
 <592a0bc6-fbf0-4189-bd47-7b7cc6fc7681@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 02 Sep 2024 18:52:34 +0100
Message-ID: <87seuidjtp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Hi Xingran,
>
> On 9/2/24 03:42, Alex Benn=C3=A9e wrote:
>> Xingran Wang <wangxingran123456@outlook.com> writes:
>>=20
>>> Currently, the instruction count obtained by plugins using the translat=
ion
>>> block execution callback is larger than the actual value. Adding callba=
cks
>>> in cpu_restore_state_from_tb() and cpu_io_recompile() allows plugins to
>>> correct the instruction count when exiting a translation block
>>> mid-execution, properly subtracting the excess unexecuted
>>> instructions.
>> This smells like exposing two much of the TCG internals to the
>> plugin
>> mechanism. You can already detect when we don't reach the end of a block
>> of instructions by instrumentation as I did in:
>>=20
>
> I agree that this is definitely a QEMU implementation "detail", and
> should not be a concern for end users.
>
> The documentation already warns that all instructions may not execute,
> and that in this case, it's better to instrument them directly,
> instead of TB:
> https://www.qemu.org/docs/master/devel/tcg-plugins.html#translation-block=
s.
>
> Finally, even if we integrated an API like what you propose in this
> patch, I think it would be very easy for plugins writers to make a
> mistake using it, as you need to keep track of everything yourself.
>
> If we want to stay on the topic of this patch, one direction that
> would be better in my opinion is a "after_tb_exec" API, where the TB
> passed in parameter is guaranteed to have all its instructions that
> were executed (not interrupted).

Or indeed resolves with the current PC at the "end" of the TB where it
gets to. QEMU could keep track of that easily enough as the recompile
and bus fault paths are slow paths anyway. It would be tricky to support
inline for that though.

As TB is exposed internally I think we'd just need to set a flag and
call out. Maybe an API like:

  /**
   * typedef qemu_plugin_vcpu_tb_end_cb_t - vcpu callback at end of block
   * @vcpu_index: the current vcpu context
   * @pc: the next PC
   * @insns: instructions executed in block
   * @userdata: a pointer to some user data supplied when the callback
   * was registered.
   */
  typedef void (*qemu_plugin_vcpu_tb_end_cb_t)(unsigned int vcpu_index,
                                               uint64_t next_pc,
                                               size_t n_insns,
                                               void *userdata);

  /**
   * qemu_plugin_register_vcpu_tb_exec_end_cb() - register execution callba=
ck at end of TB
   * @tb: the opaque qemu_plugin_tb handle for the translation
   * @cb: callback function
   * @flags: does the plugin read or write the CPU's registers?
   * @userdata: any plugin data to pass to the @cb?
   *
   * The @cb function is called every time a translated unit executes.
   */
  QEMU_PLUGIN_API
  void qemu_plugin_register_vcpu_tb_exec_end_cb(struct qemu_plugin_tb *tb,
                                                 qemu_plugin_vcpu_tb_end_cb=
_t cb,
                                                 enum qemu_plugin_cb_flags =
flags,
                                                 void *userdata);

I think the tricky bit would be getting TCG to emit the callback code
for the last instruction before the
tcg_gen_exit_tb/tcg_gen_lookup_and_goto_ptr bits but after whatever else
it has done to execute the instruction.

I don't think we could easily support inline ops at tb end though.

Richard,

What do you think?


>>    Message-Id: <20240718145958.1315270-1-alex.bennee@linaro.org>
>>    Date: Thu, 18 Jul 2024 15:59:58 +0100
>>    Subject: [RFC PATCH v3] contrib/plugins: control flow plugin
>>    From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.or=
g>
>> So what exactly are we trying to achieve here? A more efficient
>> detection of short blocks?
>>=20
>>>
>>> Signed-off-by: Xingran Wang <wangxingran123456@outlook.com>
>>> ---
>>>   accel/tcg/translate-all.c    |  27 ++++++++
>>>   include/qemu/plugin-event.h  |   2 +
>>>   include/qemu/plugin.h        |  24 +++++++
>>>   include/qemu/qemu-plugin.h   | 131 +++++++++++++++++++++++++++++++++++
>>>   plugins/api.c                |  78 +++++++++++++++++++++
>>>   plugins/core.c               |  42 +++++++++++
>>>   plugins/qemu-plugins.symbols |  10 +++
>>>   tests/tcg/plugins/bb.c       |  25 +++++++
>>>   8 files changed, 339 insertions(+)
>>>
>>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>>> index fdf6d8ac19..642f684372 100644
>>> --- a/accel/tcg/translate-all.c
>>> +++ b/accel/tcg/translate-all.c
>>> @@ -65,6 +65,7 @@
>>>   #include "internal-target.h"
>>>   #include "tcg/perf.h"
>>>   #include "tcg/insn-start-words.h"
>>> +#include "qemu/plugin.h"
>>>     TBContext tb_ctx;
>>>   @@ -218,6 +219,19 @@ void cpu_restore_state_from_tb(CPUState
>>> *cpu, TranslationBlock *tb,
>>>           cpu->neg.icount_decr.u16.low +=3D insns_left;
>>>       }
>>>   +#ifdef CONFIG_PLUGIN
>>> +    /*
>>> +     * Notify the plugin with the relevant information
>>> +     * when restoring the execution state of a TB.
>>> +     */
>>> +    struct qemu_plugin_tb_restore ptb_restore;
>>> +    ptb_restore.cpu_index =3D cpu->cpu_index;
>>> +    ptb_restore.insns_left =3D insns_left;
>>> +    ptb_restore.tb_n =3D tb->icount;
>>> +    ptb_restore.tb_pc =3D tb->pc;
>>> +    qemu_plugin_tb_restore_cb(cpu, &ptb_restore);
>>> +#endif
>>> +
>> See also the unwind patches which is a more generic approach to
>> ensuring
>> "special" registers are synced at midpoint when using the register API:
>>    Message-Id: <20240606032926.83599-1-richard.henderson@linaro.org>
>>    Date: Wed,  5 Jun 2024 20:29:17 -0700
>>    Subject: [PATCH v2 0/9] plugins: Use unwind info for special gdb regi=
sters
>>    From: Richard Henderson <richard.henderson@linaro.org>
>> <snip>
>>=20
>
> Thanks,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

