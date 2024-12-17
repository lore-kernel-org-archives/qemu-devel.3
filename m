Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6B9E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 21:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNf9f-00021p-Gd; Tue, 17 Dec 2024 16:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNf9e-00021c-Dj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:30:58 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNf9a-0004ua-RN
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:30:58 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21631789fcdso737455ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734471051; x=1735075851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xh3vsa+mVkkBICrwQgkLWWLVAlIeMypOHB9EJuk89+M=;
 b=PpdexZOt6lSeoBzOqPd9pP281rT9pSO3wwM9pMPadV34Le36TcJkYfb+7wGQ9XgqdV
 2YrW9vpxFKPeu4crRjPZKHjYi/x6QzOP9+poVI6/HVjFqaSd2+toevj/aJlOtP60FskK
 tNQXqK64X3awmH8IJKVYXnFaOjoIuIXvAMin6PO8OhZuqJCOXytrbu1/oC1aXYpn3HKK
 DxmtK4R+AJgYytCPzGZPbFKd6/16Jw62Ncsz57MkV2o8xM7vs/SYlufbeq6vX/+EnfEl
 SL40tRVT29pF3RqZoaTfROx3iUBsHWgAMjrWzGnzQTyJE+HoUvoWNvMHCAQojH4++8bQ
 9PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734471051; x=1735075851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xh3vsa+mVkkBICrwQgkLWWLVAlIeMypOHB9EJuk89+M=;
 b=ohYtim+IJMzuhytVnxi7JOYxiE4MS3+ZddSSpFAEqpm8if3p02pECbzr2RQ4haAUBU
 QR9gSXIPmq5D4I/b7Ae//lEKHlx0WooVy1sATO4NK4kytxwYdGMNYkTUIqZCKVG/wvnO
 qKMTk9NRk7++90sVwUjCadPPiYCk/w1ZyD8Y6B0g7cdtKCMf669CxipQn5sHgdp3dqz/
 OF9gSYGZhd5iBnkA62rItAZ4XpMu9gJe9PVrV/l35+nxzxWYb9Uu7tw2UEvd6Eyd33Q2
 qt35XQJcf6uDf4RlnOGioBKaC9vQzUNsCPTM0SlnApR0vPefHRPHIp3LygMmqzlb+v6z
 Ka9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSsxppUxFby4PKKHKotwsAvoPO1+FpPqRA4R3Q2wOQ/0+AROF27xomYCiYGmk/PlAAgKCMBbEXqPrX@nongnu.org
X-Gm-Message-State: AOJu0YxXA78cwfB8/YpCWY9TYdhTvNBLd7KDL0aCpV6Pie6eAKMdUB28
 RUBMbBK4kt0Pa5xwY/cTcYw8pJqbx304c1R8HfcuImHhiqpCZHPop9IdOXPAILs=
X-Gm-Gg: ASbGncvJH3xldGfFJjg9gQxZ1aB/i+Jzz/QsEf38a2f/9ehGmj+X5ADW/kfGCo64Lsk
 0Syglcqa+dt3uGbwi1nQXACBeE637NiXmWAchnCpxnIXP1tYS9R//iRwFZHb7hoIUhrW7m8z6Rx
 77NYD7uXuv5BQF2hDxuJVxmLo+R0q/9BEUohgIegDFSxL5nlLoirEZU6XPhR/aSEWWLp173gTI1
 Wv1TrZh93cpLPTUJVaHpv4euV/bQbRYmvkiH0b3ffXPhGFfqVwMr3y5tAS4jTb29GPwlQ==
X-Google-Smtp-Source: AGHT+IEktHoBM9sjyz8ivoxQU5b+W5z79oalpeYeOfQxnUJAV68gWUVo9frWnaGv+emxCjVptafJfw==
X-Received: by 2002:a17:903:946:b0:215:2d2c:dd0c with SMTP id
 d9443c01a7336-218c9216b43mr84574075ad.14.1734471051461; 
 Tue, 17 Dec 2024 13:30:51 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6578fsm64190915ad.248.2024.12.17.13.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 13:30:51 -0800 (PST)
Message-ID: <07675f0a-f398-4caf-8824-aebb733fa63c@linaro.org>
Date: Tue, 17 Dec 2024 13:30:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] contrib/plugins/hotblocks: fix 32-bit build
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-10-pierrick.bouvier@linaro.org>
 <a1a38b2f-fd2f-4e02-8e12-e9acdf852864@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a1a38b2f-fd2f-4e02-8e12-e9acdf852864@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/17/24 07:34, Richard Henderson wrote:
> On 12/16/24 19:07, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    contrib/plugins/hotblocks.c | 8 +++++---
>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
>> index 02bc5078bdd..09b0932275c 100644
>> --- a/contrib/plugins/hotblocks.c
>> +++ b/contrib/plugins/hotblocks.c
>> @@ -34,6 +34,7 @@ static guint64 limit = 20;
>>     */
>>    typedef struct {
>>        uint64_t start_addr;
>> +    uint64_t hash;
>>        struct qemu_plugin_scoreboard *exec_count;
>>        int trans_count;
>>        unsigned long insns;
>> @@ -91,7 +92,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>>    
>>    static void plugin_init(void)
>>    {
>> -    hotblocks = g_hash_table_new(NULL, g_direct_equal);
>> +    hotblocks = g_hash_table_new(g_int64_hash, g_int64_equal);
>>    }
> 
> I think this one should be using a proper comparison function: compare both pc and insns,
> the inputs to the simplistic hash function:
> 

I will replace the equal function, and the hash one as well, so we don't 
have to store hash in the entry.

>>        uint64_t hash = pc ^ insns;
> 
> An existing bug with the plugin, obviously.
> 
> 
> r~


