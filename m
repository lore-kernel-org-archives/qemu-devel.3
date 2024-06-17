Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A2DC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5vx-0001dV-7f; Mon, 17 Jun 2024 02:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5vt-0001d7-Nh
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:33:38 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5vr-0004FM-94
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:33:37 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c2d25b5432so3129376a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718606013; x=1719210813; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytwHj4dRZHFCNG9OgM8M8N5n9Xmg0HQumV2USSs/sVk=;
 b=udSxqBfU/reSFeK9jS59gA5fI5GEDFsxQeUhK2L5wMorx8cX3CCyHTerRFqwq81tYb
 dETGnRPHwEqGICSl+hdDxh3InXcz+t5YXxWvldZnyUIlimvPcLDKH+IoqQPcKJRPQv2O
 qhPgNyUpP981eP6POU32YnrVkvQp64up56XJwkZ7hGw+fdQhJMnTzvTDO36RDDncxG+S
 0yVkLJTYBoA97ioNOS7fod/osPKaavyZuyqjLtYxyEa9fAMxnJNNuGHW5mqs6qs6NYZ5
 r43m2i9OAmUUW2UK+iOBl72Mt8s+oL2+en+Ogs8oB9DKe+Cuz/z22UrAXjXzs+uJkugz
 jgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718606013; x=1719210813;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ytwHj4dRZHFCNG9OgM8M8N5n9Xmg0HQumV2USSs/sVk=;
 b=KZCXaBKxzGxMMVz+SW0h+GG2FPVvhkFNw+VaZ0H5Qg5woeXfAZamQf6BGKe/+w5PSL
 4fUaEnhVbtABwlKTzzwVY8h4wbOszJc4agnz7YQtvgp3XapPNJdTCeaDik1A1hT6JXK9
 dHhBEoM4JvA+0NianRfx2+qEqD306lM3EUoiYsYPZrjRm7clq12xzcK2dvnW13BIREGN
 mPWUGIP7YLy5Hqu1Nbn0HhQuh1KDLlWsT0V8hbNGuSRMFHwwsIsApR0ZDx9Wltvbyqx1
 e/e/xgvKzpj7jNcn+tq53ukZNXiyoljsdobMCfgaauB86fYwNQ0ngz/+/4JjSEY9HgEy
 B+rg==
X-Gm-Message-State: AOJu0YymykR+iX125/ekboB1tam18H0hEYckOHZWPwiJ94pSPfFAj5kE
 ULOwvHf/gU5QUnsxmQoHcs+gNlx9Ylj3sZ2bJRkl7VBRkwZAxfuSrcBo1sxEQoA=
X-Google-Smtp-Source: AGHT+IG5CiezOwOK4XbO6nIRyEd2voT6P6e64r3970XpB2vwLgR33crmgMfqKMOxT6T1Umg7BcwrYw==
X-Received: by 2002:a17:90a:d518:b0:2c4:f8d8:27d7 with SMTP id
 98e67ed59e1d1-2c4f8d83e27mr4609834a91.43.1718606013290; 
 Sun, 16 Jun 2024 23:33:33 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5?
 ([2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a769bfefsm10549436a91.44.2024.06.16.23.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 23:33:32 -0700 (PDT)
Subject: Re: [PATCH v2 3/9] gdbstub: Add support for target-specific stubs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-4-gustavo.romero@linaro.org>
 <871q4zvk5o.fsf@draig.linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <c80bfaab-7974-bc0f-c66f-96d75e2d7e2b@linaro.org>
Date: Mon, 17 Jun 2024 03:33:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <871q4zvk5o.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.677,
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

Hi Alex,

On 6/14/24 8:27 AM, Alex Bennée wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> Currently, it's not possible to have stubs specific to a given target,
>> even though there are GDB features which are target-specific, like, for
>> instance, memory tagging.
>>
>> This commit introduces gdb_extend_qsupported_features,
>> gdb_extend_query_table, and gdb_extend_set_table functions as interfaces
>> to extend the qSupported string, the query handler table, and the set
>> handler table, allowing target-specific stub implementations.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   gdbstub/gdbstub.c          | 59 ++++++++++++++++++++++++++++++++++----
>>   include/gdbstub/commands.h | 22 ++++++++++++++
>>   2 files changed, 75 insertions(+), 6 deletions(-)
>>
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index 9ff2f4177d..e69cc5131e 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -1609,6 +1609,12 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
>>       gdb_put_strbuf();
>>   }
>>   
>> +static char *extended_qsupported_features;
>> +void gdb_extend_qsupported_features(char *qsupported_features)
>> +{
> 
> Maybe g_assert(!extended_qsupported_features)?
> 
>> +    extended_qsupported_features = qsupported_features;
>> +}
>> +
>>   static void handle_query_supported(GArray *params, void *user_ctx)
>>   {
>>       CPUClass *cc;
>> @@ -1648,6 +1654,11 @@ static void handle_query_supported(GArray *params, void *user_ctx)
>>       }
>>   
>>       g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
>> +
>> +    if (extended_qsupported_features) {
>> +        g_string_append(gdbserver_state.str_buf, extended_qsupported_features);
>> +    }
>> +
>>       gdb_put_strbuf();
>>   }
>>   
>> @@ -1729,6 +1740,14 @@ static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
>>       },
>>   };
>>   
>> +static GdbCmdParseEntry *extended_query_table;
>> +static int extended_query_table_size;
>> +void gdb_extend_query_table(GdbCmdParseEntry *table, int size)
>> +{
> 
> g_assert(!extended_query_table)
> 
>> +    extended_query_table = table;
>> +    extended_query_table_size = size;
>> +}
>> +
>>   static const GdbCmdParseEntry gdb_gen_query_table[] = {
>>       {
>>           .handler = handle_query_curr_tid,
>> @@ -1821,6 +1840,14 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
>>   #endif
>>   };
>>   
>> +static GdbCmdParseEntry *extended_set_table;
>> +static int extended_set_table_size;
>> +void gdb_extend_set_table(GdbCmdParseEntry *table, int size)
>> +{
>> +    extended_set_table = table;
>> +    extended_set_table_size = size;
>> +}
>> +
>>   static const GdbCmdParseEntry gdb_gen_set_table[] = {
>>       /* Order is important if has same prefix */
>>       {
>> @@ -1859,11 +1886,21 @@ static void handle_gen_query(GArray *params, void *user_ctx)
>>           return;
>>       }
>>   
>> -    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>> -                            gdb_gen_query_table,
>> -                            ARRAY_SIZE(gdb_gen_query_table))) {
>> -        gdb_put_packet("");
>> +    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>> +                           gdb_gen_query_table,
>> +                           ARRAY_SIZE(gdb_gen_query_table))) {
>> +        return;
>> +    }
>> +
>> +    if (extended_query_table &&
>> +        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>> +                           extended_query_table,
>> +                           extended_query_table_size)) {
>> +        return;
>>       }
>> +
>> +    /* Can't handle query, return Empty response. */
>> +    gdb_put_packet("");
>>   }
>>   
>>   static void handle_gen_set(GArray *params, void *user_ctx)
>> @@ -1878,11 +1915,21 @@ static void handle_gen_set(GArray *params, void *user_ctx)
>>           return;
>>       }
>>   
>> -    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>> +    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>>                              gdb_gen_set_table,
>>                              ARRAY_SIZE(gdb_gen_set_table))) {
>> -        gdb_put_packet("");
>> +        return;
>>       }
>> +
>> +    if (extended_set_table &&
>> +        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>> +                           extended_set_table,
>> +                           extended_set_table_size)) {
>> +        return;
>> +    }
>> +
>> +    /* Can't handle set, return Empty response. */
>> +    gdb_put_packet("");
>>   }
>>   
>>   static void handle_target_halt(GArray *params, void *user_ctx)
>> diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
>> index dd45c38472..2204c3ddbe 100644
>> --- a/include/gdbstub/commands.h
>> +++ b/include/gdbstub/commands.h
>> @@ -71,4 +71,26 @@ typedef struct GdbCmdParseEntry {
>>    */
>>   int gdb_put_packet(const char *buf);
>>   
>> +/**
>> + * gdb_extend_query_table() - Extend query table.
>> + * @table: The table with the additional query packet handlers.
>> + * @size: The number of handlers to be added.
>> + */
>> +void gdb_extend_query_table(GdbCmdParseEntry *table, int size);
>> +
>> +/**
>> + * gdb_extend_set_table() - Extend set table.
>> + * @table: The table with the additional set packet handlers.
>> + * @size: The number of handlers to be added.
>> + */
>> +void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
>> +
>> +/**
>> + * gdb_extend_qsupported_features() - Extend the qSupported features string.
>> + * @qsupported_features: The additional qSupported feature(s) string. The string
>> + * should start with a semicolon and, if there are more than one feature, the
>> + * features should be separate by a semiocolon.
>> + */
>> +void gdb_extend_qsupported_features(char *qsupported_features);
>> +
> 
> We should make it clear these functions should only be called once
> (although I guess in a heterogeneous future we might have to do something
> more clever).

There a some cases where actually the API functions are called multiple
times it looks like. For instance, the assert is hit in the following test:

$ ./build/qemu-aarch64 ./build/tests/tcg/aarch64-linux-user/munmap-pthread

Probably because pthread_create is involved, but I can't explain it yet.


Cheers,
Gustavo

