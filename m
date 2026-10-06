Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F6ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENFk-0000XU-IM; Wed, 07 Oct 2026 04:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEIxm-0001Fz-2V
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:09:09 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEIxk-00063E-8O
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:09:05 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-93e762768f3so120162385a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791346143; cv=none;
 d=google.com; s=arc-20260327;
 b=DYeqp7SE+bvciTi8POLkxtL6S5nULd5wFMlep8GdCAJmWGxuPZLQSeF1JZiL8ZoHYA
 II0v8drkFCBiqPeBI3vs1tFZX77guL+KvwiQezDCiijDOTLwKIxYjwNaAwK79xYvR9hr
 DKk8p/1/ip3Y2LCTspAmJGyGOhDjEQaNY1SMxbXvU9Vp1KvCIMxx4jawRZs5DsBlynzh
 3HKyMXgjiksTDo7ch5GOk4XaOi1Uftt/OBKQoNk9at3Jf7jswIamK8HMHn9y5NZooRjM
 G8D0O1gC2baH0lA9Oirzi/ram2hCpicGeaTfMpsrAg+DBIAOYkwoOQe2GDVkv3nEIXHF
 qGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Du0zmqlVKzPTLatL8CvnaXgKMPRU+UbaiplXLwqvu1c=;
 fh=ge1/1JX3My5LYP7Dp0cW7id18UDQSSoc7dq77veOpzA=;
 b=LfALOVBeEd+QcBajyDANxxUijU0ybm9CCj1Av92D4hNUM95ZZlcCxVcrRNj9S1XD01
 jfsJNbkafWg3oHhJqmtGgZ+32kCKJfM1cPXKoUaRNA+QQe7pKb5PFeXcpBMqwYfKOMsc
 CDCZdbMBAh7qCDJUfGZtn4DdZtc7FEUwRF15PMPzOa1KM7ervl7x3M+qappDaKZ24DTe
 gg3UVKzOxIvCzgGG7dzRlnPeJYn1zw2AyC2VX2A/VW0cdlDThGT9uQAbw6kgM2TQxfJZ
 1jjP5vbcyWOu+7gj7JaK+7pf8nYqnn0dSa/8K+OXGESXL9+EPDzeSi3y6FYG0b8jp5Z5
 dJSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791346143; x=1791950943; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Du0zmqlVKzPTLatL8CvnaXgKMPRU+UbaiplXLwqvu1c=;
 b=kGNN+3CYIrCsdI7g3OjlzAhPFsgWnkjaYu2GS5IXbmp8VryFjtQJ81szlApnTd8M6o
 qKFe00w7QdKkH6waKYHzPDBA9+oCrYUhl6u/WzSeUtH1QqdIjtQzhUD2LxtuTcQn2LLc
 iPNlN692epzghstKUjE0eM3VyvBkUvzTT/Y8QFPhHSHetvm9ION1UvgHFGv/Jh9KwbAs
 gmJ81obFT//40bz+fWdE36G4P7sxeMhbPlDVqRfsNlk9ezXvS/i2z/ja3vscGt4vvS/D
 N/rotvN43CxFztRdDO42U9cUdkmqYvoY28obq7D32APsuDTp3GI+3ZeTp+0hmnqWQUDi
 iObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791346143; x=1791950943;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Du0zmqlVKzPTLatL8CvnaXgKMPRU+UbaiplXLwqvu1c=;
 b=ilYb8X55doBcQVzwfYpVYjjAa0GsSK8S4TjFJZKJ7ePx8WFjFC3rahNjpxI4xIykSM
 kTdWoVK2/zTYuSW3cG7kGIEq0oDFccnNPRi2ebPn9C9TJZjpPxAAby8cEryYN/NFEDHt
 V7LwPATSiWiGr8RkhZ51pYFmznKB5hRe2hNKTFvSvl80/Ps1x4abRr+kA+XLaUbscNea
 u5XUJBjAc3CqYOZNUFwrV0GhFp83sEv1oDu2SepLWXMfRzE+26JWuxoXltuPGRL+hVTk
 QWFaZf5AY/W2xpcIX6AVP79F8WshF673Z1n407oTnhp96cA/ngW7mRD/LisPATKmpyyA
 w3pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGM9bUmDd6Um0QBDTTiF1iJxIT+U0uiHaZ/thFlCfmvi95jk2R0q5enn39eIB0lbpGJ0cHSGVxWPWH@nongnu.org
X-Gm-Message-State: AFuF++kxoGN6zjHoNAeifx0AdzErxjFOZ65tl0eDxNkQ/TU3/pq6HHHu
 T70pOATWd/tXQ3+/sqR7HkEp4SZMztPOSPKbSejhM/raBrTS7xb0q/GJd8L3caN0F/IKdlg8dIh
 73bM/MV78RlvTwnsg3kopldX0BNcscG1R8mUFauz54MOmyVcB51vzi50BiA==
X-Gm-Gg: AYBFou1HiKF2QoxsViFvAQigrV/9NBnCTudjQT4MV8GuRV7ON3jJJJFneEuP0MX/NDz
 3hIN/NYJ1jWlD4v0UamsBpl/4VUfevLyNi1WOdGsca8n9i0C+w11DSune4DT5BydzHnXc6pyZT8
 ZXQ9MmBkewtpLWa9eHjHvCncPi/qfshrJDzLOirqPWuK1POeyMAD8eAVOCKgxbuT5mXhboGj7Lz
 2xwjyexLQrJ0d7TOJWnQM/AZriM82NtimXxCyRHGuBy7gnAmhjutfvWuFIVabMVxK3XsoUwuwJ4
 ZG4wfU6ROF63REF8aVQExQqwPjGdDAc1YPl/CZM9NpsNFgVHgCYaD86ZS+y7EZfTsf+4gfRYqZo
 SO1wnxLTSICT6Ng54I0+kqe7kd1oUiBXt6RtyiFA=
X-Received: by 2002:a05:690c:e3ed:b0:88f:73b0:fa87 with SMTP id
 00721157ae682-8b04f40ec61mr5617027b3.11.1791292008877; Tue, 06 Oct 2026
 06:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260930094603.35969-1-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260930094603.35969-1-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2026 14:06:36 +0100
X-Gm-Features: AclHuK_NdCVVg5s2-ED_JoBTYVFQba1HCDUR72-OT7goj6rV8uHlsRg_KX_e92E
Message-ID: <CAFEAcA8jpReMhHKhxYpM7AVc70XZ9o0FV_iOg2mb-dOvwFg6VA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: add Cortex-M0+ CPU type
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=peter.maydell@linaro.org; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 30 Sept 2026 at 10:46, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> The Armv6-M Unprivileged/Privileged Extension is optional. While the
> Cortex-M0 does not implement it, the Cortex-M0+ may - and the RP2040
> Cortex-M0+ configuration in particular provides this extension.
>
> Add the cortex-m0plus CPU type, reusing the existing Cortex-M0
> initialization logic. Enable ARM_FEATURE_M_UNPRIV, introduced by commit
> 285e929908 ("target/arm: model Cortex-M0+ privilege extension"), and set
> the Cortex-M0+ MIDR used by the RP2040.
>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
> ---
> The Cortex-M0+ CPU type was previously included in:
>
>   [RFC PATCH v1 2/6] target/arm: model Cortex-M0+ privilege extension
>   https://lore.kernel.org/qemu-devel/20260914192323.29250-3-gilles.grimaud@univ-lille.fr/
>
> It is now submitted separately following review feedback.
>
>  target/arm/tcg/cpu-v7m.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index 48b31d5eac..ac99c93ec3 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -76,6 +76,15 @@ static void cortex_m0_initfn(Object *obj)
>      SET_IDREG(isar, ID_ISAR6, 0x00000000);
>  }
>
> +static void cortex_m0plus_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    cortex_m0_initfn(obj);

Better not to call the m0's initfn; instead set all the
features etc the M0+ needs here. (The two CPUs are named
very similarly but that doesn't mean much beyond marketing;
for QEMU's purposes they're just different CPUs.)

> +    set_feature(&cpu->env, ARM_FEATURE_M_UNPRIV);
> +    cpu->midr = 0x410cc601;
> +}
> +
>  static void cortex_m3_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -325,6 +334,8 @@ static void arm_v7m_class_init(ObjectClass *oc, const void *data)
>  static const ARMCPUInfo arm_v7m_cpus[] = {
>      { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
>                               .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m0plus", .initfn = cortex_m0plus_initfn,
> +                                .class_init = arm_v7m_class_init },
>      { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
>                               .class_init = arm_v7m_class_init },
>      { .name = "cortex-m4",   .initfn = cortex_m4_initfn,

We generally prefer to add CPUs together with the board model
that uses them, so you can include this patch in your RP2040 series.

thanks
-- PMM

