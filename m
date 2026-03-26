Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4977810A88E4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nUY-0007cb-EP; Thu, 26 Mar 2026 12:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nUO-0007Tf-OB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:23:23 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nUH-0007re-01
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:23:19 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ae2ce2fe1so1245665d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542192; cv=none;
 d=google.com; s=arc-20240605;
 b=bEPbJxR3fSI54G/CvbzO1wA/H/6N0ANUr448nuO4gI88TQd+8tBF9A6V6zhOGkLTsT
 nK2BLIo64lwdGqFDW7LOTIe48k2tOifc+UH6QQKEJ9pgWUzR8oN6WRQfmXv+p1OoNOUc
 ycEVZOqfVzeoSqT5lyYeiKDiyGnypQ62uDg5kVOr2zPkFOMMdS6EsviazIXuNCfSUgeJ
 c+8ytvBfYBZdtT1xt3Go83d6GNBnqaCYW0lLdDdL8sUt1eOvynW+71p0bzmfuek0vC1O
 8/aqagNwzfj9wh3B2lTa8YstpnR3rWmjaEmjdsE0efJx6VkBVaXe2ioejwh8RjvS7SPz
 PjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E3KvqjIaNbm7a6LxNu7p2QBgZ49AFMq9LWiFN7Uh32E=;
 fh=HTPvbb48pvvew7vhUKgLof3MF4iC/k4XA4OrNYti4Kg=;
 b=TN3WWLAo5kpHbDSMwDkM+t86Ixws9LXOq0rnmtTZd7YET+bI41zR7MMwTNaOXZcIuX
 V85Sy+uDnzl+fkf10qtZNDCRhScM9gUU2LuB5SoQemg0QRbdCpBM8Yob0P7iPHOfXCtY
 ic71aWxsg8MOGnVvV2MQ+BOjJeymm960W4MRX3bxfQWxjNUxCFrkkQvsPiZaMgiHvIoi
 PVP3lwPpvkFPGbbRX5WGIiBRGqxHXHh5kxsvq4iUMIw11dZEduRv2EiW5qZj9l3Zpzh7
 KZmv3h+fh8gkaVdwIAGecF0kBLp6Dy0p6qbayIMyA4Z27RYe2vBke1rruXpLdrpEeFWT
 zXwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774542192; x=1775146992; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E3KvqjIaNbm7a6LxNu7p2QBgZ49AFMq9LWiFN7Uh32E=;
 b=wOjj2Z9JBNk0bFXJ5+BMatc+iwQlr0beXFrw1pRew6PEwAEwzcMCj4XN/st9ZuYbs7
 QuxemFV92EHKVutkGCe7YlSG7TGegDmuiLdSPK6kSWqb/Cs2jq2yAR9cI2tWS7kMu4CQ
 Vw+U1Ru8j6UTy6p7zIy9G2mGjZadvJYmSDgehKrNPtOmbnYXKOsspe2a8GXUjXZaWDZr
 aaN/9CGxmwwkQfSKmOO6o1aJ2Bs6HitIJijfkklF2Q/E+NDY7JZcpWqf6ITh5BZtVE2y
 STAS5aKy1WoAbE//Xr1bLk9qAitZNoXtWTiUiOquqImfZNWzz+ACNRRzFwlU12yMD7JN
 SDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774542192; x=1775146992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3KvqjIaNbm7a6LxNu7p2QBgZ49AFMq9LWiFN7Uh32E=;
 b=gMlZ1GqaAQ97KOdIqSWFKElQLwSBQpSz2enZ6r6elEP8YON4SLIYycXAXM9rhOhSTO
 0BT7bmx8L2ujCU0T7fzsboVaU0xfdqZd9QaxysnRBCMRgpQNmMfc+0f9Prypmiw5S/UK
 2gLcKGxiZSi6e3GN7gOZyS92Ttrh1Mmh47BNnbNB7uTPCUk1xz8ZsvPSXABE5QoWmY8d
 Ia7/HYEEbWymrLhGAhZRbBoWak9kgkx/CVD+P5FyCyX7XN8C66j0KodiNzzYoAxFynN7
 WU1RIK001EmpnbudCMB+h2AZbXcy0fSA6wwPMy0qMFl8CLGl5IHx3bRQuzWNE7JK6JEJ
 CrPw==
X-Gm-Message-State: AOJu0YzkqA6GgWVI8lrN+r35DUYUeXrqIbhBIdl6J/cxQT8tUqc9hgi5
 KGtqJTcEpg5Yl+b0KmGfsUW6fcz6wncAg7OCj2kRIoU9N1Ao4/Cc5pUMSsrHOG7dsMOjYUZoTSk
 HxdZmZnKhK3yhhu/KYQbnCutNzdC6arJ6U1PhOQQQyw==
X-Gm-Gg: ATEYQzwU/G8D7uktEpBsKo3kYeAYnsRsdWBN1ObgkaLDU3kJhlU73gsDkKe+DrFg9a6
 SgmvnBCrJwvVo5kY1PjBIFwnb3AiG+IXRaM2vFh6f1BU/Wp3dwkkGKNx8WyzbReRbAxZwHBPPF2
 zby+sKoBWfWOBMyMKl4fsja9g0M43xnRFpAJHAm9Ha7/Kro+NEQQO8g6I1wjTm8vxa9opKHqsUr
 +Q5JmwRIcwpNxEuwrcmOO0hFZOtXw14XWgd89TNnrDD/glzUYijoFxXnxr+/RsFLkxWyfBC+lGv
 oeaUjkknVEqh/bMt7+poAhJBiFEmXUa7G4p0zZ9abyWFAK37cO7JcNxqXfz9MlWKhV4=
X-Received: by 2002:a05:690e:24d5:b0:64e:9cf7:95a5 with SMTP id
 956f58d0204a3-64ee612f9eamr5792573d50.44.1774542191536; Thu, 26 Mar 2026
 09:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-5-kkostiuk@redhat.com>
In-Reply-To: <20260326160033.68318-5-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 16:23:00 +0000
X-Gm-Features: AQROBzAL6OMycNcPK4g6tPvQeDwu9YzsbCBKVyZA8MsDXLoI4LfW1Cs0juvRjns
Message-ID: <CAFEAcA_JEHXu_FdfVxEG07XdM1gL7KE6K_5eVGaUVMY7zj=hAQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] Remove unused dirent.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  util/drm.c  | 1 -
>  util/path.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/util/drm.c b/util/drm.c
> index dae8ffebc8..afa9c400df 100644
> --- a/util/drm.c
> +++ b/util/drm.c
> @@ -18,7 +18,6 @@
>  #include "qemu/drm.h"
>
>  #include <glob.h>
> -#include <dirent.h>
>
>  int qemu_drm_rendernode_open(const char *rendernode)
>  {

This file uses opendir()/readdir()/closedir(), all of which
are specified to be brought in by <dirent.h>, so we can't
drop this include.

> diff --git a/util/path.c b/util/path.c
> index 8e174eb436..72a255890e 100644
> --- a/util/path.c
> +++ b/util/path.c
> @@ -5,7 +5,6 @@
>  */
>  #include "qemu/osdep.h"
>  #include <sys/param.h>
> -#include <dirent.h>
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"
>  #include "qemu/thread.h"

This one is OK to drop, because the rewrite of path.c in
commit f3a8bdc1d5b26 removed the uses of the dirent.h functions.

thanks
-- PMM

