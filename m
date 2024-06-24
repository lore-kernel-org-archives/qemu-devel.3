Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169E6C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcMk-0008Pw-QA; Mon, 24 Jun 2024 01:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcMU-0007tn-V2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcMP-00059K-CI
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:30 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fa3bdd91c1so4271445ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207324; x=1719812124; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoUCJzKO02LLLaNe8euEHw1pBDolf/wNTi++fVPbSH0=;
 b=pX8Ck63452qXn/wASHx3ndaQQWQ7ghqP0EkBN7MZIABN246b6LX66nPFte5dndUPYH
 ckz8nMO0PAB4izAPEEx38NyXlsLi5JP78KX8JSqaVHUSPNal2UdhidRx4RK3uDwSxTzM
 VsdtGfV+tEg9Te+TFE7+uxbFRPGPXYMw0t0uOySXZ6pz7djG7e5ibtnyiUIRqwQf1HN9
 xEHmPtBCAGoCg03bh59sZcHnGTY/E+VPPdZE8fscPXTrfAZxDHF5pA9ed738jrLvdP4v
 3HAaP76iI3IDffI7Ta4UZkP1uMBBA22vYdHivW1FisK9cprtxcScWUXI1Pyz6vrl9Fil
 gQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207324; x=1719812124;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QoUCJzKO02LLLaNe8euEHw1pBDolf/wNTi++fVPbSH0=;
 b=Bk/lWmXvA0/P7rgyGXa6XhG9AEPP8d8LMi9ILbo5OhxUvo3w8MbddjuKGBk6vb30If
 nZcP4a+30pmdS3rzQ+td0ECLuUwnN3NlDkZHtpOXJYxqNNLmWRejg1lltbAbY8ov76tJ
 nD9szPAdkk72CH5lyJEOqjHjgApE+pbOhywgnSer1gNnFIY+Q1i17gp5FoPjbNoUhcFz
 33Y/Nw8Y4gzyeLQlbOEll0ES+wiLTyeA7AR6DH3udoGQvg05+/sOISD4ypdp4hVtbloo
 NG2QLAEiZeyhLUeCD3BvZ/E9jfqfPKOR+x7a8Z4KzJu/3Oid9sd0eoPKsEQlVTHVDnfi
 4e6A==
X-Gm-Message-State: AOJu0Ywk7kb4Gxn1nIOEG8Lni9Gykb/UvbSqmXvxSceRwRsC89mjH4oG
 ukIkptAbgB6WnFXNZEsDFUJzHvh7OW2Gri88fOE55M+ZvT8r7XxvejaFSmFv/I8=
X-Google-Smtp-Source: AGHT+IGjHylShk+L3VN27Rk/rxmqNtoxz1+DYto3LOFGzHdcNzvYKpH/C5GSt1ueDZNsd0CyyWo/nA==
X-Received: by 2002:a17:902:f685:b0:1fa:229c:3efb with SMTP id
 d9443c01a7336-1fa23ed7a5cmr56162805ad.29.1719207323836; 
 Sun, 23 Jun 2024 22:35:23 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b401:1758:f7d8:1e03:a6d:61a0?
 ([2804:7f0:b401:1758:f7d8:1e03:a6d:61a0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6b9csm53626265ad.135.2024.06.23.22.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:35:23 -0700 (PDT)
Subject: Re: [PATCH v3 3/9] gdbstub: Add support for target-specific stubs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-4-gustavo.romero@linaro.org>
 <87ed8qhg0r.fsf@draig.linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <8d8ffbca-e7ec-e81f-d5fa-bf759fefbf85@linaro.org>
Date: Mon, 24 Jun 2024 02:35:19 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87ed8qhg0r.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.379,
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

Hi Alex,

On 6/21/24 5:11 AM, Alex Bennée wrote:
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
>    /*
>     * We don't support different sets of CPU gdb features on different
>     * CPUs yet so assert things are the same.
>     */
> 
>     g_assert(!extended_qsupported_features ||
>     g_strcmp0(extended_qsupported_features, qsupported_features) == 0)
>
Done in v4. Thanks.


Cheers,
Gustavo

  
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
>> +    extended_query_table = table;
>> +    extended_query_table_size = size;
> 
> Similar assert here.
> 
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
> 
> ditto
> 
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
>>   #endif /* GDBSTUB_COMMANDS_H */
> 
> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 

