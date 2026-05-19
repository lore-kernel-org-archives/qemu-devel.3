Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016E7CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMMV-0006Wt-Ok; Tue, 19 May 2026 11:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPMMU-0006WS-3L
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:28:02 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPMMS-0000wM-7i
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:28:01 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-65c5361142fso3719833d50.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 08:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779204479; cv=none;
 d=google.com; s=arc-20240605;
 b=Ct8m5Aptrhb+P8dbYCvWmrh8mgY7S5xnOmTAyqAr/segp4WeZ5IXVsKTX1C8b424lr
 Oiu4mv7FCOYEwcWyy0P2f6NB3LpyvVqylQ7vgKaG6RnnsdT+BQC/q/sTWXQlcXBW2Wmu
 scsVjaDwJk2GsryKY5VqQyyASTi7+1Yrkf5D97WryDVTdJZNGLM7JmFQddUhV9LNjXZP
 mQftdQUbxB78ryMdgiDSYIn+m+fdNeajl9q1NfbY3J3rd9wgWeva43CQ/u0P0lAK6JzM
 sV9EmJcXUexM2gWsxzoYfJsdpacD38XPr+8MGleSqEuVToh7gfOD6XQMrjxVZjOovfGf
 Xl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sGrQGLNdI11dxVOlQcjvVQwr8FImet4PCaIQ6Gi2Tq4=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=c2pIpDSWr5Cp0qUBjoEEib7WRAwOXOFRDqMw6a/r/f24o8ux8kSOHManLD+nTAeFHS
 leBipTi+4mY8eAnJ7Hebo7Nuhq29Bnq7ncmLqvpAU9y5OkWXnu4gDtpN7jXAExwOzuhe
 Xxw3BI+3UFiTTEnkV+9ggak4LthYuCbSpbIT6lSeiJsut7bhEMVKZAVSV2QoV8f6wbar
 WXrTx14CTHuc2PMwr6CYXhpDyr4/L2no7hGVbMheMUSWQH6ua/dcr2IxmwAEcAeLmqbC
 6mp55THIA15FwBWbMHyJTpMI+KCOZTKPL6vp48PF0SQ+dBBIKGbN3D1O8uJl07ljWBJE
 +dXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779204479; x=1779809279; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sGrQGLNdI11dxVOlQcjvVQwr8FImet4PCaIQ6Gi2Tq4=;
 b=JwaPwdkI2t45cBCseAumVF22RhGwiRZHvqVR//7J2tHCZvyGIIqIkN0cY4WFBQdNf9
 BK/ydTLCWsCfF1wpH58vGAFUoxvbzR9SKIkz1uJ+2C09mrjNBhrfPgIJAjiZrScAa6xR
 gDoM1FMsIf74SYXPKVaFJNXab/rRPbvbCpYMnx87BLAMikjfsRTZ5E35diSc3wW4/mKG
 wJt1fYHBvWvlSWFINuhszYq94DhNUf2UcbnciUcVEKSInWn7laY6W0DONuvsTuonxdcq
 Obx9/Ktrlhk2Lcgtfegr2OaUfNQPTg7TJCTWbd6/1qmCyub8zELK3ys52sAy9HbXYqrn
 yw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204479; x=1779809279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGrQGLNdI11dxVOlQcjvVQwr8FImet4PCaIQ6Gi2Tq4=;
 b=fNeiYtk0FWvQPziskQIAXqnP6XGnFhkw0P0h0ABNHwD1iDimkUwSMJWFIV/2+5Y/4O
 p02tCFSg5e2V59aI+vBzADYoCekLmqRIOEABIrfKPdeMs/D9lp/unDNWnlaDmfn8nEfD
 5ugOEZgeGhIT/guqjnGmmJXTZ5N9h4KB3iSR33Lms8Hay3UzBCkA+ckt+3ZO9HM5K9I4
 /h4XGDUKQQ44sgSuNKjPOpKSHrxveUln3F2d0tevIXoZrjdirbcP1R17rfhNDgs06wy4
 z7ea7sozCjOifdLmUum5Kdj5uoAKDM5pbeX5QX/P8BSD9El4MJxDSQ7mxxdcdZhTckjf
 FmYw==
X-Gm-Message-State: AOJu0YwZ16d1J3ZxXBo2Bt7pjyMYYCwfvNLPVDxWEvM0g1nyZCVXVaMa
 FWO86LhD2he+YmBpdAezt+xdJhUQcT1NzOlpKPfD9OEV0QM7E7fpJiNbhRMmN9z4+q9BR/VCE0v
 LLAWHeXiMQh+COJWoS4S+s625ce97fxTC3/y//ih3HQ==
X-Gm-Gg: Acq92OFRozsqOdkIR7I5fivMZd14I9JXhL4eSYMvc74VxZuxQIPcCdwsbtB0JzRogP1
 MR8PveyGBAZWI5gXL39k8uJDB7p+LyNA0iiHUgUbUItMuxhL98BzWksE8sC1+6PzVPaOUe7ZrsO
 MSBkDxDusZkiAuQrrJqokgPL7R1NC1ePl1kM9FsBoGi9ng9B+MTlWydAYWLTCxURbJcSsBSk48r
 FiXuvna6+wxiZdbrtakHHSdHMoUrCDKN+TGKwjV9OJSsFj0SnThLJCyIGeuBmTMHXvswgFFg6X1
 Kw5ulh4sltngFrjiB8IEfT1CTg3hJbvcy6kXTbZTq7+kk5kfKs3IiGkZhojJYv2Bk1U=
X-Received: by 2002:a05:690e:1689:b0:65e:4e7d:9c3e with SMTP id
 956f58d0204a3-65e57b34374mr9120059d50.61.1779204478368; Tue, 19 May 2026
 08:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-31-richard.henderson@linaro.org>
 <CAFEAcA-q4GdT-uawv-hw6j9ixdO=Nw60hkJ=mq61G3CxRE5t0w@mail.gmail.com>
 <CAFEAcA_5nrmafaL8oGr9Oax5BJ=bJUXZ9XjNt0ZL4bcxzcebTQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_5nrmafaL8oGr9Oax5BJ=bJUXZ9XjNt0ZL4bcxzcebTQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 16:27:47 +0100
X-Gm-Features: AVHnY4L7BQirOr6E-xdMbApCddObIHgE08LpGnlK5A5PAKUwv3OdhXrxWcD3exw
Message-ID: <CAFEAcA_VS4xH09PwdpxuScsCrrkJtePp2x4ioTt1fMMTs5n+=g@mail.gmail.com>
Subject: Re: [PATCH v5 30/63] target/arm: Implement BFCVTN for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 19 May 2026 at 14:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> If we do take this approach we also need something like:
>
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -288,6 +288,7 @@ static void
> partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
>          p->frac_hi = E4M3_NORMAL_FRAC_MAX;
>      } else {
>          *p = partsN(default_nan)(s);
> +        fracN(allones)(p);
>      }
>  }
>
> because the NaN value from uncanon_e4m3_overflow isn't passed
> through the NaN handling part of uncanon.

This isn't sufficient for the e4m3_overflow case, because we
need to return a NaN with the sign of the input. In the
Arm pseudocode FP8Round() calls FP8Infinity() for the overflow
case for both E4M3 and E5M2; for E5M2 that function returns the
format's Infinity representation, but for E4M3 as there is no
Infinity it returns the NaN with the sign of the input.

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index d267bb4bbd..efd130bf16 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -287,7 +287,9 @@ static void
partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
         p->exp = fmt->exp_max;
         p->frac_hi = E4M3_NORMAL_FRAC_MAX;
     } else {
-        *p = partsN(default_nan)(s);
+        /* SNaN with sign of input */
+        p->cls = float_class_snan;
+        p->exp = INT_MAX;
+        fracN(allones)(p);
     }
 }

gives the right answers but IDK if riscv wants this behaviour
or some other one.

-- PMM

