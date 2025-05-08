Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBFAC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD7nz-0008WI-3Y; Thu, 08 May 2025 16:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7nv-0008Tj-M9
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:25:15 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7ns-0005nz-Oa
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:25:15 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so1281407b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746735911; x=1747340711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dbs3ICrNU/zk4+ddXd/8djGXG+kqtD2eyXzlHHlUsK8=;
 b=uuBfWGxYTH0nfsvtHS6I7kKQNXqURpEddYI2EKvKaHiFFwcKRj6z+bl7CPyw4P+pei
 AOP2UDgu/ZpJ8GLWTz0aLaN/Lmj8Q8DaMtxwP82URQaii4ng1LvzB7by2jTek5qR32CG
 VPLCIZIzFmdTSfnnITbAGIvy45A6QpQPAyyF4D1M5o2UN1saHupV8GMSAd3sraU3L3zR
 Kmh2010GMgSZ6f0/NKEB7HztEfUVLiZLe9zb5yrydNIBknw0gZ+3e6/6BIwkID6bkXqk
 rl+br5lMtOW4fOvKoXcD1+Ug3EMJU1pxkWFnRrcXIzpYqJe3uPHi/9q3VFY/BScWWqa5
 /qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746735911; x=1747340711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dbs3ICrNU/zk4+ddXd/8djGXG+kqtD2eyXzlHHlUsK8=;
 b=fOcMd0dTcNCVeB7EMYcVyhuE9AdRyI+Rjc4lgKHJ46AA2HTnpTl4cohy0uRFbsmGos
 MuXSZVAgO20lqHrOeVJ5BxIn5wWQTlcM9+YrM2Zu7kAH2d+Ff4Onn2Zw9fXimH5Vb5cX
 4gR/aXDgCj+KxzDGuHo9+Q2+WTqFOgP2u5khn9u2gFn4+/b5hD9dFHIMvXUpHajCGpAB
 p0SFxM/Crx3ojl+dIwsPFu9ajyEmDpjADUokdmEa/p4g6swwNtntBL8VnEKO7GpVQwXm
 zqksgGNEuf/fukiBPjotomug6Q1d9kzCFk86jDsAu78q0R4DBaF+fAjPvTOYwolqq82R
 oV7w==
X-Gm-Message-State: AOJu0YwXy+jK4GDP079/1CcEfjG03M5/mDnJDRB1K9nJRsjlGQvZJXtX
 HIehcSsxBfx4Ygv3OSgUfm1yiqk8iMQl5uCK6EeCk2V00bjv4zB1ZdEVmNzPTDQ=
X-Gm-Gg: ASbGncvJ3JYrnzjSIk9Hi5CLnnjPj489QB/Cl79i1AVhfNU9Gc3+RkMJ6XKAn6VvRn3
 OdC/TTjp9SGcJ06qwDlBRgxxB5NMTHiYIOdbUkm0MKKFIhqCZpm58O0F1nyklSJMmclJxa4KtL6
 k7fUGYvSAzTJzb8fk6OQbXLinJfe8VwcdpYcAvRG8bNvb8vrXArgDPP5FT930Uliqor5tWZlVdX
 f9IdqpNklJMyz4zlXDOFpM5TLQdVj8yfoNEPS8oY3iHMMKjjx1z8WYlcvSG5VLhZ4dGN4WKgIaf
 9KJJGomcBk/UJszsjbkF4Htzjl8InFmWaXEocjQvTn+40kOQKFaH7w==
X-Google-Smtp-Source: AGHT+IHX+QwVPFTBvEkSchrXQf8nWTOFMg3SHCnPBbU+mW2FN9V0XUhjzMTcHKgCe+mVoZDQzGKdvg==
X-Received: by 2002:a05:6a21:3483:b0:1f5:839e:ece8 with SMTP id
 adf61e73a8af0-215abab9c4emr894456637.2.1746735911313; 
 Thu, 08 May 2025 13:25:11 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a386b4sm441879b3a.136.2025.05.08.13.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 13:25:10 -0700 (PDT)
Message-ID: <49dc014b-bfd1-43de-8d0c-c916e178432a@linaro.org>
Date: Thu, 8 May 2025 13:25:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] qobject/qlit: allow to hide dict or list entries
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 richard.henderson@linaro.org, pbonzini@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-4-pierrick.bouvier@linaro.org>
 <aBy94N6JSwDj53mb@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aBy94N6JSwDj53mb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 5/8/25 7:21 AM, Daniel P. Berrangé wrote:
> On Wed, May 07, 2025 at 04:14:33PM -0700, Pierrick Bouvier wrote:
>> We add a new .hidden field to qlit entries, which gets ignored when
>> creating the associated QObject.
>> By default .hidden is 0, so it means the entry is visible. This way,
>> only potentially hidden elements need to be assigned.
> 
> IMHO this feels like a somewhat dubious concept to have in the
> qobject code, as it is quite specialized to a single use case.
> A more general purpose approach would be to have some mechanism
> for cloning while applying a data filter, though I admit that
> may be more tedious to actually use.
>

It's the least worse solution I found, for conditionally defining the 
schema.
Trying to dynamically create the qlit stuff with individual .push() was 
a nightmare in code generator, so I dropped this idea.

>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/qobject/qlit.h | 12 ++++++++++++
>>   qobject/qlit.c         | 10 ++++++++--
>>   2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/qobject/qlit.h b/include/qobject/qlit.h
>> index c0676d5daf2..3b66c22013c 100644
>> --- a/include/qobject/qlit.h
>> +++ b/include/qobject/qlit.h
>> @@ -28,25 +28,37 @@ struct QLitObject {
>>           QLitDictEntry *qdict;
>>           QLitObject *qlist;
>>       } value;
>> +    bool hidden;
>>   };
>>   
>>   struct QLitDictEntry {
>>       const char *key;
>>       QLitObject value;
>> +    bool hidden;
>>   };
>>   
>>   #define QLIT_QNULL \
>>       { .type = QTYPE_QNULL }
>>   #define QLIT_QBOOL(val) \
>>       { .type = QTYPE_QBOOL, .value.qbool = (val) }
>> +#define QLIT_QBOOL_HIDDEN(val, cond) \
>> +    { .type = QTYPE_QBOOL, .value.qbool = (val), .hidden = (cond) }
>>   #define QLIT_QNUM(val) \
>>       { .type = QTYPE_QNUM, .value.qnum = (val) }
>> +#define QLIT_QNUM_HIDDEN(val, cond) \
>> +    { .type = QTYPE_QNUM, .value.qnum = (val), .hidden = (cond) }
>>   #define QLIT_QSTR(val) \
>>       { .type = QTYPE_QSTRING, .value.qstr = (val) }
>> +#define QLIT_QSTR_HIDDEN(val, cond) \
>> +    { .type = QTYPE_QSTRING, .value.qstr = (val), .hidden = (cond) }
>>   #define QLIT_QDICT(val) \
>>       { .type = QTYPE_QDICT, .value.qdict = (val) }
>> +#define QLIT_QDICT_HIDDEN(val, cond) \
>> +    { .type = QTYPE_QDICT, .value.qdict = (val), .hidden = (cond) }
>>   #define QLIT_QLIST(val) \
>>       { .type = QTYPE_QLIST, .value.qlist = (val) }
>> +#define QLIT_QLIST_HIDDEN(val, cond) \
>> +    { .type = QTYPE_QLIST, .value.qlist = (val), .hidden = (cond) }
>>   
>>   bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs);
>>   
>> diff --git a/qobject/qlit.c b/qobject/qlit.c
>> index a44f47eaa57..7b372c5ebaa 100644
>> --- a/qobject/qlit.c
>> +++ b/qobject/qlit.c
>> @@ -90,6 +90,8 @@ bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
>>   
>>   QObject *qobject_from_qlit(const QLitObject *qlit)
>>   {
>> +    g_assert(!qlit->hidden);
>> +
>>       switch (qlit->type) {
>>       case QTYPE_QNULL:
>>           return QOBJECT(qnull());
>> @@ -102,7 +104,9 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
>>           QLitDictEntry *e;
>>   
>>           for (e = qlit->value.qdict; e->key; e++) {
>> -            qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
>> +            if (!e->hidden) {
>> +                qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
>> +            }
>>           }
>>           return QOBJECT(qdict);
>>       }
>> @@ -111,7 +115,9 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
>>           QLitObject *e;
>>   
>>           for (e = qlit->value.qlist; e->type != QTYPE_NONE; e++) {
>> -            qlist_append_obj(qlist, qobject_from_qlit(e));
>> +            if (!e->hidden) {
>> +                qlist_append_obj(qlist, qobject_from_qlit(e));
>> +            }
>>           }
>>           return QOBJECT(qlist);
>>       }
>> -- 
>> 2.47.2
>>
> 
> With regards,
> Daniel


