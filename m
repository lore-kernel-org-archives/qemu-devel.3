Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B089C36013
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGT1-0002Fb-Ir; Fri, 28 Mar 2025 16:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGT0-0002F0-3E
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:38:14 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGSy-000484-63
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:38:13 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so2239475f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743194290; x=1743799090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Vx/SoGC0OGW6boIYJrEoBkvm6+g9OKZ7RxROdG3QZc=;
 b=obDfYt9Je9ZicnwPSQ7nH6yjYAEsqhZYjfPH/2l/nOWLQ93PjfKLWp4ktIkYd//KDe
 Ig1DGvYgTRHYD3IlnhPsdlgN+6GIm5O08ZgO563RAOXUOBdgI4iq/eqycWOZCH7rAdtl
 nDElV8kluHNNQjjxBpf0Yakq8b3og0wpqxJxq7zfVek9mUEiKpVBhZJV1LjyB7g0m8ue
 0kRkV+ToVdalLSMwHs+NfGoKx8MuIFWZ8WzU9sQOuFqrm5mdwLrnElc/fKCASQfPbCV9
 3rG2FNDBb2/+7oPqrJmSLtuPwlDDh7Z/SI+qpCllhV/HTP0NxRquMMIDd7u3rvCr+H9y
 2oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743194290; x=1743799090;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Vx/SoGC0OGW6boIYJrEoBkvm6+g9OKZ7RxROdG3QZc=;
 b=XFu10lNp2Xn3MVC4e1HzsbQOGVLZ6jVuFbgDVoz54TH8Au54LqRBo1lsfEJyE8lJqs
 QUgasN8BsgtDZ8y+CIYQLiXrnRjDWGl3fsGRqY4ZDSxuf71zQ7ssXiIi7Cv7DDgc1f7f
 gSB8wSPUAZMLog3Qz3RMBOJviU7v9jC/NSzWo5nwT407TpamDU7IDOWiONpbuJndAt3m
 zVwIYhort2ZvrlDqsiRIjYOZkk0a4g11Q+v2FDfT9abrtHgYrDOwBBno3TIaks3icrmR
 LqFqzfGH9y3yWUPY4I2kPG1/Aa99u+Nf0JwdBELenM/aylce4hy4ZgYoLHp4cU1UGLnl
 dQGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzF3H1GI/tV3zNXezWLCoxbX2cQIO2JFkM6W6DrT8Ko18vnnAQyx3lnyGNkdP6nAUknLBfH6Gkk4fa@nongnu.org
X-Gm-Message-State: AOJu0YwBAVSl53xSVpi6KMtjMSLrjsJFS/r1Rm6INRD6ScU0rqNyIwud
 lECV87CLXOx0QpuqdntyPuyWwYroR4TCWIntMORckTBapROgGvlwG1B9l3BQtsA=
X-Gm-Gg: ASbGncvSMsgCcXdLM38NujLU2vsgw3kxVGzJ4b4PC+u3G9VuBhPipylIzds7FlYUfWy
 yRS5/SBYw+mVFXxgZc1e8kkI/GQjsHekXMrkOyoO1D4ceR/+mJrdoy5tVh2MnRkr7MI6nGGEkpQ
 znjlStax3jw30U99JGN2En/pKyKHrjVhB/+L++UXm9Q2FysZ1WnQ47mqZWDnhfoYGnWaoS72KtH
 q5RaFP+vAPIGMP3fbQ3xTnhbusXHYGsII0EBidTtDe5s1MPMmgLz2bsohBys066qyhO838saOA8
 1iesPxVQrfL8I/3msLl5j8BGK8Bk6MsbUV6SbHU0L2F7B+zyriAb5Jt6cksPiZHAIYlAggDFMxp
 +Cf5n3XGu8OO+
X-Google-Smtp-Source: AGHT+IHofG6NGPQ8y6q67UPc+Kg8173B0obsdQPWwkZTaB7R3ZzqYuOUm+oKW3+NX30d1CikQfE2ow==
X-Received: by 2002:a5d:47c3:0:b0:39c:e0e:b191 with SMTP id
 ffacd0b85a97d-39c120c8e0amr376835f8f.7.1743194290259; 
 Fri, 28 Mar 2025 13:38:10 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a9d2sm3617197f8f.43.2025.03.28.13.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:38:08 -0700 (PDT)
Message-ID: <26acd91e-e9d2-4b04-8158-fe0fd0c530e9@linaro.org>
Date: Fri, 28 Mar 2025 21:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] include: Add a header to define PCI MMIO functions
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, schnelle@linux.ibm.com, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-3-alifm@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328190627.3025-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 28/3/25 20:06, Farhan Ali wrote:
> Add a generic QEMU API for PCI MMIO reads/writes.
> The functions access little endian memory and returns
> the result in host cpu endianness.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   include/qemu/pci-mmio.h | 116 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
>   create mode 100644 include/qemu/pci-mmio.h
> 
> diff --git a/include/qemu/pci-mmio.h b/include/qemu/pci-mmio.h
> new file mode 100644
> index 0000000000..2ef92455b1
> --- /dev/null
> +++ b/include/qemu/pci-mmio.h
> @@ -0,0 +1,116 @@
> +/*
> + * QEMU PCI MMIO API
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_PCI_MMIO_H
> +#define QEMU_PCI_MMIO_H
> +

Missing:

#include "qemu/bswap.h"

> +#ifdef __s390x__
> +#include "s390x_pci_mmio.h"
> +#endif
> +
> +static inline uint8_t qemu_pci_mmio_read_8(const void *ioaddr)
> +{
> +    uint8_t ret = 0;
> +#ifdef __s390x__
> +    ret = s390x_pci_mmio_read_8(ioaddr);
> +#else
> +    /* Prevent the compiler from optimizing away the load */
> +    ret = *((volatile uint8_t *)ioaddr);
> +#endif
> +
> +    return ret;
> +}
> +
> +static inline uint16_t qemu_pci_mmio_read_16(const void *ioaddr)
> +{
> +    uint16_t ret = 0;
> +#ifdef __s390x__
> +    ret = s390x_pci_mmio_read_16(ioaddr);
> +#else
> +    /* Prevent the compiler from optimizing away the load */
> +    ret = *((volatile uint16_t *)ioaddr);
> +#endif
> +
> +    return le16_to_cpu(ret);
> +}

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


