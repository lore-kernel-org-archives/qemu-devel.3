Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13294C5AE49
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtQpR-0003ap-AZ; Mon, 10 Aug 2026 10:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtQoj-0003Wt-QW
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:17:33 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtQog-0002cz-K2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:17:28 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-80bb41f7f3cso19467817b3.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 07:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786371445; cv=none;
 d=google.com; s=arc-20260327;
 b=hdsmU/aIgKAVgjOj7a/9C7iCeoBmWU42r5dTsYPV513CcoLNVvPtn1r+zni5KHRlxB
 zBhj0cjTR6eV6gcQKiP/3CKCmq/bwbfJlo6RKlgjpD+dZ3DIIPgXWOWXW/Q9JFlMJOw8
 DJaWKIm9AhrrbLyzozxpEU/AZEjryQYeiiJP2dQRm127JFz95pINvVR2K4JsWW/F6uOF
 ZxMLhKQl/Q59/fXVbt2/LqFkGlCFViaR0R0292CluaYO8fPY22rHz/J5nnt2YGGn0MPs
 WcrdWVfYP2o6fuPWk5MIs9uhJWMppZm7kfAt2IHvuPVCboD1iBtDD5Z+a/ghqILbTp/8
 memg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tWabzeHPU4UF7K0LvwXAvuyY2Qr/ELZJGmNyrH1b2fQ=;
 fh=7FzEi/2LFrewGH2MJzBtQfwp2vNgslaa5OqjoXzw9FM=;
 b=OKFuhcP6cVkDsjzy7udEzynKzbgrvHvR4IwJ3t9akMlnDotqOwyvd9vD/KKnn2eAul
 U0hgGHc7D0+UVL/CpBXzRVfmBmJCNCQrKj7iLv4U8K6SSLxFotg2whZ8RL2e/AwL2NJK
 OKRtFAaeyRibUmrof2D8ZTxcZb3jAFxg63paD94gOObJJk3oP50mgMcR4TKTdVXsyTVq
 zbtPpnMZTpy3TlEv+Ue8Xhln4cwKAkQR+612a8ULxv7A3JTFfNXueVSnuQ5cDWFfICh1
 wCuzwJl4Bg1x8zNRm2+tc26vG0mF21HX8TtVBb9G6XqRY2bexraTg3ztMyZFP+j/4K4c
 NWTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786371445; x=1786976245; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tWabzeHPU4UF7K0LvwXAvuyY2Qr/ELZJGmNyrH1b2fQ=;
 b=KerQL11+FjsIEg8CfC8is+8fNy0vVKkHoQJjzBXPC7x3Pmj1ea6mxS7GvDc/5/iowQ
 Ra5+Hb/QEaRSsQFkaaYiCnQtnWReaVM6TeLOOapoBNqQnBkuKsb8KKjWzzw6Q1o0ffMp
 6OGscIJ5c4BlKrfRCSsRP34tFMbjuJcRdXxoWvM+Qw+P9DNKseihZ1kkqmG+kvFTOFgT
 RpZLJbAXfS7mVuPOlipHmHLwYjNchhQL89venbgfNFKXLGYTvBLCT2hcFhTisJBwYC01
 T5XQNnfqgcx6cau+NSFBdNx/HtsBqOd94x/YcX9YRwF3SzUv9zikoIh095YLzQir5Tr1
 2hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786371445; x=1786976245;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tWabzeHPU4UF7K0LvwXAvuyY2Qr/ELZJGmNyrH1b2fQ=;
 b=YYApifi1oepjv8Sb7y6C0tdVtaggeb4GFedCEcPigjK8bJxtVfEXIddwg8XxPf/Nwr
 04tDnKZxwglZ5fT/3Ny5L2mrc7WvqLo1hVgBNSWv15M9m3S7asH7Jjq7JGY3lg71tqpJ
 PO/mXR+fFbUS8qzKmdOhvBruoE8QYAoKLWKjODCUSe+vwB9jaBrUeW1N6U/aUa45CcHQ
 IHBqKnOgYUSWCTxjPXaEHZK8nvUt1R7LPdWnVp3niS3wieHFNjFJmJhy0Y5AtkDkPD/x
 1sbUQAv9McMCc3wvdzvGOH3rwj2kkgthQSilUwu/5Fs2PpD7KRVtgq1V5CatfR0mQnaE
 QLMw==
X-Gm-Message-State: AOJu0YxE36z/UrOvLvj2pTggC10cHRVrSay8P8EzW+VMRs8IJKWxT7Oe
 wqVT+zCeyGhwsi36UmHd/CI611OIGifJUVISy7Hd5jy5GY1b5V5B0hKMAUOIM5OZ18pvP7rR5if
 pqrETs8uwUMZK2lBHDfYzIL2/3EWDt8qCQ0urzeFY9A==
X-Gm-Gg: AR+sD13ceT+R4Oku2RkB2ytIh3LKJ9QfswuLQ3tcmGCiDXvQw4oLsQcEYkMEKA59T+C
 bOcxU7thHnHLTiqgb/LF1q8ySiZ4ckH8l67kGlClVoa1MKqG+mwcKgSx4CxveErusM5DDl8RoSR
 upsQ0RZTZNF40v1OJ2fmalCHKT/WYyfOaILzLO2/LuJRkrpPC1XFv3s0qqF5Qkd2rHZusSSVMYF
 lrh+pDKGxUz5eUamrjRcbevPjp63X3Px+4Ze7+xdMTxGLV69DKpSe2rwcjEtjhrUlgy6dFGkbzu
 75hGF0nd5xn/FsiCqVB0776u0BVniQ/t/4tlIHwudVY3H0zJcRE00B74PBPNkhd0aMyM1ghP9Lp
 2l6xHeN+UPhNrujc/M1Vvho+795zN
X-Received: by 2002:a05:690c:9689:b0:80c:3848:bde5 with SMTP id
 00721157ae682-82258a8f2dbmr162698237b3.13.1786371444478; Mon, 10 Aug 2026
 07:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260810140641.161728-1-kkostiuk@redhat.com>
In-Reply-To: <20260810140641.161728-1-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2026 15:17:13 +0100
X-Gm-Features: AUfX_mzsnHkUhv2_MIG0gojrQ-ulk9p8cy-Da0BvezrYqYMAeGCNQ3qEMpplUj0
Message-ID: <CAFEAcA996EVXzZNTH4cSM0iFf8iCdM-ZC=voMJSvnz3B=W9c=A@mail.gmail.com>
Subject: Re: [PATCH v3] qga: Change effective user/group ID in guest-ssh-*
 commands
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Valentino Paulon <valentino.paulon88@gmail.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 10 Aug 2026 at 15:07, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
> SSH key for an existing local user, the agent (running as root) decides
> whether to create the user's .ssh directory with a symlink-following
> directory test, and then writes and chowns the authorized_keys file.
> A local unprivileged user who owns their home directory can pre-stage
> their .ssh directory (or the authorized_keys file) as a symbolic link
> so that, when the host or operator triggers a key add for that user,
> the root agent follows the link and transfers ownership of an arbitrary
> root-owned file or directory to the unprivileged user, who can then rewrite
> it to obtain root.
>
> Fixes: CVE-2026-12080
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
>
> v1: https://patchew.org/QEMU/20260709105707.91209-1-kkostiuk@redhat.com/
> v2 -> v1:
> Change effective user/group ID instead of checking for symlinks and
> changing ownership of the file.
>
> v2: https://patchew.org/QEMU/20260810104659.82320-1-kkostiuk@redhat.com
> v3 -> v2:
> Deduplicate code.
> Fail daemon when can't rollback effective user/group ID.
>
> Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/commands-posix-ssh.c | 66 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> index 661972e34e..070cdffcd0 100644
> --- a/qga/commands-posix-ssh.c
> +++ b/qga/commands-posix-ssh.c
> @@ -8,11 +8,29 @@
>  #include <glib/gstdio.h>
>  #include <locale.h>
>  #include <pwd.h>
> +#include <grp.h>
>
>  #include "commands-common-ssh.h"
>  #include "qapi/error.h"
>  #include "qga-qapi-commands.h"
>
> +typedef struct EffectiveUserInfo {
> +    uid_t uid;
> +    gid_t gid;
> +} EffectiveUserInfo;
> +
> +typedef EffectiveUserInfo *PEffectiveUserInfo;
> +
> +static void rollback_effective_info(PEffectiveUserInfo info)
> +{
> +    if (info) {
> +        assert(seteuid(info->uid) == 0);
> +        assert(setegid(info->gid) == 0);

A brief comment here about why we're happy to assert() here would
be helpful.

> +    }
> +}
> +
> +G_DEFINE_AUTO_CLEANUP_FREE_FUNC(PEffectiveUserInfo, rollback_effective_info, NULL);

Don't we also need to g_free(info) in the cleanup function?

thanks
-- PMM

