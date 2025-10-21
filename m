Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60379CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDLu-0005vw-Bu; Tue, 21 Oct 2025 10:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBDLr-0005vN-FX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:28:39 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBDLp-0003sq-Dm
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:28:39 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-63e35e48a27so2397484d50.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761056915; x=1761661715; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZC7VhE1ZJnvVrL5pJoURo8bye8ZFNUAe5ySK86do3Is=;
 b=wfcxFU4lyVdcp2Fks2ReBS8C3nPrLfVyd3/saQWBRsWHhLnUToFdOTCaQnmpbP/E17
 myKX57g6asB0hot/xRatZ0pj+cwOpGiu6xN+M+KIVch6rJOcPcfHek9qUehcPUPxnHRC
 f+Nxg5CavCo0BSuef5L2pmwZOfZyy1sI5/WEuMaF3/wl2iZDc42KsaW7f341tgx54szb
 HulwyvbA9d6Ts1jY76GNLerQhpzXvVNAOmanLVwIWRezceiaGuQcYNqWroHSPFyYA2C8
 R/HRivV0WuIwWmK3dOtmTk6a0djvbflal7R1RsNB6vvh5CAGrIpjU3cN7mkzwkjrV5fI
 58+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761056915; x=1761661715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZC7VhE1ZJnvVrL5pJoURo8bye8ZFNUAe5ySK86do3Is=;
 b=lrHH/vbOeLbE0fg5n+m/J2/JX/M1xQgHIxawmIeiJgqjBQ9a3zUnNPeSMGRFOLtbeZ
 nMkUBU/dzKv230Gsh34r94o8GT8zYj/CeBvp6+5h/0cEIuWVIDWeg1uRILriRad0jC4l
 4AMQCf/DF1TF98fxPjgE7ov5/rdmzoSRRw/7icwgEXYTd3bIGNvmc1xneeJH0bO30w7o
 bvHV3Og2rs3/VBKb3jQPuBoOWna0pWtcUCcfkEHMHj1Pw0eigApNM24x0Le4928egbpd
 255MgDpjchCFBma/SJd+/zSRMcqSyxASma5aaNUJUlhvWoB00feT8T8FvX5T3pL2OuSc
 isEA==
X-Gm-Message-State: AOJu0YxNWJo8QvixcbsyUvvdaZUSJbDKfD1qk/iEV9DQV57Liw0pYcuR
 jBdTilcVVYR/r83lD7zP31uQi+T7aXfAWs7nb9Onf0DD1/9/ly2CJdvOLrJJL+zlvbagrEBNm2x
 p2201cRkJyoqaYxprLhawZsbOe24GoL5YUGho/kzvTrJpxpmvaUcL
X-Gm-Gg: ASbGnctjWGOQhha7Y2wvi55+FnXdh8SqqyLc2SZR1yGq4vx2aGGafqVxXRBedFRnT89
 g9dVWJ3mQ8MuMWWb9e8a+/cK1xfIP39pf7JY/j9X8pYsaD8q8c7jMkpI3JBH/NiI30G2DUi26Nz
 wNwoATI7tOrbMRpybXzQ/clAwubPyvGx1CDkZwIBlbh2iKOumI5OKz0HS1khLt67XXAFgokhJs9
 8p3cFzsfIJhKgWllnZyqF8jZvPVjOb2zOmFn7/u70erUuwOp+Bv3f+mtvwhxg==
X-Google-Smtp-Source: AGHT+IGhdwClSJpAUjDa44L10j1UWYrVKsXGI9Xnph3p3v+k+V66Zur4AMesvllQoBiFBluHVUn6CGpId0QLAtIOqGM=
X-Received: by 2002:a05:690e:1243:b0:63e:2a71:83b9 with SMTP id
 956f58d0204a3-63e2a7189f5mr8626401d50.65.1761056915325; Tue, 21 Oct 2025
 07:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251017133156.926094-1-peter.maydell@linaro.org>
In-Reply-To: <20251017133156.926094-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 15:28:24 +0100
X-Gm-Features: AS18NWCPqaZoDdunT0KdgiiaCIb6-SiC_t-TKvY38ZiE1ShJ17ZoLbG-4NgBv9w
Message-ID: <CAFEAcA8oiwxhj85pG0UKY7uHnZUy4==E=Q3i-HUqngEO+A7aOA@mail.gmail.com>
Subject: Re: [PATCH] .gitlab-ci.d/buildtest.yml: Install 'file' for the
 Coverity job
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 17 Oct 2025 at 14:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The coverity-scan upload job has started failing as of 30th
> September:
>
> [ERROR] Cannot find '/usr/bin/file' command, and no 'file' command is found in the PATH
>         Coverity Capture uses this tool to identify the file type of executables.
>         Please ensure '/usr/bin/file' is available, or add the 'file' utility to your PATH.
>
> This seems to have broken when we moved our containers from Fedora 40
> to 41 -- probably F40 indirectly pulled in 'file' via some other
> dependency, but in F41 it does not.
>
> Explicitly install 'file' for the coverity job, in the same way we
> already do for curl and wget.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't know any way to test this except by applying it and letting the
> coverity job run when it hits upstream git... Possibly we might find that
> it complains about some other missing dependency and we need to iterate
> on this.

Happily, this does seem to have been sufficient, and the job has
now passed and Coverity has completed a scan.

-- PMM

