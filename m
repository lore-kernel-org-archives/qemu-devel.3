Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02471C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfD84-0003hv-9N; Thu, 02 Jul 2026 04:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wfD82-0003hQ-LL
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 04:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wfD7z-0002Vx-SN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 04:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782982233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/U6sSa7NaRHnZjd0dWGrAcbCBTMdZob2Y+z8iw2jmGg=;
 b=Vpnak/igdGefmcCzd8rTwROKBtaD3fW70VHX/20T2m5X9Ew/q8yFOMjccKVTHUQE6oOWn9
 GG9zM69Kb6d+8sKLimdwdCJQv8oc7EXMFYXuC9OBZk1sQafy2EZ0VcrCltQOzp3Z56cMFM
 WpQBwu4Fbw7BVnLubqmyg+7b0UHIv88=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-d5Cwg5iuPkG3kOQlCFiDsg-1; Thu, 02 Jul 2026 04:50:31 -0400
X-MC-Unique: d5Cwg5iuPkG3kOQlCFiDsg-1
X-Mimecast-MFC-AGG-ID: d5Cwg5iuPkG3kOQlCFiDsg_1782982231
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4767036f8faso1034400f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 01:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782982230; cv=none;
 d=google.com; s=arc-20260327;
 b=WXQcD10h/mEo8t8slnMe80rlXXgzRgdQzXef+Xd6rUHDjeJCRbnHcaLdjgP3jyNIWf
 eiijFSW2GdMt+08PsYRwdFZlVfhHYANR8r9YSuzhUSDbnb17PcuD0X09y3smyHCif8kh
 ysPcDw8bIPzpTmf8/JUB6MZPAzkKiujKXbJ5OzjEOW8pQminTV046rOKRLCJ3a/+/y6u
 itWGv7YoAyY6vN1h0vxVu42XJF99SvM4yN9Zo7oXR8djQBhCWTD31h5x6vlmJwWXVazB
 JOZC3++q/GU6nMlVfESTDATlbl8C1q0W3ju/1tVn7AMmCOnkilwkgyQACfLE7sA2QaFa
 H7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/U6sSa7NaRHnZjd0dWGrAcbCBTMdZob2Y+z8iw2jmGg=;
 fh=Y6ZVa2DAQ7N99Yz30qJegDSPM58qw0hum3KbRozMzY4=;
 b=iA7OEMSwl/KsSuoGabMTnemk45RCeW4b5CiPIsloEHzYOBjruhuIla4KoY//5iDIsm
 fULtjnR48PdNfd23P/dwMgsnS7FgkiQfb5noCW1PUDxfX/raWHHmLrQPVEVtq//n9Kxu
 xc0LsvQiYmsTi6v2S6HhR1Ik4zdZ4T5QPufSmFmRDJcGQGhMBDI/hxPjfLoFIiekiXQZ
 qCYjUqBizkCZtJw1I21wBC0xDrAfYlPtCDxUMgJl7cMiW3TtSHewKra3YgKpUgJvgIHj
 wWWfrnFwNEwSPf9J3czrPmeIOL5Vt4pBgwfRuI8qqa3GCqKhtTVS/MkQyMBNIAdnTvrv
 U0kw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782982230; x=1783587030; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/U6sSa7NaRHnZjd0dWGrAcbCBTMdZob2Y+z8iw2jmGg=;
 b=Kp2A93t2bqw1+5fFzPTRYPym6eY8H735M+qnV/uEobuLCbh9JuXUMNNzE3Wh+2sdVO
 9tJ2MgPKRQc63obtRyAmvnIsBDawy1eQCia797MX5RsRTSjthnF/f0NRtf86DYjOZguL
 9oBorkII+dN6lsVs2eGeJv9AoWZaPM0cTWe6VxSIYqV0IECOdoSx8FQtnCsrYdUlQEKB
 UaqaeY2al48EjZ0SBtAXNSnsp/Xb3A4ROpAhhQ0BuLrtxZ3mZIslxjZse4zSu4bzGouc
 EXir6EPYLjpEjVI80n8uSeWBwYmrqdm32UOlekYJk9U/19Z8GaV3WTTX7N4QOI7CcDVS
 cjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782982230; x=1783587030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/U6sSa7NaRHnZjd0dWGrAcbCBTMdZob2Y+z8iw2jmGg=;
 b=a9YmA0b7oReuievSRuLzruckVWZr//ho5JGBtW7m/vamwy48CLJMyoA/BNgW1iMb8p
 OMiSTUO45frJ9V0aRaNXnBI2BUUE+Q1SaTNsFHiPjpSdN16Oo13ADlRHqhjQhJIhlLMe
 QB61n9A846oZGJZdRfmFgc/GyuLYT6CZ2ZHxGEpwdGcA4xEzqrX/LKM7X8uCajScBxdu
 8OkodBvyncxHgDeyeYn6uyVWQJtT45Otk6yAedjOnO4YU53M0HrWeJy7l80BoqX8iNQN
 27LXgYbAMe3VFfhRkmebDvrQRSY3I04aJWlfN9qPtw7TUfMOKCB5k6fEI3u+M6ch+fis
 fTgA==
X-Gm-Message-State: AOJu0Ywbk7W9i88TDZPR46wYfDuV2HC6Rj6cZ1HdbNj0gM630gxAQTPF
 OmUm5m30kDiPau9ddqfumetWQXujrEqnIVfZGBgapVABuhXbgnIX6bwUtqMbbiMh7i4S9yTLIOV
 foHeJaiea/8uWIihFyYxBexCLghJgnvwmcV61dhXZCs95k7VD8wSf/FyiBJb/BGM3OAHLiKoIwi
 UIMgwegNXG+zRm/DzYbNb6h6ZL6jmqPuA=
X-Gm-Gg: AfdE7cnSVPKgqBaRWo0pb2ukpf0ny40j2Kp2oPdYWp7j4Tfh+0A8HrF3shbJXEoB7im
 faXZBKNOltkXFAWVGIjMSMgq6L9SHICmwBzJA/CXDzITrdSH7C8+rR5cmNPbau9JAMNHuoVlyrp
 oVsWzuLX07Hfq40joHAQPhGh2gTXdMlNc+wR8uCLS+HX7YveHWtB5vcfkdGEs2xt7tot6AHpjDg
 HZ5Pu6f/88+a16Y2JrNyUn9DWgSepgTI0l2UbI4jzFQeIg/9xP8jg+KHQKQhWUeDE8Y3VU=
X-Received: by 2002:a05:6000:310a:b0:475:5e4b:588c with SMTP id
 ffacd0b85a97d-477573b7cdcmr7494823f8f.1.1782982230526; 
 Thu, 02 Jul 2026 01:50:30 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:475:5e4b:588c with SMTP id
 ffacd0b85a97d-477573b7cdcmr7494788f8f.1.1782982230136; Thu, 02 Jul 2026
 01:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-27-magnuskulke@linux.microsoft.com>
In-Reply-To: <20260417105618.3621-27-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 2 Jul 2026 10:50:17 +0200
X-Gm-Features: AVVi8Cc5RUAzXmzFb1ymi8NtVQ3-CQa2f95DDX9QS4umZiZE24mZXLVYoWRKux8
Message-ID: <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>
Subject: Re: [PATCH 26/34] accel/mshv: introduce SaveVMHandler
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000077f60a06559ce644"
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

--00000000000077f60a06559ce644
Content-Type: text/plain; charset="UTF-8"

Il ven 17 apr 2026, 12:58 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
scritto:

> This mechanism is used to handle more imperative partition-wide steps
> that have to be taken as part of a migration routine.
>
> Currently it's a skeleton that will just pause/resume the partition as
> part of a migration. It will later be extended with more specific steps
> like reference time and hypercall pages.
>

Sorry, I forgot to reply about this one.

It is not clear why you need to pause, since this is handled by common
code. Are you not handling live migration yet? That should be handled at
levels above QEMU, because users expect migration to be performed while the
VM runs, and the SaveVMHandler should just fail migration of the VM is
running.

Paolo

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 75 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 4c1a42d002..5f81881c05 100644
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

--00000000000077f60a06559ce644
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 17 apr 2026, 12:58 Magnus Kulke &lt;<a href=3D"=
mailto:magnuskulke@linux.microsoft.com" target=3D"_blank" rel=3D"noreferrer=
">magnuskulke@linux.microsoft.com</a>&gt; ha scritto:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">This mechanism is used to handle more=
 imperative partition-wide steps<br>
that have to be taken as part of a migration routine.<br>
<br>
Currently it&#39;s a skeleton that will just pause/resume the partition as<=
br>
part of a migration. It will later be extended with more specific steps<br>
like reference time and hypercall pages.<br></blockquote></div></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Sorry, I forgot to reply about this=
 one.</div><div dir=3D"auto"><br></div><div dir=3D"auto">It is not clear wh=
y you need to pause, since this is handled by common code. Are you not hand=
ling live migration yet? That should be handled at levels above QEMU, becau=
se users expect migration to be performed while the VM runs, and the SaveVM=
Handler should just fail migration of the VM is running.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
Signed-off-by: Magnus Kulke &lt;<a href=3D"mailto:magnuskulke@linux.microso=
ft.com" rel=3D"noreferrer noreferrer" target=3D"_blank">magnuskulke@linux.m=
icrosoft.com</a>&gt;<br>
---<br>
=C2=A0accel/mshv/mshv-all.c | 75 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 75 insertions(+)<br>
<br>
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c<br>
index 4c1a42d002..5f81881c05 100644<br>
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

--00000000000077f60a06559ce644--


