Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613D4E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMpbl-0005W3-Kj; Sun, 15 Dec 2024 09:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpbk-0005Vl-HB
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:28:32 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpbi-0006Uc-WD
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:28:32 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e36b27b53so1565890a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734272909; x=1734877709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pdhn9ShrrlVKy6drOM3TwfNd8OW2Z9akz/c12lT5ppQ=;
 b=hqKlyHV7Nd0zqsy7s+6BG+711GIA9Oq2OJWTD1KCieidgt48sqok6WqG3ViKY851xQ
 bwbqb55GfvuT3UZlflP1Ghi3adlJF1OmwVBFJzZ0vDuL2BXxsjqn32I2VjRWFJz0Tw4E
 jR3nLZkL/aF+CFQNCQh19fWbyhpik3VGCir+MCCrsPfBy1LCNIxOKb2/Mpn7zfF8BgxE
 mhZ+l6cd3zIoqnXzAJP4vcvgeL5NnGbgEjK87k44wciO2WEvshPXv2iu3AVb74n90faT
 UlH4V2xyD38oacnVBHKqcVsVOW/zojQCSi7pf6XTdpk1ORrHdqUl4iJCirDl78CNMy+Q
 VkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734272909; x=1734877709;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pdhn9ShrrlVKy6drOM3TwfNd8OW2Z9akz/c12lT5ppQ=;
 b=JdUTZpaPRhKbkFNGYWD5YlH3qA3VfiuB3oP7kxZepy6CwbbtOX3dhPWPjWzOI7rfdm
 aB/yBM3LW6vHtVdVgZvGpLNLrX25U5Vx7G1IA42VJ6wiH/b6UBr9Pu1MSebsauKz8CH7
 ofSSBGxqPzT+zcmx5uwE9jcyP479oMmhkeP+qgtv8riwdqwW/vI3Wvz1U04KHnXvj2tI
 gnRUjSGqQmNk/4qiuxx8KNABgfHnN0sH5UNFqdVqtpVsFEvs2MNOM9WQ65itWOjASeZI
 8Qvu+KvarJbSoqSQuyFk5SgS8QzTxEphOPa3dQqI1FqXHWXpI7BsOvJ+D4Q4M8rTz1ez
 cMKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnZPUvTU0wD9pt6PCmf2ouCLSdSnOZgA52IyWWqUgQkOmnJg4I5VLjxBzCIFAqnzdFgc8ozuUistdZ@nongnu.org
X-Gm-Message-State: AOJu0YxFvh9ASDcclKTSNuiLUJh49iM6jUcZHHCi1cnQWtILd6PhNa4K
 MYjoO62DP+G8AX6vWRUgcMWUoL5pyVt+HHet1ojL9/7+xD4Zejz33NCcObvsJ4Y=
X-Gm-Gg: ASbGncvuRTzvGzRtkZXf9BhW1UCZYZeN3PCURLI2LlIce/40u3QRIhoCrGrqhkBWWU7
 qmv5EMh5JjAiSFJDxVc6iA3ghyQvJa/Vo2k0SNe6yTaLsM48PQzR4ZxcyUKs+JyqzPQBadFm+gp
 77qnvs5ndPAECv4co4OwCqqilS3KwqCPmsGWIFcTEEEHW26lLM5OaKDmWTJ92EQGAbYkHSS1/5W
 GAxzhl8V80LG6HO9ojgBher4sm47k4l1p1m4LqX9X8ARrorkAtpSDOX267F+3a9VrMDwVr4A1oj
 L7nqNQYgVon4/tZ97JgeiTfMxR599Jk7sFM=
X-Google-Smtp-Source: AGHT+IHF5MIcNFGT9PFh0deSH29ZqmSP91/3lTod6VaiJRFaUkfscpoezYXJHfh8Pi0yFkaSfHjNIw==
X-Received: by 2002:a05:6830:3103:b0:71e:240a:4803 with SMTP id
 46e09a7af769-71e3ba3ac84mr3765323a34.23.1734272909547; 
 Sun, 15 Dec 2024 06:28:29 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e484cc99esm851104a34.62.2024.12.15.06.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:28:28 -0800 (PST)
Message-ID: <db3fddae-76be-40f8-b916-708226779bf6@linaro.org>
Date: Sun, 15 Dec 2024 08:28:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] target/i386: fix RF handling for string instructions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 12/15/24 03:06, Paolo Bonzini wrote:
> RF must be set on traps and interrupts from a string instruction,
> except if they occur after the last iteration.  Ensure it is set
> before giving the main loop a chance to execute.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

