Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1280FC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCev5-0005gE-3a; Thu, 30 May 2024 08:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCeuv-0005fU-E1
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:30:01 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCeut-0006xs-U5
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:30:01 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57a033c2e8eso896841a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717072197; x=1717676997; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mdqq5OfvF34fn5ebcEhL19Xw8v13R2F9/z4VSD3FqgE=;
 b=SSvnMAYxqJCHAabprvGN8+5ptumJ11SYgepU9okbqxHTuJgPdTJ1XPmf8xmmfG+eFz
 kAeIcccarteGK0YYwSferPUULaNEfEh1UV71JTU63cF5W7KIRt7XIUUgFWf1XPLaCR+R
 JG9QdCYi3M4uYHUnMYVQoxWH0jgiq4wfSYcKstluVh3+De0cPjlM9KeBuORN/tGs/BvW
 yVvnj8uM+TJq53hmMczLroq9TRpxLrfSP4H4MZyYZuZyy5m7tfPi97J5d87PPdlm98Sx
 Txh9DSVvFnqsQCb27GXQXDQ0u0OvXd71I4NwVHZiwAXPfO98E+6yxa5740TNDNZEGbLG
 K9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717072197; x=1717676997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mdqq5OfvF34fn5ebcEhL19Xw8v13R2F9/z4VSD3FqgE=;
 b=ZGvS1GsQioGTe931ngHHj19w0XzDcgn2xvAcFxHehUduoX4FuHqcwCrc/03QUNvlC4
 XhGcxev9XUj8tYPQ8aWtGNgrbgd+tAA8WEic9dlhcDKapPXK1y1IjTq93VXK11y2kLO4
 M2lxPlxfpc0m/bLSqa24fhN+gWGlSO4eOvVhzCFf7f6mrnr3SPg0t1ccJF1D95jgWGf5
 OyPoyBFSmTeS4f7oibMxSA0uWBaHtBhieAdxeu/VqGYg6B/PF60HMwu0vvMU8MZs1phC
 8M9PeBQnN1+TyzimH8ZAa4Vep3m+6gHWCy7wFcRejtLkAr/nHDyBGJWT5PX9qojQ5C6E
 8hBg==
X-Gm-Message-State: AOJu0YwcwW0LFYfEGzGwWEP9x0Z0+lvnSYtJfBeX7TTL2bQGp40xB8S2
 RNZLca+uoX0Sz3Q7N3lXRaQu0RlEgX/ebU3x90lnph+pL7uVtYzqalXLeZuAgKOgOMnAn69n3mZ
 kaZN7+xXKqIa78sYSCou/ZoGVu3FqQkTNpblS8SfIFRFnlOli
X-Google-Smtp-Source: AGHT+IE+Y4DewFs/tFJYYJZXV4qZlZdPn2YNoLRJU/LXtlkuxMPgXHA0M5eLaIU6zcTJcd3X5cgwlToS/IfAo5ygNJU=
X-Received: by 2002:a50:d654:0:b0:57a:20f3:d32f with SMTP id
 4fb4d7f45d1cf-57a20f3d3d8mr913100a12.16.1717072197188; Thu, 30 May 2024
 05:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240519094106.2142896-1-rayhan.faizel@gmail.com>
 <20240519094106.2142896-3-rayhan.faizel@gmail.com>
In-Reply-To: <20240519094106.2142896-3-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 13:29:46 +0100
Message-ID: <CAFEAcA-GHUzcjK+ooCq-D2iaNhTVa-A1QQwgeabMFwZdU7r-HA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/arm: Connect OTP device to BCM2835
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 19 May 2024 at 10:42, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> Replace stubbed OTP memory region with the new OTP device.
>
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

