Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39409C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 01:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wugQ5-00083W-Au; Thu, 13 Aug 2026 21:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wugPz-000813-0j
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 21:09:08 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wugPx-0001cy-3Q
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 21:09:06 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-39c953950dfso3935361fa.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786669741; cv=none;
 d=google.com; s=arc-20260327;
 b=bJQpt0mio/SEBDkPJopFjhwqzsRHBxiwmupoPU2S99Z3wF2jevOEnZuZNRLgn2d63O
 bCDjoCo7AXiT3yNFg5BHfSV2FY14HxlmiDxJ6RnO4CMT24OijbRnFZfdQVXGecyvw/wS
 L4l+lY9qZGesReTVxSx5uVKOXPb5Q5QYGTnaTKhiBol/SJZUjCtpvp1LWoI+xWeJBtVB
 fw4c/ijFruVjpkNQj4dzqBRUwEJA+fXcfZkeGyhNCJODmjr4ujdMtIony4FxH3uNsI3R
 VKuehLe0yuTgrLBeWhopNlSss02MJlGkgqIblSZFY69TXSFYZJDEzErvd/orQorTY03w
 ZaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h+r01o2zpiNjFq1GvIQlvTkWum+F5eUto/ae6Y7m77g=;
 fh=1CqkjN8Um0ylFfNHuTEBIg+39t7zmW9dKsKeQ2FICMw=;
 b=IEke8BAHKaplt4pUf9V07YjYBf8yJ5f0zEsiYXxsRkunVPP/AsvCXC9WVX01tbyhi+
 24+g7kXFbBZ9lp05cc8b4tY+5lc0klrp0lMt+ctTKf7JYkNZlUGPfk+fIToR9i2QzTTd
 GtlerZ6f+4g8efwP6KDiaMwB2qWEb9OEjPA6XI1Y45AD5K+Lh3GvmKuHYrzaZrss1Jlt
 gsmKFrdh48PQt1L1BmtZ9xD8IzehvPDfHVgZ79alSUECOrDC5P6E/hy9agF6xfYD3dZK
 a7bFwHaV9cDIcgIJSXoiJniIupVYEJruJpk7+pS52/21bpCV6Ht+zkNJ7+VoiKnIO8aM
 H42A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1786669741; x=1787274541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h+r01o2zpiNjFq1GvIQlvTkWum+F5eUto/ae6Y7m77g=;
 b=ml+0HCyhbGGK3zAeN3YTrTC6fZY42POKqeUhZun7YmPfqKNLCI71mQEZqCsJks8+tK
 NFuEE/pJqc+kGmQ5zGfg4g2pNAQO9tjxib6Xnboi/aGWlcfefR4jghmS+YM3TbBkUl7+
 iClhJYYgS4OVjwtQB7PIjDwBaqOuCWKWs7h6WSrqiCyK0NlnCEvVDeCn3qYyqaoifXgM
 NhHq20hO7z9xnMxd9kN8wTPgI802FIyhqN/L2qdfNUd/McyXqqD9BQQ4PjYl9mO6Ap5R
 5pPQJY7z4JsJa11WIpw0dEPZ+f9GSlZu5UwTBEMxcL7iEIU+5HDOCGRGj2Ra+K8D742X
 Tzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786669741; x=1787274541;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h+r01o2zpiNjFq1GvIQlvTkWum+F5eUto/ae6Y7m77g=;
 b=Xve1IJECmrmpkOVmASYcddcCnffN+vbIdsDfbe24NZseIchPRF/Zc48OHWsYfzZlbQ
 DX/+Su57hPAAnadJW0LevouansIPvXIVB3zPscfWSVsF2N5qkVuSENhd8KWrOMtNnU0e
 3T9doKtkqSPths0ODflH6UgTUaJCnhzqzJrCiA/wIO3Vx/YQ/A3FIoTlGgIDfOwVba0J
 2NxLDnyRcfW6On1/QhTK+8RewxtWJWuEtyWva4ReyqXVh5sfsbQd02sXY3Fc3LPs0bn0
 /2lXyFqzVAmu7AcvL1KgrHYuiWCVLD6XDFunLFrm15nhsehLXrsn4uqgltmx+61wJxHz
 wiCw==
X-Gm-Message-State: AOJu0YzO/jnpmHI0ZmnV61uBA6EhPdl16nejJsoqMPSCnUYRxjKTh1Dx
 3SxO8+d4v8k52kjbtBCalsuRVzGrULULnXTnAfklwh3eRvuLfLh/HVP81aWoRC1nRfcZRLrvDUl
 FksrQ7S1dHmz0DQALs6qPUQ4raAfxX+RoEgeFtEKjMA==
X-Gm-Gg: AR+sD10S0cbjqiwIoRY6SIzUv/Dv20tPO1tjn1BzIQjd0pRsZxLMeQtooMLCg6n5wG9
 iAoPws2ObZyScj2lsPfMPHkwROfgI1unIynPmUh8T37bBApFr2slUWWwXWxp/WwFEgKzue0ByZT
 qywVMtgaEqtf5TnpAWjxmITji3qNoSyt2hYCSsr7q1xs5cYS/wKyx4i8Z1Vtx1HAKGyU+uNTGRg
 KAjeMrYzUju/W/13sq6CsaP59PblfglnEs++efSZxbAK3lq3zDPz6WHXcpowJ/xptdFhe+QTcnn
 CE5keXLekQlQL1wtc1TuTQm6vugFHQmEyxbzy8jaFHja
X-Received: by 2002:a2e:bc15:0:b0:39f:119b:cb36 with SMTP id
 38308e7fff4ca-3a1324bceaamr1925071fa.20.1786669741436; Thu, 13 Aug 2026
 18:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-14-philmd@oss.qualcomm.com>
In-Reply-To: <20260812211708.92824-14-philmd@oss.qualcomm.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Fri, 14 Aug 2026 09:08:48 +0800
X-Gm-Features: AUfX_mzLIX6waKK6NYbjsfQw0NLHpeLJRLgDgWu2a0Yq5_LUdYeKWxOXH4MzZdU
Message-ID: <CAFWXh4yc+nFPTEe6m5uvgNq1kkkP7bie6N=VabjkTYnfzCYYfg@mail.gmail.com>
Subject: Re: [PATCH v3 13/23] system/dirtylimit: Extract HMP code to
 dirtylimit-hmp-cmds.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lj1-x22d.google.com
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

Reviewed-by: Hyman Huang <yong.huang@bitdeer.com>


On Thu, Aug 13, 2026 at 5:18=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS                  |  1 +
>  system/dirtylimit-hmp-cmds.c | 74 ++++++++++++++++++++++++++++++++++++
>  system/dirtylimit.c          | 60 -----------------------------
>  system/meson.build           |  1 +
>  4 files changed, 76 insertions(+), 60 deletions(-)
>  create mode 100644 system/dirtylimit-hmp-cmds.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4628793dde6..a33fbeebf61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3858,6 +3858,7 @@ Migration dirty limit and dirty page rate
>  M: Hyman Huang <infra.ai.cloud@bitdeer.com>
>  S: Maintained
>  F: system/dirtylimit.c
> +F: system/dirtylimit-hmp-cmds.c
>  F: include/system/dirtylimit.h
>  F: migration/dirtyrate.c
>  F: migration/dirtyrate.h
> diff --git a/system/dirtylimit-hmp-cmds.c b/system/dirtylimit-hmp-cmds.c
> new file mode 100644
> index 00000000000..4928d57cc8e
> --- /dev/null
> +++ b/system/dirtylimit-hmp-cmds.c
> @@ -0,0 +1,74 @@
> +/*
> + * HMP commands related to migration dirty page rate limit
> + *
> + * Copyright (c) 2022 CHINA TELECOM CO.,LTD.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-migration.h"
> +#include "qobject/qdict.h"
> +#include "monitor/hmp.h"
> +#include "monitor/monitor.h"
> +#include "system/dirtylimit.h"
> +
> +void hmp_cancel_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
> +{
> +    int64_t cpu_index =3D qdict_get_try_int(qdict, "cpu_index", -1);
> +    Error *err =3D NULL;
> +
> +    qmp_cancel_vcpu_dirty_limit(!!(cpu_index !=3D -1), cpu_index, &err);
> +    if (err) {
> +        hmp_handle_error(mon, err);
> +        return;
> +    }
> +
> +    monitor_printf(mon, "[Please use 'info vcpu_dirty_limit' to query "
> +                   "dirty limit for virtual CPU]\n");
> +}
> +
> +void hmp_set_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
> +{
> +    int64_t dirty_rate =3D qdict_get_int(qdict, "dirty_rate");
> +    int64_t cpu_index =3D qdict_get_try_int(qdict, "cpu_index", -1);
> +    Error *err =3D NULL;
> +
> +    if (dirty_rate < 0) {
> +        error_setg(&err, "invalid dirty page limit %" PRId64, dirty_rate=
);
> +        goto out;
> +    }
> +
> +    qmp_set_vcpu_dirty_limit(!!(cpu_index !=3D -1), cpu_index, dirty_rat=
e, &err);
> +
> +out:
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
> +{
> +    DirtyLimitInfoList *info;
> +    g_autoptr(DirtyLimitInfoList) head =3D NULL;
> +    Error *err =3D NULL;
> +
> +    if (!dirtylimit_in_service()) {
> +        monitor_printf(mon, "Dirty page limit not enabled!\n");
> +        return;
> +    }
> +
> +    head =3D qmp_query_vcpu_dirty_limit(&err);
> +    if (err) {
> +        hmp_handle_error(mon, err);
> +        return;
> +    }
> +
> +    for (info =3D head; info !=3D NULL; info =3D info->next) {
> +        monitor_printf(mon, "vcpu[%"PRIi64"], limit rate %"PRIi64 " (MB/=
s),"
> +                            " current rate %"PRIi64 " (MB/s)\n",
> +                            info->value->cpu_index,
> +                            info->value->limit_rate,
> +                            info->value->current_rate);
> +    }
> +}
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index 50fa67f3d6a..70bb7bac2d0 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -17,8 +17,6 @@
>  #include "qapi/error.h"
>  #include "system/dirtyrate.h"
>  #include "system/dirtylimit.h"
> -#include "monitor/hmp.h"
> -#include "monitor/monitor.h"
>  #include "system/memory.h"
>  #include "exec/target_page.h"
>  #include "hw/core/boards.h"
> @@ -491,21 +489,6 @@ void qmp_cancel_vcpu_dirty_limit(bool has_cpu_index,
>      dirtylimit_state_unlock();
>  }
>
> -void hmp_cancel_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
> -{
> -    int64_t cpu_index =3D qdict_get_try_int(qdict, "cpu_index", -1);
> -    Error *err =3D NULL;
> -
> -    qmp_cancel_vcpu_dirty_limit(!!(cpu_index !=3D -1), cpu_index, &err);
> -    if (err) {
> -        hmp_handle_error(mon, err);
> -        return;
> -    }
> -
> -    monitor_printf(mon, "[Please use 'info vcpu_dirty_limit' to query "
> -                   "dirty limit for virtual CPU]\n");
> -}
> -
>  void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
>                                int64_t cpu_index,
>                                uint64_t dirty_rate,
> @@ -548,23 +531,6 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
>      dirtylimit_state_unlock();
>  }
>
> -void hmp_set_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
> -{
> -    int64_t dirty_rate =3D qdict_get_int(qdict, "dirty_rate");
> -    int64_t cpu_index =3D qdict_get_try_int(qdict, "cpu_index", -1);
> -    Error *err =3D NULL;
> -
> -    if (dirty_rate < 0) {
> -        error_setg(&err, "invalid dirty page limit %" PRId64, dirty_rate=
);
> -        goto out;
> -    }
> -
> -    qmp_set_vcpu_dirty_limit(!!(cpu_index !=3D -1), cpu_index, dirty_rat=
e, &err);
> -
> -out:
> -    hmp_handle_error(mon, err);
> -}
> -
>  /* Return the max throttle time of each virtual CPU */
>  uint64_t dirtylimit_throttle_time_per_round(void)
>  {
> @@ -646,29 +612,3 @@ struct DirtyLimitInfoList *qmp_query_vcpu_dirty_limi=
t(Error **errp)
>  {
>      return dirtylimit_query_all();
>  }
> -
> -void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
> -{
> -    DirtyLimitInfoList *info;
> -    g_autoptr(DirtyLimitInfoList) head =3D NULL;
> -    Error *err =3D NULL;
> -
> -    if (!dirtylimit_in_service()) {
> -        monitor_printf(mon, "Dirty page limit not enabled!\n");
> -        return;
> -    }
> -
> -    head =3D qmp_query_vcpu_dirty_limit(&err);
> -    if (err) {
> -        hmp_handle_error(mon, err);
> -        return;
> -    }
> -
> -    for (info =3D head; info !=3D NULL; info =3D info->next) {
> -        monitor_printf(mon, "vcpu[%"PRIi64"], limit rate %"PRIi64 " (MB/=
s),"
> -                            " current rate %"PRIi64 " (MB/s)\n",
> -                            info->value->cpu_index,
> -                            info->value->limit_rate,
> -                            info->value->current_rate);
> -    }
> -}
> diff --git a/system/meson.build b/system/meson.build
> index cd3193d170b..377adce8035 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -9,6 +9,7 @@ system_ss.add(files(
>    'cpus.c',
>    'cpu-timers.c',
>    'dirtylimit.c',
> +  'dirtylimit-hmp-cmds.c',
>    'dma-helpers.c',
>    'exit-with-parent.c',
>    'globals.c',
> --
> 2.53.0
>

