Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35E8C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 16:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYTKg-0002Kn-DO; Fri, 09 Feb 2024 11:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYTKE-0001xD-1A
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:02:11 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYTKB-0006It-2I
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:02:01 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so1706932a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707494511; x=1708099311; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lezDAMlBpM8fielSqHbLTkkmpxf2SLdKNWZUmn314Vk=;
 b=ke9Dx7NgiXTBo07cr7LnJGVSB0B8CT9I3nmPeGN5MeJ4WCmlmQoCvF1ksEQbuobOb6
 VbGvvCDL00hRwsNrFrPk8r8lIdTBFQS+dv+5enGQluoYQKQz8KJaRrrdRn87vcRYnaRo
 uo52Btl5wGhqGuqCutTFHCqnYO3oakby+hKVpzo8oAo2jzr1gEQIFa9y2MRdHROJRYSt
 kf0sy3hrCt5ciaHMcg/BxtQCT1YnL5NBmjORNfOeh1P4T3Kr6ZmMVzKgXPm6BvpHoyJZ
 7Wl4Y11Uwf7cbYeczD/nLEzt8FNGI/s52cytvMQJZAWf2J5JwqS5W/y9tpvWTw9fXtNB
 SG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707494511; x=1708099311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lezDAMlBpM8fielSqHbLTkkmpxf2SLdKNWZUmn314Vk=;
 b=Ko+ArpxJN9FQxg9yg/QIM/zp/QAKJK3MJQpq0rib2elY0KiFBD9Y9EWbbaOm8o7Fxm
 4fX0uQtA17fhAr1kDkAY7XwfIusk0TKtyjPInlqCShY3AOtb4beNnLWRYKFJ6p60V5/P
 bKQPG4JTWw2VcHjHpG1SUwnNug2AEbGscBzRWwVS3dF1hsgwPFYLXurk/lcQw/vozTo+
 GJnQocDLTfwSmE1uvqKNqWbug7xHKdv2sNv1yjPCbM2aZ/DEDe1FstkYXjrelcwcutbB
 TZaBoxzzwiJ7MC79PFKmirG4j5/TccKYEfLj95g30is5DDLfkXwIhUGI9ivrWDPGsaWv
 wpfA==
X-Gm-Message-State: AOJu0YzkDpvyyYvA4S34jLtyK5J66J+D3QdG42ZuULHJa2/eHWr6AYoQ
 wx25TEb4wKsBtd3mFSY1DqyfxV+KRLPvyqnqIke3IouVn9pcRTkfI6bQMGzZFj3gUXDE8c4zqnl
 tJ1LYE86Wzd024X8oHxlJoJxJBCmNMMWtCGpMTg==
X-Google-Smtp-Source: AGHT+IHTWrTSv71O2Pyu15n1vuqvZUfNe7KUZFomMQjZglGedv9It5RW7g+FpkjhUgw6Kwg7Wh6wSNrfAHHxXCjYkTk=
X-Received: by 2002:aa7:d350:0:b0:55f:8bba:d0ae with SMTP id
 m16-20020aa7d350000000b0055f8bbad0aemr1893609edr.23.1707494511382; Fri, 09
 Feb 2024 08:01:51 -0800 (PST)
MIME-Version: 1.0
References: <20240209150039.22211-1-philmd@linaro.org>
 <20240209150039.22211-3-philmd@linaro.org>
In-Reply-To: <20240209150039.22211-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 16:01:40 +0000
Message-ID: <CAFEAcA8QYv-CckneF=o7j=vN1=UvFqE0EZPO4+u4daXgOAjBPg@mail.gmail.com>
Subject: Re: [PATCH 2/3] monitor/target: Include missing 'exec/memory.h' header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 9 Feb 2024 at 15:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Include "exec/memory.h" in order to avoid:
>
>   monitor/hmp-cmds-target.c:263:10: error: call to undeclared function 'm=
emory_region_is_ram';
>   ISO C99 and later do not support implicit function declarations [-Wimpl=
icit-function-declaration]
>       if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)=
) {
>            ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  monitor/hmp-cmds-target.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index d9fbcac08d..9338ae8440 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "disas/disas.h"
>  #include "exec/address-spaces.h"
> +#include "exec/memory.h"
>  #include "monitor/hmp-target.h"
>  #include "monitor/monitor-internal.h"
>  #include "qapi/error.h"
> --
> 2.41.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

