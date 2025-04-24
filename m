Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED36C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85LY-0001MC-Jg; Thu, 24 Apr 2025 18:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u85LX-0001Kp-0W
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:47:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u85LV-0003lt-E6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:47:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso9848515e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745534824; x=1746139624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3b4o2uWmJs3aRgz9gjGXTe8VIbv1WMxsqsYzl1LzmYI=;
 b=JIjPl12FL56k7i+Kqu3OovPkcK7WNC1zBbH8uURBjma8ObQoWwwgyZPwuJOSywoc4/
 0faipMPuLBs+e+X/Bp61lUUEQWbxB/Ik4bHF0eSYkcER3+fgOdgDY3P7IEduhMSAjZcx
 ybQxvZw6dNgbeu9scte2p0fDKFooT5vJxBx3xT39rXn1cTpnwu8mhPPCXbpEtkDRpXDo
 rAmozNgGCXfstpg7xyBYVulYWuZWc8iWAd+nrLpdbBxwQR2Ieg416AfkDYxz5lKLDNEo
 G5Y3e/bQrz73C3Djb5tiTpc5eUEoYBiXQVdowTz8Zn/2CbaOQd2TRXFsbhFQm57/nKAQ
 dbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745534824; x=1746139624;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3b4o2uWmJs3aRgz9gjGXTe8VIbv1WMxsqsYzl1LzmYI=;
 b=nMKry4i92dSXqA3vq8XXsSAdcVBA8cAGLRw+SSRxwYl6lAghpQB4AbPIQhWaANw7Si
 k8bm9+oHJIiNb/a2/B+p4deK4aP2c0Uo9M5x908zT1itqxkUeauCd1Q6dXM4xNHNnx2e
 Gj4IolyOC6rOB3fYaPebLt/vobfypQQGYwzm/TVQqy8gZxNUjIRuIMwEWOoBUFeWwQJB
 z2yr5fWS/SKVnt1hUMS3bV8VTYUfxkT84QWZLkXFmOpkkYsYCLjKdVNRy3a5qAyl5xEE
 dDhEBpsbFm4H0wlK1sUoto6UFxasAIUIec7Z70YiLXN8HMUUVUeXVMcjqag6z4UA3fXA
 n7/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Cz8tuVmXiLIOSirX1NNnBzZedCrFHRpnswjwSz5H3MwO/QCYMj6UZQtI27QkYW9RwcDV2HG3bsvu@nongnu.org
X-Gm-Message-State: AOJu0YyywSq7ORG6Qy/V5G6drKTSFmI4Nnb88po64O7UhNfStTlpUBsv
 uCL3QjTk7rmLqGIhMJP9qKlIirYhNB4UyKaQzbdPmSCU7AviSx807UAjUmMMx/E=
X-Gm-Gg: ASbGncthZkeT9FvJmtCATdtUHVuLNOYazucuC7FVagRrvnYr/D8AKrIB3K1Lt+Qbcrh
 2TqyWIh5NN2c6nQJRTtcEQBqRb+N4Sp69sltMPLOGQkoZqxYEzK+Qxz8oHn8V3P05Hz1iLcLsrh
 JUU+s/NVmARcebm+RVyaytb2lhvlemC2hPIHzyAFsK2GhDufrr+9DOI+FEBFt+Va1HQhLT3WOED
 SQEZaQbHNIs+oCgC+hVqAnFGc3kUquLRHVtNnkzYZhw3g+RBQhJg7JcDHOLrjAsXItr2/Yb5dK/
 ycpbq+02/sBpzrTy5c5b87VvNs105xyFALR1khLTPbZujzV/DoOCbdpu2O7cn3V25GUb6kNqrED
 +VQxFM+JK
X-Google-Smtp-Source: AGHT+IG+1wJBeIxeD7qs7vpxIROyu4mJeE6nGhapK2uNq3Xh4Yt8EHIE25ZJIW3e8ghilBeIMa6uRA==
X-Received: by 2002:a05:600c:1e86:b0:43d:b3:f95 with SMTP id
 5b1f17b1804b1-440a3186746mr7818835e9.28.1745534823907; 
 Thu, 24 Apr 2025 15:47:03 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a530f6e6sm3746945e9.17.2025.04.24.15.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:47:02 -0700 (PDT)
Message-ID: <f35fc475-87de-4071-a183-c12d44a52790@linaro.org>
Date: Fri, 25 Apr 2025 00:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 04/21] hw/core/null-machine: Define machine as
 generic QOM type
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-5-philmd@linaro.org>
 <8c32913f-5ee4-4f17-8fee-908c48dc4506@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8c32913f-5ee4-4f17-8fee-908c48dc4506@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 25/4/25 00:30, Pierrick Bouvier wrote:
> On 4/24/25 15:20, Philippe Mathieu-Daudé wrote:
>> While DEFINE_MACHINE() is a succinct macro, it doesn't
>> allow registering QOM interfaces to the defined machine.
>> Convert to the generic DEFINE_TYPES() in preparation to
>> register interfaces.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/core/null-machine.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Maybe you can integrate your other series changing existing arm machines 
> also, so it's easy to apply this series without the other dependency.

I discarded the other series due to Zoltan comments, and only
salvaged this single patch (the others aren't needed since this
series introduces and uses DEFINE_MACHINE_WITH_INTERFACES).


