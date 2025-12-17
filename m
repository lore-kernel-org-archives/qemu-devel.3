Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C716D609D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfI2-0005Lo-S9; Tue, 16 Dec 2025 19:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfHz-0005Ig-08
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:21:11 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfHv-0004rD-DW
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:21:10 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b8e49d8b35so6124934b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765930865; x=1766535665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=me9Y4ZiIf8VN0b7bhRbL2IyOr0U40SOYM9sqKzlDOPg=;
 b=dttnSlBKDlRE2EV1FJqTwi2/S3Yr98V8MQTMRqvnHXjhxTrYM5l449zeDlSZqELaaK
 emUJTtJM+aBzBUT2h5yaoJ80GLnAaH553cgO4WHrD6J/lsB/Uby7zHuvtVf3swM9cXBo
 NzClDfLIATKrFJUYEiNxlDUkEx1Pm9z3+APmauVcrIUlypQg6PE4ZlfOUKVmZ4qTGPJe
 7+QSHVKtXkDZaNo/VYP6skotaJh1UbLA2xYaeWouSKJEJ81EtR26mtDlblxmg+ZAM3TR
 kCk6Qh7Bjf+SL16M/dO6SKiojyxYsxnuzKIl+eG+v5+EciMk2A/EDwv4GYoWgvqTjBXQ
 U9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765930865; x=1766535665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=me9Y4ZiIf8VN0b7bhRbL2IyOr0U40SOYM9sqKzlDOPg=;
 b=ABS95zTBfso54ragTnkBGvA/KtYhFDWv51X6v3CL0lYzEtJZzO3HaS5H4idEPZJO4g
 7qHF3UHZo59VQDXI45vx4zdp71KI05ObHJ237IyVIVANz/BKX4lohrhk+3guiJDVpF0M
 QHHthwYxphwN7VtUOrFLnanjxr/ixZANhIfmHayKy637FLwaegVfViHF1ltG5EpQYl1p
 2SyIl3l7xa94AKdPOpXgTEz71dq/A299LQHc26REQT/fY68E1+BC+3w6gjCo4ivo3Sls
 /4ysutPcyI+faWGSL3/bXJXxqW6eao4FUDi+W1S2I1v+qeXy4BFZfLrzsSDRRu+dbUHS
 Oc6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFukUtlMPBrFltx+24qx0L3VtpPCPxqeSoeHyRwP109fDmUl6yR9WDIXb866op5siB+/jHxeDgz9UV@nongnu.org
X-Gm-Message-State: AOJu0YxjDMWMM+xaUiJfF0XEHIFZcf3iucVPN58SS79wdV4PgpsCezXQ
 LPQSjdo0XeXC/6AlVtUNGA/EPVGhhbN/DGID1//bTI5wPbOFBiqoNmLH+l2PONZVynI=
X-Gm-Gg: AY/fxX5xdzUanyy/cAqAhMR3nStAjbSaxEDWozIh/cIKBUIr1Ha9SA2fsQovYcsgj4V
 w3PLkl1JUbyv1WLFBQXZvKlB43HMn4sF3Ha2btQFMbbToxLGbtPl071EstE3H3MT0fbicJtYzYX
 p9r+YdXuqVuud/8+aGDO9b89aHBfPrNOt+6iEfhe9LYrOstbsSd+9+C91Uly4lw3W6eS5Zbo8zc
 FGTwFIj10MzK7guDxMAEXPxobNb5CEjf3ZIykrlP+p6xISu94kgmjc84q+5c0beVYLVUwjZ97Pa
 jnzfPFqRRkH1TvX+DDtavmnl4HMN9u892eEj6Z/pFjWv4QbCaUc18J99lkuKLoHkp2HKfMM8yIA
 JIBjcxaDsRLAHv6Y+ld13A2zlUrviNF/3HBWGTPq1V4B4u/LvXQXX3rAeG+S8fE3hema9/hEvM4
 1S9TJKfevXfpKDSli1NflnCQvlJ07VzIkIpF7mAwoSlKPkAFwTSvBL5a8=
X-Google-Smtp-Source: AGHT+IHzYRg/Wrr4UAwd3ZYDcPJTJbGkio3SapUI7YpcfGwuaKiM8OyfuO5n38cR+QbckF8mgqj4Fg==
X-Received: by 2002:a05:6a00:4c86:b0:7e8:43f5:bd24 with SMTP id
 d2e1a72fcca58-7f66969fa0amr15226152b3a.57.1765930864636; 
 Tue, 16 Dec 2025 16:21:04 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcb874276fsm731417b3a.10.2025.12.16.16.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:21:04 -0800 (PST)
Message-ID: <632336d9-0863-4976-b787-6b3aa99b567f@linaro.org>
Date: Tue, 16 Dec 2025 16:21:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] hw/riscv: Register generic riscv[32|64] QOM
 interfaces
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-1-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-1-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Defines generic 32- and 64-bit riscv machine interfaces for machines to
> implement.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/riscv/machines-qom.h | 20 ++++++++++++++++++++
>   target-info-qom.c               |  9 +++++++++
>   2 files changed, 29 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


