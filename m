Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8443104953F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GM3-0004zx-Ku; Wed, 11 Mar 2026 05:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w0GLy-0004zR-Sq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:59:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w0GLv-0000bp-0p
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:59:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-485392de558so19723325e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773223179; x=1773827979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8wZt4XB77QBsDVJLkD1cJ8p8swY8/o57zXOJbb8EwU=;
 b=ayZNJ49sM9g8gJEiVBrEILZ7ONirXZ6eDw9Ou1t9PtCebd8Z5qdn6AtCar9+a/dX+u
 HIfSYi/Bql2qXBKEnS7pKb6yqKV4EzTWl0ZemdRN+xPmCZ6Q0WP++Oszg8mR3tYQQrqQ
 7pZ62mULl1mtiTMR/jtNajX4w9gUkfeWhD7F+zE78DpDjkrQgxaF3mPHiodbH3N9HTlG
 o0GyApu7EeLfdEN8atI2SFGC1LELy3FOZrUuNMqmG9JM3UUFfOEreFmXRHKVQeC4nyuN
 eEcTnxEnLNrYWp+JgVUKW5/CTlr4YRzLxz8YnIuySfTVkVZ5VBTXmDjJbu/asJ0uYFjP
 YJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773223179; x=1773827979;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N8wZt4XB77QBsDVJLkD1cJ8p8swY8/o57zXOJbb8EwU=;
 b=WNdO9hYQcmiqDPG0fsO1wFdbpiJ9C4lAt9i3vU+MgfhDh6Lgyw5jkeUy7CsSahhH4r
 LMok9/GCK1VJ/a7/cnUIYY7Tvsyz/+V/WTqBV0hoRJ09UTWd3AuPrIEPKi0jFgkq6Owr
 1FL1UVn+bSCfNk1O4AbSD28WQh2WcPZzkgcqLjJOy7UiqrxYR/+ue2om0lMV4X0+ha75
 vUvTONM3W1mtCLO6glAW1m24YTZS3tqD57ivFioKuUNONCFn1h40o+8dznRKEZz2/mt3
 qJm4p1bl4HNCcP4/sYix8yFDrrLW5VhM32B5QNWgbwnFEQ9Z6AZPjy0CRtb3ZGDROt1a
 H7UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhKXhISA6GgXUyq+HO2zHwf07sEN7eCveBrxWStwRO/b7YYxxpVHGLDE59sAxqrNeJtsrK2QSPRyvi@nongnu.org
X-Gm-Message-State: AOJu0Yw4tcC2n80P4v0ErUXJMUO1jQUo1alZ6mG180tIa5xJ3vaRSyYu
 RzKaMvTr9LvJCu28lpwEEnn70M6JYwvIgV4iEsv2cvELNu8D+vkSFpe7QHnZA/w2vRYdSUaEvFW
 GCmGstoA=
X-Gm-Gg: ATEYQzwCSVpgMmT9pkqG5f0zHml16twFErFPsdnZdnYWIITvk2yuvfd1HQ5Sz75d7TT
 w3DI5wyEB0ZJpRz0tYQwkfzilP9uDXJSqPoEXiSh1Zjk9fsLqHWW5bMgmUkypOJxqL+aEZvfMkB
 xhiy8O/ew0Ckavx8kv4iwOBztIsXy2YIfW5GSA4dxkolpoM1+vl22lrqwOw2cwCKtQ1lOMigawg
 EvzAlBAvpErgBsl01AFoUUr+7qbzfvAyTginlSOH+ZFECWF7a1fOzH4I3BjLwmn6oQgW/OchaE8
 7+xEb1vodItFLDzR8BlxcQpvetbQpz3lJjDQPPiJAkKfyjw2Wc8YcvOsZIVwyahjsftjgmKOcQ2
 qK7uy38yEid7pdwHkA4pze5ErB0tooxtFFeuoo1X6xAz5WETyzB/HXTc6XrCRMN5QMArhNlfo3i
 taMpX9USXEomaHTeDXcQM507w=
X-Received: by 2002:a05:600c:c4a2:b0:485:4371:539a with SMTP id
 5b1f17b1804b1-4854b134965mr32932115e9.31.1773223179402; 
 Wed, 11 Mar 2026 02:59:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a5143sm5210210f8f.14.2026.03.11.02.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 02:59:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF38E5F813;
 Wed, 11 Mar 2026 09:59:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,  qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  richard.henderson@linaro.org
Subject: Re: [PATCH trivial] plugins: add missing docstrings to qemu-plugin.h
In-Reply-To: <f624f3d9-aa11-406a-ac9b-f3fa2b103291@linaro.org> (Pierrick
 Bouvier's message of "Mon, 9 Mar 2026 10:25:19 -0700")
References: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
 <f624f3d9-aa11-406a-ac9b-f3fa2b103291@linaro.org>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 11 Mar 2026 09:59:37 +0000
Message-ID: <87o6kuit4m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 3/9/26 9:21 AM, Florian Hofhammer wrote:
>> This patch adds docstrings for typedefs and function declarations in
>> include/plugins/qemu-plugin.h that were previously missing. This
>> resolves inconsistencies in the docs, e.g., the description for
>> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
>> but code cache flush callbacks not being documented themselves.
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>> Hi,
>> While working on a QEMU plugin and browsing the online docs at
>> https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed that
>> some of the API functions were not actually documented.
>> I went through the include/plugins/qemu-plugin.h header file and
>> added
>> docstrings where they were missing, hoping of course that I documented
>> the correct functionality based on my understanding of the plugin
>> internals.
>> I hope that's useful and I didn't miss anything!
>>
>
> Thanks for the effort, that's always welcome to add documentation on a
> public API like this!
>
>> Best regards,
>> Florian
>> --
>> Florian Hofhammer
>> ---
>>   include/plugins/qemu-plugin.h | 98 +++++++++++++++++++++++++++++++++++=
+++-----
>>   1 file changed, 88 insertions(+), 10 deletions(-)
>> diff --git a/include/plugins/qemu-plugin.h
>> b/include/plugins/qemu-plugin.h
>> index 827e8e1787..fcf5af52ed 100644
>> --- a/include/plugins/qemu-plugin.h
>> +++ b/include/plugins/qemu-plugin.h
>> @@ -339,12 +339,28 @@ enum qemu_plugin_cb_flags {
>>       QEMU_PLUGIN_CB_RW_REGS_PC,
>>   };
>>   +/**
>> + * enum qemu_plugin_mem_rw - type of memory access
>> + *
>> + * @QEMU_PLUGIN_MEM_R: memory read access only
>> + * @QEMU_PLUGIN_MEM_W: memory write access only
>> + * @QEMU_PLUGIN_MEM_RW: memory read and write access
>> + */
>>   enum qemu_plugin_mem_rw {
>>       QEMU_PLUGIN_MEM_R =3D 1,
>>       QEMU_PLUGIN_MEM_W,
>>       QEMU_PLUGIN_MEM_RW,
>>   };
>>   +/**
>> + * enum qemu_plugin_mem_value_type - size of memory value
>> + *
>> + * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value
>> + */
>>   enum qemu_plugin_mem_value_type {
>>       QEMU_PLUGIN_MEM_VALUE_U8,
>>       QEMU_PLUGIN_MEM_VALUE_U16,
>> @@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {
>>       QEMU_PLUGIN_MEM_VALUE_U128,
>>   };
>>   -/* typedef qemu_plugin_mem_value - value accessed during a
>> load/store */
>> +/**
>> + * typedef qemu_plugin_mem_value - value accessed during a load/store
>> + *
>> + * @type: the memory access size
>> + * @data: the value accessed during the memory operation (value after
>> + *        read/write)
>> + */
>>   typedef struct {
>>       enum qemu_plugin_mem_value_type type;
>>       union {
>> @@ -462,7 +484,6 @@ void qemu_plugin_register_vcpu_tb_exec_cond_cb(struc=
t qemu_plugin_tb *tb,
>>    * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
>>    * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
>>    */
>> -
>>   enum qemu_plugin_op {
>>       QEMU_PLUGIN_INLINE_ADD_U64,
>>       QEMU_PLUGIN_INLINE_STORE_U64,
>> @@ -803,6 +824,20 @@ const void *qemu_plugin_request_time_control(void);
>>   QEMU_PLUGIN_API
>>   void qemu_plugin_update_ns(const void *handle, int64_t time);
>>   +/**
>> + * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback functi=
on type
>> + * @id: plugin id
>> + * @vcpu_index: the executing vCPU
>> + * @num: the syscall number
>> + * @a1: the 1st syscall argument
>> + * @a2: the 2nd syscall argument
>> + * @a3: the 3rd syscall argument
>> + * @a4: the 4th syscall argument
>> + * @a5: the 5th syscall argument
>> + * @a6: the 6th syscall argument
>> + * @a7: the 7th syscall argument
>> + * @a8: the 8th syscall argument
>> + */
>>   typedef void
>>   (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcp=
u_index,
>>                                    int64_t num, uint64_t a1, uint64_t a2,
>> @@ -836,24 +871,61 @@ typedef bool
>>                                           uint64_t a6, uint64_t a7, uint=
64_t a8,
>>                                           uint64_t *sysret);
>>   -QEMU_PLUGIN_API
>> -void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>> -                                          qemu_plugin_vcpu_syscall_cb_t=
 cb);
>> -
>> +/**
>> + * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return call=
back
>> + * function type
>> + * @id: plugin id
>> + * @vcpu_index: the executing vCPU
>> + * @num: the syscall number
>> + * @ret: the syscall return value
>> + */
>>   typedef void
>>   (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int=
 vcpu_idx,
>>                                        int64_t num, int64_t ret);
>>   +/**
>> + * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry ca=
llback
>> + * @id: plugin id
>> + * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
>> + *
>> + * This registers a callback for every syscall executed by the guest. T=
he @cb
>> + * function is executed before a syscall is handled by the host.
>> + */
>>   QEMU_PLUGIN_API
>> -void
>> -qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
>> -                                         qemu_plugin_vcpu_syscall_ret_c=
b_t cb);
>> +void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>> +                                          qemu_plugin_vcpu_syscall_cb_t=
 cb);
>>   +/**
>> + * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall f=
ilter
>> + * callback
>> + * @id: plugin id
>> + * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t
>> + *
>> + * This registers a callback for every syscall executed by the guest. T=
he @cb
>> + * function is executed before a syscall is handled by the host. If the
>> + * callback returns true, the syscall is filtered and will not be execu=
ted by
>> + * the host. The callback must then set the syscall return value via the
>> + * corresponding pointer passed to it.
>> + */
>>   QEMU_PLUGIN_API
>>   void
>>   qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
>>                                               qemu_plugin_vcpu_syscall_f=
ilter_cb_t cb);
>>   +/**
>> + * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry
>> + * callback
>> + * @id: plugin id
>> + * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t
>> + *
>> + * This registers a callback for every syscall executed by the guest. T=
he @cb
>> + * function is executed upon return from the host syscall before execut=
ion is
>> + * handed back to the guest.
>> + */
>> +QEMU_PLUGIN_API
>> +void
>> +qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
>> +                                         qemu_plugin_vcpu_syscall_ret_c=
b_t cb);
>>     /**
>>    * qemu_plugin_insn_disas() - return disassembly string for instruction
>> @@ -861,7 +933,6 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plu=
gin_id_t id,
>>    *
>>    * Returns an allocated string containing the disassembly
>>    */
>> -
>>   QEMU_PLUGIN_API
>>   char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
>>   @@ -888,6 +959,13 @@ QEMU_PLUGIN_API
>>   void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>>                                  qemu_plugin_vcpu_simple_cb_t cb);
>>   +/**
>> + * qemu_plugin_register_flush_cb() - register code cache flush callback
>> + * @id: plugin ID
>> + * @cb: callback
>> + *
>> + * The @cb function is called every time the code cache is flushed.
>> + */
>
> Thanks, I was thinking to document this since someone asked a question
> on IRC a few weeks ago.
>
> May you add here:
> "This callback can be used to free resources associated with existing
> translated blocks in a plugin. @cb is guaranteed to run with all cpus
> being stopped, thus no lock is required within it."

This does make me wonder what the use case for this callback is? In
theory the state of the code cache should be an internal implementation
detail that plugins shouldn't need to concern themselves with.

>
>>   QEMU_PLUGIN_API
>>   void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
>>                                      qemu_plugin_simple_cb_t cb);
>> ---
>> base-commit: 7608a95d2e0bd8c8d069ab77824d02586dd94648
>> change-id: 20260309-add-missing-plugin-docs-159d7ff315f9
>>=20
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

