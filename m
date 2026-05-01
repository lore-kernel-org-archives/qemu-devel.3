Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BED9FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 08:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIj8i-0000q8-9O; Fri, 01 May 2026 04:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIj8e-0000pn-Qs
 for qemu-devel@nongnu.org; Fri, 01 May 2026 04:22:20 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIj8d-0006Iu-AS
 for qemu-devel@nongnu.org; Fri, 01 May 2026 04:22:20 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-651c366f7efso1848869d50.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 01:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777623738; cv=none;
 d=google.com; s=arc-20240605;
 b=SutDyt6augyPqEc/5AqCVn6zRfBOMnuuFjZpqubhCyEDsp4vFsJvhiFj/nJYngLbRW
 U6JJeuzfrDPRQ5nFYRI+/6zM8mWDOMSBXQ0pl+DyIgRcQmFi90m17Bg80Jw9NUiq9fuS
 HoWn0PY34ot+v+9nCNqVPw6p3zSoErSmGL5AUi/wMnRiMPfgFsqzSs4SvvPWGx++I2JM
 hAZpT7bzDzxA25DEGFQQNPjEtGhOXVaOBArRE+jizZJxx3v4p8KLfgnXpkC0chLUxIHp
 /cTAbvzpicSNyfD89QEuNKO9PwojtbB8D1D/srrGvbRyhj6ZRCcgPYK+7R2701GVoXq4
 zEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VBNpCNuiCpFV2nOlypxmB0JL1T6t5pZBpv1vCJf9xMk=;
 fh=67FIEAxCuvQIamkfYfieYWW8UW8BrMCsPo5FDyEN3kQ=;
 b=KY/AQ6Vt5oSaTVInajReKTf+svOLaelChArQsukcKQBuUVdrrTGxtamfrTjg2dTnQV
 HGExbXXF7oXLbnTSqARVx7gIrVvsDxzTGG72qSnB480wn+vgx3PEsx4Xsr+4czA6K7eE
 TkgqPTkMwuWLyr/xQlH5pimgck29b1EoBLncBGHIXP0MWE2drojWcaq9PmivrgE1zJmL
 wO+bapkFqDmugnJJfXyN2Ssg8iAJAH/Wv7Y6Lcr0Hb7IJuUB0NFc69FhkRv/+Ijt0RM5
 P0CTC/u9eZp6ib5LB5IMzU//OBsyNfdrjH2IBdBRwYROP1wgnI+NwT4Xt8xLOv4uUmXx
 P2VA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777623738; x=1778228538; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VBNpCNuiCpFV2nOlypxmB0JL1T6t5pZBpv1vCJf9xMk=;
 b=BcTLMR9FY47sN5cbxlC13URAUOwPR1/cGe7VxYPqqmB5j6uOfScX8ku57z1bXKkgJJ
 t6WO6C/lvUHsMLUbRNUL3JruFODOcwMytdFa8nl2NZnrU2O1gG7gyCUcHbJnOpb2UTB+
 08+1AoTP2QwtGyBPcU8oNOK3LBExnwtneFvB7fGEF4MimURf2oSo5uwl/2ISRhIcJoG8
 OIa3lE7eowF68bL02Tr57H9fAEQkzn+AQIFpeS+D+3S4U2HKAP3Xi/mSyp9zmZYyxkrP
 +oV4J+5APelD5gaCHxA/H01G7xBtR8bunZDNAqNgbYTMS3VECl6BXWbL6dunGlgd2ieu
 W66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777623738; x=1778228538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBNpCNuiCpFV2nOlypxmB0JL1T6t5pZBpv1vCJf9xMk=;
 b=oLpsm3elBiqT6gG4Uoqy8hLY0pfGbMm0mkJQe0a04K+5vTbWNDw4zd92Vukm3tTiAG
 yG66Q28tO655aoi2jP//ZAhk3zOtO6yuOgKDnyUObMYLRJGMT7myOyYgc9o3VJT3Edfq
 qN7f3L1KnwyzwWAcTaUfnmc3dludNmofzd0lZ53VT3UVmAwGLWmAvJem6NOezBpnEiJ1
 J8EcMvZquthzu5QvSLoH/u/RT+i7wQZQyvjDJvjXLw+fIni793Ui3cr05Bb7AZdtA+w5
 iTqCQl4jXpr4Dkn9MZRQxTdcZ0VOj0R52gj8QOttOeL+TECFtlsBDmnzZpFBfB/rA40+
 8ihQ==
X-Gm-Message-State: AOJu0YxYS95g6Iq6+SBXFNFlVLsLu5Au2cASYzyt3MAB1KADbTg1eolj
 I7yfcO+dz7LEwpqpiSlv0aWNfyKptSnU7ClyKFlWhwXow8yk/tFNc+YPsg3ED6vMzFAuOQYt3ML
 /PzQXvnRZ5cYfvNuCv94xPB2cEEbYjpWd+Qf7ZHep6Q==
X-Gm-Gg: AeBDietFYiaHJ2po+03qPzWasL/5D8yOsqAwOJc3PFd+wMXoFW5Ul+dC7vuBXwvb2vN
 JbQx8+VRa0QzxHGlpm+bDQrqBxPfpkG3ylcflPyOO5ziHa0LDYVVCx8Nnb5t4FFsguyZe1xD8MQ
 iAKk0RGMG+Dp51MSoNwbxQNFpnv6TLX7b2NiwE6CrAGe+WgVX57Lnv9AokKaDgKgBRk+38jtAor
 TC+AolYb/RKV+deIAHkFQKEoWJZ/FgAnQtonaFCHugTmE52JECPfNsnr2SjOkwaB7jsNM0KaBMN
 jYqXqgEzzPSfwlRMVsEtWOJPst5Yj5wBUDSg45pOa1hLSjfGFx56eSefwLb4+H0bKBeo2ihMiMH
 yidO5CpQMLd2P
X-Received: by 2002:a05:690e:191d:b0:654:1261:8b57 with SMTP id
 956f58d0204a3-65c30518267mr1806097d50.6.1777623737892; Fri, 01 May 2026
 01:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
 <20260429190532.26538-4-mohamed@unpredictable.fr>
In-Reply-To: <20260429190532.26538-4-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2026 09:22:06 +0100
X-Gm-Features: AVHnY4KuyM6gYc5WFFzASu4wWdDm24T8QkofWmZBaWEjMzwcNkGwL1CsRgsKUtI
Message-ID: <CAFEAcA-H-E4ERsz2534i5qVnr+VF9uy0N66MOs3QHmwkP8i1DQ@mail.gmail.com>
Subject: Re: [PATCH v21 03/15] accel, hw/arm, include/system/hvf:
 infrastructure changes for HVF vGIC
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 29 Apr 2026 at 20:05, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Misc changes needed for HVF vGIC enablement.
>
> Note: x86_64 macOS exposes interrupt controller virtualisation since macOS 12.
> Keeping an #ifdef here in case we end up supporting that...
>
> However, given that x86_64 macOS is on its way out, it'll probably (?)
> not be supported in QEMU.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

