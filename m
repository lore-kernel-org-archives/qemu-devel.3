Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32840C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 14:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ig8-0008HP-Pj; Wed, 08 May 2024 10:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ig7-0008H7-3K
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:53:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ig5-0001we-FM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:53:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34f0e55787aso2571458f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715180032; x=1715784832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=562fNtK/aLswn8aZNSaHVclyRbFEvhrHK8HaoaQyWRs=;
 b=O+bgiPHh+omln+fmzbQ56oyM426cAhwE+hXMzrKj2Nhh5ABwHa1XeQlipWc2qyquEu
 9zsorK5E6vYoMyCt31SkVP/Bum/cUANdIO6/2uJ5ky1lhR3CGGbbGM534+ELZPggM2i3
 LmSo+2gZW4JeR2eorCMzFHNl+BosOHVQJlWeDrU1M9Jiw69XPcnU6nMYu3rmCyKWLNLd
 bezfkbCIdt9xSob09kGNx7/fuX8LdEuT0UspEPBZd0WxPGd0uaG6NcFHb24+/VJbiIWe
 F5BDVunuhFz18o4C2YUEF5l7wx/WoOAi0PliOyLHLdLsbTTub6TJM5PL/y4Y9bkf9VXR
 WAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715180032; x=1715784832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=562fNtK/aLswn8aZNSaHVclyRbFEvhrHK8HaoaQyWRs=;
 b=nJNBr9+k8IsS3vZ7y7QA4kyPuPvwqhfvqWQ7QGEzgTwYAYbJboA54z0X8quk6cT7Ju
 z8hsVb4DmD59KkQ8LtfYlP/d3vSuzloaQLUw6978ednSjPe2pXm3GOlOmqSrgP7QNifE
 kpnmNAEViqhbq343GVlc0PJtmd7Shp/42hS7mtN13f9AgvSvZ/SjekK/+WHuAPxKWvsj
 67T9eghOhJu0kvxk7e4R8kynUgl6rteJno9wr/y+Ft7wSF7JIw2Z3oLX74XcC371KZx7
 cXIFjZfTS69mKuFJlSpg4AATQon6IPBWCvWwIYLkmvp6KK82K4NgxbOh7OFbmov/2KkJ
 7yTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhZ1IA11L6wjBYrSrgqlfbrFNIhGMOho62tVPhsPkrVbYdZtBarWr5MdLLCln1nRboxWs5mHGmucAQUuKePxylFPlHGnQ=
X-Gm-Message-State: AOJu0YylSzz1k3m5k7+cu12TQ8CwwrvaQdG7o8Ayadcc8zaE68W0bQOn
 VomZYoVI1LT6hdTHslPLjENH39tKKHeUP/4FnmFdVZE6IOYUYCLzgQzsdkoRqSE=
X-Google-Smtp-Source: AGHT+IGziInGm/dQomSHkoMm0q+qX1vcph/099SxIwp46ALJSlLGlooeQaLZ98tenCCy0mBJ3mhG4Q==
X-Received: by 2002:a5d:564c:0:b0:347:6a0:b61d with SMTP id
 ffacd0b85a97d-34fca149bcfmr1912393f8f.12.1715180031791; 
 Wed, 08 May 2024 07:53:51 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 u9-20020adfa189000000b0034bc5934bf8sm15568902wru.31.2024.05.08.07.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 07:53:51 -0700 (PDT)
Message-ID: <5bf68cc8-a602-4362-b1c7-0096a2df3f07@linaro.org>
Date: Wed, 8 May 2024 16:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] This series changes the "isa-bios" MemoryRegion to
 be an alias rather than a
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240430150643.111976-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430150643.111976-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 30/4/24 17:06, Bernhard Beschow wrote:

> Bernhard Beschow (6):
>    hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
>    hw/i386: Have x86_bios_rom_init() take X86MachineState rather than
>      MachineState
>    hw/i386/x86: Don't leak "isa-bios" memory regions

Patches 1-3 queued.

