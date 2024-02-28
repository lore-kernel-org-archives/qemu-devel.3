Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3C6C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEvT-0000Ks-9R; Wed, 28 Feb 2024 03:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfEvQ-0000Ke-QL
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:04:25 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfEvL-0008HO-1G
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:04:24 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-512bc0e8ce1so5526771e87.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709107455; x=1709712255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ymPkbYhA98WbWjkBlzH58cLNFFhFrhkTBLmoCJ66UIo=;
 b=KhY6wuTVpkR2jdILkX/NNbytEGZblEcDbNCQgS3BfyUzuFmYvQd6+niUCn+PDwLomo
 rLfh0u49G8Jl7LmMQDu17ZthlvXlN6gW9jl+K0EtWuyiwF0cRBPI88Cb0othiYP0ph3O
 s8YJh9LPS7JYa2IhKQxHb6GkQhWB5gYiyfJs7HbC5cImonMdSxiqKl3ivAeCD66E2WJq
 ZVD8It0IEUui9Ui4NiKxGAgKU8cbXI/EYlYKanu8b0UCe2YP1kSL/WvgR8Wi3rkj1ltE
 7KaL6vQ+d47SBhe3XyRbEmDt7hEBXyX/z7K7MlaJ4NFEyCVgsdRdCftsDotY2xcvEPYm
 56Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107455; x=1709712255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ymPkbYhA98WbWjkBlzH58cLNFFhFrhkTBLmoCJ66UIo=;
 b=kaG0KYq3+eHyhe/KF4wuyfIEe8IJrC5+yyLD3t+fzf1DO4UAdHtyW7JQDmdKeXEh9b
 c0jTqRtWtVBLg+w63o+KbmYBbad8vlunyS3BN6tY3iSNV/c5Da7/h4AgEupqHdwbQgxM
 I0aFC7yuA4ZBIVNRMEoxWpmtaayasHYVhRsKQZetFAy7bL0ak4s0/pkswiQ5sVbnWQxg
 I996lQp9IseQhfWQWvJV36D/2Dq2/XvBhCMzqRjymfpzdfQa4qi6g6TNJMJZnyeJCVFm
 c2pUm1ehYlhps15ZXKaVHBSy0YrkMaFv+n8cxhmPJBHS0M12tueOXPe1DrnhE/enO+52
 KIiw==
X-Gm-Message-State: AOJu0YzwZhJ151sXQJujwqQhdXWuYJlAlRVASEipe1D+3SQLLQwc3RoY
 SQV0yhEXctD5KZyvSblWwfM2+8qOlUekqtrWTWAbOOzqQR4Qq9wyjNl287YHrkA=
X-Google-Smtp-Source: AGHT+IENvRt/cL393vp7n+JWZsRa/4F8KJlA1FGId8Uf+Eupn7TiF6dHY9GY2qKo4bx2Bs1Yn91fNQ==
X-Received: by 2002:a05:6512:128b:b0:512:a899:34e9 with SMTP id
 u11-20020a056512128b00b00512a89934e9mr10008541lfs.58.1709107455361; 
 Wed, 28 Feb 2024 00:04:15 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a05600c0a4600b00412a5a24745sm1271855wmq.27.2024.02.28.00.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 00:04:14 -0800 (PST)
Message-ID: <68b1dff0-13db-4ad0-a1b0-a85991fb3374@linaro.org>
Date: Wed, 28 Feb 2024 12:04:10 +0400
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
 <e0688c8b-fac2-4b4f-8cda-a0c4f5ee2bf6@linaro.org>
 <Zd3xGrZetKoAbIn1@luc-work-vm>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Zd3xGrZetKoAbIn1@luc-work-vm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

On 2/27/24 6:26 PM, Luc Michel wrote:
> On 15:09 Tue 27 Feb     , Pierrick Bouvier wrote:
>> On 2/27/24 2:54 PM, Luc Michel wrote:
>>> Hi Pierrick,
>>>
>>> On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    contrib/plugins/hotblocks.c | 50 ++++++++++++++++++++++---------------
>>>>    1 file changed, 30 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
>>>> index 4de1b134944..02bc5078bdd 100644
>>>> --- a/contrib/plugins/hotblocks.c
>>>> +++ b/contrib/plugins/hotblocks.c
>>>> @@ -34,8 +34,8 @@ static guint64 limit = 20;
>>>>     */
>>>>    typedef struct {
>>>>        uint64_t start_addr;
>>>> -    uint64_t exec_count;
>>>> -    int      trans_count;
>>>> +    struct qemu_plugin_scoreboard *exec_count;
>>>> +    int trans_count;
>>>>        unsigned long insns;
>>>>    } ExecCount;
>>>>
>>>> @@ -43,7 +43,17 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
>>>>    {
>>>>        ExecCount *ea = (ExecCount *) a;
>>>>        ExecCount *eb = (ExecCount *) b;
>>>> -    return ea->exec_count > eb->exec_count ? -1 : 1;
>>>> +    uint64_t count_a =
>>>> +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(ea->exec_count));
>>>> +    uint64_t count_b =
>>>> +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(eb->exec_count));
>>>> +    return count_a > count_b ? -1 : 1;
>>>> +}
>>>> +
>>>> +static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
>>>> +{
>>>> +    ExecCount *cnt = value;
>>>> +    qemu_plugin_scoreboard_free(cnt->exec_count);
>>>>    }
>>>>
>>>>    static void plugin_exit(qemu_plugin_id_t id, void *p)
>>>> @@ -52,7 +62,6 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>>>>        GList *counts, *it;
>>>>        int i;
>>>>
>>>> -    g_mutex_lock(&lock);
>>>
>>> I encountered cases before where the vCPUs continue executing while
>>> plugin_exit is called. This can happen e.g., when QEMU calls exit(3)
>>> from one CPU thread. Others will continue to run at the same time the
>>> atexit callbacks are called.
>>>
>>> This also means that you can't really free the resources as you do at
>>> the end of plugin_exit.
>>>
>>
>> Interesting...
>>
>> The current documentation [1] mentions it's the right place to free
>> resources, and from what I saw, existing plugins assume this too (see
>> contrib/plugins/cache.c for instance).
>>
>> There is probably a bug related to the case you mention, and I'll try to
>> reproduce this, and see if we can have a proper fix.
>>
>> I'm not sure that removing cleanup code from existing plugins is the
>> right thing to do at the moment, even though there is an existing issue
>> with some programs.
> 
> Yes absolutely. The problem is on the QEMU side. FWIW I tried to fix one
> of those exit cases (semihosted exit syscall) some time ago:
> https://lore.kernel.org/qemu-devel/20220621125916.25257-1-lmichel@kalray.eu/
> 
> IIRC Peter was not fundamentally against it. But then I was off for
> several months due to medical reasons.
> 
> I can take some time to rebase it and address Peter's comments if there
> is interest to it.
> 

It could be well appreciated, and definitely worth fixing!

> Luc
> 
>>
>> [1]
>> https://www.qemu.org/docs/master/devel/tcg-plugins.html#c.qemu_plugin_register_atexit_cb
>>
>>>>        g_string_append_printf(report, "%d entries in the hash table\n",
>>>>                               g_hash_table_size(hotblocks));
>>>>        counts = g_hash_table_get_values(hotblocks);
>>>> @@ -63,16 +72,21 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>>>>
>>>>            for (i = 0; i < limit && it->next; i++, it = it->next) {
>>>>                ExecCount *rec = (ExecCount *) it->data;
>>>> -            g_string_append_printf(report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
>>>> -                                   rec->start_addr, rec->trans_count,
>>>> -                                   rec->insns, rec->exec_count);
>>>> +            g_string_append_printf(
>>>> +                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
>>>> +                rec->start_addr, rec->trans_count,
>>>> +                rec->insns,
>>>> +                qemu_plugin_u64_sum(
>>>> +                    qemu_plugin_scoreboard_u64(rec->exec_count)));
>>>>            }
>>>>
>>>>            g_list_free(it);
>>>>        }
>>>> -    g_mutex_unlock(&lock);
>>>>
>>>>        qemu_plugin_outs(report->str);
>>>> +
>>>> +    g_hash_table_foreach(hotblocks, exec_count_free, NULL);
>>>> +    g_hash_table_destroy(hotblocks);
>>>>    }
>>>>
>>>>    static void plugin_init(void)
>>>> @@ -82,15 +96,9 @@ static void plugin_init(void)
>>>>
>>>>    static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>>>>    {
>>>> -    ExecCount *cnt;
>>>> -    uint64_t hash = (uint64_t) udata;
>>>> -
>>>> -    g_mutex_lock(&lock);
>>>> -    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
>>>> -    /* should always succeed */
>>>> -    g_assert(cnt);
>>>> -    cnt->exec_count++;
>>>> -    g_mutex_unlock(&lock);
>>>> +    ExecCount *cnt = (ExecCount *)udata;
>>>> +    qemu_plugin_u64_add(qemu_plugin_scoreboard_u64(cnt->exec_count),
>>>> +                        cpu_index, 1);
>>>>    }
>>>>
>>>>    /*
>>>> @@ -114,18 +122,20 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>>>            cnt->start_addr = pc;
>>>>            cnt->trans_count = 1;
>>>>            cnt->insns = insns;
>>>> +        cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
>>>>            g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
>>>>        }
>>>>
>>>>        g_mutex_unlock(&lock);
>>>>
>>>>        if (do_inline) {
>>>> -        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
>>>> -                                                 &cnt->exec_count, 1);
>>>> +        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>>> +            tb, QEMU_PLUGIN_INLINE_ADD_U64,
>>>> +            qemu_plugin_scoreboard_u64(cnt->exec_count), 1);
>>>>        } else {
>>>>            qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
>>>>                                                 QEMU_PLUGIN_CB_NO_REGS,
>>>> -                                             (void *)hash);
>>>> +                                             (void *)cnt);
>>>>        }
>>>>    }
>>>>
>>>> --
>>>> 2.43.0
>>>>
>>>>
>>>
> 

