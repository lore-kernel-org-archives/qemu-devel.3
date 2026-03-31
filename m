Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6054210F92E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7cRc-0005Ux-SI; Tue, 31 Mar 2026 13:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cRb-0005UX-3L
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:59:59 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cRZ-0002CA-Mw
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:59:58 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso8951991d50.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 09:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976396; cv=none;
 d=google.com; s=arc-20240605;
 b=WshoT2JarUtIYTdINsy0htbEO4QsubmGNEW1nPvWlLSuqrWp6m2120QA909n2/guLe
 52DwUZwIuvvPPCioeoHNyn6nYhmlICMbPyx8PwqwZ4zIVaB8YXvEOKQe24ZiwuH1zFhH
 VUR6bSn1uuXa6qryVhtjMPZXHNPmoiqInEm9SWVBFfa7pz26ZUJp4RXUeNCTqvl81wBT
 oIj5u0tVUMyXfqK/RwejCnlXdr/2dNnVy6TnG6hcTAXTHPyrgOWZdl2zkAEt1PdCQYjA
 xEjA/8rWNh40CIy8LkRgAGpIdw8xz6HhbZ+t+j78OeldQ6WYdU+Z8Xo90v2rXEiSJ45B
 8isA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iMDREFWEMPXLywfoQ5kD3fONGP27XaMe1I3ynxwtKt8=;
 fh=j0m/KHqzOQ6CKKktQSBLLiVo/M7SZnjHIyl4bugXt+Y=;
 b=guJ595Wxw0p/cMKUL7sv+gwOOEDoldFU6Nt0+aqOJ7zJRUpi/1Pdhv+GkHmpLCM7GM
 UOVcBLMr9Ob9oN2Ah99nhvFEpD2+9zuTiddpXIDeapayRvdwlMO0fIwtku0aa7/yo+uq
 2D+mIbWAnHjllg1S05VsyQethJ+U07zUNFexbj4QnXZ5YtaRWDXX+1s5VgoY3ElEMGF1
 t7DC2pFIi/pwjHWcIQNM8VPZxGB8Zd1hd6/YB/ebffTZj/xFxYUJjguwYCtxv1WZu6gV
 f/YZ+xcrWZCUEFk8BVEPWrVjHXF+HCtCfq0O+h3HQEFKQwAben7/ZhzgGbBNp2EY2mCg
 ZUPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774976396; x=1775581196; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iMDREFWEMPXLywfoQ5kD3fONGP27XaMe1I3ynxwtKt8=;
 b=gfDfuvFbn0mt4Qip/Nn8UVBIbTzh/cIPKxkBpPx07ICWLTDeNiQnwkewHfRz5aYm4E
 LET8d3SbHorRxhOK34N9afmw7db49QycBhwn3wQRF/rmxOoNJE4m2WHhxmdNI3x4ZD70
 2yOtK3tRxJ79e6bwGqrWDBN7nqwCvHlradLLTTuMTKaRIjJS9s/CDEGLH6MfZQYjyRxy
 No75MK8M2sQkFi9ZrBNYacI06v2bzYqdApQMEC+P0p2FeQxeCZHfIZM4Lija5oRDuFrj
 tsm6pXFjpsCistVhQ8mdK5Ca3t14mOLxN1mNiPTH56/fEDxWZwPYChhZa9+Eth+G+X5o
 0HeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976396; x=1775581196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMDREFWEMPXLywfoQ5kD3fONGP27XaMe1I3ynxwtKt8=;
 b=MLtvowba611uD4bvfplc5/jrq4ye21CxUY7Ro3JMiZreVHdCTEkviuYeLv+qfVB+c3
 eJ+tIQgQTFcGqXSMiGFrZrkT0U8Anlb9kzbLcbpezYfjeHmuUcM0kWPqApJfCo+Dp1/i
 GE0mFjOu3wSX7TToPdXkCLCpfkgphgqT577Gh1nSiiJkwRgJJJ6bcjuqiIAhHmFVpeR7
 dTsU9GoPuJrbCG8xQga561IQgKbxaapgD2c0Ux+YmpAYga38qeO5VwrHONFYyVpN/n5t
 70pO+BWO3lVsDNDGauGlnwAlO6rhI0IbZHQ0oXuAcshMHBUBeJt27qbzxDvsGbG4RfVr
 HZFw==
X-Gm-Message-State: AOJu0Yx42NvEXdbliD6nkEvtX8xyqeb4NhiNfeNapBlbekTisSEKsowf
 +diOk4BOTRKgQR6v5zInKUFF/ycVKCfhyE7KZcjVrWrlY6h5UuOzwFqusAGbHEqnxkpR6hRbd0P
 saSOr4Fb0Wl6gBzT5onosq55af8pPcadMBoBaE/5MIg==
X-Gm-Gg: ATEYQzw/AHNoqLBRS1CaHz8TEcd0KSfO/FS8Ruj+PnReNgNgZ/4hR535GfIzvUl6EcA
 k7G50/wT8kZOcT1wM8le7dFNjLB/7sKLS4NZdnwi7FTebUhLKuPwOQb/uTjZ7QLhmo/Vb5DRsnU
 PobeZ2k2t0p9yP0YiYrdIUtN9cDb/0E6HAwk/lgbXWLJmh4PgW3xC7AbTztdbVOw6LGpCzcvQIJ
 AN7pyUp6KB6kZnhA4hF4lwPFbOlpx3AjAxmA6EZC+QA3LsP/VIKVGf8BCzlJMHjzkEd1MqN6jQy
 zMV4eafAkl1W3zLZSXtcnIVZ8EeV7NVCj/o0dRf+DYowxl3Zy5UPDZtlIym5JvZ8e/BO3F1k+7I
 f9g==
X-Received: by 2002:a05:690e:428f:20b0:64e:e380:c83f with SMTP id
 956f58d0204a3-64ff73cbbe3mr14146920d50.46.1774976396057; Tue, 31 Mar 2026
 09:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260321135624.581398-1-npiggin@gmail.com>
In-Reply-To: <20260321135624.581398-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 17:59:44 +0100
X-Gm-Features: AQROBzBniHr2TcrbiuKPFeKJRtYKWPxMmXX6KW53z9Nh14Ok5NwaBowLuVeaOD0
Message-ID: <CAFEAcA_iwWDmZf1hojzZ8+N5RTRC4WXDSSK7SugNNRd6kdk8Gw@mail.gmail.com>
Subject: Re: [PATCH 0/3] user: recursive signal delivery fix and test
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Sat, 21 Mar 2026 at 13:56, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> I found this recursive delivery problem when testing new riscv vector
> state support patches (plus a minor lock user balance bug).
>
> This or similar type of issue was fixed with 8bd3773cce1 but I couldn't
> see exactly what scenario that was addressing. Is there any other way a
> signal can be generated during handle_pending_signal()? The SIGTTIN
> case, perhaps?
>
> Thanks,
> Nick
>
> Nicholas Piggin (3):
>   linux-user: sigaltstack lock_user_struct missing unlock
>   bsd-user, linux-user: signal: recursive signal delivery fix
>   tests/tcg: add recursive signal delivery tests

I'm going to take patches 2 and 3 into a pullreq I'm doing for
linux-user fixes for rc2, so we can get the fix into 11.0.
(I've made a s/__chk_error/do_chk_error/ adjustment to patch 3.)

Patch 1 I had a review comment on and in any case it is only
a problem if you build with CONFIG_DEBUG_REMAP, so if that
drifts out to 11.1 that's fine.

thanks
-- PMM

