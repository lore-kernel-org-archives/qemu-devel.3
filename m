Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6467EB1054
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzy8G-0002fL-Nf; Tue, 10 Mar 2026 10:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vzy8E-0002en-FE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:32:22 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vzy8A-0003uH-Cc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:32:21 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-506a747448dso113901191cf.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773153134; cv=none;
 d=google.com; s=arc-20240605;
 b=P5uuRHa2zfVqe2+JFPQmX4HWbc139mGS+jZIQeq2hMrNyge+XOLmVvl01qyCajARoX
 kCowpUulv5th/Il2jqYj83SWbkEkM/jQ/8RCDFz1JfMgcYNFsopzu5w0+WME17th+/bO
 xETtB9cwVrlzci7sSGmeDQWl8N2WtU9sBAx2fdNG/66BNV99KVNcaLi4pFsDU/4FLglq
 xa9BP61ARbN7VcHS10dLGluTlMFYt1/GgKP3MIL1A9dvfBZcTxRRV45QjwoJIB/x7gnc
 9fzIbehnjmuE+JDEay4mU0Tn1/NY1j8yyqiWwQF/8rjehXJUPYmA1Ns0Pq0bRYAV8XiH
 /r3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eS5ZwUDDZgg/nkA9LBKgyJ+Uj7ou2Wa//QoFkJLgujM=;
 fh=W1NcKK7iQreG/T81x9yLAkh32WIjMiy9id5KcMjASR8=;
 b=CpIKBwWuqwaRDF5kQmUm3n4mnO4JLAjaK2fI3fG9Cl3EMP9FP73Oj8PDfO0GOSAM1F
 dxdk4cB0rnDHuiMX7SBaAvcpSTGpcUZfUvs0OkazrLjAYsXiyhmiKtu/iXOyufHru4xL
 BH62nymiOudROieA3TBybYogD15tpzQWJ1OVJUenXVrdy6mOWl6RPC6FmG4DzLzNLGjZ
 BaeQXlY5P1+zOWK2oH8jdhVXGSn556xAHsLQLjNDy9/tS8fpSFNH9+P+hYjR7koE2KL9
 LWjOcy2elYmnrrA+m314jGjiVw0fq2YrnjHypqpIbc/7o10uFu8hXtuJM2Mfmoz3cMK3
 SdVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773153134; x=1773757934; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS5ZwUDDZgg/nkA9LBKgyJ+Uj7ou2Wa//QoFkJLgujM=;
 b=Hvv7LfJvZUrHytfwEnNJEsnzx4TCwVsbgw7vs3VcMIHdrbKisCrlD5AOKJbpr/WfN5
 m4IsOQNm+QDVytwLMW5CH9/8pq1CchWw1o6cXTQab0M0Pwh8Qy1azXdHwy5Fw0vBhQmx
 TZL5qBtkzHSyxMTZdCkyPdsPNhXKgSjG4SkDtWTx8n/REwW1aYXmhq9IXtuBzKLu5UUI
 g8PrhzsoeYtrhIZT1UV4gXx2cnw8+ekGefVpp4iqM+XVOQuIMSedPJsVabNxZOnqrnx6
 9tEJyP8DHHkvjtNxd7Mmut79KkxCGkUnAekPOSid359WMWextlEAEz2UZTXvvvmMvWKZ
 zI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773153134; x=1773757934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eS5ZwUDDZgg/nkA9LBKgyJ+Uj7ou2Wa//QoFkJLgujM=;
 b=nTi1d7KPsSxzu/GulRTDVyRzyLKyaj9RTp591LuORx0JgnAlM/iE+6CfQF8n6x5ydZ
 c+rqwD5rmvzz8M0XTftkOFiovxMnRTyfft68Hn4/A2cfMPRPVahE93lawNFc/IvA5jsN
 AKp2JmXjdN8c0Mw3fWNcg9NjnGP9H010H97wNUoPQzY//KK6GfhcYs76gb7DIAAcI6sh
 uLRKZnU0pT+tIn8IgUIwG3kcqozd6uHaB429Zt4XvNoXkOdcSgKmeY8glRszyL5f39b+
 mC1Kv9RK20Rbk4Z9GxZXJPuBzea3zHW/7/Q6sKTuCXyYiRRI6A7MG52PeU70uHOqTtJi
 PIJA==
X-Gm-Message-State: AOJu0YwdOrqj+8jd4NMKhNM8718N3cBK5HOmLuYcl1gJ96ebeyDf6X1P
 dO0iZ3L3TiAmXsSXwe1+p6jBaUvLvUmu6TrQmLWyMTSRK2gzIAxchs9pK37pMuiG0JT5GMj4F1H
 th0O4XbQ/kRCKD5eZgNYU6sHoBl865zM=
X-Gm-Gg: ATEYQzweH6L5mra0dmjDJb0LLVALyoNGbWIi35WDo6hUE3NLyxq5DnXN4sz3hLcvFS8
 P7VUf7g1ycBbU1lRpv7qH007jSBItgiadmbufayGuNbY8gXYY9VSx1TXVsfBkx1eYLi59MpxybK
 bYIv6PJcR8A6B/rbX1x6pPzg1VfeENvgm+6vCb68osOt5znfC0Z53dT+keTvwuUDyTZXPWvWFm2
 N/A2iWy03o3Zelc8PaeRfVHmf9XzLrqZGTDYVwn721V54v6Av/vFl9JpI4mGkINKmM3tc4GrT3u
 XWxANdt6QTc59Y7JkkpVvIDW4eUjmuN9m1LbjOc=
X-Received: by 2002:ac8:5f96:0:b0:501:3b8c:7d7d with SMTP id
 d75a77b69052e-508f492aecdmr191106161cf.29.1773153134160; Tue, 10 Mar 2026
 07:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260310142552.240877-1-f.ebner@proxmox.com>
In-Reply-To: <20260310142552.240877-1-f.ebner@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Mar 2026 15:32:02 +0100
X-Gm-Features: AaiRm51XMBLJV5JPhJgDRlObYqJjp9CiUs5bmj6ukAxWl7SJHqfk2YavpOPNLD8
Message-ID: <CAJ+F1CLU9E3ukJBPeW7TKjBqGBdt6Vx-1-UUQUuq4mj_3BRJPA@mail.gmail.com>
Subject: Re: [PATCH v2] ui/vdagent: add migration blocker when machine version
 < 10.1
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 zhao1.liu@intel.com, peterx@redhat.com, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 10, 2026 at 6:27=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> In QEMU 10.1, commit 5d56bff11e ("ui/vdagent: add migration support")
> added migration support for the vdagent chardev and commit 42000e0013
> ("ui/vdagent: remove migration blocker") removed the migration
> blocker. No compat for older machine versions was added, so migration
> with pre-10.1 machine version, from a 10.1 binary to a pre-10.1 binary
> will result in a failure when loading the VM state in the target
> instance:
>
> > Unknown savevm section or instance 'vdagent' 0. Make sure that your
> > current VM setup matches your saved VM setup, including any
> > hotplugged devices
>
> Add a compat flag to block migration when the machine version is less
> than 10.1 to avoid this.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 42000e0013 ("ui/vdagent: remove migration blocker")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Ah yes, I didn't think about that case!
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>
> Changes in v2:
> * rebase on current master, adapting to commit 8c84f31ace
>   ("chardev: .chr_open(): add boolean return value")
>
>  hw/core/machine.c |  1 +
>  ui/vdagent.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a14ad05b9a..6cf0e2f404 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -57,6 +57,7 @@ GlobalProperty hw_compat_10_0[] =3D {
>      { "vfio-pci", "x-migration-load-config-after-iter", "off" },
>      { "ramfb", "use-legacy-x86-rom", "true"},
>      { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
> +    { "chardev-qemu-vdagent", "x-migration-blocked", "true" },
>  };
>  const size_t hw_compat_10_0_len =3D G_N_ELEMENTS(hw_compat_10_0);
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 5a5e4bf681..bb0c4aa14c 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -6,6 +6,8 @@
>  #include "qemu/option.h"
>  #include "qemu/units.h"
>  #include "hw/core/qdev.h"
> +#include "hw/core/qdev-properties.h"
> +#include "migration/blocker.h"
>  #include "ui/clipboard.h"
>  #include "ui/console.h"
>  #include "ui/input.h"
> @@ -24,6 +26,10 @@
>  struct VDAgentChardev {
>      Chardev parent;
>
> +    /* needed for machine versions < 10.1 when migration was not support=
ed */
> +    Error *migration_blocker;
> +    bool migration_blocked;
> +
>      /* config */
>      bool mouse;
>      bool clipboard;
> @@ -657,6 +663,12 @@ static bool vdagent_chr_open(Chardev *chr, ChardevBa=
ckend *backend,
>      return false;
>  #endif
>
> +    if (vd->migration_blocked) {
> +        if (migrate_add_blocker(&vd->migration_blocker, errp) !=3D 0) {
> +            return false;
> +        }
> +    }
> +
>      vd->mouse =3D VDAGENT_MOUSE_DEFAULT;
>      if (cfg->has_mouse) {
>          vd->mouse =3D cfg->mouse;
> @@ -901,6 +913,19 @@ static void vdagent_chr_parse(QemuOpts *opts, Charde=
vBackend *backend,
>
>  /* ------------------------------------------------------------------ */
>
> +static bool get_migration_blocked(Object *o, Error **errp)
> +{
> +    VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(o);
> +    return vd->migration_blocked;
> +}
> +
> +static void set_migration_blocked(Object *o, bool migration_blocked,
> +                                   Error **errp)
> +{
> +    VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(o);
> +    vd->migration_blocked =3D migration_blocked;
> +}
> +
>  static void vdagent_chr_class_init(ObjectClass *oc, const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
> @@ -910,6 +935,10 @@ static void vdagent_chr_class_init(ObjectClass *oc, =
const void *data)
>      cc->chr_write        =3D vdagent_chr_write;
>      cc->chr_set_fe_open  =3D vdagent_chr_set_fe_open;
>      cc->chr_accept_input =3D vdagent_chr_accept_input;
> +
> +    object_class_property_add_bool(oc, "x-migration-blocked",
> +                                   get_migration_blocked,
> +                                   set_migration_blocked);
>  }
>
>  static int post_load(void *opaque, int version_id)
> @@ -1064,10 +1093,26 @@ static void vdagent_chr_instance_init(Object *obj=
)
>      vmstate_register_any(NULL, &vmstate_vdagent, vd);
>  }
>
> +static void vdagent_post_init(Object *obj)
> +{
> +    VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(obj);
> +
> +    object_apply_compat_props(obj);
> +
> +    if (vd->migration_blocked) {
> +        error_setg(&vd->migration_blocker,
> +                   "The vdagent chardev doesn't support migration with m=
achine"
> +                   " version less than 10.1");
> +    }
> +}
> +
>  static void vdagent_chr_fini(Object *obj)
>  {
>      VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(obj);
>
> +    if (vd->migration_blocked) {
> +        migrate_del_blocker(&vd->migration_blocker);
> +    }
>      vdagent_disconnect(vd);
>      if (vd->mouse_hs) {
>          qemu_input_handler_unregister(vd->mouse_hs);
> @@ -1080,6 +1125,7 @@ static const TypeInfo vdagent_chr_type_info =3D {
>      .parent =3D TYPE_CHARDEV,
>      .instance_size =3D sizeof(VDAgentChardev),
>      .instance_init =3D vdagent_chr_instance_init,
> +    .instance_post_init =3D vdagent_post_init,
>      .instance_finalize =3D vdagent_chr_fini,
>      .class_init =3D vdagent_chr_class_init,
>  };
> --
> 2.47.3
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

