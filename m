Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92782C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 06:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubvs0-0008PU-T5; Wed, 16 Jul 2025 02:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubvrv-0008NI-Cc
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:43:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubvrt-0006gI-JI
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:43:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso46418325e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 23:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752648230; x=1753253030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7MB7uOSwE/aasgi8rMeq9SRnAj7bo4Vy3svnH5pxpyo=;
 b=rdAIsScm1WtqjcIz0AUGbDwp+uvdMYjT5w5/J7PnmC1gwa1b04eM9qdbuIzh4kpiNd
 KBpiGwiGZ2MtZYv7rzLiPGUeAyz5jXx3d1dcf8OY3jdYm8Qx+7FGmQ09dCWDpx22N7GI
 u05led7VtAXIrl/TTef+rHL/gaPtDslMOVwCMUL3JeWqjbhOE1P6fZzuhKn5CNfpQZ+h
 CizSr9vtJAAgTgMwGdOSx4urQZ1L3nTVbKoIUsMYoUeZ0HyHTJcsMDJhpY36ioCGBrvO
 BZAb728TNtMzdBQqc+DQmBbriJy0j8jcT6tHuKH0gmU5QdTHSefJPNv4ST5AycP5RtAM
 6qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752648230; x=1753253030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7MB7uOSwE/aasgi8rMeq9SRnAj7bo4Vy3svnH5pxpyo=;
 b=sKWGjy/jB0iBtT/Rfa9DF1THrfQSFwXBsvrt9IYyqHDq46gsd4gA8+ye2Le1v7p2/L
 VnG6Wwjc0vTainLsXlqKPFzCQIX4uziFjRXUqAwXRAV8KQnnYWiDAOlznqf7J1MYwTmR
 dezPQrs/BqmuN/wJMd7Fn2UAHSCNPcc01YYc32kc2GRFSDtPD3Pryenz0a+FsxK9Cycb
 9h8rCHFOojEgX1173gn33vYxc/R+0bQOSHkvd4SIhj4qaUxc0Y6AmnAQErvkoMfujeOV
 r2YFZi0yO7V77v+QY/iCCkQs+hcrmzSuP6jLz/QUz6K//XPDomfdkA+xvMY/iH01tAFn
 LChg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXECJ38od8P1Ao5hN7DNnJTKXchOdIYYZWGh0wURNjWWCTpSCl88ycXfEI6JUusIQkF/fO5CmDp3b97@nongnu.org
X-Gm-Message-State: AOJu0YziJ7Vb8cJzjyrIX1BmL/cfgJIJYfDt8yReAj35RCdsLrgMWm2j
 JWI6/ZgjNYh+7CemYoBkvUX0UvH/WPesHQOBGdGhqJjLNiQzdPj1HJk8gsppqfAKkBs=
X-Gm-Gg: ASbGncvrxCyRC4lt/9+3iHAoUWgvQqIGvC/FWTBWpxO6BHwnNCmrEihhCi7a1P5Iwya
 r9oAPeAiEyaYaUnAv/PZ65rgdPP8O5ibjxUVWaZ4wWjB8jrlnYiC7a7680UqHqe4wjjukZPKH1K
 0vcx1Nx1HHhJEawU/Sjg0zoD+A7Fzqf2amSnmOCutz7jFWv4wZ11nT62pddTZotwIN6hhQefJ9r
 h1BdP2UgwSgbG7ajx/zdBd2B5Kwqq+sMyfybGqIpNYsV/b7h8F5BuyWbVQhz3CgC0gRZsQnj2IN
 aMvbXOzT5o76EGW253jcu9FxEv+6Du5xEKmZHsOPS3gPqFTVyjVxvQ8LA2sq36nTkmQXLmNQhvZ
 elk6PCTJgeZNYXcSu9MQTi/w17tEWs/29c4aelU0ps1FKmCMsRjtFesALTi9yFn/3iQ==
X-Google-Smtp-Source: AGHT+IH9KcKuEpMr+MEkqBtZHKTgEUGIhw/ribHDHxsZa9gicmxh82SwuHBJwsonhxXYdAjl/xKIlw==
X-Received: by 2002:a05:600c:4e4a:b0:456:18cf:66b5 with SMTP id
 5b1f17b1804b1-4562e274849mr12958995e9.22.1752648230151; 
 Tue, 15 Jul 2025 23:43:50 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e83c9edsm11130835e9.34.2025.07.15.23.43.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 23:43:49 -0700 (PDT)
Message-ID: <cfa8ca25-e9b9-43b5-983b-1601d02d62ab@linaro.org>
Date: Wed, 16 Jul 2025 08:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: Cleanup host_cpu_max_instance_init()
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
References: <20250716063117.602050-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250716063117.602050-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 16/7/25 08:31, Xiaoyao Li wrote:
> The implementation of host_cpu_max_instance_init() was merged into
> host_cpu_instance_init() by commit 29f1ba338baf ("target/i386: merge
> host_cpu_instance_init() and host_cpu_max_instance_init()"), while the
> declaration of it remains in host-cpu.h.
> 
> Clean it up.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   target/i386/host-cpu.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


