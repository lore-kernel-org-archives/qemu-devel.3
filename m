Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5E4E88D63
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8m1p-000106-FA; Fri, 03 Apr 2026 17:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m1m-0000lq-EM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:26:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m1k-0004Ls-VH
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:26:06 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b24fdac394so22014725ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775251563; x=1775856363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kXVDAFigxpqAMaZ5AsV5mEiXkzVO5VRcIlBzElJ9mQs=;
 b=JSglxi4iQ+GPKAjctgOshkU6UzpXm1OVWjhm+YEc1YP5bCrmRtYaGEPWXUIUlHxtbm
 Ii0Vu9YjmVBE/DbPEpMaRf7NuMx5LufOBXldGAxokFVLxBm/a3sEsWmxStS0JU7Wy4OH
 Ukjvj6KuKfbEHaR817rF1SpiOTAk8DusuBBfBfK7aV2cCHS4ID2sK/qP3iGBr7n5wbtG
 iWKioW9rHcZ2r42+IAprGHPhmpmeEJnz1h13+nrPxo6E4iZ5H9EII17WpDEabKYalA/T
 sGVifiUTgu2Au/JmmpLhuI1smm8PAILXUg+dwbr3vbivWHfqNyBTu6DkRgwMsDCFSfZ4
 4gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775251563; x=1775856363;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kXVDAFigxpqAMaZ5AsV5mEiXkzVO5VRcIlBzElJ9mQs=;
 b=A+cfI9R/Z3TeGtZkO3oW3ZHwnKDyt7krJHd4hgn/Kx3VfmhjRL00GtyFaTSMukFn04
 PiKuc95DZaikbC/gwp6DHp10kjGtOYSTj2Qq/gEgtY6VLcReJQTh36AenBhqCC5EFSCR
 QAlNXAzmk4Wnvx6ZMJT/tVLHJhPCjmYDHIF/9sJVuvoownD1IU0NDmS+PYi1itQDATgf
 RD+jcwg71RcUbC7w+rVazwjwUk9jETGaa2ImwTiwwxIXCttwxrPeM4ZnJFAKU0xfAG8P
 hndvI30RV3vdXZHvCcTKfOSPt+hD1LgdkskBjKCncmWj5+/IbJj56g3YRN6HBBvTePis
 q1yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt5Qu4qyaIZ2ArVRLPVa7sfnWk1YMQv7BjxsiBrSDEfRkzev3HSt7gBirYwzh7VC0ZdxKJuDSa4R3E@nongnu.org
X-Gm-Message-State: AOJu0Yx7iOQ00URk0KZ2mvTzdalZcv369X6/0Z2Pougi/oPFzajAzUG5
 WgGF+7yRNXh6jekwMknSiFClVkvAM+HXxuJRjUXL1U5QsmDtPGLKwkPVEor9wmI/QnU=
X-Gm-Gg: AeBDievHveMHul9jK4t8BlczL5pyjKRqNLdukKegM+ncjLvGuBdIXfxCMAvR7uSStHY
 Hxpn9ZEHcr21y7NM0LHGEwdAlw13t6/LaPc+ZDjYt42Q2nkRALrUUl2lUm0Iu+f4BSy3nnkIy/X
 voYhDS3lDi3uH4C70HJqTovwhwJdWlG7NSxm/Gwkk3+V3/3aivUqqSDRtUoXL9AlW48Ddwqut/I
 NAxECT9TNFC4/+nfkQg/xgYfsF1FtSw2xtS1BjkAIGmH2yHnQRIS/rFP+VRDH6HEI1cCy1sYaKa
 rv3sViKHxcNWJddYOqwWTtTNJPgf/RrP1NJOsK5B8Dgdp5SFSCm1m1Eoe3ThbQXMxyVXv0Eu8Wv
 ukj6I5P7aaKPpYHL3DZDdXQ0vK3c6rHkUSCZ43CADcxVOg2QsRTcS42kxpngG4pnrFfSrZ5teH9
 oIDtqUro9qwml4e22M1NObVgUohlje3qbfCYV2K9N6xQgAuP2hNNBTQ8QIiHzw3JmH1wq4gdkJ2
 KTHZQ==
X-Received: by 2002:a17:903:3586:b0:2b0:b325:748a with SMTP id
 d9443c01a7336-2b281705e9fmr46641625ad.22.1775251562960; 
 Fri, 03 Apr 2026 14:26:02 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27475ff56sm65084735ad.22.2026.04.03.14.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:26:02 -0700 (PDT)
Message-ID: <b0da9537-e4ff-44c7-bc53-8bdbd9ce62ee@linaro.org>
Date: Sat, 4 Apr 2026 07:25:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 2/8] accel/kvm: Remove TARGET_KVM_HAVE_GUEST_DEBUG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401201753.92290-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/2/26 06:17, Philippe Mathieu-Daudé wrote:
> All targets except MIPS have TARGET_KVM_HAVE_GUEST_DEBUG=y.
> Declare the kvm_update_guest_debug() stub to MIPS and have
> TARGET_KVM_HAVE_GUEST_DEBUG be the default.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/aarch64-softmmu.mak     |  1 -
>   configs/targets/i386-softmmu.mak        |  1 -
>   configs/targets/loongarch64-softmmu.mak |  1 -
>   configs/targets/ppc-softmmu.mak         |  1 -
>   configs/targets/ppc64-softmmu.mak       |  1 -
>   configs/targets/riscv64-softmmu.mak     |  1 -
>   configs/targets/s390x-softmmu.mak       |  1 -
>   configs/targets/x86_64-softmmu.mak      |  1 -
>   include/system/kvm.h                    |  7 -------
>   include/system/kvm_int.h                |  2 --
>   accel/kvm/kvm-accel-ops.c               |  4 ----
>   accel/kvm/kvm-all.c                     | 13 ++-----------
>   target/mips/kvm.c                       |  5 +++++
>   13 files changed, 7 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

