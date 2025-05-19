Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56099C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzWE-0006jU-0y; Mon, 19 May 2025 08:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzWC-0006fl-4N
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:22:56 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzW6-0005Qt-Vm
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:22:55 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70dda931089so1547617b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747657369; x=1748262169; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOOEe52iEaVwERPALHVdiHQ4JvSCJqXQqWgK4nKIcOY=;
 b=ot57SM97Y5wgOTdGLBB7qzI+3edXM0QKkg+H4F12oX3iPRqSxFYphSU5I9jqy6Myn1
 dAQGFKy4qvFYhdPI8MqyPlLnDccVjCacqts76SHjDHND4Re04gOudJzLDCRWvRGrO4rK
 t2VcEOHjH5XdGAt4wvIsqJd3rAHbeU+8D0xiUq5lX7tQzNgxX06ee0292oKrP2TcwPgQ
 YmgQ9crgaDftM90ZNL/xePSQ1B1lSc55ipTplmVTbAX20hXzk1bMiI1PK70r+jpL57Q9
 UHipc8b3WvWAQJeZJxewIQmtOD0ihcAx3hNn/oyYNu0xjz5VE7aSJC4zkgvZ4rkVcOTY
 ZUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747657369; x=1748262169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOOEe52iEaVwERPALHVdiHQ4JvSCJqXQqWgK4nKIcOY=;
 b=JQUjGyDsN62BIxW4LlrjUwwG8qgjhsL/06/VRktjihGu2r9Co/rihTYFqw51TjdvKx
 8RvZzXFLKlYPw9JkkByiKfYop00Ix8nEaRApSPlFupIdXutdtZDrR5PwkntbqvdcI5wi
 8YxyydmlJoh+jcdhqV8rXNZSpdN0Nv/c58KdR1pIBGYvOFhl2dFmQfeCZGQQgeisxrFV
 rupDJMArwWgszMmRzpxoBC9qEf2p6i3NG0M5ENHK2RnczgQP1wdJGouNiK9IjRGZlbdT
 eU6DE+xBlnZaZv2SEIgdso1H6teXtI+E8JnPVdXJhDz0vXdtCMZcSnPWUXO+LozPOsMD
 QIJA==
X-Gm-Message-State: AOJu0YxcVCucUUcP1wLqlGDmZ03+mAwY4aZb0fBqfeE6p5II42PMsqrw
 GLziHm52ZMi9oMZRPqQOKWuKWYvRVJfGBMg6aQAwO6ob+KqqwHKbUs+B+8oVKTtU2CVQzaiNtun
 241jGzhEuI7FYxG0CsKArQobRJA0LNbj3t3amS5tUqA==
X-Gm-Gg: ASbGncuJz+xk7dDIUqpJAPRg7arorjkzzG5isEMG0p4Dd0pOnZFg3Xv0MwQ9/AyiCEk
 2LopkdRjutgbYN6j8QXVm8d5DghECxC8usYgqbfKPnBQCBKJ/UYt5+UbTvs88zpBPNfQTUxLJkn
 SIwEg5NJnSx38p+XB5b2SWVAoLQrsna4XYXadZ7E3O4e5G
X-Google-Smtp-Source: AGHT+IF0R2usrK71CiogERL2gA9moUlkQm0PibYiqpjwGcvP72fmVsoO/IA7dip3VPrlGpgtFrU4wj/ZRoR5KVDm9pU=
X-Received: by 2002:a05:690c:4b8f:b0:70c:8147:a80d with SMTP id
 00721157ae682-70ca7a53119mr190335677b3.19.1747657369339; Mon, 19 May 2025
 05:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-7-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-7-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 13:22:38 +0100
X-Gm-Features: AX0GCFvoHZrW2cLwi2_NoDis4l1bgERYu7ouuiC6IgiQAmUiCAiwdco-vzMFiGg
Message-ID: <CAFEAcA8uyDvsqW8sa5-juWX-7sN0JuRyqhBDT4dcYXYsDzZRqg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] scripts/checkpatch: expand pattern for matching
 makefiles
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 15 May 2025 at 15:00, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The current regex matches Makefile & Makefile.objs, but the latter is
> no longer used, and we're missing coverage of Makefile.include and
> Makefile.target. Expand the pattern to match any suffix.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

