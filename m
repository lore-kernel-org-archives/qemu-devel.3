Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D30BC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTA50-0000Ym-Rt; Sat, 21 Jun 2025 22:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA4y-0000YJ-CC
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:05:08 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA4w-0007TD-Hw
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:05:08 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b31d592bbe8so2073005a12.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750557905; x=1751162705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j3RBWxlp3Vy+UYueKcO1eQe1DEMgNEeM9q98HXMtG9A=;
 b=zAR3uiAr5R53c0v9zvYsOsJYVLBkhHWu3fXcZKJ0ALY9QdwZwRznJe0rn2WvHlqZXL
 9gX1ovAFF7BeVFHcW2NVQnopqgwaDtxeTskNxQyYH8nuWrZhx3IZgfe3A3CVNrq+LDvq
 WHOiIPCadmmcBqNO46rkZ/O3iDhEi9kmPje23hevARqiOr2/bD3w9fHRWuRAUr5hQvLR
 iw/+oi+61GKhHQauiJhjZAa+D58Vt7VUnmB4Il5pSH70ltcSrTRF6+1WpXEOcT8nTnB2
 +O0YBrURb7BVgAXLR3opOTdutVwY6eCLFxnYksNCSTJQxOyR37whD1JKDfRWB6eK1RY7
 YR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750557905; x=1751162705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3RBWxlp3Vy+UYueKcO1eQe1DEMgNEeM9q98HXMtG9A=;
 b=AN13X9X093taRjds6QVPuUMarr9c4Y6kgOfzCOrpGiLEeICbffWfni/52jHwBC1zBw
 VxPiafnLPm23pHaiyId9vttdMNp9hSCpGUTmpPhkKf66Nk48u9st461/tJLqQuNANzVq
 Rj6Cug3ehFl0M5tOPYwqHEaaV3xyxBy3VYN8FhaFqrTnTCVa2O+Z2S+9A00CXyWZu2ND
 KovuLXj9KB6yyHRrB4W6tEy6d4ThV/OWknZWGM05buM6XK24esdWRCCNJUeadSyKB8Kp
 nU+ISfXjjuu3Yq5OqQsxdwoGeLV4tTcKRsSbOFTxEapqo7BFp36HhlFJpMasdGSEYgnl
 Hbbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiTtky8kN0wbFg2NaPrOzVB/G+fTjcs3UGJ1SCGh/beoHmfsGpjB7ev6NsoWfcqpqQc6AcwJiHPdvl@nongnu.org
X-Gm-Message-State: AOJu0YwZcSgCi7mdbtxriDypYTvXQyRz8TaapsxEHXJztJO21+S9vsuG
 w/lQykg/DClVfM7O+MvoPEUiMzvVcZ403sHWtvNIYYlEwIdVF5bxAwL2v0e3F3y7OOg=
X-Gm-Gg: ASbGncszAowK8SfOlvqi/MkE5XVcLyn1JO73B7JGYQyoKXwj/ZUaP6WTCPMZ1YhG7Uj
 vUCF3UQNmOyZYBeWWfVMAlLHK3GYEQQOJWkfPhp/2WGTTvT6MhLsd6dOFtUWDvHqiW5iJ/gFmW8
 jIls2RvhgEqGS/c089JcjTtzKop+v00BihSLFPkJJoWH8b8fyG7NluULIpFnXmdCb1iCt+8CIrz
 Co/MwLAuagttRZB8u2KtA1Y5aRgqhwSAbE3kjIOQKFzcEof/wtXZ2H22OZOI5SM7j+wFWElAOzt
 RN4Xv0ENocY/LNOCXSDtkcqppUe7jMmkl7/Z10DKM08G98kb8MWwXU7HqkRf8Qe4LElAy9HGG+q
 BFE9qUco/5IM6XGsisz25hWLUWYZY
X-Google-Smtp-Source: AGHT+IEpLymIcD5wNVFq0B/9ddvhqarH1xYWlyMapQN5ypjjWeffp/Rhu+LbxpB84TMiELuYbon50w==
X-Received: by 2002:a17:903:41c3:b0:235:91a:4d with SMTP id
 d9443c01a7336-237d9852ea9mr115469665ad.23.1750557904720; 
 Sat, 21 Jun 2025 19:05:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d87182b2sm50548815ad.231.2025.06.21.19.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:05:03 -0700 (PDT)
Message-ID: <810e9278-c928-4e06-86b7-26fc71e87e62@linaro.org>
Date: Sat, 21 Jun 2025 19:05:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 34/48] accel/kvm: Convert to
 AccelOpsClass::cpu_thread_routine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-35-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-35-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> By converting toAccelOpsClass::cpu_thread_routine we can
> let the common accel_create_vcpu_thread() create the thread.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/kvm/kvm-accel-ops.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

