Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBA5CF9C72
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 17:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8Gb-0004MK-Q2; Thu, 20 Nov 2025 12:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8GZ-0004Kb-RA
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:16:19 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8GY-0005jZ-5c
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:16:19 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso5542675e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 09:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763658975; x=1764263775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IhBSD6LO/ve6A4g/Muw/8ItZECnAEBxHA2OnsgRjHOU=;
 b=x6teF+EHW4qGFwKY24CudCITOEkdSYdqgfm2CORciC8ST0st64TtBhzoJKq4jIthCG
 UZIDdlRumGBBubsKy5ZZTdTLwWeewZQY6/XTFjgFELtwViGiceshdotek5SAT5bdXwXM
 tj/Eu5KwLLmRh1Hitmzr5a0YrlPcO4ke8rk30zVnnfArQxaHU+BXnXxqi9dFQJlsJMbp
 j5QNIteFE3G13IY93c4rLb2wcOaXpj3sFyzEdFfrX0e4tMn2/N0km9e9cghn5nbxAHeG
 BCVcZqE++tjY/1MfKLIpgT2dHBRF8dyeoMO1fqtfJSdDS7SrTgQDs5hlNYI9/0S+odJw
 SMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763658975; x=1764263775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IhBSD6LO/ve6A4g/Muw/8ItZECnAEBxHA2OnsgRjHOU=;
 b=O4OjsOb/O0WwObgZXztplHAeTnf4kNHbKhjOBva9wYHiiMgiWsnz6dQisnulv1NHip
 NLazE/8p6MfnMyhZGmrlsa0NPr+++oYct8cUj3Bhuy5C7zx50x/i+sUnvlfEZ5piFST8
 grwG3xjb9gpI5ZOMBPXfNrokR7CWfWvUFjNUIpx4ziTOE/GyPQQ2An7yXxGvkmJpgN83
 yBnFz84bN/5R2AK3vddAH+Gna2+fU54w0O6Euk0y5SlIX2wOjsyhozEmHl4JjEhNrIId
 vPncrmWKVJr4yLtsruNsFG0IHON7uCkAluHe77UT/V+iwkxyJjes9CxIh2qMl2QEIqLn
 Ur0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXYvch3w3rg1pLTqjPijWAUBbu88XB7oVGQy5bwoABlJlE06zqtFf7XRetqsNs9GxwkWBSNYPMaN2x@nongnu.org
X-Gm-Message-State: AOJu0Yy4IusiR4ktFbJdd/zAGB8t+3RR1Ya/unjpCJ8Qs77GfgdqBU2i
 832LnjJvTzsy39d7PXwCfD9yY6IHzgHvJyfBkLLyjZJJvY+TFJQ9/Ykp9dUUmA14GaM=
X-Gm-Gg: ASbGncsgUtQDvXcYbhVBiJJHtUGaM8b/LXLd4RuTeP4wslEYybp7k2Q8kS4Tjz/l+Zu
 oTHXD8N+Cp+CvfrgzFVcxI6w03vuuO+lOmY28p+Ihl4Q7DbZvziQk5kKv0AgSmhy+ZbcwSDYX2Y
 P4Pl3Gq0Mr7vvy8RPl0fu7HBXXx8DxHNhbN4dOfDTZ/1bfHJL8bXl6kbajAlujzIQ6UIY/Y1v9A
 4Ar5FgIa2G5nthRB2aITAz5ZHdmF3It7HAre4fSp4KWJgvZC9U2RX4aMvb0lDPYDz2whzliiK70
 34N9HtBRBU3fwl8dd9bFA3uTFU1RiqbxtfCuvYRjl9KgpUz5ZO3F5vTQA2SpXAlbo+UVIeu/tCy
 NNsl0Kqv+x4xZ+ZMz5xnMpkAJCRifk2GZQma09kcKigvyCiydbJxKqpC48sum7weXPoRFCv3o9y
 wuhk2sSOx6b6uK1VwuNeHjZSiTQ9u1Hr0QChxkPpYsuW7jq+faahJPjA==
X-Google-Smtp-Source: AGHT+IEBKj4hUm7cKaMaSihFWxyofkIrtRTmeox1NNVvqpvpZjb+ZNGgzCo4brUk5BlmMK5z0hQpxA==
X-Received: by 2002:a05:600c:450f:b0:477:429b:3b93 with SMTP id
 5b1f17b1804b1-477b8a9f1acmr37102295e9.18.1763658974715; 
 Thu, 20 Nov 2025 09:16:14 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7ec454csm6093202f8f.0.2025.11.20.09.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 09:16:14 -0800 (PST)
Message-ID: <a5e9c465-5c4a-403e-8768-bf383256091f@linaro.org>
Date: Thu, 20 Nov 2025 18:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] RISC-V CPU time source interface
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <aRb1jmwXE18JB2_g@XFR-LUMICHEL-L2.amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aRb1jmwXE18JB2_g@XFR-LUMICHEL-L2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 14/11/25 10:25, Luc Michel wrote:
> Hi,
> 
> Ping, patches missing review: 8 and 9.

Doh sorry, I don't remember why I stopped... I suppose I got interrupted
and forgot. Too bad this missed the soft-freeze, now we'll have to wait
after Xmas :/

