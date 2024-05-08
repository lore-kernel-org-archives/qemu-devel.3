Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BE5C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4iu6-0006Ag-8K; Wed, 08 May 2024 11:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iu3-00069m-3r
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:08:19 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4iu1-0007Js-D0
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:08:18 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a59b178b75bso838340766b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715180895; x=1715785695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sBfztSU1Xz8JnczzZBO/74iMyU3fwntHEQoamPACL2Q=;
 b=nPApDZcDCd4hq4rNkq7DVIkHuimYc1ctEy6faGoA5lQJrTB62ZWHD9P+mGdQX13lRq
 iFbWCbQvRDuR8oAEHjEHw/f34nhSgCltss/B79Kfxk+vb2fmbGCaz9pVdRNPfYNZk0fk
 g4hRFyMq1dRKB0y66bJytAARxTqg3hOp2lWoAr2IjBrOq1+JdhSkY8Hrtp0t2/lLwPwa
 F3ur4VZvo+IfELoyYLWh6bqK/q+VlwNx+umt/6WwM1FaHLhdKIWc9bBGdqdMgZRXcd98
 2UFPvt9Rd0mYUNEpL1ddk4n94MnCuNhuIdeYl65jezN3KaD8SRWx2gCl/+m5ROPixOCs
 nPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715180895; x=1715785695;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBfztSU1Xz8JnczzZBO/74iMyU3fwntHEQoamPACL2Q=;
 b=fvKa+pxc9R9agWVbtpMFpV6iPEScW/A17J9BlZU4OcM532zoXhjGv4bhBJEx0uaPqG
 iEGxBAT2yqQqbI2580af/0lNy9Dt5wfKyoD2kOa/lk1M/64vPcI1oRSCQG2m1EV8SWkF
 XE8Cpexe9mtQPiwg93vvoK6Mko32mIKRdD/1pWR0O9TivtsnLQc7nT3eMR+r/rsbzbCO
 Ho+pa+xeGTaoFTq43NZXfps265+F1zhVf8zLqtIleI8bVQOh2lTIxCSQpdN04CGurZvt
 GaibYVLa13qrwn+eBOt3Bjgh3aag8fjCxGfhWg8PiyT4qJ5pqWo/rudBjFyPPT5qmeUA
 nJ5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCWxIUxenH5EgT/dVeUdycRon882X22IDwA/4ejDRgZG3DvL4L/e19Rs59ezj7rkME8SZAVzJNnDNihzKecBIWQR0yJ4Q=
X-Gm-Message-State: AOJu0YynzNZAp/ZpxXJ+B6cEK46N/IlqLArsF3AogYiDDhGOtRWj6O4v
 +49VCqKCER+ap7IVBRpKZyblFdoNgg8u4ZmOCBbxjtY0130wlLVkDSFew4Xwnzk=
X-Google-Smtp-Source: AGHT+IH8esw49twUyjZRB+6P01f+2ZOwSdYzxipW53jOWUaRtstOKHOvXsCbVa3zQoNQc4PEc0mxUQ==
X-Received: by 2002:a17:906:7f8b:b0:a58:c80e:edd8 with SMTP id
 a640c23a62f3a-a59fb9f1250mr181221166b.70.1715180895381; 
 Wed, 08 May 2024 08:08:15 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 xh9-20020a170906da8900b00a597ff2fc0dsm7113951ejb.69.2024.05.08.08.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 08:08:14 -0700 (PDT)
Message-ID: <5a73992e-0c7a-4f38-b78e-5df0d146134c@linaro.org>
Date: Wed, 8 May 2024 17:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] hw/loongarch: Rename LOONGARCH_MACHINE with
 LOONGARCH_VIRT_MACHINE
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240508031110.2507477-1-maobibo@loongson.cn>
 <20240508031110.2507477-2-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508031110.2507477-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 8/5/24 05:11, Bibo Mao wrote:
> On LoongArch system, there is only virt machine type now, name
> LOONGARCH_MACHINE is confused, rename it with LOONGARCH_VIRT_MACHINE.
> Machine name about Other real hw boards can be added in future.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/acpi-build.c   |  8 ++++----
>   hw/loongarch/boot.c         |  2 +-
>   hw/loongarch/virt.c         | 19 +++++++++----------
>   include/hw/loongarch/virt.h |  4 ++--
>   4 files changed, 16 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


