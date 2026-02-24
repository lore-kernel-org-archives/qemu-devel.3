Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9042F357C5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvtq-0001jR-SU; Tue, 24 Feb 2026 12:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvtm-0001j3-Kf
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:08:38 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvtk-00068L-Ro
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:08:38 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9707fc11so1377799d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:08:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771952915; cv=none;
 d=google.com; s=arc-20240605;
 b=j3UpECmE5S9vguaJ3ON3aRZhF0uUUfgG1v033Oe4IhS2v6nlKlsDaXT4GImFkHUPFL
 8I40pWuvmZpSIVqruazoFw3vswkTmJ8KfrdhMVEKNaAUPyJmlksKj+8mdEoY4gxL3l+d
 g2kKdvlH1wWA6CDI3bRDk2Wj7jdAFoHi1vKluNfPB+SwODGCK1j8PhmmRxTgoj/Ft2pC
 rPnkyF/9sUK6yIrQWBjjp4QnfucJYsBCVHm2R49ULwT/kyM0xhs1j2fhp4GEFsmMtlM5
 gatllOo9dWu8NCDPz97OmrcVR8T48ZJA6yPhtmkOfkqd6LJQnHpdEoVfH2lJuCQgnQv8
 Dp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JCK2+HRfzyKjKq4I9ueyjdjn4gWopG0uuA219YFZRAI=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=gGSb2jsFEKDLB/ABdYkq8Fmm4wvxYvFlw9fWKitFtjccVStPO9njudmzwO0f8hCVmd
 ommM5Zc9lh5lZNdO8tOgpVDR6EwbziJuEmh+IwVkKqblWd/Bgy+y5fDZa6B984Z//Hme
 B31xGxMWyDSW+H2/2VqnjwPzTknE5mmAysjK73HHpvfZ0ZzJ6saDCEIIqivXXtt620RY
 TfSLCvk7wflT9JDXBn3szXUQ7rTq/1YE6OsAxpeEllHhSMUxPVMWn2Q3K2GUf2Td+Oe5
 SWu7oKJDYRFE+RbqsTzW85OePeUGBdATzuKaUy0nF9mNOa15LG5L7FPPagGYN1+rOxPY
 0V1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771952915; x=1772557715; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JCK2+HRfzyKjKq4I9ueyjdjn4gWopG0uuA219YFZRAI=;
 b=zm/eM33j1UFxQLZQPA/nb7MFCPOEkrSbAFDx+v2PjyJaT3ydBK6CGafbgwIrVyPGR+
 4eX8LN0DRdV8lqnphHkdSS2Vf+5LOJiYUHgZLA0r6KzY2V/pijs9w2A9nXv65TgIvOF8
 dM61IsQuGTE2sy6khxMUn5NrkpujuW4NC8Jdknd0QBua9wudDAfB8bvdKSB136V1ijYl
 uA/y9SyAJilAsQtsFGZTHdmY6/8HfFskYE4p4LWISd2A/zfqrq70vh38DgJbKOhOEIWN
 AbrYOb0FHCPIBIKbYLW+pCNcHqGGnLlwPLwWarNizuHXvz14alLAmVhybcwmuYtL6fKT
 9uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771952915; x=1772557715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCK2+HRfzyKjKq4I9ueyjdjn4gWopG0uuA219YFZRAI=;
 b=IMsFGWZG2lbI8mnzEWm77ZsI8ssC0SywUzDsS3pxiih2B9Y8tWkg3vlepgOIPG2znb
 k+t+XfoaaPqWgpFe3W71fsX7UvTecNB20P6cI4n3j650cMUN0seljS7ui0iF1ZAeqsX2
 9rEBlTFfvRST6ecstN5lkU4chVp5pwiNuzyPF/4hSgUhPyB/9doyzkmibVN/QBNFPUq8
 nHS+j4CgyDgAhpFTcAPWbGVXEQyV9eAdqEHLViyF562MJsLsv7YvTU3uAGEHni31scx6
 J6seeEePSBcCz6yuVe8uoDIbOjk/75p82lvknWw6qmPciB0++YuX2JP7EPoDQ1ZaYwzg
 iq5g==
X-Gm-Message-State: AOJu0YyfchkKVNHy7ifEEeOpTFM/RgQ9CsOBpfjdUCtwcrnuGNFWqhDa
 oMDroiaEBGh/LwhH1b3MMOJtesA+HLip9gwMNapUqjZsF6RlK4xoYaEHJxqeJC4EvAlgFZLJFiX
 wErounBjGPPmlN9gcwr3TgHL8dQvl/Iq0epzg0trSVP0Srii+a3qd
X-Gm-Gg: ATEYQzz6AkH59DSwvgmnVoXHq0hOOE2yfwHvtOfRWwrD1BeH3ITOp03Y55QD/b3TJem
 gws3EOd+H/VKQiS7pEfVlp5YUjdERHaLwbjl6FCa8uYzXBZ4RixICIY07utlZGLpPd8ifjFB2/H
 bmrilGBhznwIuP6s2/JuthYpAJKT3hE4VJqUKaRe7ILL85aS2r2NrabZiX0d3XcL2PF1dIm2o5i
 dDeX1cpucLTtN7/9nNuS0LGlY136ik8KXDTcztr/on9BixJRNWxixeeXTNJUtsoizG23ud/M/bE
 gLelTqiZEOCy1aZIHlrET1CNFb163i6eC1m+Zvd8ysPZXZH1GfC428N0q3rkdka+mOU=
X-Received: by 2002:a05:690e:142:b0:649:44ac:cc01 with SMTP id
 956f58d0204a3-64c78e3f96dmr8772857d50.55.1771952915034; Tue, 24 Feb 2026
 09:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:08:23 +0000
X-Gm-Features: AaiRm501BahcmULcmfIJZ3y0p9lNL_gR3riUsdu855FJHnJvyh_Ku4aBWK_k_fQ
Message-ID: <CAFEAcA9ChSZchdz+17-ee3CzWK6g_BsbEz9_DQ--F+Ek037JLA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] target/arm: Support SME for KVM
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 16 Feb 2026 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> RFC mostly because the kernel support is not yet upsteam.
> This is based on
>
> https://lore.kernel.org/linux-arm-kernel/20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org/
>
> Properly testing this will take more time.  I'm not 100%
> sure how to confirm that the SME registers have the correct
> value across migration.

Am I right that patches 2-8 in here:

>   target/arm: Remove aarch64 test for kvm
>   target/arm: Move kvm_arm_sve_get_vls within kvm.c
>   target/arm: Init sve_vq in kvm_arm_set_cpu_features_from_host
>   target/arm: Move kvm test out of cpu_arm_set_sve
>   target/arm: Drop kvm_arm_sve_supported
>   target/arm: Remove kvm test in arm_set_pmu
>   target/arm: Drop kvm_arm_pmu_supported

are preparatory cleanups that don't depend on the new
linux-headers changes?

(also maybe 10 and 11)

thanks
-- PMM

