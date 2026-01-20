Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67322D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 13:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viC4S-0000cq-RB; Tue, 20 Jan 2026 08:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1viC4Q-0000cJ-8a
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:46:58 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1viC4N-0006Wb-ID
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:46:57 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59b76844f89so5246360e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 05:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768916812; cv=none;
 d=google.com; s=arc-20240605;
 b=OoORohIYztccJhoH04/l4BOwIjm5KR7Gl4h/mg62Ueqcsq/ji7dUs4W7SUZC4cMEsV
 gw02Kr11EFCep72jtYYwI7oFfQtFAIcss1OOmLPWjcyy1+J19AMcsWEVM6YGlqSSQrYK
 blo4tVjzIVgFhkuwkAR57eVofTVIrScC5BA5hSMq4rvBg6skTbdMXHgdXM9s28GShAiw
 dN84zVyQ+tAyfac1vH6DVe2+4ziIKyRR5kfGzCK7brsuKbcFXsPxF5y2EUGES2mizZjL
 QgAzsH2n0rse5etWJz1JkO8LGysXMXxigfHwH5WxpGuq+ci7sFaJtMZXEhoqgC1AAs41
 28mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8Uz3amhsVPp+nZfHVVlYW4f9piel5X3SPpWY66F/Bm0=;
 fh=ro/AWavYJ3k8wuJjFcsnbm9LKL8KpbSULCknMk7kheA=;
 b=X8jT3AtFw8xNw32NPWZRTcEOELL9DwIRmFuVibK+LrJtLbzT76bcAtfvr/ecKRNlMC
 EpSmkoKpTfmiNTnPjXzv3u4CQ2RxaETqYq6mJRXIapdr3UF4v//0oqby7CAJz5DEL9XJ
 tra6gx6fGZS7ofUkvpi/O5Oxx/dMQSzdw42W9FM/Dzb6upJKSad/Rwuj1rNujrjrB8dS
 yIuAHCMsWkrEFelY3OSkH/Xfs1wEPWS60bQAsiJZaTHMq9KWCrDH1vt0BldZveuBSP4a
 yW24ZVolvAeoeqMfl9oiR1ALTNDiVGoWNQ985FL7uSPCoRcVg0CoEFT5DmR528G8xGVb
 3Q2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1768916812; x=1769521612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Uz3amhsVPp+nZfHVVlYW4f9piel5X3SPpWY66F/Bm0=;
 b=VKARxFwK1y+1VzzNijVoZXWS49vGs+7tORyOUBwjSsGWTOAAKc7H6iFa+aumKKNywb
 IPKVLfqFY/nutAtL+6LdPNISJmQ23vZ0ObnCjtn47ErMKRQCiOAG9MGtUClBLf+fmIg5
 2CQOIWmg4Q26GsYbLse5stHd7tQqMUAuEpiKmJXL/XR3DQ0SrhZl/LYiG8ownqqmfv/h
 jo4NiU2LGRmSLqHG7dU6xv55lPRI73NpwVd6tdUuJBcXsR82Pf86XVprvl0F8M6PQWIt
 HLknHmhg0V4S8PB1NQ9e+9LgNdZDCkSlvpy2aY7uXJENxr4edXvotKSnFx01ML6hY2Bf
 D3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768916812; x=1769521612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Uz3amhsVPp+nZfHVVlYW4f9piel5X3SPpWY66F/Bm0=;
 b=LAxKVDIOEW/v5m6J1LejFGxuoOdjK72HTZS+jeo8Gxh5BAxBRboMf+AN/Ko/5vECe+
 VbScW4RLGaklqQYZRH45Ol6sO5E46EnLppZ18Lz1CntwtvF4KNfSw7JZLc35vBMjhhEN
 u3SlgiRXjHr6X59yTXtLoLhi64utxID4b4ugSrZt4mIwghGhYNw1IV60ZYWJ17OMuwBK
 FyTNusX2UPzY5DBpnoDC/axj59908MPynf+ce3wvqsDUvCap6sLutlaKG2eIXEMHRBBw
 OTIQmLkkd4WMGvyubPHS6JfSe6cy22HPM26367ssnyMhTplin5zYu51qWnRDmI6IAXOz
 htng==
X-Gm-Message-State: AOJu0Yx8S5i2s9t9OG31Hik5jb88SFevSH+AENkbIfkrD8dOsXqnxlB4
 oFCRfYTAfj18Rj2SbrzVbACj+rSlpBZDC/EoGUGQhmwymZEB09dgiYEftmxz0cEFiIOFeaHmOAm
 uIU5vJnplccj+YE4euZcSUWX6IDltfb0+v2OTOYE=
X-Gm-Gg: AZuq6aLp5W+pH9skIVYaxJvM10/jaKdxu/V02F/Vm2MPm9xDh9Maz9P4Udh5WiT9Pn2
 yuF6xZiUHaj08Ls/62aj9EAwADT0tKIXKipwsHQBFtwAioMg1RoSuwejHWreJS5Fk0cJ9Bc2en3
 CIaoM1muDnuD3ksl0Azj/dgnR1CZT0tD0iU0wV/dCy+3sK19lVk7upUY4ju2sbZGWO+0pe3kJNW
 S9G0tDaVcwEIo2k/lkmnWbF0kQ1yWm2bDpeGKdXDeLb0QXH+2tjGimZoyGIepuTFFQ6Q1PMaImh
 cXwVrNZI/KfkzENohlFc4ksj2ts=
X-Received: by 2002:a05:6512:3992:b0:59b:b420:db3d with SMTP id
 2adb3069b0e04-59bb420dc19mr4094111e87.0.1768916812024; Tue, 20 Jan 2026
 05:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20260109202740.362506-1-ankeesler@google.com>
 <20260109202740.362506-2-ankeesler@google.com>
 <CAGZECHP9i9zeZP4wLtDtx44OsPesOC3hG=bmpjsGrYUVAG-mXg@mail.gmail.com>
In-Reply-To: <CAGZECHP9i9zeZP4wLtDtx44OsPesOC3hG=bmpjsGrYUVAG-mXg@mail.gmail.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Tue, 20 Jan 2026 08:46:40 -0500
X-Gm-Features: AZwV_Qigfgd9m-s1HGB8zIQPPnprVliCmkdCrJvW_HpvgpWGdrnPxNi0UtvXlG8
Message-ID: <CAGZECHOj7X=WXx0-KqunAbSeo-Dh4M2Ci0T+=9BFhe+P1GMMyQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] Support per-head resolutions with virtio-gpu
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: multipart/alternative; boundary="00000000000038a0c00648d20af5"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=ankeesler@google.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -177
X-Spam_score: -17.8
X-Spam_bar: -----------------
X-Spam_report: (-17.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.168,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--00000000000038a0c00648d20af5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle request for review.

This change was previously queued, and then dropped from a PR:

  https://mail.gnu.org/archive/html/qemu-devel/2025-10/msg04960.html

This v4 PATCH addresses those comments.



On Fri, Jan 9, 2026 at 3:31=E2=80=AFPM Andrew Keesler <ankeesler@google.com=
> wrote:

> Note - we use "xres" and "yres" (instead of, say, "width" and "height")
> to match analogous virtio_gpu_base_conf.xres/yres.
>
> On Fri, Jan 9, 2026 at 3:27=E2=80=AFPM Andrew Keesler <ankeesler@google.c=
om>
> wrote:
>
>> In 454f4b0f, we started down the path of supporting separate
>> configurations per display head (e.g., you have 2 heads - one with
>> EDID name "AAA" and the other with EDID name "BBB").
>>
>> In this change, we add resolution to this configuration surface (e.g.,
>> you have 2 heads - one with resolution 111x222 and the other with
>> resolution 333x444).
>>
>>   -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \
>>   -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \
>>   -device '{"driver":"virtio-vga",
>>             "max_outputs":2,
>>             "id":"vga",
>>             "outputs":[
>>               {
>>                  "name":"AAA",
>>                  "xres":111,
>>                  "yres":222
>>               },
>>               {
>>                  "name":"BBB",
>>                  "xres":333,
>>                  "yres":444
>>               }
>>             ]}'
>>
>> Here is the behavior matrix of the current resolution configuration
>> surface (xres/yres) with the new resolution configuration surface
>> (outputs[i].xres/yres).
>>
>> Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
>> Behavior: current behavior - outputs[0] enabled with default xres/yres
>>
>> Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
>> Behavior: current behavior - outputs[0] enabled with xres/yres
>>
>> Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
>> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>>
>> Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
>> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>>
>> Signed-off-by: Andrew Keesler <ankeesler@google.com>
>> ---
>>  hw/display/virtio-gpu-base.c | 10 ++++++++++
>>  qapi/virtio.json             | 13 +++++++++++--
>>  2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
>> index 7269477a1c..6adb5312a4 100644
>> --- a/hw/display/virtio-gpu-base.c
>> +++ b/hw/display/virtio-gpu-base.c
>> @@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>>      g->req_state[0].width =3D g->conf.xres;
>>      g->req_state[0].height =3D g->conf.yres;
>>
>> +    for (output_idx =3D 0, node =3D g->conf.outputs;
>> +         node && output_idx < g->conf.max_outputs;
>> +         output_idx++, node =3D node->next) {
>> +        if (node->value->has_xres && node->value->has_yres) {
>> +            g->enabled_output_bitmask |=3D (1 << output_idx);
>> +            g->req_state[output_idx].width =3D node->value->xres;
>> +            g->req_state[output_idx].height =3D node->value->yres;
>> +        }
>> +    }
>> +
>>      g->hw_ops =3D &virtio_gpu_ops;
>>      for (i =3D 0; i < g->conf.max_outputs; i++) {
>>          g->scanout[i].con =3D
>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>> index cd67c4f52e..c1a1fb4997 100644
>> --- a/qapi/virtio.json
>> +++ b/qapi/virtio.json
>> @@ -970,15 +970,24 @@
>>  ##
>>  # @VirtIOGPUOutput:
>>  #
>> -# Describes configuration of a VirtIO GPU output.
>> +# Describes configuration of a VirtIO GPU output.  If both @xres and
>> +# @yres are set, they take precedence over root virtio-gpu
>> +# resolution configuration and enable the corresponding output.  If
>> +# only one or none of @xres or @yres is set, root virtio-gpu
>> +# resolution configuration takes precedence and only the first output
>> +# is enabled.
>>  #
>>  # @name: the name of the output
>>  #
>> +# @xres: horizontal resolution of the output in pixels (since 10.2)
>> +#
>> +# @yres: vertical resolution of the output in pixels (since 10.2)
>> +#
>>  # Since: 10.1
>>  ##
>>
>>  { 'struct': 'VirtIOGPUOutput',
>> -  'data': { 'name': 'str' } }
>> +  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
>>
>>  ##
>>  # @DummyVirtioForceArrays:
>> --
>> 2.52.0.457.g6b5491de43-goog
>>
>>

--00000000000038a0c00648d20af5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gentle request for review.<div><br></div><div>This change =
was previously=C2=A0queued, and then dropped from a PR:</div><div><br></div=
><div>=C2=A0=C2=A0<a href=3D"https://mail.gnu.org/archive/html/qemu-devel/2=
025-10/msg04960.html">https://mail.gnu.org/archive/html/qemu-devel/2025-10/=
msg04960.html</a></div><div><br></div><div>This v4 PATCH addresses those co=
mments.</div><div><br></div><div>=C2=A0=C2=A0</div></div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Fri, Jan 9, 2026 at 3:31=E2=80=AFPM Andrew Keesler &lt;<a href=3D"mailto:a=
nkeesler@google.com">ankeesler@google.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Note - we use &qu=
ot;xres&quot; and &quot;yres&quot; (instead of, say, &quot;width&quot; and =
&quot;height&quot;)<br>to match analogous virtio_gpu_base_conf.xres/yres.<b=
r></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri, Jan 9, 2026 at 3:27=E2=80=AFPM Andrew Keesler &lt;<a href=3D"mail=
to:ankeesler@google.com" target=3D"_blank">ankeesler@google.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">In 454f4b0f,=
 we started down the path of supporting separate<br>
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
</blockquote></div>

--00000000000038a0c00648d20af5--

