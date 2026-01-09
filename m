Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F509D26D99
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 20:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJ96-00087J-4a; Fri, 09 Jan 2026 15:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1veJ8o-00084h-44
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:31:27 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1veJ8l-0003zh-SK
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:31:25 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59b6c13b68dso2935507e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767990681; x=1768595481; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uZovdkN3pD8TLxsfstC8MK6P3iodE8+NXNywFHIPYuE=;
 b=Cf69wm2WiesaJhHTEBSua8Iv0XNrNgGL0UzG6J34cf2lls6U8D+mjGDGPRQd2t8mrA
 RlB9B1d4hu3I4I+NAJKP8EXP9aJ1AvyAA3SW5CKtQ6XrQyU1j3ov9RNtoIQTa2Db/aUh
 xy9FBQy1bW0IUFtG+1yw3dXoP6xLlzrd1GNOT1L7tQca/+INfeC4k9xCZ7Ll6pFmPGxr
 PISjb/lnmkrqjV7ztU3RSqaFIyfLzES6jhE7BBwBPSYnwP5w+bCzJmOuknvDRL3HpQTj
 GWKpedb72D5TfvbrPGopHgebQaHyRsLWUF3mYBTNFFF9TgR+i1FKLeHtV+6tCL+z9hHv
 LBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767990681; x=1768595481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZovdkN3pD8TLxsfstC8MK6P3iodE8+NXNywFHIPYuE=;
 b=U58eg0/3g2aj4LCwxUQIHrENM29gNqx7yeL3fMGesnevsJrI7xp1LIRMPmKtV207FL
 dj3Dc2HQjphNxEvpaDXsuM4SOTxBVcK3eLPz7VKvsm0+Qc2cDO9vgDPdRy3USpP/TVKi
 pBPVifu0bnW+eNW16M37zQRvqOZI0SiMcDtJtoVmIOALfAOvplU6AEmnbvxZ2d5ZnBmX
 2CxrJ75e+EDeL2RWGU22yWhs26a//mmYFB5V9cCZpVPogFbq2ch5Y7ecA5Dtp0id425i
 yIzQ8iUIADgtSFQHkytUZO6zCLhzLFoaKYcVRGM/4sOziqFyl5nNkx09tEqRe9GDcvTw
 6Rvw==
X-Gm-Message-State: AOJu0YwlM9q/1mthPQ5E7P59upnHtPwV/gta+yBFFgM5jNmqPNmyoP6P
 XyGPbtx6Gi/i+tXsCGBQghNzeuHpipFoSlPuwAuhVC06UF3U7Er7VS3RyAptRwUuHLKmu3B2J3U
 IDWC3h3QPlT1WfVhbtJjB1K6etjmL4zmqf4bdgGo=
X-Gm-Gg: AY/fxX7PfTgtir76FwhgtXEa30WnEHla4xI6BsMGlCHUknnuKbGVHa9oXo7QwuDDeZj
 C7gPIrse1yLZXBlpukfaOGeMgC1dlSeahvGSZxCj8YOuyzYABc26HiURuMAqmBoa8COV/W5A30e
 yOco+Iudr6keAq4UpGYhaoLptCoI59Mf5ccTIMbs8RAoqJQ8RgVJN0l3SG9DGGRF1xov1SJUFbd
 wKZ0Qf4Hik9f5ziu1aH1OfE/S9icNFsMMLmg4Sc2lZ5mZwfp4g9nK6o66HtqlstahOW3gb0c33z
 syVyA2i8q0NuANVgCS/LrKSqjzE6
X-Google-Smtp-Source: AGHT+IFvtSy5A0T7xRxfrtyF5stpDwD7sjhqViK1ghjaj0lDYcgMc+EiEJgF3FgSH1x0ecik6UMLviAmHodUz1EhZ9k=
X-Received: by 2002:a05:6512:ad0:b0:59a:108a:c8bb with SMTP id
 2adb3069b0e04-59b6587c2a7mr4760331e87.12.1767990680683; Fri, 09 Jan 2026
 12:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20260109202740.362506-1-ankeesler@google.com>
 <20260109202740.362506-2-ankeesler@google.com>
In-Reply-To: <20260109202740.362506-2-ankeesler@google.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Fri, 9 Jan 2026 15:31:09 -0500
X-Gm-Features: AZwV_QiqiM0OZpjfqUqTsZd9IDWRo0v38wmbEqDehNuo5bXaidvUW_wh1Siv-lw
Message-ID: <CAGZECHP9i9zeZP4wLtDtx44OsPesOC3hG=bmpjsGrYUVAG-mXg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] Support per-head resolutions with virtio-gpu
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: multipart/alternative; boundary="0000000000007db9860647fa6867"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=ankeesler@google.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000007db9860647fa6867
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note - we use "xres" and "yres" (instead of, say, "width" and "height")
to match analogous virtio_gpu_base_conf.xres/yres.

On Fri, Jan 9, 2026 at 3:27=E2=80=AFPM Andrew Keesler <ankeesler@google.com=
> wrote:

> In 454f4b0f, we started down the path of supporting separate
> configurations per display head (e.g., you have 2 heads - one with
> EDID name "AAA" and the other with EDID name "BBB").
>
> In this change, we add resolution to this configuration surface (e.g.,
> you have 2 heads - one with resolution 111x222 and the other with
> resolution 333x444).
>
>   -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \
>   -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \
>   -device '{"driver":"virtio-vga",
>             "max_outputs":2,
>             "id":"vga",
>             "outputs":[
>               {
>                  "name":"AAA",
>                  "xres":111,
>                  "yres":222
>               },
>               {
>                  "name":"BBB",
>                  "xres":333,
>                  "yres":444
>               }
>             ]}'
>
> Here is the behavior matrix of the current resolution configuration
> surface (xres/yres) with the new resolution configuration surface
> (outputs[i].xres/yres).
>
> Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with default xres/yres
>
> Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with xres/yres
>
> Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>
> Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>
> Signed-off-by: Andrew Keesler <ankeesler@google.com>
> ---
>  hw/display/virtio-gpu-base.c | 10 ++++++++++
>  qapi/virtio.json             | 13 +++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 7269477a1c..6adb5312a4 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>      g->req_state[0].width =3D g->conf.xres;
>      g->req_state[0].height =3D g->conf.yres;
>
> +    for (output_idx =3D 0, node =3D g->conf.outputs;
> +         node && output_idx < g->conf.max_outputs;
> +         output_idx++, node =3D node->next) {
> +        if (node->value->has_xres && node->value->has_yres) {
> +            g->enabled_output_bitmask |=3D (1 << output_idx);
> +            g->req_state[output_idx].width =3D node->value->xres;
> +            g->req_state[output_idx].height =3D node->value->yres;
> +        }
> +    }
> +
>      g->hw_ops =3D &virtio_gpu_ops;
>      for (i =3D 0; i < g->conf.max_outputs; i++) {
>          g->scanout[i].con =3D
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index cd67c4f52e..c1a1fb4997 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -970,15 +970,24 @@
>  ##
>  # @VirtIOGPUOutput:
>  #
> -# Describes configuration of a VirtIO GPU output.
> +# Describes configuration of a VirtIO GPU output.  If both @xres and
> +# @yres are set, they take precedence over root virtio-gpu
> +# resolution configuration and enable the corresponding output.  If
> +# only one or none of @xres or @yres is set, root virtio-gpu
> +# resolution configuration takes precedence and only the first output
> +# is enabled.
>  #
>  # @name: the name of the output
>  #
> +# @xres: horizontal resolution of the output in pixels (since 10.2)
> +#
> +# @yres: vertical resolution of the output in pixels (since 10.2)
> +#
>  # Since: 10.1
>  ##
>
>  { 'struct': 'VirtIOGPUOutput',
> -  'data': { 'name': 'str' } }
> +  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
>
>  ##
>  # @DummyVirtioForceArrays:
> --
> 2.52.0.457.g6b5491de43-goog
>
>

--0000000000007db9860647fa6867
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Note - we use &quot;xres&quot; and &quot;yres&quot; (inste=
ad of, say, &quot;width&quot; and &quot;height&quot;)<br>to match analogous=
 virtio_gpu_base_conf.xres/yres.<br></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 9, 20=
26 at 3:27=E2=80=AFPM Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google=
.com">ankeesler@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">In 454f4b0f, we started down the path of supporti=
ng separate<br>
configurations per display head (e.g., you have 2 heads - one with<br>
EDID name &quot;AAA&quot; and the other with EDID name &quot;BBB&quot;).<br=
>
<br>
In this change, we add resolution to this configuration surface (e.g.,<br>
you have 2 heads - one with resolution 111x222 and the other with<br>
resolution 333x444).<br>
<br>
=C2=A0 -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \<br>
=C2=A0 -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \<br>
=C2=A0 -device &#39;{&quot;driver&quot;:&quot;virtio-vga&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;max_outputs&quot;:2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;id&quot;:&quot;vga&quot;,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;outputs&quot;:[<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;name&qu=
ot;:&quot;AAA&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;xres&qu=
ot;:111,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;yres&qu=
ot;:222<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;name&qu=
ot;:&quot;BBB&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;xres&qu=
ot;:333,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;yres&qu=
ot;:444<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]}&#39;<br>
<br>
Here is the behavior matrix of the current resolution configuration<br>
surface (xres/yres) with the new resolution configuration surface<br>
(outputs[i].xres/yres).<br>
<br>
Case: !(xres || yres) &amp;&amp; !(outputs[i].has_xres &amp;&amp; outputs[i=
].has_yres)<br>
Behavior: current behavior - outputs[0] enabled with default xres/yres<br>
<br>
Case: (xres || yres) &amp;&amp; !(outputs[i].has_xres &amp;&amp; outputs[i]=
.has_yres)<br>
Behavior: current behavior - outputs[0] enabled with xres/yres<br>
<br>
Case: !(xres || yres) &amp;&amp; (outputs[i].has_xres &amp;&amp; outputs[i]=
.has_yres)<br>
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres<br>
<br>
Case: (xres || yres) &amp;&amp; (outputs[i].has_xres &amp;&amp; outputs[i].=
has_yres)<br>
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres<br>
<br>
Signed-off-by: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.com" t=
arget=3D"_blank">ankeesler@google.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-base.c | 10 ++++++++++<br>
=C2=A0qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 =
+++++++++++--<br>
=C2=A02 files changed, 21 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c<br=
>
index 7269477a1c..6adb5312a4 100644<br>
--- a/hw/display/virtio-gpu-base.c<br>
+++ b/hw/display/virtio-gpu-base.c<br>
@@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,<br>
=C2=A0 =C2=A0 =C2=A0g-&gt;req_state[0].width =3D g-&gt;conf.xres;<br>
=C2=A0 =C2=A0 =C2=A0g-&gt;req_state[0].height =3D g-&gt;conf.yres;<br>
<br>
+=C2=A0 =C2=A0 for (output_idx =3D 0, node =3D g-&gt;conf.outputs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node &amp;&amp; output_idx &lt; g-&gt;co=
nf.max_outputs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output_idx++, node =3D node-&gt;next) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (node-&gt;value-&gt;has_xres &amp;&amp; nod=
e-&gt;value-&gt;has_yres) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;enabled_output_bitmask |=
=3D (1 &lt;&lt; output_idx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[output_idx].widt=
h =3D node-&gt;value-&gt;xres;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;req_state[output_idx].heig=
ht =3D node-&gt;value-&gt;yres;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0g-&gt;hw_ops =3D &amp;virtio_gpu_ops;<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; g-&gt;conf.max_outputs; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g-&gt;scanout[i].con =3D<br>
diff --git a/qapi/virtio.json b/qapi/virtio.json<br>
index cd67c4f52e..c1a1fb4997 100644<br>
--- a/qapi/virtio.json<br>
+++ b/qapi/virtio.json<br>
@@ -970,15 +970,24 @@<br>
=C2=A0##<br>
=C2=A0# @VirtIOGPUOutput:<br>
=C2=A0#<br>
-# Describes configuration of a VirtIO GPU output.<br>
+# Describes configuration of a VirtIO GPU output.=C2=A0 If both @xres and<=
br>
+# @yres are set, they take precedence over root virtio-gpu<br>
+# resolution configuration and enable the corresponding output.=C2=A0 If<b=
r>
+# only one or none of @xres or @yres is set, root virtio-gpu<br>
+# resolution configuration takes precedence and only the first output<br>
+# is enabled.<br>
=C2=A0#<br>
=C2=A0# @name: the name of the output<br>
=C2=A0#<br>
+# @xres: horizontal resolution of the output in pixels (since 10.2)<br>
+#<br>
+# @yres: vertical resolution of the output in pixels (since 10.2)<br>
+#<br>
=C2=A0# Since: 10.1<br>
=C2=A0##<br>
<br>
=C2=A0{ &#39;struct&#39;: &#39;VirtIOGPUOutput&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39; } }<br>
+=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39;, &#39;*xres&#39;: &=
#39;uint16&#39;, &#39;*yres&#39;: &#39;uint16&#39; } }<br>
<br>
=C2=A0##<br>
=C2=A0# @DummyVirtioForceArrays:<br>
-- <br>
2.52.0.457.g6b5491de43-goog<br>
<br>
</blockquote></div>

--0000000000007db9860647fa6867--

