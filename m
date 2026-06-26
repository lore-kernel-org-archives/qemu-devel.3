Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972A0CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd10b-0008JI-PA; Fri, 26 Jun 2026 03:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd10W-0008G4-JN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd10U-0000Ex-M7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782458986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CzC2n9BTZIfEO3GrKWqCEkPi7HE5nTqsuefmZJ4ztTc=;
 b=i01N8cGcu6gqpG9OSEZ1D4w0+HE5hUBZ98MMW5zPHTBLPHxzeNJpJoH0/ZeGMYXvBXQi0m
 qyF/pfQIUqMXBh66Y8Revy9VuS3FwEcKHKkgSIX4Q4sqYMaCetqjVQrRjUvdCG6hmtZzrE
 NIU8hTQW7w+3JFe2SKRcxMtZofpu4Zk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-rg4-klajP-6genlsp25xiQ-1; Fri, 26 Jun 2026 03:29:42 -0400
X-MC-Unique: rg4-klajP-6genlsp25xiQ-1
X-Mimecast-MFC-AGG-ID: rg4-klajP-6genlsp25xiQ_1782458981
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso5084095e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 00:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782458981; cv=none;
 d=google.com; s=arc-20260327;
 b=XSpNAsA03h7LR4trLu3/vWnK4E5b5OVtUnmDRb1yPB5zynVaQu7J0OQO9bLRHhUPNu
 i9G+HLz6d6fdoaTbutXTGr/0No7iZx1kaIaxz7oYmvsqk/ZnicamBIM7RUOGQcn5qEMp
 63lLfKFcbT3LpTNAO7DKoxgrgy6ktSIaUQdvhGwF0T0vGBIbteTU5oHFJ0o0PHy0DQzB
 Xfkx25EX7QopuSpIWVBGjXhNH5/UJLP9T42/6MmGuo58O8adBAaMgjw6VDI+MtVsgNai
 yvzOsVtkmYRci0psSslB0HOfW9KjM84S/Erjhbl3y88wJ5eySFBJvpdZLna5fT0pJRL2
 ny4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CzC2n9BTZIfEO3GrKWqCEkPi7HE5nTqsuefmZJ4ztTc=;
 fh=o6+CfxXq1AMfAZsh5yo6dJisHnlcAL1pTt3+7/JMkLQ=;
 b=H5kQGFH63XS/5NWhw+4Ki4yvw5savJ+fA1vgba85ML4YvH+EOMoZ44MDhOTwLTuFUB
 OmxjyrEo2v0BpyBAPS28YX7sLDX9afDfxYZ3BApMpC8U23WxKaajTkrFCnnNNt8K0iUn
 Wf+oEUyg33bL3qDl1/SJQDho01134ccdRomGYM+FV2iftYPTXy0JJxMUyZy6fF+S1ADQ
 bxA5uajePHrSTd1IxkKHOGyED3WjdN3YdSgxYmbgYZmKrsyk4kb/KH33dff+9Oi5YyD1
 imCxn+4tDHZgTexgHberx6oCG8ZY2KFteOO3/bEsytKNUhbtLfwJhVVf/tOop0TkzBka
 YF6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782458981; x=1783063781; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CzC2n9BTZIfEO3GrKWqCEkPi7HE5nTqsuefmZJ4ztTc=;
 b=FxHUs5r479tPVyRrAyBtcfu3JQfgq1iNeCrN64VeepaUHQ1yUp9UT0n9XWGc8rpvGS
 LylLyjee3UjU7Q5RzYzDW/8WbKh1wwzA+X7y4zp2Osxyhh8au2F6Leh7EB9LzGppqgll
 bLGQ9iVwChKEYkg/jYNGmfqV/RU7ObSqfRhHo82vZssJ4aM1l7iK/Bb0JdBCh7djcDEb
 icjeWEw+b9rRtp6O9csXQCa+loXz4n+yDRRmqgG0MH5StNbeFgydKTowU4DfIMuAYSp3
 SkcoAWhIwmJsZqXrkvk16PCFqsJsKNNwr2JX1enyRYLBure9lutIs07LTV5mOe+HDioT
 t4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782458981; x=1783063781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzC2n9BTZIfEO3GrKWqCEkPi7HE5nTqsuefmZJ4ztTc=;
 b=m0YoEkSn9yrDWegKXLa2aSRXFfi3RXwOH4mPMk/e2mIzVHPOD2Jkqn06iDMwpzlo2n
 wc0gz81ve/2glCQdAbBAUB3OC/uuv9OY3X1Tf92VGAvKGPVs6qawbPil9ttI2vstSHVh
 vf0NX+BBq2xSvyF8iAfsuR4W8daEU5p1/4ZwT5l0Hh0gN8ZUC3jKrM4TBp05C2R4tjPR
 3/VxEpW/RJchlHWdmoyi1TwZnpneGTg8D9v338bko+CrwRHajoQ8a5RGqU1rL9AwslY7
 Xu5XQ+FdmLZ7AAkUtaRIdG+8L/nsKeyOTHH7FYfHOKvnX7qW8d8gqoNNUvqpHJ49LkQy
 4SrA==
X-Gm-Message-State: AOJu0Yxli8L9Jsxvcfaws3qCd1CnpHmk9SQbLKBOeQZjXwm5/4KU9fMZ
 a2g7PuvFsh6Jyep06z0KBWUQt+IaglP5+qVHRrvLoIP6YFj3haWToefTfUu2rxliIuhprHPY/IV
 SH3HENbGe/iK6zuASouyYAjmwg517rSHzuSxW1xQUrS5QqTmvnNcpKfJO+fdsaHzl5vTMX8np0n
 a69EOjJlP+4lrf7/9mm87Od6NgArfa77g=
X-Gm-Gg: AfdE7cklj3+sU0nx37uc1L/XthfpiTpbEt8gkHQppSqKuOSCIaDZb0YlJrPFSMyYcyU
 W4ONsbbA9eIWtnIsVH8y0DszyKiK5KB0cGCTyDZAIUAxnvwtsXPIuacEkxFvtY4ePdneKcxKovg
 zSL+0Sqvm20XEsTlobPFtbksB42BHTqXrElVaU1S8hXkDD2bNkujBioLdJukuHY0wSi4py9sFGo
 FaqPOBkrCpzlZ6Ev8NTl4urAC0JkYquzTSzWkSyTJ75mDXq3UyacFF/Rm55wFpQ/n+Cmw==
X-Received: by 2002:a05:600d:644a:20b0:490:a298:acf7 with SMTP id
 5b1f17b1804b1-49266899f6dmr62016675e9.17.1782458980917; 
 Fri, 26 Jun 2026 00:29:40 -0700 (PDT)
X-Received: by 2002:a05:600d:644a:20b0:490:a298:acf7 with SMTP id
 5b1f17b1804b1-49266899f6dmr62016295e9.17.1782458980487; Fri, 26 Jun 2026
 00:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
 <20260323135812.383509-25-magnuskulke@linux.microsoft.com>
In-Reply-To: <20260323135812.383509-25-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jun 2026 09:29:28 +0200
X-Gm-Features: AVVi8Cd5qLIKTPhp4YQLzzsynAD5N6FeecoX8XTlCbE_Wlcso7oiaesEiPVOYkg
Message-ID: <CABgObfbFN7m-omgB28wMqKxSBLeCVKptwaEPoBxULDeG80+nqw@mail.gmail.com>
Subject: Re: [RFC 24/32] accel/mshv: introduce SaveVMHandler
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Wei Liu <liuwe@microsoft.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Magnus Kulke <magnuskulke@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005be8db065523120f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000005be8db065523120f
Content-Type: text/plain; charset="UTF-8"

Il lun 23 mar 2026, 14:59 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
scritto:

> This mechanism is used to handle more imperative partition-wide steps
> that have to be taken as part of a migration routine.
>
> Currently it's a skeleton that will just pause/resume the partition as
> part of a migration


This should not be necessary. It is handled by common code to pause/resume
before device state is needed.

Paolo

It will later be extended with more specific steps
> like reference time and hypercall pages.


> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 75 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index d1bf148bb8..365288b901 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -39,6 +39,8 @@
>  #include "system/mshv.h"
>  #include "system/mshv_int.h"
>  #include "system/reset.h"
> +#include "migration/qemu-file-types.h"
> +#include "migration/register.h"
>  #include "trace.h"
>  #include <err.h>
>  #include <sys/ioctl.h>
> @@ -47,6 +49,9 @@ bool mshv_allowed;
>
>  MshvState *mshv_state;
>
> +static int pause_vm(int vm_fd);
> +static int resume_vm(int vm_fd);
> +
>  static int init_mshv(int *mshv_fd)
>  {
>      int fd = open("/dev/mshv", O_RDWR | O_CLOEXEC);
> @@ -80,6 +85,64 @@ static int set_time_freeze(int vm_fd, int freeze)
>      return 0;
>  }
>
> +static void mshv_save_state(QEMUFile *f, void *opaque)
> +{
> +    return;
> +}
> +
> +static int mshv_load_state(QEMUFile *f, void *opaque, int version_id)
> +{
> +    return 0;
> +}
> +
> +static int mshv_save_prepare(void *opaque, Error **errp)
> +{
> +    MshvState *s = opaque;
> +    int ret;
> +
> +    ret = pause_vm(s->vm);
> +    if (ret < 0) {
> +        error_setg(errp, "Failed to pause VM for migration");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static void mshv_save_cleanup(void *opaque)
> +{
> +    MshvState *s = opaque;
> +    int ret;
> +
> +    ret = resume_vm(s->vm);
> +    if (ret < 0) {
> +        error_report("Failed to resme VM after  migration");
> +    }
> +}
> +
> +static int mshv_load_setup(QEMUFile *f, void *opaque, Error **errp)
> +{
> +    MshvState *s = opaque;
> +    int ret;
> +
> +    ret = pause_vm(s->vm);
> +    if (ret < 0) {
> +        error_setg(errp, "Failed to pause VM for migration restore");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int mshv_load_cleanup(void *opaque)
> +{
> +    MshvState *s = opaque;
> +
> +    resume_vm(s->vm);
> +
> +    return 0;
> +}
> +
>  static int pause_vm(int vm_fd)
>  {
>      int ret;
> @@ -454,6 +517,15 @@ static int mshv_init_vcpu(CPUState *cpu)
>      return 0;
>  }
>
> +static SaveVMHandlers savevm_mshv = {
> +    .save_prepare = mshv_save_prepare,
> +    .save_state = mshv_save_state,
> +    .save_cleanup = mshv_save_cleanup,
> +    .load_setup = mshv_load_setup,
> +    .load_state = mshv_load_state,
> +    .load_cleanup = mshv_load_cleanup,
> +};
> +
>  static int mshv_init(AccelState *as, MachineState *ms)
>  {
>      MshvState *s;
> @@ -509,6 +581,9 @@ static int mshv_init(AccelState *as, MachineState *ms)
>                                    0, "mshv-memory");
>      memory_listener_register(&mshv_io_listener, &address_space_io);
>
> +    /* register custom handlers for migration events */
> +    register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
> +
>      return 0;
>  }
>
> --
> 2.34.1
>
>

--0000000000005be8db065523120f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 23 mar 2026, 14:59 Magnus=
 Kulke &lt;<a href=3D"mailto:magnuskulke@linux.microsoft.com">magnuskulke@l=
inux.microsoft.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">This mechanism is used to handle more imperative par=
tition-wide steps<br>
that have to be taken as part of a migration routine.<br>
<br>
Currently it&#39;s a skeleton that will just pause/resume the partition as<=
br>
part of a migration</blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">This should not be necessary. It is handled by common code t=
o pause/resume before device state is needed.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">It will later be extended with more specific st=
eps<br>
like reference time and hypercall pages.</blockquote></div></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Magnus Kulke &lt;<a href=3D"mailto:magnuskulke@linux.microso=
ft.com" target=3D"_blank" rel=3D"noreferrer">magnuskulke@linux.microsoft.co=
m</a>&gt;<br>
---<br>
=C2=A0accel/mshv/mshv-all.c | 75 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 75 insertions(+)<br>
<br>
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c<br>
index d1bf148bb8..365288b901 100644<br>
--- a/accel/mshv/mshv-all.c<br>
+++ b/accel/mshv/mshv-all.c<br>
@@ -39,6 +39,8 @@<br>
=C2=A0#include &quot;system/mshv.h&quot;<br>
=C2=A0#include &quot;system/mshv_int.h&quot;<br>
=C2=A0#include &quot;system/reset.h&quot;<br>
+#include &quot;migration/qemu-file-types.h&quot;<br>
+#include &quot;migration/register.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &lt;err.h&gt;<br>
=C2=A0#include &lt;sys/ioctl.h&gt;<br>
@@ -47,6 +49,9 @@ bool mshv_allowed;<br>
<br>
=C2=A0MshvState *mshv_state;<br>
<br>
+static int pause_vm(int vm_fd);<br>
+static int resume_vm(int vm_fd);<br>
+<br>
=C2=A0static int init_mshv(int *mshv_fd)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int fd =3D open(&quot;/dev/mshv&quot;, O_RDWR | O_CLOEX=
EC);<br>
@@ -80,6 +85,64 @@ static int set_time_freeze(int vm_fd, int freeze)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+static void mshv_save_state(QEMUFile *f, void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 return;<br>
+}<br>
+<br>
+static int mshv_load_state(QEMUFile *f, void *opaque, int version_id)<br>
+{<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int mshv_save_prepare(void *opaque, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 MshvState *s =3D opaque;<br>
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 ret =3D pause_vm(s-&gt;vm);<br>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to pause VM for =
migration&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static void mshv_save_cleanup(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 MshvState *s =3D opaque;<br>
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 ret =3D resume_vm(s-&gt;vm);<br>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to resme VM after=C2=
=A0 migration&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static int mshv_load_setup(QEMUFile *f, void *opaque, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 MshvState *s =3D opaque;<br>
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 ret =3D pause_vm(s-&gt;vm);<br>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to pause VM for =
migration restore&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int mshv_load_cleanup(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 MshvState *s =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 resume_vm(s-&gt;vm);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
=C2=A0static int pause_vm(int vm_fd)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
@@ -454,6 +517,15 @@ static int mshv_init_vcpu(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+static SaveVMHandlers savevm_mshv =3D {<br>
+=C2=A0 =C2=A0 .save_prepare =3D mshv_save_prepare,<br>
+=C2=A0 =C2=A0 .save_state =3D mshv_save_state,<br>
+=C2=A0 =C2=A0 .save_cleanup =3D mshv_save_cleanup,<br>
+=C2=A0 =C2=A0 .load_setup =3D mshv_load_setup,<br>
+=C2=A0 =C2=A0 .load_state =3D mshv_load_state,<br>
+=C2=A0 =C2=A0 .load_cleanup =3D mshv_load_cleanup,<br>
+};<br>
+<br>
=C2=A0static int mshv_init(AccelState *as, MachineState *ms)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MshvState *s;<br>
@@ -509,6 +581,9 @@ static int mshv_init(AccelState *as, MachineState *ms)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, &quot;mshv-memory&qu=
ot;);<br>
=C2=A0 =C2=A0 =C2=A0memory_listener_register(&amp;mshv_io_listener, &amp;ad=
dress_space_io);<br>
<br>
+=C2=A0 =C2=A0 /* register custom handlers for migration events */<br>
+=C2=A0 =C2=A0 register_savevm_live(&quot;mshv&quot;, 0, 1, &amp;savevm_msh=
v, s);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div></div>

--0000000000005be8db065523120f--


