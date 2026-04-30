Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788CFFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJYG-0000kN-MS; Thu, 30 Apr 2026 01:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJXB-0000H1-DL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:02:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJWc-0005QG-04
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:01:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so287496f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777525280; x=1778130080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FA0ykYJraxchdeGrRh/CMjCJX6uSo2QK+HQHQ5sN+cE=;
 b=JOUkgzDwts7fxNOAmvI87A6kfCsPYGOcP+ANazV9lJoUBPkEFcYmAP9gtoBpkKk2oL
 E4xVNaQhqAJ8qvItP0BKdj4RCoclbH4LEr7PSsFAOwsMkl0x1w6bFB/wlBPM5ZlowsY0
 VYQKHBTyvkp9aFEw3laErLOCEenMsfA+sKIHYxRAXFPEQfTG94Xjc9BznQaZkslCNior
 Ue9O3XkuKOwKXKIa3JI7/LLeyokePICM/J6VOiswrnGV8OY7+EgBGkWcM3sE1mkjaWqt
 rOfnY3GzBmBefhMoAxV10zfd31oBUY+9EFO4GH3H6P3g02ua2mEbveDihfHWdiPCmugZ
 C7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777525280; x=1778130080;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FA0ykYJraxchdeGrRh/CMjCJX6uSo2QK+HQHQ5sN+cE=;
 b=QT1fh7db+umGhazgHJVF2Z6/DxREfFqdmDZk63umRXunmOJYyf3RF+sfTDPKU8WK8G
 AKsVMqhjchdxasFsnlyMrAfoaW2DlX9WW4LbP1EVgQt3MmveeKWGSdd9V+JjslsFk26R
 HOsF5xyVCqaH30DwFimEozICWDAtBQM4yJ+R8H+4tPoyDZt627JySN2txGN5Wk7iyc88
 b1vcQuHQ2CWPYTn7rZvuHy1i/JLsm+zkTCmeblr4XqqVMMbJ2yLHm9YenPwf/cpeEV4P
 v6fTz3Ndxkl/ZkTVnlCfCAUp68rhxmhcxKRY4zYvx8L2FgCmGqj3HJ8hESO79dqOamNP
 iVbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ88NNb0nXsrz9aID9b/s3PJCuBzrVI4yXouLCtHbKUCb1t7M5bGaTlWU5qpxvNLZ+wmtqu7AuIPkExL@nongnu.org
X-Gm-Message-State: AOJu0Yxiw4QZQNAsCtpJ6LJuB9CGP8HziWOd7nGlFVnWrHphGGXwB2Vd
 5qORuZvUO7clLt/aFsZYVW2BLpUCPL1K287rXg5rtzUJcXXVf+TZBOc/a7CQZlV9UTwcK8gZwZM
 ue5yJFiM=
X-Gm-Gg: AeBDieu0loYJZG9iYf4WPVHXwDJnuWlyxe6FwkR+UIhCJZclph1ZgGDwTBfY03sPaac
 anTb/f7xVXc+5d3J29T4emHu74XYVu2g8AiGjkkGrp8pCYfsbn4z9pm7FM/i83cjd5uSLhdfkhx
 0K6XNT1zctApoWxm5bGzUZh1BB5fAgIb0ozNSCs2V3J474gxX9FkB+XsDiwU8dbm7TNOr8htJVo
 FbTkh4nK5yI3PxBgB2cGYOmzWE2VznVn2rYrB11UPIPdbQIIq2EG9iCjz3/bLgiGmfPFNV4noGc
 qGBJjN5wdhkHuRyNKETc1/m2FfF83qabVJLdjAWTmF21ZxCFK8reuyqnCECYNSqHgqTv12ibMcG
 chYL3ZKTP5WAqfcaNaPfSYKfzHSu1PNrtgIRW/lb0mdaDPfA448DAZFNuFVuqdJZ00BqSIUO+Ph
 dJIPmpqMFKm4oxG1o5iVetn+0m9FoQZ3FAwsqW1PVgHUJh1f2qk+roFe4P/i9k399D+ZNWh4xBz
 Cuw
X-Received: by 2002:a05:6000:2c11:b0:43f:e9e2:efac with SMTP id
 ffacd0b85a97d-4493ce387abmr1987753f8f.5.1777525280202; 
 Wed, 29 Apr 2026 22:01:20 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5bf2sm10810748f8f.27.2026.04.29.22.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:01:19 -0700 (PDT)
Message-ID: <9b2bc0cf-8213-4ce9-9bae-a267f64cdca5@linaro.org>
Date: Thu, 30 Apr 2026 07:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/40] fpu: Introduce parts64_round_to_fmt
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 30/4/26 02:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h |  3 +++
>   fpu/softfloat.c               | 22 +++++++++++++++++++---
>   2 files changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

