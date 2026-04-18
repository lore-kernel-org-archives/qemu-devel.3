Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D3F99C9B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEDxl-00083I-EX; Sat, 18 Apr 2026 18:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDxS-0007tb-PQ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:16:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDxP-00083R-Us
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:16:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso20123615e9.0
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776550566; x=1777155366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fLmLmFSRDAwknWcYloo6OfPzyQDkibFSRyljJRY4yig=;
 b=B9/LPjsqOy1SFxQFhR5bYiz+RIfB7X7E585u5V8RtGwEHSMibgA6RTMIYO8+LYN6Ty
 WItxs4K/eKwDoLrXBwGlJ58JopKah+3blRsV1bMDCf2pDlrBP11U5cXasyrxaRnNgEKm
 A/Ek3KKhlhqY7h28dUm3ZQvN1o98DZpgl0gdU0/3WJnn1M85x787GBqpW1Ztq8xXxrM5
 G0yvAEyB2t6IatDkf/4HHbKVpQDaA/6ZRVboGLTUNUGehEll/CNunZL9FzuK4baU7d5J
 uAVDu12ehf5sqXu47gXP+Ynx+LJ06JdgQGGgF6R3NN3WkpuoacST1JotrM5LZd++JNpT
 gzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776550566; x=1777155366;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fLmLmFSRDAwknWcYloo6OfPzyQDkibFSRyljJRY4yig=;
 b=o9WnlnneCM63gaLdQmUXoRCZqH2PMvpopBCXuFaIAuGJxM9aZh+fp2W87J/9PB57fw
 E2VrtpzyvANLYiuO/hMh4C+0/CxAR59rEo2lwuRW6mds2aWkapD6neVL+ZnGPHgdvrXz
 u2UR77xksldS8+S1+3TL7QDL1V5di6wJ+3hQyLPQWxlEhTBmohAoE6watKrYVMbVDz8v
 5b2Mzmw0ZSQuiZ7CKQIhtriG6838p2ZNoI7aHcqmz3v+PTrbb5rtkhEhq+qAEQEMBIpM
 I3dremAD82b/DQ6t3Nmw4yT4bMXoahD+csSa3/AGloQputs2QkMHtbSgv4fABeuzC1T9
 qMJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ekYivmCqUWQLf4dbXdquBz1Y3+fXjDrSKLOthfjQFjFw5uvbXHl+ceJDrXk7x7Q5t2z+AYnt5CYEW@nongnu.org
X-Gm-Message-State: AOJu0Ywt6dVpt9qcuYR62paEtXE0jZdXQoMfmeQLeZZNwiYNw2zCS9fi
 qylCEYID6dhrJ+Nd72EFYov53TRx1E4FDxZ49ZxZJoO1py8d+iKW+eFHeASivBazl9udER2Mene
 LuvdsHJI=
X-Gm-Gg: AeBDietFSkUQCZow4ll7LIJKEehidPqs2w60b0k7OYXBCzy0shuTraYOSaEOAeUKnoH
 2lkGQYbdWU02ZR5/S0Gk4LyXvffS/LQEgpoYOEc9Wym2y5CWoIvPY39o9pmFqn26maW52m+6ZPJ
 p3crc5CnsdWI+Egl9F9ip0VN74xk3WXBQIIZFZFBk1Y/7gpc2imm4RoQAuxJFJo6s1q60KPcTe8
 qcFkgInb7vxL4UxCtNVeHdIItS+2zJyxHNmQ9SoTtym48TQurTWGYWMzdDQfaI4MdVEQ2BV+lwr
 gPdJbcEGpzLfz0Ex3GGRbPuTlJjcA5rwo45ch2DvpnAo61JAZRbI3nyyr+tts+BPgJVgi1++z6T
 DZR8+gAufSVqwByC2Fdtq+D6uchwliNZU0m429DyOHX4dqoOLWDTdh4M0CEdfxgL6Rdf9F2ciFs
 4sWRa33W1gwRGbVXBNJbCSApWWAfcDDQyVBPFEyfrHdPWYg3Lfgo7Q7VFRZTQz7rjtr47sjZdC9
 JdP
X-Received: by 2002:a05:600c:3150:b0:488:9fb7:376d with SMTP id
 5b1f17b1804b1-488fb792ce4mr121122025e9.28.1776550566299; 
 Sat, 18 Apr 2026 15:16:06 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c96b4sm259981395e9.13.2026.04.18.15.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 15:16:04 -0700 (PDT)
Message-ID: <4db2d1c3-a5ae-444f-9432-bc0f9b085776@linaro.org>
Date: Sun, 19 Apr 2026 00:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] hw/core: Update docs for
 get_phys_addr_{attrs_,}debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-11-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417173105.1648172-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/4/26 19:30, Peter Maydell wrote:
> Update the documentation for the get_phys_addr_{attrs_,}debug methods
> and wrapper functions to state that they can handle non-page aligned
> addresses and will return the corresponding exact physaddr for them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/cpu.h            | 16 +++++++++++-----
>   include/hw/core/sysemu-cpu-ops.h |  4 ++++
>   2 files changed, 15 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

