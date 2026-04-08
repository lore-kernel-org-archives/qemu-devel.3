Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322A710F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYTz-0008Ve-Jc; Wed, 08 Apr 2026 15:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAY4g-0006Ut-PH
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:56:26 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAXRl-00016Q-Qc
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:16:15 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64f48a5c3d8so46237d50.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 11:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775672171; cv=none;
 d=google.com; s=arc-20240605;
 b=MR3YZhD6PkSLJqyhvgsDdd/YA2AZYH/vkqo4XkIMgh3SisqC1IjkpjRgnrrEp5H3nh
 ulI0XMtZJIkrJfS9CXx0oOW+RzMJ7oI/8Ym3CD5sjXKO1GaiskFsl4CM3SaedThoD3sQ
 n2Urm+f8fWu0WTqklw+y7DgmrCBTQYK4Sjy25ZI6qnsHnpa/GxKHVn8f8Eia/GkJaHPZ
 fHQbKZYG6n6aOsLlRffLusdA3SudfgG83ZbGHse2QzB4E53PwjgFnXeRQwTRKJ7JaRqJ
 6mM5eQZa516QhwI99aeQeZW42B8OflHIb3QpiHb2ZKJOdRR9Z+IMPk4AZmqPyUF6HKbf
 9iIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pKLfQ33XiCRiNlynAN/2fOlxoo0Fd+Z9Xj6+c8ipyzw=;
 fh=o9NNXRRpR1snqmakVgbq3eXDVCQ4hGFs6Xd9sNLXLEI=;
 b=XG6SYcV0Yt0xWhyjfgt3f05tDj0AQBm4rBceqo9j9y9b6pruJYLqRKHccO3Uattekg
 X2ZgRK80omnNz8KoBf+4n65VRLSzZ4FeAbSubv8gbqb8B6ZyFMInEcUq3CykoqJr+Zgf
 hFmhQ4U019V5u7pkobHu+zTeA81+HWI88c8eGE6uTsnpQHLa8mB4VK2yKatOYsvRIxMp
 eoloxUuiYgtIPA+qwEODi+NoiCfDi4hl0Jw8xMTjrKNrZwYZcobvXY0afhcJ+zsb2q6v
 FNFlk8+tW7+6TlSweGmauws0Selt1xUw5ZDiEp03Y9mitr4MF1noxBIQsDQIFxpigqrk
 N1dQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775672171; x=1776276971; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pKLfQ33XiCRiNlynAN/2fOlxoo0Fd+Z9Xj6+c8ipyzw=;
 b=lOAObgOYnn5Kl0d5SV8QAbisy435WfIYWl2eKQLa8p+lng9UF0LEmlHVK38bl3uzII
 r+OAkQ/XGeYd9JCbUD2I5/AJ9LTK10d6rtBkyi0DzKtbBR9RFbnaYhQPU+R3sp67M5li
 vWJ7HULjh/UdzjgwY9P1NeFg1J9TMRZnvNN2TKc6Q5DTlIkcUyVFQcXrOCxA+2AbxyFi
 QfLybK0yiVMTNBYwvKr63KPGBPWRQ0F2CnCDnGYj3bT+DivHpsRfotzKutGDogf25jML
 J9bhC6oedMwnw3b510ceXTpDlqrUYD4tn5CTOM0WQIWZno27+f7dyj5N+dVg6NuDv4wf
 mF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775672171; x=1776276971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKLfQ33XiCRiNlynAN/2fOlxoo0Fd+Z9Xj6+c8ipyzw=;
 b=eNz8rWHLBOOApJW2nnxbo3Kbk3+hspQb4UQmDme0MRQxHDlJApsYvMhC40kSQ1q2Wr
 HHL7evY0+BAmgV2bzi7KZ9sEhavSq1uzlstgKQOgaHBBjDMlgqTBkCHnaLxu3vv+jnyU
 4wHyYtSI04zcV4P49MR2zMTzluHnopbgYJK2JSdXk7mOp2b+P/Uqfglfbl+x/fVXBdXs
 RM/bfN1FHNM9n11O4yCzqyiDeapjOVMTXOfjgeGryQKRMtLZqbHloOrgZ2So15EKTVFV
 YjVrPLsWqzFsetPEFkgwo0bzGwCTcUW97u/guBm6+b0i69NjBh3hqEVobrYDX6lDsfPK
 DgRA==
X-Gm-Message-State: AOJu0YygkvnSE9R2BXqqL4Pjb8Pl9D5oqzuugW1svV9CJ2wWKN+Lhvja
 mqciB/dqdFHZpP6/ce9FzSkE0aLpogVhZSfACN3XSK+MS5rQfr9uINicRt3nd/Pg0rhbziFdeUe
 NQ5vkqRYNxkQD0VqX4Mpmy0AHClJvPVZCi2zB9ZxYMdxQsKQr1s3qphY=
X-Gm-Gg: AeBDieuobNcza+OUXn7GeQwgdwT8fi9jAcS67lwpzJYMN7NkfXBDPpu5Gg028ZX5/Vs
 W9epi4OIV3UlTjtPKMwPQTcRgZgHWZTiUxPW5x45nyd5kNpZefDQ4WOSvvDR6TqtqmuxUDOKik3
 cd7tqDev0befZeVyW7ECwxqV9vBdBwz+wL/cyGMkmcu1A5EL5cJzi1LRdNVyWTWPJzFByBJxiY5
 PBvsPgR0y3wigIFd4CpiDWWuMOyhgnTEUsXFjETvT3chDptdvN1l3l4o2VQbIIQgnPTm6g4+nq4
 /lS83psiMLsd99R6VjPu+7Z28vu3M37N5XFihztN7zEbfuHaCYDxlTqfR+ylTw2LJ7w=
X-Received: by 2002:a53:e8cc:0:b0:64e:e553:d788 with SMTP id
 956f58d0204a3-6504880fbeamr15709937d50.43.1775672171043; Wed, 08 Apr 2026
 11:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260408105605.172465-1-mjt@tls.msk.ru>
In-Reply-To: <20260408105605.172465-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Apr 2026 19:15:59 +0100
X-Gm-Features: AQROBzB3c7wft6KLxafDDsTZSV5Zlw23_RdknzdNROhvWBfy6MKaeN6ucRD7v-M
Message-ID: <CAFEAcA-JLmahDa329ycaVY_t7LsceLa2X6wDgXZG6Z8mbYH__Q@mail.gmail.com>
Subject: Re: [PULL 0/3] Trivial build-system patches for 2026-04-08
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 8 Apr 2026 at 11:56, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit b6a7d06213e5d2f7d124d16418bc289c4a8a4b82:
>
>   Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to 17fbf3e18c3dbc32ec07cfc24853d6654a813e90:
>
>   util: fix missing aio_wait sym in qemu guest agent only build (2026-04-08 13:48:50 +0300)
>
> ----------------------------------------------------------------
> trivial build-system patches for 2026-04-08
>
> bugfixes, and making possible to build some minimal stuff
> on 32bit platforms - pending more permanent solution in 11.1.
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

