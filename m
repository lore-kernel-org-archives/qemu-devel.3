Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8F0C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 11:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPKZ-0007KA-FP; Thu, 18 Jul 2024 07:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUPKW-0007Ii-Pd
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:29:48 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUPKV-0003u8-11
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:29:48 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36844375001so490223f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721302182; x=1721906982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iYmazKYtPTOO0QK+7VEdzxnW8P2vYDfdiuU56Ps7OhU=;
 b=d/Ye9kq/EjgxbUm+InLFmj9wdWLPr1gcd/WEqTE97P0+2pMKQ/IfsWOE8tNAqvZ/7I
 6kLA54Js0JZleLjkKf/vuEHZ1IssTOFQM8z7jpaNQ6Atti/4d2PTU9NnmUtWbl9kiGs6
 zr2vsn5JVfCC1m1HAvrp9aZ9vDH6z03uZcdjo025fBAeNyQW5zmxXh060MkIMQus8W3N
 dVOJg7hS058cdh++cJtjXS7lmkF5r2GHjPWkOu2BrW0zopvcGhQLrmGE/YBHQsqON/Z3
 1xyND9WU7oXbyfy5GzXb2+S/mCXmnC6454KoaJNdmccOl1YAQhtAqpLQ91DIHPJX9rMy
 uDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721302182; x=1721906982;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iYmazKYtPTOO0QK+7VEdzxnW8P2vYDfdiuU56Ps7OhU=;
 b=wTCs+Ev6In/xj9QngXWYhG0OF/Ir3eBxBpjhX+z2F3wI5bcqC13FbwIOYlFYsrQ0xm
 DReScuUvjycuJzYtEoIN4MbxkLXW4OTQom+28C3NMZoRxMBQOVpS8MJ858lMo443ptf5
 rsXH2G9m2JLL0bxKPdIqiCxgYQskBFjS0Yv1bnhOEdBw3TYPo7gFEPH9dBRSRr6rP8J2
 QMcEAh7MUi4DsLBxnZ4QolO3AS071rBMGSmgPJMVUliwFH6MVy61inCY8QZjwwuVvoM1
 koXbi2no1QcD5oPU6Y6qqKjIo5xJDgKQWHjl00UNhXVxoYXWOuvsy0Bw0vRVm9Q81YPi
 HyoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBmIvfMP3QGPAYf1LZxd4IRYdnz8yYoVvCC/k40IdclEWO0/HCYpsfO3/LJ4Mb+K+S3MKi2xv8e/cSKK53hVNNrSOjgwI=
X-Gm-Message-State: AOJu0YxVC6VhC0VUMUzCZCTJTd4pI/l8Rq0kNP2erhCudCXUqlK9h0lk
 dXuB5GJ/kq2e7LY2DHDG4+7gX+DHaXlfy9J39kPirRf0E4M5wV8nyhuwasFqSrE=
X-Google-Smtp-Source: AGHT+IEIeFLCnBQRO8YIhgDAjydwP52d6l5gGtSSwJ3qWzCw7Gyk3/bXZnHzmpgbi33SDbudZ8uvQQ==
X-Received: by 2002:a5d:4451:0:b0:368:4e86:14cc with SMTP id
 ffacd0b85a97d-3684e861615mr1243392f8f.10.1721302182170; 
 Thu, 18 Jul 2024 04:29:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3681c30a024sm9753084f8f.96.2024.07.18.04.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 04:29:41 -0700 (PDT)
Message-ID: <1d312b3d-9677-4308-8b61-3294e6b2aa42@linaro.org>
Date: Thu, 18 Jul 2024 13:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/18] Reconstruct loongson ipi driver
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <70323100-002b-803f-8f85-23f1bf32c885@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <70323100-002b-803f-8f85-23f1bf32c885@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 18/7/24 12:00, gaosong wrote:
> 在 2024/7/18 下午4:38, Philippe Mathieu-Daudé 写道:
>> Since v3:
>> - Use DEFINE_TYPES() macro (unreviewed patch #1)
>> - Update MAINTAINERS
>> - Added Bibo's tags
>>
>> Song, since Bibo reviewed/tested, if you provide your
>> Acked-by I can queue that to my next hw-misc PR (pending
>> Jiaxun testing).
>>
>> Thanks,
>>
>> Phil.
>>
>> Bibo Mao (16):
>>    hw/intc/loongson_ipi: Access memory in little endian
>>    hw/intc/loongson_ipi: Rename LoongsonIPI -> LoongsonIPIState
>>    hw/intc/loongson_ipi: Extract loongson_ipi_common_finalize()
>>    hw/intc/loongson_ipi: Extract loongson_ipi_common_realize()
>>    hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON stub
>>    hw/intc/loongson_ipi: Move common definitions to loongson_ipi_common.h
>>    hw/intc/loongson_ipi: Move IPICore::mmio_mem to LoongsonIPIState
>>    hw/intc/loongson_ipi: Move IPICore structure to loongson_ipi_common.h
>>    hw/intc/loongson_ipi: Pass LoongsonIPICommonState to send_ipi_data()
>>    hw/intc/loongson_ipi: Add LoongsonIPICommonClass::get_iocsr_as handler
>>    hw/intc/loongson_ipi: Add LoongsonIPICommonClass::cpu_by_arch_id
>>      handler
>>    hw/intc/loongson_ipi: Expose loongson_ipi_core_read/write helpers
>>    hw/intc/loongson_ipi: Move common code to loongson_ipi_common.c
>>    hw/intc/loongarch_ipi: Add loongarch IPI support
>>    hw/loongarch/virt: Replace loongson IPI with loongarch IPI
>>    hw/intc/loongson_ipi: Restrict to MIPS
>>
>> Philippe Mathieu-Daudé (2):
>>    hw/intc/loongson_ipi: Declare QOM types using DEFINE_TYPES() macro
>>    hw/intc/loongson_ipi: Remove unused headers
>>
>>   MAINTAINERS                           |   6 +-
>>   include/hw/intc/loongarch_ipi.h       |  25 ++
>>   include/hw/intc/loongson_ipi.h        |  50 +---
>>   include/hw/intc/loongson_ipi_common.h |  72 ++++++
>>   include/hw/loongarch/virt.h           |   1 -
>>   hw/intc/loongarch_ipi.c               |  68 +++++
>>   hw/intc/loongson_ipi.c                | 355 +++-----------------------
>>   hw/intc/loongson_ipi_common.c         | 344 +++++++++++++++++++++++++
>>   hw/loongarch/virt.c                   |   4 +-
>>   hw/intc/Kconfig                       |   8 +
>>   hw/intc/meson.build                   |   2 +
>>   hw/loongarch/Kconfig                  |   2 +-
>>   12 files changed, 568 insertions(+), 369 deletions(-)
>>   create mode 100644 include/hw/intc/loongarch_ipi.h
>>   create mode 100644 include/hw/intc/loongson_ipi_common.h
>>   create mode 100644 hw/intc/loongarch_ipi.c
>>   create mode 100644 hw/intc/loongson_ipi_common.c
>>
> A build error occurred with patch 15.

Oops, introduced when adding patch 1 :/ Will fix.

> sed -i  g/Loongarch/LoongArch/g   *.c and *.h

OK.

> For this series:
> Acked-by: Song Gao <gaosong@loongson.cn>

Thanks!



