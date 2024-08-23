Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77775C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 10:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shRXq-0004oz-Nr; Fri, 23 Aug 2024 06:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1shRXp-0004oS-HQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 06:29:25 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1shRXn-0004Zq-CV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 06:29:25 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8695cc91c8so187609766b.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724408961; x=1725013761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3B9iZAMtc0nFoqBYZl+nJndWxEL2fNECRTmDB5g3zxE=;
 b=J/egWbW3P1Swr9n4Lg1OxvVgrqEYDeh0l+NX1WKSpu4KXp0f7h5YXP8AVB795wNQv1
 v8GvLHarHgMCTcHWKgL0yTIzBCiGuypTiSUmB9NOpSuwa9g/uX9Ep+ZHvaG+pYP9iwon
 tj4wgFWCXf9EaAQMicc7/h2liJypNl++FylrHt0saYx1K7S0Xnm8nNFCkb6SzwniTkbw
 /p1lsaDy24rk1x4t72/Z/EgkOiO4QUkR6qUDUmnF/dayvFVy3CPPmVHVzSOMQ/6x3gUe
 YMB8yFoK7Fn36tPVhwG+J6y0DK6QbbhdYd25z7RbNhITBO2T211ExagOLVYNKbJOQBRf
 271w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724408961; x=1725013761;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3B9iZAMtc0nFoqBYZl+nJndWxEL2fNECRTmDB5g3zxE=;
 b=PSymqQhyO5PeUNJJftkSyF09YHzsmLQtKpRmpscDBKEk6mhNf6stJj+sYHJvNwEhF9
 zJzNtLMGFXQwx/Nh/Ckf6LPaf4ki6Tq8YnW/B7i1JaWcYhsNd/212RL4+5vGu7X5ma+d
 s96BSWxtFDnSpitkp5F2cQ9KBaKlEG07IDhki8DAJH8C7w6CSmWFac/q5YCtB4PNhHET
 A+Jbxuo06siVwzPRkM7wBWL1NoBTtvimjQqYmlE7pjRIuXy85pATdDAO2ZRSK9vmQkLx
 QtBotdEFrrAf9SoKU9Vch1dDx3Gskq4/HjrpwzHGzaXY3sArR3jFZ3AUPr4ksxmEy8/Y
 UCpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6bQxWwvkk53kPiwux/566Wm6+2OWl7Vth3v6oIQRw5KauX4E3xauRc6ID/ojWox/eWKubEkIsjewb@nongnu.org
X-Gm-Message-State: AOJu0Ywnml4jPVzWF8St7Nqp10ig1Yub6bCNfE3Oe8ruPhB+ruH44wed
 2Ge+5BKfPPZ8kFxUGFe6ruLhbO9lLMoZNx3F6NPAO2h+nwTS1lz2yna9+08NYFW+NOgRWJM1pBl
 r
X-Google-Smtp-Source: AGHT+IFseKWEpzjADqrJLPeZ7IPIEk9t4uPFHDfBTfX6XPjfeSbs6GX8cKzFTMQBDhDyUBg402cmtw==
X-Received: by 2002:a17:907:e229:b0:a7a:b1a8:6a2e with SMTP id
 a640c23a62f3a-a86a52b99fcmr127618866b.28.1724408960831; 
 Fri, 23 Aug 2024 03:29:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f48a5ffsm242355066b.177.2024.08.23.03.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 03:29:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37E3E5F87E;
 Fri, 23 Aug 2024 11:29:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Rowan Hart <rowanbhart@gmail.com>,  qemu-devel@nongnu.org,  Alexandre
 Iooss <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH] plugins: add plugin API to read guest memory
In-Reply-To: <d134a954-0380-41dc-9e3b-75e1dc2e2bbf@linaro.org> (Pierrick
 Bouvier's message of "Thu, 22 Aug 2024 13:33:23 -0700")
References: <20240821235607.208622-1-rowanbhart@gmail.com>
 <d134a954-0380-41dc-9e3b-75e1dc2e2bbf@linaro.org>
Date: Fri, 23 Aug 2024 11:29:19 +0100
Message-ID: <87a5h3legw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

> Hi Rowan, thanks for your contribution.
>
> To give some context on the answer, we are currently working to add a
> similar "read_memory" API, but associated to memory callbacks for
> plugins
> (https://lore.kernel.org/qemu-devel/20240724194708.1843704-1-pierrick.bou=
vier@linaro.org/T/#t).
>
> A key aspect of what you propose here, is that the memory may have
> changed during the write time, and when you read it, while what we
> propose guarantees to track every change correctly.
>
> It's not a bad thing, and both API are definitely complementary. When
> talking to Alex, he was keen to add a global read_memory API (like you
> propose), after we merge the first one.
>
> @Alex: any thought on this?

I'd like to get the memory callback API merged first - mostly because
that is the API that will absolutely reflect what was loaded or stored
to a given memory location. For precise instrumentation that is the one
to use.

However I agree the ability to read the state of memory outside of loads
and stores is useful especially for something like this. It's not
unreasonable to assume the memory state of arguments going into a
syscall isn't being messed with and it is easier to track pointers and
strings with a more general purpose API.

>
> Regarding your patch, it would be much easier if you could split that
> in different commits. Adding API first, then modify each plugin in a
> different commit. This way, it would be easier to review. I'll make my
> comments in this patch, but for v2, please split those individual
> commits, and a cover letter, describing your changes
> (https://github.com/stefanha/git-publish is a great tool if you want
> to easily push series).
>
> On 8/21/24 16:56, Rowan Hart wrote:
>> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
>> ---
>>   docs/about/emulation.rst     |  16 ++++-
>>   include/qemu/qemu-plugin.h   |  24 +++++++-
>>   plugins/api.c                |  21 +++++++
>>   plugins/qemu-plugins.symbols |   1 +
>>   tests/tcg/plugins/mem.c      |  37 +++++++++++-
>>   tests/tcg/plugins/syscall.c  | 113 +++++++++++++++++++++++++++++++++++
>>   6 files changed, 208 insertions(+), 4 deletions(-)
>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>> index eea1261baa..9c68e37887 100644
>> --- a/docs/about/emulation.rst
>> +++ b/docs/about/emulation.rst
>> @@ -354,6 +354,8 @@ Behaviour can be tweaked with the following argument=
s:
>>       - Use callbacks on each memory instrumentation.
>>     * - hwaddr=3Dtrue|false
>>       - Count IO accesses (only for system emulation)
>> +  * - read=3Dtrue|false
>> +    - Read the memory content of each access and display it
>>     System Calls
>>   ............
>> @@ -388,6 +390,19 @@ run::
>>     160          1      0
>>     135          1      0
>>   +Behaviour can be tweaked with the following arguments:
>> +
>> +.. list-table:: Syscall plugin arguments
>> +  :widths: 20 80
>> +  :header-rows: 1
>> +
>> +  * - Option
>> +    - Description
>> +  * - print=3Dtrue|false
>> +    - Print the number of times each syscall is called
>> +  * - log_writes=3Dtrue|false
>> +    - Log the buffer of each write syscall in hexdump format
>> +
>>   Test inline operations
>>   ......................
>>   @@ -777,4 +792,3 @@ Other emulation features
>>   When running system emulation you can also enable deterministic
>>   execution which allows for repeatable record/replay debugging. See
>>   :ref:`Record/Replay<replay>` for more details.
>> -
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index c71c705b69..d4ec73574b 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -57,11 +57,19 @@ typedef uint64_t qemu_plugin_id_t;
>>    * - Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
>>    *   Those functions are replaced by *_per_vcpu variants, which guaran=
tee
>>    *   thread-safety for operations.
>> + *
>> + * version 3:
>> + * - modified arguments and return value of qemu_plugin_insn_data to co=
py
>> + *   the data into a user-provided buffer instead of returning a pointer
>> + *   to the data.
>> + *
>
> Is it a change left on your side, or a bad diff?
>
>> + * version 4:
>> + * - added qemu_plugin_read_memory_vaddr
>>    */
>>     extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>>   -#define QEMU_PLUGIN_VERSION 3
>> +#define QEMU_PLUGIN_VERSION 4
>>     /**
>>    * struct qemu_info_t - system information for plugins
>> @@ -852,6 +860,20 @@ typedef struct {
>>   QEMU_PLUGIN_API
>>   GArray *qemu_plugin_get_registers(void);
>>   +/**
>> + * qemu_plugin_read_memory_vaddr() - read from memory using a virtual a=
ddress
>> + *
>> + * @addr: A virtual address to read from
>> + * @len: The number of bytes to read, starting from @addr
>> + *
>> + * Returns a GByteArray with the read memory. Ownership of the GByteArr=
ay is
>> + * transferred to the caller, which is responsible for deallocating it =
after
>> + * use. On failure returns NULL.

We should definitely point out the pitfalls w.r.t callbacks here.

>> + */
>> +QEMU_PLUGIN_API
>> +GByteArray *qemu_plugin_read_memory_vaddr(uint64_t addr,
>> +                                          size_t len);
>> +
>
> IMHO, it would be better to pass the buffer as a parameter, instead of
> allocating a new one everytime.
>
> bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *buf,
> size_t len).

The registers case certainly does it this way so it makes sense to be
consistent. It also allows the plugins to re-use buffers if it wants and
makes managing lifetime a bit easier.

<snip>
>>           } else {
>>               fprintf(stderr, "unsupported argument: %s\n", argv[i]);
>>               return -1;
>> @@ -137,6 +234,22 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plu=
gin_id_t id,
>>           statistics =3D g_hash_table_new_full(NULL, g_direct_equal, NUL=
L, g_free);
>>       }
>>   +    if (do_log_writes) {
>> +        for (const struct SyscallInfo *syscall_info =3D arch_syscall_in=
fo;
>> +            syscall_info->name !=3D NULL; syscall_info++) {
>> +
>> +            if (g_strcmp0(syscall_info->name, info->target_name) =3D=3D=
 0) {
>> +                write_sysno =3D syscall_info->write_sysno;
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (write_sysno =3D=3D -1) {
>> +            fprintf(stderr, "write syscall number not found\n");
>> +            return -1;
>> +        }
>> +    }
>> +
>
> It's good! I appreciate to see this feature.
>
>>       qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>>       qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
>>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);

There was someone on IRC looking to trace system calls in system mode
(by tracking the syscall instruction and reading the registers at the
time). I wonder if we could make this plugin do the right thing in both
modes?

>
> Thanks,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

