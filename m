Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE405C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3gI-0005Rt-Hx; Tue, 12 Mar 2024 11:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk3gF-0005QX-Ul
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:04:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk3gC-0003xY-PO
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:04:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4132a89a351so13406635e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710255875; x=1710860675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ikn0OW3q4cTzR0TbRk29qEzYUyKhlG1xie0tSAUqMb0=;
 b=mbQ8lG3vpcKTh+66BBjLeUvq2x8tXYihTEqlKT6zyhfFtQF5YJdSuvIczrv6qAXpHq
 UiRErGbB0JWNWqweZnlV3C4ZyO3DEFUPtYrZJmL9vpPq5VlcnW29OE6SZhloESjlYnEY
 JmeDwAlRg3xmZRmKQwz/oyQS3UN1PZI9znw8ajLHywOl+mbht9jIqOtb6QxSVHcQnFOc
 7HwPBF6PZzpknNqOZOv6BeXq41WZE93p/m9e9kuSW2mXCbeTsfAssIRkFqcAE7trAJo1
 TknqYFVBomMKon9DnQ5mtScjjgxc8VkhGkJVFJ8kOnKJM8+N53Ob3HiqHqHYY7N0TgwI
 JJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710255875; x=1710860675;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ikn0OW3q4cTzR0TbRk29qEzYUyKhlG1xie0tSAUqMb0=;
 b=xAVPb6jQNPXQcMwx76fL46tSnINopiLEywXxaXIbTLSJ3/BKqTBhc4vBgeaB76czVM
 4Uj5ODC1Tdf1g7oWryUakjM1+W0j4Kky17pv9kHvA+mr4cy9gpMOJDSctBcQzOpovU++
 qTLWhnRzGxDWeVdQRPf9bWq/MhZ6GaxHva5rAVRk/XYq1nm/+AQLf6xYI7iMB1TevRPT
 32RSg30DXjaHZ8sh0xK+6qh2mpPjyhFDmB3WRRVU1EslVT09MBzTGW8F7pfxmnhczIBC
 VaYIwGB96sbvcIcgpprhp6L3ws0aFljIfvESMCp32kpm1mP0xkRvmEgH7xsb5/iRE132
 FTxA==
X-Gm-Message-State: AOJu0Yx+Ycdecys2gfZjMFRE7383w4kGeZyvrma81avobyaii9For5gr
 yFqWfx3gdHlpt6L8iG1U4qAdUF6bq1hSZrVKVjQIZNk6MMatUGqY8PvxNQnZzsnbYmRRZfbuQXD
 R
X-Google-Smtp-Source: AGHT+IHdOauxxJIkOKaVANzqmXpxruoFE7WMn9yDmLRHXvP2i1c41ZPv5ffQoKl27kbfJUUN/oFC1g==
X-Received: by 2002:a05:600c:4e56:b0:413:394b:3cdc with SMTP id
 e22-20020a05600c4e5600b00413394b3cdcmr1312815wmq.21.1710255874905; 
 Tue, 12 Mar 2024 08:04:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p14-20020a05600c358e00b00412d4c8b743sm12602683wmq.30.2024.03.12.08.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:04:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 113C65F756;
 Tue, 12 Mar 2024 15:04:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/5] plugins: conditional callbacks
In-Reply-To: <eb665792-5250-40f6-8bb5-9ca5b2d8c6f8@linaro.org> (Pierrick
 Bouvier's message of "Tue, 12 Mar 2024 10:03:21 +0400")
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
 <20240229055359.972151-5-pierrick.bouvier@linaro.org>
 <87bk7lqdw0.fsf@draig.linaro.org>
 <eb665792-5250-40f6-8bb5-9ca5b2d8c6f8@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 15:04:34 +0000
Message-ID: <87edcfo5j1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

> On 3/11/24 14:08, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> Extend plugins API to support callback called with a given criteria
>>> (evaluated inline).
>>>
>>> Added functions:
>>> - qemu_plugin_register_vcpu_tb_exec_cond_cb
>>> - qemu_plugin_register_vcpu_insn_exec_cond_cb
>>>
>>> They expect as parameter a condition, a qemu_plugin_u64_t (op1) and an
>>> immediate (op2). Callback is called if op1 |cond| op2 is true.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   include/qemu/plugin.h        |   7 ++
>>>   include/qemu/qemu-plugin.h   |  76 +++++++++++++++
>>>   plugins/plugin.h             |   8 ++
>>>   accel/tcg/plugin-gen.c       | 174 ++++++++++++++++++++++++++++++++++-
>>>   plugins/api.c                |  51 ++++++++++
>>>   plugins/core.c               |  19 ++++
>>>   plugins/qemu-plugins.symbols |   2 +
>>>   7 files changed, 334 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>>> index d92d64744e6..056102b2361 100644
>>> --- a/include/qemu/plugin.h
>>> +++ b/include/qemu/plugin.h
>>> @@ -74,6 +74,8 @@ enum plugin_dyn_cb_type {
>>>   enum plugin_dyn_cb_subtype {
>>>       PLUGIN_CB_REGULAR,
>>>       PLUGIN_CB_REGULAR_R,
>>> +    PLUGIN_CB_COND,
>>> +    PLUGIN_CB_COND_R,
>>>       PLUGIN_CB_INLINE_ADD_U64,
>>>       PLUGIN_CB_INLINE_STORE_U64,
>>>       PLUGIN_N_CB_SUBTYPES,
>>> @@ -97,6 +99,11 @@ struct qemu_plugin_dyn_cb {
>>>               enum qemu_plugin_op op;
>>>               uint64_t imm;
>>>           } inline_insn;
>>> +        struct {
>>> +            qemu_plugin_u64 entry;
>>> +            enum qemu_plugin_cond cond;
>>> +            uint64_t imm;
>>> +        } cond_cb;
>>>       };
>>>   };
>>>   diff --git a/include/qemu/qemu-plugin.h
>>> b/include/qemu/qemu-plugin.h
>>> index c5cac897a0b..337de25ece7 100644
>>> --- a/include/qemu/qemu-plugin.h
>>> +++ b/include/qemu/qemu-plugin.h
>>> @@ -262,6 +262,29 @@ enum qemu_plugin_mem_rw {
>>>       QEMU_PLUGIN_MEM_RW,
>>>   };
>>>   +/**
>>> + * enum qemu_plugin_cond - condition to enable callback
>>> + *
>>> + * @QEMU_PLUGIN_COND_NEVER: false
>>> + * @QEMU_PLUGIN_COND_ALWAYS: true
>>> + * @QEMU_PLUGIN_COND_EQ: is equal?
>>> + * @QEMU_PLUGIN_COND_NE: is not equal?
>>> + * @QEMU_PLUGIN_COND_LT: is less than?
>>> + * @QEMU_PLUGIN_COND_LE: is less than or equal?
>>> + * @QEMU_PLUGIN_COND_GT: is greater than?
>>> + * @QEMU_PLUGIN_COND_GE: is greater than or equal?
>>> + */
>>> +enum qemu_plugin_cond {
>>> +    QEMU_PLUGIN_COND_NEVER,
>>> +    QEMU_PLUGIN_COND_ALWAYS,
>>> +    QEMU_PLUGIN_COND_EQ,
>>> +    QEMU_PLUGIN_COND_NE,
>>> +    QEMU_PLUGIN_COND_LT,
>>> +    QEMU_PLUGIN_COND_LE,
>>> +    QEMU_PLUGIN_COND_GT,
>>> +    QEMU_PLUGIN_COND_GE,
>>> +};
>>> +
>>>   /**
>>>    * typedef qemu_plugin_vcpu_tb_trans_cb_t - translation callback
>>>    * @id: unique plugin id
>>> @@ -301,6 +324,32 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct q=
emu_plugin_tb *tb,
>>>                                             enum qemu_plugin_cb_flags f=
lags,
>>>                                             void *userdata);
>>>   +/**
>>> + * qemu_plugin_register_vcpu_tb_exec_cond_cb() - register conditional =
callback
>>> + * @tb: the opaque qemu_plugin_tb handle for the translation
>>> + * @cb: callback function
>>> + * @cond: condition to enable callback
>>> + * @entry: first operand for condition
>>> + * @imm: second operand for condition
>>> + * @flags: does the plugin read or write the CPU's registers?
>>> + * @userdata: any plugin data to pass to the @cb?
>>> + *
>>> + * The @cb function is called when a translated unit executes if
>>> + * entry @cond imm is true.
>>> + * If condition is QEMU_PLUGIN_COND_ALWAYS, condition is never interpr=
eted and
>>> + * this function is equivalent to qemu_plugin_register_vcpu_tb_exec_cb.
>>> + * If condition QEMU_PLUGIN_COND_NEVER, condition is never interpreted=
 and
>>> + * callback is never installed.
>>> + */
>>> +QEMU_PLUGIN_API
>>> +void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *=
tb,
>>> +                                               qemu_plugin_vcpu_udata_=
cb_t cb,
>>> +                                               enum qemu_plugin_cb_fla=
gs flags,
>>> +                                               enum qemu_plugin_cond c=
ond,
>>> +                                               qemu_plugin_u64 entry,
>> Is this a fixed entry or part of a scoreboard?
>>=20
>
> entry is an entry of scoreboard (automatically associated to each vcpu
> using vcpu_index) and can be modified by any other inline op, or
> callback. @imm (next parameter) is fixed yes.
>
> callback will be called only if entry <cond> imm true.

I wonder if having an alternate form for comparing two scoreboard
entries would be useful?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

