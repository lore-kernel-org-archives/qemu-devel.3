Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC37CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 18:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swn0o-0002WD-UM; Fri, 04 Oct 2024 14:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swn0k-0002VY-0l
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:26:42 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swn0i-0002pt-9m
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:26:41 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5398e4ae9efso2857209e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728066398; x=1728671198; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2yEjesP4qQwFvs3HmZf4KN/MQveFZrQn2HjkTmy5WOc=;
 b=BLjUptsDZTjytVsLKBNfLkRE0Qom9Ea5Degdhb84GPdPJENYSvJAW19geLvjd426du
 WbqxS6zl8TjGqjBaOQG/8GmfZAdXh8IUNAJ52pG0/Cdpk2A9o4M0ZfuncDUu37xPymqh
 nrPUW0Z2u3mnsWEpLLUyPxEIJMnTMvuL9KffzzMn8mfdh65wMt7qlaUmbMDQI22qtU5s
 q1GiJFGaXRbS/6yIoQ/rEr8guQBwlaYWWzFkpHGsVi3+/pFpK4atG/f0iimlXHDBQUga
 4XV1jTf8VfLljbys4+tzTm4c3yqFaoL+Vqb8oQAyTrRjxm4PjzaF+2Osz7IuFzoja2LK
 m97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728066398; x=1728671198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yEjesP4qQwFvs3HmZf4KN/MQveFZrQn2HjkTmy5WOc=;
 b=Hnt51CMRdwtywIK8rScJ1c5u+yz9DXrGE9/0wsHOHT6yGyhut1y3qevA2zmlxlZQuZ
 JHQszSTFmHfEh/ZccePakozGhqzhrU51ZETajmQsuOt5bZYfCCvTb3S7eTNH/Z8HBSwp
 8YXAibhAXWAuGZ/7Zyw2II5EnbeCPHRmWUOL5ZxtyD5QYmYvr9c1AFsu2CNsZ90J+XnV
 iqouwA/Iqvn8zLlt+5/Nk5JHyxscXzHIpYoWS0n42HUMbkhbDolLEQGa1twmUwuyBM8z
 Y+czkFgwGDAPd07qX9xxYGuca0lEflrZGa2Ad1UgRllUwVL3f1hZG3enm3Vx8AqTMXn5
 0cHA==
X-Gm-Message-State: AOJu0YxjybQaA+Gf3wxw2vAGYbs/Hr2D42WfA4aL7oFtI1JHxK1HBncL
 RYqbuP3xpI1sECyfT1orJ2FEqx0BHgey1kfa4jQN3ziShEsSnp8NCM1WquUDznTm5VPaDk7xcnL
 Fbq33htOD+wFvTPJd6uIlVaH0GNj11uPcZkjnQw==
X-Google-Smtp-Source: AGHT+IEnO7qfCP1Jwtwc3yRwMmCi45qn91QDIo/eIoIxF5BWJ7azQmBL0S3B2SHBtSibSERW+cxcqZZnrrBPOd+Filg=
X-Received: by 2002:a05:6512:3c97:b0:52e:91ff:4709 with SMTP id
 2adb3069b0e04-539ab87757amr2503893e87.21.1728066397895; Fri, 04 Oct 2024
 11:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 19:26:27 +0100
Message-ID: <CAFEAcA-pBSDX=p7pqAHuA_B_yFnCi_-VhdAbec=HiETAe=ZWYA@mail.gmail.com>
Subject: Re: [PULL 00/23] Trivial patches for 2024-10-04
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Fri, 4 Oct 2024 at 17:07, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit 423be09ab9492735924e73a2d36069784441ebc6:
>
>   Merge tag 'warn-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-03 10:32:54 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to 6b7d2f6e1896fb675e8518ed61c792d4dd92e034:
>
>   MAINTAINERS: Add myself as maintainer of e500 machines (2024-10-04 18:57:38 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2024-10-04
>
> - many dead code removals by Dr. David Alan Gilbert
> - forgotten minor bugfixes (vnc, resource freeing in qemu-keymap)
> - some more..


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

