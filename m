Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E1CD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viAmk-0008U0-A6; Tue, 20 Jan 2026 07:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viAma-0008NZ-VG
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viAmY-0000Bm-Q3
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768911866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9je19wIsyBuozw+rhD3RjIBV+rBhjXZKLgdw4oh4Y9I=;
 b=MGetjvEqvXyO3wHZn3/UmekLjYJEpgG5ECXbkkDv8UD/Pd1e2o6iE5MV7QlQARZxdkSnW8
 xCXkImAMPDdMxsn6ET1fP7jl/Xi8pik0AgbzolLr/ezSWKbexU6E6gI0C01Ne1d9EXZvGt
 KNSsfmlK5GhjDJwXiiJRUGkbIZaDz/U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-i3jf14KOMk62eK7BaV-7KQ-1; Tue, 20 Jan 2026 07:24:24 -0500
X-MC-Unique: i3jf14KOMk62eK7BaV-7KQ-1
X-Mimecast-MFC-AGG-ID: i3jf14KOMk62eK7BaV-7KQ_1768911863
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee1fe7b24so44973155e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 04:24:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768911863; cv=none;
 d=google.com; s=arc-20240605;
 b=H78fr1waAb37vdkBYepFld+6sldd56CR8OY+C/FnL3pqah2y4mP4IYE1DP5UjZ4lxf
 4dkIVipCDnEzLaW9PmExgVOZBfLgYWGAohLbwNzTNvQTA4IXADAgb9D56jxstaSxJSJo
 ANwF3QfXW6DiPGZJXoKE5Z/pXJQcQctAKamA2JLDkhZy/01fQeoThaYaDBXUOF8ZLjNT
 0H6pjonOJ5aoo0ttlzWfJGdkhSCUboQTOMCgTWtCtMd+A5wcIjdRUtePPbCHRlIPiJP/
 wngvPnF1AsPREPHNWJ3DLbixfdGxbxpgY/HEqQE7MDWWs85H8zPGCXazbuQU9UglDvrl
 GVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9je19wIsyBuozw+rhD3RjIBV+rBhjXZKLgdw4oh4Y9I=;
 fh=XLoX46h2kkxb1f+IgDT9Efhly0i1dVw/CL08qUopCI8=;
 b=JcYV7qWnoFs823JP0UoZDHwVQ6u3zIq8bfxWgQOt8faOAJC4MzKI5K/30OECXGrhWF
 FmuhFzUEOBm6UR6LLjQlJ89G7UrZRyHQ9dbm6BL939n+q0RxF6C+kELfvkJcwX8tPpp+
 HMTivpOsbSdPKT+e5hkuosmXqrgT+dLi9N3DfPFtldcghSYawxwr62617CDYvECKeEwN
 csDXMVgsilqFTXzRv5/MFLC4QDSTYzJZCASpbgHTNSvM5NqC1GN5JGPZtCJb2D6QHtFD
 MU+SfruisgKwGwLouGPoFOzjBoFMjPlQVqYMfSQekTIvskdAM8zeFuIfhHXUNBLIceZ5
 30yw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768911863; x=1769516663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9je19wIsyBuozw+rhD3RjIBV+rBhjXZKLgdw4oh4Y9I=;
 b=bXTxjpbxEbv6+r91Rju2YZFdymHNqR7jzuNWgnHCq5p3C1VvVUG9o2W7uWTlKDJ5Cm
 NLr1iHT4wkHGS2ZoRdDHYoMyuQi9NMrGlV0m/HzzfubfKnrexcSbbX2EBesvCl131PiL
 vguCpEnn/IhSU4Spy/dHtz5BQ7rowcu+nSm6YQXg2m2yDN/Y8v8VrQ3/71Vki6Ua3zNP
 T8y16baRCCQgNhpm0ClFBrBe305zEh6yONwkRvvZW8S16aoiudndjGOxtYZvR0tHKkiO
 5z803y5VQxOhEUSSzBbAma2PSwtwRPV91eoUP8gNpVtymJNIMEbpYqXc8IZtW/YUzDoS
 8wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768911863; x=1769516663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9je19wIsyBuozw+rhD3RjIBV+rBhjXZKLgdw4oh4Y9I=;
 b=qVmwIJVbLdhEfinv4T5EDyib58+f7FX73+ShRNV7uD8sKdXu+cXbJgRH8BS+bWkvN3
 rr4AYAuUTCmJ4PHTGNOTW8Jd9E15KO9jTXa6o3tMnB2GFJ+bXdO6xb87x8r1U+/75FPp
 OmKLSwyINbW88f/BX3bErOJV1ZL0wTsjRiox5Xux5jOpHKj4xEMpUQK++NlPaKQvH0Y/
 sHwZs0YCs9iB7xvptNg8YfmmUnUn5Ek9DyMd9AunrjqF+RODuU1zEtep6MguMc1po7BK
 hbSFHKyQR9Mbjlv4Q1SjJMnp7/LAj6A9egf8THDgtGinh7tTh/Hl0Aj/6PC+kqsSU+fm
 kIIA==
X-Gm-Message-State: AOJu0YyXm1cOwKr4P2nma7aalD0SY7sUcE9YpGZmXDLKFu58s5tfKIap
 Aq8jgBbq+RU8pIG0LaqZGRpYhrTUjdLuxTgsBStkbUgGAcRyxRoY32kgboydZLFlPY1E92nAyGy
 Zvc6AXPsS66r0/JSUtM1HzGaz2KIOPeUx0l81/kr9E904gk265nyHoWTKUZ8igoTrrytle9eO8r
 h3PwUGy/QUyKkXkv4NtjWsGlQF3y0KFsI=
X-Gm-Gg: AY/fxX791GTPFNuHBihQqriojkuHMc/ixqKpLGkm0XG5v6gYkMr9Dxf1oZ82zCH7/iK
 LtEMvExHi25tsKmoeuIdRXh6F9J+Nf2EoDiuDqSaWzUFrgZtQp2S91FBDeuSDj0w7olYf4ryqMd
 CGcJQtr7wTtbMoI3Tpj0bS0/ZTRGeNOvNJeze+kEYeLXCt4Kjuyp1cG17brevpUx/PWuo6QjaxN
 mRKDu3jGbi027JUh4mkVOzN5E9jDEF4QATv9fEtsmFU4O+x/eB8qlY6
X-Received: by 2002:a05:600c:8b8c:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-4801e2efd61mr183569225e9.4.1768911863203; 
 Tue, 20 Jan 2026 04:24:23 -0800 (PST)
X-Received: by 2002:a05:600c:8b8c:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-4801e2efd61mr183568745e9.4.1768911862760; Tue, 20 Jan 2026
 04:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-23-mohamed@unpredictable.fr>
In-Reply-To: <20260116135235.38092-23-mohamed@unpredictable.fr>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 17:54:06 +0530
X-Gm-Features: AZwV_Qhtw5CsOxCan4HN2G6Un9pq1T_I_qORSudBsDoj2a_cQ18XT6wEQH-jwtg
Message-ID: <CAE8KmOwJ-Gs+4gNaMmyxOXBZzU-exTCVS-vdLFBsX8f=H=K-VA@mail.gmail.com>
Subject: Re: [PATCH v16 22/26] whpx: arm64: gicv3: add migration blocker
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 16 Jan 2026 at 19:31, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> GICv3 state save-restore is currently not implemented yet.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/intc/arm_gicv3_whpx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
> index 9bc036d1ac..84ef16d9b7 100644
> --- a/hw/intc/arm_gicv3_whpx.c
> +++ b/hw/intc/arm_gicv3_whpx.c
> @@ -17,6 +17,7 @@
>  #include "system/whpx-internal.h"
>  #include "gicv3_internal.h"
>  #include "vgic_common.h"
> +#include "migration/blocker.h"
>  #include "qom/object.h"
>  #include "target/arm/cpregs.h"
>
> @@ -204,6 +205,15 @@ static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
>          error_setg(errp, "Nested virtualisation not currently supported by WHPX.");
>          return;
>      }
> +
> +    Error *whpx_migration_blocker = NULL;
> +
> +    error_setg(&whpx_migration_blocker,
> +        "Live migration disabled because GIC state save/restore not supported on WHPX");
> +    if (migrate_add_blocker(&whpx_migration_blocker, errp)) {
> +        error_free(whpx_migration_blocker);

* This error_free() might cause an issue, IIUC
     migrate_add_blocker(&wphx_migration_blocker
      -> migrate_add_blocker_modes(reasonp,
       -> is_only_migratable(reasonp, ...) /  is_busy(reasonp, ...)
            ...
            error_propagate_prepend(errp, *reasonp, ...)
            *reasonp = NULL;
            return true;

* ie. when error_propagate_prepend() happens, errp starts pointing to
*reasonp, so *reasonp is set to NULL above. Instead of error_free() ->
say -> error_report_err(errp) above;

Thank you.
---
  - Prasad


