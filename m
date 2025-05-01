Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14C2C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 12:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uATO0-0005OM-Bc; Thu, 01 May 2025 08:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uATNy-0005OC-Ik
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:51:30 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uATNv-000781-AY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:51:29 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-86192b6946eso24976339f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746103885; x=1746708685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cGQ6/50Xx9pmjDWyFm3RYYeAnAV6BumPYHp2rdjxp70=;
 b=huDlDP/qsNoF62RF/psxX0mtwVILo3wXriQ6UGzPDITWhY4V2gEJt+W5mCEh8hcis2
 BgLs9QmOcxEidyxSwl41sXHVoGJLid62gBIiIQKzWx2joHm605GZZOA0vL3d9bg6V5Ho
 S8rpUluiIZb/bfya7VlUtYs7EdUMJqhVgLqZ2o4r0QUMz00nDaglAQ/gQYm72sJ1olZ8
 OLVwRggvMXMhX7BEykp9GABbhP4reJJ/x1WIMo86CTCOXjmZe9QYjIBijDYMzSq+tEiK
 aIkAi6yh1ZjYoWLjnPVDmy60cSRakh2T6rNBx89xozfr03tzLOlQEqZsI628jGXEPks6
 1ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746103885; x=1746708685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cGQ6/50Xx9pmjDWyFm3RYYeAnAV6BumPYHp2rdjxp70=;
 b=Su7Ky1o7Ovvs38+dRP8c/c5glyp0ph/Y6lVSRwsn3l4YOJoW3Erj33A7GDkQcFil1a
 AMtn6wYDq2fmJeXybzy1JUkM7veYFm3vzeX6peM8NQuTYVsfGwk/duol1IJMB/jq0Epx
 ot6/nr4zYG5O+Bv/1godurfuUHPNmSszV8IEkeVhWOqVn1pT6ylplu+aFHUHmRjs8aap
 qn64PE70fOQmyEOAoNzffZYjkyqATBKbEHJvqjDUZgHk0QRyumq0rGbTaP2tCoDkTfGE
 q55gWMgbErmKLIvxsjL8lwylqGkD4UpffGgtdpDKJdE5Yu31RrSUghRGdYR4LW2EMxRQ
 gZFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwQIe2Oa13/7d53lnVYUnH4RsSaClVM7WT3CZ+r5fBW8Khlcc8bcws5QR4+Q7prwrKN62T6dyxI7vF@nongnu.org
X-Gm-Message-State: AOJu0YwBj20OuDCu5tzwzMBuKikgqccnphBSQgR+iYlpkRjTIMwxg56X
 axhzgBoT9w9oj9Un3wPs8E1JuQszo7kvb7I5ZR6dD9P8m3kjStE/DUm9ZZAIBgU=
X-Gm-Gg: ASbGncucL6gonxNjYhBqyLtwUChReJugVwSP8z8JBRDbkEII1Fl4KTjhpaevO3xZczk
 SL+WvAwdLyjdTLMNRAYQ7f2Q3PyjaupJbTzPwocDRMVuHYb8SecpgBupScDSJDRlayuY6MEXvSb
 00ektDlXpgImGssb/gkyRN89oZvBow4KhYLn2CaOHMC8Hxf1D8+pjBrx3dLtbZw3hu1t058VQJt
 Ov0hkW72LQEZRT0bqTnoFD83bdNiC4XQEdkK0K4J+dtPjmoEAJEQiyw9kgjF2k50JknyhBgbgPN
 /yYBmxa0C+lyyV1QGbY6v3ntvukTV8JjlCSYL3AWm4wCFXwS3+rQnLfTM4HLIpC5iVWT8OTwHb3
 pIbC2iYox
X-Google-Smtp-Source: AGHT+IHeM8wDG1UgsPqLQcM4/lsLeEFCKmopDyNX27jw6eAUXlUdE6hpzWA/aFXV0lZbRgWPH4S6Dw==
X-Received: by 2002:a05:6602:4182:b0:85b:45c4:571e with SMTP id
 ca18e2360f4ac-864a228db8emr359083439f.9.1746103885574; 
 Thu, 01 May 2025 05:51:25 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882eaed51sm147915173.10.2025.05.01.05.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 05:51:25 -0700 (PDT)
Message-ID: <1d99561f-044a-4242-80ed-819b955d785d@linaro.org>
Date: Thu, 1 May 2025 14:51:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] system: optimizing info mtree printing for monitors
To: David Hildenbrand <david@redhat.com>, Chao Liu <lc00631@tecorigin.com>,
 pbonzini@redhat.com, peterx@redhat.com
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, qemu-devel@nongnu.org
References: <cover.1746003314.git.lc00631@tecorigin.com>
 <6b3567672da9d5778c18a32ee1306aaed884463c.1746003314.git.lc00631@tecorigin.com>
 <15227d0a-c459-4bea-bec7-13dc88d22c3c@linaro.org>
 <f5f540a2-a6d6-47fd-9b7c-8fd4a4927684@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f5f540a2-a6d6-47fd-9b7c-8fd4a4927684@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2f.google.com
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

On 30/4/25 23:38, David Hildenbrand wrote:
> On 30.04.25 11:58, Philippe Mathieu-Daudé wrote:
>> Hi Chao,
>>
>> On 30/4/25 11:02, Chao Liu wrote:
>>> Make the hierarchical relationship between nodes clearer by adding 
>>> characters
>>
>> W.r.t. $Subject, it isn't really about "optimization" but making
>> output clearer, as you describe.
>>
>>>
>>> e.g.
>>>
>>> qemu-system-riscv64 -M virt -monitor stdio -display none
>>>
>>> ```
>>> (qemu) info mtree
>>> ...
>>> memory-region: system
>>> │  ├── 0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>> │  │   ├── 0000000003000000-000000000300ffff (prio 0, i/o): 
>>> gpex_ioport_window
>>> │  │   │   └── 0000000003000000-000000000300ffff (prio 0, i/o): 
>>> gpex_ioport
>>> ...
>>> │  │   └── 0000000400000000-00000007ffffffff (prio 0, i/o): alias ...
>>> ```
>>>
>>> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
>>> Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
>>> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
>>> ---
>>>    system/memory.c | 36 ++++++++++++++++++++++++++++++------
>>>    1 file changed, 30 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/system/memory.c b/system/memory.c
>>> index 71434e7ad0..cf91718bcc 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -3296,6 +3296,21 @@ typedef QTAILQ_HEAD(, MemoryRegionList) 
>>> MemoryRegionListHead;
>>>                               int128_sub((size), int128_one())) : 0)
>>>    #define MTREE_INDENT "  "
>>> +enum mtree_node_type {
>>> +    MTREE_NODE_T_INNER,
>>> +    MTREE_NODE_T_TAIL,
>>> +};
>>> +
>>> +static void mtree_print_node(enum mtree_node_type is_tail)
>>
>> Either rename 'is_tail' as 'node_type', or really use a boolean
>> (maybe '[is_]last_node' is clearer?), since the mtree_node_type enum
>> doesn't bring much (see [*] below).
>>
> 
> Note that I suggested that, because the passing or true/false in the 
> code is horrible for readability.

Oh good point. Sorry I missed previous version reviews.


