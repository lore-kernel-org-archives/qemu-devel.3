Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8344CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 03:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIfFY-0004DS-QM; Mon, 10 Nov 2025 22:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIfFV-0004An-37
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 22:40:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vIfFQ-0005XZ-LR
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 22:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762832447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oqeI8PBOVyJPpLRawkuwP2zVH9YjBiGVPSlZ3dKGgB8=;
 b=S8LAqJn/G0MTAqMM10sismICiZvjheGoqPHlbyRalIIYoY5QAe4SoHXwUskKja5xWVDZf+
 MaVckaxeDzw2xrCzvg7CtaqdJu4GV4ESgI0AvGDmQvT7KG4m0dA4WdkzWDaeNXzYcRey7y
 Jm+vxPBCTQJzXyhwMf02MNfUqs1Soyc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-01tQMFuyOH6lL32vj-PWHA-1; Mon, 10 Nov 2025 22:40:45 -0500
X-MC-Unique: 01tQMFuyOH6lL32vj-PWHA-1
X-Mimecast-MFC-AGG-ID: 01tQMFuyOH6lL32vj-PWHA_1762832444
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29809acd049so27195585ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 19:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762832444; x=1763437244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oqeI8PBOVyJPpLRawkuwP2zVH9YjBiGVPSlZ3dKGgB8=;
 b=a4ySqXuvMOc24PdidxXV6p3Y4igF1Sf7K7J73RBw4f2Ro2NsBTztM0pal3NiTUFPWY
 bi0MAMW4NriIJRPUCkkEu9tv2hUkzi1G4qMPv3uqRpdZ2jmE66lWA07A6Ol7esIi2CaL
 0TC3fTkGzpRNYwPlhHpQ/jybTcoVI+3dR9Gtp/vfBi1a0NzN5nbzQczvCkA++wZckaOy
 d7z90vZO/9rXEgPIDjaMNT4oGNRjfAQ1YnHQ4ZjbyDxpH078nyoug5KkL6HTpb+4Gb+N
 PGZcZGlBYMbcBgC+7le/KiAlT0Us4fVnfNtDSDMdNiu3ea1PxfbaBQSSnxq+jG9YVSdZ
 Q0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762832444; x=1763437244;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oqeI8PBOVyJPpLRawkuwP2zVH9YjBiGVPSlZ3dKGgB8=;
 b=H6iGDWpGUuBF2E3MxrLeU3QdJWSuP7jTnVHUnPUauDocZCy2fiKJ4ig8sQu4PgDD7L
 gWmHGn5tO3z8DUmndPA2xXF+0e+Aggfl17dxywsYuyFcD3fbm1IcziDYjj+c5zhvBRqM
 CqRPRKfCQdJCxomAigySD2QPzOJ8FiozhLfgY0KwkyeQwt5iUFnRkA4IlNQ6ysM+U9nF
 gFQhUgjWEcZu6swGqn/J/wh3HnfcscEL5IpLxpOO1mtQu+yVk2X/gtQkw1oo4noQdKl3
 z7uSZbJbJNlJrxtZP2D9pXm1ALkZSEthQm0g8E9BpYZNHx/Ah8tGhhL5V2nZDzb1MyGJ
 UoCw==
X-Gm-Message-State: AOJu0YycJDnr407APGYk2JBwNuWVB4MkPTgK4FR0idZEFUdzb/84zGLW
 Pk4fh6He2q1FESAxyhzWsLVN5uy8zF7clXfl0WiwC1b6GZZH8FNbRk+qKVaCLtiEb6XYL7mfZ/d
 g7OI8UJjYS6430/85G8i5FawqQ3LQ8FxAO5rcPH0APUZTyj1GPq5fGBL/
X-Gm-Gg: ASbGncve0ajl2BbEuGvcMTn8unJt0+9gnjebTidgrdxb4Xt3ICtTRpcixKtfEHAH1JT
 QiL5/RHl525NiNkatQUMJUg5bHSjqKkCYg9qTSMGicfg5UhW68Om8cx7kCavtd8RJ1o1uxPm0SZ
 0HWJIUOvI+Flip50EcUIhf1+H0gf/+2aYytmGlfthS+0R1W0yzt/VwWoeWthR1fe5ygnsMw77KJ
 3rQZ29euxkYElrvbST8kYh/bcfwttWEXmli76RzBd3LLLW/7kjqltOJCWfpKtSG/qYXeBJPVmGF
 2HONAw+bcdJtEZEoNZYibjCfPcTpQn0zpIJ8E97klcceGwoMRnnGYVLBXA5osvF4kiqjoCXwyqj
 EsTDJ+fhnjff8wXoRrO4JIi5JN+hKvu/P1o8IAzQ=
X-Received: by 2002:a17:902:e951:b0:298:ab7:85b3 with SMTP id
 d9443c01a7336-2980ab78690mr95342545ad.55.1762832443963; 
 Mon, 10 Nov 2025 19:40:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF24LMbc4x2xiRhT1iaUbdmps+aAiZ3sIjijZ++isRA9vAiZA9U3907LPUZwBYWo07BOnRl0w==
X-Received: by 2002:a17:902:e951:b0:298:ab7:85b3 with SMTP id
 d9443c01a7336-2980ab78690mr95342245ad.55.1762832443518; 
 Mon, 10 Nov 2025 19:40:43 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651cc1907sm161713035ad.99.2025.11.10.19.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 19:40:42 -0800 (PST)
Message-ID: <a6adb9ad-5e73-4f86-951f-c2ef89e36226@redhat.com>
Date: Tue, 11 Nov 2025 13:40:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] acpi/ghes: Extend acpi_ghes_memory_errors() to
 support multiple CPERs
From: Gavin Shan <gshan@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-5-gshan@redhat.com>
 <aebd41cc-470d-46b3-85a2-1d8a1c62621d@linaro.org>
 <dd43ee6c-6968-4b45-ac35-e9e88bd80629@redhat.com>
Content-Language: en-US
In-Reply-To: <dd43ee6c-6968-4b45-ac35-e9e88bd80629@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Philippe,

On 11/11/25 9:38 AM, Gavin Shan wrote:
> On 11/11/25 12:43 AM, Philippe Mathieu-Daudé wrote:
>> On 5/11/25 12:44, Gavin Shan wrote:
>>> In the situation where host and guest has 64KiB and 4KiB page sizes,
>>> one problematic host page affects 16 guest pages. we need to send 16
>>> consective errors in this specific case.
>>>
>>> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
>>> hunk of code to generate the GHES error status is pulled out from
>>> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
>>> generic error status block is also updated accordingly if multiple
>>> error data entries are contained in the generic error status block.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   hw/acpi/ghes-stub.c    |  2 +-
>>>   hw/acpi/ghes.c         | 60 +++++++++++++++++++++++-------------------
>>>   include/hw/acpi/ghes.h |  2 +-
>>>   target/arm/kvm.c       |  4 ++-
>>>   4 files changed, 38 insertions(+), 30 deletions(-)
>>
>>
>>>   int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>>> -                            uint64_t physical_address)
>>> +                            uint64_t *addresses, uint32_t num_of_addresses)
>>>   {
>>>       /* Memory Error Section Type */
>>>       const uint8_t guid[] =
>>>             UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
>>>                     0xED, 0x7C, 0x83, 0xB1);
>>> +    /*
>>> +     * invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
>>> +     * Table 17-13 Generic Error Data Entry
>>> +     */
>>> +    QemuUUID fru_id = {};
>>>       Error *errp = NULL;
>>>       int data_length;
>>>       GArray *block;
>>> +    uint32_t block_status, i;
>>>       block = g_array_new(false, true /* clear */, 1);
>>> -    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
>>> +    data_length = num_of_addresses *
>>> +                  (ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH);
>>
>> Should we check num_of_addresses is in range?
>>
> 
> The check is already done by the following assert().
> 
>     /*
>       * It should not run out of the preallocated memory if adding a new generic
>       * error data entry
>       */
>      assert((data_length + ACPI_GHES_GESB_SIZE) <=
>              ACPI_GHES_MAX_RAW_DATA_LENGTH);
> 

I may have misunderstood your point. We probably need to ensure @num_of_addresses
doesn't overflow the bit fields (Bit#0 - Bit#10), as Igor suggested in another
reply.

Thanks,
Gavin


