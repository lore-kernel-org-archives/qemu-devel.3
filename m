Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC25C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucK76-0002sI-NV; Thu, 17 Jul 2025 04:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucK72-0002nT-PZ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:37:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucK70-0002oD-Vi
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:37:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso410106f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752741425; x=1753346225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7RD8Sq8xGxltfRg2gpAeKzeKjiELPbaFso96la2dkgw=;
 b=K0IpL1OH+8HpfcPtpJbuTxDTPeT85ZdEo8AfooINsoahpU4R3FRco9mt5S0psU2U4D
 9k/CBIEULXJrV9gUk6qMOQ4LbUYQqsYOZH1NYSOLfwWa8OXnldEdfBEHJrhN3pVMCV0O
 GuJupYf6Cn6zF/21efrmMdn6jtPNkQsxNtQ65MptraP8DGZ4DdlBB9V+JmqxH4xIWyPE
 P5ZUTFsMNGYjjcOisjxUyD9NNwaWbIi6GfgplFTC3WhfrYgHshtQmQcNbDeDAPPExU/j
 SXWQR4p00TiMs6l9ecXXwivUJVfLaRktlF4/58MDE4g6q+4yQ4BMAPVNhf9YyxVWiPFe
 +rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752741425; x=1753346225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7RD8Sq8xGxltfRg2gpAeKzeKjiELPbaFso96la2dkgw=;
 b=TXHhHN/f23TTQWIFzFgiigt8cniUpZl36GRW7rRzk1L3VPw0MTVCcY5vcnw0SkbgmW
 lcxM7K7JU5AexToWnil3zIiwCJ14SgT+easnIxPodG4NmWV6jfThFLXwnJfIKR/a4e/7
 P6RjiT9qXAhtKwjFOKA4iIEEbeix7a/x5OfWUuPG6hYdVUmf8ziB2M9P+3cdrbg3B2ZX
 /rcbKbjf5k67ll3OUxpk4OsWX62k6FmF2D65AcqCgGu6pp+Oj35D6gPrZB3a2kqhV2Uq
 z/bMBNGv7RxE+DRpHKxH6UpZC/S3Qjp5Rh5PSJDhO8BCuapGNjxNxJuxCgFusjc1S/zU
 M4ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdEPhy1lyDNtReZ/wXzJpu1qEzcJcWAMrwclr5z3WRMO2t1EYzc9Y5SJBNS8Eop7OvoH4Rpn+uIW1J@nongnu.org
X-Gm-Message-State: AOJu0YzvPOLY80WiZpIIGO6RYG/nrtzFxTRZkec1VIeG4pEciqQu/vmS
 4/lyuS9xaRY9fUXkFDdMF16lRrvS6QJFeaSH+JX3wwGQIxYwMIGLecb0MSHelHfOXss=
X-Gm-Gg: ASbGncuRfFdsLE/v1ZABV7j3BluGxzd8Px2IzmPMHwYj2XZ0PaQhJHnhpzkMJvkELyh
 A4EEtIkNKNEOohi/lju/EzR1eUdhLNq6J8TuLFCuWyhAePcDDFvNVIkUn0kJGBpulE2wZhxAiKr
 jVvXr/cuy9SaWbvblkLmiHB+yr9y9kUx79mria4XRzovLYGlDIpNCN6wzANU+P+RQkUaDmsWbnf
 qc8rAL25cPZOEazbs3mzzDj7JcZEGAJa/8SSYhIb7kBemiPDTCUdcjRGhpBpMbl55jG5Oi1rQSq
 uM7ypQW4EP09HqP/wZLLYokoSHEKvy9gOsLNpMAa30ctgfqvc3x8+Gs9IPUBb9faXZcr5EX6PTG
 zeJTnKpDbMVCpG+jBvVaLr0ThvZJdK3pMaHBQhrmCdkmKgjzaWc0vSiy+r6aAipSn+A==
X-Google-Smtp-Source: AGHT+IET8wnwX6vLNgQzuFlhd9SiMxbPlUPaooNfKvHEJzJmcDxZ3xYq+dYVIwqDO1AM670n6VRQkg==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:f7e7:416b with SMTP id
 ffacd0b85a97d-3b613e66f70mr1768695f8f.16.1752741424939; 
 Thu, 17 Jul 2025 01:37:04 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1647sm20000606f8f.1.2025.07.17.01.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 01:37:04 -0700 (PDT)
Message-ID: <a2a3292c-f662-44e4-8b15-391428dab297@linaro.org>
Date: Thu, 17 Jul 2025 10:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] migration: HMP: Fix postcopy latency distribution
 label
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>
References: <20250716182648.30202-1-farosas@suse.de>
 <20250716182648.30202-3-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250716182648.30202-3-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 16/7/25 20:26, Fabiano Rosas wrote:
> Fix the loop condition to avoid having a label with "1000 us" instead
> of "1 ms".
> 
> Reported-by: Prasad Pandit <ppandit@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/migration-hmp-cmds.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Good catch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


