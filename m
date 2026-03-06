Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89592F01828
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTJn-0006rO-QM; Fri, 06 Mar 2026 06:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vyTJi-0006pg-Bx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:26:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vyTJg-00006W-LI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772796359;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYlEUlW/q2KCNVBJcYkE4AnArRDazI/bQcyRoVFTtRg=;
 b=QXdPIdjh04aLzLBD8L0BI9FA31cMFqHGZQN0X+Dme4Ineg3QEZQth65aY6o5nm37LM7K7j
 moaP4d4nkHYi6VCNudA/rkUZ5ZCdc3AiIu28bOlexWBR9yPLeP4r8Oez5D3AezGxK9NGKD
 7Y5pjQTo8XBZTmpIh8JWDMCt4GFheb4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-2AfBOf9JP4-px1JZMc29Lg-1; Fri, 06 Mar 2026 06:25:56 -0500
X-MC-Unique: 2AfBOf9JP4-px1JZMc29Lg-1
X-Mimecast-MFC-AGG-ID: 2AfBOf9JP4-px1JZMc29Lg_1772796355
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48071615686so78143875e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 03:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772796355; x=1773401155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYlEUlW/q2KCNVBJcYkE4AnArRDazI/bQcyRoVFTtRg=;
 b=HxyQlUYAX4sBF3HEpwssIY/Zbu51Ccy4E7iGCAdqeExfmmPxVRgu9liiAd0IOMI3ui
 HvKaPx4YS+u5Vq2L0jaDCMwlkSpMAz8DNUcdim2chlx8rKDby9JiKLxd9U+ypdSWqWxl
 j8peL91fdtfZ9DEvoMqocjiV2+h5aaEMjoce4R9iQvINUIWzw36db/3yLrYnJLFrzICe
 moXYv6JJ1/Xb4jdtt0TLDssMppgYWwA+aIK2zQKV86c5w3gKDl0q6X3RNRVDfq4CiL7Y
 Kjzv8pnOsk226giKDTOLB+E6Nlinb9nrM9J1MzTFLmucF65JpBKunzpIpYHXezylvuO0
 gaTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaGhcfWwh6SHRLq1Oklb44QqyXAJoXS2v1WDuzsn9vXJwAiuIhtHb5qTO3wHFtLeOaSWoHz+bo70FD@nongnu.org
X-Gm-Message-State: AOJu0YyISlPSdIZzZCycqT6ijkTdj5/X1rcNU56heivNJnjoAJMg5cLe
 Xs7M2jLEOUe7tx7IPO1NbtFqXfPMPxY986TEQ0rV6uyWLk4Sju+CY0CEoW0kpB95vO46XVsKiqA
 uQPAmL2iXawCITedAjMzNSTa4y3zAB4sC+JcPt2Yzti5PF6NkWglGkFfa
X-Gm-Gg: ATEYQzws2I4WweCzT5e781CcLnDyc1qR6uxVg3y5lO6f3/bPw7HRP1NfQhE8KIWFAAP
 4AhtrlRrcDPwRr36fy+LCOg1Gb8gPEAl1hQfmgJ7D3GboT98hAGYAEVht7dTeZQZASCTghErxey
 irfBWOPd6PhBd5Q2ImSLBsjgfpaTgZM+C61dQXzgRfvDJVJJQzzxDV0kImW83T7Yg+5Xu/4BagO
 /a+WmopgdUwEhHmYUy232BjtNDQaHO9/U5kso6j/UTAfNufoWEO7XdZj4GczJySDQBZP5nfvlZS
 C5lOsSP6vKIWE1rIdV3mHYRv3z9r5Jg8b+9YpBMnwZc4a5EX+j5ZcPFRrL9cjXvpBVGlyvp1GKA
 6v89JXuXjYVIr3C6Bp7s7mLdXZHumVgjCYFgrWmn09NOHZhjxaS7JK/pnxcPzjTKFvWivOg==
X-Received: by 2002:a05:600c:4752:b0:483:b505:9db7 with SMTP id
 5b1f17b1804b1-48526976a4cmr23374665e9.32.1772796355139; 
 Fri, 06 Mar 2026 03:25:55 -0800 (PST)
X-Received: by 2002:a05:600c:4752:b0:483:b505:9db7 with SMTP id
 5b1f17b1804b1-48526976a4cmr23374265e9.32.1772796354659; 
 Fri, 06 Mar 2026 03:25:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb4257csm174314465e9.15.2026.03.06.03.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 03:25:54 -0800 (PST)
Message-ID: <69272bc3-e4da-48f1-a160-18a386fefd99@redhat.com>
Date: Fri, 6 Mar 2026 12:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] target/arm/machine: Take account cpreg mig
 tolerances in case of mismatch
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, peterx@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20260304102249.1963784-1-eric.auger@redhat.com>
 <20260304102249.1963784-3-eric.auger@redhat.com>
 <5ddefbe2-3514-fda2-a933-e2df46b4db89@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5ddefbe2-3514-fda2-a933-e2df46b4db89@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/6/26 11:51 AM, Sebastian Ott wrote:
> On Wed, 4 Mar 2026, Eric Auger wrote:
>> If there is a mismatch between the cpreg indexes found on both ends,
>> check whether a tolerance was registered for the given kvmidx. If any,
>> silence warning/errors.
>>
>> Create dedicated helper functions that print the name of the culprit reg
>> and analyze whether a tolerance is set. According set the level of
>> traces
>> and analyze whether the migration must eventually fail.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> target/arm/machine.c    | 30 ++++++++++++++++++++----------
>> target/arm/trace-events |  2 ++
>> 2 files changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/arm/machine.c b/target/arm/machine.c
>> index 476dad00ee7..13b8a0b2220 100644
>> --- a/target/arm/machine.c
>> +++ b/target/arm/machine.c
>> @@ -1065,24 +1065,34 @@ static void
>> handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
>> {
>>     g_autofree gchar *name = print_register_name(kvmidx);
>>
>> -    warn_report("%s: %s "
>> -                "expected by the destination but not in the incoming
>> stream: "
>> -                 "skip it", __func__, name);
>> +    if (!arm_cpu_cpreg_has_mig_tolerance(cpu, kvmidx,
>> +                                         0, 0,
>> ToleranceNotOnBothEnds)) {
>
> I don't get this. You apply a different tolerance type than the one
> (potentially) registered. This check will only fail when there was no
> tolerance registered for this kvmidx. But this can be changed by someone
> registering a different type. 

Note at the moment, only one tolerance can be registered for a kvmidx

Eric
>
>> +        warn_report("%s: %s "
>> +                    "expected by the destination but not in the
>> incoming stream: "
>> +                     "skip it", __func__, name);
>> +    } else {
>> +        trace_tolerate_cpreg_missing_in_incoming_stream(name);
>> +    }
>> }
>>
>> /*
>> - * Handle the situation where @kvmidx is in the incoming stream
>> - * but not on destination. This currently fails the migration but
>> - * we plan to accomodate some exceptions, hence the boolean returned
>> value.
>> + * Handle the situation where @kvmidx is in the incoming
>> + * stream but not on destination. This fails the migration if
>> + * no cpreg mig tolerance is set for this @kvmidx
>>  */
>> static bool handle_cpreg_only_in_incoming_stream(ARMCPU *cpu,
>> uint64_t kvmidx)
>> {
>>     g_autofree gchar *name = print_register_name(kvmidx);
>> -    bool fail = true;
>> -
>> -    error_report("%s: %s in the incoming stream but unknown on the "
>> -                 "destination: fail migration", __func__, name);
>> +    bool fail = false;
>>
>> +    if (!arm_cpu_cpreg_has_mig_tolerance(cpu, kvmidx,
>> +                                        0, 0,
>> ToleranceNotOnBothEnds)) {
>> +        error_report("%s: %s in the incoming stream but unknown on
>> the "
>> +                     "destination: fail migration", __func__, name);
>> +        fail = true;
>> +    } else {
>> +        trace_tolerate_cpreg_only_in_incoming_stream(name);
>> +    }
>>     return fail;
>> }
>>
>> diff --git a/target/arm/trace-events b/target/arm/trace-events
>> index 2de0406f784..8502fb3265c 100644
>> --- a/target/arm/trace-events
>> +++ b/target/arm/trace-events
>> @@ -29,3 +29,5 @@ arm_psci_call(uint64_t x0, uint64_t x1, uint64_t
>> x2, uint64_t x3, uint32_t cpuid
>>
>> # machine.c
>> cpu_post_load(uint32_t cpreg_vmstate_array_len, uint32_t
>> cpreg_array_len) "cpreg_vmstate_array_len=%d cpreg_array_len=%d"
>> +tolerate_cpreg_missing_in_incoming_stream(char *name) "%s is missing
>> in incoming stream but this is explicitly tolerated"
>> +tolerate_cpreg_only_in_incoming_stream(char *name) "%s is in
>> incoming stream but not on destination but this is explicitly tolerated"
>> -- 
>> 2.53.0
>>
>>
>


