Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0073BC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdBq2-0008B8-1s; Thu, 22 Feb 2024 11:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdBq0-0008AY-S6
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:22:20 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdBpy-0006Ip-SW
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:22:20 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-564fd9eea75so2807387a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708618936; x=1709223736; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8pBG7l/XuxDSAATZdauPDIwLeX6LrNnMLPODy+LAl0Q=;
 b=eyF0wyajQKzxLGTe+G7fMgUZXXxIhMx5y/VkSIUciAvbDoJThv+e2bCk+J8N+PyGKJ
 ZO7kDkZLWNI8xJrXqdiBYw2m6CULH7cXp/cOI7zOoJMDgd+7wjyYYXmXztekdTzc/b8Q
 +iDv/3Qb3JWgyeiD0wUScmm4LlzlOLj++CbJy2svN2U9YaXcStLdEqNDPpHgcvJFR7gK
 dBwasF56nsleEYQBZ1S+SV74MmYXptjvFlWInk3iKgFKmwdNieGq0f+9L7VzJQ9lz/0G
 u640NYRt1eKl5Gu6PxRiUqGxGnvLdY5DWmBUuTHN61Dyd4Wwt3D5K7eVchEm/02HMWYe
 O6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708618936; x=1709223736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8pBG7l/XuxDSAATZdauPDIwLeX6LrNnMLPODy+LAl0Q=;
 b=BQb/mYrLybAFsasOtqGyulapY0avAP0jaHvOQnQtNa9KR0BsX+7S7By7VfleOosbIe
 0eK9ODY8YtWovagDRiOuzVbELkPfKt96evF73VuF+2LtMy6TLe3NBIdn8PgxGm3Nzt6f
 v0QsateMPyhmvhtGc2yRXC99uhvcDdk6Otm8fUYuVnhqFQP3fz+Tlfk9RNNWxOGqqp1j
 AaeL5gdcP4yn8iXqez7nlRLj5OPovBVr5O9F6OoXw2Wsg8WZF7LBV/yEsInIWNzt/Xu6
 Oeme2llncO8DLKPqPi+EIrmqiEb5xtnrhjQosYix/slmM+6Qg0HDCwjzdblhG6CtPrYR
 gBTw==
X-Gm-Message-State: AOJu0Yx82XTtki6dm90xZ/Z3IJbdl/DNYb2qDgQ9F5+XKhSFwor1hxcK
 zFAvLNUznek8qTRl3UnolqEgyiuBghdKn7uHAdWrAHqHNh8Z3xdcAHO4KCx4iscfyXhq/B9+Otp
 8qf0FxTUbxL737W37wmlK7HrxsIq+n9vGXKUbv3lSD0HQgVwN
X-Google-Smtp-Source: AGHT+IHiRqFcpbtWeY+dtL06dSy9p+pYXgklK1u0Nn2WKBYeBruBZFXprVlpjoxrJ7p9btWrIJDv6lzTiLXikCJj2XE=
X-Received: by 2002:a50:ed03:0:b0:564:7350:cac8 with SMTP id
 j3-20020a50ed03000000b005647350cac8mr8126183eds.15.1708618936163; Thu, 22 Feb
 2024 08:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20240222000341.1562443-1-jrtc27@jrtc27.com>
In-Reply-To: <20240222000341.1562443-1-jrtc27@jrtc27.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 16:22:04 +0000
Message-ID: <CAFEAcA-yJyfHdp9OPTG+iSduoQC6nAmWMbTgzcHvxD7pewAdqg@mail.gmail.com>
Subject: Re: [PATCH] pl031: Update last RTCLR value on write in case it's read
 back
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 22 Feb 2024 at 00:04, Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> The PL031 allows you to read RTCLR, which is meant to give you the last
> value written. PL031State has an lr field which is used when reading
> from RTCLR, and is present in the VM migration state, but we never
> actually update it, so it always reads as its initial 0 value.
>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---

Thanks for the patch -- looks like this bug has been present since
the first version of the pl031 emulation was added back in 2007...
Applied to target-arm.next.

-- PMM

