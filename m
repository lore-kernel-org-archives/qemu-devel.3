Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62208C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcsas-0002NY-DL; Tue, 28 Jan 2025 15:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsaq-0002Jk-7s
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:53:56 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsao-0001RZ-Lw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:53:55 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2167141dfa1so1098145ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738097633; x=1738702433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EdYR+g3RZySNqBRj2P+MBIC+Dp11IBEcEZZWpWgjeRQ=;
 b=QockUr7+kZ+gutPM1ddaeYyp1kNWh2076BpVeKV7nx1yf48kqjVj/LAtH8SCyBadq1
 KEOn73UxiVIa7XDwHYFxyTRZbnGT/Tg0MpSZO94R+ta3ARJstGMHazWoIvISnuEsV50v
 aK64EZwgLNcZ6D51UEMom3f4V/xZ8m+kpJ6n87jmNFTKTSHTmxF+QXp5TG7irlYVbljo
 kvu9+W7Z3o61o0Z7SMEUqgnQeE6hOwC9M5mRSZVd1Qy1dVCM4LSBiIF3h2O++Sf2Gt8J
 Tzn8cGxITNoLfBFKILjUCoTljq8uEpnmI3Tu9kN7lBp5Ha0FsVh1eZI0U5tHPOjq5ioh
 WcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738097633; x=1738702433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EdYR+g3RZySNqBRj2P+MBIC+Dp11IBEcEZZWpWgjeRQ=;
 b=j2ez3QZfgaptTEZCJERSYw53q2Lla0cT/zG/ePfP4/ejQP/XOyeDluFPjwF5ZFKgvb
 ZGf299MTQRqGfbGeriNwB6a+exixzCb6X8bHCqmShFagNHz8AijQoaFkAaW/poePyWxf
 0SRauytS4z/gydroEUnwulCPaef5y1PY3hscQ3n/OuHL/LZ1ypkzWJdDOkPlTfC30hep
 rmWs57nQLwg+FwByq+oWqTKwnZMC3U6IJ7fJlDwQ8Q/gzqhfmyRRFi8ie73atBUQqtLr
 Rv36Imr8p8hja+ra4nGgumLGjFvf48zo3ZxWJ9GESu63tXzJduBHWi8N6F4DVEmZO9Ik
 3HJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiaQxSbyTZFyp1gwBZ7v2hyPPaRm2RCEEFKlQmi5N5sOVMDEUYj4FwCjH/NqVqSKwBWaHbadWwTBwP@nongnu.org
X-Gm-Message-State: AOJu0Yw5xphq48GOa+0Adul7DctThw3pLR13+vh8rT+Xvs2NJAGWNc4D
 l72OHl6FmqJBoextuoYb1IjHgY4xJ+O2M/8v3xvxb5WWa62mplKQoZIvfc+nzhQ=
X-Gm-Gg: ASbGncv+aK1Wq4ltdM0Ct2b8hHOQk3txBNs4k+wXjf8+I9loCeQH33CSOKA4OGzGt6g
 d9gTs4thfZQRDyLKkx/e2yhCAvwKBMmOc1NaiviCXQz+MX6w17HPgMnx3E5uEQdgRgmhHd6H6q8
 Epm1nMD6kIOjQL5Tew8DbZ+UghbZJ5zMdYQoKdxtGfiYV6LCCU0YWENCfxESGIxNhpO/i3XyqOz
 a2IQmbPP13YmHfs+faZAzHO+DhTWmLGWwMs9DkZ+fqRnCqENfwCba+ep4rolz6Qg5GZxnTLGq7g
 JC0o1ky2eNjJLUiY2ItRiu2eOcIA3eL1w9W9x9L2MDLDRGpqvTTY5CxuFw==
X-Google-Smtp-Source: AGHT+IGT3RYwq4TvBuMp7Yb1ABeHTb5L2izZWLlG8mrwmQfObeRas+wAp0zgDA63rMhcPAFSml9DFg==
X-Received: by 2002:a17:903:2445:b0:216:5db1:5dc1 with SMTP id
 d9443c01a7336-21dd7618768mr10778945ad.1.1738097633229; 
 Tue, 28 Jan 2025 12:53:53 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414ef91sm85718885ad.209.2025.01.28.12.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:53:52 -0800 (PST)
Message-ID: <81a4e102-1eb9-40af-9c8c-beef06204390@linaro.org>
Date: Tue, 28 Jan 2025 12:53:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/9] cpus: Only expose REALIZED vCPUs to global
 &cpus_queue
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> cpu_list_add() was doing 2 distinct things:
> - assign some index to vCPU
> - add unrealized (thus in inconsistent state) vcpu to &cpus_queue
> 
> Code using CPU_FOREACH() macro would iterate over possibly
> unrealized vCPUs, often dealt with special casing.
> 
> In order to avoid that, we move the addition of vCPU to global queue
> to the DeviceWire handler, which is called just before switching the
> vCPU to REALIZED state. This ensure all &cpus_queue users (like via
> &first_cpu or CPU_FOREACH) get a realized vCPU in consistent state.
> 
> Similarly we remove it from the global queue at DeviceUnwire phase,
> just after marking the vCPU UNREALIZED.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   cpu-common.c         | 2 --
>   hw/core/cpu-common.c | 5 +++++
>   2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

