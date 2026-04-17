Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B186F436A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDjNM-0006xp-Mg; Fri, 17 Apr 2026 09:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDjNL-0006xZ-MR
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:36:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDjNK-0003oL-8n
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:36:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b150559bso5748265e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776433008; x=1777037808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mShtuxJaJqzrioPkBLtonDyEYnArQLDycE8usXmr4qU=;
 b=IBiz05T3gMUIhW7BpW0KwQTUhdV5w4YAJV0XqEAVAZfkUuW8GtkYlJRkjKhS5EE9ld
 +EBmwpjRZXP6bq7JfU9+ac6Q3XuEyo6c1Oc3Xhkc9xT4nHTSOssfD8xzRm1yPy2FaowM
 tXT6PLfEtZPaPWZXAnNgkARdobNO2GEFRHEhcwD9xPQbMo13Z+gjHvJd/JydMUyfjyYx
 XJ4dxbFbZO8WLplbg4wyb6MrmzNRCt2yGjBs1k6FcWSm/njGB3JUNvsCaRZr2MQEGmMv
 xSmCkxb4g0pg0gPmpJEf+BDn4K0oQ76DIhPGm1sxhpnOzZJFp8Z7VQNNzN3LV90zeBxc
 qnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776433008; x=1777037808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mShtuxJaJqzrioPkBLtonDyEYnArQLDycE8usXmr4qU=;
 b=AzQgmYC9LQhiWa0Gfj3Je5rBbdfCC8Eg4BlPWIFdrq0GuEpjGFjURw3C7x9ZNQJISm
 foR2qjR7Ow6J4uSmKzOAiBp86P56DKEAoB5KmUcb6TUUi/hpHQ7YPnaQDeBfpdiZCwqm
 b/qONPxsJrFt7MZyc9xyth5/Iz9zHTkdh66CY4WWZx+H4XI6xAGgGfbK9eY6fakPnkX8
 5kj0pS8+GmUXjPbxK1TCQ+Q7sczNV1heHJc7lCWKjmKRcG4De7ZUZx04x82hDxKtUbtk
 I5uKIaLXnGYczaiLeBDw6bVDdGKTBD1M2CQ1FIOh/zEjOzEzH2bkgpfLbMLh5Bj0tk1m
 PCVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5Nibqjb7aY1BjviA9qF+DxnW6BiNocfnrtsdDTW2D8PgMTimg0aUFqLbawczLkooolQ6deJfttjeo@nongnu.org
X-Gm-Message-State: AOJu0YxqiL68k22/VbP7/UYi3kFn+X1+Il60QjxJwndLPlKlXzCQS5tx
 Ew3nTJhYT0HGN/BCwmuN0iTnqPXy4N7k9NxxMnylv5QxBweXwTJdSUFZzO4zF0KdYcs=
X-Gm-Gg: AeBDietcoXykCAwuWgcVatT33WU1MkrmNRqSmL+DutMQgo73NOV40ula1tD8/CwMuk3
 kLMUtjKykmmCCcS56OephPhNinR+5BtMXA/zDa7i/dPaeSmMNzyc01FBLXu0SMDQ3cujvdif5f3
 BumMjyGbpfFUTy7AZqCVDrq+YjkoWg9lJglu12cRYUBpg4HryX/T363PdZbtc5o/F8BNtdx8p1L
 ri3eSHbGWhwY2zfywe8PTxMc5Q17S57Yoac18QzJ80sMIRzfmIUkrppF+gtoSVME7XfpNglfjLE
 CqdDQeiXUUT0LSmMwkTod+bIlzIPiIyn9twUjmcR7zEHXXrLhiDA+vEp7Pwe1d4AvP3EiRvfRPi
 x1aDh74wxmgTELwzReU7Otey4xGUgMEQtPfqTy8pzQcbVbqTSu3tEPu7tVMPomacFgvlK2OikRN
 RwWwyUr+CB7Oy+P84AzpoR2NNA/dIA2H8JykoGSu2JCnkJZ2w4yJYNvff8dqmqWzxM2IyVZwwkM
 ZK7
X-Received: by 2002:adf:fe8b:0:b0:43f:e414:1bed with SMTP id
 ffacd0b85a97d-43fe4141c7bmr2851040f8f.0.1776433008207; 
 Fri, 17 Apr 2026 06:36:48 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc09b1sm4877983f8f.9.2026.04.17.06.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 06:36:47 -0700 (PDT)
Message-ID: <fbb50386-e2e9-436d-b488-68f81a47fe42@linaro.org>
Date: Fri, 17 Apr 2026 15:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] hw/sd/sdhci: Don't use bounce buffer for ADMA
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
 <20260417-sdcard-performance-b4-v4-4-119e66be10c2@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417-sdcard-performance-b4-v4-4-119e66be10c2@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/4/26 11:51, Christian Speich wrote:
> Currently, ADMA will temporarily store data into a local bounce buffer
> when transferring it. This will produce unneeded copies of the data and
> limit us to the bounce buffer size for each step.
> 
> This patch now maps the requested DMA address and passes this buffer
> directly to sdbus_{read,write}_data. This allows to pass much larger
> buffers down to increase the performance. sdbus_{read,write}_data is
> already able to handle arbitrary length and alignments, so we do not
> need to ensure this.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/sdhci.c | 102 +++++++++++++++++++++++++++++++---------------------------
>   1 file changed, 55 insertions(+), 47 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

