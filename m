Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CE9CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 04:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAhRS-0002ei-9t; Mon, 20 Oct 2025 00:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAhRQ-0002eO-Jy
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 00:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAhRO-0008E0-Gw
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 00:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760934251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JlbeOKJA9ekSEIyb9m7z7OtU+jEv17RQeHu/JWzq72g=;
 b=dqQV3B5xDgoRJ6FX/d0qLhhqVPnoWTtxYT7I9S7wJwmsarzpz//EkIpjYj8ZQJbtnvuCWg
 hcZTH4DkxIQ/GwQemkQ0xDPtlHmZZ/BqBQX0xhautv8BE1FDSoVwMFekhD80uYAtnsMHn4
 VrvySk3BjmWAa9DG5HdiTcWA14lRaSM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-72443fYQNzqSixUSWFfe7A-1; Mon, 20 Oct 2025 00:24:09 -0400
X-MC-Unique: 72443fYQNzqSixUSWFfe7A-1
X-Mimecast-MFC-AGG-ID: 72443fYQNzqSixUSWFfe7A_1760934248
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b56f1c14b71so57684466b.2
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 21:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760934248; x=1761539048;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlbeOKJA9ekSEIyb9m7z7OtU+jEv17RQeHu/JWzq72g=;
 b=LPP1B3iOhGPmOUGOoULqsfnpI/K0zpbaKzkz2bgJ0vwazIQmIA+F9XxlTlNhTZs/Wl
 foSWTLoIGphtdznwURFSw8T+bT5EV9wnJqYbRHd9SwgZYF9pGMBUF4FI648LZmdsidV+
 cJkuF+hs84AebhddT3TFdU2TNEl/7YkTjFAeiy+GaLa17cD+Zr4TEPel1RA3iE/qDkkW
 MJO504dETNAa5ad3/k7z2L/48WmUtfTcF3cLn5BodES/Fhi4v2XMM/dy001/1A9/ho4I
 TMZD+srSfVgx2hslOGcW1eb861d1Rjh/+4J6DRM0bcLpJ0H1fN361Oi+fm+I1ldnkO9G
 L1OA==
X-Gm-Message-State: AOJu0Yz4+sfVhDuiPSs/Tk2ahmizefTX5pQSVQoHLpKEvFnri+0BDOxa
 npf7RAUs2xCxhuZuM9NQ3hMbcR5lIPxxFs2SP+HFBzRnE924bTfaI+qRHDVW7L3lRZj4nSqtj2r
 xED+2Qsd3Xa+RNIqiXJZ/eO8cAPAwJuy9ATqJZQPZYv4u/8BJwCPekF/t
X-Gm-Gg: ASbGncuamMQ1bcgFFFrODC6gG5sXjcaQYdlW79sdAn5Dzc4pNl15jsn3D8h/93FCrBc
 M1QCTBsoACPZfh1htgWvNK9AbBOT/RcSnT08nOiat/bz7r+X7hAGKtDS3xtYbGOJaaM1hfEyQx+
 3u7qsYALnMGZhWI6zr6k0vFcK7Y+SS3u1IYnFOjSAyJHNjOcBEHlD7lXvBNBAzQ+IBruEIYjArG
 moDbr4dX0DxPQgOeFOfhpeyULzGXijzYKh1Izx6KDm169MVJ7JGoaGKGu7avGu9rC0eolLYJD/Z
 pRs1rmt3PLVEkccCLMM2GtUuXg5mIYVntxRZFobvAUKIyXeCderjyV+6m9fA8OeqjtK/JMgFqa1
 Ssftx8a3S12wPzImMGkNT+SnFh2nbK33lwoCsfc8b
X-Received: by 2002:a17:906:fe45:b0:b60:d888:32d9 with SMTP id
 a640c23a62f3a-b6471d45a8cmr1369405866b.11.1760934248324; 
 Sun, 19 Oct 2025 21:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpqj/7X1o9f85t64y+IM/s7GWMba5i7Ei3f2dCsUnxphknRGVA5+fo4G4H4kIDI+tClCGA3A==
X-Received: by 2002:a17:906:fe45:b0:b60:d888:32d9 with SMTP id
 a640c23a62f3a-b6471d45a8cmr1369403466b.11.1760934247922; 
 Sun, 19 Oct 2025 21:24:07 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65e7e984f2sm671390566b.13.2025.10.19.21.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 21:24:07 -0700 (PDT)
Message-ID: <f928e02c-064d-4b1c-aaa7-9b9160e83c11@redhat.com>
Date: Mon, 20 Oct 2025 06:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Remove the unusable e200 CPUs
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20251017144504.563594-1-thuth@redhat.com>
 <295be472-7778-49f7-9ede-e5ef51dd908e@linux.ibm.com>
 <3c2d1838-0fc9-46e3-a6b4-382ecc4d4ff8@kaod.org>
 <a69c0e62-1cfa-474d-abe1-151df0caf234@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a69c0e62-1cfa-474d-abe1-151df0caf234@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/10/2025 08.07, Harsh Prateek Bora wrote:
> 
> 
> On 10/18/25 11:31, Cédric Le Goater wrote:
>> On 10/17/25 17:50, Harsh Prateek Bora wrote:
>>>
>>>
>>> On 10/17/25 20:15, Thomas Huth wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> There is currently no machine in QEMU (except the "none" machine)
>>>> that can be run with one of the e200 ppc CPUs - all machines either
>>>> complain about an invalid CPU type or crash QEMU immediatly.
>>>>
>>>> Looking at the history of this CPU type, it seems like it has never
>>>> been used in QEMU and only implemented as a placeholder (see e.g. the
>>>> comment about unimplemented instructions in the POWERPC_FAMILY(e200)
>>>> section of cpu_init.c). Being completely unused and unusable since
>>>> such a long time, let's just remove it now.
>>>>
>>>> Note: The init_excp_e200() is used by the e500 CPUs, too, so we
>>>> rename this function to init_excp_e500() instead of removing it.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   target/ppc/cpu-models.h |   4 --
>>>>   target/ppc/cpu-models.c |   5 --
>>>>   target/ppc/cpu_init.c   | 147 +---------------------------------------
>>>>   3 files changed, 2 insertions(+), 154 deletions(-)
>>>>
>>>> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
>>>> index c6cd27f390e..a439eb37ee4 100644
>>>> --- a/target/ppc/cpu-models.h
>>>> +++ b/target/ppc/cpu-models.h
>>>> @@ -120,10 +120,6 @@ enum {
>>>>   #define CPU_POWERPC_MPC5200_v12      CPU_POWERPC_G2LEgp1
>>>>   #define CPU_POWERPC_MPC5200B_v20     CPU_POWERPC_G2LEgp1
>>>>   #define CPU_POWERPC_MPC5200B_v21     CPU_POWERPC_G2LEgp1
>>>> -    /* e200 family */
>>>> -    /* e200 cores */
>>>> -    CPU_POWERPC_e200z5             = 0x81000000,
>>>> -    CPU_POWERPC_e200z6             = 0x81120000,
>>>>       /* e300 family */
>>>>       /* e300 cores */
>>>>       CPU_POWERPC_e300c1             = 0x00830010,
>>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>>>> index 89ae763c7f6..26b6debcfc9 100644
>>>> --- a/target/ppc/cpu-models.c
>>>> +++ b/target/ppc/cpu-models.c
>>>> @@ -244,11 +244,6 @@
>>>>                       CPU_POWERPC_MPC5200B_v20, POWERPC_SVR_5200B_v20, 
>>>> G2LE)
>>>>       POWERPC_DEF_SVR("mpc5200b_v21", "MPC5200B v2.1",
>>>>                       CPU_POWERPC_MPC5200B_v21, POWERPC_SVR_5200B_v21, 
>>>> G2LE)
>>>> -    /* e200 
>>>> family                                                           */
>>>> -    POWERPC_DEF("e200z5",        CPU_POWERPC_e200z5, e200,
>>>> -                "PowerPC e200z5 core")
>>>> -    POWERPC_DEF("e200z6",        CPU_POWERPC_e200z6, e200,
>>>> -                "PowerPC e200z6 core")
>>>
>>> While I hope removal of e200 should be fine, I am thinking if we want to
>>> deprecate it in this cycle and remove it in next ?
>>
>> Since it was never usable (I don't remember of any tests for these
>> CPUs), I agree with Thomas to bypass the deprecation process.

Yes, that's what I was thinking, too: If nobody could have ever used it, 
there's no point in marking it as deprecated first.

> Sure, reasonable.
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Thanks!

  Thomas


