Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB653E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 18:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX2Wv-00018T-F3; Sun, 12 Jan 2025 13:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX2Wp-000182-Vo
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 13:17:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX2Wo-0005Kk-7o
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 13:17:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43618283dedso34923255e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736705856; x=1737310656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tJlrmxxKy8QK2Sqqisic+Nnsc8wfC643ue6qLvSCilA=;
 b=mGP/OP2RLB3buzfOvQQuCXt9upugUTneISDJpCmAUCQEXOM20C72eMO6AhbDQRC2t7
 HjnpCtHl2vC6u9GjmNkgQSYMM2wFOP/jzbIaV5huXzAAzdGufsN1HhuxYjoyO9C12G5h
 LcNMQmLJC4apkZ4TE+7/IhWDGH4q245zplXCb9MsYzWzCy4t7Ak8nwrwb3+SwEtQq6DL
 doMLZnCNY2Dxm4/exlqLg8CDQjFAA/tsXo5wDzcwvgX0YbwoIcd/DwIFh9JNhv25McD2
 XbS3QtfVHdU7yAA91VNDAkSZ96TYGH6dnM3OlEnGkif8GiqiTLB6mW13Ounn6r4zYDrj
 vz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736705856; x=1737310656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tJlrmxxKy8QK2Sqqisic+Nnsc8wfC643ue6qLvSCilA=;
 b=p8e8eVfBoNammdW3gd+kkFA/bj0lIyxyBKBlYHEq9L7fWWogR89gfnH9bCQ5wV4tMB
 /jnonidksOklhoGeFGAvV4FOsYWOnI5HPjzDFr1QtxO93csu4MJPLdvESaHIEJfmqS+K
 1NZPyfPVHCB/IyQ2DgecNaDW58oFb6sRXG94+WMoKe/Uy3zfLHw/rGCGR0V8W4dBnjw7
 0ZU/iDtFqUqHsqOi0mipohSvY3asuJzEpHqkQ8rSE/60yjuuPcOXi4YgO4ZICuXdb61M
 VPoWV99ePFHsa8PSXKzZMm/n2pkMd83nbHdEGG5YSrwKieL4DjK3xGPevDChHNYhoKnO
 wtXw==
X-Gm-Message-State: AOJu0Yw5igz69qyh+eD7XM9LwDUfFRJbq4JqqbCw64r+7JqjmelwK/4f
 jUIbje+DZmT7UTpci4CZl0xl0NOFkbCLYD2nDQ1B2RkEOz7dQsElcqiOlZdPpc307cTgV4hk5sC
 lNsY=
X-Gm-Gg: ASbGncv9zvb3ip+tMg9fEVtf5T/pCshF7TXbPovtWt+VSAdxsT3s4GeW7bdqVO69aia
 SdKtSnt6Hy6fzwZ/KXgPWdIMQ+adk/z1WbA7Aqo1f6nNODcO/fD5umlWimuDKk3e5Ixl7Yy45rF
 Qqo7SPtV00FQEQFmniyZ/yDoR+k3Csx3aNigQ6WUPgh8CoygXy6lbMlWSMOR7ybaO/8jsYNccfE
 72boXbK+/S3cII+rPwdqIV+jUy3UIFYxLiCh5+UMIg+CTDwi6i853j9Oh3e6AUg58jeLTC+BPPI
 HbdJNE51gJOtpKufbuL78OUG
X-Google-Smtp-Source: AGHT+IHN89+e146YDxlRJDiq3uknj4ECO+8iPX9olNdsk5FhIqEj7Jt2mYnmVGcoi6qLaHzRqWBupQ==
X-Received: by 2002:a5d:47af:0:b0:38b:dbeb:63a2 with SMTP id
 ffacd0b85a97d-38bdbeb64acmr1417724f8f.55.1736705855626; 
 Sun, 12 Jan 2025 10:17:35 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80besm9988954f8f.83.2025.01.12.10.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 10:17:34 -0800 (PST)
Message-ID: <821300ca-47f0-4de7-a7ce-a49aeb0d3dbd@linaro.org>
Date: Sun, 12 Jan 2025 19:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 00/19] hw/net/xilinx_ethlite: Map RAM buffers as
 RAM and remove tswap() calls
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
References: <20241114210010.34502-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 14/11/24 21:59, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (19):
>    hw/microblaze: Restrict MemoryRegionOps are implemented as 32-bit
>    hw/net/xilinx_ethlite: Convert some debug logs to trace events
>    hw/net/xilinx_ethlite: Remove unuseful debug logs
>    hw/net/xilinx_ethlite: Update QOM style
>    hw/net/xilinx_ethlite: Correct maximum RX buffer size
>    hw/net/xilinx_ethlite: Map MDIO registers (as unimplemented)
>    hw/net/xilinx_ethlite: Rename rxbuf -> port_index
>    hw/net/xilinx_ethlite: Introduce txbuf_ptr() helper
>    hw/net/xilinx_ethlite: Introduce rxbuf_ptr() helper
>    hw/net/xilinx_ethlite: Access TX_GIE register for each port
>    hw/net/xilinx_ethlite: Access TX_LEN register for each port
>    hw/net/xilinx_ethlite: Access TX_CTRL register for each port
>    hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
>    hw/net/xilinx_ethlite: Map TX_LEN as MMIO
>    hw/net/xilinx_ethlite: Map TX_GIE as MMIO
>    hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
>    hw/net/xilinx_ethlite: Map the RAM buffer as RAM memory region
>    hw/net/xilinx_ethlite: Rename 'mmio' MR as 'container'
>    hw/net/xilinx_ethlite: Map RESERVED I/O as unimplemented

Series queued.

