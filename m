Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9AFD17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34EU-0002Rx-Oc; Mon, 21 Oct 2024 22:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t34ET-0002RV-5z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:02:49 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t34ER-0000F8-O7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:02:48 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2ad9825a7so3379890a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729562566; x=1730167366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AHp20/sUgmilkAPw1DVAvLPVOmpI2mYpOlMBAld4tn0=;
 b=UgQsVF2TiZS85F0Vb6BUdGhMmaWuVd951C2snsmKdJCjxXzJKebvqYObvRf62AJ/tq
 zNjhMaX3nuYmXgOShpDDl6KibunqdK58m6fwnMB1jmiBYoARRvnRGsB04oMLBhJeBpRX
 uyJcnaXgHSdQJrt/+YlYTxlpdvE8Ndvl6cGmrswNadwn7tdwdjBLNmBpXUnFfS1Tq0cP
 k1XUbCcyepPrJX9dORWPMQwWI8OVAemfEk2auOv2ptbdPKzziEAdBUMJiv+gvmR2DUAd
 254Op/K87N04TNlCQjdn+kGowzj7QL7Z+IBXfJQ4/dCD+NU//NSvtS/muv56EkLC2uKU
 YDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729562566; x=1730167366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AHp20/sUgmilkAPw1DVAvLPVOmpI2mYpOlMBAld4tn0=;
 b=i6Inc6u6hKkhovkPOQqyd+GaYSdKPIm5LpJRBVzinTApdpvnLbDE0GcHBn3D4BPiMa
 xxPJJ91mNoe3+sCYUXQs4Opzkev7ky1XFFdAhV11K4A/wlcMe7t3cF+IXOru5CNulMYp
 GKEcZ0o1HlCu3lpEV2uST0iGc0R6hlKf5iodtzHtnnMrtlw3ns7aUefl7AzJbRlwynNM
 cB5Y+58gZ18qf8BDz7oVoAggzHcdFJDRhol89JamshEPfrL2Mc7VLWGYGhU7Ab5i+VzA
 wywbjhvNE7gmI+Z7+FKBLXuWiyJHIKeHqXEJ5zd+6GekXROPf5q9i+zrgajECjvYAwKB
 Awag==
X-Gm-Message-State: AOJu0YxkpUjyqJl7rCrozXvyq8hwuAlpQETv1tnXrqiuFOf0uu66uKNu
 CawikyFrEI/c8D7MnxuxVLLQWLW1zrT/34tCKrPV/gJUE+UyKONAh1Cq8fJ5z9c=
X-Google-Smtp-Source: AGHT+IGmhUqeHucijqQ09ej5aR+OtL7JV7ExToukakNtvaYuPpDpUDrrLmUybbMntXGKY9Va4MqqZw==
X-Received: by 2002:a17:90b:538f:b0:2e0:a926:19b1 with SMTP id
 98e67ed59e1d1-2e56172fd5bmr14577091a91.38.1729562566060; 
 Mon, 21 Oct 2024 19:02:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5e2029d29sm168260a91.1.2024.10.21.19.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 19:02:45 -0700 (PDT)
Message-ID: <f164ace6-0ef6-4c14-9642-39ce0b510a2d@linaro.org>
Date: Mon, 21 Oct 2024 19:02:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Emulate /proc/self/maps under mmap_lock
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20241014203441.387560-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241014203441.387560-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 10/14/24 13:34, Ilya Leoshkevich wrote:
> If one thread modifies the mappings and another thread prints them,
> a situation may occur that the printer thread sees a guest mapping
> without a corresponding host mapping, leading to a crash in
> open_self_maps_2().
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 7b7a3366e142 ("linux-user: Use walk_memory_regions for open_self_maps")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/syscall.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, queued.


r~

