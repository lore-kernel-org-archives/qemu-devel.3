Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E971C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razbu-0003st-Sh; Fri, 16 Feb 2024 09:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1razbr-0003sa-2e
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:54:39 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1razbp-0006vf-8j
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:54:38 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so2901905a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708095275; x=1708700075; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7xXTa/W2p2MaLklKaZVjyubH9ibXSXdaZOGnUiZ4xe4=;
 b=icqg9Qvn4Ize9HE/7x1XhqUEpXTkIy9445NGnsna8P1eT4CEoCNx6mukslQb0NW99a
 onaxQtkLiZu5Z05MzSQUMYMGiC6iCp9O7KCo/t+SBDBcjlky8LGPF5awZl36CEdsFEkY
 Nm5SOzUE4FhSXroBYP/rpFAFoFhmUb2LHQYwjvw/jdVnAgjQJml+t9KLjA6NcxCe3WC3
 iQizYgelBjM1x8EQDpdTjK2BopIMWygEKzg8Emu5rlgFdftKpOSJAG/fQ8eZ3cdnyqij
 U1hjiiCL+RCk8XUScO8YpujewE/8dTtBKcZLYDDSrHaKnbJ9uNtlVrEojBMkVL2fCRHK
 v4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708095275; x=1708700075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7xXTa/W2p2MaLklKaZVjyubH9ibXSXdaZOGnUiZ4xe4=;
 b=dD6D8LcmHoJsB8yPG60riA/TV62wskBREhBGSH8Qf6jg+pmiS429nTrYtHrbEjcWg8
 MZOEYDZA/TPB2StdVTYgP6bi9nLm/L2KUejZ8MNOhTDv5k5N3iAxfQI7pIoKztt0+vNo
 /acnyLNGJBrb38xW93Ct5fgCZAHrjJrTi/qAFlFaUoi8NnUkQD1AgeTlUIc6/ntMzpMN
 cIPjrXcddUFmao+Q0EKg5gr6nu4QKIQ2wGb4jxanyP2mDh/Z3gens/CcBPHszvPvbyJH
 VxWlt4Zmq+Uav0YehKqI2ZIpcS1NbA8slCB9cRYfqFSYpP6Wz7fRyY/YSpHz8ZPmlWc6
 nOkw==
X-Gm-Message-State: AOJu0Yz4V+Ii2oAIdkBTUy2Zp23R8p9WajwuHfLGXzDZOfVUmv1OO4S4
 Jw4GPIkDLpJkx0ZSELvc1HLl/WBrTWZ/YQ4+c4L4HOEfEqj2OXHnKZdvSQGBIl+LF7sBlOQlDId
 bJi5QSQKluFAKZwYWnJDYuZMm+MaG8po8PVEARw==
X-Google-Smtp-Source: AGHT+IGVs28RWefRMDTe/h0gfbuD/W7N7NeNDkWZ4w3CYR2GFwutbJyWk9MaxjHBESYPus8uDql9TmTd1xw2si/Wnwg=
X-Received: by 2002:aa7:cd46:0:b0:562:1441:81f0 with SMTP id
 v6-20020aa7cd46000000b00562144181f0mr3633178edw.7.1708095275087; Fri, 16 Feb
 2024 06:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20240216135137.8668-3-atp.exp@gmail.com>
 <20240216135137.8668-6-atp.exp@gmail.com>
In-Reply-To: <20240216135137.8668-6-atp.exp@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2024 14:54:24 +0000
Message-ID: <CAFEAcA8dC6siNn684zqgiEZhKkxnw3DRu_AzPPZ16QRUg2410Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] misc: ppc/spapr: replace qemu_system_reset_request()
 calls with watchdog_perform_action()
To: Abhiram Tilak <atp.exp@gmail.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, david@gibson.dropbear.id.au, 
 harshpb@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 16 Feb 2024 at 13:56, Abhiram Tilak <atp.exp@gmail.com> wrote:
>
> A few watchdog devices use qemu_system_reset_request(). This is not ideal since
> behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
> As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
> to reset when a watchdog timer expires, let watchdog_perform_action() decide
> what to do.
>
> I am unsure about the changes in `spapr_watchdog.c` in patch 3, it would be great
> if any of the maintainers review it.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
> Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
> ---
>  hw/watchdog/spapr_watchdog.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
> index 2bb1d3c532..9751b19506 100644
> --- a/hw/watchdog/spapr_watchdog.c
> +++ b/hw/watchdog/spapr_watchdog.c
> @@ -18,6 +18,7 @@
>  #include "target/ppc/cpu.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> +#include "sysemu/watchdog.h"
>
>  #include "hw/ppc/spapr.h"
>
> @@ -114,7 +115,7 @@ static void watchdog_expired(void *pw)
>          qemu_system_vmstop_request(RUN_STATE_SHUTDOWN);
>          break;
>      case PSERIES_WDTF_ACTION_HARD_RESTART:
> -        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        watchdog_perform_action();
>          break;
>      case PSERIES_WDTF_ACTION_DUMP_RESTART:
>          CPU_FOREACH(cs) {

This one is more complicated, because the spapr watchdog
has multiple possible behaviours which the guest can ask for.

We had a discussion on the mailing list about this a little while back:
https://lore.kernel.org/qemu-devel/CAFEAcA_KjSgt-oC=d2m6WAdqoRsUcs1W_ji7Ng2fgVjxAWLZEw@mail.gmail.com/

The conclusion was that the watchdog-behaviour QAPI API
needs to be enhanced to be able to handle this kind of
"the guest picks an action" watchdog, so that the user can
either override the guest's choice, or request that the
behaviour be what the guest wants it to be.

thanks
-- PMM

