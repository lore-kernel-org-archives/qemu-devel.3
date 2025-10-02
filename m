Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBF5CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 10:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Gdl-0008QU-6c; Thu, 02 Oct 2025 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v4Gdf-0008Pd-V4
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:34:21 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v4GdU-0002dv-RJ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:34:16 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-72e565bf2feso10088467b3.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759401238; x=1760006038; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G1PifXCYidVavLIwD9Fxaih9Keb6v2gXNLURiE+Wvzw=;
 b=gP5opXgrXGEctdbftq1sg/k9D9ea8lmhrJissp61LzYsH3UFuxOsvV7bBJ9+8BJi0N
 rwsK+sBZFJw2ix9a3U0EgedKpFE0G0x2xYU85DyawmTGkXIEqbsFp63LEYiJsiT63Y6r
 nXA8iYqqvH5Pqa/oie3DJLN1bZJHhnMRXQppQgQXIGxgxIfjtw3zJDpdA18cLsbZqWj7
 ZCsB/ydZflnk8DD+mkvBhWjj8sdeEf1J7H3LzDs8h5sDW4SA2JPzxkS8+QMXMEvFOjby
 Hmebwn3oyqxt2Vsmk1nFFeMcY2MPiistybGxgPvT1Q5P8ciLUN/+eXnYPoG1SWOZhVjM
 lPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759401238; x=1760006038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G1PifXCYidVavLIwD9Fxaih9Keb6v2gXNLURiE+Wvzw=;
 b=CSqHzgcUHDbjvzmIyImKLtYpcZrAy2YTCzou3nXjlxF3BJbX9uGA+ITNjWPMgate/S
 YdM01v1U8gy4G2duijUWTCtSO/ehUf1rySF2PYb1tA2N5etQTeMM0J2E/SlmVQNlVvOv
 j5Jf3JWllhZQlcaLFfVuzU5Uf6M6LdIKJhHI3rvC2UPLYX0M8eLdku9vVWcfQdcLvhKR
 Fi9n4U5XiRo3eFMMkXeVIqlBI2qm66n2vB56U7tt+FYxb1k1ggoFL5W1WrfUAMmAPmDz
 l6F291qkW7VgZXmkcWUDoiw3xdrAX85I5EM0HE44gh3balZTRl2oQ6jOzlqJbF/4y2I9
 cFyA==
X-Gm-Message-State: AOJu0YwEQgVrTJx5cVWPM2QT/EfE80+kLPFJYhiusWW5qhR7W7dngCrn
 znDcNBuwKbKy1OPd0zRYX5jdn8Q9rItA6ynAGDGTe3Qt2YmFPClD9MhXdH2F9Pgr++CImV/d1FL
 TUXnb3lfvfaQwuzVokDl2RbTR9GZ+sw1p8y/U
X-Gm-Gg: ASbGncuhHLsQsG9jcfs+UNF9up0eGEzdsjN5eDSGbQ1r6lJ8DUqZW1lV4FeZOaHZMAL
 nIAjnOZTSNuBaBDhamcNTJ5ge/YsIzm4hwCe7GIbby6FJAbZkmpWUfPJ+49QJaUve1Og5txUDgP
 wu0kA6OMVaL66iRqoTD7C3RdNkS1J4ofXKgCUWP/gzDYoclIke5UDzKnLQJ60O9FMLu+a/0PiqC
 OteLteb94k6rVyT43sjEQItiMEFrclc64d4rp9pszNJ15II+/0v2fiHg9OtffYjWcQuKQl8Y6hD
X-Google-Smtp-Source: AGHT+IH2KUo8moCjnnelaYThmIkO7yONDJQZ/2kP+j2p1v/NfULpcGa4ub9tZHpIbWTdLQcKyzhtI2eA6TvTPFPUe/g=
X-Received: by 2002:a05:690e:434d:b0:636:1a8d:9d43 with SMTP id
 956f58d0204a3-63b6ff47fa5mr6117377d50.40.1759401238206; Thu, 02 Oct 2025
 03:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com>
In-Reply-To: <20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com>
From: Gal Horowitz <galush.horowitz@gmail.com>
Date: Thu, 2 Oct 2025 13:33:22 +0300
X-Gm-Features: AS18NWBjG-KatCdoxDEsah6UkDnkUgiBVXoQrHuLoyrdpXqx40xjlydYHgMMMJE
Message-ID: <CAP4rq2AYWTn5=-kGsDkwbcCAX+MMk7F5FRFd16aw5hAU2iMDDQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] tap-win32: fix multiple tap support
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=galush.horowitz@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hey, friendly ping for review.
Patchew: https://patchew.org/QEMU/20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com/

Best Regards,
Gal Horowitz

On Wed, 24 Sept 2025 at 17:50, Gal Horowitz <galush.horowitz@gmail.com> wrote:
>
> Currently when more than one tap is created on Windows, QEMU immediately
> crashes with a null-deref since the code incorrectly uses a static global
> for the tap state.
>
> Instead, this series allocates a structure for each tap at startup.
> We also take care of cleaning up when the tap device is close.
>
> NOTE: Checkpatch has a false positive on the first commit, where it
> mistakenly flags a cast before an address-of operator as a bitwise
> and operator missing spaces.
>
> Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
> ---
> Changes in v3:
> - Split to multiple commits
> - Link to v2: https://lore.kernel.org/qemu-devel/20250923-fix-win32-multiple-taps-v2-1-d497e5ac446f@gmail.com
>
> Changes in v2:
> - Add cleanup of the structure fields
> - Terminate the thread before freeing the structure
> - Link to v1: https://lore.kernel.org/qemu-devel/20250920-fix-win32-multiple-taps-v1-1-bee41dcc213d@gmail.com
>
> ---
> Gal Horowitz (2):
>       tap-win32: cleanup leaked handles on tap close
>       tap-win32: allocate separate tap state for each instance
>
>  net/tap-win32.c | 44 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> ---
> base-commit: ab8008b231e758e03c87c1c483c03afdd9c02e19
> change-id: 20250920-fix-win32-multiple-taps-ed16ccefbd17
>
> Best regards,
> --
> Gal Horowitz <galush.horowitz@gmail.com>
>

