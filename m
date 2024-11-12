Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BCAD41D51
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 19:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAwyJ-0001hD-1x; Tue, 12 Nov 2024 14:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAwyI-0001h4-1x
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 14:54:42 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAwyG-00042G-Lw
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 14:54:41 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-720d01caa66so5811551b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 11:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731441278; x=1732046078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O2JMyessd0hYaWg0ucv7u5P7Fnn7u92EWbl8vOlw/8E=;
 b=U1AYFlEnr4eXBLBECW2ScFboAJWwSVqZ5mIHCNr5hXJmiFOsJ0oS37Fp/8rwkIanSw
 6UVMe8AEvuQnqYpk5spWafznwKf57djKvh7/pz4i9Wqc7X11QrjjjZZ2aboAohvFY0A7
 mFv4aBfmjHwmaqUf5M78MHeuKL4SJGelCb8UckS+dHPvatm4Qa2oUIW911A98rxwfip8
 x0Ce2zycbzi51VpFoxxrIK0KnVG4kXfTurIbSRg2vzOlv6OXbbZgyx5VBHv77hYx+I48
 Jsy6hysBZ5sEz2/KPhopGxsqvdXMSoSvyEkCJsH6cTlQGUcw4vP29mPJB1dwQnyV8u76
 bg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731441278; x=1732046078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O2JMyessd0hYaWg0ucv7u5P7Fnn7u92EWbl8vOlw/8E=;
 b=Q3cwzH2AwC1iKSDhYQjBU6sP4ktilZ49tdllSJqfyeWWQDsSqQn7k1x1a96baOF/CO
 JfQrjDuh86dbIZnOLG0OvQ6v4cPk043sb3+tFJ0ob56LtbB4y53S4ozn8wjxwKFIW/Xe
 ywBGIk8XvVJX4kcLup8fe7w9zJAQwZYDb1UXBxiIqN+g2VwrxlIZv81idZkg4h2yXeqU
 xl4KYeu7BvCad0W69yM62F8xW0W37MDTQ+LZFwtfd51T+3WU1zwVT4bvhVpCagVSlGpZ
 sHzBVAy9DHbZOXwAWJEFelScCQMMDeau9UCqPccrn4+fC4hhrabaNH221/I4QR3kLLRl
 Woxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNQA+TfA5Euiq9ndPzEBLKqwk67hVgi4J71fAexx6E3vVKTk73yRNSm59eV9w1/NJrwgQYTLNeF+Wx@nongnu.org
X-Gm-Message-State: AOJu0YzVfO9BiO1A7KHdnzHRa27XyGsg4fMXIJFUVl1getM2mC2q281B
 WxAS7hb+hjuGakW4CpipQt09QA2GeqBiMTcWc+pK8yo/EIZe/MhPUUujflLN0ZE=
X-Google-Smtp-Source: AGHT+IHCb6Q0CYhgyMXybulj5wgISzOA7vKDJhBVfVo/At/7t9rWz+eiUJ2RAzgoU9LTghIBbFYZXg==
X-Received: by 2002:a05:6a20:12d3:b0:1d5:10c1:4939 with SMTP id
 adf61e73a8af0-1dc70338a9dmr534271637.8.1731441278504; 
 Tue, 12 Nov 2024 11:54:38 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f5b3f8fsm10847368a12.19.2024.11.12.11.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 11:54:38 -0800 (PST)
Message-ID: <764e5746-ee61-471a-a90b-886f78c606ea@linaro.org>
Date: Tue, 12 Nov 2024 11:54:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] GTM19-448: Fix script to work without realpath
To: Aleksandar Rakic <rakicaleksandar1999@gmail.com>, qemu-devel@nongnu.org
Cc: djordje.todorovic@htecgroup.com, cfu@mips.com, arikalo@gmail.com,
 philmd@linaro.org, Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Faraz Shahbazker <fshahbazker@wavecomp.com>
References: <20241112183849.2577570-1-aleksandar.rakic@htecgroup.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241112183849.2577570-1-aleksandar.rakic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 11/12/24 10:38, Aleksandar Rakic wrote:
> The archive-source.sh script depends on realpath command, which was
> introduced in coreutils-8.15. CentOS-6 build systems use coreutils-4.7,
> which does not have realpath, so fix the script to use 'readlink -e' to
> perform the same action.

Centos 6 is not supported.  Neither is Centos 7, come to that.


r~

