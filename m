Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CD7F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcoG-0004yi-AQ; Mon, 09 Mar 2026 11:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzco9-0004p1-MY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:46:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzco7-0006kn-So
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:46:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4853fd7b59aso4660455e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071170; x=1773675970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0qkLJNTJaW7oolOelk4ghR8+UlfgfKILOpNxiYSdaFc=;
 b=yyJPfZf4UegNfFbmz7FD3pWuYl8hl4wQxKbtX3ewuz1fKKm1TmcM8lOrF5C3Snzp5L
 7dr5zRq3ExEKimBrRjS2uSv2sG3INIKR+QRk8XbAEaohqc97te+qi1Rjr/T/kLIn62A4
 ZsuDr4BnVE03cl0Kji411/WpT6efMEUXHpYZICYX5pDYhIDqy4aSVV4o076VBk0Tm0uU
 ayO/GtA4Wgo+f8IA6hPJwBq11J187SaZYhK89Mq179Cyc7rI7SMempEOJcSTO0inYycW
 Lg1foUzehbs0FGbv2uy8b6BHSCP7L7AIzEGBcX3hpYz/JuNGByc+N5prGJ7+aXoo2uDA
 2GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071170; x=1773675970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0qkLJNTJaW7oolOelk4ghR8+UlfgfKILOpNxiYSdaFc=;
 b=al1LAInWaiGTdWUx8rSvy98KFP9OIm/4okeVHLIeW/QTCzfE0B6OcXZ+pWut6FNJJH
 xNScSD60d/B5x08F0hzWQDmixUhpGiYkw8oUmjoGRavijRYrStU1ojeaKC/6EKsc/k7P
 TYmLvTzX4vEORPYKU37gk3JHj7QNtHWiThw8JS8BYxiRlEy7Xer8HmRu5NXbu9cxpRKj
 RU+Dabyc+MsnhfBepOW8U7revQB4ZGWviyD/ZpCdpPcclKBiQ516NebMEwQyovdKVDae
 mxWEJr6uNuDDXec3cR3mHW7YfQjrl2HQNfv7MNgPzr31Lk4cNjZKyWSkqkLjzMe1Xdvp
 NC9Q==
X-Gm-Message-State: AOJu0YzOXjLoA4z+C97PK56J4uhW7ScAkWJj6m7jGJfFzgyZkKSqvOHp
 4QtjtZLgEpj3qxYFwuOe2UiNXszlpqHHxePRqpCbfbVeZqhQJGjlM6EFIMEGAGeJFohClGlviPI
 65X8lqwI=
X-Gm-Gg: ATEYQzxTexLBIzyI54JZErPg2x+6mZgXLZYxDq3DziKsFKJysulNvSfJkrmcV/CwEjK
 ueyHc/k8uMkvYYgUygAmWNhbfiRbtqjsC0GTCayEmOUXaE8Afk1g3OHNqqs4c1g05FdiDPSimeH
 kamOJ7Mlfv/u+h+QJ/w8/CiClVlqDCCHt592iPIJqLRB/o+k49v4JvCLhPGRknCCd5VrwUr3AHi
 RtDwhiR+pRHQTl/J2hFNqpxpGmI0+lPDBqSPtiFxTNU+Fm70QLQ/Jc3vK3AfE1YQqW538dEe4jb
 ZyltgoCYsKZY19sb/HFsz3VPdiuPVXkyt7fSS1/9V2ju2IRJfeB79zJ+79H9ltVyHgtmvZjYtMx
 /3m7BFb7ad/00PGJNFNJY39yo/PIfrOzhEV6d78txaTLkElcDIbhbb/B30hObEKlLhCnQ++A9kD
 3F7y/3nmy3FoCVoF9Y09K1PtzeePs5XHe2Jsj19bDhGscyiVPhMQnewlap8kC9oXwTYQ==
X-Received: by 2002:a05:600c:1e2a:b0:483:c771:10e with SMTP id
 5b1f17b1804b1-48526957d6cmr184839855e9.20.1773071169945; 
 Mon, 09 Mar 2026 08:46:09 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aba60esm104065e9.5.2026.03.09.08.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 08:46:09 -0700 (PDT)
Message-ID: <f78eb83c-45ba-4219-876c-c6a4f7de2a0f@linaro.org>
Date: Mon, 9 Mar 2026 16:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] hw/i386/pc: Remove deprecated 3.1 machines
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260309145013.44327-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/3/26 15:50, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (10):
>    hw/i386/pc: Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines
>    hw/i386/pc: Remove PCMachineClass::pvh_enabled field
>    hw/i386/x86: Remove @pvh_enabled argument in x86_load_linux()
>    hw/core/boards: Remove MachineClass::smbus_no_migration_support field
>    hw/i386/pc: Remove pc_compat_3_1[] array
>    hw/i386/iommu: Remove IntelIOMMUState::dma_drain field
>    target/i386/cpu: Remove X86CPU::intel_pt_auto_level field
>    hw/core/machine: Remove the hw_compat_3_1[] array
>    hw/pci-bridge/pcie_rp: Remove PCIESlot::disable_acs field

Series queued via hw-misc, thanks.

