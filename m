Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C170C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfnT-0004W8-2o; Fri, 07 Mar 2025 17:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfnF-0004R6-2B
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:03:46 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfnC-0002fC-OU
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:03:44 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bc38bb6baso14013675e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741385020; x=1741989820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jRadLtz6MCHDQMm2b0Lbh8WLL127tonOLitCvIEfqCU=;
 b=NmWjY3q3wB/oQeTiB0/hrCptiCot1nsOF49bHOTsTS8uw9umUOjU3bspy7pLNZz3WP
 dwMqZEDWtCB/dV1LhOGmqKQIdRe8FpexVo5W+pOq1kvHS+naZDxbSr0oWsTMFsQoaSNh
 S8cyorD9nthFOPrANUc0UPvg+NBNCvcMw3sA7xmOVhMvbxpADGu+F0GH6p+P1kPzC3s/
 ErK09zBuHKC5GQom156d1yfh0frwdIDIFB4QCtBih+2fUZ6/l4acfrr6ALN8++a6PRiy
 BRhVuT5YNmpACJknsZjex9dmISX6+dEeA/pIxMLPcS/wLpA3AnvYhfMjOqQmBZVmh2fx
 zDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741385020; x=1741989820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jRadLtz6MCHDQMm2b0Lbh8WLL127tonOLitCvIEfqCU=;
 b=HxVBlJUct82kCVKlS0FkFnnMMkS4RAWUyiVbgRRMNJsBsPD80uq3NiYpja6lOy7vTp
 //21xXUiFZCdrVdEKJ1Us813ZH7hOFMUO2k7oIEoUTRKycemCF07EOdAvyZfDSLq0dJ6
 Bs5OHkimFWMbHsaQAGKjNVuftDq3hdk5/EqD7pEU9KLltD9L0zTU007yNFUp+DTDbe8U
 ss4SDsYhs1l+xjALgjzv+sIqnjLR6b2pjGSZ+tLZ3cD6/JzcK5z8+/DsjM6GmHsNosNz
 6PCZZjqWxnGN3CHaiuA4Fuzw9JaP4cPBEkeML94U10nff6U6f8CGbgillEkjub2rn3A2
 tIEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUanPbIV7DPJnCORYxN7QCiF2bqXHrO7QwN1y9psvgYxPnc4PgoPIWpezpPPBvBwYRiAChpBJzxN+eU@nongnu.org
X-Gm-Message-State: AOJu0YyyFCQ01bYtVdOZj3rFIvmMCfLAlANSOhzmWIMGIvftvVhK4Ykw
 XwxXkPVdeQ7X53JU+fc4MvF8Hp/6GVr1fi6SUfuJYyRn4o5I8iUKJOmyl1P9oEs=
X-Gm-Gg: ASbGncsayyzPJL2Z/53uTXQjnYHMKr2caPZRcxa7CWzvrOTKQ/kXWa+46h1ov+GoxQq
 xpx9b4+xY+O01xfQ3g7HZKEenwzqeKcQC+Us8zBw/VbiJVLT48nVojTPjy78NtC8j1aL4ZeNBrH
 Q01LOHiHbzq8CTO2GxXHMHz+/2g5vw/ffoG1bXyp2g8mt172wM7BbxljlL27cyc08HNWmGZlO6Q
 zuJLJSCITEGO2Rw4vIRqUkNz61WUpLFR9IQ1hYIxJYOxzcKsv1x8IGOxhWekITCR2CjdfiXx+io
 RHjOPvOIiNNwrFj59i/GB1KX/mRDSx6SZjf+egdW6+Rif98sb1S718NMJkDOb4JcWlx6Um03e2X
 Tt5mvaJO2c3Aw
X-Google-Smtp-Source: AGHT+IGJUUYgu5z9NvBdVZM4V1anZ2xg1V3PJGdpIHtQZ+jiCiWsX5R7+TmUSjTg2LEB24YQyUMEjQ==
X-Received: by 2002:a05:6000:4112:b0:391:d52:d042 with SMTP id
 ffacd0b85a97d-39132d883f3mr2745810f8f.32.1741385020461; 
 Fri, 07 Mar 2025 14:03:40 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2eafsm6781486f8f.68.2025.03.07.14.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 14:03:40 -0800 (PST)
Message-ID: <e4c1d33b-523d-41a5-a8a5-6b47bce42f8f@linaro.org>
Date: Fri, 7 Mar 2025 23:03:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] include/exec: Split out exec/cpu-interrupt.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307185645.970034-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 7/3/25 19:56, Richard Henderson wrote:
> Some of these bits are actually common to all cpus; while the
> reset have common reservations for target-specific usage.
> While generic code cannot know what the target-specific usage is,
> common code can know what to do with the bits, e.g. single-step.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h       | 53 +--------------------------
>   include/exec/cpu-interrupt.h | 70 ++++++++++++++++++++++++++++++++++++
>   include/exec/poison.h        | 13 -------
>   3 files changed, 71 insertions(+), 65 deletions(-)
>   create mode 100644 include/exec/cpu-interrupt.h

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

🕺

