Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795E0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2c2-0001JF-K0; Thu, 08 Aug 2024 08:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2bz-0001Hb-5U
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:51:23 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2bs-0000pR-RR
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:51:22 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-530e2548dfdso947725e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723121474; x=1723726274; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g/iWmPja43LIDv77TO9Vc4j/QAJjDM3XJTKCebu0b70=;
 b=lskBN5KLEZTUw3mHHH7mhGTyYCyWebiVWgAEyDTJYZz0CTGaYu9dSkwUDqCi/7iOYr
 PF9O9aEWtnxakcPWzcz62C7Hx5blq3Z0mbMUI/ZLFfxBcqUux7/6KkxN3LaUKu17MMUd
 WKw5/1LrghOUuPGQiMkbcmMx/+qY3WTbYieisEiHDKeTuu0+rQjB0UumqfdIJUwcPksL
 aQisIsas/OAGp3b3KY/A2SbehwqQEnNezm4XX+fMSYdgnWJb7387GU/2kNZvR4lzUpHt
 jSSJWT0n4gEyKzX9C6V9p8BNIOVGGoDjJOtpKaCoAH+xxx9fjjC1+cjVTxvzgUB6DgVq
 bWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723121474; x=1723726274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/iWmPja43LIDv77TO9Vc4j/QAJjDM3XJTKCebu0b70=;
 b=bAUCttMmBFhxvDxgEeuIxXCSnA+RJIDX3+GFrs6P6H3P4c9fV/vHoNJ3y1PXH0g641
 afROg74Gw0fgC9q9Xf9+K5Es+NOEKDHnvH+J+ouyCTsQcF4pBgPqHGYEYFv9ry+936qV
 e+v2fwgRMvYb9NDZmaqt4wjQfNu/MknT7aBofbwO8PwBgBII05KrE49mFlMjHf/EPutk
 lEpOyQ7NgUAAZBCNvNU5yYSvLU3qwRN1FwBvcrpqKOjIVGoAmSz7WnCh/fuPMld04xXG
 F2knJyGWvtpGtt+LytXPCaMncB4WOss4ciIGwFLHUK+sGXwmAMJSz56c7G0Z63gSpNHp
 R6nw==
X-Gm-Message-State: AOJu0Yy+cnAbXe2cMlAJ8TEzhOTIfxpvsVQB3tFy/yLxHFmbu3i8VmcV
 yq088FFXbBMczgh5YfdSYcGQNOegH5CauduIkzdU5KKWmjcVFhzFRyKo/XKVFr9a14UWoceZiyk
 vd2hWT1/89a2adH2d8yjgMXma2TLF/b9XJ+2EnA==
X-Google-Smtp-Source: AGHT+IHbUW6ct4afjz6F2R2nO5PpiWhAvuDN7QgCYPV8Cm2dTT9qKbyUFP9LrNVmrWO3RhMTbD6OseYHCb88tdCljC4=
X-Received: by 2002:a05:6512:4025:b0:52e:9fe0:bee4 with SMTP id
 2adb3069b0e04-530e585bcb5mr1219059e87.9.1723121474248; Thu, 08 Aug 2024
 05:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240802133118.2000067-2-eblake@redhat.com>
In-Reply-To: <20240802133118.2000067-2-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 13:51:03 +0100
Message-ID: <CAFEAcA-uQ-tawSxxyCg+MO6wJMg92Lb1TNnQwRtrjWshFao4YA@mail.gmail.com>
Subject: Re: [PATCH 6/5] docs: Typo fix in live disk backup
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Fri, 2 Aug 2024 at 14:31, Eric Blake <eblake@redhat.com> wrote:
>
> Add in the missing space in the section header.
>
> Fixes: 1084159b31 ("qapi: deprecate drive-backup", v6.2.0)
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
>
> Noticed while figuring out where nbd docs would appear in [1] once [2]
> goes live:
> [1] https://www.qemu.org/docs/master/interop/index.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg00223.html

FWIW a "6/5" patch like this tends to confuse the automated
tooling (neither patchew nor patches liked it). They prefer
it if this kind of "on top of that other series" patch is
sent as a normal patch but with a "Based-on: $MSGID" tag in the
cover letter -- then for instance patchew knows to get that
other series and apply it first when it tries to apply the
goes-on-top patch.

Anyway, I fished the email out of the lore.kernel.org
archive and I've applied it to target-arm.next on top of
my rst conversion patchset.

thanks
-- PMM

