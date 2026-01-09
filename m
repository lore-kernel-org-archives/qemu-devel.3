Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59B7D26D64
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 15:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veE9P-00020x-2l; Fri, 09 Jan 2026 10:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veE9M-0001zI-Q5
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:11:40 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veE9L-0006L5-AA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:11:40 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso35622265e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 07:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767971497; x=1768576297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LI0EBls7XECi9whpqvco6YvFPGEwsOG51vPH1n1ROdY=;
 b=witNThall2yh2r3EVojN7rBw8X7iWN/74yxWxYarRyT6mdq5iIDVUOiqJ0W3CpP94V
 nbYqBHjsVyHC/WLJ4mi/APW8JzBHGXOX5BBhlQ4f2zPIWD4OzoreYmQTqQlDa+/EPnn5
 Xh0DMompWqsRR5ORidg6PAfcBzo05xtNTxSC5gu/OFjzirqHfW7GqtmXcyAG2B8dMYiV
 cRF3ErP/qSOyVoccUfuAwPSY2qmAcAxryn+y41eXjQvOYb/srTUpTFUuzHLwAMNR1Reo
 DayyQz2FAhvDS9Z4bdeF+YT6J/hV6VIDDJic3xEiiJ8+UOhioI+SNhJcMDtztSKtHmPC
 DOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767971497; x=1768576297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LI0EBls7XECi9whpqvco6YvFPGEwsOG51vPH1n1ROdY=;
 b=BNVyOdo00mxe9bEDSiqCp4a/pljQUdGDRiAHtt+5isXOaTGdnxABiEBIZpUVPGpJOV
 uJfruTjXT9KjYCC9yb+mgmtUCEc04IdelestrCc7WTqY+6FKgsBLN9EHtkRETiccqlnN
 KQon/NxvY+qddLMGRNtVOHJtdAsSWlC3NtHyd5y+maW+6kt7CL+MAIPs1p4IidC1HSj7
 NuywTiJg2wmPKDVpAg259d3wb6LaGTIHUrtRw9KlqkaFVl/AuSDsTXMtxfLLwbVa00F2
 rEBW1co9Y+x6xABS6KdkziI8fnBdHfbHozdTJtmQHU2HntRL9ReEFTGxOCX/In1SVuzI
 +/Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvQvktCTUF4F5RfyRxVHJWg1xJU13mpPU3gOGiswGAl0ZtbdQ2oIxYFc/flwiFRzSbPD2OVyFOPlD6@nongnu.org
X-Gm-Message-State: AOJu0Yynsby0i5yJplO2C2dYS5QOVeDVZH29Yi+9UQdDVwJVnbaafDsC
 7mItn6tfJpQeCQif/JB+k08sP/qkSAki6LtpRn6jJGtlSDGTdrqEbYd2VtR+SLwVjGw=
X-Gm-Gg: AY/fxX7a0BYM9rDxU8XDtcUObIIJ7BzCEifF/srFbk5k3gjyKXmE5tCxznISNUoiwTg
 RssYfCF5k0ix5DEudqaoO2heXq+5gOV5o1bO+naR/ETdXz+FOHqLjGTDAKgfyOKnCcjq416HJ6u
 exosVFI+BCHJSrKD03ZnG6k5DJxbXU3gfAkagxrsHHt5puBAJMULvowRYi6KYQvnBZnp9Fu4Piy
 AT66e0cuM9mNUAREo/F2GRxawwT5g3HzTiR5xgD5eWzuBsp1TWdA7wb3YBYf4CJqgoqjDn8+1B6
 b3h8pMe1MDPWTjej7fcfF6cPKAtURK/M+J0MeyWr3ZXN9oN/KOZAnEGGgyO+t0DMQ8uk5DMvVmF
 I8YMMaaPzTGJdi9PhNEPVbBynQrOVg55aC+g8K2KSeeIsGYe9RKvB7f+ahaho+B5s6cNDyC4P7v
 Wq2CF/yFnxI3kF7R5gYpD7gB4Tk7leS/ruqy8WPC4Jg8y6Fyhz6A2ecw==
X-Google-Smtp-Source: AGHT+IFiRIQw0Nwsr4pCmzocihuuM7antSVUtGQ+pePr22eK/+XDGW+JGYbLhWjH8ZiL/6iL8Vy/Xg==
X-Received: by 2002:a05:600c:3114:b0:47d:403e:90c9 with SMTP id
 5b1f17b1804b1-47d84b18663mr111003065e9.11.1767971497554; 
 Fri, 09 Jan 2026 07:11:37 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8636e588sm70753965e9.0.2026.01.09.07.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 07:11:37 -0800 (PST)
Message-ID: <440f8fcf-9d37-40dd-b487-ead9a6d1190c@linaro.org>
Date: Fri, 9 Jan 2026 16:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess in PCI config
 read/write functions
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org
References: <20260105222029.2423-1-alifm@linux.ibm.com>
 <6ac8b1d3-9252-4e63-83b9-c92915a8b78c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6ac8b1d3-9252-4e63-83b9-c92915a8b78c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/1/26 16:01, Cédric Le Goater wrote:
> On 1/5/26 23:20, Farhan Ali wrote:
>> The VFIO pread/pwrite functions use little-endian data format. 
>> Currently, the
>> qemu_vfio_pci_read_config() and qemu_vfio_pci_write_config() don't 
>> correctly
>> convert from CPU native endian format to little-endian (and vice 
>> versa) when
>> using the pread/pwrite functions. Fix this by limiting read/write to 
>> 32 bits
>> and handling endian conversion in qemu_vfio_pci_read_config() and
>> qemu_vfio_pci_write_config().
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   util/vfio-helpers.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> 
> Applied v2 to vfio-next.

Typo "endianness" in subject.

