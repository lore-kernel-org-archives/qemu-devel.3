Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AABE6C619
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 08:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tION4-0002A1-LH; Tue, 03 Dec 2024 03:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tION2-00029Y-W4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:35:01 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tION1-0004Dd-0H
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:35:00 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53df6322ea7so8946825e87.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 00:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733214896; x=1733819696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cXhmZFZ2wYMPP+KqgqlRsWgRPB4GDgQF4G7WusQflsQ=;
 b=zPvIHGYOJgidxX+kjpcP9skSHJYnIzQ6e2JnR51HlnHtb18oQBN6dW9qoaGzEoGsbV
 jN7Q6y4+L6W5InUWRzhRFqGAjuLFBMVCmehmHxBzQqa00yoKCxhGHcIZNO9qbc+GBX/v
 NR+O30n6z+IgDiIfFHje6u/7jPlZKsC5JZD9c4L3E11OVHE2X7drueozOccFp/yhItJc
 NSrOCMdYKjUWvoFXHgCUWeM699zDu/P1CrbZzX94o0dHU6dmUpujcOBUkyHrJoFho9qU
 PNdBtYttpUPrs+Vlp0CP+Qi5Gstuv6U5cvmsF1DDROu8/+qg2e/7PtmQpVBmZE0xsgaI
 b+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733214896; x=1733819696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXhmZFZ2wYMPP+KqgqlRsWgRPB4GDgQF4G7WusQflsQ=;
 b=KHzb/K1L1kvfirUqoGjJEJBJ2/o7BHlC7vd6YiOGhZWlW5P4qcHCpGYHQf67xOFIxn
 pSSUooJoOOQkHCXmkrg5tLWJ13LeLpf0xh6rbM5wD+Gwa7mvOQUvKqGEb4HFNiWf7qn2
 958T6t++yvotjrH6/pGIpkiZPDEujcDwAY+FPAxRybp08mGQCoSVZqxfAyxsesDayEEg
 nn+UIipeR4A1qkXvg8yp2MEAqc2HJR5UHueJNuTNKaLIWmnBp48DVURCyP/+S0l9IyCq
 lGnFcuFW7s+v1qkOesvgk8AkG4P355L/9ZlH2FVHZs2V7jJ4a3zCECh5AjEOmAQXEvYY
 KwjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWoZHawoKOU42dJyCMz3N/CKpvLNwQl+oQv7IWhSP3Ugx85B7t+FtMEaMK2sXbWKkWitj64v0+nChV@nongnu.org
X-Gm-Message-State: AOJu0YxC6O2JnPaGtWpcdOOeoET6B1tJ6/lEeuH+5Hq0kGQzXQBxjt+x
 GQk1A8dujkcTIILM8FlJfszLnc/4aVX2kAbYPC0kheSuh+uXEmZAfHNbE1HyeJo=
X-Gm-Gg: ASbGncvuwbvzABzQaphA4877OR1thsPKaXPlNcrrQhtVSJ4199gA/psTQhXIOijgo+a
 CrQgkYjfWaNAUq/EfzCfJvBgxfyW7aaRgtysw9zEaERTKbj3m5rBg11Lpj6A/ZM4jZ4uwcqMJZx
 OzHOn3aB9XML3LM7d+oj7l38UJB8K+1mKOWWhJInYAJPLN+cr5EiFmMjjX0rSHsFHeokSHycuzb
 71h5oC0CKnFHLcvMW94xS/bTAoR79qR47o3ON6/r1ihTKde++UM/lbBXWDuVdPZkw==
X-Google-Smtp-Source: AGHT+IEp5PD/s5FHXnCMuKVRACbPB1lyzPEVVbrqWbkx8pZZ0+aLxfEQK1fdpjpBv8IHv6dvoqfwhQ==
X-Received: by 2002:a05:6512:3d26:b0:53d:dc3c:2595 with SMTP id
 2adb3069b0e04-53e12a319f3mr1274219e87.44.1733214896329; 
 Tue, 03 Dec 2024 00:34:56 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996c19fasm587299266b.34.2024.12.03.00.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 00:34:55 -0800 (PST)
Message-ID: <6d74743c-d79a-4bc5-8c82-fa35bdacc469@linaro.org>
Date: Tue, 3 Dec 2024 09:34:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2? 0/2] tests/functional: Fix tests failing when TCG
 is not available on macOS
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241202204020.55665-1-philmd@linaro.org>
 <9c4408cd-5fee-4242-ba6b-ebf2bb680d83@redhat.com>
 <50f8076d-aa90-4b47-884c-ac3937ceec89@linaro.org>
 <ce9fcfd6-b196-4dd3-b42f-e5f3c5beb37d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ce9fcfd6-b196-4dd3-b42f-e5f3c5beb37d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 3/12/24 07:11, Thomas Huth wrote:
> On 02/12/2024 22.01, Philippe Mathieu-Daudé wrote:
>> On 2/12/24 21:56, Thomas Huth wrote:
>>> On 02/12/2024 21.40, Philippe Mathieu-Daudé wrote:
>>>> Explicit the QTest accelerator to have these 2 tests
>>>> pass on macOS when only HVF is built in.
>>>
>>> Could we maybe rather add something like this at the top of tests/ 
>>> functional/meson.build :
>>>
>>> if 'CONFIG_TCG' not in config_all and 'CONFIG_KVM' not in config_all
>>>    subdir_done()
>>> endif
>>
>> I'd rather not:
>> - these tests don't need anything of TCG/KVM/HVF
>> - we can run functional tests using QTest [*]
> 
> Ok, but then please switch to "-accel qtest" instead of "- 
> machine ...,accel=qtest" since the latter is legacy and might go away 
> sometime in the future.

Doh I thought it was the opposite :/ Sure!

> 
>   Thanks,
>    Thomas
> 


