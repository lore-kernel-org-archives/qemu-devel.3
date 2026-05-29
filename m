Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FA6CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 08:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSspw-0008AC-Pf; Fri, 29 May 2026 04:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSspu-00089R-Ho
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:44:58 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSsps-0001I0-F2
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:44:58 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65e15fb394bso9713350d50.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780044295; cv=none;
 d=google.com; s=arc-20240605;
 b=Lkbsj/W9untCLb3BKUeOSb73O4s2X3CdKXD6RZNq6ur27oAih1NtaJlDPzTmK/8QCZ
 +6+itSCbjuxQXZRX44Dfqo7sqXo8PrAKmpqMue4+WQ9A2SFEtKJEyOL7mEHTi6MdmsM+
 zRwXKxvtByiWMRdeMCttK0RIEW0M9IxsFa+uW30sjDVUG8CNjSvKNjkLgAKsxyrtb1bp
 i9XXZf9bpQvXbhimveX1Xl07tGfUwqC1MAY0Cb3M6cUYsJftfOl6AaE1JCYnv6D/kdiV
 J7xK5IQIStOgMTw1qptqV/E3yZIWredrYxGj1ytdyeS3CMZQd7pVrULS+EgvcDoMRSPy
 Zy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ipZEZnY2uFh45UZO5kuYZhzJoHYpiPS/VC9qdhC/puY=;
 fh=dsV49Vvr1tHDyBDRldQbgGjKbfoIR7Zf+IuqY0dMFP8=;
 b=BR6tjPwlmUNoT2sB+yO4UultiyP6UKuWtNxnb70xhS+If7GyMA91YYxN3DBl4gh6iv
 rIF+9PgrT88g3+p4QLOUzim8KToHHHA7X3vrnix1RhI6Dp11SZl2MqD0MWXnqgw1WZZ6
 IuNCjDHNOYuflWM5ag6cvoWwTd7koMNbICfBg4iooYXVnGPzbVuNQeKS471ewURDjqY9
 YvfZlZh5/35KTHE48w7U49RynaXfBsqUMJpsRrlRrnuhmgTmAsvheuNH2L6JvkqDAeR+
 Y1RJT+RlN+vNtqLh2HTP4ImDZEAy2fMYx/UzAM/MLpp8YqoOpuTILLgMm+WbalikgvMj
 y5Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780044295; x=1780649095; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ipZEZnY2uFh45UZO5kuYZhzJoHYpiPS/VC9qdhC/puY=;
 b=M+/McFIZEU21xAxy1Uv8tioePl6mANfnyOHnkpnrl3AUQKo4lx4AsW9n3smzeT1mYr
 I3PKpkcUa8twWtLt7MzJsqyAG1IqB/qX/j5iJtxi9dIFTKobLOW0bhMB0h7nJU8VcXyr
 AWN+CHt7yYFnVYwvoIh4z9zk6/wnMIia+4kxalq44b9wf7lYly3kgiKMno162RBXQcy9
 IC1VkEZGqJd7nbBzWeGiEJW9T482KrNBHJ3qVYvWJIX2bv5OT30S2JueivQYN8srw59V
 NqT8dQjyhZITsXRRjdaWu6PFjXI9G93nL+qUwg+Nw1Zeb5aS4YcLAuiWM/sXSK++0aSq
 c1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780044295; x=1780649095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipZEZnY2uFh45UZO5kuYZhzJoHYpiPS/VC9qdhC/puY=;
 b=JNdAxBOp5uqhjNpaph3Uy6Q+uhZyp1mrQkwuHnCjsULhQoft2zGamcC4FDt3n2JKmh
 Uw+hvV785NfhyKzZTzzFOK1EjdbyYTlQ/iI3tc0uwdFm+a8lqoZp97iv8W1+8eJxLBWg
 jRf2eBSKwJGhVDMzbhC64Dj/Vbm3bJZKquBtre+foWeMoEgzB9yyEKRRFjrihmTOFlqj
 O8u3umjwhZab81W44e/VSf4lNsa9PT0v5nE+t1i2bfDkY7bWULikagutFN9alDHhUSN/
 KSoq2O8fVWwCjUoKzmijUN6qLIoxBYuFxayjZIFCNeZ0UhKzzujuMwA82HiWzMThyyCM
 waJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IX4hdxULOiFAtYhxsmfVAAONwD4V/bnSVIbRjCaXmy4BdbtKkRy+PDkBhmSEC3AN5/ZVOZMLOIaJm@nongnu.org
X-Gm-Message-State: AOJu0YzjI5EQRG3Shz7FNFu5BjGuYtFmeIdCVyWox78/msGvbnruK/mI
 LOKkPEMcNhiwpanvvsVwlSXCloMmomCqIawmSHySsvNnbL2y+nfUe80KnuTXTgI6w9Vdc4jefP1
 6YvL8kX8Q9Pyx8R1tInA+PugWnREZR+CLCiMTAE6P/g==
X-Gm-Gg: Acq92OEpXFRBTMp3T3qYADgTCS77ucQGZzIi9rAKWBsda1qurW/Y52j1CDcQTrIESVo
 nhLJ9EPSdyrBawlUrCNzGGPCc6aCYftnaeLG4DEGVhbQR6ueO93dv0MPBLEBtWScfgXD71pKaxx
 I1afMApxAza/XD9mA4OfmB0BUduSC1d7xy88S4A2QlCW9nrbtz3wvRN5Lq2WTQPO1Kpy8vt1/J9
 r2phXEUZbd+vY0E9CyzGpwzKe/N+etzZ+6nEnA7u+v+djNEpEw5cRwSagLwQIM52TnDES5Xn8v6
 JiMDIMtU6qEH70lobr7OzzkxhttwPzQ8M2p40yzoyEB1QKi+G9Icr3QM8W7JFvAzb3UYCnDIGXG
 A7RiPXLYyYYQM
X-Received: by 2002:a05:690e:12ca:b0:660:4563:869d with SMTP id
 956f58d0204a3-66052e3f5e5mr1265392d50.28.1780044294725; Fri, 29 May 2026
 01:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260524002617.69593-1-wrigjl@proton.me>
 <20260528181857.92087-1-wrigjl@proton.me>
In-Reply-To: <20260528181857.92087-1-wrigjl@proton.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 09:44:41 +0100
X-Gm-Features: AVHnY4LbDlVkKYAAbHqs8VIeawFzR_t1Wbi7pfbdCrdt8ZBMaYpiFbvxH1AVSUs
Message-ID: <CAFEAcA-qwpS8sMqYfR8WgHxoZvhVW1eMO6C1uXqWvK_5hkL9sw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] target/arm: implement FEAT_RNG_TRAP
To: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 28 May 2026 at 19:19, Jason Wright <wrigjl@proton.me> wrote:
>
> Implement FEAT_RNG_TRAP for RNDR/RNDRRS and enable it on cortex-max.
>
> v3:
>   - helper.c: give ID_AA64ISAR0_EL1 a readfn so that ID_AA64ISAR0_EL1.RNDR
>     reads as 1 whenever SCR_EL3.TRNDR is set, regardless of whether
>     FEAT_RNG is implemented (Peter Maydell)
>   - cpu64.c: keep the ID_AA64PFR1 fields in register bit-field order;
>     RNDR_TRAP now sits after SME and before CSV2_FRAC (Peter Maydell)
>   - docs: list FEAT_RNG_TRAP in docs/system/arm/emulation.rst (Peter
>     Maydell)
>
> v2:
>   - access_rndr: return CP_ACCESS_UNDEFINED when FEAT_RNG_TRAP is
>     present but FEAT_RNG is not and the trap is disabled (Richard
>     Henderson)
>   - Register rndr_reginfo when either FEAT_RNG or FEAT_RNG_TRAP is
>     implemented, not only FEAT_RNG (Richard Henderson)
>   - Fix document number typo in Patch 1 commit message
>
> Jason Wright (2):
>   target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
>   target/arm: advertise FEAT_RNG_TRAP on cortex-max



Applied to target-arm.next, thanks.

-- PMM

