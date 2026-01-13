Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6A8D29DE4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfZ1P-0006G1-Nw; Tue, 13 Jan 2026 02:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vfZ11-0006Ag-NX
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vfZ0y-0008Gw-KG
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768290031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UJU4/bcTwN64G8ORVb7u+twJq9t3lRceY05/tFm9F4=;
 b=MzJzBAyGaPy/ujFeDYu5ScNSgVNz91w9Fq6LtF/VL2YmeDoVhdOqH4TAhadEMw3zAo30Q8
 ubakHfoCYFUQCRjVoa9BZL22Zej6IEhPEEn8uYg8KU4dg6COc/FENa7/xGuIDnBEK/R64Y
 jJv5jXNBpHbWe/WwcqvUlUDIlS1lC+8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-KUzDBjbvO1qIMuTpqFZsTg-1; Tue, 13 Jan 2026 02:40:29 -0500
X-MC-Unique: KUzDBjbvO1qIMuTpqFZsTg-1
X-Mimecast-MFC-AGG-ID: KUzDBjbvO1qIMuTpqFZsTg_1768290028
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c93f0849dso5687072a91.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768290028; x=1768894828; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9UJU4/bcTwN64G8ORVb7u+twJq9t3lRceY05/tFm9F4=;
 b=He7gpou6fyucn3N7fI6o4pnZv+xd/tjuNnzwn7+rrkTOrLhHfM7wwWQMJ6+8zFwKJS
 C3ukVr9Mje+7yq0hWzioZSaoIl0xsBkA96xzGRjO8r6OCL0qKpRlzftWz7hF3cadBkSv
 iac9eZ8FxZ3mewHQIpQdWNo3+L9VjHaCQ9G5hzBF+oZSi5nINvJvGwjRS2MKaltsU2d7
 gbvE+3JEIl9BYWSzerXKbUGnCTns3qlLMmRbY2DGwRrW1QIU8gHU3b99IawcoPUZ4HGz
 txOqzSmZQtnrPibYOqACgj0caG+vJIAAR9aX/b6O//9vYwvpjdzt957VA+h8AMN+Ky20
 ifTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768290028; x=1768894828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UJU4/bcTwN64G8ORVb7u+twJq9t3lRceY05/tFm9F4=;
 b=kKiovoMaJ69z04DWmtcJdR6b/28KO2beA2aaxA5pnwthn7+90lZ6RhrhLl2Ehpec/F
 YUrXi0h0v+edES0NwSUI9PCE1Y3x233mjtlozdfzQWdszD03OwCyxRjulGvQ55rYLT3O
 jNBeCvbjkeij5Y8/Pw029THkNNWJZqfuqbwp3h3LJB2I8WWFDPvI05pNbkCOc9bB8oi2
 zWhoSsCkLRqBFUaWG/fBgElDH10ti/pDeoAB4cM63xVvfRPCVNznPuzAECeiWqrr3Tnp
 xwnTDswtgwH4OBQKPh0UrxuTvYw9YXGdUnUJ19kw+XHKSHqHMoEwU0wMOe0ezNmYEzbx
 t+Rg==
X-Gm-Message-State: AOJu0YwM9+f7k2bAv+czruNXcO6qnq8ViXtSqgaIe3SKv/alqXtJuWiJ
 ejom3C6sO6mtpUhIQazFU5F1SQllrmtoZ72QOfWadE89QIAXG3mszOm5h1Rlcb/1LoHV2dPp8f0
 KabPB21L2oCFnklyv6/X4y7fGRXO2rkcGyElJqxdJ9hBE6hRTuwvL4xn6SQVLvrBTb6g5J3lJeI
 fkX6FAYyd8gDw99SBwbLAkz8nD9MTO5BE=
X-Gm-Gg: AY/fxX5SSkHQ3C+Wwat4bAZgBMGIz7PQ50hma4d9/QtV0pPM4cjky1ibOiIRseBOLNF
 psTjAmXqcmxtZbeJMNx+ltF78o4YSIU/7WbIFijbzNQ4dNqawo6gtBMIfyfOJt6TgjycfeDqiRm
 p4HPmp492verPz3Dee14DlXiCKnoQBm+SctOwlemu6NZJytsbLkh/Vs43C3wKhzjy7vewlzQbq1
 GM5Ht5G+8QNHu5b69xtdidQIg==
X-Received: by 2002:a17:90b:314a:b0:343:3898:e7c9 with SMTP id
 98e67ed59e1d1-350fd0ff4b2mr1897296a91.2.1768290028160; 
 Mon, 12 Jan 2026 23:40:28 -0800 (PST)
X-Received: by 2002:a17:90b:314a:b0:343:3898:e7c9 with SMTP id
 98e67ed59e1d1-350fd0ff4b2mr1897287a91.2.1768290027805; Mon, 12 Jan 2026
 23:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20260112104454.54225-1-f.ebner@proxmox.com>
In-Reply-To: <20260112104454.54225-1-f.ebner@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Jan 2026 11:40:16 +0400
X-Gm-Features: AZwV_QgT_-1UHCL2Til6jpNFdlC3ArA7bHgaZHsTPicXuTpdcQozlbLuO6zGBCM
Message-ID: <CAMxuvaz0AKCcO=nWUc_U39wcdHn0w_3N8WDncT0Fbc7aWM=nAQ@mail.gmail.com>
Subject: Re: [PATCH] ui/vdagent: add migration blocker when machine version <
 10.1
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 zhao1.liu@intel.com, peterx@redhat.com, farosas@suse.de
Content-Type: multipart/alternative; boundary="000000000000f7ad990648401a67"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000f7ad990648401a67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fiona

On Mon, Jan 12, 2026 at 2:51=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:

> In QEMU 10.1, commit 5d56bff11e ("ui/vdagent: add migration support")
> added migration support for the vdagent chardev and commit 42000e0013
> ("ui/vdagent: remove migration blocker") removed the migration
> blocker. No compat for older machine versions was added, so migration
> with pre-10.1 machine version, from a 10.1 binary to a pre-10.1 binary
> will result in a failure when loading the VM state in the target
> instance:
>
>
But you can migrate a pre-10.1 machine with the new binary.


> > Unknown savevm section or instance 'vdagent' 0. Make sure that your
> > current VM setup matches your saved VM setup, including any
> > hotplugged devices
>
> Add a compat flag to block migration when the machine version is less
> than 10.1 to avoid this.
>
>
I am not sure this is the right way to handle this. There is already this
error when migrating to an older qemu, I am not sure we have to block
earlier and prevent the above case.



> Cc: qemu-stable@nongnu.org
> Fixes: 42000e0013 ("ui/vdagent: remove migration blocker")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  hw/core/machine.c |  1 +
>  ui/vdagent.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 6411e68856..9a5241ce17 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -55,6 +55,7 @@ GlobalProperty hw_compat_10_0[] =3D {
>      { "vfio-pci", "x-migration-load-config-after-iter", "off" },
>      { "ramfb", "use-legacy-x86-rom", "true"},
>      { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
> +    { "chardev-qemu-vdagent", "x-migration-blocked", "true" },
>

Is there a precedent where such compat property was added to block
migration?


>  };
>  const size_t hw_compat_10_0_len =3D G_N_ELEMENTS(hw_compat_10_0);
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 142a3691ac..15ecabb402 100644
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
> @@ -32,6 +34,10 @@
>  struct VDAgentChardev {
>      Chardev parent;
>
> +    /* needed for machine versions < 10.1 when migration was not
> supported */
> +    Error *migration_blocker;
> +    bool migration_blocked;
> +
>      /* config */
>      bool mouse;
>      bool clipboard;
> @@ -677,6 +683,12 @@ static void vdagent_chr_open(Chardev *chr,
>      return;
>  #endif
>
> +    if (vd->migration_blocked) {
> +        if (migrate_add_blocker(&vd->migration_blocker, errp) !=3D 0) {
> +            return;
> +        }
> +    }
> +
>      vd->mouse =3D VDAGENT_MOUSE_DEFAULT;
>      if (cfg->has_mouse) {
>          vd->mouse =3D cfg->mouse;
> @@ -920,6 +932,19 @@ static void vdagent_chr_parse(QemuOpts *opts,
> ChardevBackend *backend,
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
> @@ -929,6 +954,10 @@ static void vdagent_chr_class_init(ObjectClass *oc,
> const void *data)
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
> @@ -1083,10 +1112,26 @@ static void vdagent_chr_init(Object *obj)
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
> +                   "The vdagent chardev doesn't support migration with
> machine"
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
> @@ -1099,6 +1144,7 @@ static const TypeInfo vdagent_chr_type_info =3D {
>      .parent =3D TYPE_CHARDEV,
>      .instance_size =3D sizeof(VDAgentChardev),
>      .instance_init =3D vdagent_chr_init,
> +    .instance_post_init =3D vdagent_post_init,
>      .instance_finalize =3D vdagent_chr_fini,
>      .class_init =3D vdagent_chr_class_init,
>  };
> --
> 2.47.3
>
>
>

--000000000000f7ad990648401a67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Fiona</div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan=
 12, 2026 at 2:51=E2=80=AFPM Fiona Ebner &lt;<a href=3D"mailto:f.ebner@prox=
mox.com">f.ebner@proxmox.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">In QEMU 10.1, commit 5d56bff11e (&quot;ui/vdage=
nt: add migration support&quot;)<br>
added migration support for the vdagent chardev and commit 42000e0013<br>
(&quot;ui/vdagent: remove migration blocker&quot;) removed the migration<br=
>
blocker. No compat for older machine versions was added, so migration<br>
with pre-10.1 machine version, from a 10.1 binary to a pre-10.1 binary<br>
will result in a failure when loading the VM state in the target<br>
instance:<br>
<br></blockquote><div><br></div><div>But you can migrate a pre-10.1 machine=
 with the new binary.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt; Unknown savevm section or instance &#39;vdagent&#39; 0. Make sure that=
 your<br>
&gt; current VM setup matches your saved VM setup, including any<br>
&gt; hotplugged devices<br>
<br>
Add a compat flag to block migration when the machine version is less<br>
than 10.1 to avoid this.<br>
<br></blockquote><div><br></div><div>I am not sure this is the right way to=
 handle this. There is already this error when migrating to an older qemu, =
I am not sure we have to block earlier and prevent the above case.</div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Fixes: 42000e0013 (&quot;ui/vdagent: remove migration blocker&quot;)<br>
Signed-off-by: Fiona Ebner &lt;<a href=3D"mailto:f.ebner@proxmox.com" targe=
t=3D"_blank">f.ebner@proxmox.com</a>&gt;<br>
---<br>
=C2=A0hw/core/machine.c |=C2=A0 1 +<br>
=C2=A0ui/vdagent.c=C2=A0 =C2=A0 =C2=A0 | 46 +++++++++++++++++++++++++++++++=
+++++++++++++++<br>
=C2=A02 files changed, 47 insertions(+)<br>
<br>
diff --git a/hw/core/machine.c b/hw/core/machine.c<br>
index 6411e68856..9a5241ce17 100644<br>
--- a/hw/core/machine.c<br>
+++ b/hw/core/machine.c<br>
@@ -55,6 +55,7 @@ GlobalProperty hw_compat_10_0[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;vfio-pci&quot;, &quot;x-migration-load-config-a=
fter-iter&quot;, &quot;off&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;ramfb&quot;, &quot;use-legacy-x86-rom&quot;, &q=
uot;true&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;vfio-pci-nohotplug&quot;, &quot;use-legacy-x86-=
rom&quot;, &quot;true&quot; },<br>
+=C2=A0 =C2=A0 { &quot;chardev-qemu-vdagent&quot;, &quot;x-migration-blocke=
d&quot;, &quot;true&quot; },<br></blockquote><div><br></div><div>Is there a=
 precedent where such compat property was added to block migration?</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0};<br>
=C2=A0const size_t hw_compat_10_0_len =3D G_N_ELEMENTS(hw_compat_10_0);<br>
<br>
diff --git a/ui/vdagent.c b/ui/vdagent.c<br>
index 142a3691ac..15ecabb402 100644<br>
--- a/ui/vdagent.c<br>
+++ b/ui/vdagent.c<br>
@@ -6,6 +6,8 @@<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
=C2=A0#include &quot;hw/core/qdev.h&quot;<br>
+#include &quot;hw/core/qdev-properties.h&quot;<br>
+#include &quot;migration/blocker.h&quot;<br>
=C2=A0#include &quot;ui/clipboard.h&quot;<br>
=C2=A0#include &quot;ui/console.h&quot;<br>
=C2=A0#include &quot;ui/input.h&quot;<br>
@@ -32,6 +34,10 @@<br>
=C2=A0struct VDAgentChardev {<br>
=C2=A0 =C2=A0 =C2=A0Chardev parent;<br>
<br>
+=C2=A0 =C2=A0 /* needed for machine versions &lt; 10.1 when migration was =
not supported */<br>
+=C2=A0 =C2=A0 Error *migration_blocker;<br>
+=C2=A0 =C2=A0 bool migration_blocked;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* config */<br>
=C2=A0 =C2=A0 =C2=A0bool mouse;<br>
=C2=A0 =C2=A0 =C2=A0bool clipboard;<br>
@@ -677,6 +683,12 @@ static void vdagent_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0#endif<br>
<br>
+=C2=A0 =C2=A0 if (vd-&gt;migration_blocked) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migrate_add_blocker(&amp;vd-&gt;migration_=
blocker, errp) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0vd-&gt;mouse =3D VDAGENT_MOUSE_DEFAULT;<br>
=C2=A0 =C2=A0 =C2=A0if (cfg-&gt;has_mouse) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vd-&gt;mouse =3D cfg-&gt;mouse;<br>
@@ -920,6 +932,19 @@ static void vdagent_chr_parse(QemuOpts *opts, ChardevB=
ackend *backend,<br>
<br>
=C2=A0/* ------------------------------------------------------------------=
 */<br>
<br>
+static bool get_migration_blocked(Object *o, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(o);<br>
+=C2=A0 =C2=A0 return vd-&gt;migration_blocked;<br>
+}<br>
+<br>
+static void set_migration_blocked(Object *o, bool migration_blocked,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(o);<br>
+=C2=A0 =C2=A0 vd-&gt;migration_blocked =3D migration_blocked;<br>
+}<br>
+<br>
=C2=A0static void vdagent_chr_class_init(ObjectClass *oc, const void *data)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
@@ -929,6 +954,10 @@ static void vdagent_chr_class_init(ObjectClass *oc, co=
nst void *data)<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D vdagent=
_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_fe_open=C2=A0 =3D vdagent_chr_set_fe_ope=
n;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_accept_input =3D vdagent_chr_accept_input;<b=
r>
+<br>
+=C2=A0 =C2=A0 object_class_property_add_bool(oc, &quot;x-migration-blocked=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_migration_blocked,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_migration_blocked);=
<br>
=C2=A0}<br>
<br>
=C2=A0static int post_load(void *opaque, int version_id)<br>
@@ -1083,10 +1112,26 @@ static void vdagent_chr_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0vmstate_register_any(NULL, &amp;vmstate_vdagent, vd);<b=
r>
=C2=A0}<br>
<br>
+static void vdagent_post_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(obj);<br>
+<br>
+=C2=A0 =C2=A0 object_apply_compat_props(obj);<br>
+<br>
+=C2=A0 =C2=A0 if (vd-&gt;migration_blocked) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;vd-&gt;migration_blocker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;The vdagent chardev doesn&#39;t support migration with machine&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; version less than 10.1&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0static void vdagent_chr_fini(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(obj);<br>
<br>
+=C2=A0 =C2=A0 if (vd-&gt;migration_blocked) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_del_blocker(&amp;vd-&gt;migration_bloc=
ker);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0vdagent_disconnect(vd);<br>
=C2=A0 =C2=A0 =C2=A0if (vd-&gt;mouse_hs) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_input_handler_unregister(vd-&gt;mous=
e_hs);<br>
@@ -1099,6 +1144,7 @@ static const TypeInfo vdagent_chr_type_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.parent =3D TYPE_CHARDEV,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(VDAgentChardev),<br>
=C2=A0 =C2=A0 =C2=A0.instance_init =3D vdagent_chr_init,<br>
+=C2=A0 =C2=A0 .instance_post_init =3D vdagent_post_init,<br>
=C2=A0 =C2=A0 =C2=A0.instance_finalize =3D vdagent_chr_fini,<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D vdagent_chr_class_init,<br>
=C2=A0};<br>
-- <br>
2.47.3<br>
<br>
<br>
</blockquote></div></div>

--000000000000f7ad990648401a67--


