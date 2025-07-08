Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D95C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDY-0002lk-QF; Tue, 08 Jul 2025 16:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZDnP-0004UE-4B
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:16:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZDnI-0006wO-1z
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-235e1d710d8so62645625ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002094; x=1752606894; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8s3POq+g29lZCTW4KGaiw6YRZUM/zpjO6CKLcIScNM=;
 b=G9fxjIntewLc0dE+OAid5UBWD0Kbx2lmhYq3P+y/sbZI6fD7P8BdvSruNUlL1Pk/9Y
 mIVRxXVUB0OAlYxqgq7p/V96YwaKBUuBwRb0JquK9QrnQUNQxvpYpJ5ATb0VtLJTt47S
 IJIPZGrWA+jJPpxAE/iSuGReDEL9tm74PpEclXGVPy/DvSOQ1B8mzV7RiOhMznoo6XbB
 7T5TjgOL/Lz4xykfZE0PyKgMpmr+onoFoIoB+K2w7Pk/jI6gq/rBxyIKgVFcr02Ns7Ap
 PNdhPeom8hMIxDwqkzXT6JS93YroLqfG8nSIz0RUkqnwGzGn/z7qZ7WuITA5zrKS9Pxh
 P0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002094; x=1752606894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8s3POq+g29lZCTW4KGaiw6YRZUM/zpjO6CKLcIScNM=;
 b=WdEL0Vu6co2I7Z3E+U3S0vKkzFien76MTIv3pPCRyE90MkZrxL/NsNmDxoZY/aXWwN
 7Mg/ebiKYaWZAeKpRP+SubxQYzL99lZYEQst7PQUiF2bMRK3gYaDwP8hRuY5PTKMQ7gi
 mVq2Nx3VsTwJ1HYBqiQphK2jiuRYPbBksDVn1d01wkF6TCDZi1FxrPLE/46uHxaKo7YI
 kwudz5eKNl6UnBsR2/TAU9gvW2Nj0kv6wnVBuRCxADY+5qgSlRXXW754Ut0mztuIL2E1
 K4S35COfF5qXkWDZ4IUw4t7GO0fujla43GvJX42TmuwqpY6OSoWuXqrnwQACL2bjnYM0
 0gaQ==
X-Gm-Message-State: AOJu0YzwZibUC0qsQp51FI5DWpN3Lv9qQ4pNK908X7ZriGqF/62oun+1
 00yojyTRbaHltKuK6wgt+4YTD+5mpr2rQewwMVQ3W4En3Xc6F0DI3mH0tdn4fTrw13DgfWZyll8
 ODpEPYmxw54bA8Fjau8rGoO4p4jxcynC5RKZamXdvgyP98nfpUd+8psc=
X-Gm-Gg: ASbGncsMxVrE4nWcDNEECCGkIyIsnMoFBxP1iSun+wbdbWjqara56rbSaESCBVYmZF+
 dhZGUpaxMMu64ajglahOl7B9ydngFksWTmuUOQaHj3CSbQmKoRxYE/Ftt+bNQMo5htRI9lIJ7hj
 6UbKG1OBMSpKRW+1xYg6liotUMxV2ofb63SUUllSS6sMgP
X-Google-Smtp-Source: AGHT+IFWT3DipFQC9i7Dfs2o7UN9KnD3vr81lmbfCI/c+/IgB/Qv6x30sVjxmdwZn/oeNI3OAJdvi+FZTPDCCHLTOxk=
X-Received: by 2002:a05:690c:f02:b0:70e:18c0:dab6 with SMTP id
 00721157ae682-717ae0c61cfmr9914547b3.23.1751994909123; Tue, 08 Jul 2025
 10:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250707170904.2908-1-philmd@linaro.org>
In-Reply-To: <20250707170904.2908-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jul 2025 18:14:57 +0100
X-Gm-Features: Ac12FXyz7_6cIBnFIkoJgjm8GuCCJJOrs9_ndhhpP6rmJVSZoTNuFcbe_CAEhhk
Message-ID: <CAFEAcA9rcJHBaeAqCM1BszrhzkE4=gxJkx9h62BVhEz9hB7OMA@mail.gmail.com>
Subject: Re: [PATCH] bulk: Remove unnecessary 'qemu/typedefs.h' include
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-pl1-x62c.google.com
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

On Mon, 7 Jul 2025 at 18:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> "qemu/typedefs.h" is already included by "qemu/osdep.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/vfio/vfio-migration-internal.h | 1 -
>  include/system/os-win32.h         | 1 -
>  hw/intc/loongarch_extioi_kvm.c    | 1 -
>  3 files changed, 3 deletions(-)

> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index 3aa6cee4c23..662cfabc5e7 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -29,7 +29,6 @@
>  #include <winsock2.h>
>  #include <windows.h>
>  #include <ws2tcpip.h>
> -#include "qemu/typedefs.h"
>
>  #ifdef HAVE_AFUNIX_H
>  #include <afunix.h>

This one's tricky -- osdep.h includes system/os-win32.h
*before* it includes typedefs.h. If you want to remove this
include I think you need to move the include of typedefs.h
a bit further up in osdep.h (taking care that it's still
wrapped in an "extern C").

(Or we could declare the functions in os-win32.h which
use the Error type somewhere else. That header I think is
intended to be "Windows specifics and compatibility wrappers
that everywhere needs to have sorted out", not "this
function happens to only be needed on Windows": a lot
of the functions declared in it are only used in a
handful of files and don't need to be declared to every
source file in the project. But that's a bit more effort.)

The other two changes here are fine.

thanks
-- PMM

