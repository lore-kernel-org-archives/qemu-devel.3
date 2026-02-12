Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C142EEA871
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 23:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgUU-0007Nt-6n; Thu, 12 Feb 2026 18:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vqgUS-0007NM-Gi
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:52:56 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vqgUQ-0000vs-V9
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:52:56 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-824a829f9bbso233698b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770940373; x=1771545173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mLGnl55F8MS5uHcq4883ZK81ujru+dmWKeQb1Fy4nVg=;
 b=sPq8ft94a6wBhgwqQuAGHOEE1jks82alIZOaYXQBYB5TBU6oGSzT8fZ3KjBNvBBs8P
 H8eOwGEyIfaFXKJv/YTLsGGN1ybwAf4E+E3fF6UaD0FOVfRgobE/PQ+RheFlZSmiQuzk
 64Sq6JI5ONnzpVZ0i8nbEoa2n0r6VkthzoxF9q8Ii1dkMF/7xKng0rgghIcnqMazxP+2
 1Rv23e7oGqkN7JtOVY4aRv8OaTU/YxmYnmgtXdtk4XIjioGv18w496RKFHL2iDj3Jj6o
 Z0vVh+lpFJWoM7NADcZq9G7FloFGL+GYrK0F2GJl/mHO2/isFzqYZz6C28EN+vAL7dxn
 YjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770940373; x=1771545173;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mLGnl55F8MS5uHcq4883ZK81ujru+dmWKeQb1Fy4nVg=;
 b=blmT4Rr8u6/jxx8K57DvEC346kWeDdNCcYNpZ1KjoSgXu6JlbAkHcjmRbbN7d9vkbn
 ucQYxzQ0NHy5njgcOtbLH9h0sMkYBBIxw7Qyr6ml8g6kwJyQ4SYTLV4EZaaT/QshqCln
 QLxq1TrYO4j5DJZlnG8c7B1Xc3ePNgTfgQ1hbgbi8PRpbyKpthLCRr7oDvb00dzvxctU
 0Gy/60djXg4jeaWVizSrwQry0y0kJ6EJRzUOR90DtzN3Z6h3X+QPRi4YYwd25C8ww9BD
 Z8DxfRsqM0zJqFyKcVUb5DmTrb+/vonzkyC1tLwP10hfvbRdTjmTMf2+gacwzntuzVYj
 DNCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfmMDNYs74uhKjKc07SNva7pkxhucduCo3KZQ0cU1KJ8yBpnCIAP2ChV0ZAtkrUcVlTzIJleB4KEfS@nongnu.org
X-Gm-Message-State: AOJu0YzuAUlHtTsA2in8NmotZwxdteWJZfjGRDvX2jee0lrftXeFvnuB
 6jHi2U2LEZgPB3v82+q36TQbGnXo30Ok9a9Ynmf8pCLNCU2JJB5p+FgQE06jkW8w3r0=
X-Gm-Gg: AZuq6aK4lFmg/ijNEF+vkYdQKekWcUpv2cFfQGh130hX3hNf32YL/0+5ihjbiHMiGhZ
 tWiqZEpRmGzHB+HmyCpUPPa2u965gRqnxRSNI4z0AoQFwfxg9z/H9kYTtoQ3tp/s/QiSSJANVOz
 paxMElgftsDZWd8IfRyIu/nu1Ofgk/1xn004fokXoDHhAZrzWU6zrVZZlibqbSEQI/bpY0gvxnb
 sAll+ZMj4wTc5PejcVGNVN6PL09u9qzdEmGmD5DTlUge8fEY2gchlssp1qX8YKp7vf6xFU5nmZ2
 1ONZ+4L6hHd7gkNxE9jxz4lbm2lhV7/AnaCMq+kGc55TxEbN6TKuASAcUamIkgzupf23GxALwfD
 +XEG1jZGz/DSeriansWslghBTzAB7/NtvGwXVDstAMj47CuiNaX5NYQM98HcG+TQuvMNuUClVJQ
 ShyDNC8nl/xh4PKGdG6AO20YDa/VnJpsk/FEtoOZUsaZaZR2lIM6V8/o5yVf5HjE6JhLH+ySYmy
 h6CVlhYpAxd5l4BckUmFChp
X-Received: by 2002:a05:6a00:21d2:b0:823:172f:f0c with SMTP id
 d2e1a72fcca58-824c95bc931mr127973b3a.45.1770940372803; 
 Thu, 12 Feb 2026 15:52:52 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:f2c8:acbd:3db6:14c6?
 ([2001:8003:e109:dd00:f2c8:acbd:3db6:14c6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b9528esm402195b3a.48.2026.02.12.15.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 15:52:52 -0800 (PST)
Message-ID: <998e5fe3-9f13-416c-927f-f037eacbc0b7@linaro.org>
Date: Fri, 13 Feb 2026 09:52:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] Hexagon (target/hexagon) Introduce tag_rev_info.c.inc
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
 <20260212033435.3598-5-ltaylorsimpson@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260212033435.3598-5-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/12/26 13:34, Taylor Simpson wrote:
> From: Matheus Tavares Bernardino<matheus.bernardino@oss.qualcomm.com>
> 
> Table that records which CPU revision introduced or removed each opcode
> 
> Co-authored-by: Brian Cain<brian.cain@oss.qualcomm.com>
> Co-authored-by: Taylor Simpson<ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain<brian.cain@oss.qualcomm.com>
> Signed-off-by: Taylor Simpson<ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/tag_rev_info.c.inc | 61 +++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>   create mode 100644 target/hexagon/tag_rev_info.c.inc
> 
> diff --git a/target/hexagon/tag_rev_info.c.inc b/target/hexagon/tag_rev_info.c.inc
> new file mode 100644
> index 0000000000..ed7fb68aaf
> --- /dev/null
> +++ b/target/hexagon/tag_rev_info.c.inc
> @@ -0,0 +1,61 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_TAG_ARCH_TABLE_H
> +#define HEXAGON_TAG_ARCH_TABLE_H
> +
> +struct tag_rev_info { int introduced, removed; };
> +
> +static const struct tag_rev_info tag_rev_info[XX_LAST_OPCODE] = {
> +    [A7_clip] = { .introduced = 0x67, .removed = 0x0 },
> +    [A7_croundd_ri] = { .introduced = 0x67, .removed = 0x0 },
> +    [A7_croundd_rr] = { .introduced = 0x67, .removed = 0x0 },

Any reason not to use enum HexagonVersion?

r~

