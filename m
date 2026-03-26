Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F3B10A88E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nfL-0002sc-BJ; Thu, 26 Mar 2026 12:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nfJ-0002pq-NK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:34:37 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nfG-0001j1-Cf
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:34:36 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ea73e7b60so1280528d50.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542873; cv=none;
 d=google.com; s=arc-20240605;
 b=S83aayVjRiCqF+GBopYWCcfGNz0MhTLn+XnJdpeHeIA0oXMvmEQM3lB49pnnrY/9Zw
 yNok6GqAFScAtoWvg15TY93vcN67EB1VmCBwP69ZLIkinReWSQIEgXdvNqYzKzrG9uk7
 AqkN9aqIAF3MNwpNaMv3RQlX2V16+3Pr7nUK8wAneCmtQzTsgC/0fVLwyrLFDZUmtwli
 h1DClggJupfm8UNXFG/qBzSC8uPGPkb8C3oL3JxOCQzE5qAqdiB9gadMT7iLNOhbVgld
 lbXYUyx3E949AkV76JstWujZERwHI1i4iGLFgIuFW+RzRxJK2UXQWbo46BGciZHsjVV8
 EMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QW1+0NajNhWghBEMbjMqAtjHpOo6yU6hvye6zdfH1PA=;
 fh=HTPvbb48pvvew7vhUKgLof3MF4iC/k4XA4OrNYti4Kg=;
 b=TBTstHyqCIJg1X0nzwBOuPxXQBU0l2ssxTii/k4pnaadAI7zNd7dSDUuxEECK+38HZ
 cwMPH6Ypn2ctG4OFLoBr2CqbHWzhK487JGTW3EnKfvTxbMR6mVp3dpdb4sP17CEseITE
 wgt59kKkKicwfKPSpRtxD//FBKRcX+wr+hGzEMJFwWKX5Z9+nTbVdmXud1OZbVIhvkaT
 wT6rkC1iMEaP+SJUPKH4zGxZ7bQdu1G8F96SFv/hz2icJBzhDk83ZE2Yyb0ScjbdZNX8
 7J3edMzk9ImawoljM3L+IXOz9Z12/eqLxGCh0faHOgg/FDgW81SvjecaiDkDESAg0P/A
 t2pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774542873; x=1775147673; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QW1+0NajNhWghBEMbjMqAtjHpOo6yU6hvye6zdfH1PA=;
 b=SwQpYL1VSWvmA9KQkRqzzb/zDTT/bjQFBobgVvFbkY0sVP1qavuuwdM0hCutBDscg3
 AYxIgch4e0mxEUJQJq+HT0G9bKQuY7ipU+IWFvkaFSJorVHRBeIs5w4VGzxq4045mIHr
 I44FehXPu7dx81udhRAXXtnJOG/V0ACgEj7Nis53fNcPxNljG+zYMUFjunHMro9IfPAS
 769HQpouJkqN83Fnq4c958ZZdgAhtkLjKwFwyy1SD260VaI5DoZC1kC5TpEMgfcOomsH
 fEz15qLn4WpmdrCYHjFQzt2lBzS9rVoqC1VTrV3d5ZpxHUr8M6c8GYQC/nQwSbhxBjwX
 dN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774542873; x=1775147673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QW1+0NajNhWghBEMbjMqAtjHpOo6yU6hvye6zdfH1PA=;
 b=gOnMnM9GMKJwX8J3BntgPXwNGsHl93Mrj71FwKkSvwAOtS5w5/46G/HNzKxA/vMnjS
 iDgyyPhsLXoSEpbPIMpoXuPsW+tEu9kdhI6EPgANKzUXsmw18M6dh5HFLUGMWPNlsSzA
 cler9tTxb2vo0oBmU5NSEu8EOBPdaCJmfBM/DL244Ekt9ULWkBjwC/K5HBD0nO0so7KV
 A3ErXbkCkii7FERvkcqbKPKo1d/vSUj16llrmC08cXxK4e4eJrCXlA38bZH01YSBHeKZ
 2M6auJ1x2ucGb/B+XnVAeKrXY13a7GznRFBrKSGvgS/FevoXQMJpIZsJc53Hf8ID9cU7
 xmtw==
X-Gm-Message-State: AOJu0YyZhx4VbYS2uzFaHiKh3seXZqaRNknrjVIK12SvgHuoRq0nLo7u
 WVX20Ar8J2uPmuMHb7Z3iX5Fg4ZkClJAoU98TSvYb19PS6AvGrnIHjVfHj8Fp99TQVvD3iuCupt
 o+zwXrJl0h2mnKg0h4ceKeZyo7IOV1gFHbuskvjKAPQ==
X-Gm-Gg: ATEYQzx3YRJE/Gxy2qJvi0ghvpONXOYYhctw90aG6ZXLI8FRqfw/4CsRmG1sJWL368a
 KMoNN4ealo98eerlpEZFlL/D7hS24oxtphTNJVcP5+3yYlxLZyi1ATGftPtGbaUG+1gfIVfciTj
 WygLOZm1BRYzX6iM4G4d9+zmELlE6UE1uEpVnWw94Y/oyxmI36bOQFBYyn+iZBBQW3tgf/QOw0G
 bcqYtkk6ov2NWdcVbPV/xf3RMNL8MS/gM8nBpInXn23hFE2YxWDDtK42EvBfPCoUje38ewC+4b7
 vT1UrlQNe4tPvt5reXfA1G0PIMiOOpT+wB00YPv9i57PYyz56S9UJLs6bjQXrTPnPW8=
X-Received: by 2002:a53:d017:0:b0:64e:8d4a:d0c with SMTP id
 956f58d0204a3-64ee60943aamr6945628d50.31.1774542873006; Thu, 26 Mar 2026
 09:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-2-kkostiuk@redhat.com>
In-Reply-To: <20260326160033.68318-2-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 16:34:21 +0000
X-Gm-Features: AQROBzDEKjM8-Eelb0VcnK-E5Pzuosn5SBkrgBGh63dxN78E_snsMwKT7ckCdFA
Message-ID: <CAFEAcA_QcibXPCDpYPNTeO6RAZPaSAkFKMTnd8Uf0rK-FKLnQg@mail.gmail.com>
Subject: Re: [PATCH 1/7] meson: Use stddef.h instead of unistd.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 26 Mar 2026 at 16:03, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is more cross-platform way.
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index d7c4095b39..711dafa9ce 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1060,7 +1060,7 @@ endif
>
>  if not cc.compiles('''
>    #include <glib.h>
> -  #include <unistd.h>
> +  #include <stddef.h>

POSIX says stddef.h provides size_t, which is the only thing
we care about here. (But it also says that unistd.h provides
it, so your platform is broken.)

This is the kind of detail that should be in the commit message:
you need to explain why it is OK to make the change and why
the previous code is wrong.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

