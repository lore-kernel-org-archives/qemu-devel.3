Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE5EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0RK-00017u-Ld; Tue, 07 Jul 2026 03:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wh0RJ-00017l-SW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wh0RH-0007aX-JN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783410113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6VTV6fFbVSyjDCvjLQiUKjqMZbjP1Skv3jmNCvXKNbY=;
 b=jAiMbKOIJQv6vFlTEQP1I+ny5r7rGZpQ7jAr8N31dijL+jwXr80bUXvt0cctLCpkNXCFzv
 ghOEKkRjGlzKA/1cgCaKCjdUVziPyXltTdPlNpSJFkvo4dfkXCfNe7tolB6VXsxwiFIKR2
 Zj/rBsrHHlOQlc4yYjTk+UVLuq7Ho7Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-2oDEejjqPDOYV3KLtcFG3A-1; Tue, 07 Jul 2026 03:41:52 -0400
X-MC-Unique: 2oDEejjqPDOYV3KLtcFG3A-1
X-Mimecast-MFC-AGG-ID: 2oDEejjqPDOYV3KLtcFG3A_1783410111
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cca5e0a0c9so38615305ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 00:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783410111; cv=none;
 d=google.com; s=arc-20260327;
 b=ajAGalgEDxaKqgtUrJGqrqQQa0JY03f3pyCM4phR+WOIZG7LfCXkhtaV95f06AJRdg
 1A7XbQjKju1p461fACNSeVXPrzyXRLDb2dnTwhJeoGqu23okVsYcg7yf9kYzGl3tnloH
 xzuEy/ohWXQcf/haJSmE6lJXrmrgzr+2Yh0/z5yMqdZT9IZMWebgSKFWD7bSuItSi0it
 XufzQKOBhdpOdONWbZ1rpYNZNKCWBViP7ceYKqoSGJvHvedgIcPeG5F85XrX8B3LoZtN
 Q4ojPMKKPbHq8MPxAGN/sAyInq9DJOEBC3qx5FF0m4P1XvQE7dWSVKLZLSbjNhj9Lvhm
 Iejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6VTV6fFbVSyjDCvjLQiUKjqMZbjP1Skv3jmNCvXKNbY=;
 fh=BJV1XQpcPYVfj07oxpXym4PJB4wpZuxfU0BJwGhLHVo=;
 b=L2FoDdUAI/2hBsCbYD3n736ZSlEkg9Dq2sgza4l4xmtkTfJd1yNJizp1YK0ALvDuTS
 LYV6Ls+jHEyY10GDCBTfXdy83XWQxyqNhdmxBHC/uGXY1qXTb+Gea+Kaz+wrX4hfNWmc
 RD2bsy7+DxpkoXVVVKVGXkDzooOLycLj+8HzUgUYWYyX6wjx2nVoE5+SqfR60rLde2PW
 nDtUvelTA1d1Gv3xlIlEGF4LpVkyJHKFCd9IotPkj/GVNx1HKlEIa9bVAOIJSPDhmtKP
 cq7gsDPuweaCgh6AfTg4HUBBJi5ohxl7Gp4lgP+Wmq3qdxGANGZUEpNAAzkLHL74lysS
 +VEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783410111; x=1784014911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6VTV6fFbVSyjDCvjLQiUKjqMZbjP1Skv3jmNCvXKNbY=;
 b=UI1+zja9rPtDTPlVqzRgsqKZrXzpkfhmMWZ781cx+YEnFy6zpVCPJRlej/IJ85I1/p
 zjcYtkYuYvJfSsJZAuOgyzZiKoRXdHcVEPjfapQVmZaRIG9nMW8uTdgA/K1ZM2AqhAZN
 x0OpZ4M8FvwO25mXs7E+KhquDPKJFRFnx5cZSGG4/4hOYye1zKhQ7jSvoaweJY8VkaXY
 qqD9nyQMxlPd4UWvvBx0E8HNoriLCkFGZlox5urO52GpR0t/ku2xAYk3rtfupfFjr4gY
 CGrSGTd0kLkd64Ml3FPej6g2N6RPQn4g0WDl2YYoIUrjn0ydwfvsknL9rmbPIRBWx7nK
 8PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783410111; x=1784014911;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6VTV6fFbVSyjDCvjLQiUKjqMZbjP1Skv3jmNCvXKNbY=;
 b=HUDzzPbFYQet5+emIOw/HJGYS++tGoP1RtWvuXet2lwKs03Z7iyUkmDbKGPbf/f00b
 kIA3M02D1BJcEJ10zIYGi/gZ9X4O4//y4Po1LuRpksicf5igoRiaogAyHynxul8WVh+E
 gzcMKqFQv6JrWIT3zbO+6/sNyzGZsBei1A3L9yb/LBMR+DHc3gJjwTBKiR+zcql/4dXE
 n+31iroUhgH7lbFGXJgzSIcoDhkmNa+5ygFIi8vGm7Y4aTM3J5044HTJ3pipDmDf2i9i
 hGjyNLGTC9xZr9vPBsEGinYdsE1Cg80hBv2ZHFGFTuRjsXp4DRa3IP/uggFiXzhnHLU5
 KBKg==
X-Gm-Message-State: AOJu0YzwtgqfpgHlZGfm9yus456U5HnolRinDUZPG5Ekd6RVlMtn6ikN
 gUzSn3ZHLPAuiI3MN/DHYTIZUbYoOr0qgt/bD/wyTz044iMPs4LxVh8cm3Y5GYLpSRQoBQUVHvF
 NbMaX2xLmbyB8D28ZnJsw1+TkoTUQkgUCIM6e411fSkn+oDeJUDSLEbzZqLK2rHjafHY1/nvLQ7
 cbpmafLCb+IWTgHYMyJF0nqYHij6QmDKU=
X-Gm-Gg: AfdE7cm3kai3O2NNxphadtK6YkROqvrpOsWvCWLWYYjgHwc72nZz6+3Hj65fgS30Rjr
 hOyuNpSonE1i8DD1Rrv4GLiS0DYdoHgI9NTcWqhjZMo3mkPNfOm3YhjvTZzYyLW8/V1Iqjdz8vH
 M/decn3Ur77yYAlI4rgxfq/OkNarQuxTIf8q4ImSIx+bUC41+q4yUljl4yz+kT9qPJoAwtgIQ+b
 Oi+5UAEwAZbVtai0sqhf5HakjA9VHe6u7VeGQxI05Toyg4k2kvVnW3zUpS/mGJzBaVwojHjJ91m
 iVKjP9PJTv6p
X-Received: by 2002:a17:903:37c3:b0:2cc:9473:97c8 with SMTP id
 d9443c01a7336-2ccbe722810mr44862665ad.15.1783410111312; 
 Tue, 07 Jul 2026 00:41:51 -0700 (PDT)
X-Received: by 2002:a17:903:37c3:b0:2cc:9473:97c8 with SMTP id
 d9443c01a7336-2ccbe722810mr44862435ad.15.1783410110812; Tue, 07 Jul 2026
 00:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260706135824.2623960-1-berrange@redhat.com>
 <20260706135824.2623960-7-berrange@redhat.com>
In-Reply-To: <20260706135824.2623960-7-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Jul 2026 11:41:39 +0400
X-Gm-Features: AVVi8CcM5F4_lvyq5afqVWb87DF160gDRRceUjzfcpiawJ9Ejb0oHcZL2RhS5sE
Message-ID: <CAMxuvayEWU6Nb7AS5cVXm6S=WGGAf40m2V2Ojhutr4+QMcWmdg@mail.gmail.com>
Subject: Re: [PATCH v7 06/35] monitor: pass chardev ID into monitor
 constructor instead of object
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Brauner <brauner@kernel.org>,
 devel@lists.libvirt.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 6, 2026 at 5:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> Current the monitor_new_hmp/monitor_new_qmp constructors accept
> a Chardev object pointer. To facilitate the next commit which will
> introduce a QOM property for the character device ID, switch to
> accepting an chardev ID in the constructor.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char.c            |  3 ++-
>  gdbstub/system.c          |  2 +-
>  include/monitor/monitor.h |  4 ++--
>  monitor/hmp.c             | 22 ++++++++++++++++------
>  monitor/monitor.c         | 11 ++---------
>  monitor/qmp.c             | 21 +++++++++++++++------
>  stubs/monitor-internal.c  |  2 +-
>  7 files changed, 39 insertions(+), 26 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index c71ffa7963..22e5bae388 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -804,8 +804,9 @@ static Chardev *qemu_chr_new_from_name(const char *la=
bel, const char *filename,
>      }
>
>      if (qemu_opt_get_bool(opts, "mux", 0)) {
> +        const char *chardev_id =3D qemu_opts_id(opts);
>          assert(permit_mux_mon);
> -        monitor_new_hmp(NULL, chr, true, &err);
> +        monitor_new_hmp(NULL, chardev_id, true, &err);
>          if (err) {
>              error_report_err(err);
>              object_unparent(OBJECT(chr));
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index fda8ef9352..fd754e5664 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -389,7 +389,7 @@ bool gdbserver_start(const char *device, Error **errp=
)
>          /* Initialize a monitor terminal for gdb */
>          mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
>                                     NULL, NULL, &error_abort);
> -        monitor_new_hmp(NULL, mon_chr, false, &error_abort);
> +        monitor_new_hmp(NULL, mon_chr->label, false, &error_abort);
>      } else {
>          qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
>          mon_chr =3D gdbserver_system_state.mon_chr;
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 83723f705a..bfbeedec9b 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -29,9 +29,9 @@ bool monitor_cur_is_qmp(void);
>  void monitor_init_globals(void);
>  void monitor_init_globals_core(void);
>  char *monitor_compat_id(void);
> -void monitor_new_qmp(const char *id, Chardev *chr,
> +void monitor_new_qmp(const char *id, const char *chardev_id,
>                       bool pretty, Error **errp);
> -void monitor_new_hmp(const char *id, Chardev *chr,
> +void monitor_new_hmp(const char *id, const char *chardev_id,
>                       bool use_readline, Error **errp);
>  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
>  int monitor_new_opts(QemuOpts *opts, Error **errp);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index da11e56854..1704166326 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -39,6 +39,7 @@
>  #include "qemu/base-arch-defs.h"
>  #include "qemu/target-info.h"
>  #include "qemu/units.h"
> +#include "qapi/error.h"
>  #include "exec/gdbstub.h"
>  #include "system/block-backend.h"
>  #include "trace.h"
> @@ -1538,16 +1539,25 @@ static void monitor_readline_flush(void *opaque)
>      monitor_flush(&mon->parent_obj);
>  }
>
> -void monitor_new_hmp(const char *id, Chardev *chr,
> +void monitor_new_hmp(const char *id, const char *chardev_id,
>                       bool use_readline, Error **errp)
>  {
>      MonitorHMP *mon;
>      g_autofree char *autoid =3D id ? NULL : monitor_compat_id();
> -    Object *obj =3D object_new_with_props(TYPE_MONITOR_HMP,
> -                                        object_get_objects_root(),
> -                                        id ? id : autoid,
> -                                        errp,
> -                                        NULL);
> +    Chardev *chr;
> +    Object *obj;
> +
> +    chr =3D qemu_chr_find(chardev_id);
> +    if (chr =3D=3D NULL) {
> +        error_setg(errp, "chardev \"%s\" not found", chardev_id);
> +        return;
> +    }
> +
> +    obj =3D object_new_with_props(TYPE_MONITOR_HMP,
> +                                object_get_objects_root(),
> +                                id ? id : autoid,
> +                                errp,
> +                                NULL);
>      if (!obj) {
>          return;
>      }
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 18a1d8ddde..cb0299a2f7 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -741,13 +741,6 @@ char *monitor_compat_id(void)
>  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
>  {
>      ERRP_GUARD();
> -    Chardev *chr;
> -
> -    chr =3D qemu_chr_find(opts->chardev);
> -    if (chr =3D=3D NULL) {
> -        error_setg(errp, "chardev \"%s\" not found", opts->chardev);
> -        return -1;
> -    }
>
>      if (!opts->has_mode) {
>          opts->mode =3D allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_=
CONTROL;
> @@ -755,7 +748,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp,=
 Error **errp)
>
>      switch (opts->mode) {
>      case MONITOR_MODE_CONTROL:
> -        monitor_new_qmp(opts->id, chr, opts->pretty, errp);
> +        monitor_new_qmp(opts->id, opts->chardev, opts->pretty, errp);
>          break;
>      case MONITOR_MODE_READLINE:
>          if (!allow_hmp) {
> @@ -766,7 +759,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp,=
 Error **errp)
>              error_setg(errp, "'pretty' is not compatible with HMP monito=
rs");
>              return -1;
>          }
> -        monitor_new_hmp(opts->id, chr, true, errp);
> +        monitor_new_hmp(opts->id, opts->chardev, true, errp);
>          break;
>      default:
>          g_assert_not_reached();
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 1ef09352fc..e2f841212b 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -527,16 +527,25 @@ static void monitor_qmp_setup_handlers_bh(void *opa=
que)
>      monitor_list_append(&mon->parent_obj);
>  }
>
> -void monitor_new_qmp(const char *id, Chardev *chr,
> +void monitor_new_qmp(const char *id, const char *chardev_id,
>                       bool pretty, Error **errp)
>  {
>      MonitorQMP *mon;
>      g_autofree char *autoid =3D id ? NULL : monitor_compat_id();
> -    Object *obj =3D object_new_with_props(TYPE_MONITOR_QMP,
> -                                        object_get_objects_root(),
> -                                        id ? id : autoid,
> -                                        errp,
> -                                        NULL);
> +    Chardev *chr;
> +    Object *obj;
> +
> +    chr =3D qemu_chr_find(chardev_id);
> +    if (chr =3D=3D NULL) {
> +        error_setg(errp, "chardev \"%s\" not found", chardev_id);
> +        return;
> +    }
> +
> +    obj =3D object_new_with_props(TYPE_MONITOR_QMP,
> +                                object_get_objects_root(),
> +                                id ? id : autoid,
> +                                errp,
> +                                NULL);
>      if (!obj) {
>          return;
>      }
> diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
> index 20367b7e9a..f94b5e5c21 100644
> --- a/stubs/monitor-internal.c
> +++ b/stubs/monitor-internal.c
> @@ -8,7 +8,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Error =
**errp)
>      return -1;
>  }
>
> -void monitor_new_hmp(const char *id, Chardev *chr,
> +void monitor_new_hmp(const char *id, const char *chardev_id,
>                       bool use_readline, Error **errp)
>  {
>  }
> --
> 2.55.0
>


