Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A905C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXfb-0008Dz-3Q; Thu, 27 Aug 2026 06:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzXfZ-0008Dn-Cf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:49:17 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzXfX-0000x1-AQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:49:17 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-857c51be779so2520447b3.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787827754; cv=none;
 d=google.com; s=arc-20260327;
 b=Tvd5mzQPmCyODjQLi5dV5NeCeD9h8Q/BHJ0XqJ+EyUHi7BbEPfIDQvqBwenaGtIWt7
 5HI3nCVeerMLwzn/NPSvi8yQXbnAVFdwm1+wKYIkkcMmhFboFg7b3KqCB82O3R+7ua1P
 4JYK9B+2sqGPYRLmYjzftxCwbffP3XuZuGdR3/IFyDe1sHpONrXzam8R/zET/yzHWdCW
 WUmPhVVbgKsK+1ABYPuUVvVZi5IWaoyXixBLPav3I5e2BrnUmYjXIRdLUFJo5KIGIItQ
 t37vtq5S1Ll9Wke3yHBB98gzFY7fL/IEjmiZQ5TCjB7pZp7XI/2UfYxWXHTwcFwruekR
 Ie0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=huQqSMe3N9uh++IkE+LiJ1JbhPmizm/crfaW4QRHI90=;
 fh=vwLn0QjPfybQ7TrkM/wEJNBHvvswDHP+AhH71hCDNA0=;
 b=V+M1kffQp/VnDOWVFlHYn+muyxGqPvNaeuBRN9dLazeKae+D3V1OirRIAppLkD/VWH
 aD/QWnR1vHPB1wWSiMrP56j9Up6XHFUOpypuYjhr6bVLtUmxFup2c8MWd7klMSr9jfpu
 pgwTgB20CGBpJVQE1Ymbpv4W90hSup6DqHXTeZ8ryT6GdXO4Q4mNpGgapwnpLZFLZZwv
 N+jf0gKDB+NUROEAX3wGLUKI2oWuR/079isTiSrftd4klUF1e26Vzx+UyL+jKkKhLaHl
 tEMQ+jivFo35dKx8klOJxNEG3VTod6GHm9Sm4N+pstYYW0J0j28JvGS+BHgbluc/xWHn
 gQYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787827754; x=1788432554; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=huQqSMe3N9uh++IkE+LiJ1JbhPmizm/crfaW4QRHI90=;
 b=RnjycLxITsPDbhqDgQT5uBpq9W+K/132UyY0RL1TjKVwuz9N7NJzBr4zRTChpx8GVA
 JiR8XAt5Hqeds+ypurky/Y8RRhm2DJiGfSI736s76BMqZlY3wvR1H2BHOIAZnl2cRY7x
 hDiFc3QhTzy1K3AhhuXzvMID04qQ7m+fQmVb8lMeARAM2RBTuo2dWExXwyBxx8NhTppx
 Yj9pCbF/9Kisy4yjT1vYFpu+a4gjH3sWOsD4qCemEMCYLUN0bTIiD+fBO0AKcJfftmug
 zBgz4R/05qQrmmBfW3h8TKve+PEOotQdj0cLMvPeiGiCzpm600lHH83XtkJXT8VzGbVl
 bL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787827754; x=1788432554;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=huQqSMe3N9uh++IkE+LiJ1JbhPmizm/crfaW4QRHI90=;
 b=LuMj+Z67WgMxjVnbTsc4U73xZkGuVCMNwjNQZYzU+ZDIR8EMt/8/f9tN5QD6wfMlvt
 MpzXDpMUBBlbHGT+C8+y+3ia2PTADak8VnwvMObsXa+SFhOGxB/qFubiTeGd9z5Za+u2
 yTqkmAdrlw/2pyyNsnH3bUVSOK7YfoHF9VdAsuRFlVhy6Xu/bYZ6wfvQEvQsj9emywpv
 Fe6TRMhsDa+UXKty9CvWmoqbMmRMgXd8LGr2z/RNVhumYR4c2PbDzk1vPehYC6gd6p4r
 fcB7xvKrdarLirO7xYs68XKFOxv2+fijP4hU+Ba3obQIwsKnte3xUZk6SOTlb0OsC15W
 Xp6w==
X-Gm-Message-State: AFuF++n/5NtI1BD7vrMoTgPr5CnNBf5mrw7kOQ+fVIcGMGuytiqlBgXX
 Yp2qtsVwpwMfJZExZlAWt192HKENXnIcFN/ZSI29tO/4VkgXdzCcNC/aP22+ZRd6MlxB9Fq501Y
 gFfKjCKnSuMR033E8O7RA+BuOzDy5TnoYi+eeWiCONQ==
X-Gm-Gg: AR+sD10iVGMGpUUbQaVmT+SqgJuE4Ius7A/B1ijbMuVCwD7mG7IOZgOMCzAzQB/CkQL
 jMKL4ZeNBZv16giHMNCchCK8AnYo895lYS4ENw1pHyba+TtDl7J55cQF35gtAPXUAnZmn+/yjZL
 fot/yBCaHsDhfFmRlZMvn0Dmre9btGCZ9461gyiSsiyBYh2uGsymRXLgRwqh0DE2F4UaXBL4Tm+
 W3NPLk1uM664tWyxUFQvXgkvq6r6UsvzF9TOM11KEK/T8s0V0VsfJozU0iPvGYTIIhQUXn5plal
 4LOR0F5ehdC2fhlvOyXgdka8mTLZ7Q2s2l8psm65/kbiZIb/YfvZ7juVp7VnV+24iyJepoAlhyN
 jRH1sMXBmNgRT64k6xg94jRx6RRcv
X-Received: by 2002:a05:690c:dc8:b0:814:6ca5:ef99 with SMTP id
 00721157ae682-8573de63a48mr61331057b3.16.1787827754004; Thu, 27 Aug 2026
 03:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <ZR6PR04MB44238851A057F385D7EECEAD3599AE2@ZR6PR04MB442388.eurprd04.prod.outlook.com>
In-Reply-To: <ZR6PR04MB44238851A057F385D7EECEAD3599AE2@ZR6PR04MB442388.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 11:49:01 +0100
X-Gm-Features: AcwNN1Wom0X-Gi8wRD6Z3y_L0FXEJZs1tHF3MnsdQ-maDAKPVqj_JDg1yDsptCk
Message-ID: <CAFEAcA9HP168y3nxkfBgKYjvWV8kTvypa5h2V4+bOVu33xWMhQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix TTA instruction S bit for IDAU-exempt
 addresses
To: Alexandre Frey <alexandre.frey@nxp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 26 Aug 2026 at 17:55, Alexandre Frey <alexandre.frey@nxp.com> wrote:
>
> The TTA (Test Target Alternate Domain) instruction is specific to
> ARMv8-M processors with the Security Extension (TrustZone). It allows
> Secure code to query the security attributes and access permissions of
> a memory address as seen from the Non-secure domain, and is typically
> used by Secure code to validate pointers received from Non-secure
> callers before dereferencing them.
>
> The TTA instruction incorrectly reports the S bit (bit 22) of the
> result register for IDAU-exempt addresses when executed from Secure
> state.
>
> According to the ARMv8-M Architecture Reference Manual (DDI0553B.z),
> the TTResp() pseudocode (E2.1.408) always calls SecurityCheck() with
> the current security state, regardless of the alt flag:
>
>   sAttributes = SecurityCheck(address, FALSE, IsSecure());
>
> The alt flag only affects which MPU bank is queried for the R/RW/MREGION
> fields. It does not affect the SAU/IDAU security attribute lookup that
> determines the S bit.
>
> For an IDAU-exempt address, SecurityCheck() (E2.1.366) sets:
>
>   result.ns = !isSecure;  // isSecure = current CPU security state
>
> So TTA executed from Secure state on an IDAU-exempt address should
> return S=1. This is confirmed by testing on real Cortex-M33 hardware.
>
> QEMU currently passes targetsec (which is flipped to !env->v7m.secure
> when alt=true) to v8m_security_lookup(), causing the IDAU-exempt path
> to set sattrs->ns = TRUE and return S=0 instead.
>
> Fix this by always passing the current security state to
> v8m_security_lookup(), as the spec requires.
>
> Signed-off-by: Alexandre Frey <alexandre.frey@nxp.com>
> ---
>  target/arm/tcg/m_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index f4ba93b..12ec191 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -2870,7 +2870,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
>
>      if (env->v7m.secure) {
>          v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
> -                            targetsec, &sattrs);
> +                            env->v7m.secure, &sattrs);
>          nsr = sattrs.ns && r;
>          nsrw = sattrs.ns && rw;
>      } else {

Applied to target-arm.next, thanks (and cc'd for stable backports).
I added a brief comment
        /* Note that security check is done as Secure even if alt is true */
for the benefit of future readers of the function.

thanks
-- PMM

