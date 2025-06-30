Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94CEC8302E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 08:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWAML-0006Nk-Qt; Mon, 30 Jun 2025 04:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWAMJ-0006KL-OR
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:59:27 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWAMI-0006cE-0k
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:59:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so2668759f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751273964; x=1751878764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w+A3+IebsMaAPwZvp7nKuPH6W45hRJN6sDur+FFmVCk=;
 b=GMN06SPxg94S/W+TBT23538Mo6UMiTpy8c9aYBpn9eDWgNuB5FWT+37EW3yEoiWWCi
 l1eNiRg2NXUTvOw9qsCcIh/mc1QfsYJbwJ/5PstFyYwMik52JZDo8zgJJgKcWXavI8ul
 CpY2Bp9oHLjX4w5dBrVJpDKOWcEI0b7w/wqA1asrnoWEEJTYQP3bbc3Y8e0mH04cWcXX
 AGeDMigu9kma6p7iL7ya8g0xNNszZEXQ+a+a6a6KDn3esLHG7S72Aadky9tIlexZIftH
 2nEaUuFiWzv1caAgKkKgQCZfQ5toEOm5n3nEMT52HA53dhsLKbHY5kYuz147RK2ko83A
 2hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751273964; x=1751878764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w+A3+IebsMaAPwZvp7nKuPH6W45hRJN6sDur+FFmVCk=;
 b=GEujNAQ+yRBWZuzjLilVypFS7+p/+bJRSjOuVmqNPQ6FsbzFV9BRB5FrHxU2ZxugeF
 XUM0eviYUuF2ZzU9lgYrxSGtd5OYmxGeOeNxB+q5VWA89TvN5f/CkRsUWbOtkCjiy7kd
 9c0fPnDYvBwljsdv064Nwoc6/454lh4AlEILXXuYzKNUv8pAjX+o27ypnQBJYumCvdTI
 2JlCg3bybSx7TUsjeaF07bd7Sgk5MbF6seAy/OB/sTxnK9swNh+kyB9LP2LC801tNDSL
 X71tDPun0AXHMrjosDcr9OBTL+zglouW/kM+h47ttM1PkYcqXcxkEVIgiOJ+We5afXrL
 6kFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfxtk0wEO3iaOmnWClQISm9vNzAnHxBya84IG/bATuQ7vZ2o3B8p62JekjChTNj+stsE3hUUOVMwjU@nongnu.org
X-Gm-Message-State: AOJu0YwRxweLc/uxHw/2MT6VpJ4hI7SXxnQ9yZlSG+HExZaoG/HHs4Eb
 pQZ/8cHgn5cNc4yg8anTMnjIwhi1OM5n0AgG6KpmoeJzMm1F4SX4tU5llV5psquaER0=
X-Gm-Gg: ASbGnctlq0fkp/odM8EgNJT5OYQeiAGbwrLj+qsGDJ7sjlrtiJFZJE3R+S3ohNYYUgS
 R8MGAWSW9MNYxcKWJWVysg5uAkpyaiGQlMYNmRd+60t/OKjW/BtStMyzF5cpuT226P91xNPg9YT
 wh74JZCF8SnVKzTGWxrHvKA3vWWIHyUMUOuH5ozdzcUrGfEqDKJzRV1CZHzMtT76VYAiw0sX11H
 FLkwlfBum1WFx1j3VmWwAVGkWbHw7TwDF+kwan3ih3/xZKOgaSog1LVy8+Ih+/BtM36wc/3M7D8
 WdKa/wfO4VwwYRupoCqnO5Sozl4AMGYBeO7gHb5gWVRMutqhcCvsRH07C6z0UAZB/Um71I0oRKE
 XWpEWeKvWmFqxh2vwNmsPGhuZ6VFSjA==
X-Google-Smtp-Source: AGHT+IEGCUFjnRTI8xE6HfEs2SybcXOepmvHqaYnK3CY1zqa0wmWx5AOZ9u1/evDfGUXiuvBOFstDg==
X-Received: by 2002:a05:6000:2a88:b0:3a4:f663:acb9 with SMTP id
 ffacd0b85a97d-3a8fdb2aee4mr8787145f8f.9.1751273964018; 
 Mon, 30 Jun 2025 01:59:24 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390d11sm130380765e9.7.2025.06.30.01.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 01:59:23 -0700 (PDT)
Message-ID: <4c966437-91b4-4c07-a07e-1a54f51329fe@linaro.org>
Date: Mon, 30 Jun 2025 10:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm/fsl-imx8mp: Wire VIRQ and VFIQ
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-2-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250629204851.1778-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 29/6/25 22:48, Bernhard Beschow wrote:
> Allows to run KVM guests inside the imx8mp-evk machine.
> 
> Fixes: a4eefc69b237 ("hw/arm: Add i.MX 8M Plus EVK board")
> CC: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/fsl-imx8mp.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


