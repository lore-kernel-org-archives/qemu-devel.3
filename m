Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB14C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZokj-00006z-Mp; Thu, 10 Jul 2025 06:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZokb-0008Vd-4B
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:43:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZokX-0006k3-7C
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:43:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453066fad06so4747095e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144211; x=1752749011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YsH2CsC3SbUWzt01eKgxXS2RO/6o0D1c2Re/SGbbvtk=;
 b=OAAyIYPkZSuN6ug3NvXnFGfHi48aZmxMQG7VaVDB8F93Jn9Eos9pA7h3JK/YrfFKyp
 lW7wwoat31tkXSsCcWh6JQuQveq8tIdEi6E9xdkXGaHI058OTdEiZLtUrM5bE9MIo5HD
 9tvdEvkH5z/fDtJlvu/F7YdNx8ncHrddTWN5fB+cI/q9Jh8XmXFOXyYsPJ2f0IED9tXE
 GdJCWUNCdZJxJmSU8mAzA6mTVqS4zWYauuxrWl6Ke2c1mWvha7DTfOWNve5Ov7rCAMBF
 BtyuI5N/qTuhCTQSOETuvA+OM51HCUN3KG0A/65jw5acVmntc/be2xhdr32AGtY1auNu
 VZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144211; x=1752749011;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YsH2CsC3SbUWzt01eKgxXS2RO/6o0D1c2Re/SGbbvtk=;
 b=PiGBfUobf55VHWEQp496aA6EEaqIZhhoPzTmbNDaGzaz328OH6Uf8JCElm+L29zAVb
 qeCQyRO55wWpe7Ifs6428HtzbjshYf8svrBUbiAlj5EH813nRb+kPsId/M+vr2W5mgtl
 EoO3Rd2khoWG4NQAC1+/TG8Vrssp5ewnvCUPD/swYi/AP0Hvmn0moSwAkGtoQp6cBRMe
 L9cgsIUJZo5k7OpV7W2I7ezQ1iTXvwzBgrNZ1vHsnaaTfZzX/ozb+XQtorzNYCEcOyp2
 vtjEpzjCtMSLdhwUhbkCC/nbn8vGNRCcYsZxJOxr6dk6UaHO6WVmrwPThYbBz0RPDnb4
 eGPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWke7npMDkry+O2/CW6IxpmEpIyZBB47sQycsQIQjIWrQ9tND7GsDpoxEWjODdvT357OHDj1Lb/pFet@nongnu.org
X-Gm-Message-State: AOJu0YyBlJ/pjzyhH3svE3V4M7MWeE4wmKmi73oa3vM/BrxoY5/03DYR
 MADXSTNuccpMlPC8TTPtdmCp5ksG9XTLcd+zjvIhhozOHr5x4Ra7rvrnvB7RYFECYP8=
X-Gm-Gg: ASbGncvvXmuhgSqvXAnLblcR088W7KxK1Cv8+y309UIiROOcuTuPYd9HrqEN2NfR6RR
 FOL86eyAA7rrqdDrUMsfuFlmu2w8y/6DQPb9TGeR9+gWL2S2HWQBwbJ1XmQb1urvPvGxgUZ0sAw
 eEEGO3945FmhnE8Ij71Wx7SFBrFmryo668figUoU2LfFoYOTLDBkQX72ogfLn92FyiSp2ESe4ox
 CQQQN8I/u1hTruZSQ/BOOXv6GTu6IOdaAeVNVDkCH2X7iFu+2Nmu6IAzJBid3CsEo1GT+F55Obe
 KXHpSuf5ynJvoRapEr23B/9aVYMqgZ4f3xkA9Bdc5XTm51tEGpSlh+kUxaJkxEGHYCo+0UabqO4
 Y/hFGkcSGZq//CcLa2MuD/8GH6tXV83XoCTKEcsAi0Gk=
X-Google-Smtp-Source: AGHT+IHMXle9Ikkf2slwgJCpQVlfG6z+3m9EkHsW8srqy7rfuwVtBNWhDojrImol1Lsa5xSjBRDDcA==
X-Received: by 2002:a5d:5d12:0:b0:3b2:ef53:5818 with SMTP id
 ffacd0b85a97d-3b5e44e2010mr4815890f8f.5.1752144211469; 
 Thu, 10 Jul 2025 03:43:31 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e2cfsm1488847f8f.75.2025.07.10.03.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:43:30 -0700 (PDT)
Message-ID: <624dc105-25f5-404d-82e9-ee8184d430fa@linaro.org>
Date: Thu, 10 Jul 2025 12:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
 <20250704141018.674268-14-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250704141018.674268-14-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 4/7/25 16:09, Mark Cave-Ayland wrote:
> PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
> in pc_init1().
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 194 ++++++++++++++++++----------------------------
>   1 file changed, 76 insertions(+), 118 deletions(-)

We are not far from removing PCMachineClass::pci_enabled.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


