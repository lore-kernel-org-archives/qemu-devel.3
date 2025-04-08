Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AA6C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 15:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2AbU-0007S5-G2; Tue, 08 Apr 2025 11:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2AbS-0007RW-6p
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 11:11:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2AbO-00079y-5Q
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 11:11:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so4770679f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744125059; x=1744729859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ppVzXJk+5s37uuANspQDg2GcmOMcJQDWWGuWyALqCEc=;
 b=zkIGJpNCtPPMRaqtE1HHWiHNGvEz4BLwToHUjHcbbfADcd0QYkRdFWnHHkTHhMbpw2
 naWB72wt09fPU9tDGGNIAq+auHQJ1TI0iJ+2WLQ2SHRcieQzkA5/dP8ogRiL2EWJROny
 a2OsukuzvrNNTFVOgOdrEgcKV2IYP9c7SnORpfYpo07l/djEoRaiNpWh6NUslbJzCEt7
 CBrIQgXMWy85lbBA7lgR4QvzgCj1362aTsMuSFfQ0arngZcfr5lvjDuq0ZJyWuWo0pUf
 FS+39hmwhnbI+xPwfB8TpMAb7JAZhwq1NdM8Z+8I3ITG0QOssfRAHJhQWyVOghqwuIGX
 ShJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744125059; x=1744729859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppVzXJk+5s37uuANspQDg2GcmOMcJQDWWGuWyALqCEc=;
 b=PFJ1JobzZ6kfl+SmtchOdim3gUccCnGy5JLYOnx9JjnB8jFD8oPqvI8aiG5CgFQ5FY
 2vxd6yDpPLdAFsPGYPGGpSlaXpdMdigTBpSxBU7c99N1lrfpFUeQcl/QDk4y6kvxM6br
 zm7X2s3Gnin/Sdzs4Bevs8uwgEoiEx9Y+DKCszXMp32wtdGkAeKSdIJEMBrdahDlDp9F
 wCvROz/bCdg7f86NkQhskiE+vcTtOIyot7ckujllsBcafx+DsZJcP8pZqhXKV2flaFtu
 pMuZ4anqbT79L9VXhQU+MtTFyYVZbLL7cwHrskU1dJsZwyQrxim/y2z4egARrQ35Bnae
 Bf0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXedZqeGdGUwvpoBXxr3c2dF1kpyXZVf5I8m4bhg+ikxusbQWFEAQmwulOjGFFUq80aq/6Z4yOd2e/h@nongnu.org
X-Gm-Message-State: AOJu0Yxto7kC5ozD3pMxkcSwxoKsyXcAq7AFeePovjiTBUw4qqVhIt/y
 rcJa92ej5JYiwLwcn+yw+Woo/Ra3CwBjs8vWQErcFDgdaNLous/CrdEjc1JSx2U=
X-Gm-Gg: ASbGncvCd9al6/s89NJyPsG1WzWbX7SAC0Nu1zFpbydD4ae38GVBddQxeOZdKspNS/H
 Sc8u7wqByoDZuZvtFZtYciEwVEmoUg7TyA9pLPDpD8D2XwojmUZb0LPPIBz1Bxx0zKVo+DZEhpr
 iJ66UPpj0pC2M6Y1tjpThOAjUQrqJmfDBHldtS4elerQalqaJCCbk0eycoEvqVu/vSIJ7YulkS2
 1cwW07/qSwyumpBi6vUO/OWj8VEWwbUPYxzZDmVK5S1v8Ln4py4At6r8Pu1o5xeaq/vcOFH7epw
 slWD55jwxEDnWIF+UFLOF0GrZ/CNWcWtoV4WLG78NvxyxVtCUm47w9+MzfZODyeR+qVE9asFkIW
 ohF00XRwZaia3
X-Google-Smtp-Source: AGHT+IFzTIJlNg0dcJiGCrM2sc5tiP9OMdwL3d1Hprqr1jTrQqJM03OARI8cs2sMEtXmsY6cBCubQQ==
X-Received: by 2002:a05:6000:420a:b0:391:487f:27e7 with SMTP id
 ffacd0b85a97d-39cba98bb36mr13827860f8f.55.1744125057932; 
 Tue, 08 Apr 2025 08:10:57 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16f1a73sm167565835e9.24.2025.04.08.08.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 08:10:56 -0700 (PDT)
Message-ID: <95411eba-7da2-43e5-98b6-e9f920490aef@linaro.org>
Date: Tue, 8 Apr 2025 17:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cleanup: Re-run return_directly.cocci
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org
References: <20250407082643.2310002-1-armbru@redhat.com>
 <20250407082643.2310002-2-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250407082643.2310002-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 7/4/25 10:26, Markus Armbruster wrote:
> Coccinelle's indentation of virt_create_plic() results in a long line.
> Avoid that by mimicking the old indentation manually.
> 
> Don't touch tests/tcg/mips/user/.  I'm not sure these files are ours
> to make style cleanups on.  They might be imported third-party code,
> which we should leave as is to not complicate future updates.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/gpio/pca9554.c                     |  5 +----
>   hw/i386/kvm/xen_xenstore.c            |  4 +---
>   hw/riscv/virt.c                       | 25 ++++++++++---------------
>   hw/scsi/esp.c                         |  5 +----
>   hw/vfio/common.c                      |  7 ++-----
>   plugins/api.c                         |  4 +---
>   tests/qtest/cmsdk-apb-watchdog-test.c |  6 +-----
>   tests/qtest/pnv-host-i2c-test.c       |  4 +---
>   tests/qtest/stm32l4x5_usart-test.c    |  6 +-----
>   tools/i386/qemu-vmsr-helper.c         |  5 +----
>   10 files changed, 20 insertions(+), 51 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


