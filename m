Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F0EC2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 09:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ8ru-0006PM-3A; Mon, 17 Jun 2024 05:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJ8rt-0006PA-1q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 05:41:41 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJ8rr-0001d5-0l
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 05:41:40 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6267778b3aso380848566b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 02:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718617297; x=1719222097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LvbA+HrbgfGYow3daAH/GAHP+vc257ZCJqNdgvoivvw=;
 b=bsOqPPJR/s2K6jDIvN/6ej6eh6HW8G8kBiccvUbk9UKRtyntN4iYlI77t6JngQcrrl
 iWkdj6GsrylsKCkbCTiQQv5gIXlgS/C5DaZWN6qkbU2xpr7Uoic5DHD5F6nL79MtZliR
 ms26TLWMrufR6MrQviDAB44LoWt8umn3hM6t8ut9SfaFD57yzItT3ss186wvUnBKYzQ9
 gfkDpA+f1sXQbq6AUZrx6at3WUJ2MttLCCTRcSqhvJtwsao6mHzCUN5ZMm21lcPWk/so
 XSKFdfu8g97bnVqH23fYZIlBrC9asm89Dh4Nb6Zvqr4T+NIckDVPI83yRWjDgvoO/sb1
 Dgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718617297; x=1719222097;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvbA+HrbgfGYow3daAH/GAHP+vc257ZCJqNdgvoivvw=;
 b=MPNZJeIg6rIW2maB06EoVquQ2FQm1B8dcgCEOS2wfOJEb8Ym9EvfChR1Tpw8Bt2vJy
 cSxR/NRefC4o+J4LAmmuba9FHJu77I1Ikhc0UubhZCaC7Hc1xFrPcWd/tHCuZXirLt/d
 mx2SCkGkmrr7zpxyzuP/+fDfGC6m0ZnTt5ip53YgHIX9uJU2C8PUxAoGhAToGkewZkly
 UIBlwWTzspehXU46lihpWNc2ORedixNRPJv6qFK/RS12GHylhavivxe8rK4lebgbKFNI
 Z2sYn6B1dSV8s710fJta76JSO0Dqtk7p1u029GwWn3FrnAoqBxZXQg0YD1kEdo803ZGP
 5gEw==
X-Gm-Message-State: AOJu0YzY0CBzl4A/FEfrDMbY9ZN5vPJfulfCw+WhtcA+EV0YmXz8bLTL
 ucNuntAkt9ry2+lJ9gnIp130JnjJ92RaJY7fYXqogVkMJsNXvhDZeA6PYI/3noY=
X-Google-Smtp-Source: AGHT+IElInn7W8VqmXtYLzeoz/brdAyMioj0z/YJVPSpJBBJywZHFI/PhX9hMw7h3ZsLhOsql1O5Iw==
X-Received: by 2002:a17:906:a013:b0:a6f:5318:b8f3 with SMTP id
 a640c23a62f3a-a6f60dc2058mr584608266b.57.1718617297239; 
 Mon, 17 Jun 2024 02:41:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db5b52sm496473666b.69.2024.06.17.02.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 02:41:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 560A65F78B;
 Mon, 17 Jun 2024 10:41:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 3/9] gdbstub: Add support for target-specific stubs
In-Reply-To: <c80bfaab-7974-bc0f-c66f-96d75e2d7e2b@linaro.org> (Gustavo
 Romero's message of "Mon, 17 Jun 2024 03:33:29 -0300")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-4-gustavo.romero@linaro.org>
 <871q4zvk5o.fsf@draig.linaro.org>
 <c80bfaab-7974-bc0f-c66f-96d75e2d7e2b@linaro.org>
Date: Mon, 17 Jun 2024 10:41:36 +0100
Message-ID: <87msnjewj3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Alex,
>
> On 6/14/24 8:27 AM, Alex Benn=C3=A9e wrote:
>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>>=20
>>> Currently, it's not possible to have stubs specific to a given target,
>>> even though there are GDB features which are target-specific, like, for
>>> instance, memory tagging.
>>>
>>> This commit introduces gdb_extend_qsupported_features,
>>> gdb_extend_query_table, and gdb_extend_set_table functions as interfaces
>>> to extend the qSupported string, the query handler table, and the set
>>> handler table, allowing target-specific stub implementations.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   gdbstub/gdbstub.c          | 59 ++++++++++++++++++++++++++++++++++----
>>>   include/gdbstub/commands.h | 22 ++++++++++++++
>>>   2 files changed, 75 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>>> index 9ff2f4177d..e69cc5131e 100644
>>> --- a/gdbstub/gdbstub.c
>>> +++ b/gdbstub/gdbstub.c
>>> @@ -1609,6 +1609,12 @@ static void handle_query_thread_extra(GArray *pa=
rams, void *user_ctx)
>>>       gdb_put_strbuf();
>>>   }
>>>   +static char *extended_qsupported_features;
>>> +void gdb_extend_qsupported_features(char *qsupported_features)
>>> +{
>> Maybe g_assert(!extended_qsupported_features)?
>>=20
>>> +    extended_qsupported_features =3D qsupported_features;
>>> +}
>>> +
>>>   static void handle_query_supported(GArray *params, void *user_ctx)
>>>   {
>>>       CPUClass *cc;
>>> @@ -1648,6 +1654,11 @@ static void handle_query_supported(GArray *param=
s, void *user_ctx)
>>>       }
>>>         g_string_append(gdbserver_state.str_buf,
>>> ";vContSupported+;multiprocess+");
>>> +
>>> +    if (extended_qsupported_features) {
>>> +        g_string_append(gdbserver_state.str_buf, extended_qsupported_f=
eatures);
>>> +    }
>>> +
>>>       gdb_put_strbuf();
>>>   }
>>>   @@ -1729,6 +1740,14 @@ static const GdbCmdParseEntry
>>> gdb_gen_query_set_common_table[] =3D {
>>>       },
>>>   };
>>>   +static GdbCmdParseEntry *extended_query_table;
>>> +static int extended_query_table_size;
>>> +void gdb_extend_query_table(GdbCmdParseEntry *table, int size)
>>> +{
>> g_assert(!extended_query_table)
>>=20
>>> +    extended_query_table =3D table;
>>> +    extended_query_table_size =3D size;
>>> +}
>>> +
>>>   static const GdbCmdParseEntry gdb_gen_query_table[] =3D {
>>>       {
>>>           .handler =3D handle_query_curr_tid,
>>> @@ -1821,6 +1840,14 @@ static const GdbCmdParseEntry gdb_gen_query_tabl=
e[] =3D {
>>>   #endif
>>>   };
>>>   +static GdbCmdParseEntry *extended_set_table;
>>> +static int extended_set_table_size;
>>> +void gdb_extend_set_table(GdbCmdParseEntry *table, int size)
>>> +{
>>> +    extended_set_table =3D table;
>>> +    extended_set_table_size =3D size;
>>> +}
>>> +
>>>   static const GdbCmdParseEntry gdb_gen_set_table[] =3D {
>>>       /* Order is important if has same prefix */
>>>       {
>>> @@ -1859,11 +1886,21 @@ static void handle_gen_query(GArray *params, vo=
id *user_ctx)
>>>           return;
>>>       }
>>>   -    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>>> -                            gdb_gen_query_table,
>>> -                            ARRAY_SIZE(gdb_gen_query_table))) {
>>> -        gdb_put_packet("");
>>> +    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>>> +                           gdb_gen_query_table,
>>> +                           ARRAY_SIZE(gdb_gen_query_table))) {
>>> +        return;
>>> +    }
>>> +
>>> +    if (extended_query_table &&
>>> +        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>>> +                           extended_query_table,
>>> +                           extended_query_table_size)) {
>>> +        return;
>>>       }
>>> +
>>> +    /* Can't handle query, return Empty response. */
>>> +    gdb_put_packet("");
>>>   }
>>>     static void handle_gen_set(GArray *params, void *user_ctx)
>>> @@ -1878,11 +1915,21 @@ static void handle_gen_set(GArray *params, void=
 *user_ctx)
>>>           return;
>>>       }
>>>   -    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>>> +    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>>>                              gdb_gen_set_table,
>>>                              ARRAY_SIZE(gdb_gen_set_table))) {
>>> -        gdb_put_packet("");
>>> +        return;
>>>       }
>>> +
>>> +    if (extended_set_table &&
>>> +        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>>> +                           extended_set_table,
>>> +                           extended_set_table_size)) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* Can't handle set, return Empty response. */
>>> +    gdb_put_packet("");
>>>   }
>>>     static void handle_target_halt(GArray *params, void *user_ctx)
>>> diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
>>> index dd45c38472..2204c3ddbe 100644
>>> --- a/include/gdbstub/commands.h
>>> +++ b/include/gdbstub/commands.h
>>> @@ -71,4 +71,26 @@ typedef struct GdbCmdParseEntry {
>>>    */
>>>   int gdb_put_packet(const char *buf);
>>>   +/**
>>> + * gdb_extend_query_table() - Extend query table.
>>> + * @table: The table with the additional query packet handlers.
>>> + * @size: The number of handlers to be added.
>>> + */
>>> +void gdb_extend_query_table(GdbCmdParseEntry *table, int size);
>>> +
>>> +/**
>>> + * gdb_extend_set_table() - Extend set table.
>>> + * @table: The table with the additional set packet handlers.
>>> + * @size: The number of handlers to be added.
>>> + */
>>> +void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
>>> +
>>> +/**
>>> + * gdb_extend_qsupported_features() - Extend the qSupported features s=
tring.
>>> + * @qsupported_features: The additional qSupported feature(s) string. =
The string
>>> + * should start with a semicolon and, if there are more than one featu=
re, the
>>> + * features should be separate by a semiocolon.
>>> + */
>>> +void gdb_extend_qsupported_features(char *qsupported_features);
>>> +
>> We should make it clear these functions should only be called once
>> (although I guess in a heterogeneous future we might have to do something
>> more clever).
>
> There a some cases where actually the API functions are called multiple
> times it looks like. For instance, the assert is hit in the following tes=
t:
>
> $ ./build/qemu-aarch64 ./build/tests/tcg/aarch64-linux-user/munmap-pthread
>
> Probably because pthread_create is involved, but I can't explain it
> yet.

Hmm, I guess new threads still need to register with gdb. I wonder if asser=
ts like:

  g_assert(extended_set_table || extended_set_table =3D=3D table)

would be valid?

>
>
> Cheers,
> Gustavo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

