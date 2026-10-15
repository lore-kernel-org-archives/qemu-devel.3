Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A071CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF65-00057J-Ku; Thu, 15 Oct 2026 02:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHF5N-0004gn-34
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:37:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHF5L-0006az-Fp
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:37:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4956869750eso32670085e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792046221; x=1792651021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dIGqrbzOxAw7g06eqadXfM441aCpvMHz3IX0UKu8WTU=;
 b=c5m5yinxXRE6xhZ4TcmpsdCxsVx6UniLeIbhFdSU2qArIFIPiyTJCOO3yiJ4BSoDe/
 ca8R/7cIXkye94vOkCIuG1oml3248Ue/zqEgb33XwOAyLimyI/dYpQj5F7Z2nqQZmB+W
 Mg3EhgYanTJBepSM4szEARBoGDCQaRwBpkpr/ivFSI1bXgKGoj/LDKKBJk5Ih3IHtRYC
 oIIlclnX5Jp2Q6OWfKcUzK8PxdzU2F4pAOT0wlO+Bl6MGcXjXYXh3CGMUOQ3rIuIO+JK
 PEsWo/nqRcZCuk7U1CnlHjKE7/0SZD4dX2sOHfdsrNgGvYTn6ZEadUhxbolUmIMEfAXb
 IdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792046221; x=1792651021;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dIGqrbzOxAw7g06eqadXfM441aCpvMHz3IX0UKu8WTU=;
 b=uCSC5KbaIkFxv6JGu+mQeL4AdpjP1ZHpUodlbNHLBLBblr/ioeKK7lpn5MxGDraT3p
 SK7T9JeeYqPqwvR3rvaOiaPHZeu7OpOXuah0Nv1yYp3Rp/60EfpbFVOPjeJzQgjAd73c
 F2lN713HwLgmhcqtC3ZS0rvYFX7D404qQTBNy6PR1NJf67Y5CXZdHjyYVYIfz3/0UOTR
 l/Gs0eiX+PMTqHSWdqI7VufZoP+Pc00kXcOEk+nI1oMVBYgQ1ygKiD3dH7gPuc4yu5vX
 4RasjJec38eHLeSEklYGeIzNt+ofWxKNjEP3ZRixdz4aiAvFew5c2CeqR3dMp4kiFAS4
 qXBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9O7gECnjwmVriE1enn0SfvpFFJXRuB3TA9VgU9Wcepkl/swV4e55wKBwpceUmhLudV/n3bWKShZnK@nongnu.org
X-Gm-Message-State: AFq9FYK8KQUoJ6jru3Xd1SITvoJnDFnuovtSWJwoP0KRTqC1eHF3EUoG
 UM7SHljM5VTA2SQXTfF+b4aeUcLnXwQdQD1Cjbn4uEgn/sl/lylU3PCk3YZL2rQl+I0=
X-Gm-Gg: AYBFou1T+DvzmiezzuQq4cIOZks1zSB3B292gQvhSbSF7PCwKooj5jJ5KxEkvmBqO2e
 x4xvyrvO2uX314Ls7ZvmNSD5sha/i9X8v+x7nTt55RHeh+W31YjEJhc9OubI/S/TgCEDewkRg1Z
 zweKdbuB1bjYYipTqz9ng4zljkKwoTe0vHM1GH6EcK5UAXy8tDRc6rQKJpENqpqrQty7F/3LbnA
 Pa/uyJG6MIux08GKHKnOWRY2OmGxHRoV9454DPwanIpL8cmbQwH6Fx2Q+NYfvkqDM9Lpq9WkPVN
 Ifwh+u+iWaePpDzr6ms43nAShJQpoEm55koNxTYdpUJ9GOfmAk90KR6TWvhtNGoWw3DV+mnaysc
 1tr3Iovy99Z53W8rP6SFi9DyFqOPPWsJtxETp+pQloDNpEIUZu9P/wNxWPlQ6qDxQDYz2IBQQVs
 mK6LPwsjr/Nc6dY+eLt3wx/4OS6rnXclIYXZTHKi6j8Y4hSr3kHQwyEi2MtkJ/4afRUk+9dkjSB
 68qYuit01nJ+vadi8DCgjjZCFYZ5bErL0JRRkd752tzJzHuoNk2iNAjfVb4P9KywrkNTOJMSALb
 plOsUkqBGBPvkEevW+q7lqmbmZgkNayd2hGMzt0y
X-Received: by 2002:a05:600c:1d0b:b0:4a0:13ea:2ec3 with SMTP id
 5b1f17b1804b1-4a18e4ddca6mr361235895e9.35.1792046220967; 
 Wed, 14 Oct 2026 23:37:00 -0700 (PDT)
Received: from ?IPV6:2003:ca:3f0f:8b00:a126:fdb7:f67:bb04?
 (p200300ca3f0f8b00a126fdb70f67bb04.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:a126:fdb7:f67:bb04])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd5eb046sm34475245e9.0.2026.10.14.23.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 23:37:00 -0700 (PDT)
Message-ID: <38f85822-5e61-4934-bb18-8eb14d08a445@linaro.org>
Date: Thu, 15 Oct 2026 08:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/alpha: Record masked exceptions in FPCR for /S
 insns
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com>
 <20261012-alpha-fpcr-status-s-v1-1-bc7efa6d5609@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261012-alpha-fpcr-status-s-v1-1-bc7efa6d5609@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/13/26 05:14, Matt Turner wrote:
> The trap qualifiers (/U, /V, /I) control whether an exception traps,
> but EV6 still records every exception in the FPCR status bits.  Commit
> 471d493047 ("target-alpha: Set fpcr_exc_status even for disabled
> exceptions") made helper_fp_exc_raise follow this, but in
> helper_fp_exc_raise_s it only added a second "exc &= ~ignore" and left
> the mask in the initializer, so for insns with software completion the
> masked exceptions still never reached env->fpcr.
> 
> The most visible effect is on inexact: the IEEE-mode code generated by
> gcc -mieee (e.g. ADDT/SU, DIVT/SUD) has no /I qualifier, so FE_INEXACT
> was never set.  Many of glibc's math tests fail because of that, and
> the narrowing functions such as f32addf64 return results 1ulp off
> because their round-to-odd step depends on inexact.
> 
> Record all exceptions first and only then apply the ignore mask, as
> helper_fp_exc_raise does.  Which exceptions trap is unchanged.
> 
> Fixes: 471d493047 ("target-alpha: Set fpcr_exc_status even for disabled exceptions")
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---
>   target/alpha/fpu_helper.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

