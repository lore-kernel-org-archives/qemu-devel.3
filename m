Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642E5C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhC4W-0006md-AL; Mon, 04 Mar 2024 12:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhC4M-0006VQ-4G
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:25:45 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhC44-0007md-9r
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:25:38 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-513298d6859so4428311e87.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709573122; x=1710177922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=siOpzgJ38wA53g1oE1TLt4ZXTIX/sx1qob4r3WniGEg=;
 b=lxTjRLSOzyyc9DvP1YMmqC69HqJaSdCIY2xiLGpTi2Io9/CnuezNUHCqsNhZsLsXiX
 DDlLufgz8Gv6JsH+1+yUb+7cEndgdAWXkacDfBp82S6DXL/+pq2lA7l/SR5+kmmJjScr
 I5kitPqlqtglKMvpuN+eFUZ+CKpnm8vtSOcAVt/R7duDN3jkvqIpVhBWnjU4fjIl5QBI
 5AsoEjFeyfs9+n1nnBuuHOjuebSbfQFdkL+IchXZw/HrMraPk/TGSSpGB9IN+mt9gfiP
 iivBRy2sKMKaieTEk/lW30VqoRABiLd7tao1TRDbTJzMiGoCMR7lrTu0MCKytCK0DbAp
 muRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573122; x=1710177922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=siOpzgJ38wA53g1oE1TLt4ZXTIX/sx1qob4r3WniGEg=;
 b=S3x3Su3fEEwsjhiu9k3eUfyXB44EDXGxPRgIAbmr/Jvvm7ag38Dy9L7oC9fKXPzeOy
 Op7m/kH3ArrmFdD5BmyiaeeieJcLGtP3sZE/SV0ts24AUdGzVTRZPH9jypZU5psNIkXN
 m1LG22O5Vd1DjBDenbCJVrB9pt+mOk3MnaR0yFRZNQs8xPx2wdzfCDR3Gtk2NXXc6dL0
 Tp1/oDG6XrHKv3At3+J8PzMsG9G4iRpI6iQ4d9418wcqsJRfqtnX9jIt+mK66uFeXPKG
 zCjdug1gxE89dByyIlVhacItukoRHV8wQ1ApMu5YX/c1jde8so2gn10xVNcLyNnt+Nz4
 Ueuw==
X-Gm-Message-State: AOJu0YwmUfuNQf2FFhPlzAr6hXmCFmFKYGD1xEnrGwtc6sAGz2fM1otr
 /WMkQqKoQDArV4E8UJob8gEdOg9WKiIeqEAMsqQz6ktr1OBS6h1IZb2C3MCi6WMR3xIPyq7JRD4
 36i35KxVvcVNHdEoFsI/c0RAqRnOBWAH9EdSZ0w==
X-Google-Smtp-Source: AGHT+IEocjwZxijhjgFhzqoH+b8Z/R047/hRAzGMDS6mLl/3l88V8uosQwp+gJwKq6uVq0+uyidJq5B8puzYlkdM8S4=
X-Received: by 2002:ac2:5b0e:0:b0:512:fabd:8075 with SMTP id
 v14-20020ac25b0e000000b00512fabd8075mr6986509lfn.48.1709573122429; Mon, 04
 Mar 2024 09:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20240302010627.12998-1-richard.henderson@linaro.org>
 <20240302010627.12998-3-richard.henderson@linaro.org>
In-Reply-To: <20240302010627.12998-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:25:11 +0000
Message-ID: <CAFEAcA-gircuBZ3Osa5ckQpBpzAHNqrRSXnPZQ6GtzJ3hQ8h4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] linux-user: Implement PR_{GET,SET}_SPECULATION_CTRL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 2 Mar 2024 at 04:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Both of these only pass and return integral values.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

