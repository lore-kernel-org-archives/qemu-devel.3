Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA57C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rreH4-0001op-4O; Tue, 02 Apr 2024 09:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rreGq-0001hr-LB
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:33:51 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rreGo-0003Je-6m
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:33:48 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so6060609a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712064824; x=1712669624; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dZaM+0gpcer9rrkxwrVQDkyNdPl6hTnle0VkE5xixrE=;
 b=UjsdDdTlPIgupIBkMwBvSwFB9lxBEI2CSqgbXfiry1tMRmdRKMrmD9Zbw2cjzRD9nh
 SQv6FrMbRAAa/eTh9P7k4WZ3pUvs0VAljjNlKuseyptAvrc6Moh6VfPgkrxt51K4P9bo
 s8ILbaEaGW2Ot3LBSx/8d3T+Y/rUX79Lgn+Pfq70e3U/gtZOcjiOCaUPhrxE9Otv+db3
 0kGeucGxQ3LfNrq3dNuTUBq8jovSbyjEaQrdFyJ2mnReWctEKvEMfkBSIBuBBzqAdf1M
 2WOlwGwOP0fBeIrl304kVpyWOX2uTX6+ZclpNCqXi6+trn2VExRLkpjQ52J8x8AthF5w
 x8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712064824; x=1712669624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dZaM+0gpcer9rrkxwrVQDkyNdPl6hTnle0VkE5xixrE=;
 b=oj+6IDK46owUgz0QX5kiXu+VijYaLAr5k4qxOcW96Bx4QgHAXdDGc+TG/7H6BQhWPr
 LebxWiAzsR2n4rUzoOgmABVgLHqS+gCBfasGZX4fDrYFWEQU+QkM64FgM5VqWw1FiZYO
 YP7emst+WEYCW9656/UVjDjzeDn809TsjFhqsvXw29dvVkleacaQHlonAmwmERbsppEy
 HXFhtEOoeK8pEUes9UuDgHDQrNBkWzoKaAItNvD/t/0ym4NTNxHUQnwEgLfb7Wbhg4SL
 gRRYNQbge6eRKcaLnpCyEXYetOmjjPCSsc/TvDclTuPvHO4fz7YltBSscuCcE1Ht+luj
 xaiA==
X-Gm-Message-State: AOJu0YxOTNRTLQHBuYNPKHdmyLMjianKxauhBUn0gbq0SYoQuto3eipN
 KlAVLjNdOHKQ7QRsI+juJnt7l+54UI0128p7knoMp1weQ6P+L0AXXz9b44FIjjiSxAKaFc/AlFe
 ReCQ0QtZma08gEzTPPwzIQWRA8QaYh9dZjqimLw==
X-Google-Smtp-Source: AGHT+IEYgj6FPkVmklqwFq3/MlkfAHEfPJaaqQ8VTfOD7qP7hoCd+padMmFJL2UBrqcMny1/uriRQKBYZ3TiNp89NcI=
X-Received: by 2002:a50:d65b:0:b0:568:3378:8fd4 with SMTP id
 c27-20020a50d65b000000b0056833788fd4mr8710754edj.11.1712064824473; Tue, 02
 Apr 2024 06:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240402104106.2933247-1-mjt@tls.msk.ru>
In-Reply-To: <20240402104106.2933247-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 14:33:33 +0100
Message-ID: <CAFEAcA8674ZQgWPWV_XD0EjJXdwPGbj9Py+2PEPgZ-3PFFatww@mail.gmail.com>
Subject: Re: [PULL v2 0/4] Trivial patches for 2024-04-02
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 2 Apr 2024 at 11:42, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit 6af9d12c88b9720f209912f6e4b01fefe5906d59:
>
>   Merge tag 'migration-20240331-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-04-01 13:12:40 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to 7805132bc30b2619355b10bbfb67217ac838c677:
>
>   hmp: Add help information for watchdog action: inject-nmi (2024-04-02 13:38:51 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2024-04-02
>
> spelling fixes for the release, minor doc fixes and usb-audio fix.
>
> v2: fix Stefan Weil email
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

