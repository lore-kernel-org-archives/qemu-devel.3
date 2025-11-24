Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CEBCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 04:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNp6-0000uB-Q4; Sun, 23 Nov 2025 23:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNp5-0000tp-Gg
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 23:05:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNp3-0003jd-M0
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 23:05:07 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso41178275e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 20:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763957104; x=1764561904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2HkgHj/DV52TQhqzh+Gs/2f81DkaKLTHS1KsxZUMtMA=;
 b=J4xzeuFwYCWa0pWFrtK83atBTeisvYh3npl+aY5pLym8rb9pHDl+veOX58nSgZKNdo
 0NnXrYbbobzsRbh4+y3IaVoxgoGf6ukZS/ZmeFwvxR6LcC9aBAhgt47b/4aDk+6VHQBn
 2x2e58zmuhLbQ3HbYIB4vtpF1FL3KUMSMqixFrL++0OfxEjRJuDk/Pcf0iTEJ2Qw7iBl
 XhK9BwctZEC9K1Bpkpk5gCxNN9GTot8ozaatAcRy8+d3BYySyqHaO59+lQ4cmuj/0F6E
 MET09sfm3CAK6aZqoN9U3u4RlMZO2qTxp/RCicD06pjQV8q+rZIDqCQu+5ni7I3UlfAF
 rQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763957104; x=1764561904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2HkgHj/DV52TQhqzh+Gs/2f81DkaKLTHS1KsxZUMtMA=;
 b=FI2JNMyHepu11CHQlFtg8nw0HDuxwCjvofFuB7dRzbv5iv+HT8LqHK8iqwtiGf0KOx
 +SYTEhACW6sO/9G150EbKhSG7dMZqQlbFtC+3vB5l7LNi10PkfXgKhzH4fiECU2XpnZK
 Zdim+/+pPaYoBnUsbLOfPseO+fhh8Qh2AZb82t1+XR+iM4ef0ymraYjd+t03xfj+NAht
 1Ijd+HWHNSlpuu/MkDRgJdayK+ZKYiUMehAA0qrbPtzAbTv7mTGnvKUJYYAl3IXAYzYm
 rwna1D3Bpg+O7D89rIGoGPS0dn8OrqSf83Ys0PkvipXWpp+S1xhNvshFqZRTiOSeWWdK
 o8Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV7TdLwq/b9eofAFFGVLMdenIpKi2nTv6CQMI6cjnoAjkUvc0zAbJqRDWXDP2l1NEu2elwk8ZTepn7@nongnu.org
X-Gm-Message-State: AOJu0YxokumQm6uM5XCOXJaug3ytO2saPVo8cEgR/Utp0M0jYVQFEbte
 w03QmSBTONb19QvmKB7Uo/YdAkyZCzFbnR1rxFSOILvu4E5HH8gLqUcRVfsoHU20H40=
X-Gm-Gg: ASbGncuMU9J21Is5XMVCPmalY3YGib3jYkAvJvQpCwGszbD9nwLXEkPARJ1+cX9rRKD
 jKbzVoExS0UDTcozlTEZDSYGi/HnTddNRob+V5IDSyWmaP+NDVdev2DA3u/lQgohWxnTGOytscT
 zShbAG+X6hr+kOD7lb+91k5xtkwoKC/jXvaBBVqH5oNIzZo+I4Dl3iUQA4bidpgVHHVdscYJI1o
 DlyIbvnxVjVo6xEvR/ohtFwPoM2HCd0xyujBjwWRJo645+Vlg41gvlXwMb5uCoWpWqEKyFHL1DD
 K3jVlwMpTIKSGR2szsWVtBeFYzqfEHUTWHME1IAJa/G6DfT9t+807ufrP6+6hQZYJmMk0xb1FWl
 kJIVmnDkcU78S/BLMjRFH0i80k18g54PGkKr+C566WpB0QKajrg8l1vaG2/DnD5D8wSXA8whv7T
 bQ9q4ld0FhkNxZOra4tjSWpVFkNhhwVnKOHhI/LJHo/5M8CBwcYBcS+w==
X-Google-Smtp-Source: AGHT+IH0f1I50LieR9En3YLudQD/NxBqB8Kw2wI5juCuWnK4ZkK3H+XaQ1AvG/56xXsOcdYWbM9QYw==
X-Received: by 2002:a05:600c:450f:b0:46e:1abc:1811 with SMTP id
 5b1f17b1804b1-477c1124ecfmr96352945e9.27.1763957103974; 
 Sun, 23 Nov 2025 20:05:03 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477aa387473sm141578365e9.4.2025.11.23.20.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 20:05:02 -0800 (PST)
Message-ID: <b87df803-930d-46fb-ad5b-454bdf1ee889@linaro.org>
Date: Mon, 24 Nov 2025 05:05:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/sd: Improve performance of read/write/erase
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
 <4eal54pkozivg367yzt76irxmxn46pjtexvbm2xl7qpbiyfyah@n6milralmryq>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4eal54pkozivg367yzt76irxmxn46pjtexvbm2xl7qpbiyfyah@n6milralmryq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Christian,

On 7/11/25 10:08, Christian Speich wrote:
> ping, I've not received any reaction on this series[1]. Is there anything I can do to
> move this forward?

My apologies for missing this... I was in PTO when you posted and then
it felt into my INBOX cracks :/

> On Fri, Sep 19, 2025 at 02:34:39PM +0200, Christian Speich wrote:
>> This patch series improves the performance of read/write/erase operations
>> on sdcards.
>>
>> This is done by increasing the maximum buffer size that is worked on.
>> >From 1 byte (master) to 512 bytes (first commit) to larger than 512
>> (adma commit).
>>
>> Testing on my system with fio I see the following rough performance
>> values in MiB/s.
>>
>>                read write readwrite
>>         master:   6     6     3/  3
>>   first commit:  51    43    23/ 23
>> second commit: 392   180   144/143
>>
>> Tested on a 2GiB raw image with:
>>    fio --filename=/dev/mmcblk0 --direct=1 --runtime=60 --time_based --bs=128k --rw={mode}
>>
>> The adma values are somewhat unstable but always >100MiB/s, I'm not sure
>> why but I guess it has something to do with the host side caching.
>>
>> For erasing the third commit changes the erase operation to write zeros,
>> as indicated by DATA_STAT_AFTER_ERASE in SCR.
>>
>> The fourth commit allows erasure in large blocks, to speed it up
>> significantly. Erasing 2GiB now takes 0.1s instead of 26s.
>>
>> Signed-off-by: Christian Speich <c.speich@avm.de>
>> ---
>> Christian Speich (4):
>>        hw/sd: Switch from byte-wise to buf+len read/writes
>>        hw/sd/sdhci: Don't use bounce buffer for ADMA
>>        hw/sd/sdcard: Erase blocks to zero
>>        hw/sd/sdcard: Erase in large blocks
>>
>>   hw/sd/core.c       |  16 +---
>>   hw/sd/sd.c         | 277 ++++++++++++++++++++++++++++++++++++++++-------------
>>   hw/sd/sdhci.c      | 102 +++++++++++---------
>>   include/hw/sd/sd.h |  13 +--
>>   4 files changed, 277 insertions(+), 131 deletions(-)
>> ---
>> base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
>> change-id: 20250912-sdcard-performance-b4-d908bbb5a004
>>
>> Best regards,
>> -- 
>> Christian Speich <c.speich@avm.de>
>>
>>


