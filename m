Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F30CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCa-0008UL-Qe; Mon, 05 Oct 2026 11:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkCQ-0008OU-2O
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:54 -0400
Received: from mail-yx2-x2b.google.com ([2607:f8b0:4864:41::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkCO-0005CA-Bc
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:53 -0400
Received: by mail-yx2-x2b.google.com with SMTP id
 00721157ae682-8af5397f0a0so6415797b3.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212511; cv=none;
 d=google.com; s=arc-20260327;
 b=R6RiZjPSdGH9MOFApr4lekuZtoSMjm8euGQmUoAfqB1txvpUb3Qgj4W/3T3qQAlydC
 EPFqYX3jGUltbmQe7zX1T+J31AiN6kO5QJedz9anh3eGZZHO+5/QfRVFoHP2B0tTU/k0
 Cke1pC8Gf2dbBqQG/A8buw/BjrtOf41x7W+OPYdVexfOpKXBOXVe/RQ+BhIAAXZqTG42
 1v+S/q0tI8wXqQfzwtJcZwQbxPlgGnbUPEf1X0HbzRq4MTY6CAsQ1GuKPvg+A9/Q0be0
 38sj/rx6tz2n0URjdpQjZudyZc07Vb43aUsaFlL504F2BdgpdsXRA+J50YBlVsTK2lIh
 dS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sJL1wUq1/9xigC+eDOJFyGhcqLk4A52EajwWjb33Br0=;
 fh=EjplmlcXR8MWJXDdpR5ncThIs/e4S293bvxZuvqDLMM=;
 b=QEUQKRZlH2pFqADFXRl0XaDLRCJFwNTHBL5fW5Rq+i37OJBsrwFFEXyk2sJ+aaEzIa
 aWLRxq4zjw3n1m0o3YN8G1Rober7PTWCZnUyyvP6bIQbx6/7p0RjyJy/zsWI1rbNu62g
 oWnKFKO3lAJ5fATo9SlXs46mGU6X8vk2yUpgkOnEl+agUsJalSaD0VGv9JN69oPPsoX2
 j6XsJtCCX3Z1bluDG3NdR8hsSpDGzgQFw9/rMSSCXwa5eq/z58tTfrpSx631FjN21oXh
 UZKQcLcaJ9sFV7euBG/bJZYgB33Ltq5F8jc8FdihSj+4EAnpkGBvwQfGWhTHZSuCRDiC
 intw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791212511; x=1791817311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sJL1wUq1/9xigC+eDOJFyGhcqLk4A52EajwWjb33Br0=;
 b=A+D/07sx3Bo8L3wsCaRL77WEM85oqUhpJ0EI2QpCU7xdnoFV0Flq3Ziwmp1xBN18ty
 OzNdtTl37CVdIERVZZtg5EkpQ85ZeVSnig9vSNO9YO4q/dYq9enUHaRboKAAdCDaURMS
 qeQK9ylBKSlNwpTewPB4JCzHpaNkKAQNQ2XRoiB6mXjre3qRFfNLJFo7DX0asnrwk6WD
 Dwy+vSUbAxRzphcRSusCct6sCumPFVGJJg43f5j+gSwWr5ZMHPw07wAum6lIUAuPKrWV
 vzqHPLCZHThofC3G8DhV7VP2xMJfDzF8uLruJY1LhtxBlLNhbzpF+MdQYHnXG1PKsF8t
 uaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791212511; x=1791817311;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sJL1wUq1/9xigC+eDOJFyGhcqLk4A52EajwWjb33Br0=;
 b=DGH1RrtsJ4rQ52Fco/vg3yACQnTQ5TCXGIhcJA3xCh+wXTk/ImwAdEnDiM6onDeaVh
 QWwTB1+byOpZrhYkfKqTlfb6CzR/kGxZ5kS74h4LWtK2LswQYKXR5J0baMqNAykkNv8r
 YFEB5nl3RCew4h7YayN03YXjNNDe4EAVwyZPUcg40vyyBJcV+pw+w60Xf3AyGtJg3yfk
 5sexEzoeZ2GX141YT3ics6AKmcCP7tjZdjvyoiKyweojhVrPQhufnXSNWsOCyfpik99D
 NFHiqswla4RY6nQLq7rbqeupgy5qilpU/APE6BnuI19lMNXwbRAdFmXDOrDEcjVJIv9P
 IxqQ==
X-Gm-Message-State: AFq9FYL1cVKW4lRCCSfNWhHXYteippr4H5QoUs7I9/xXtkCATAmcjBYZ
 0LFUlGWfqrZZsZtberOhlv20LCELSfLCA097pzmHkLJSfxGjkvrZQVbKeFq84VwniSkh8tjy6W4
 +4Hl+L87UmnUKSOiKfi6nwe5flYpkdIw=
X-Gm-Gg: AYBFou2cEi7PHW7fc8vYlemgMC3b+CgC/rkBCglOLJ5qs6CgGkl3PNphs7kEsoeGG8H
 1dQZ7tAigVgeeRRk10B276PAfy+kAoSNT6owbbOi1HB17RFsvERA7aLis3y0NrsC79fg4z0RdUR
 3jiDIsyfaY2Sh5APruQwS2o0t66GeTF++7674NVdQRy6MlmHmT9eNVCB3W81wtkgWz7fDESliBs
 xksVJRnUoOpAaxbkFuSasYH00HuSfVZTxL4r6/MrUncmHf4MmBmBoASjs1j1iK6Nhibv/m0ivGK
 mA8sEaBveWsFMe3sRhTM178I4M4O1WyO01FmP6E0nkqaBokqsyURS0wF/o/3ROhtknEjPWFf8MW
 GwcciBtXteLKabDNNkveMgZ/fWg==
X-Received: by 2002:a05:690c:348a:b0:873:5c6b:a303 with SMTP id
 00721157ae682-8ae3a00d216mr34163507b3.49.1791212510582; Mon, 05 Oct 2026
 08:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-5-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-5-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 23:01:37 +0800
X-Gm-Features: AclHuK-Vc-cwOizJz1bGvTI7Ny-9rajbHeBvLAZXy7l1LoiGbPbi4NS3TMQV4VU
Message-ID: <CAEUhbmXuyb_2=JT0GDDPYaU=z0LycFo7GphY8AYD=hzZmEf82g@mail.gmail.com>
Subject: Re: [PATCH v3 04/31] hw/watchdog/wdt_imx2: Remove redundant attributes
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2b;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Bernhard,

On Mon, Oct 5, 2026 at 6:21=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Since WDT and WDE are write one once bits, their values always
> correspond with their respective locked attributes. Thus, the attributes
> are redundant. Take advantage of this observation to simplify the code.
>
> Note that removing the attributes changes the vmstate structure which
> constitutes a migration break. This is allowed since QEMU does not
> guarantee migration compatibility for i.MX devices between feature
> releases.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/watchdog/wdt_imx2.h |  2 --
>  hw/watchdog/wdt_imx2.c         | 21 ++++-----------------
>  2 files changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx=
2.h
> index fc01fc46e7..0bf2903959 100644
> --- a/include/hw/watchdog/wdt_imx2.h
> +++ b/include/hw/watchdog/wdt_imx2.h
> @@ -84,8 +84,6 @@ struct IMX2WdtState {
>      uint16_t wmcr;
>
>      bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
> -    bool wcr_wde_locked;        /* affects WDE */
> -    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
>  };
>
>  #endif /* WDT_IMX2_H */
> diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
> index a15f452d48..e9cb5819e4 100644
> --- a/hw/watchdog/wdt_imx2.c
> +++ b/hw/watchdog/wdt_imx2.c
> @@ -59,8 +59,6 @@ static void imx2_wdt_reset(DeviceState *dev)
>
>      s->wicr_locked =3D false;
>      s->wcr_locked =3D false;
> -    s->wcr_wde_locked =3D false;
> -    s->wcr_wdt_locked =3D false;
>
>      s->wcr =3D IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
>      s->wsr =3D 0;
> @@ -156,24 +154,14 @@ static void imx2_wdt_write(void *opaque, hwaddr add=
r,
>      switch (addr) {
>      case IMX2_WDT_WCR:
>          if (s->wcr_locked) {
> +            /* WDZST, WDBG, and WDW are write-once bits */
>              value &=3D ~IMX2_WDT_WCR_LOCK_MASK;
>              value |=3D (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
>          }
>          s->wcr_locked =3D true;
> -        if (s->wcr_wde_locked) {
> -            value &=3D ~IMX2_WDT_WCR_WDE;
> -            value |=3D (s->wcr & IMX2_WDT_WCR_WDE);
> -        } else if (value & IMX2_WDT_WCR_WDE) {
> -            s->wcr_wde_locked =3D true;
> -        }
> -        if (s->wcr_wdt_locked) {
> -            value &=3D ~IMX2_WDT_WCR_WDT;
> -            value |=3D (s->wcr & IMX2_WDT_WCR_WDT);
> -        } else if (value & IMX2_WDT_WCR_WDT) {
> -            s->wcr_wdt_locked =3D true;
> -        }
>
> -        s->wcr =3D value;
> +        /* WDT and WDE are write one once bits */
> +        s->wcr =3D value | (s->wcr & (IMX2_WDT_WCR_WDT | IMX2_WDT_WCR_WD=
E));
>          if (!(value & IMX2_WDT_WCR_SRS)) {
>              s->wrsr =3D IMX2_WDT_WRSR_SFTW;
>          }

In the following codes:

        if (!(value & (IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS)) ||
            (!(value & IMX2_WDT_WCR_WT) && (value & IMX2_WDT_WCR_WDE))) {
            watchdog_perform_action();
        }

Since you removed the part:

        value |=3D (s->wcr & IMX2_WDT_WCR_{WDE,WDT})

now 'value' does not contain the preserved WDE/WDT bits (they are only
preserved in s->wcr in this patch), the watchdog_perform_action()
won't be called.

> @@ -234,13 +222,12 @@ static const MemoryRegionOps imx2_wdt_ops =3D {
>
>  static const VMStateDescription vmstate_imx2_wdt =3D {
>      .name =3D "imx2.wdt",
> +    .version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_PTIMER(timer, IMX2WdtState),
>          VMSTATE_PTIMER(itimer, IMX2WdtState),
>          VMSTATE_BOOL(wicr_locked, IMX2WdtState),
>          VMSTATE_BOOL(wcr_locked, IMX2WdtState),
> -        VMSTATE_BOOL(wcr_wde_locked, IMX2WdtState),
> -        VMSTATE_BOOL(wcr_wdt_locked, IMX2WdtState),
>          VMSTATE_UINT16(wcr, IMX2WdtState),
>          VMSTATE_UINT16(wsr, IMX2WdtState),
>          VMSTATE_UINT16(wrsr, IMX2WdtState),

Regards,
Bin

