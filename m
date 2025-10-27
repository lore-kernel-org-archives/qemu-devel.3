Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AC9CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJhF-0003UA-LR; Mon, 27 Oct 2025 05:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDJhD-0003Tb-LZ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:39:23 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDJhA-00088Y-ML
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:39:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so26348135e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761557957; x=1762162757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L9Gkw6WeDhF1XM3MrljCsuR7+7JfXHtFQGXbhULjP0U=;
 b=QZo6YiD60MSNYSNrcF4foRwyAgevPBUZF7QUkDezMKi9O6FJpaZ2IUyYG97TUTCPSH
 AoX3rkHAHOG2IY1oDmqQYAw7tX99iqU52VQdp02VftGqVd+D1CzYOpiJRqQgh8+tYKE6
 m/ffkku+vOgtXoRVRuM5gUyP9KIpQtVf/Y0+Nigk9vK02FeXxdd2s+V1nC5dLz9XUjoe
 2jnsgpJUQfxvrfg0hHsuZjYrepxkjMhuzgJhpneYXhUhFb+OYSKcbuoZ0SKjO8YBGMez
 AOuoboPbuySH58Aqd9oZIBZtQGqC4oc2dFVjExgjSocfy3WHhJDigQ2MHdzHDt1uC/l8
 /cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761557957; x=1762162757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L9Gkw6WeDhF1XM3MrljCsuR7+7JfXHtFQGXbhULjP0U=;
 b=gAdUkkdusbR/SQf5ZZRdDTorQnR4JgJkhbyjoL4E/VsWAvNReWOzYhrKA1JuPalZEE
 EI0kwdk8fQMV7bgo37VDNULtBqn2yWu5hZ5ej4FjDZJ9zKGUf+/R7SINe3F42PM4I0nm
 XrHrAUhsoQmb2uheAoLvhXKNZzUbAE2L5Y9wak1Bl6h0GQghqxBYzV5MFGiIwLlhWUoM
 czagVFEhcdTMiFVt1l2Gv/GzUNYzH1koDRWLC68pa3sGAf6r0P8mBGbbVjQzKcxEeE9a
 sUd7WFjEAz76OB06x0nKsaIAhdjKD4E3WjAYZkb62zTX6QVo5qzH2j9+hguekaLGfu63
 erLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUukwO9wTI8PqKW/xcWPsCOekVVCV9wLG7Q2a3O5euL0aM4Jtb0BGOOSiAqy8ocVvD7gdXGDtqNqMQL@nongnu.org
X-Gm-Message-State: AOJu0YwZU80JF0abrGqhCwy5cWC+vDhIZXDjLgVa5aw8JmHQfgOh4SZy
 Rg2lSjpAG17PCAjvBT2RWT4dGiPILyHB85zwM98P/c5vh5b+Xc4oQplSfeOAgqEEIV0=
X-Gm-Gg: ASbGncuqaBeVdugvDjkkJdcTlW8fB3zlUyKfU5vSMKv/LIxVzIgbQ4X/J9IePUHPuc3
 fAGccFdh5A/8PJlqbKgybkA25llTHMgVrjHWNFoDlH1a5fWKU0/r3cSKQEpYKup4ZecxUgTV6DU
 NpGQK3uxDWIMHQPBeGxfBPN8DcB/uNjgDWRNNTkLzzA18KgTK8JBh03OpKiU+aiBPkvHwatRsUz
 RVky7lBWWM5QOOsDQqAeHwiYGQ1fMGsgd2U3T+3sTVTmFocI7tiOyqgIKquaVUbc4duS4cStPKt
 gpjO0c/ZuwOy583krXW9QH6uI4bGKOn8Y1qSuu9r6XdaPPAwrJPxu4pFDHC03+HI9b193zoQLSz
 f6eIAp8jo4ebClWuHpSlFhn5eTKi1UfF75bVsGzZ3SzToLUnoVDa8Sw+G5CQXTq24m032ovZvo/
 bZYg2m51BcT1y1nUt8fsMbntlc2CrMH685pU72QhadBiaMmMbbtI2nqA==
X-Google-Smtp-Source: AGHT+IGGPPPLJURIakloQq4g+YRAP2mO1YOSULpfld03rhRMn+vtjCGttBrNyEYdZEXbRG/IcOHYhg==
X-Received: by 2002:a05:600c:870b:b0:46f:b42e:e366 with SMTP id
 5b1f17b1804b1-4711791fa34mr274052075e9.40.1761557957116; 
 Mon, 27 Oct 2025 02:39:17 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02ce46sm146112475e9.3.2025.10.27.02.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 02:39:16 -0700 (PDT)
Message-ID: <4aa9a5fe-4987-4140-a2b5-9da2677c9b19@linaro.org>
Date: Mon, 27 Oct 2025 10:39:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix MemoryRegion owner
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20251027-iommu-v1-1-0fc52a02a273@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027-iommu-v1-1-0fc52a02a273@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 27/10/25 06:37, Akihiko Odaki wrote:
> as points to the MemoryRegion itself. s is the device that owns the
> MemoryRegion.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/riscv/riscv-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


