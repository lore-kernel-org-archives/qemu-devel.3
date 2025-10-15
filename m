Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB280CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99Em-0006ds-5L; Wed, 15 Oct 2025 17:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Ei-0006QF-Cw
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:40:45 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Ee-0005NC-PD
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:40:44 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2681660d604so934675ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564435; x=1761169235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YOwesMzwLSu4uCr1Ef1IJ6OQT/hq4jOSRu/u7tcHxuM=;
 b=EnhjepcU0pWUStjpSecOGuI+zIfbiuakKqEYB2bISyEiSse7LEHKBioLPniYbsXvHQ
 tWNQyc7dhwXITjZaWuOusXeNY87BueUK18fQyKFOd9nS0aoWvWpjj5vrarB6t9fO7PbL
 c87xfTW5ulwAunCksHuQjrZDvuTXQbKL1Tekdie+gWuUPwpudRhsCM/xtL542VGPFIBN
 MwCwGem1jH8E8HKtvcIWFXcv8Ss9yX3+QEJLj2+LfbkroHZmh+Gq+zhbjAGAnk29RCk4
 +FRVAizTpM+Tt8RDXofkZeagxEzY8e5LWYTf5Eim6A8ZNcliWxizR+pYnR5/VztbxCXN
 BeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564435; x=1761169235;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YOwesMzwLSu4uCr1Ef1IJ6OQT/hq4jOSRu/u7tcHxuM=;
 b=SzI2Fgq98R/GNvNbfuq9+an0/fM3t/HjR5+y2+BbQ5RIgyQht1uy+b16KONvqw6Kvo
 GCsSnI6yNXODUnYAf9OtlWCA0tKnpUx4rs6PwxPFa2peTiA9lPSb+oXAFrh1BmWQqYD1
 mZfcd/YDDeGI5etiVsjiJenLT4jKoImyIg/nbvUnalQf/nQbiDrCoRUst+UazK3+/5Q7
 crxJu6stHmA+zjMS02xsXGk/YRxEZzC9UWpIKaKujrr59VskKSsDT358dRJYdOjINxin
 HqBrurQzJWMNQe2ixWBrUdIFAUrvnr7196J0W/lEm5PtDSJz8XBBJDOPIzeap96gXSGz
 Qh8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq4NEOva42sgJq1YkvDaBw/YareySO+z2REdHpM4cEVHZvX4PZLqRySA+4MbzDI8zf9yMSJRRca+Cs@nongnu.org
X-Gm-Message-State: AOJu0Yyg737/bcp68XV8PGMzZ96amV9OW7zRdX0mlC+hs2pvjn07LGlY
 Aooc7EwAaY+ZniV3KqtJ/gGVr3D5DeyT3NQuJZwc1TGyZPQK16cCiPezpgel6GB5rF3pMho2tmh
 w7YID4M4=
X-Gm-Gg: ASbGncviDZ3o4V6o246GHQ10yaON6qGyHsHyUiFtEsrQ5qT3JtRxhgx1HNLkURvYLba
 aCoWw1gmPvEh4BBSwbr1/Xdp6Ta9IPGpRe3CIJVd7uWWGLxAp7IRN/sGBbMfa5km8+ZSwb8nODD
 IZDDDLDbcpiPtvORTL7pqtVvzTTN7o1eWGAOjeWBXfFOSu1uHysnTjdSdSqHaWIO6FhlqKagYNv
 jkblHeOwqfsgLhpS8C0MZDMwOp317G9kv4Dx8ozNoTJ9ucLjuRvqO/C5x1nOB2qhuWSXxtfIEtP
 7dT8/c+3u0r0oMB0v79IpQOD8VqtDDmYCLbILCdnqC+Y63GAFFd3s513m78+YlwpyAjKkp6IiCZ
 jqYp/5NTkvDXOa2p52K601LKq5q7nhf4G+H0i2ZpXZYaWA4aYKtdAvCVujbdLdzJqb05/CPhNBD
 MYEdcthgbnwheTdJpLSw==
X-Google-Smtp-Source: AGHT+IFVVO7+s2WI6C0XZPiM8WRosv0HJmmyScrjawrDGwCGtSxKKc08LXmAPqavL9t7xArcyI3WHg==
X-Received: by 2002:a17:902:f791:b0:290:9576:d6ef with SMTP id
 d9443c01a7336-2909576d7c1mr11759095ad.54.1760564435253; 
 Wed, 15 Oct 2025 14:40:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aa32c4sm6248535ad.79.2025.10.15.14.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 14:40:34 -0700 (PDT)
Message-ID: <ef21f690-2721-4d12-ad41-6abdfa54a53f@linaro.org>
Date: Wed, 15 Oct 2025 14:40:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/alpha: Remove superfluous fetch() line
 from the clipper test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20251010144525.842462-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010144525.842462-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 10/10/25 07:45, Thomas Huth wrote:
> From: Thomas Huth<thuth@redhat.com>
> 
> The kernel asset is retrieved automatically via the uncompress()
> line below the fetch(), so the fetch() is simply not necessary here.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   tests/functional/alpha/test_clipper.py | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

