Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E311CC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDiv-00013o-Hk; Wed, 14 May 2025 11:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFDil-0000wP-JT
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFDij-0004Vw-F7
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747235312;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbuRFuKD5JpjQw2f4iee9uAmZP1oYGiVJtTJHjTRBb4=;
 b=bL0zhwUEHFN6hLzP04IeGJuCmwcfGwy/Ht+QdgswP78vAIsV7PiCxd636yGAsZ25TUTYnm
 bjVDNdtEcMb4yVc2zMJUywtyBm4thAuCyLT9Bkn8q+NiThgmCiIwqsh1EMwu4sbjkyj4KZ
 UlLWGPj8AVSCLZwCuClwxdPECykaEOk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-k7ppG5ZoNDCOL79TfzRz0g-1; Wed, 14 May 2025 11:08:31 -0400
X-MC-Unique: k7ppG5ZoNDCOL79TfzRz0g-1
X-Mimecast-MFC-AGG-ID: k7ppG5ZoNDCOL79TfzRz0g_1747235310
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acf0113e311so657558866b.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 08:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747235309; x=1747840109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mbuRFuKD5JpjQw2f4iee9uAmZP1oYGiVJtTJHjTRBb4=;
 b=YcYo4EqjgQPOyBaBaBzjW1q+NJic8Z9B4qWnHddCO2JFrQ9sbetd3w8YyVz5QWD43G
 B49KHKHhp34hu3AXYy3PKPYQfXnQRj8C5aP9DuN0Smq2c5FygeezQ5pRY8yQI0c62sEs
 sQEuct2ecy4bz2QoixhiiJAhJvRR1PYd1BChErChgZDYFaNLXIZRaiOGiisJmCWzLur+
 +RM2DD1eDMwOAu+8izfVR/PYojlFkgMFkUqPSPt4Sw9GUTh/kYF+iUaJ+GhNsy7nSe0B
 WoEu3b5+btWrFJJ88iP1IBFqtpL6lX8Do6ExM57NujW53v0wDO0De/LLyQJxITMY2JA2
 PwLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXdoSt5I8c1mD8Z+Iw+HiIOJ/gcJ8kTAvgzm1k74fq6qDr31T77wZiz/OD+kyttL+vCq3uvrUWD0WJ@nongnu.org
X-Gm-Message-State: AOJu0YxN9WVyM4tbSnJ+8DHGn1IDrUUjwD9b6XRF7Nx+FxiXLKi82Sh9
 HiFw3qo2VpjxqANOYYQw+TRvpBcu9xgn1roWH4mhaicPHkxFhs0bkhAAtEtC/HLYkLBQzYH+Mki
 90BkI4ORQ3Li5GO26GwY2oD2mRdp5puy7dxNmI18B7kNBVjmd4rAh2dQ1LHp5
X-Gm-Gg: ASbGncsuJEil5vQ4GUr400Z3oJM5oEKCoEFnrDL9zHL2/y/E5cNvO6fqJ0A/3aCbpBZ
 VIW72Y2LcdX1ylK1eUYZ3A7i7kPTMahXX4lLu1eqp4JwU+40hTXpxwXX6rl+jPyeOD5HQWYbCAd
 0iTOGKHohJoUUvZOQGfr2b4BQKOWOnyhdtOLSVRMNAf9ZtwU3OUwj1LHR1PeRMken6El4eA7BCk
 U6yZZdW1Ysn9Bwq6FAc0n6KJHthApX2tt1Lucvl7iec4i3uKaZIqxLU055SAQLos6TyYVivYPRk
 JlhiYjRo51t8Pe7o2+kSkHXw3sYYJkmVgIDFxhEkBO9/3rD+Q3J1Ihyhi68=
X-Received: by 2002:a17:907:2da9:b0:ac6:fcdd:5a97 with SMTP id
 a640c23a62f3a-ad4f751aceemr350800166b.48.1747235309001; 
 Wed, 14 May 2025 08:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWuSv9/zfPHqoWNNm06AVsXh/VAzx0R1BskaTdoOty31H22/F/jMydZXd2oUtfyetk6jO3jg==
X-Received: by 2002:a05:600c:3b02:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-442f20baee4mr34112625e9.2.1747234896892; 
 Wed, 14 May 2025 08:01:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337db30sm33725535e9.11.2025.05.14.08.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 08:01:36 -0700 (PDT)
Message-ID: <3f1c89a5-5887-4761-84a1-366dd9ef7fc2@redhat.com>
Date: Wed, 14 May 2025 17:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/14] arm/cpu: Add sysreg generation scripts
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, agraf@csgraf.de,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250506085234.855779-1-cohuck@redhat.com>
 <20250506085234.855779-13-cohuck@redhat.com> <aCNwKBDtJES0GX3q@redhat.com>
 <87ecwrckfc.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87ecwrckfc.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Connie,

On 5/14/25 4:54 PM, Cornelia Huck wrote:
> On Tue, May 13 2025, Daniel P. Berrangé <berrange@redhat.com> wrote:
>
>> On Tue, May 06, 2025 at 10:52:32AM +0200, Cornelia Huck wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> Introduce scripts that automate the generation of system register
>>> definitions from a given linux source tree arch/arm64/tools/sysreg.
>>>
>>> Invocation of
>>> ./update-aarch64-sysreg-code.sh $PATH_TO_LINUX_SOURCE_TREE
>>> in scripts directory generates target/arm/cpu-sysregs.h.inc
>>> containing defines for all system registers.
>>>
>>> [CH: update to handle current kernel sysregs structure, and to emit
>>>      the re-worked register structures; cpu properties will be added
>>>      later]
>>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  scripts/gen-cpu-sysregs-header.awk    | 35 +++++++++++++++++++++++++++
>>>  scripts/update-aarch64-sysreg-code.sh | 25 +++++++++++++++++++
>>>  2 files changed, 60 insertions(+)
>>>  create mode 100755 scripts/gen-cpu-sysregs-header.awk
>>>  create mode 100755 scripts/update-aarch64-sysreg-code.sh
>>>
>>> diff --git a/scripts/gen-cpu-sysregs-header.awk b/scripts/gen-cpu-sysregs-header.awk
>>> new file mode 100755
>>> index 000000000000..b6b207e3c0fd
>>> --- /dev/null
>>> +++ b/scripts/gen-cpu-sysregs-header.awk
>>> @@ -0,0 +1,35 @@
>>> +#!/bin/awk -f
>>> +# SPDX-License-Identifier: GPL-2.0
>> Invalid license name here - hopefully checkpatch.pl is warning
>> about this.
> It might not check .awk scripts?
>
>> Same issue as in the other sysreg script in the host CPU model
>> series.
>>
>>
>>> diff --git a/scripts/update-aarch64-sysreg-code.sh b/scripts/update-aarch64-sysreg-code.sh
>>> new file mode 100755
>>> index 000000000000..721f41a9a516
>>> --- /dev/null
>>> +++ b/scripts/update-aarch64-sysreg-code.sh
>>> @@ -0,0 +1,25 @@
>>> +#!/bin/sh -e
>>> +#
>>> +# Update target/arm/cpu-sysregs.h
>>> +# from a linux source tree (arch/arm64/tools/sysreg)
>>> +#
>>> +# Copyright Red Hat, Inc. 2024
>>> +#
>>> +# Authors:
>>> +#          Eric Auger <eric.auger@redhat.com>
>> Although its fairly short, this still deserves SPDX-License-Identifier
>> to be set.
> @Eric: do you agree on "GPL-2.0-or-later"?

Yes I agree

Eric
>


