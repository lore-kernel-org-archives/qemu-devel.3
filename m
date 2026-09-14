Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8433C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Aqe-0004HA-Ux; Mon, 14 Sep 2026 13:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6AqX-0004G4-9s
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:52:01 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6AqU-0000B4-1M
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:52:01 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66c9995ca60so49260d50.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 10:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789408316; cv=none;
 d=google.com; s=arc-20260327;
 b=G7kZNaEvI2+j/p75OMOzPeeavr6gawjLEhpkCGvKTp/Axum/QGOZ/G5J8lSpSMZkpU
 hru9AdBZQNpYKM7BZYJhQIwlt0YcbWbIR+8D6Iloqi6lbDNbPMFPwvhjL/8swiL8i+vJ
 AeRvA7DUzGPbReq6/53dTaKoIUegV1pj/wlDxscycAvos3DhJXdCI8SvjgY3NSko+Am7
 54HVrLXSJWsSM06a3+Xj+M8V+TrExuT0Bi9PLpfT+gfwgwXiltmMJt90iqQnQZoDX5JF
 UPGCQEQqr5cDupbzBO3iuTESi+uh8iTbPSg1ooTwNoQ8Ph0q9BKiP1NVtRxQYaMUYinJ
 uhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z+y9OUzhFJYi6VOAPvadEexAEwbMzmh1iwkml1S2xE0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=c10PLQET6+rJHA+5JQfyFWZZZ1Bdzaf+U0lolwfZB4UTsouq+5xyK/uAwhMIKZgKSB
 P/4jar2ghlKbcNMQsQ1DLEEs1XcKAHtd5HZKBRhUpp2Lr+ctSQ+cZWxbnF9EchFCr7fz
 sa2DX7rYAFKqBdsxt7lQcFBkNYgcsUVFKp/EmANp2powvZ6gXJcmeLwyMv8kIl1r5z16
 CBoLTsKkon8lqwMR8VBfMzdhQ0aynQ3WdeutjoWkmZ0N0RqcIMEHNm8U6h8QHpX8OIhD
 csw5w/tNxLnOyu6JDzPF60R1mOqfKdpEm/Om8SjBHH4ODMAV89ykssHSi4D2eX8zQYDu
 rz5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789408316; x=1790013116; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z+y9OUzhFJYi6VOAPvadEexAEwbMzmh1iwkml1S2xE0=;
 b=O4gWQ0vHMxgFC2VPN4arOF0Hj9TMmb7zKkO7t+xLmy3mCiKa+OBER44u/eBxHDI6vi
 C60BoZJi9WqKOm6NJgS1Wko9hz2s+5gM0Eji3rrMNpHAkK8HugmMPmKBqdVr4xGfDoP2
 7vID9WQHWqnbpWal5Fes9mF9ZKWVBsI3INqrVBWOjtlMARq3Rry6EFw9sm65copZDIbt
 8vVzaHv/MlA1CPVo2I+jtsrWAZXM4fHOG8UPUKPvvDTQEbg2by8k2poq2As/c22BuQjU
 riEgQ1KQet56QRffiaIUm3TivkabMYt757/G0p4GwNbffdKkzazzHf96gBU9vCufsDOr
 mQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789408316; x=1790013116;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z+y9OUzhFJYi6VOAPvadEexAEwbMzmh1iwkml1S2xE0=;
 b=YrGJPwZYJz/XXp+b/44v7/Kq1Z89xNdYsCmfSjsgvcKtZz4FCZTjEONzhImr6aZC3z
 PqA35HhZdCtkRZOOMWOqq+1Q5EVsBKp9oHa3dCuWZnsaRtFlRRXmsVwmEn3HCzIoEQ/1
 hBjTOTdGDhlttsUCEvxXpSDYB+ZzwiGZEUrfh1H7xChpPTPPWvnm4kAhTOXApsMXzvxb
 +Pdw4p18OW/iwYDqgf5cRNji1c+cGqfeDuI9ve4MbK6lxgxhe4Sz1kJSa/lS9Y7v8jcN
 Dh7F5UdsGKHmpaZonYygJpg720Z2sE4zeFEoujsxIFO3uwEb77SAn4PrkEx1oDVtkabA
 jyyQ==
X-Gm-Message-State: AFuF++lh839/Ar9uybOPh5+R+OVmMtun2LMbsCo9t0cxlkBabqfSZbzn
 hLeJj1YEzEHi2kHd5BYpS+qWZUHoSzME8LBuSJQrglB3HHkkeaMUxMFOcC7/OsygIc62H98WCvA
 zS3+jri6w0NbizObmSeSvUDUAgETwb4Ww6OEFDP/axw==
X-Gm-Gg: AYBFou3GrWr0hSN/LaN3JJ96+l/c4M9/Lz0NF2mPyU90Yw95Jb4IZGiOl4pbGDrD+FW
 hXRUbmUrcL16Fm/mOSEIR44zTLhDQYhn+rye/JPAOUUkPKmTUt1Qr8OwtK1i7/LPwtgEcfL9SKh
 c+QyEzADQAzrEoVaJymHn5vMoueY1F0vC4D312nUEeF/tXkFqZ5nalw8oAfZsMKUTZLAgp5LDhU
 G7L/txZ8Pe/Y1j+DT1rTXfFpDjZk7V65bO3kSFWL4jXISaqP3EcTUTOXyCFwEjMQSGTPhsCetTL
 qdiDePQ/30TK2ZWv4YV5BYpxzJCM5jeoQnAnZY2XQb6IFYW0XQt+hPCZeoMEK2djF4TdCo/14nU
 +PcqQeMuP2vUglIWhUqp/pczpg1v2GIeVlJsiGns=
X-Received: by 2002:a53:ac9e:0:b0:671:482b:fc72 with SMTP id
 956f58d0204a3-6715501ce81mr110439d50.32.1789408316287; Mon, 14 Sep 2026
 10:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260806173123.333423-1-richard.henderson@linaro.org>
 <20260806173123.333423-4-richard.henderson@linaro.org>
 <CAFEAcA-NoW=39G_m21zQO6CzH5UU3MnsKuFNjkjX-55gzXqD2g@mail.gmail.com>
 <a930c1b6-dd93-46ad-9e61-eafda9dcaac9@linaro.org>
In-Reply-To: <a930c1b6-dd93-46ad-9e61-eafda9dcaac9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 18:51:44 +0100
X-Gm-Features: AcwNN1UAMrlZMLL4c6UcZdvKECQiwi31H-8xgkYecW6cN_BvcU9IpsRw-nC5JBU
Message-ID: <CAFEAcA_-UwXB9svLsFwJRfe37+CkwkRHnNVoWDScTEL=L4uOpw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/arm: Implement HCR_EL2.TID3 trap on
 undefined TID3 registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 14 Sept 2026 at 18:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/13/26 23:16, Peter Maydell wrote:
> > On Thu, 6 Aug 2026 at 18:32, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> It is IMPLEMENTATION DEFINED whether HCR_EL2.TID3 traps on registers
> >> within the range which are not explicitly listed.  Previously we chose
> >> not to honor the TID3 bit.
> >>
> >> However, with FEAT_IDTE3 it becomes mandatory to honor SCR_EL3.TID3
> >> on these registers, so we might as well honor HCR_EL2.TID3 too.
> >
> > I thought we agreed not to change the behaviour here? Is this
> > just a "forgot to update commit message" thing?
> Oh, yes.  Because I did update the code to test for v8 in translate.c.

So what does this patch do? Is it just a no-behaviour-change
refactor so we have a place to add the SCR_EL3.TID3 check
in the following patch ?

-- PMM

