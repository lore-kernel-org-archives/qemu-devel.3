Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4131C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtkO5-000795-DN; Tue, 11 Aug 2026 07:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wtkO2-00078i-QZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 07:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wtkO0-0002Tg-7F
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 07:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786446671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lC/UHm6AIYmxUrQwEn7PnFT2Xqx7q7cgySb7hxJIac=;
 b=HnsYXQ2tDeitsQhYtJq3aeO/VkgeYZ2IABtSRxMElpGhdzH0+2tf7ogSVCNxXXAsOlXXYK
 /ZP6laNJMv73girBjXCW1w0t5yuMRUYloKDVa8KuNFrplIHKDkcYu6geJhaG4NTJ4oA5z0
 7M+3yGqA6HEAUT4ZXAgrkOUJjhPwNu0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-h1hmYXnTPTWbJsV8tPLK4w-1; Tue, 11 Aug 2026 07:11:10 -0400
X-MC-Unique: h1hmYXnTPTWbJsV8tPLK4w-1
X-Mimecast-MFC-AGG-ID: h1hmYXnTPTWbJsV8tPLK4w_1786446669
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbedc1899f7so132246a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 04:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786446669; cv=none;
 d=google.com; s=arc-20260327;
 b=mw1qJs1h7Lyfs2w4AyF9l9q4wVN82n0iiEFpBK0CEuP8fgpQ7X3L0xbQeEqbV3mWKc
 H54mInJUl15tBF3HT88rShsZqv8XQX1CjvHf+D0eHuDIk8XpBlWww4k9cdq7M92dPKy9
 4jkUWzs0S5eyJWltJ5dyYrPdmkok43GZi5RXje7U53PDJrg3Ek7j+7zcAsgegTe91pjr
 eDvz0dv6LroEO5yc3FKa0zKAir1VVlfo96aPg7dIOdXx8BZI+wHXI7V6bdjA/RI9hfOV
 p1oUuFY8eIdAx1PS67txn43sImSmfisIkfp2f5iOUwQCMetFAS2J10+yreOf72tQ8pfp
 3saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5lC/UHm6AIYmxUrQwEn7PnFT2Xqx7q7cgySb7hxJIac=;
 fh=cm37+rwiGUyfdWg+5XYmpoBPAEY1qvegLf2w8agcdbs=;
 b=MEDUrTrvX37a+UiSfKvvN8PyjuVOByIm9P0aUkulrURzk3r1f0+38VuNAC9KYsFyDD
 v2BDWcRvx+GYPHmpF1NYDLmeeyphKj9LEt/R96Zv3dtYtLqIMIvk9X/WQTF602T+At6z
 zBzJyrX5rC4wHI4ZTGlNV/kDTHEVZuVw3/lyfTS5Tqd3QwROFqohGNZX4OWDm2BmzwmR
 xaCJLNcBWQ/xZPqnKN3/ZSB1Mr7klIk+fWMfAufdNfdiusEFEeoLB6nxjownN8QJtX2Z
 OK7paO0OVu70Wlv07spypmvm3FcxIF9oUjr9T721t0MfvvDlUtJ3U1GPPKEWag9YgS6S
 Lmug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786446669; x=1787051469; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5lC/UHm6AIYmxUrQwEn7PnFT2Xqx7q7cgySb7hxJIac=;
 b=S/KFJvpiJplie8cDik5/D4j2D8lCrOtWWUSFhdh+9L00UbFoIhCdH73DGUb4fOGp1e
 vO+Hnv6DYXo02b+YWM6Q60irtRYL4J+NW3AGlhkPpo++NNYn/YOS6V0fffX/dwz8Z1Zw
 uWo5aeUNm8oEGhNSTEmdCOOVnCrbnUeTWQAmvYZ5fCyqj/ye41xdAwAc1xN8mb8VDBNX
 BxRtqVsmpz+ZOh1ZGOZLykhISrHurKo1mw2QJH9RI1k8HjFK5hRlm6d4dWgeUVBga1FD
 ENNDUfbKhdJ1n6U0U52mfp4IBR85GpIs5xAk4RdQE9bTfYn3tcfgSpGGEnAbWCJzxRIR
 IbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786446669; x=1787051469;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5lC/UHm6AIYmxUrQwEn7PnFT2Xqx7q7cgySb7hxJIac=;
 b=WpIrdHfRO63Ol1VGMmyh0ktM8p4DeeqcA1m0UgKvFghmbmp8gjtvUEi2YmkEqLJF9o
 hZTqp4o3iRDpJIY60W5K0MIZld7xbJRgmd1QyYh2eXC9/rCRnW0+RsC4rI5rasKNf9PC
 nOSrDkAJ1UHz3sEm5DfTFJQJjRt8ftejqq6Bjctql1TEVlVflAh8PDH8SNVH04Bd0dwO
 kfDp1DAFj/hSPwp3db1ivKZgwwEFpZAdlxRQjB9+3Lp2XFfKzF0j9bdNkPTEjgzcA0V8
 0md7okbCUaB3rLn0ufCfR2Z098f9/zrH5vhgEH3fNrEAZ0AYJ2DF0EBPvY/LgE3EvrXD
 4eig==
X-Gm-Message-State: AOJu0YyybOtm5FComRVNHBGLRl0DtEurD3pwCeWg05YKEK2s3GcXwoEt
 AxeoiyH8xvi1BMjh+kRira00Wz/2kuGSiKpe0nc8Fct0SxX9XL22s4lH5yJXMsb+WGobrXDhQXe
 agC/LqcR47erjptMau+CFHebGPSjIMGu9zGtF3pA7kl0XNACsXwm/xG35WbpFz5JwtwM7CxXuUO
 d8T6YE1YjNpS63Z+8bZkFNTiQCikdCl2k=
X-Gm-Gg: AR+sD10jR4AVhUdNNCpMmrwqbt5ouPWMt5WJEt7CSnymt8nWCWg17Dok1Ybk/tFexFe
 pwrAJtiZpqy6VB4f4tPNT5JNiHuU5F+3wPr2Uf6KelNWPCFBFfDUynXcvD1Zc54xs+Qmx5m8UHg
 PdOUB6UPS+cjQWNMtCDRGSSZ55bqH4CyTzhwcQYx+pt45BM29j+ErXrEq+JyaNxD/Y3kF9mXl38
 u0G+6oT6E+396y33LFdC+iBv/qq7CXFxy9kjdsU3oaaYGPQnQQOP4ZBoDN9hxlKp/iAUX3LB7NF
 GA==
X-Received: by 2002:a05:6a21:117:b0:3bb:2883:a723 with SMTP id
 adf61e73a8af0-3cc2bc77f3emr3679256637.35.1786446668634; 
 Tue, 11 Aug 2026 04:11:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:117:b0:3bb:2883:a723 with SMTP id
 adf61e73a8af0-3cc2bc77f3emr3679185637.35.1786446668009; Tue, 11 Aug 2026
 04:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
 <20260811105425.7429-5-philmd@oss.qualcomm.com>
In-Reply-To: <20260811105425.7429-5-philmd@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 11 Aug 2026 15:10:55 +0400
X-Gm-Features: AUfX_mxfKCYnCVBX4epPQKbmQurAgg44jZqaVGIKcFmlaBn632TgIHJvXx9CHK4
Message-ID: <CAMxuvay+TjVoNb0PgmnVj1TmTMHAj7+j7Xm+sTkN58XVUgZ6Hw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] hw/nmi: Remove @cpu_index argument from
 nmi_trigger()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, 
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Tue, Aug 11, 2026 at 2:55=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> nmi_monitor_handle() is not related to the monitor, rename
> it as nmi_trigger().
>
> Return a boolean value indicating success / failure as
> recommended by the Error API since commit e3fe3988d7
> ("error: Document Error API usage rules").
>
> The 'cpu_index' argument is not used, remove it.
>
> Document nmi_trigger() as suggested by Peter Maydell in
> https://lore.kernel.org/qemu-devel/CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9=
RYeo8fKqz7gcw@mail.gmail.com/.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  include/hw/core/nmi.h  | 25 ++++++++++++++++++++++++-
>  hw/core/nmi.c          |  9 ++++-----
>  hw/ipmi/ipmi.c         |  3 +--
>  hw/watchdog/watchdog.c |  2 +-
>  system/cpus.c          |  2 +-
>  5 files changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
> index 4c4ce79071d..e77c382452a 100644
> --- a/include/hw/core/nmi.h
> +++ b/include/hw/core/nmi.h
> @@ -46,6 +46,29 @@ struct NMIClass {
>      void (*nmi_monitor_handler)(NMIState *ns, Error **errp);
>  };
>
> -void nmi_monitor_handle(int cpu_index, Error **errp);
> +/**
> + * nmi_trigger: Trigger an NMI, in a machine-specific way
> + * @errp: pointer to error object
> + *
> + * This function triggers an NMI, in a machine-specific way. The
> + * intention is that this should typically trigger a guest kernel
> + * dump or reboot, and might happen as a result of user request
> + * from the monitor, watchdog timeouts, and similar events.
> + * (For example on the x86 PC it triggers an NMI on all CPUs,
> + * and on s390 it triggers the RESTART interrupt on the first CPU.)
> + *
> + * The NMI is triggered by looking for QOM objects which
> + * implement the TYPE_NMI interface, and calling their nmi_handler
> + * method. Usually it is the machine model class that implements
> + * this interface.
> + *
> + * Not all machines implement NMI handling; this function
> + * will return an error if used on a machine which does not
> + * implement NMIs.
> + *
> + * On success, return %true.
> + * On failure, store an error through @errp and return %false.
> + */
> +bool nmi_trigger(Error **errp);
>
>  #endif /* NMI_H */
> diff --git a/hw/core/nmi.c b/hw/core/nmi.c
> index ff6454437c1..662f2051123 100644
> --- a/hw/core/nmi.c
> +++ b/hw/core/nmi.c
> @@ -22,11 +22,8 @@
>  #include "qemu/osdep.h"
>  #include "hw/core/nmi.h"
>  #include "qapi/error.h"
> -#include "qemu/module.h"
> -#include "monitor/monitor.h"
>
>  struct do_nmi_s {
> -    int cpu_index;
>      Error *err;
>      bool handled;
>  };
> @@ -54,19 +51,21 @@ static int nmi_children(Object *o, struct do_nmi_s *n=
s)
>      return object_child_foreach_recursive(o, do_nmi, ns);
>  }
>
> -void nmi_monitor_handle(int cpu_index, Error **errp)
> +bool nmi_trigger(Error **errp)
>  {
>      struct do_nmi_s ns =3D {
> -        .cpu_index =3D cpu_index,
>          .err =3D NULL,
>          .handled =3D false
>      };
>
>      if (nmi_children(object_get_root(), &ns)) {
>          error_propagate(errp, ns.err);
> +        return false;
>      } else if (!ns.handled) {
>          error_setg(errp, "machine does not provide NMIs");
> +        return false;
>      }
> +    return true;
>  }
>
>  static const TypeInfo nmi_info =3D {
> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> index 74818ff3cea..444af726d75 100644
> --- a/hw/ipmi/ipmi.c
> +++ b/hw/ipmi/ipmi.c
> @@ -59,8 +59,7 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_op=
 op, int checkonly)
>          if (checkonly) {
>              return 0;
>          }
> -        /* We don't care what CPU we use. */
> -        nmi_monitor_handle(0, NULL);
> +        nmi_trigger(NULL);
>          return 0;
>
>      case IPMI_SHUTDOWN_VIA_ACPI_OVERTEMP:
> diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
> index 0842fe373ae..026768e9fb2 100644
> --- a/hw/watchdog/watchdog.c
> +++ b/hw/watchdog/watchdog.c
> @@ -81,7 +81,7 @@ void watchdog_perform_action(void)
>
>      case WATCHDOG_ACTION_INJECT_NMI:
>          qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI);
> -        nmi_monitor_handle(0, NULL);
> +        nmi_trigger(NULL);
>          break;
>
>      default:
> diff --git a/system/cpus.c b/system/cpus.c
> index 97e5a5edee2..5c0a192c01e 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -926,6 +926,6 @@ exit:
>
>  void qmp_inject_nmi(Error **errp)
>  {
> -    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
> +    nmi_trigger(errp);
>  }

This officially drops the current CPU for HMP command too. Just
acknowledge it in the commit message, and remove the "*cpu*"
documentation in hmp-commands.hx?

Also, can we use one word for "deliver", "trigger", "inject"? or is
there any distinction I am missing?


