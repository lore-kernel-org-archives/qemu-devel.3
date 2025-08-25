Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A487CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTr8-0003mJ-PK; Mon, 25 Aug 2025 05:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqTr7-0003m1-06
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:51:13 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqTr4-0001dI-5r
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:51:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3c7edd71bbfso1629705f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756115468; x=1756720268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GRGNyw4orMeu0KGkqhcsF9EvE4ABgISS+prpghx0NVE=;
 b=OSsgttt9I3WJs+LdALjsEWnpdwiDTpmSo98hafF3q8wLXYa3nYO9eVaQEhUdTixEUR
 XosgTTb9U3aIH99amgevCGmj5WInx15JSpXLWcI83XfuX42bNbpOkf6io62iXYOSD686
 MEQR4zXOwG72cMtxLSvrmQFxD8HazZpb6JqeWhNOuTGAxwb7rMWfPq8hQk5FJr2YjUTx
 ZjRzgOW8RWe6EhWXXOV4hftsa2tbIwW3M6e6uKwm1UOYFpx3rfVO8KDbONIrCJlXZq/8
 a98uX0hLQ9UX5+o2CIjN7I/EwdBkKrCABkTiyF9axhYpfX2rcBwog3xtOlSgY+/Dgodr
 zNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756115468; x=1756720268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GRGNyw4orMeu0KGkqhcsF9EvE4ABgISS+prpghx0NVE=;
 b=o5zsWlPK7TbXQdh805MXW4brt0YZqPHm1M3wQyuW/H2lbRWGsNlm+X3WehxDloEvQf
 yp3JLAcksRgMZe7BZFVfdjEzLF/Dz7KLLmHI2XByH6d/6hPbawr2ZRFCOD80sD69AP6W
 0SlQf4wTjEkmFHq1j3g+wfss93SNVrO4FIuWdR0RvgwgNwIiY0gVxN9aeGTdienc5nid
 q+IpuYYGdYA/lWJPOiKPEcCLqV6bIk4D9EXSZ21mbqhQ/NnuW8Dcld/uXTgv4L3fDO2z
 6pD54zgzfzukPMt+m6eNg+OjnwnS7+7PecBRrC3k/1GVxdFnwWK11K/4w1MD+sA278pM
 W64g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHdMtP4B3gv3tjDxRyFpd4DuhN+fyMcsppb0YFkYKNWVa3RsGeKjDhLDB53QpK6IKG4KzfK+yxpV1P@nongnu.org
X-Gm-Message-State: AOJu0YywrT2rQ70DR9kylmScbNsBFY3kYS48jn6Wz1dUgY/va7q1FC1y
 wzvauVeyNa444jdTaBA2mC/3yVOyUNfkhFjIH2jIfgYuZ6gskY6XTWE7pHNWsJRNvaXmJz4qE+m
 JB1Qv
X-Gm-Gg: ASbGnctAvj5sV6HcKbPmvxlwTTCrwE22jk6GOWlmnUPLMa9GJS9tRXYCRC31HXNY/wK
 wJv1DnbFiivaCYdi/1tnRJpa/LMtFG7XCbArONe+5yi4dMsAJvtFbW7oMPFFKC9yN7pGdaoGXBj
 Aje2h3qcnAcTjaU3TGPDAj4T+NQvsUu5CAhwJXXzNB9u50Jpri8tg2pKE+z+A0sOMsNtQBrF659
 BJlYl8zmbmN0gfEVuVHdw0d8D54ZpyPQuEfC71rCyv0ODFhBjOWtqbVyNwhmjxVd2Wtl4V2ZRG0
 /yN9ongCdlnVi7akk7syuo4yqQPi/4PWFxqWCqcA++i+Bx2Tzz28BJLTXyktFsHPO1lJV78Cj4k
 nURnuz7i1KrQDUpe2QVTKKNZ9Q/2dFB7lC3HMa6/m61PApJ56SeitGEf+imG9rjZ9Lw==
X-Google-Smtp-Source: AGHT+IHSw2S5aSVuOGAXlsC8S4vrX+OJSSLXFl3qYdK0ZZF2bQfEuCx0BMVZPZ7jsdgGFGo4yCzAJw==
X-Received: by 2002:a05:6000:2a0c:b0:3c6:c737:d382 with SMTP id
 ffacd0b85a97d-3c6c737dc6fmr7314295f8f.35.1756115467688; 
 Mon, 25 Aug 2025 02:51:07 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5747sm10741910f8f.48.2025.08.25.02.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 02:51:07 -0700 (PDT)
Message-ID: <f30dd13f-7657-460e-89ee-ce2f958fd2c1@linaro.org>
Date: Mon, 25 Aug 2025 11:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] scripts: Add helper script to generate eMMC block
 device images
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <c8ee22c72a87c6bd8d9495995868cb22a633de41.1756019920.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c8ee22c72a87c6bd8d9495995868cb22a633de41.1756019920.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 24/8/25 09:18, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> As an eMMC block device image may consist of more than just the user
> data partition, provide a helper script that can compose the image from
> boot partitions, an RPMB partition and the user data image. The script
> also does the required size validation and/or rounding.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   scripts/mkemmc.sh | 185 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 185 insertions(+)
>   create mode 100755 scripts/mkemmc.sh
> 
> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
> new file mode 100755
> index 0000000000..5d40c2889b
> --- /dev/null
> +++ b/scripts/mkemmc.sh
> @@ -0,0 +1,185 @@
> +#!/bin/sh -e
> +#
> +# Create eMMC block device image from boot, RPMB and user data images
> +#
> +# Copyright (c) Siemens, 2025
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# This work is licensed under the terms of the GNU GPL version 2.
> +# See the COPYING file in the top-level directory.

We now require SPDX tags, otherwise LGTM!

