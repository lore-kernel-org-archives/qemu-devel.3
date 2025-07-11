Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7306C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCZd-00015N-RY; Fri, 11 Jul 2025 08:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCZT-00014l-C2
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:09:45 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCZQ-0000sC-QP
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:09:42 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e81826d5b72so1769596276.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752235778; x=1752840578; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zmGhLPOug29OVLJE0P2qLGwbOURKNr34ADed+0HuJmE=;
 b=ICC30TbhR1OvXKHL5enJYe6d8O2PQXD6GfS2aNHG4g7oCr9N0gp6bPJW/h4UxUq18M
 QXsHfcsXwQp0db0bLwfoVvzcrd/+i2EDcdlrIK/+d5kGy2IyQI3CxxPs3JZmG705JVhA
 6vxN9QiDDykBGBo3Ce64uMZ3OKJHHc8Y017wctceLP/EsRZrmLRvrRwXzb3vgR19zinF
 SZxaIgY6FCA2pkK1gEMKVVYYZ3ssuF7QXR4bd2dXZ/7iX/agxb1lJEN8B5F/d33bSLyB
 +plZisQbr1GYeylc7nqFrSZPqhvIvgUwxf+Ykm8P4BqXGpvcVC74B03Y7QnrfI5N98JM
 S/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752235778; x=1752840578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zmGhLPOug29OVLJE0P2qLGwbOURKNr34ADed+0HuJmE=;
 b=edvTiD403d3TgjvC6o2/Aw9TMCoNbOnpLc55khjWPlbfW8j27K98A1s8jlvYViMdSC
 xcWFv3xIuqL560i0/ssT1CUwqH9nIBxMGxWlPUse7+WJHeHt3c1bi2uU+n+tJopzHskK
 25TD1F34OMYnxZP5vwbmSCbEIIT9D+2jrGnPPWkA7Ftf5T9DlFB+Lv7nod4lFEg4ixAd
 6/cClj7r1E5ti7rn4muj1fDLnV61Gs+pBiF/4L79nWr0RD+sPEcOgSaQHePDwrxABM/k
 psr+IjU4nCtQZIYzRLAAh5M6KsA+qM7On2piMCW7gWaCIKncsnY4F058Cm7lLuyuqVGQ
 y2bA==
X-Gm-Message-State: AOJu0Ywr+pJxs/xCQ3coq7prHLC/CJOj9i/1HYngxwsyleSqUxdHuJce
 ia1CtwLk3GliIpt3GzZaMkN1GfV1CS/ZVfawDP/Ile696ySuBAHfq+DagyOR3gVeycBxEqsjQJ6
 NJPV4jeYIXlQUiDFnY/hpklxIQXKgqEGa+KlrS77Rqw==
X-Gm-Gg: ASbGncvx8f5NZTMt7jXGmoPCt9SYluQIDrUUvYXkOR9gC3eQ+2C8DMGAHzIevlTKUxK
 KOABVbofdw7Nk4Fe4m93ZeNP3j2r6J1yWsJOUSywgAbS2/hDlD5CrcG1RdjuwiKWji7JNb8RYUP
 lwi2FWCTI9Pnn6QeZBdutK/CAYR57b8ivpPB01hHjgtNYz7VIRAVwy0mvuSnmKW+VfWZgkJZ4cN
 kM4frZ3
X-Google-Smtp-Source: AGHT+IFmNjc+PS0kJuUG8o30plOV/EjLdhJVvSJDsGNXI7a2S1u/z7iF8Pb5sfCYVNS6ZB7CfUw7irczvqrxB28U5pw=
X-Received: by 2002:a05:690c:6a12:b0:70e:1d14:2b76 with SMTP id
 00721157ae682-717d5dc93aemr50294957b3.23.1752235778296; Fri, 11 Jul 2025
 05:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250711110626.624534-1-jcksn@duck.com>
In-Reply-To: <20250711110626.624534-1-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jul 2025 13:09:26 +0100
X-Gm-Features: Ac12FXz2Lc1XEojo48PdrP02p1isdL-_PJ_xdN_iOE254Fkva2PWz1vCj7nBGCI
Message-ID: <CAFEAcA9bfXn52L52EZyOfj-HNAzYHjSbS4eJDm+rcoauWB-1AA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] MAX78000: documentation and test
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Fri, 11 Jul 2025 at 12:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> v2:
> Docs now build. Sorry about that
>
> v1:
> Adds .rST documentation and a functional test for the MAX78000FTHR machine
> as requested by Peter Maydell.
>
> Jackson Donaldson (2):
>   docs/system: arm: Add max78000 board description
>   tests/functional: Add a test for the MAX78000 arm machine



Applied to target-arm.next, thanks.

-- PMM

