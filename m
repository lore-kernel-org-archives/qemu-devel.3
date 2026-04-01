Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C569A10F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xod-0007Y5-3a; Wed, 01 Apr 2026 11:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7xob-0007X9-UU
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:49:09 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7xoZ-0004Rv-SQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:49:09 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6501d242e3fso6135239d50.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775058546; cv=none;
 d=google.com; s=arc-20240605;
 b=AC71c/4XfozJek+o1eP6lpMkDa07exVdcgFAj+aa5yAgPFjDWmezp/UCi77NGdIwl5
 w4u8wWLyX7CpzpYBVgnJyVZpRpZUl+WttHJGYajQiOdNRQPvJ1WHL3uDvqxGHd9CATIL
 Du/00fFXrgnClWfedhF8MYs6CKaxNClNJzHWOJWVIAsEHRD2udmwm/G/QkMCVjiNYfiL
 HTi5PxEDfeuxMzD5G0+fGAuJRY2L/svJbmpa2HVj/tHogA09tYPr41n8XSN39fhQDHjI
 KKyQPieOnTF9I0u9Gwc8kdGvwI/43jfmjjsgVVGISxmYZXVggNmgK0CoUcc9rnFLGARC
 /3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CvqJeZrCQKWWtweqh2hPuERImWrZNUsGak5s0mm2Umw=;
 fh=5NmWRpsM0Pimq4b4GG2BklFc0fFQ0YVy6ORqc7oid8s=;
 b=T5djbdHGNJ8/5C8TNPdFprFGk2H5pPuZrZ/Bn/w2aPF0xp7m2f10zaj8H9V2jOLnQt
 kb7kMablkYtkFOKsLF75T+TvAZa+bB1t+SYiw4MiuzluA4MVVhP469sjulXoe7W3HIPM
 mpT0tHApPeSFKbCv4YUTLgaZXFdZdUV31RqYzOhkXKU4sjpOyObgabfB3qyMXVyCXDhC
 j0Mp9H2pPyhajMqcFEenbfYzlhTKiesmiMBXI3dnYC9Xwwgou59Insj8NHby8mA0FQHT
 fJDMJ8EjPV11FLoBSBL5hVyc7etCLfGdz1Pk3WmCD7pskKyKT2r75tzTzYkl67jdkosM
 UXIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775058546; x=1775663346; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvqJeZrCQKWWtweqh2hPuERImWrZNUsGak5s0mm2Umw=;
 b=XTpQssdgpGfURlWU1/ZtayFloFEVywaGVM5PywOkE+jKoi0mZtkVK64gQGCf8oh/1V
 tl3SSxwwOpWCMnLbEqtfS4cf/TC49UamHyMLf2xtRTLK0l3eUIlrhr5PBdoq5+goelBz
 6wrDccX6L7AvfrjBs44T3HcY104YmMhFYE5xcJE0TbpCrIfTunISPafctcfjhF5ge7cK
 cDHrjn/IerKRXvozt8AhGKeLQeI6RyLWC1rBwj3uRb+2bHUoMiZWXF5hS3TSHWR0gkHs
 yLVU4BrbjQKrDV6dI9lHd7FqOlWwMMnAj5Y0RKtraTtlRfsH4kJzfIG4zbtRKoC43sfT
 QGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775058546; x=1775663346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CvqJeZrCQKWWtweqh2hPuERImWrZNUsGak5s0mm2Umw=;
 b=CQQB3hluICX88hk3asuUetXAixF5LJhkCX6nIHWF0F1LgTlJmxNJ7GPXT0t/8O7Osg
 QsXfzAAI+Xj2QlN0wvVwfmrMi2rY02cAwR4igO8PhH6FIoUE7/thnzlhLMnQB9MRKsDP
 gRNLiuP2s8JpQhexgR18OBK43Yi43IqsEvAqF/CWuRd5Ngfo7FuHeoLnFVXTNyE88cIf
 w2dKqH3NBCwGpgR4yCyn6bJ5GzHT81r4J4wH8/3vnwqiGCcGCa9GKMCbWxL/wfv4W1uz
 eghUMeiZsxBVh9It/2678VbxmeVRKJIQsbUvdSdbGCwdkGnXxESjJrvA/VqbjlbXyTtj
 Dq3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWta2334BbltdC+883YlG6Bx9nXvfc7v6wgc2PD2diWbcib0aOBy/gIszBE/a9QFc76jc8NKpp14b9m@nongnu.org
X-Gm-Message-State: AOJu0Yz5jmrZecNjVylAIw3CkK8G6anjhfmMoLIOL9z7d2MTLnPiCR3R
 yQU0w54g2sqsLRopvdDOr98kFnlkdXz5El9WlU1au/O1hMYu3HaEp945+LM//LQNO5NmfnAuHXt
 vqxqAQ+Kjendfmdz1kh6wbJG0q/T6qVlqoBzLUDbQi7Jvm1q0bGvV9Sw=
X-Gm-Gg: ATEYQzxCk2q/u104zMyUxCH/fLRWAYf91tpn+rELdBbsmUNEK57lXPTtOus5WGJSlP1
 TguKSURjCBuMgPi6OfK9fD7uD7+UevrhYlLmRT5IAKKakFHyAiAhq8wh/uBrYecJQWG8CewYsNs
 r/geb+J63V0+K/QKBZWoWu2R4Joi0zT4IKvjjBmUNJwnsqw4x/squTqxIrNvt421xsIM5J0ze8I
 c5Hsp0+hs4qPrHdZIX/jn0e10PbD+qqDIDyW7oLluGSS6dUd3ZlYpfeSpCZqdKs15fs0KTAfXiG
 ZcptwZl9pHR1RLGT4ex3XUGP+4MK3JTfuT5ha43GzNrO4+gz5cmcObJ5yeFDQGdkKAw=
X-Received: by 2002:a53:d013:0:b0:650:37e7:e59f with SMTP id
 956f58d0204a3-65037e7ef0emr1371907d50.37.1775058545890; Wed, 01 Apr 2026
 08:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-4-alex.bennee@linaro.org>
 <595c4e17-c6c8-4281-bee2-8ed50d27d582@linaro.org>
 <87a4vmq1xt.fsf@draig.linaro.org>
In-Reply-To: <87a4vmq1xt.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Apr 2026 16:48:54 +0100
X-Gm-Features: AQROBzBoa7_1w4ECPtZIl57sfnFUWCfrLKLxKImFymTlRZU7S_zsJMZVkXhB328
Message-ID: <CAFEAcA-2xAodGOQmLXx95zARvNO_wjLWmKnCZB_4wfqnRG+U1g@mail.gmail.com>
Subject: Re: [RFC PATCH 03/35] target/arm: migrate FP/SIMD trap syndromes to
 registerfields
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 1 Apr 2026 at 13:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > On 3/20/26 23:05, Alex Benn=C3=A9e wrote:
> >>   static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_=
16bit,
> >>                                             int coproc)
> >>   {
> >>       /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA =3D=3D 0 */
> >> -    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
> >> -        | (is_16bit ? 0 : ARM_EL_IL)
> >> -        | (cv << 24) | (cond << 20) | coproc;
> >> -}
> >> +    uint32_t res =3D syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
> >> +    res =3D FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
> >
> > !is_16bit.  I'll not mention it again in the series, but take as
> > given.
>
> Impressive that I managed to run all our tests and nothing tripped up on
> this!

"!is_16bit" and "is_16bit ? 0 : 1" evaluate to the same thing...

-- PMM

