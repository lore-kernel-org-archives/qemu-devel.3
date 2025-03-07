Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62DFC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqerd-0002xY-Ed; Fri, 07 Mar 2025 16:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqerY-0002w2-Fs
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:04:09 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqerW-0005sO-RT
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:04:08 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so1228178f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741381445; x=1741986245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s7lIJgOA1tjiMK/XknTysFy21ttJ28wSLFCbPOi8VqE=;
 b=fSTF6UtXr9Oh/5sFc2imDZc+Bpxxwnp14r0i8xg4gtLbA4vrh/o1a+8qlT4ZeDgt0q
 pIobZg4WUsLcXsglca01GrulGJGiPVeMX/xrysiPOUshaXHUuMTU/GusQrggJrTr9CKa
 IUyS7DeItTLItKGlTDLGJBC7ADyCEOQ7hz8OBL/Mc46/IiAzhB9K5e5ekL/6HH4UPXhw
 sxeTJ6l3Cs3+DODqCGMUMQvGTUgAkPhOW3Lj+kRtDbwUi0Oni4C7QFI51iZMUEbwVyeK
 jl1hMyx67inra066VDmS59qWaqmFTj9gLVHU+Tb3OJh7E3DQXb2Y5V9IQIaV78sPSgQk
 yneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741381445; x=1741986245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s7lIJgOA1tjiMK/XknTysFy21ttJ28wSLFCbPOi8VqE=;
 b=Cnsx2yhUIZo19Zo/cXQvw6aCpXbxMYJpg949CPaXstH6P5OL6Q4Wdzk5lyL9fBG7rd
 2k8OT7HHVsF8TmhPjdQ15HlX9znYCvvZ59NmJaq7zQxRn2/PZITULMs0JaL58tj2QSWu
 JhX4zmDrH7FCu3KcLaaJ0J8D6iRyIFohMQc1cZ8IwiHflZVJQGqc8EJ88EPlbTi2wDmN
 D9N+RSdW1m7fPS/V9xs757HmRvKadz28Bo53S4HOoyh+Oe9Z4UvAdDxe4gQM6kHfOse7
 j3ZAQ0YZ66/0K/rzyKrkkfS9DP/W/zec1savmFWMN7YbQ9YGx4q+0mF1fXISkQIEXNn6
 leVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL2Nf4uVJncM0x2BoQOFT30P9LFWzDIfJ3NtE12CLaoUlL3Uu233WAXNZhb3YDCi9hrjy4+PoF9dLJ@nongnu.org
X-Gm-Message-State: AOJu0YwbET8WWi2DYQzrqRaM6+9kkJEbGjb7GedO26OQ3H9ZJzVtJhqS
 xhs+WL/9f7ieT6qXfo4vfBeokU1CcLDQ3ZOD5uTqT8rk4Wlie4a9lpmnLLxQCS8=
X-Gm-Gg: ASbGnctnWGfAHWCF9me7BcwKAb+iNbxK7ba2KlUG4WsCOB+DIRQfpBjEM9hl5xokopL
 ONonvq0cDQ6d6lsEacf4GzHpXVWoSwqLSa31pkyToeV8QQAvGXIK/sSxvkwHL3F0VgwvriShR7W
 5ssIiRuG8wMjBnJttANDOjf15IseFbZfHsNkc0WLlYyP/zTzufTVlwrL/8ZqJUdYwxMxSEX8VsD
 xX1Uc5D4eORLMTWlirvoiKMg8hkUiBne0bFTUQKDEGHw6xAqROoWtW01LMarPUEn1GWTwW1SMtM
 VQTyYsIgwysZgQQpJiEv3rn0XJE0cWo4ok8qzEt3Eihgh4t4gWbiqdnxfdojmn+cAs/H/jqnyeP
 hDkI5ks0cdZGU
X-Google-Smtp-Source: AGHT+IEHmJNHvM1w44v+C92puTP3sQXrQ3+Ct5w1xj+tmPdoOze0tviwD10Rz14zJ1VGNl40QZCaXQ==
X-Received: by 2002:a5d:47c8:0:b0:391:2889:4ea4 with SMTP id
 ffacd0b85a97d-39132d06142mr3560982f8f.9.1741381445333; 
 Fri, 07 Mar 2025 13:04:05 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cd62sm6359734f8f.46.2025.03.07.13.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:04:04 -0800 (PST)
Message-ID: <4eab7108-4e57-42df-9141-b213327395af@linaro.org>
Date: Fri, 7 Mar 2025 22:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/20] tests/acpi: virt: update HEST and DSDT tables
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <c8f4dcf726b8813f00c917062184ad3348edd647.1741374594.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c8f4dcf726b8813f00c917062184ad3348edd647.1741374594.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/3/25 20:14, Mauro Carvalho Chehab wrote:
> @@ -1,39 +1,39 @@
>   /*
>    * Intel ACPI Component Architecture
>    * AML/ASL+ Disassembler version 20240322 (64-bit version)
>    * Copyright (c) 2000 - 2023 Intel Corporation
>    *
> - * Disassembly of tests/data/acpi/aarch64/virt/HEST
> + * Disassembly of /tmp/aml-DMPE22

The other path is more meaningful IMHO.

>    *
>    * ACPI Data Table [HEST]
>    *
>    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>    */


