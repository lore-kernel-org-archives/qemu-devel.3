Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53C6CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNhy-0001TW-II; Sat, 30 Aug 2025 11:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6iH-0003Dp-V5
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:32:49 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6iF-00077E-0u
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:32:49 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b4c72885c8bso1470888a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756503165; x=1757107965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RnLBRmA5/Inu3OcN7jj7H/GMmsk/+FIMHY9bKhpSdaM=;
 b=GINpwwrTEqS6V6tLRR0OE+J4Kh8wfI2jzphk2glPQYPLq7Fu2/MNPBxaKa3MO9PbkN
 ejhulbCNVdCSclRsmVvq+XuZvqv6hBmIhGr5Y+Bk94QaD1irAeU6oU11PRJvKR+bhWH0
 NXCWLxeB11i/DwY5sqtLdx/3GOFvVM1DItluAA+PbQATLjygYjoMSQsu/mCjb09JGeg+
 JcY6fyZgFvT/NM8zAaH7fv+KYBzcYl3IAnnWTEcV7KeSl7MS1EI2ifiWL+BRTwKYJFvI
 KhlL59uyiKmH34bS5hgOFZItOOY6oBBgo196KIz2HWmL2FzJBZTiGn2JWwZNBFcDaHjm
 Z7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756503165; x=1757107965;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RnLBRmA5/Inu3OcN7jj7H/GMmsk/+FIMHY9bKhpSdaM=;
 b=FBieHF06AJ0XnFJAWgsWTDJoFbMlLJCOUjrquI1Jf/AI2VAtCeMhBM0kWJEsjfghBv
 7+poaRSa+CXrPxzCu0V9e+9ul0vDxpTY4TgBiLiCU2vKxeUThH7pi7W/dUZH/G3Bmu4e
 cbhW8i/a6WnxHE9enmrT7wnl2yMZTeftGV82xaHzu1/FAbWKJOeexvU8iCP6hI4sxfsQ
 suFy0ykoo58cSSO+kSm9b5DlCBNi056FXAB7+v52UeGvJyZ3Zz67doiu+QjPWWG2E86k
 B/ybphTN+0VdWGJUlObAZs6+ixvIitTUYECwoocQADE+gOWYGfjiftuVTc08kdIOvwIX
 d0Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUju6FoBz6pjN1e0DmRWfdlaox8fWyJdHr2SFfMAvN1xjkVL+hRjBQH38+20JS2TEq7d6aTT3GFo2Yb@nongnu.org
X-Gm-Message-State: AOJu0YycW0pwiYXSQvKLgjyqa3+XVCq+YdLKHCr+JWLS9+E7NAla3HjP
 TN6oukUN/vjcFX6In01xlyvgw9RKmknWbfmuELfeHLmtpvGG8rIpABrZKlCGsbG2xD4=
X-Gm-Gg: ASbGncvslXrW/UZzgOjL8pV3DMqcxqcruAfFs6IJKrP7LGQi/Swzn2i8DFDvaxTSdzn
 IA1EUygaE0GiVFo1J8hGxML7uEy3KQwHrUXaWffYKxD6lJaVKjHG4F+R+aZnancxi4HW3ZuKRYF
 WRRdrfAzfVKlm0HL7nI5bp4GhA6sp4dugGl8ciVf6jUFWXkUiZG2ccqNHKEWrxX7YQ5LiM76mMB
 eATh3+0IUI7maH+Z1LqQ4efy4M8oNRSgm82ANv7rLz0YKJF2Iakxg/Fbemw+i2mN2eAXHn3KLje
 iZR8CCCkfUv+odpn9qE2geoXAqIbs3USk2GhcGno/KJ2omgxgGwJBFvkFYcZ62Q5oVBJU8XwCWt
 QX+0wLSMdN8wNe0jSi68vm4b4znVSdItcoywBIMXquvCew/apWIIoJYzWh3t2e/6BQEvYBghD7m
 uQu11MHx4=
X-Google-Smtp-Source: AGHT+IFakS0+rpdNXwjuy99OnKtjmr7VDVR68459dfqHU0uA74HY6b9AVoDIEKT4oM9DmnafVwiOLw==
X-Received: by 2002:a17:903:3884:b0:246:7a11:3775 with SMTP id
 d9443c01a7336-24944aec4admr839905ad.48.1756503165447; 
 Fri, 29 Aug 2025 14:32:45 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd366f95asm3042215a12.51.2025.08.29.14.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:32:45 -0700 (PDT)
Message-ID: <813a9ff0-8979-4fd1-b412-5538688c7965@linaro.org>
Date: Sat, 30 Aug 2025 07:32:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] target/sparc: limit cpu_check_irqs to system
 emulation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829152909.1589668-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829152909.1589668-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 8/30/25 01:28, Paolo Bonzini wrote:
> It is not used by user-mode emulation and is the only caller of
> cpu_interrupt() in qemu-sparc* binaries.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/sparc/int32_helper.c | 2 ++
>   target/sparc/int64_helper.c | 2 ++
>   2 files changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



