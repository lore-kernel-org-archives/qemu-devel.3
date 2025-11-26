Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85DDD1118B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOJrw-0005gw-0x; Wed, 26 Nov 2025 13:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJru-0005dE-3u
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:03:54 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJrs-0003Z2-8b
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:03:53 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-297d4ac44fbso7058775ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764180231; x=1764785031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GA0m4hz/3ablOkOLpWlF1oJIwb+LkmnA6WNfABTTFrk=;
 b=N8/SmEGdsKj2+fhT4hBuQv/9j3flA1GkeaKU6I07V6LSg0TADuoCZO487/SOaCJeXI
 Jb3/kdqB33YmQ+0C4COq1rCIWuyAOT6wZ06bSwElKwDV5YVtMwBfdLojQaSuxwx6iLoP
 8p2EnnUtlslk32hjM+C2bbdCkagTRZUCHfQFJxDm0LE4GXRvp51GzNZo71yXKI1ACrgf
 EuDZsUNiXZohTrnJyzze6qzUjJSidMJomP+5MY2IzwxdYWWbwioIAzs3xTWFm1EcJOys
 Qzg+9sCjEoSVG5IZGJS9AgpgHAfC/Pvn5hZ2ftaBiDP6+gWnCn+AlluSGP3SXwQowQHz
 nY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764180231; x=1764785031;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GA0m4hz/3ablOkOLpWlF1oJIwb+LkmnA6WNfABTTFrk=;
 b=Q/WDYIFivo662GenmRxMe+M1d70H89d3f/lZB11wyIs++TgqPBQtsyg6ZYUIYpDj1b
 fP1r8SbHhBKNLu96ofuarM2btXmLv6IqDSAtbkImUulmFEt60V9+OYcPcntqTmSkDz76
 0iuIToJQwY+jeY1JA5udqtEF3ODNU3wyJ/rHbQsOgEnmmxDPbQR9CbvDEXHRXU61ihgg
 OWpmvbmWdf4J7VaU9d2S+yNE/mL+JL96MvOY0kHl8AffvQBlQElpcpuxbtBx6e4Q92s6
 jk1DgD+vyYmTicK+iqLJk2ReObFhneZgPzyaJp44KUNpsuyvsh3biJgSwkwV0H34nulD
 zE5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrUqDtGX3ONjn0L+Kd+eGXzyz70ElIo+8iRfwjcL/9HahRU++ExL5xk9OOTb3uLqxJROubVcWqSNIn@nongnu.org
X-Gm-Message-State: AOJu0YxLrf4S1RZRwj2BM+rG3we2D/mBE5xAvXoB4/1E16qT7uZdNFNt
 YF6zf+Qnpdk1GojS4iRfPwU/KRd7gWRLbwz4KJfYj4Abayg2pPMuMP3/75/0qgPCQ+UsBWgvnhl
 LKlXN
X-Gm-Gg: ASbGnctjxI+6ryBvJxfPyvTv58FnIVfgdA5P26CTomw/lh9aErlIQJh6iLSgAChnfj6
 OSSeR0KQ3mBv7Mhyd/jO9nQNbQhzYvGzgPmngJ+oTZ+MZzGPI8H3nMWNL0Q67CgCxnVRwESmEgz
 f+H/54z0b26dhq9Q2TcDG4wuWIjJvDGHdn0qBKH2vek2+dmGJ0vjsmB5KI6I1tROof7a1l3OoXa
 XOatMEz+BXoeX3Lopep8nAbZLarGyr1q33Thz8OdDvp0bS+wtIb065RGoigd2vQ9gcpeMX0J+7V
 Mm172B0nVejVe/z0q3vvyZ9goTM35KofHSv1J3/DynfqtcT90/leSR5xEtZ4w5Czei8csi+3R7O
 TBoRdfRW3XT5NkFuY7gK35sY0wdoa5oUbOVvdCuVjzDX+vbadImd4ezfCilynIPI78Z2wPDZP4H
 b/OcPH0207ATId+ogbgCfFCtu/xky4z++6IKQs908YGK3IB8w4fQ==
X-Google-Smtp-Source: AGHT+IE3pascFHOfbxKKMGeFVkAQYlBX4wsr5vKp09rKitl/KHsNJgXqPtCDnoWSOp7mHUZ6PNSkuw==
X-Received: by 2002:a17:903:2acd:b0:299:bda7:ae45 with SMTP id
 d9443c01a7336-29b5e3b884dmr238203805ad.25.1764180230602; 
 Wed, 26 Nov 2025 10:03:50 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b2bf9a6sm201626855ad.102.2025.11.26.10.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 10:03:50 -0800 (PST)
Message-ID: <566747ef-a2e5-4109-8649-44836a319b2b@linaro.org>
Date: Wed, 26 Nov 2025 10:03:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v2 03/12] target/i386: Use little-endian variant
 of cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251126075003.4826-1-philmd@linaro.org>
 <20251126075003.4826-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126075003.4826-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 11/25/25 23:49, Philippe Mathieu-Daudé wrote:
> We only build the X86 targets using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=i386; \
>      end=le; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Then adapting indentation in helper_vmload() to pass checkpatch.pl.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/ops_sse.h                | 12 ++---
>   target/i386/tcg/seg_helper.h         | 12 ++---
>   linux-user/vm86.c                    |  4 +-
>   target/i386/tcg/mem_helper.c         |  8 ++--
>   target/i386/tcg/mpx_helper.c         | 28 +++++------
>   target/i386/tcg/seg_helper.c         | 16 +++----
>   target/i386/tcg/system/excp_helper.c |  8 ++--
>   target/i386/tcg/system/svm_helper.c  | 69 +++++++++++++++-------------
>   8 files changed, 80 insertions(+), 77 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

