Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70117C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we5EH-0001aF-Kg; Mon, 29 Jun 2026 02:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1we5EE-0001Z2-Jo
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:12:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1we5EC-0006vT-2U
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:12:21 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0A8953F468
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782713536;
 bh=8W3RzLAM/J7cY41L92q4LdQLYG8Vxh0+7AkVoZMu+GU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=g7o6/0YjWN8H1+OaAEioahm6Zz7LgU8HMqe6xOAz8b3mxX3zmW1tWC6+6Qa1SQLvL
 gOPmgyz1y0QPqOD8mEhILdVx51e9o+A2eg9a2OtDb0te3DlsZjBb1pQ3f/UGtWa9pI
 rTBn5pbpPGwPGkLwGqLdn2BZBdKWeh8XFCZHizYcRtyFgYoba9nVYqQcJwJaVBB+v8
 YNqkjMj8mR4UD8yGbkHkf6eB1NDw3tqYzO7vvfT0gwJ9XPjd1YlvNSy+NY+GJsuiv+
 9t9HmyYOHsW5glK7Ilsld3rmhM7BdCpoKpMophL896SDy3+Rr/Nipc0zKW9o35bl7A
 e4U9wj+yPfuvUmz02E2Ld33TAVpu1eocF/33RXzzoMVFzTkesHYAy2LUwFTVDjeH1Q
 usAExSFAVaBLPTZV8AnsRLzEWXTYeLLxyjzkC2SNFWQLagAn/Q6BF99Z0Mz0ZW0wea
 QD8Iib4KPYAM5cTtTV66pbbWzeSrUroG8HDCkBKEF9ONziT1ZPBYJHHpBpJieEoNV0
 5guqkDsudWBayEZAbvXhZx66KhLc1mIp8w4S70chV5xaO+dnYjDluWLkTig7KpUFGi
 I/6ecRFsppJFMRzjt6/wDxsEFhoM7Lv9SRDlM12jg0b7RJ8hram2SI5CGjJLonLOIF
 dxqTihLF3LjvXzKXjB7aPGPE=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-469218e618dso1689867f8f.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 23:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782713535; x=1783318335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8W3RzLAM/J7cY41L92q4LdQLYG8Vxh0+7AkVoZMu+GU=;
 b=WB2mGt6FOPenPuO0f48ZmrqoaZI/zjLEScSIzyrYWdlFiKxBm7TLwZHKUHYti0tGaj
 JiUFOMk5DgNTyK6No/ulQByRnu22/8VHOmTxj8DhDLXu1RlT6OtAMemoZlrSsVbM6s0F
 VkumA0rNWylXOC6oJd+IDNHNXZ+sknsmdhlgisur8ATU1ERNpTJzbIMgzX09u4lBjtLj
 ctD+BWBs+oVSMn6Aem2GgFJhc1ZcNrBRBk8juHg+OCVw0gUX7dla9fu6/LzddkYOmIvz
 Vfift0oY3Uflg+01baLKKa1I1kDX0yJDwzccfMv3Xm3LUKgzGJwWBSLT75fRXS4E+ok9
 pvog==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9Aw2Tf2ZKYnjfSIRiDCiTWQdkkhESZK5gZZP71xhYPY//eaS6q5Z0qSnMVQ+f9RgO5SHFA1YwMaUZ@nongnu.org
X-Gm-Message-State: AOJu0YxYGW2UfizqcNFE32c6p1V3kK89oZlnkAVLacda5C0uFRndrwBm
 iP00KT6aPJzsNkypkWjfdd7ZKDoCKP62nBQYEjxERnRVan9iSFRlOEvXcOF6/3Xh0XaHo3hEmYR
 U87YT8S5OLEP3PaWCSsQEgyMVg/pxn4+efIMBXBKqpE7vVGI004XUOhZtXsTEoAEuoXa/58WJ
X-Gm-Gg: AfdE7cl+b8zvsJsnLYhs/VTHXzB883pF/Y0HTnXdUSvaSDZmRTQT9H77UsNSQY4fb4Q
 n7DF+1GXxsZ0N2Z+G9fJnOsU6yDiJskhN4jmVRH4HGHqZtYcEPDSuTi+D6DrUvbmQuJJu0B/IKm
 Mvz8O/ybrpc+tXnXhoxPWHFe5sykKXvnxmPUGtWnapt8N19QCf6zEA1PQPHoT6LnxHVu/kzWo24
 KwLKuxaRUvDMd4F1jZ73C7Ak1w6gC2hmqqURd8BrUmxoTWv0P5JMhhgNpOyDWT+XmMuI/4FwtjF
 OmuDlm5VRUMFA7d17CYrWTY/zesbEkCPWh0HOHzFccTN1idvxoNYyOlvoCCoCK89oUP9zW7I/NH
 CnhJicUlAPA/f629w5NCE2VorRwwbRvXPLTYX1vZl15uZOUwPUbTUsx4jHqoR8x+4UqQQpmOyML
 s3GxUtJnRKgKXZS15byyb/pO2rEyDM2xfAB33ezCC2qHKwFOsWXZ0=
X-Received: by 2002:a05:600c:3b8a:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-4926fc761ddmr196991295e9.21.1782713535554; 
 Sun, 28 Jun 2026 23:12:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8a:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-4926fc761ddmr196990905e9.21.1782713535127; 
 Sun, 28 Jun 2026 23:12:15 -0700 (PDT)
Received: from [192.168.123.154]
 (dynamic-046-114-104-147.46.114.pool.telefonica.de. [46.114.104.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4726b76e6f8sm16115691f8f.13.2026.06.28.23.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 23:12:14 -0700 (PDT)
Message-ID: <34ffc248-aa4d-4154-bf5d-3b095aff0144@canonical.com>
Date: Mon, 29 Jun 2026 08:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hw/acpi: correct field sequence in SPCR table
To: Alistair Francis <alistair23@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260622111843.34056-1-heinrich.schuchardt@canonical.com>
 <20260622111843.34056-2-heinrich.schuchardt@canonical.com>
 <CAKmqyKPeK-nCsemLAru6nkWP7V8qtA=XgW3ALuOJ5nFegF5F4Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAKmqyKPeK-nCsemLAru6nkWP7V8qtA=XgW3ALuOJ5nFegF5F4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/29/26 02:58, Alistair Francis wrote:
> On Mon, Jun 22, 2026 at 9:18 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On LoongArch and RISC-V invalid SPCR tables are created:
>>
>>      Terminal Type : 00
>>      Language : 03
>>
>> The correct values are:
>>
>>      Terminal Type : 03
>>      Language : 00
>>
>> This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
>> SPCR creation to common location") that swapped the fields.
>>
>> See the specification of the table in
>> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table
>>
>> This page shows version 1.10. But the sequence of the fields was not changed
>> since version 1.0.
>>
>> Our LoongArch and ARM code uses version 1.07 of the specification.
>> Our RISC-V code uses version 1.10 of the specification.
>>
>> Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
>> Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
>> Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v4:
>>          Reproduce the test data changes using rebuild-expected-aml.sh
>>          creating the same diff as v3 but in two separate patches.
>> v3:
>>          Update test data
>> v2:
>>          Mention the different specification versions used by our code
>>          https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinrich.schuchardt@canonical.com/
>> v1:
>>          https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
>> ---
>>   hw/acpi/aml-build.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 9b3cdd3781..990abc64cd 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>>       build_append_int_noprefix(table_data, f->stop_bits, 1);
>>       /* Flow Control */
>>       build_append_int_noprefix(table_data, f->flow_control, 1);
>> -    /* Language */
>> -    build_append_int_noprefix(table_data, f->language, 1);
>>       /* Terminal Type */
>>       build_append_int_noprefix(table_data, f->terminal_type, 1);
>> +    /* Language */
>> +    build_append_int_noprefix(table_data, f->language, 1);
> 
> Won't this break tests? Don't you need to disable the test first (then
> re-enable it and fix it in patch 3)

Hello Alistair,

It would be helpful if /tests/qtest/bios-tables-test.c would clearly 
point out if changes to tests/qtest/bios-tables-test-allowed-diff.h and 
their reversion should be in the submitted patch series or not and what 
the acceptance criteria for the patch series are.

I was not able to identify this from the existing text. So I eliminated 
those redundant changes.

Best regards

Heinrich

> 
> Alistair
> 
>>       /* PCI Device ID  */
>>       build_append_int_noprefix(table_data, f->pci_device_id, 2);
>>       /* PCI Vendor ID */
>> --
>> 2.53.0
>>


