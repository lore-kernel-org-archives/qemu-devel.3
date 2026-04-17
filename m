Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9504F436A0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDixs-0000zl-9u; Fri, 17 Apr 2026 09:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDixU-0000pJ-NH
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:10:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDixQ-0004Gf-QV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:10:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso8136325e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776431401; x=1777036201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkPx8zsRBbyK+R6Iq9Ts6RRLY9SvhXCEEGo2Yws5eLo=;
 b=Lj2hGwi+G8wCNwL9MRr1E43og2Iv4rGNijEh/BozrY5NKdIl1oRnA+Euliw76YzQ3Q
 2YQfDyHDKSlwyzdqpzKUrt5o5Jc2pGIMDARnlSIbC0YFCU5c0dmPl7zXcV4diAbK8AH9
 b7riwXhU9j9W+xqabIz5NW0446FMO6lMoLwlPkq2yanXzAqzTy8AkAOCn8vER2dqG463
 hnBvveBUBAJv6ISJmUXBh5To/0M5vWtnom4P0J8LNx5ffjjwvwuatupeZiTqolfcL+tJ
 +1pJ7lsXPr5U78pLh6lmjV/gpfTSPlApBLyvSqoYGT7KQ2OQjYOczlRc2ItCefSZJEkG
 l+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776431401; x=1777036201;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TkPx8zsRBbyK+R6Iq9Ts6RRLY9SvhXCEEGo2Yws5eLo=;
 b=Hq/tZ4ACyQrDwn8XS8hZiqIPVauzftAW5rqTPER8NooO4IpKx/M02Ekw6wDLahGsx1
 5IHGhzYFMAqNQCYzM/kCUP/mpWQRVfdDvQEK35x+A1q422HCe7Athsa1Cqhw8MgD37iG
 X3ZKhclED0UX/qzgirFtgL5PUsFyuvI8ZEjiuAWGtc5XFvyzqGNpFmYLp/a599jp3VDi
 AFS6cWFn/W4owAi5Yb032KsrFpha5jO0ddKDqPfObDzmc56ePhrGsSbhtrlfmNf1quas
 FKeLgAxDsHh/m4C0JxrJtNghV0v1hNzkJOs4yqYWIKn4Umu0iHWH0+JGnHE+UWKOGuBD
 gbng==
X-Gm-Message-State: AOJu0YyTywOCTJrsUltDHkdG7XXdtxmXbTKXE7XxUIZ2q/ZYTMmpxKxA
 MTxkCg261oY+wLl+OJPgk/FykNb1iAfruw8u1JhK1PNpAb4whhka5OTEeB5USKvlpRI=
X-Gm-Gg: AeBDieusE6zQW/f1/NmKfSJeu7ZrMV7KzljB88n341Kw5LwTgEScdlV5Wv9Z0fE5DAG
 PpOPH12JjUKctlRd54jD109FhrT+sQHNnfVHh4uh/7DFMA/UoEfzYqbOiPRITBrkqw9dT1sCJ5U
 enIlyTdl8ip++VAF5Vz/jJ8zLTPIqfxRgbe/K+hY61405aJEYptcezzIA1q27vpyo+oqmQHZ//j
 5Cd4k4DePce5SuAhNyLW/WEk6nasJLdCbHBj2lQ8GN7wk67PSt1zHtgqsgBSYL1Q0CRadCk9p2/
 eHNUKOnQ90ZQUx6Leivsf6xEFiiTvOMGCnoqrL+7M5z7vIsxVUt5plTklnYqTgYoZWGfUeENrLi
 mHXy7sfUHCprx/wjULFn3PmHX+hd7vselk5Mu0yg/obokzVRQclIWTet32bywXyKoTSa/YIQ82m
 7++FpjqA2nlhoCV581P9XFdA7cQ9I8K7Lqew==
X-Received: by 2002:a05:600c:c089:b0:488:9db9:5235 with SMTP id
 5b1f17b1804b1-488fb771b54mr28804685e9.22.1776431401077; 
 Fri, 17 Apr 2026 06:10:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10019bsm46971265e9.4.2026.04.17.06.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:10:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BD2D75F94F;
 Fri, 17 Apr 2026 14:09:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH 0/2] More virtio-snd fortifications/coverity fixes
In-Reply-To: <20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org> (Manos
 Pitsidianakis's message of "Thu, 16 Apr 2026 08:48:08 +0300")
References: <20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Fri, 17 Apr 2026 14:09:59 +0100
Message-ID: <87mrz1ravs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Added checks for stuff coverity pointed out.

Could you add the CID ids for the issues please. Either inline (seems to
be the most common) or the:

  Resolves: Coverity CID xxx

form.

Thanks.

>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Manos Pitsidianakis (2):
>       virtio-snd: check rx buffer descriptor size
>       virtio-snd: check for overflow before g_malloc0
>
>  hw/audio/virtio-snd.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> ---
> base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
> change-id: 20260415-virtio-fixups-3bc3a1a1cd27

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

