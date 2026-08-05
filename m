Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B4CC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrbhZ-00082Q-58; Wed, 05 Aug 2026 09:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wrbhW-0007zv-Rh
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 09:30:30 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wrbhU-0006DU-Oe
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 09:30:30 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a10b20634fso1692303a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 06:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785936627; cv=none;
 d=google.com; s=arc-20260327;
 b=SaMssPwlvu7h6JExZ5At+Hb4dyI/xH8hs1Y9bqb+jVhVUo76+/CrEF4vAxe49BOGTg
 3lprnQ80AkmrAtRx5DJsHXpANzXz/FiHGMiJvnH1Ok6maYSyA2IEIU2XoEtyW8RY/A+U
 YkT2uXfaWhfRbG97AGltAt8zEvC5KbNd/XqXF74jGC0PBcYCnCYGzJA+RzHDxIyypuuw
 MqiL1bw08I8DwKwT1WCQ/nmH1kFMWPsUUz5Aa8aJvmwG+lC9k/wHpmYMNRRMAFt7lZbS
 KUNmujnZ8hWiwVnnHeVRguwYxQr4dxYyMsyR+7sRTAvPzCjs8o28NSVMsjwfSUwqEaTq
 cskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ul+bEM2cOS0fH17TffqT3LRkSX+Tmw6wVbSUQ/vxJP4=;
 fh=9mwyWOpK54iJC8aLtzCKDeGN9smrR+H4CobDsaMoCBU=;
 b=Zsi27FfmENqNOsT97sywFjQ6iUycQlaaK2ctosA8mQvFG/2y2Erx3E8n099V0VEwru
 6gdnbYNe0KpfcmfwZ6hHKsW5w4Jld6Ap2q3P2x8BpiTWE4LnyyKYxbnK5tirNthQxeER
 5j5T26O/VE9SucSm1QCnHI8uBjEMMu2K1oO/LS3yNgKE01xKwslhrO5ay8tuYua5+l5S
 qzXb1hDdENFcdn8fVj9cS6lo1+j6ojSmkFKTSto1r/ZTDso4CwmlkeB4REWjQ4ovxRPt
 WfrM0fTjhi6vg7EX7jnp4qhh9wNzhLUGuTnak3ia91/eGk+/3yCPf7CHFHQ6itTSlt7c
 +HRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785936627; x=1786541427; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ul+bEM2cOS0fH17TffqT3LRkSX+Tmw6wVbSUQ/vxJP4=;
 b=Uq0K5OYjdixpcylaPtig8khWHR0FtbIOiWXDoiYj9N9QW0+5VOhWj+2qLTgnuWk9dd
 1Zw7LyoCHEGJMwq6xfcbVPguc2tMB1bOqKpSHLHCJWd6ENPpoVZXR4HkaLBfttvQ8OAs
 7+ZCQm5wUzBkuysG1WLoBufiAeLy5KeQY68xHyOvdy9qak/1pg0D/dWrXhHgasXemd3N
 0oXQXkilk+90YexuBkoKdUvOS8XHahdC4N5YsClpa8aV2Kz6tksBW7pR7ptenSm3101r
 UaqZ7ZrfpDq7J11Bv5cbseA7X9fGZzuqBp+RJ5ddkdtkG+hwnIUC2+Zrpp//KXbazHv5
 uQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785936627; x=1786541427;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ul+bEM2cOS0fH17TffqT3LRkSX+Tmw6wVbSUQ/vxJP4=;
 b=PBVeZ/QMYxWzeLK4FaRqp/vDh7VhOB/WfoXl3xx8KXwC2LUC7BrEI087fJRJAHJ8Ld
 /GSksoXDH0heMI/r81nIzPlsPj6N1FRk3nsBgqXinXrUJX+aelypnVASZhsOpN8ugoHV
 6rblyA8BUOrBYH1hY11sdJrPZelWt9l6krfk8D5hBhpcEW9YtuTKUuO0eavvF3v9c46+
 HI4Vm6VL/s48qzXwc0Q4rATTnFSGfhAi8J33UqVzBI0MdjcgbatJuO37QIGhaemLWdMO
 DimuPeAiGWBOtMOG/DbHh86LiYYwt9jAodXLO3gwPOCDCKHJEtTVea60mX0MU5BRj210
 vzWA==
X-Gm-Message-State: AOJu0Yz/eRNszXMlpjBVFLC6wqF4Neh6jE+5xv/qAxx1Vy7dgUvTsZiM
 i1d7mNc1n5VxXdCYZ4icpolbDJIw96sFtES4yTV+/3vHxeyvyLxeFqb4obCBspMRbOtoZRPvPZv
 MncCg7BdvYFzgofV9whwD/HvtQI/t6WA=
X-Gm-Gg: AR+sD11rFLUPWnAAP/3WDiaSDk5+iwI0W0u8m8uWPkmOZnVu3PJ6CcNTMgoRlWaEVRP
 YP1+UPZhu0Mr+45YVcJDiU6oM92AMpC5lwAst4SboacXxaBiUqag/G3BalGwMgMAudZ8SGrWzxS
 o7mvW5iLXwZp8v5UPXxvSxV3npr3X9/Ku6PaL7Ps/GVbZkODXVKw143uXJJI/JvIqiG7AJx3XPu
 vWRuRf0k8P3WaQtQiuaRDrrJKkuBAMQnk8VoUJCNBiKA50NWJhgiRnGeIHPfDiHfDDC0tjEtYw/
 bd1dbPAPNCY8sr5C7t6e+kZ9xHjdVjnOasSPUd8oK0srfQ==
X-Received: by 2002:a05:6402:5416:b0:699:fbe4:16d5 with SMTP id
 4fb4d7f45d1cf-6a14f07bde3mr4085934a12.1.1785936626400; Wed, 05 Aug 2026
 06:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <56625144-c2fe-4017-90ed-473e570fa35d@oss.qualcomm.com>
In-Reply-To: <56625144-c2fe-4017-90ed-473e570fa35d@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 5 Aug 2026 21:30:12 +0800
X-Gm-Features: AUfX_myW-51VdwsXko_-FnUn5AsElZcpa6tQp8UY-NdvtrrOq-GunwWyWs0os04
Message-ID: <CAE2XoE_-amik0TXZFTKiL2o1hOd-Qo0zkBHrdrSGnasLxA6q3g@mail.gmail.com>
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="0000000000003540b306584cc64f"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000003540b306584cc64f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:34=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 7/23/2026 5:09 PM, Pierrick Bouvier wrote:
> > Now that we can link a single-binary with at least two targets (arm,
aarch64),
> > we want to make sure that we expose the same set of machines (later
devices and
> > cpus) than target binaries. For that, we implemented a static filtering
based on
> > target interfaces that each machine will implement to declare which
targets have
> > this machine.
> >
> > However, we discovered that this static filtering is not enough.
Indeed, some
> > machines and devices do not depend only on target, and their presence
can depend
> > on Kconfig or host/target combination. Thus, our static approach can't
work, and
> > we need something more flexible.
> >
> > This series adds a new TYPE_TARGET_SPECIFIC, that declare a single
function
> > bool is_available(void). From there, any machine type (and later
devices and
> > cpus) can implement it to override their presence for each target.
> > We first replace the existing static mechanism with this, and once
done, we
> > cleanup all the old interface. One nice benefit is that we can get rid
of
> > config/targets/*.c files, which saves duplication.
> >
> > This series was tested by comparing list of machines for all qemu syste=
m
> > binaries, before and after this change, to make sure we don't introduce
a
> > regression.
> >

I am also tracing for this. So what's the shape of the final command line?

Maybe we can at least get arm/arm64/riscv32/risv64/riscv32-be/risv64-be to
be in a single binary.

The -be is needed because gdbstub would need this to get gdb working fine.
so the endian mode is important. arm/arm64 have nothing about be support
yet, even though in spec also have



> > Pierrick Bouvier (27):
> >   include/qemu/target-info-qom.h: declare TYPE_TARGET_SPECIFIC interfac=
e
> >   hw/arm: implement TYPE_TARGET_SPECIFIC
> >   target-info: add target_riscv32 and target_base_riscv
> >   hw/riscv: implement TYPE_TARGET_SPECIFIC
> >   target-info: add target_config_multiprocess
> >   hw/remote/machine: remove unsupported arm target
> >   hw/remote/machine: implement TYPE_TARGET_SPECIFIC
> >   target-info: add target_config_xen
> >   hw/arm/xen-pvh: implement TYPE_TARGET_SPECIFIC
> >   hw/xenpv/xen_machine_pv: implement TYPE_TARGET_SPECIFIC
> >   target-info: add target_config_nitro
> >   hw/nitro/machine: implement TYPE_TARGET_SPECIFIC
> >   target-info-qom: implement new machine filtering per target
> >   target-info-qom: use TYPE_MACHINE instead of target_machine_typename
> >   target-info: remove target_machine_typename
> >   target-info-qom: add type_target_specific
> >   hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
> >   hw/arm: remove {arm,arm_aarch64,aarch64}_machine_interfaces
> >   include/hw/core/boards.h: add DEFINE_MACHINE_TARGET_SPECIFIC
> >   hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
> >   hw/arm: remove machines-qom.h
> >   hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
> >   hw/riscv: remove {riscv32,riscv32_64,riscv64}_machine_interfaces
> >   hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
> >   hw/riscv: remove machines-qom.h
> >   configs/targets: remove target info definitions

> >   target-info: rename target-info-stub.c in target-info-def.c

Does that mean  target-info-def.c would be compiled N-times. N is the
target list count and finally linkage into a single binary?
How to choose this target-info?


> >
>
> Gentle ping after a week.
> You're welcome to review only your architecture if time is limited, and
> validate the global approach.
>
> Regards,
> Pierrick
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003540b306584cc64f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Jul 31, 2026 at 1:34=E2=80=AFAM Pierrick B=
ouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bo=
uvier@oss.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; On 7/23/2026 5:09 PM,=
 Pierrick Bouvier wrote:<br>&gt; &gt; Now that we can link a single-binary =
with at least two targets (arm, aarch64),<br>&gt; &gt; we want to make sure=
 that we expose the same set of machines (later devices and<br>&gt; &gt; cp=
us) than target binaries. For that, we implemented a static filtering based=
 on<br>&gt; &gt; target interfaces that each machine will implement to decl=
are which targets have<br>&gt; &gt; this machine.<br>&gt; &gt;<br>&gt; &gt;=
 However, we discovered that this static filtering is not enough. Indeed, s=
ome<br>&gt; &gt; machines and devices do not depend only on target, and the=
ir presence can depend<br>&gt; &gt; on Kconfig or host/target combination. =
Thus, our static approach can&#39;t work, and<br>&gt; &gt; we need somethin=
g more flexible.<br>&gt; &gt;<br>&gt; &gt; This series adds a new TYPE_TARG=
ET_SPECIFIC, that declare a single function<br>&gt; &gt; bool is_available(=
void). From there, any machine type (and later devices and<br>&gt; &gt; cpu=
s) can implement it to override their presence for each target.<br>&gt; &gt=
; We first replace the existing static mechanism with this, and once done, =
we<br>&gt; &gt; cleanup all the old interface. One nice benefit is that we =
can get rid of<br>&gt; &gt; config/targets/*.c files, which saves duplicati=
on.<br>&gt; &gt;<br>&gt; &gt; This series was tested by comparing list of m=
achines for all qemu system<br>&gt; &gt; binaries, before and after this ch=
ange, to make sure we don&#39;t introduce a<br>&gt; &gt; regression.<br>&gt=
; &gt;<div><br></div><div>I am also tracing for this. So what&#39;s the sha=
pe of the final command line?=C2=A0</div><div><br></div><div>Maybe we can a=
t least get arm/arm64/riscv32/risv64/riscv32-be/risv64-be to be in a single=
 binary.</div><div><br></div><div>The -be is needed because gdbstub would n=
eed this to get gdb working fine. so the endian mode is important. arm/arm6=
4 have nothing about be support yet, even though in spec also have</div><di=
v>=C2=A0</div><div><br></div><div><br>&gt; &gt; Pierrick Bouvier (27):<br>&=
gt; &gt; =C2=A0 include/qemu/target-info-qom.h: declare TYPE_TARGET_SPECIFI=
C interface<br>&gt; &gt; =C2=A0 hw/arm: implement TYPE_TARGET_SPECIFIC<br>&=
gt; &gt; =C2=A0 target-info: add target_riscv32 and target_base_riscv<br>&g=
t; &gt; =C2=A0 hw/riscv: implement TYPE_TARGET_SPECIFIC<br>&gt; &gt; =C2=A0=
 target-info: add target_config_multiprocess<br>&gt; &gt; =C2=A0 hw/remote/=
machine: remove unsupported arm target<br>&gt; &gt; =C2=A0 hw/remote/machin=
e: implement TYPE_TARGET_SPECIFIC<br>&gt; &gt; =C2=A0 target-info: add targ=
et_config_xen<br>&gt; &gt; =C2=A0 hw/arm/xen-pvh: implement TYPE_TARGET_SPE=
CIFIC<br>&gt; &gt; =C2=A0 hw/xenpv/xen_machine_pv: implement TYPE_TARGET_SP=
ECIFIC<br>&gt; &gt; =C2=A0 target-info: add target_config_nitro<br>&gt; &gt=
; =C2=A0 hw/nitro/machine: implement TYPE_TARGET_SPECIFIC<br>&gt; &gt; =C2=
=A0 target-info-qom: implement new machine filtering per target<br>&gt; &gt=
; =C2=A0 target-info-qom: use TYPE_MACHINE instead of target_machine_typena=
me<br>&gt; &gt; =C2=A0 target-info: remove target_machine_typename<br>&gt; =
&gt; =C2=A0 target-info-qom: add type_target_specific<br>&gt; &gt; =C2=A0 h=
w/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE<br>&gt; &gt; =C2=A0 hw/arm:=
 remove {arm,arm_aarch64,aarch64}_machine_interfaces<br>&gt; &gt; =C2=A0 in=
clude/hw/core/boards.h: add DEFINE_MACHINE_TARGET_SPECIFIC<br>&gt; &gt; =C2=
=A0 hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}<br>&gt; &gt; =C2=A0 hw/arm:=
 remove machines-qom.h<br>&gt; &gt; =C2=A0 hw/riscv: remove TYPE_TARGET_{RI=
SCV32,RISCV64}_MACHINE<br>&gt; &gt; =C2=A0 hw/riscv: remove {riscv32,riscv3=
2_64,riscv64}_machine_interfaces<br>&gt; &gt; =C2=A0 hw/riscv: remove DEFIN=
E_MACHINE_{RISCV32,RISCV64}<br>&gt; &gt; =C2=A0 hw/riscv: remove machines-q=
om.h<br>&gt; &gt; =C2=A0 configs/targets: remove target info definitions</d=
iv><div><br>&gt; &gt; =C2=A0 target-info: rename target-info-stub.c in targ=
et-info-def.c</div><div><br></div><div>Does that mean=C2=A0<span style=3D"b=
ackground-color:transparent">=C2=A0</span><span style=3D"background-color:t=
ransparent">target-info-def.c would be compiled N-times. N is the target li=
st count and finally linkage into a single binary?</span></div><div><span s=
tyle=3D"background-color:transparent">How to choose this target-info?</span=
></div><div><br></div><div><br>&gt; &gt;<br>&gt;<br>&gt; Gentle ping after =
a week.<br>&gt; You&#39;re welcome to review only your architecture if time=
 is limited, and<br>&gt; validate the global approach.<br>&gt;<br>&gt; Rega=
rds,<br>&gt; Pierrick<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>You=
rs<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000003540b306584cc64f--

