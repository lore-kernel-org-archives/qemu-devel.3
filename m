Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F68C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbemi-0000fp-EU; Wed, 07 Aug 2024 07:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbemX-0000b9-KA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:24:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbemV-0000s8-8b
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:24:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428f5c0833bso4601425e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723029877; x=1723634677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IPqe+CXFhO2XZAxvBuXd4awThYyr5aarDl2ggjn89LA=;
 b=wIm31cYLuKb1TkadztrN8CH4HShkfYna7aTs62ylfKti+qzoniC9rP1NPoGVTbuwjR
 9usBuUpO3tbM0SoMYoC22Qw3SVxN7JBFmfPnEVblwJwL8gbkfkCWjeCp1/Dq1QHekHEb
 OErvLV3KuBsoZn6cPR5Qh1i3Av8SxZZ5TXNCqxu+Pu/cnFgSs+r1WiaMZg4zdoEYGNnm
 WIavzLFZht2DXzSlDSoMQ0sxtEIbRnTIuCMVEq3x0bP+2uuUGSxihpHUBqyCZVnuRgZi
 HTEll2uTNdiDz0JpN1sLgxPdjZ5OothBr7Ch1x9vYOLhfc02K27/l9af8I1JEVDhkzqt
 UqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723029877; x=1723634677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IPqe+CXFhO2XZAxvBuXd4awThYyr5aarDl2ggjn89LA=;
 b=bR3GMPvA2+Mg/A215By0kA/XihlayfxS929lruACrzGGiYoE+bQ/czhioAJQjsPsPa
 yv0htCdQfHWTClXoiZdfygND7jitJx1b4CAypsFi5J05CnGqG0vkZ7P31ht3kjPt/ArL
 xApc2x5iN7hq4UfSvOeLkNBDBgoV9jAGn9kaKTMqOiMdOCwEI3+b9ZQLteTPEpEPsBRr
 +21FkcAqaXq4g/ARXkhGkj0eiM2IuTlpqEB2VZi7QH6w5WACcXoVy3UtdVlPE5/x0Emp
 DEVrBwHCnBzTqUN+pp4mz9ikWA4IehQpqo8bH3K1k6ZW6+0KMt6Tt8j54cSSBGfFHrgK
 yqRg==
X-Gm-Message-State: AOJu0Yya+tFb74hK3HMsyC3fgvVqm/trqYo5KoiT8xkh+sZWNjgn5myX
 xgfLoTEk+8pdlCfIr+MsuaF31wUH3T++Tm0iqcquvKKTBMHy/1Uq5Gxm6tXlC8M=
X-Google-Smtp-Source: AGHT+IFogy5EXaAOooNclOMyYB+PlFsenzIv+3GVO9vZbhEe/ZPWeG3r+OR5TIdd89R35Kp8F9H9VQ==
X-Received: by 2002:a5d:6c6a:0:b0:360:9500:9bbb with SMTP id
 ffacd0b85a97d-36bf0db24c2mr1417224f8f.12.1723029877214; 
 Wed, 07 Aug 2024 04:24:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd02884esm15485358f8f.60.2024.08.07.04.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 04:24:36 -0700 (PDT)
Message-ID: <ea6d7058-1460-49f2-967f-666650de1cce@linaro.org>
Date: Wed, 7 Aug 2024 13:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/23] hw/arm: add SVD file for NXP i.MX RT595
To: Octavian Purdila <tavip@google.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-5-tavip@google.com> <87sevhrbjm.fsf@draig.linaro.org>
 <CAGWr4cTPqtzEvbd5s7xfMOzid90Gje6NSTGw1qR7r=Ao0xeAcw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAGWr4cTPqtzEvbd5s7xfMOzid90Gje6NSTGw1qR7r=Ao0xeAcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 6/8/24 22:31, Octavian Purdila wrote:
> On Tue, Aug 6, 2024 at 7:06 AM Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Octavian Purdila <tavip@google.com> writes:
>>
>>> Picked from:
>>>
>>> https://github.com/nxp-mcuxpresso/mcux-soc-svd/blob/main/MIMXRT595S/MIMXRT595S_cm33.xml
>>>
>>> NOTE: the file is truncated to keep the email size reasonable. Please
>>> use the link above and download the full file if you want to try out
>>> the patch.
>>>
>>> Signed-off-by: Octavian Purdila <tavip@google.com>
>>> ---
>>>   hw/arm/svd/MIMXRT595S_cm33.xml | 224052
>>> ++++++++++++++++++++++++++++++
>>
>> I guess one thing we need to decide is if the source XML should live in
>> the repository as the preferred method of making changes or just the
>> translations generated by the tool.
>>
> 
> I think we might want to store the XML in the qemu repo, even if we
> don't use it to generate the header files at compile time. This avoids
> issues with the original XML moving, going away, changed in
> incompatible ways, etc.

Until now we tracked external sources with git submodules or meson
wrap files (see commit 2019cabfee) forked into our GitLab namespace
(https://gitlab.com/qemu-project/) at a particular commit, so if
the external project is modified, we aren't disturbed, or have to
adapt our source to update the submodule. Isn't it good enough?

> 
> As for generating the headers at compile time, I don't have a strong
> preference. I like it because there is slightly less work to do and it
> avoids dealing with resolving changes on both the SVD and the
> generated headers. For example, the initial headers are committed,
> then some changes are done directly to the headers and then we want to
> pick up a new SVD from the vendor to support a new hardware revision.
> 
> There are disadvantages as well: pysvd dependency for building qemu,
> hard to review if the vendor dumps a new version with lots of changes
> and we want to update to it for a new hardware revision, slight
> increase in build time.
> 
>>>   1 file changed, 224052 insertions(+)
>>>   create mode 100644 hw/arm/svd/MIMXRT595S_cm33.xml
>>>
>>> diff --git a/hw/arm/svd/MIMXRT595S_cm33.xml b/hw/arm/svd/MIMXRT595S_cm33.xml
>>> new file mode 100644
>>> index 0000000000..8943aa3555
>>> --- /dev/null
>>> +++ b/hw/arm/svd/MIMXRT595S_cm33.xml
>>> @@ -0,0 +1,1725 @@
>>> +<?xml version="1.0" encoding="UTF-8"?>
>>> +<device schemaVersion="1.3" xmlns:xs="http://www.w3.org/2001/XMLSchema-instance" xs:noNamespaceSchemaLocation="CMSIS-SVD.xsd">
>>> +  <vendor>nxp.com</vendor>
>>> +  <name>MIMXRT595S_cm33</name>
>>> +  <version>1.0</version>
>>> +  <description>MIMXRT595SFAWC,MIMXRT595SFFOC</description>
>>> +  <licenseText>
>>> +Copyright 2016-2023 NXP
>>> +SPDX-License-Identifier: BSD-3-Clause
>>> +  </licenseText>
>>
>> This certainly seems compatible. XML is not the medium I personally
>> would have chosen as a register specification language but I guess there
>> are no other alternatives?
>>
> 
> I agree that the choice of XML is unfortunate but I am not aware of
> alternatives, this is what vendors will provide.


