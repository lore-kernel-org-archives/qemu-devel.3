Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611C6D637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfQF-0002gn-SX; Tue, 16 Dec 2025 19:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfQD-0002d2-UB
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:29:42 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfQC-0006We-Ch
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:29:41 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-349ff18445aso4312630a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765931379; x=1766536179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ih6ys6XHM7O9Qa024dWKHwivlgwlJayUzYMfjepNtGU=;
 b=RXY2uB37jzXTGSPHaONnROEraPVqRZLd3p5xMLlDhUnKRvcEiPv4eDMA+WNAees4oq
 byrzIqG8ipiyZYZTc/dsva0+rRqMmppeWMKvXLkBksRrdb5d9CUu4od1wKcQP+LN9g58
 opthJ6kKK3oJfwM8B/i1uiFKjlla94tWKopb8lB3ypg4v7/qRPnKv/+XYrM4pfR5q1Ec
 Hh6umo3dNcB7V26XkbEujQyY21WIxgASAuljgZkS+otRNh1+AZkfz4rkZaxZY01LFLrl
 Lf5qnU3jrMB9q38F6C4e59L0r8DPt/XL6fnncPiYb8h+aQ5MOYAZZSr91aPT5xCoOMzU
 Jh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765931379; x=1766536179;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ih6ys6XHM7O9Qa024dWKHwivlgwlJayUzYMfjepNtGU=;
 b=Htj/Y5pDIDwTivLhfSa7vcrFCI5xpJ4jYocOc/ANQgFNtn/BkxZZSzuxh5HYoNkSEq
 2KWJeuqGXlg2wxes104ykyDg2wDiBnvD6bAIjk1howLacmDxEYfzGh3v6S6CSY7A0WLj
 HDq82Hk2JtA8x4LJJZWW+wQmRW6trxGVEjUQu0KKjlAr0SHVl1dZnko4FhKAcUzXjKUy
 IUYq1r5cipxuY4eDx6Dtgbs5M+HjIT2tbNLt4BMiFDsY/b3a3Dc61TuSkmiPu0Drw1J/
 AztngvLOBLqqdeQQ6/8ernPImq4EpZpxraFN51wkvfSCZERkZRL3yd7g8R7EAgjOmgTP
 2ARA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcsAcRHu6KqhkpyLu1gc9g7C8G0yMt7ZLYRmnEbEL3WqWGU6x5JKcHXqVjO7K0s8Ql9RrTm/c2a5hY@nongnu.org
X-Gm-Message-State: AOJu0Yxk4ZlyyawQJPwj29QW+i0ZCPkW6Hv8Y199c26X77sjMOHAu94f
 +HQsmFQqIIvD3sczb9upg0bPwEfZW1hoF64HgdSJxEv/a0qLkoqopevb0h+oQ8VUvZg=
X-Gm-Gg: AY/fxX7fnsF3FcEiImMMZRN5mjvkzgmZncqSPMf6lhT0v5KhN/3kNlZx5Xh7jS+nRLV
 LqCzx+ICZ6YgF9uJ5SYuBF6BUshwNSGhl58d18h4k6xroLzDkWiOtTktZA/x4UPUfl3RIGWSG/u
 nnqQwcS+FBOlOb7Rht1P+50Q5chS1G8a5j1M5bLf7G837dUgT8lCDtpIbeTRPpfVHMGg/HlJVF8
 yDmznL713MM2FykNWVyTf0+TUR49To0IYCH9dhWOiFi7qvEA0PX7EqC8NptZTxZx4IQKo1FIibg
 qOGi/RdXSMAttPfEk4P7IDrd0foF5M4pKKGYug7ZuCvKgVRj/bmP2S227IYf7R/lhFy2C4YMhXI
 nmPJRW3kd+uoq042BpR7aWiizHQusKWst96pzzwj7cN7evp45tO7g3+GuLItRCO/JEs8NKWgFtQ
 /Hs5TA6i5HS+HuWHXBhPJDGsjEOvM2whaYhi2oQt+yUe6HbO1VeUEl3TM=
X-Google-Smtp-Source: AGHT+IEGlMj/BPyJPYEZEFUzuYUzQNkRu/85NhgWAPIehVjhkAwOExg0ptlQxUT3lxfobKcXDqjAww==
X-Received: by 2002:a17:90b:3e4e:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-34abd7a9571mr14784525a91.6.1765931379001; 
 Tue, 16 Dec 2025 16:29:39 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34cd9a40c83sm1071816a91.3.2025.12.16.16.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:29:38 -0800 (PST)
Message-ID: <b5ae3fd1-62cb-49b9-a85b-13b42dbd3146@linaro.org>
Date: Tue, 16 Dec 2025 16:29:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] configs/target: Implement per-binary TargetInfo
 structure for riscv
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-5-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-5-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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
> Defines TargetInfo for 32- and 64-bit riscv binaries.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   configs/targets/riscv32-softmmu.c | 26 ++++++++++++++++++++++++++
>   configs/targets/riscv64-softmmu.c | 26 ++++++++++++++++++++++++++
>   configs/targets/meson.build       |  1 +
>   3 files changed, 53 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


