Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5577BC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 02:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXsim-0006j9-T8; Tue, 14 Jan 2025 21:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tXsik-0006ij-NK
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 21:01:26 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tXsii-0001ez-BN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 21:01:26 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216401de828so102632145ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 18:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1736906481; x=1737511281;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+6a5Rpv/aHVtz5k+1HjY1q/gssY318lQz3OBpZgw3Uw=;
 b=KMj6i0QcAGiavfGN1Z1Mwbkf45kWXdoO5+emg2mzRSjtQkn4j9S+rzvCqnZn6om3tU
 Y/ZiX5tzj9Tst021Zw+3RzPst7S5RTVjBnagx39Np38Z4TQ+0WlCAJt5+knwAl+QEeEA
 Ei5Qin9vR36kJGJkDA4qWIQl9jKJjvkN4JyK9fMEQWIsgqDVcXkhV2vttweNO6oVmINR
 kv3xYr9F3edc2xXFDVu8Dm1X3JjM5pZz04AW2dSb1YYN4Rn0upWV8QSk83sna+jYRI7r
 S16UkrEPtn7v/8l8khee6fiqSxZHOoSvAGDKFk8O5M/SHHwunSPFCLX8oO303FQVV1SZ
 SfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736906481; x=1737511281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+6a5Rpv/aHVtz5k+1HjY1q/gssY318lQz3OBpZgw3Uw=;
 b=TazApokjb8hKIKDtfR+qzx5fBCYJg9wwHQSN7U4xP5HJoPBqbPH/+1FxtIos/e9aK3
 xW4RxvOxDp8OT4Fyo3Oil3YKYlxS7+uiBHeg++k0mg5PtxjR2Lrg1c7CuHeQ7rJRr3Mo
 xT6udwY253oQCqQt7uE8MY7kMcGEsVWoiSGTAh91I8SIu6vAs5bnyteFghDnaKZyzEl4
 ieVPzaqxoEyM3/TboTLf9ii4sjqqIK5F49OwLBhk4B7x8sWp+PLVHRls4nJ1OeqMwTcr
 sh4ZkPM8Mf0kxN8f9dXNe1SWbOVfEQdPclQ4MAYPoHZ4Ul9SUI21XdWeu+PoGUTLV2xO
 K6LQ==
X-Gm-Message-State: AOJu0YwEwHfo1tNcEtiiY+iGo3bz64EFvxCgK1KMPmrmDf1o+LRbq1Bf
 i1DKPuOGso3IxE96n9YOP39dcE4mfC/b0FWNtRMl5Xoshee7UJwU6695a1Pbd7k=
X-Gm-Gg: ASbGnct0rRPdXNvXtF6K3Jo1gXReVwbgNzJPJUv6zr/mfgmEWolB4ZQd2hzoecsRJZs
 TTUfbX8yeZWez8XCg4SOKAgx6JlBs0U4IMOXozMfIB9mWmf03KV+dFX6ugvdh4Bymf5l6CmAhJU
 S9cMnMqpia1yFevxEs0iVAWTuLam4m1VITKOpXLDtMkaUEM9nSuSh461T1BFi9VIMfJFIP+qXrb
 F0r2iZtjRIqw2IXzV8pV0k1y9e70LmXvet3s+TBEgx3H9ZU8+6thIIKsXLM4FR/udog44VLkylY
 BbX9FW4=
X-Google-Smtp-Source: AGHT+IEuKB70bOPrpQP2oLO49OnS74q2fkE41+9K6wur9Q8t6ONTWIQ6WHRVzWndpH2nJTX1m0seww==
X-Received: by 2002:a17:902:db0f:b0:21a:5501:938 with SMTP id
 d9443c01a7336-21a8400ae3fmr420537635ad.52.1736906481549; 
 Tue, 14 Jan 2025 18:01:21 -0800 (PST)
Received: from [10.16.129.24] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f13e9e7sm72412945ad.101.2025.01.14.18.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 18:01:21 -0800 (PST)
Message-ID: <aa848200-c51a-48af-92e4-38a423e3505f@igel.co.jp>
Date: Wed, 15 Jan 2025 11:01:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <Z04lW_CdYBPJRah3@x1n>
 <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp> <Z1MpY7ZIAAoBDbZU@x1n>
 <9d1f07e5-2c08-455c-a653-e57e219666ab@igel.co.jp> <Z1oYIn5cMZeA4tes@x1n>
 <1ab0a747-e2c4-4545-bae9-31e19c77bd75@igel.co.jp> <Z1sFUxCiQp3Nziu_@x1n>
 <2e2dba3c-2bfc-478a-988d-fbf2e58cc293@igel.co.jp> <Z36su8G_hlkdBFy6@x1n>
 <6a4dd6ef-9d0c-4f1f-81eb-0d55fa32daf5@igel.co.jp> <Z4E4Cx0DRFyCVXog@x1n>
Content-Language: en-US
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
In-Reply-To: <Z4E4Cx0DRFyCVXog@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/11 0:08, Peter Xu wrote:
> On Fri, Jan 10, 2025 at 07:11:27PM +0900, Tomoyuki HIROSE wrote:
>>>> MR implementation to be safe when unaligned accessing (current xHCI
>>>> implementation does not handle unaligned accesses but the spec allows
>>>> unaligned accesses).
>>>>
>>>> In addition, maybe it would be better to document the constraint that
>>>> the situation where 'valid.unaligned = true' and 'impl.unaligned =
>>>> false' is not supported.
>>> Do you perhaps mean this instead?
>>>
>>>     valid.unaligned = FALSE && impl.unaligned == TRUE
>>>
>>> If so, I agree.  I think we could even consider adding an assertion into
>>> memory_region_init_io() to make sure it won't be set.
>>>
>>> Thanks,
>>>
>> I'm sorry if I've misunderstood, but are the following understandings
>> correct?:
>> - Need to merge my patch that converts an unaligned access to aligned
>>    accesses.
>> - Need to add 'impl.unaligned = true' in the following two places.
>>    - hw/xtensa/mx_pic.c
>>    - hw/ssi/npcm7xx_fiu.c
>> - Add an assertion that to check for invalid patterns, additionally.
> Yes, all these sound good to me.
>
> Thanks,
>

OK, thanks.
I will prepare patch v2 according to the above understandings.

Tomoyuki HIROSE

