Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45198C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revLS-0006sh-6z; Tue, 27 Feb 2024 06:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1revLM-0006n3-UX
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:09:54 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1revLK-00078K-7y
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:09:52 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d1094b5568so46279811fa.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 03:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709032187; x=1709636987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7knbjUMnDpzzfvhJon+rgXRY+nK/6pyr/T+GmcaGMUE=;
 b=cMrNbDE9t7rqgd49NCFs0I5MwEP7tSfhCAPqM77ndLHT2EI9xeiGSRgXl23uRfDGf9
 X4eqhv6dCCEJCqYP0AfKpXzssig1xkMofX70ZszVDDtl08wrpElAd/EFxcc+Yei78k9F
 4XYuMLV5iimT9IJBgjYrN0OkzVVWcj5iWuZkem5Nfo+r9GbnnrUdaWe6HVO17n20uXti
 bK1ewrT+/uHDoEszQ0DDZzljvB/kXazSfhM2aOfCmD8f8Kc764rxg3Elu8ZeZ9/up1lu
 kPtEF7l2mmKqTp83ZlUi27wzJfwxGxOPNJukknT6+ve+2i8varGaSBBWmKnn9/7B5yuj
 nK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709032187; x=1709636987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7knbjUMnDpzzfvhJon+rgXRY+nK/6pyr/T+GmcaGMUE=;
 b=uAjOKSAXuRix783OBeOxVLWswfFIftOY9b7sCqEj4VQ6MLuMYW4ZiJkqPKRc5rBBIu
 yUS1OXXwtqS4dIC5btu4MLiM6xVuZkY8Nk86vKHQI4cM6P7Z+/cCT0mVeZBnHMl0hopK
 TnS04GG/g5ThdMz8V1lSakKhH18SUWieyIwL6JxH0vQwd7YWF/FaEOG/toUYuHQo80Tp
 i83V/teUrplXYZsoItGFEV4qCxu//lNSkar40ai62/3WFVI9N6Bj29gnONq7uZIDy+LQ
 FAY5Z8+XIOUYl81s9wtBFAdGbfYwFw9Ci4mARZf0pcooo8LPBhhOVeLbBV982RV8PySP
 j/rw==
X-Gm-Message-State: AOJu0Yza/KyWdGnP40fg93vYWvIywov+nbvKt9maTrXgWUUe2Ob/j3XE
 D1vwBWa40r47ffi+6PzA9YqbQZdrZvVqNC4HNu+DSNGQ15jWnPTWRaIwDokpBKI=
X-Google-Smtp-Source: AGHT+IFsarJjhFgP7E1JXgr97nwwXr6ISK0KlImhLk3jlcF+kFWAHzHiks6iUTQOb+GR25hxrAAAFQ==
X-Received: by 2002:a2e:9243:0:b0:2d2:a55f:60dc with SMTP id
 v3-20020a2e9243000000b002d2a55f60dcmr307111ljg.52.1709032187213; 
 Tue, 27 Feb 2024 03:09:47 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 hi17-20020a05600c535100b0041290251dc2sm14388075wmb.14.2024.02.27.03.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 03:09:46 -0800 (PST)
Message-ID: <e0688c8b-fac2-4b4f-8cda-a0c4f5ee2bf6@linaro.org>
Date: Tue, 27 Feb 2024 15:09:41 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] contrib/plugins/hotblocks: migrate to new
 per_vcpu API
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-10-pierrick.bouvier@linaro.org>
 <Zd2_VHB6-G7srfSo@luc-work-vm>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Zd2_VHB6-G7srfSo@luc-work-vm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x22e.google.com
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

On 2/27/24 2:54 PM, Luc Michel wrote:
> Hi Pierrick,
> 
> On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   contrib/plugins/hotblocks.c | 50 ++++++++++++++++++++++---------------
>>   1 file changed, 30 insertions(+), 20 deletions(-)
>>
>> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
>> index 4de1b134944..02bc5078bdd 100644
>> --- a/contrib/plugins/hotblocks.c
>> +++ b/contrib/plugins/hotblocks.c
>> @@ -34,8 +34,8 @@ static guint64 limit = 20;
>>    */
>>   typedef struct {
>>       uint64_t start_addr;
>> -    uint64_t exec_count;
>> -    int      trans_count;
>> +    struct qemu_plugin_scoreboard *exec_count;
>> +    int trans_count;
>>       unsigned long insns;
>>   } ExecCount;
>>
>> @@ -43,7 +43,17 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
>>   {
>>       ExecCount *ea = (ExecCount *) a;
>>       ExecCount *eb = (ExecCount *) b;
>> -    return ea->exec_count > eb->exec_count ? -1 : 1;
>> +    uint64_t count_a =
>> +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(ea->exec_count));
>> +    uint64_t count_b =
>> +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(eb->exec_count));
>> +    return count_a > count_b ? -1 : 1;
>> +}
>> +
>> +static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
>> +{
>> +    ExecCount *cnt = value;
>> +    qemu_plugin_scoreboard_free(cnt->exec_count);
>>   }
>>
>>   static void plugin_exit(qemu_plugin_id_t id, void *p)
>> @@ -52,7 +62,6 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>>       GList *counts, *it;
>>       int i;
>>
>> -    g_mutex_lock(&lock);
> 
> I encountered cases before where the vCPUs continue executing while
> plugin_exit is called. This can happen e.g., when QEMU calls exit(3)
> from one CPU thread. Others will continue to run at the same time the
> atexit callbacks are called.
> 
> This also means that you can't really free the resources as you do at
> the end of plugin_exit.
> 

Interesting...

The current documentation [1] mentions it's the right place to free 
resources, and from what I saw, existing plugins assume this too (see 
contrib/plugins/cache.c for instance).

There is probably a bug related to the case you mention, and I'll try to 
reproduce this, and see if we can have a proper fix.

I'm not sure that removing cleanup code from existing plugins is the 
right thing to do at the moment, even though there is an existing issue 
with some programs.

[1] 
https://www.qemu.org/docs/master/devel/tcg-plugins.html#c.qemu_plugin_register_atexit_cb

>>       g_string_append_printf(report, "%d entries in the hash table\n",
>>                              g_hash_table_size(hotblocks));
>>       counts = g_hash_table_get_values(hotblocks);
>> @@ -63,16 +72,21 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>>
>>           for (i = 0; i < limit && it->next; i++, it = it->next) {
>>               ExecCount *rec = (ExecCount *) it->data;
>> -            g_string_append_printf(report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
>> -                                   rec->start_addr, rec->trans_count,
>> -                                   rec->insns, rec->exec_count);
>> +            g_string_append_printf(
>> +                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
>> +                rec->start_addr, rec->trans_count,
>> +                rec->insns,
>> +                qemu_plugin_u64_sum(
>> +                    qemu_plugin_scoreboard_u64(rec->exec_count)));
>>           }
>>
>>           g_list_free(it);
>>       }
>> -    g_mutex_unlock(&lock);
>>
>>       qemu_plugin_outs(report->str);
>> +
>> +    g_hash_table_foreach(hotblocks, exec_count_free, NULL);
>> +    g_hash_table_destroy(hotblocks);
>>   }
>>
>>   static void plugin_init(void)
>> @@ -82,15 +96,9 @@ static void plugin_init(void)
>>
>>   static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>>   {
>> -    ExecCount *cnt;
>> -    uint64_t hash = (uint64_t) udata;
>> -
>> -    g_mutex_lock(&lock);
>> -    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
>> -    /* should always succeed */
>> -    g_assert(cnt);
>> -    cnt->exec_count++;
>> -    g_mutex_unlock(&lock);
>> +    ExecCount *cnt = (ExecCount *)udata;
>> +    qemu_plugin_u64_add(qemu_plugin_scoreboard_u64(cnt->exec_count),
>> +                        cpu_index, 1);
>>   }
>>
>>   /*
>> @@ -114,18 +122,20 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>           cnt->start_addr = pc;
>>           cnt->trans_count = 1;
>>           cnt->insns = insns;
>> +        cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
>>           g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
>>       }
>>
>>       g_mutex_unlock(&lock);
>>
>>       if (do_inline) {
>> -        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
>> -                                                 &cnt->exec_count, 1);
>> +        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>> +            tb, QEMU_PLUGIN_INLINE_ADD_U64,
>> +            qemu_plugin_scoreboard_u64(cnt->exec_count), 1);
>>       } else {
>>           qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
>>                                                QEMU_PLUGIN_CB_NO_REGS,
>> -                                             (void *)hash);
>> +                                             (void *)cnt);
>>       }
>>   }
>>
>> --
>> 2.43.0
>>
>>
> 

