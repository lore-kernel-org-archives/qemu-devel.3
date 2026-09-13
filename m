Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115FCC88E40
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 03:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5avp-0005pN-Rt; Sat, 12 Sep 2026 23:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5avo-0005oU-SH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:31:05 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5avm-0006yF-39
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:31:04 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso3324686a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 20:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789270258; x=1789875058; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0o5SYxek6plPn4fkQF86P9+LXv8vVx7gjk7fIvFwFVw=;
 b=i3qiYa/4+NvRFISyYjDbsHgxVhcG5Z+q9Cz8wOumnH9wrDxhp/MXP57h/FW9Bz1gyc
 CFezscL3c/gfG1yas5GzXqeXxCxbGr7LgbJSU5ixLaHxGaAHKEX43OEdtW4qarsUjrhY
 J9o/CqVo60bvGTED8x/lAM7np1oXzxpdQ6WKayTZS4CAbyT/KSDfDSqXbw2AqicNd1wH
 xKpUnBBSY7Rn7YhJ4joShJWATrsKFQW0hXCmNte7ECDE25p5lIgJfsAAgfAJGgnVc+7q
 2VkwZ03nrZW/2jIqAM50acoc9rc9SupHYx2XwkdFXYzCyqmSPfI2kTcFwAiZXhkptOcI
 znMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789270258; x=1789875058;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0o5SYxek6plPn4fkQF86P9+LXv8vVx7gjk7fIvFwFVw=;
 b=kKUirXw9nO3r4GDhtC4ZLiNTejjwQRF+1FqHwFtO+7TsJX9OIGAOqoqbyxE9j/CfYk
 oCTExbxjCSXizfuUI4l4xd4w+YuJjQcsru83g4mmYUf4/LDVxhxFp8ALxcqB8i2h6eHe
 6TMVvmhj6kMoa5pMQPhu5y8+8+/37NxeAcdxH2bDNd8Qsx4wICEdvOdgHZ0blf/lxlxH
 InH4by8YiBLekgNkkQ529MSVuyQr7UPMyPWtETcux9ypNIh2G8oP796sJuI4LQAdlnKy
 kk1xlaezkAWzvgRYGu6iCl9uedgBnM93mufBCiOReW3zz4XIIJrrpFpBl9qQL+VpJ2fI
 1Dfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwlObvkWx9o960462lsi/xa94YR36UWN7k90TdqwebomYVjdxyEyZQnLw6LZDxng/SUgTbGRq1Xv86@nongnu.org
X-Gm-Message-State: AFuF++md8LjP+CpDeXztGOASd5vp06BerLKQ+6xIH/QMx5PcYlYabs5u
 chlyBsvB7RHKvW01RNQWOf2JHRtyUge3mmLRW+jbNqXjWXGcNlzlvkLAOda9eZYt9Ok=
X-Gm-Gg: AYBFou19bzIKmo26243gnHkok8u3OR+cd/JENbu4GQDxqrFQe7mceXbqolBqI+7iiYR
 orAwgT9biLZGHtL38LxymeSjGaH6tc087NxMgQeKasMaHCyUmB1/RnRQtT4AXAseN3ccg+C2J9/
 CraoUfpD++GqwUEtA35MBDxqvFb7i7nFZQQMeFJ2vyoSDO3APvwEWVD4Ge/kvS88HWNrJ/xLL8W
 Aanea9GiYgt5YH1y4inccTUjIMHVe93umnNFwqtj4dptqPT2cQy03V0cbjldMwfArBqx7pPL5aV
 kplOSrJdIDb2qrr4deKmds6IMxFcMnC8lCVko0NBN4CabhPKoWpo+ahC5DytBR3e/nKOxOnM2CL
 scEg0G1iKrNIc/4NxuEiqGv672gpA3PHz+zB+i+Wvm9BxAWqiNKZytJ9GJFv/KaiBK+Qju3XEUQ
 hDVvczt9JKBipVdU5WXwkQbQ7vtDexXaVMTUAdlruKP9HIqUP55nJ2Xf5BI4xUxathOnJ/CMnaN
 yJfvrMPRo4XquVt4LGUPvnR+Hik0oEN3bbshhWfPNszKnrgw0/yUK2YCBxVpTKrcvvz9KI5
X-Received: by 2002:a17:90b:4b81:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-39d9bc6a1b8mr18907582a91.8.1789270258047; 
 Sat, 12 Sep 2026 20:30:58 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8f1f7sm14786661c88.11.2026.09.12.20.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 20:30:57 -0700 (PDT)
Message-ID: <9cd6b3d3-4f67-43b1-879e-7ec5b5edd7fe@linaro.org>
Date: Sat, 12 Sep 2026 17:30:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] accel/tcg: Document do_interrupt() callback
 contract
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260902152044.31291-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/2/26 05:20, Philippe Mathieu-Daudé wrote:
> Expand docstring to clarify the handler is called with BQL held.
> Add assertion that this callback is mandatory and never NULL, since
> all targets must implement interrupt handling.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h | 11 ++++++++++-
>   accel/tcg/cpu-exec.c        |  1 +
>   2 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

