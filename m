Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE512CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqVqz-0001EC-SC; Mon, 25 Aug 2025 07:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqVqx-0001DN-AG
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqVqm-0008ES-2W
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756123136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CW2h082mlOG6IjOMPrhkXMfKjuO/mMnKtKOIhJZMvIk=;
 b=buUW+mDpzUxRBVHao4wY6QEYsoi2YMTN5l59x8xhw8jqAussMQU11OMgOJM3JOmc1ikAnO
 OHuZALu6uasHjpNJWIpDQEbqCb2RwtOU2TYbXTZLZ2EOfDiYGA2k0Az1FWvzJpGui0wUub
 mvLXRBJSTll1vGJd+QxTyHPTgInpsNA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-qfZaU8pEOy-XfisYoTwfEw-1; Mon, 25 Aug 2025 07:58:49 -0400
X-MC-Unique: qfZaU8pEOy-XfisYoTwfEw-1
X-Mimecast-MFC-AGG-ID: qfZaU8pEOy-XfisYoTwfEw_1756123128
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b109bf1f37so94872951cf.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756123128; x=1756727928;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CW2h082mlOG6IjOMPrhkXMfKjuO/mMnKtKOIhJZMvIk=;
 b=QsQqY8dYEuRYFDf0+t5tC+XvInzqka6NDvBymkXGxyi8yi5jaT43KPO1gKlfJrxO5h
 kG/98iGvqKSveNZ1BIXwdW/DZb/uB02bUNr8ylrXK5nXNEYDgehNRIw+Lc016SIiNmAt
 7E5VkHgf6dL33et/JCpUm0lLFzqjaTFnSdXmtLkdZX/G02zNohMbiPZQwzr8SEB1zAq1
 VTn82kmRGN4f5aiMLEsf2WUzMiVFL+lQ6iuVyvOi4EgY02h/ydL3hH4Si4d98afnEB6k
 yDaeMZCu5taf6BD90zJ3UUA6QFGDKaUqhuDr4vktReXNxdncPzSx/rjgnBhTY9D61ma/
 kyUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5rQg2hPjBznrPmxIYajuvCT29sJb8km/5U/7A03utPvGatIkoBg8EgE26D9oZfiVh/xE25njIfe5F@nongnu.org
X-Gm-Message-State: AOJu0YzmxaSY6jO9bvn1Rheifh1RicUkt6MJrOs6lcV8PupKLmNbxToE
 1iFO2Asxc067JIKVHDQdc8NBK9TykL2FF4wSJPYtbKAFJdo347cdYsp+G6lqmflVf/ppOuzYU6/
 l75JtOhXM2SLpDShl/rhpCnKPhZ2IjoeHhG9URxS9+8pnJa72K7Ms0VJO
X-Gm-Gg: ASbGncvIgMofVY3tXLabiGwpGBvYntDSzK8Lh15iqBtikiHgtgK6RSA/1cRtvR4fPbZ
 LrU3sFzzhhs7gn/WSYTfhzzia5mdtCTFzbNfczleLJ0TBrhNFAnOtPFKU7vbKMf4v+ASto6e8J/
 MKtIY6AA1quwl9GwlJkquW909KKx2gAmIiQHyCP22wpI/2rejmDf6PLv23Rr/uvVA3ZF9QchAZ0
 MqfmWxSm+37F53i6L+122WUCdgyMeHzltHvmleHHAQh/VFpdEhYJyAOVuNYe9jsUIThqKbR+b+h
 LiUixvN40oU9y9MpL+nHwRGjb+I0FCB2hUKZgUwMvmSKiKDug2J2jC9KdgEPnWDq9aLHwRSfVpa
 kKH4=
X-Received: by 2002:ac8:7dc2:0:b0:4b0:83f7:b45d with SMTP id
 d75a77b69052e-4b2aaa0327bmr122766691cf.7.1756123128358; 
 Mon, 25 Aug 2025 04:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXqffB6MU/DQznfcq6llO5yNp2HNkRmN4chdfcYZHQVFeDEhUA0ZEZu3TsabjjVJIFNJmSGA==
X-Received: by 2002:ac8:7dc2:0:b0:4b0:83f7:b45d with SMTP id
 d75a77b69052e-4b2aaa0327bmr122766291cf.7.1756123127726; 
 Mon, 25 Aug 2025 04:58:47 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-084.pools.arcor-ip.net.
 [47.64.112.84]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b2b8c885e4sm51227731cf.13.2025.08.25.04.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 04:58:47 -0700 (PDT)
Message-ID: <dc6dc7db-f4c3-4641-9707-383737e2b678@redhat.com>
Date: Mon, 25 Aug 2025 13:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Add IBM PPE42 family of processors
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-2-milesg@linux.ibm.com>
 <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
 <c13f63a6-5fef-42f2-89fe-946f71498f51@redhat.com>
 <fd855a38-976f-430e-9db1-1bdce1cf869d@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <fd855a38-976f-430e-9db1-1bdce1cf869d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 25/08/2025 13.46, Harsh Prateek Bora wrote:
> Hi Thomas,
> 
> On 8/25/25 17:04, Thomas Huth wrote:
>> On 25/08/2025 13.24, Harsh Prateek Bora wrote:
>>> Hi Glenn,
>>>
>>> This seems significant work. Thanks for upstreaming.
>>>
>>> On 8/20/25 02:58, Glenn Miles wrote:
>>>> Adds the IBM PPE42 family of processors supporting the
>>>
>>> family of 32-bit processors ?
>>>
>>>> PPE42, PPE42X and PPE42XM processor versions.  These
>>>> processors are used as embedded processors in the IBM
>>>> Power9, Power10 and Power12 processors for various
>>>> tasks.  It is basically a stripped down version of the
>>>> IBM PowerPC 405 processor, with some added instructions
>>>> for handling 64-bit loads and stores.
>>>>
>>>> For more information on the PPE 42 processor please visit:
>>>>
>>>> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>>>>
>>>> Supports PPE42 SPR's (Including the MSR) and  Exceptions.
>>>>
>>>> Does not yet support new PPE42 instructions and does not
>>>> prevent access to some invalid instructions and registers
>>>> (currently allows for access to invalid GPR's and CR fields).
>>>>
>>>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>>>> ---
>>>>   target/ppc/cpu-models.c      |   7 +
>>>>   target/ppc/cpu-models.h      |   4 +
>>>>   target/ppc/cpu.h             |  66 +++++++-
>>>>   target/ppc/cpu_init.c        | 286 ++++++++++++++++++++++++++++++-----
>>>>   target/ppc/excp_helper.c     | 171 +++++++++++++++++++++
>>>>   target/ppc/helper_regs.c     |  28 +++-
>>>>   target/ppc/tcg-excp_helper.c |  12 ++
>>>>   target/ppc/translate.c       |   6 +-
>>>>   8 files changed, 535 insertions(+), 45 deletions(-)
>>>>
>>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>>>> index ea86ea202a..09f73e23a8 100644
>>>> --- a/target/ppc/cpu-models.c
>>>> +++ b/target/ppc/cpu-models.c
>>>> @@ -116,6 +116,13 @@
>>>>                   NULL)
>>>>       POWERPC_DEF("x2vp20", CPU_POWERPC_X2VP20,                 405,
>>>>                   NULL)
>>>> +    /* PPE42 Embedded 
>>>> Controllers                                            */
>>>> +    POWERPC_DEF("PPE42",         CPU_POWERPC_PPE42, ppe42,
>>>> +                "Generic PPE 42")
>>>> +    POWERPC_DEF("PPE42X",        CPU_POWERPC_PPE42X, ppe42x,
>>>> +                "Generic PPE 42X")
>>>> +    POWERPC_DEF("PPE42XM",       CPU_POWERPC_PPE42XM, ppe42xm,
>>>> +                "Generic PPE 42XM")
>>>
>>> Can all the PPE42 specific code be conditionally compiled only for
>>> !TARGET_PPC64 (and !CONFIG_USER_ONLY wherever possible)?
>>> Not only to reduce the bloating size of respective binaries, but also to
>>> avoid some code being added to hot path routines like 
>>> hreg_compute_hflags_value().
>>
>> qemu-system-ppc64 is a superset of qemu-system-ppc, and there are even 
>> efforts to unify all system functionality into a singly binary, so 
>> excluding a 32-bit feature from qemu-system-ppc64 sounds like a step into 
>> the wrong direction to me right now...?
> 
> We do have existing code getting conditionally compiled for TARGET_PPC64
> which I guess gets enabled with:
>   --configure target-list=<ppc64|ppc>-softmmu
> I understand the efforts are towards having a single binary to support
> both, but what gets built-in is still decided with configure choice?
> 
> Please correct/clarify with above understanding.

As I said, qemu-system-ppc64 is currently a full superset of 
qemu-system-ppc. The ppc64 binary contains all the 32-bit code, you can 
perfectly run a "g3beige" or "bamboo" machine with qemu-system-ppc64, too. 
By disabling the ppe42 code in the ppc64 binary, this would now introduce an 
execption to that unwritten rule, so I'd expect that we'd not rather want to 
do this now.

  Thomas


