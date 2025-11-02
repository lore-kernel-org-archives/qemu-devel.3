Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFF9CCFA00
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 23:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFhg7-0004RI-W7; Sun, 02 Nov 2025 18:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vFhg3-0004M4-74
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 18:40:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vFhg0-00012L-Ck
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 18:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762126798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOmSrkeZzv8ZMxQCIXBM8Djg7ZsTvVYIgL4Xkijj4Fw=;
 b=LxQw81Bz9oNAc4OsSJ05FB/n5DSjf7elRp0fCbQjilEoPosON4N486NUAkrSEUcIoNu4Ky
 QYQWCxq3O03Yh/ZhFTjH1YzQKW+Ea5arDuuaBKAWUVTdODD32Z6KvLlcM/qeAPKOJ7G2x6
 vwhdAx/lAUU4K5fzPtgtm6AZQJeTghQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-Vub3PTQiPaeV9XBQkRIjeg-1; Sun, 02 Nov 2025 18:39:57 -0500
X-MC-Unique: Vub3PTQiPaeV9XBQkRIjeg-1
X-Mimecast-MFC-AGG-ID: Vub3PTQiPaeV9XBQkRIjeg_1762126796
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2958c80fcabso23693215ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 15:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762126796; x=1762731596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dOmSrkeZzv8ZMxQCIXBM8Djg7ZsTvVYIgL4Xkijj4Fw=;
 b=H+Hd6OZobSVOavYUWC4uUi3XJKVB8MsezlTtuE1DhTfP5/KX2WzYAvmchP/s8iAkMa
 IArDcWgyXAZFurxc7oaKC4MPp8ClsHsIMCDRsZhrAgmUHOXPoaF4/C5DmawcBqwt1yWf
 j6ZcSOE048UeQBf+FV9BZlLIuAUAmeSNPP2+G/BPNkVyF376VD/pYK9l9a58evJtc8ab
 tMlGFdc0pyB8zO1hDR7gyZk6l53W/qKd6ZkkXWQa3rRg0Lg2kCx5QyByuvzBW6Ru4ftd
 NRr/isF9PcR7ekTfQUJlMb0IuXWFUmnIOAxPoplszwHbVOnpV1LqEGit9pLUETrQjYgy
 5Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762126796; x=1762731596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dOmSrkeZzv8ZMxQCIXBM8Djg7ZsTvVYIgL4Xkijj4Fw=;
 b=TItcLkKAxbK4KSFTdVe5Mt712c9ZroRURAYK9sIxwEn1fj6piuZriL2VHz/Elsv6YN
 QUfGXm21iTNnIxHsj6J8SR4e+uP4AenieIg8SBHpuqCvvM/9Zm/43Zq4/zc12INYqoDz
 7I5jkygTPiVNWQZuAB7xQkZPF0ZZBY3HKDED6uzdWCTmb+UNuLRnFj+sfpqMUSgQY8gF
 p1UUVh6Kh1uigknfEArrmh+9QZOTzRpLuvzv+LiX1/eFf/nIfCIahr0DBuj3Z3IBBQKF
 V0WJ5o6Azy352ul6flL8xLmiUUWYoBBZPbhY6izdhzvUWr6Fc+m2JW2g6KepGBBbNL7K
 rkeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURr9CH2XG/Yk2wvwaioFu+o2DFQxaeHD65E660q/v0xM9MwpgLcVf+RP9Rgdi51uFaOthg5awb3LkG@nongnu.org
X-Gm-Message-State: AOJu0YzcrGDAOyfcvlBvii4mTDkFQdHvghT4sctk8k5229+0VpWqglG0
 /2Ckin52a1s5Z60FKAzgt3xZf38E/nA7LUqlxaU5qtPP2XbrLHGL4E1Mf9wbTyeYZH0bF3Npejc
 seVaMJGWUaBOPeIynjefPoQ9q0YtVWjJ3Echz0PxzJzHe4xim2aN/5dZm
X-Gm-Gg: ASbGnctZ3aBrzHSXgPkHsO0Ym6CZ0sDEMFm7hOrymgl56da9wCD8T/LVkx1HTjSSGSA
 07fstcefXz/8LqNhW5YRhhmPwZ2r/dEXHjhxGTx/y/Za33zYZYhTGLlZHPuzRbZ4/W/GAB9UV2G
 oAV5MPUTxUVLUTSHsvpSvxKLetkWIb3Snzz4BY5Kpgi5FxSNjpEWZzzzsQG2QO7M7pC49Q8U6oC
 RjcJp6PTRxeHBwQWrsq4aXv9Q2SJh4UPTogGxd06++DQs7FU0xCjO/acipdmH2t/z6Rydi3EeNU
 g+V5Y/MMxhCuy1cn+nlGMyij4nKo2z9iyaBAor8bspoFc0z3GN4yfyIGiQlBWpVrWXauYXwmWs/
 xYXAa9UGSVwOjkktUDbevB3MZhtub9257v9d+jKk=
X-Received: by 2002:a17:903:94e:b0:28b:4ca5:d522 with SMTP id
 d9443c01a7336-2951a496d09mr152479595ad.39.1762126796223; 
 Sun, 02 Nov 2025 15:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5SrQ604PeCdmL37tWQVinLxv9IJolJDcR25y52HirD8TT5RjRMzg41w31rVhl260mGeiiSg==
X-Received: by 2002:a17:903:94e:b0:28b:4ca5:d522 with SMTP id
 d9443c01a7336-2951a496d09mr152479325ad.39.1762126795881; 
 Sun, 02 Nov 2025 15:39:55 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295269bb28fsm95771895ad.100.2025.11.02.15.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 15:39:55 -0800 (PST)
Message-ID: <fcf84423-9675-4293-9552-ac5f09acf171@redhat.com>
Date: Mon, 3 Nov 2025 09:39:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/3] kvm/arm/kvm: Introduce helper
 push_ghes_memory_errors()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, mchehab+huawei@kernel.org,
 shan.gavin@gmail.com
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-3-gshan@redhat.com>
 <20251031100901.00000ccf@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251031100901.00000ccf@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/31/25 8:09 PM, Jonathan Cameron wrote:
> On Tue,  7 Oct 2025 16:08:09 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> Introduce helper push_ghes_memory_errors(), which sends ACPI GHES memory
>> errors, injects SEA exception or aborts on errors. This function will
>> be extended to support multiple ACPI GHES memory errors in the next
>> path.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   target/arm/kvm.c | 36 ++++++++++++++++++++++++------------
>>   1 file changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 9a47ac9e3a..c5d5b3b16e 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2429,12 +2429,34 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>>       return ret;
>>   }
>>   
>> +static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
>> +                                    uint64_t paddr)
> 
> Why not hwaddr paddr?
> 

Because acpi_ghes_memory_errors() accepts it as uint64_t.

>> +{
>> +    GArray *addresses = g_array_new(false, false, sizeof(paddr));
> 
> As in previous I'd just have
> 	hwaddr paddrs[16];
> 
> rather than bothering with a g_array.
> 

Ok.

>> +    int ret;
>> +
>> +    kvm_cpu_synchronize_state(c);
>> +    g_array_append_vals(addresses, &paddr, 1);
>> +    ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
>> +    if (ret) {
>> +        goto error;
>> +    }
>> +
>> +    kvm_inject_arm_sea(c);
>> +
>> +    g_array_free(addresses, true);
>> +
>> +    return;
>> +error:
>> +    error_report("failed to record the error");
> 
> I'd just do this inline at the error case. In the next
> patch you add a more specific report of why to another path
> that would then be followed by this.
> 

Ok.

>> +    abort();
> 
> If you do the above with the message, just duplicate this in the
> two error paths (by end of next patch).
> 

Will correct this in next revision if we still take current design. Igor suggested
to have individual error source per vCPU in another thread.

>> +}
> 

Thanks,
Gavin


