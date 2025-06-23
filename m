Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36A4C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 15:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTilO-0008WA-RN; Mon, 23 Jun 2025 11:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTilM-0008VY-Pm
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTilJ-0000DA-RR
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750691226;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e8CylTLGHaf3QU81BclTm8+kkuyzBrG/KuFZoBykFJE=;
 b=dsIzHGzMv5F8mMptkJDjyP4fZ5YsOiyAT/k5PHXOecSPgHidaGZB4vXlnSki6hXb56m1QP
 krVlAlw5uyDq5OuRQ1JqtsHeu/BhuEv0hgOm4nY2NzoHI8ic1RTTEWFbxB/LbOl/3Asmng
 lz8C6bp3mEP0MYQPPz0Ih24KNjPClXU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-JpZdMsySOYKCgXSjVr2OEQ-1; Mon, 23 Jun 2025 11:07:04 -0400
X-MC-Unique: JpZdMsySOYKCgXSjVr2OEQ-1
X-Mimecast-MFC-AGG-ID: JpZdMsySOYKCgXSjVr2OEQ_1750691223
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a58939191eso1777506f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 08:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750691223; x=1751296023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8CylTLGHaf3QU81BclTm8+kkuyzBrG/KuFZoBykFJE=;
 b=na1Ex3XB04Zu/kVyVK+ilSSyHNs07JO13/gVIKBBUBUFK0jqueOOmq8Slo0vFYiB/a
 69PTUWAPqgRM0Ea4HHbqzbaPNGQFfqW6pe7GXNegJ7mCqriCt8uDWbt/wqAZtXjYPVwm
 UmvPdtDtRfZZpYP7CmcyWkElTLKdh+rSgDWNkugMOZWgltRA9lgq1nTdMQiP+s0Ypt99
 sLxJ1st7E/K5OXeu3c+PfidEVpf1+E6hSUqYEz2DenxnUr/SDH22iyClnDgm/iCP6SJQ
 rJrDpK9Imyv6bSMa38F49mUPLQZjNVlKzYGQtGjajiG8jDKZ1/+XzYfmp+TudpG4NaPu
 It6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFSn3d0jEg8UGLjqS/sEG0pcVwJ0lhnvHaaFDrc7XAIzuzDisFbb/RxrS1AEbnkKQUxQ++iXHKT4AL@nongnu.org
X-Gm-Message-State: AOJu0Yw28rN/XsPvmpABCW4WUTGfzMPLjEGtTUm+qwLkkEwSFhQhxJnF
 953q7GhAVyZCIRFjRZoPIWcI2hHrqOR0R95TDe/Ucy1CAi0PrmLNCJRd5GVkhNrL/FvcPY5TuMc
 XEjty2yQhhfusVQJL9g95kZghlH9Q/1q0gjZM9ugrudKn2/U8Y+6cDBG1
X-Gm-Gg: ASbGnct+C46o/rNvXlPZQqPa0+T/i0FJ4mY2FA0qYuxJq5HQbK8l+3UvQxWHN+AEwXp
 u65qL+0VDQelAlksG0D4bWLeZyc9s6MRGFVQq+Nd6aht3m9S07xlJX3KfIbEMb9nlrt5SRx0z9c
 lMWB6/czk22a7JtBtndxTGF6TqCCUzDXs5nzRkZFRR6xqgzUI87Gy2kTq1bYT+FnnqzLl3CryfN
 GvMlzKUBgLl99olsV778nDSKSJH/pp6hP0PHAqsJ/Shr9Zb19+RQSCMWn+rrbdc26xpGwx+1ng9
 bb9Jp0gZfGbjZqmd+hkm3xFXTcH0Euwbu/BzOGi6YAWcTGV2XOHmn7MYlu3ywnOTD8XK4Q==
X-Received: by 2002:a05:6000:22c6:b0:3a0:b84d:60cc with SMTP id
 ffacd0b85a97d-3a6d1191e51mr10263398f8f.2.1750691223079; 
 Mon, 23 Jun 2025 08:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwte713yI9R4FwCzU5Z5DbyLPy0cfJd9+SRpAcL1xhSoHstmwjkoXzxHAYmPReWChdRvISYA==
X-Received: by 2002:a05:6000:22c6:b0:3a0:b84d:60cc with SMTP id
 ffacd0b85a97d-3a6d1191e51mr10263348f8f.2.1750691222682; 
 Mon, 23 Jun 2025 08:07:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1187cf0sm9625756f8f.71.2025.06.23.08.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 08:07:01 -0700 (PDT)
Message-ID: <370742c4-cb80-412f-a9e2-8a1906ac0f36@redhat.com>
Date: Mon, 23 Jun 2025 17:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/29] tests/qtest/bios-tables-test: Prepare for
 addition of acpi pci hp tests
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-28-eric.auger@redhat.com>
 <20250620113138.00007531@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620113138.00007531@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan,

On 6/20/25 12:31 PM, Jonathan Cameron wrote:
> On Mon, 16 Jun 2025 11:46:56 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>
>> Soon we will introduce a new test related to ACPI PCI hotplug that
>> will use a new reference blob:
>>
>> tests/data/acpi/aarch64/virt/DSDT.acpipcihp
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Unusual sign off chain.  Eric is signing off as handling Gustavo's patch?
> I'd expect Eric's sign off to be second.  Looks good in the next patch fo
> instance.  With that fixed.
Sure. sorry, unintentional. I did not know the rule either ;-)

Eric
>  
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>> ---
>>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp | 0
>>  2 files changed, 1 insertion(+)
>>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>> index dfb8523c8b..dc3ab24d05 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1 +1,2 @@
>>  /* List of comma-separated changed AML files to ignore */
>> +"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
>> new file mode 100644
>> index 0000000000..e69de29bb2


