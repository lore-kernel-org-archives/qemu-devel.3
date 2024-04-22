Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA0AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryt3L-0007Ix-QP; Mon, 22 Apr 2024 08:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryt3C-0007D4-PI
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:45:40 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryt3B-0005Lj-9W
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:45:38 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a55b10bfd30so84997566b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713789934; x=1714394734; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Gvssde9/xaurWK599MgZqx+vkz5GaGp8TSAAqSjOMw=;
 b=GyxE8pGfBucj0lBw/e05ZkKM58hQyf7kg1P5vUW15XhThONP4mNd60Sz9wywG6Y70+
 5WoHha33wDJ+S2csg6hsQkxYpy/UpUgZlmsSQWizVfqr59WpGl8c3hsJ4cbttltl46vs
 pGXALDD4DkQUyZPUioHF56Xl3e7x8OtePyJAKWmEVMDpi5iOAhG7Xd2tZ9SxYGGUdUc6
 LSylJCdsfm1qLU5JnMhWO53uH7PwqLFdRG/VKbv+FWF+Y1OO0XrBBCThsw8oXGTuJx3F
 Dfqj5oFEcWLmgAk06aEDd9IOHUmuojGwAPNi8R0IwWBa3rQaAKTmmRrx4FKNwmkJwJ1a
 TK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713789934; x=1714394734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Gvssde9/xaurWK599MgZqx+vkz5GaGp8TSAAqSjOMw=;
 b=KqtEMxHH0s6CIoMG0JtjMXyAweaI37N41mbpHPFsNqX7I4IStIQEOCkk40I2z6+cU/
 dcb6e5wMzOxTSpqR/R2awj5y8ZqbQMaZr8+7wJE5f9toDXeA1b1uq+3+HgdQ3Go50IXf
 RCndDkqYC5DPz2xbezubA0nq/1PWUKE2zVYndVU9JEguWjcfX4kj/ge/gVFnBOy1RqgI
 QqDQj8CwjVQREiw5s7TW1cMUoy3NTHSo7MpwSH+1rInu3e8QeeNsUYcwEY3XkDeH14OF
 fwB6a0wa/6+gcQ1IDc1FOpnmo/f/RfdvO4PTUbdRLBmCpbOMygjNgEniG5sQzXLez0TI
 MXhQ==
X-Gm-Message-State: AOJu0YwVx77+Ys9orSKrGl8wJHRybQkyUcv6C/uyZmqWxIS1lo43Tnc5
 pXfinQWEMN2juYrC6KAJ3Txj+K5N2H3F2kINdP13mDMZaxBf3c5XIWHgNtr/AzYvynA29h5kGBq
 lQ9tkr4ACXiyJNjCFPN8qZw7oXj+HgEIzYfWwog==
X-Google-Smtp-Source: AGHT+IGotxdISTlx1oD6A4f/aljsRACWpwmNSAotUDKFGgabI6UwsdtoR4xXyVi+ljmv6lQ1EAxZqPTujQ5RpBkuK/I=
X-Received: by 2002:a50:bac6:0:b0:568:d19e:7ab0 with SMTP id
 x64-20020a50bac6000000b00568d19e7ab0mr8330839ede.36.1713789934271; Mon, 22
 Apr 2024 05:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240422124128.4034482-1-manos.pitsidianakis@linaro.org>
In-Reply-To: <20240422124128.4034482-1-manos.pitsidianakis@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Apr 2024 13:45:22 +0100
Message-ID: <CAFEAcA-NgdMgJfWZqWV7khgnEzz8K7NWPg6tgHDKtA+KaP85eQ@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: fix minor typo in submitting-a-patch.rst
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Mon, 22 Apr 2024 at 13:43, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> s/Resolved:/Resolves:/
>
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  docs/devel/submitting-a-patch.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> index c641d948f1..83e9092b8c 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -177,7 +177,7 @@ add an additional line with "Fixes: <at-least-12-digits-of-SHA-commit-id>
>
>  If your patch fixes a bug in the gitlab bug tracker, please add a line
>  with "Resolves: <URL-of-the-bug>" to the commit message, too. Gitlab can
> -close bugs automatically once commits with the "Resolved:" keyword get
> +close bugs automatically once commits with the "Resolves:" keyword get
>  merged into the master branch of the project. And if your patch addresses
>  a bug in another public bug tracker, you can also use a line with
>  "Buglink: <URL-of-the-bug>" for reference here, too.
>
> base-commit: 62dbe54c24dbf77051bafe1039c31ddc8f37602d
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

