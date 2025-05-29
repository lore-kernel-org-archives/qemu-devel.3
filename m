Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471CEC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 16:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKfrK-0005HP-Bl; Thu, 29 May 2025 12:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKfrI-0005Gk-Dm
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:11:56 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKfrH-0002j4-2O
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:11:56 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70e3980757bso10403477b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748535113; x=1749139913; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+mel1eN+tm8poZ5dlpP/RdF9Erss8TOllz28gw93WIY=;
 b=aeAst65WrlGF36xFQkSth5kZUxoQ5WS0bpofWJnKn+W+0gM5nGVBQ1LyuKpSsM0hMD
 CC8YSGNyfz87w46yfeoo+u3iDgNlDa/gidGqfmEcy2b1uEg6jx7VJBZdQ2Hx6D8FIPyq
 UXdcMiipmnFoGxdZs19XSHl6y1PCvrYRFdDoHMv7XWUlbiWHp33EkzFLENuyxTv3lgEm
 0mcI6OqESaIQhDHpdrgfiFfg9pbk5C46Gq5NkciVPW5ufpoEoEdthSqbE9uew8eCX49S
 wXyToNsy25Ap7YveCjYy1tLPtfqwlWPhopf91V0sE+vsBSP56iGvtzDDU96DUnVsB0Il
 P+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748535113; x=1749139913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+mel1eN+tm8poZ5dlpP/RdF9Erss8TOllz28gw93WIY=;
 b=lxAz6G7YXr8RPshKlfJOZWFDbBcvYXUZhtdqGF1CcqxlN2k0x7QhTa3QwC3xQ64hY/
 J32gL5wqEwbZGIi5wTQknTFOk5DqKNIYckK6yxOvuG1A/s5BIXw2edOwKzYG4mUfsxV9
 TSf9sGe/GNVqo7s/3CUY8RlvMqe3RfMJxacGmoISBrpEVGxxHYyL8iZZJRYdvSHB55y2
 jchdIjrwLXYeGip/QJkf/hEoCugVVl/iLK5mJ8DYtR7IMzsm6IwIvYpGyuexbjBDH7XE
 gsl4VkS9srtcXzaG4BeMVdSDd5L9BKF4qvG0h0iHO7g6AO/Umcf73pG+35TXC0T3y9G6
 Eq/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf76v7ceGLMQ874Z7gcwe9E//zJNIhet8aMbvSuW9Hb7U8LHmuGyXaWShJd1trT7GhaHuIeXKO2Kkn@nongnu.org
X-Gm-Message-State: AOJu0YyZ8F7PDCJDkcV5Y9tESvmNBT6dFOK/2I3ZGVpyA8+qeo0/WfC8
 N5QJgeXhdV71GAcfxwc4l778nEOUrjMARH/UM7vNLy2eAR5cGXIuuNAjvXTM3VNwXFCdLbWWcOu
 KCgej4/IhQlQQq+2WIvtQAtXPmeSbnkgBcXaT00JL2Q==
X-Gm-Gg: ASbGncsl9sQVo3SI8TgB8fJ1O0PrRwe3jpqeBwDlhg/qla7IXyaZQGivRxCRBhona+Q
 fDlhWVnkRlyVFafJdb5TFbJmtBGDC1haS+xauXYL1GgGRiqXEvz2AAGLcuyT1EJWE6Rwih8d2iW
 1gkvzAbquXzY5YJN0gUTwa/NgVL3sgJFPonQ==
X-Google-Smtp-Source: AGHT+IEp+cfOTNiCXJbFZizYOfMUd+jzqcdIonPV91qIWTPRGX43dU1/XngO5xXspMSS8+MH1OsDn5YX49wBitwKfLY=
X-Received: by 2002:a05:690c:6403:b0:70e:7158:6fda with SMTP id
 00721157ae682-70f877a3b54mr70879897b3.9.1748535113595; Thu, 29 May 2025
 09:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250519170242.520805-1-thuth@redhat.com>
In-Reply-To: <20250519170242.520805-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 May 2025 17:11:41 +0100
X-Gm-Features: AX0GCFul07BWFixlJlKTdh5b25Rd47Gx0rGyLrnsCOW2cDgehhk5PtEtFmQU9Ag
Message-ID: <CAFEAcA8hYOpx+Nxp=ZN2hprb1rPujc54Hh0X7iSn8-30rkn_=g@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Add a test for the Stellaris arm
 machines
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Mon, 19 May 2025 at 18:02, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The 2023 edition of the QEMU advent calendar featured an image
> that we can use to test whether the lm3s6965evb machine is basically
> still working.
>
> And for the lm3s811evb there is a small test kernel on github
> which can be used to check its UART.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

