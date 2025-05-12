Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E23EC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 17:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEWaU-0005TU-TL; Mon, 12 May 2025 13:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEWaS-0005SP-UD
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:05:09 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEWaQ-0001Zi-Us
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:05:08 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70b51b9de1fso17676267b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747069505; x=1747674305; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zvRx2YjYaLEAvjVNHgVkFrKkwlNHjH/BSNbHDUcFyqo=;
 b=sd8svAHXXonUh6xPk3zFxaaxGE7K5sH92wfBy4QqG5osNigs33vB/HlTwmP1s3wFvy
 b7HwUqmacvkgwK+lZh29nA+FaPjBzDnYykT1HleqvD5o6eqmLgroOth4DcBynYsD5Z/i
 XGQRXi4UwlQMErFN9cua1DMUf3yirnGP7D6zv6eCUnvoYkMrxmI3CZy0UzUuLLPxLaJv
 JN+W4QsB4VG/uGBIYfoPpjduLNMAVnlw1MiHHV5mhnvgT1AnI7Pp8UN6QW1eIdzfooGN
 wKLlbVF43WoJvRe1qGGwNJjZHfS5fDsOiWgBhOAVme73TDESWlNwlo24Szp0XSzBDZAj
 jGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747069505; x=1747674305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zvRx2YjYaLEAvjVNHgVkFrKkwlNHjH/BSNbHDUcFyqo=;
 b=AD14iHRL/THKQoR7LvYLYTvw4JgrfoQWZfk2o21e6P5drKh1HhLd2EQO/HLwaF5HpJ
 DC1taki050f4sulB6TYwcgW+WdzSRI06JoRrG0axyGhpWYf0vYzFbzNjtLIKSoVCXHj7
 wdA6LVDkSk6/KNwbNnS1ga/46Y83hATQSRvPDPndpm8WdBoqOGaArgg+p1dkquypzRK2
 sEw1uNsdw2jDx4BBLRhdYgUGPt+jY3QfypSlToum6R3Oakb+xsgasx0OC+KvY8gxjsvt
 Xps9iIQpaETDoAmskDUcXauLDoxLPIyCB9aPd1Ana/tiKxuKv61PU9asBfv77fDhnngl
 iecg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHj/JP6i4MIeyL1mx98/QZPfoyrGecUOB2BpLJzS88V6XlKCNZG/vm2uI1R/ylUP8wtc3hbX+lY8Gl@nongnu.org
X-Gm-Message-State: AOJu0YwVy5k6S3G2NrPN+jzq9zEEfWsERAaPma8m85m9lTbXHL+bOWkL
 CCk2MiwIIYNrAyh8wr+A0VqORtD0ckNeqgfMnPCt4WT+lk1MuiuEiGwFMgLLGNJki82vUNNc5zk
 rq0dSoUf2rQ8qib4EMlqcowYD3AF7bWRn77LeyA==
X-Gm-Gg: ASbGncsTPExYvMYOSz1tZrjytHMIuzMQJgdFttHZZSadD2jSR1IweVFdPQxjSooJRcN
 yw++ruTsXjD2+OvL+jIg6CrQlDKdlAG7qzGKF8DV+OhDbCJcVOePA0UIRNISS5ux2MHVaLfayCp
 YGpR9XehIGL3ks/5SrA/EaP4kjhgav8rIhXHxxSIXmKiSn
X-Google-Smtp-Source: AGHT+IGWZXEurE8O5P54U0n4JI6LClwFf259k9kGkbuj8V9/TUnFw2/PLMP2ZE+v1fghd/ZdGo9ftcCpy/pbgyyI6p4=
X-Received: by 2002:a05:690c:25c3:b0:6fe:b701:6403 with SMTP id
 00721157ae682-70a3fa21321mr220702057b3.11.1747069505232; Mon, 12 May 2025
 10:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250508122522.73786-1-philmd@linaro.org>
 <20250510183552.GA116934@fedora>
In-Reply-To: <20250510183552.GA116934@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 18:04:53 +0100
X-Gm-Features: AX0GCFssGz2nVMJ9xqBvywkgpJn-9LACjYeS_v-5zSTr_Ns2JBPNBbq0NH564-o
Message-ID: <CAFEAcA9mav8B+u1-C47KZtc-cnUBGY-f7OZG0QAwtb0uGMdxPg@mail.gmail.com>
Subject: Re: [PULL 00/19] Misc HW patches for 2025-05-08
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sat, 10 May 2025 at 19:38, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

This pullreq from Philippe doesn't seem to be in upstream git:
did you forget to push it?

thanks
-- PMM

