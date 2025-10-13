Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28683CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 15:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8KiJ-000714-1B; Mon, 13 Oct 2025 11:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jelly.zhao.42@gmail.com>)
 id 1v8KiH-00070g-7e
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 11:43:53 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jelly.zhao.42@gmail.com>)
 id 1v8KiE-00079G-KQ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 11:43:52 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-27c369f898fso60279265ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760370227; x=1760975027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrXMV/TPclJ2oNHwrYzf/NqliMCZdXD+QzV31j52NQ8=;
 b=C4KILe/uTX0Hh4v7u4HT9pZwUfMVlIGBZCag3KYd8mR+pvfmrXH48IS/II10EPvbjs
 XmJ/QwZuQhBi7pA00icnnlYtN473zg5m2TZ1An6zIpKFbZCyuPIbHZx6wMKywHIJ0/70
 zWrgfi0bpNyL0d5cHhQkTaKuYdXbM6u3iD06o2PMQi0SpA2TEe3xxaokU5FTHnlPHib6
 dDu1jz4it1h6xcfTE8UHZZrtYNefF6ke6wtdPcN3X74+afVJfSMIvA21BtVFvSny/DHt
 ZKjEE+KIlz4/JMypn1Wosod6vcTSwG7VDnyt5TvyjPnMDSqq/V2XN0D9vZnpouvLN8Iz
 KKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760370227; x=1760975027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrXMV/TPclJ2oNHwrYzf/NqliMCZdXD+QzV31j52NQ8=;
 b=WoujDL9bJQULG+442FcsN0LneARuAWvfJAfLzRNbUvHqWd4HQKKNnJuHCjVkHLqxCF
 XkLGiNTBr7djVRv+/F8jBZpgVxzNEGk1duW9e8g5rreLv7q2FdM6qOQoB8ADyPic2elr
 +l6rskGG853hsHGFT/HTMmdHnsWcD5HBCEqYPQG0q7YI6IszJMnrDAKzdZZXoN3OyADX
 R7c5LIxXFwFj+KLOXjC/cLXEsnFyYh+mc8oBNcPjOX7rOFCXtX0UGQdXGrMS9tFu0AJY
 zIYuAw6Dmuj3LY9zH3iBGSpeU572udPrfZSqrRP7d2CuSVQNzI0rkWwJvqb7Gez2WYfF
 cOJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9vPxOzRCOFNTvIwt39ymL53+Y+ZWxM+ngnLPOkskUqlSk09LbQAXgLwTiLA+W7ua4ifBTqyfOyg1V@nongnu.org
X-Gm-Message-State: AOJu0YwU1/ryVjCC+UrzDE/q20jeHoC6GZWmMcgMuOgPY9lhShCapZ0N
 /EDzb6h16gUFsqeZee8CX/2b3RCv2KR9Icfic01uvLw3yxhmBVRRtWj1
X-Gm-Gg: ASbGncurPbr1FYrJhZRXsMi6Wa9PY2vGTmxZkUe4exX8J39WQEOb1P5o9pkiNxkWIwy
 fXdzs6VwvEnwS2YKVSg8kNkl8MEzyGGcmCkGbQ3J32aXMuG51DHSDXODkb3Mh05BhMaJFCEyndZ
 HOIav72JTRJ5yHn+XJWVDan42TfLkdbWcT64oR8ael1LWK3CGR+O0Z9J3M93hV7ruvh1rQLDzMJ
 +q3xHPpWHMwUfZhKXnYkh7xJkwUaIydyXoC+XVca+ZVsq057zjtBFYz2P8iS58hK+vtf1AziqZa
 5ou1GQraAsNMZGsnJMsLR/rNGCOB5TJrAJUAcKsQmBA6xI79VaExa3NaoXoBO1fRIKgg3BrKScU
 RtcBVXfIQdvcbFG/3/ZF43tHZqSXChUskpxZIBIXhHGzwL9fKOao742dahjecJ/YnBK0lvbo9Xy
 fukrxN
X-Google-Smtp-Source: AGHT+IFia7eMzum+06Q7CowkYvu7/z2nQvX9Ip+9NuY4N1HVgIZHsomGjFFrMYugkKa7QTdg5lcOtg==
X-Received: by 2002:a17:903:4b46:b0:27d:6f49:febc with SMTP id
 d9443c01a7336-290272159d1mr282145305ad.1.1760370227425; 
 Mon, 13 Oct 2025 08:43:47 -0700 (PDT)
Received: from localhost.localdomain ([103.116.72.131])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b529cec1esm10041015a91.3.2025.10.13.08.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 08:43:46 -0700 (PDT)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Max Chou <max.chou@sifive.com>
Subject: Re: [PATCH] hw/riscv: Correct mmu-type property of sifive_u harts in
 device tree
Date: Mon, 13 Oct 2025 23:43:35 +0800
Message-ID: <20251013154340.1989427-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cca1b0f7-8063-4d53-88f7-a56eb56b3eca@ventanamicro.com>
References: <cca1b0f7-8063-4d53-88f7-a56eb56b3eca@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=jelly.zhao.42@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, 13 Oct 2025 11:38:48 -0300, Daniel wrote:
> But the documentation I found [1] seems to indicate that it should
> support sv48.

The second paragraph after the referenced Table 9 from [1] states:
> For RV64 architectures on SiFive designs,satp.MODE=8 is used for Sv39
> virtual addressing, and no other modes are currently supported.

And here is the same statement from [1]:
> The U5 has support for virtual memory through the use of a Memory
> Management Unit (MMU). The MMU supports the Bare and Sv39 modes as
> described inThe RISC‑V Instruction Set Man-ual, Volume II: Privileged
> Architecture, Version 1.10.

So I believe we should not try to support Sv48 for this hart. Hardcoding
it to Sv39 should be fine and correct.

Regards,

Zejun

[1] https://starfivetech.com/uploads/u54_core_complex_manual_21G1.pdf

