Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A98ACF34A0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 12:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swKXG-00018u-O7; Thu, 03 Oct 2024 08:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swKX9-00016N-Gn
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 08:02:17 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swKX5-0003mO-VG
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 08:02:13 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8a706236bfso58295766b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727956929; x=1728561729; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAvSrjhWim9UP0Hyli75iN10SnffLjufaKxnCvC5Z3k=;
 b=ji6O7HodHHNvKp6FgQjNQMEuHPaHTQczMj5t/RfD5l1NTIA3B2A0Y9BefybqZJ/fEE
 Dndv2UuK57M7WrljOgkSvor+3z7z9PEurqMU4KNqE3ykICKzmhYxmI/SIym8hdZ0Yhga
 UgOrqjzowfhDxlnY996z6stygCp1RQdAumumA8qeDUie7qvyyYVJrElx7rtEzhZlINcB
 sJJZWPxcV4K6u7KRlWo1Ex1msC+5hWoppVXN23O8YgihleHZFPKys3fFrjGoR4f8euYG
 6GWzdFWkPRq3oSRZan/tbAl6CyozQy5xrZyVdIcr8ELKyqJzaosiNWRxrmP+PobshRqd
 Bkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727956929; x=1728561729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAvSrjhWim9UP0Hyli75iN10SnffLjufaKxnCvC5Z3k=;
 b=NxNHJi2w4pyJxu6Q0zT+hsas/98K+LLI01+BZK9V7fm4GMEOzDnXOMHj178VcvJN83
 jDKyKBBGNFlKszH0lMORlp5g40VeZl1TnmHZizWyNo/1ZdXyQ8k78LsMPBj0CMPz5ONY
 f+RqezY2azu56xwKgMnnKl5VZQ00MO8knSsUhsYRx4ESjlqQFsmTUMv9TxUbSJ7+x+Uc
 f0mMtUhVNXiN0sfwNlL3bDarAQuHvJ3aUMdeMfiB5ydseKHk/2fdrOpKI5mgzgMtk3jk
 sSTht/EIKullCl8hkf8HPEdBRB6++2pe7dHQd9FmBQpoaaF/aDEnC5ajoq8pRSyx6Kn5
 pNbg==
X-Gm-Message-State: AOJu0Yxo5nczHqCyYYa7SNhl/OMRc/euO0YT3Z2qyFnxJMqKcDcXGuNB
 Eg0rxGARJoUq8EDU06XZYkArWHucX33OM7gqySmXskx/nMgx6ET98bwJv2zyWMH/51SGXQ37RV3
 1wgRsyvvVpMvBaeX4OaeclKj+i46J7VSNLwIiXQ==
X-Google-Smtp-Source: AGHT+IGsGkptWF2JrdrqfFlDNNTVkaFBwrQ3Y2PXfbFiRZPoEAuaw2sHteWAFy+wTajdzRTyAjaPQ+iUa1UPRhK8ZAA=
X-Received: by 2002:a05:6402:4405:b0:5c8:9f44:a0b2 with SMTP id
 4fb4d7f45d1cf-5c8b18b9d5cmr7891724a12.5.1727956929408; Thu, 03 Oct 2024
 05:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241002123417.2974893-1-marcandre.lureau@redhat.com>
In-Reply-To: <20241002123417.2974893-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2024 13:01:58 +0100
Message-ID: <CAFEAcA-GCt0BwmvtZeL+f0i8MSJfPCwB2mHC1BndYfvaAqa6Zg@mail.gmail.com>
Subject: Re: [PULL v2 00/22] -Werror=maybe-uninitialized fixes
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Wed, 2 Oct 2024 at 13:34, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 062cfce8d4c077800d252b84c65da8a2dd03fd=
6f:
>
>   Merge tag 'pull-target-arm-20241001' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2024-10-01 17:40:25 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/warn-pull-request
>
> for you to fetch changes up to 8f3375434d45e56db51b5ecd4d8a929146ba5641:
>
>   qom/object: fix -Werror=3Dmaybe-uninitialized (2024-10-02 16:14:29 +040=
0)
>
> ----------------------------------------------------------------
> -Werror=3Dmaybe-uninitialized fixes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

