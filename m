Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF92C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlyY-0005qL-TM; Wed, 19 Aug 2026 15:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwlyW-0005pM-Ln
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:29:24 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwlyV-0005dV-63
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:29:24 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2d53197d8b5so13945265ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787167761; x=1787772561; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bZ81RTHiXjRiOf4VX95G4x+qZym9rEm0kU5yTWP5n3U=;
 b=Ut2s19pRPfByaUQbLPZx2WVuN/MeGoevVM9P5VkQcv3De5BQ5Gf+pj9pziF0J7BHlu
 sA8drBuTKKkSbkq/v0ULHY0Y3tWAKCcnqbub78g/OuZx49pCTHceJwL2R8uuW6fCsBqS
 JJ1PZ2grJhcr/pb8K3ZLqjBX8w/TJaQx0jjtsEp+6Mo+0hb35vUPzULkX9I8MSuGhplE
 PSWm7B6OHJuGsJI7sfNlsUjslahbtdR9fLMwP3sDiTcaOi+zD95Wi4o3XH+Sc4vDR+7C
 j9Iu7jAcXLRL5Hsdb4sWdOAzFbWNOlA+3vfj12wRr2MDPqp4Kb/iFc8T4MgvapnT1gnw
 Clqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787167761; x=1787772561;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bZ81RTHiXjRiOf4VX95G4x+qZym9rEm0kU5yTWP5n3U=;
 b=sddy20jmz4sLb2cz2hLIdwhCcsdFv706LBBxdXN84kSg+xNuiss4hrsOdYeEaXEXR7
 fKs7pO7lA6iwCEnLFoVIVynts9DyvtC8XGvc35qhw2Yn4ISgfWy8Q/cbaurr7M9EpOwm
 iKQPkNczEDYYBY+aWvfcIND+IgqCzygl+FchmHCPxpMbX1aDdg0w6Lhf0jfozihTzz1J
 dOgatVT09UVG7xXXtF8Vpb0A/7+COptvyH+rfUafESxgtW/dDFFM1h2Uh8UL92wyma9+
 pqnetI9l7lS0bm9aj1qBBxm91cUht9ZPEr1sr0GlChcDvF8Tmd4qDhP14GJLADC2r0sr
 i9lg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVcr3jgIHeZcSccmnDhahBW02Rhc3H+/BNbVN8/XrClfOm+nVZMnd25hmf/wNtnT/H4RxBkGLNiiCT@nongnu.org
X-Gm-Message-State: AFuF++mx5OVDcyjSTaJzJx2UdYZUxtrTnOB8Ze79t78k//hbnAOi/K6v
 z9Yf6lTnftwpA0cTLIOMi3B4E0+e7MTmIVd/XnWlaURHRy4XNgOjeRdW1EAEMLOFcm0=
X-Gm-Gg: AR+sD10Sok/utr0XaTuJZH+wEwolG2M6a+7zGKAHzBtQ3I6VmOoBohAQ9/jc26GJQcm
 P5WgvVaQauk7hNZovNqwKFR0OtM/FDdvZlyxN3GMhCiC6Qrh/pw1SpUXbf06VEk3l+abdM03C/C
 O0E+buhiVx/4mXxT/8CVLFHCEitfjIX8tPNsGxN+auQ6rQz1dm11j67rTZzSudiLbN5ywiayGC9
 ATi1gA8YBqVx0KDWr+9uV48N81rgs0fbRYE9NRSrEZy1pvLkKo6rtPVyVwP7WV0lvIQ4BOCsScb
 ZT6sF1DQttj7wqVTilqPNhB/etMlvZwVR7LY+YSrWIdRdC8dBAbaw+sB8Hho1xrOsZHZiHv3cAu
 IbG0QTqrwG+4lTPJBcTfbdWQu+m0ouIRPw3TuPxtXuSxDTEsQLdqVyyX/ArK5cfgBb+VIFL1UFv
 rE5KOOhVyzmAyMupR2lwe/PSlX0Ndw/cs++WwADTQvptgnWUVC4QE2qT3K2FwUWs32ka/gKDOLB
 HvRnvsI
X-Received: by 2002:a17:903:1a86:b0:2d1:1f73:3667 with SMTP id
 d9443c01a7336-2d5fd65fe83mr144124235ad.1.1787167761456; 
 Wed, 19 Aug 2026 12:29:21 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb499e81sm31171165ad.1.2026.08.19.12.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:29:21 -0700 (PDT)
Message-ID: <74b805d6-9565-48a0-80ec-89d6244de004@linaro.org>
Date: Wed, 19 Aug 2026 12:29:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't enforce alignment faults on Device
 memory for SCTLR.U == 0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260819190015.3555218-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819190015.3555218-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 8/19/26 12:00, Peter Maydell wrote:
> We enforce that we take alignment faults for unaligned accesses
> when the MMU is disabled or the access is to Device memory. This
> is correct for the new-style unaligned accesses rules that were
> introduced in ARMv6 when SCTLR.U == 1 and then became the only
> option from ARMv7 (where SCTLR.U is RES1). However, it isn't
> right for the old ARMv4 and ARMv5 setup (and ARMv6 when SCTLR.U = 0).
> 
> We don't emulate the v4/v5 alignment rules (which notably include
> "for unaligned LDR, do an aligned load and rotate"); but taking an
> alignment fault is definitely wrong and isn't what QEMU has
> traditionally done.  Restrict this behaviour to when SCTLR.U is 1.
> 
> (The other place we enable alignment checks on Device memory is in
> ptw.c, but we only set TLB_CHECK_ALIGNED for LPAE translations, which
> are guaranteed to be v7 or later.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/hflags.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

