Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23D7C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 19:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weHg6-0002O8-Tn; Mon, 29 Jun 2026 15:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weHg4-0002NZ-Qi
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 15:29:57 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weHg2-0002oP-1P
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 15:29:56 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-30edbb0dc5fso625215eec.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 12:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782761392; cv=none;
 d=google.com; s=arc-20260327;
 b=JxBQc+CzwNKjNyzaU7pfNfTYKbJYWE4hmJ1qe1j5+M1PTe0uERhXBq9PbrB/MyNuAM
 j+KhwnO92ZZdv8gBuPDTNnChbWM6+53CGNAJEmQBiYzFgfRj5Wc7gj148S0O+VgmDskf
 LFUXF5cekIRSHNOfFNrJyGlLLcdtNenu3jcDmknajpQ97xB6sJNGWxGioyW4nVm0WTba
 qRQ7sB8xuBI0k8fCd9XJ/Lzj+dHL1rJEjaiIsCVSyFeh0ciM2kvhVTiDAegEFrdGF5t7
 vCldpJPkKLQeU4A3vMDHqqv6u4Pmt4hkYw/enatMlGGbWx5jwJh3h3GfcqRT/w10apTZ
 R0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DHdLpaNOUeUV+STUAjjaSBZ2VsTIednKSLRAdXIn0AU=;
 fh=82zpD1RtEqCMY3/SRL2aX0zH6U8M4k1HxcXx+amt/Z8=;
 b=cr8N3Bd2u5T3s4NomqltBn25aD4V6pmi+ImVNviPdEn42wLbxcQGtSSdeZZSOL76bq
 3APlQZtibnFd/+hIHeUImObRSgEzllXInivp/NyZBAbZPsWJHWrku4AIWT8xcV12LuKI
 X0xAgvPLw+1brU/OMrRO1JNzeIkLZZ7yc/ouzT90L3/BiEqWMXuTxvOFqbPfHVinsWK9
 PVW3rvXYapTEo7J/Tu4sbvRyjjBTypuqSseOznwW6Ci07ggEGtC7v9aDYNa5Z3M+vJ/x
 vd0IFgD+1R4teVA9PHsW6+J51bRla2WSFxhEdVhjjQA8WtBZLdwiPP+SPT+MG05NjVk3
 diOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782761392; x=1783366192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHdLpaNOUeUV+STUAjjaSBZ2VsTIednKSLRAdXIn0AU=;
 b=qkK0/Ufk+umB9awDV5jAfhLWfAeciClEL3vgLFgN+hIgNrRE2QSmKrbEpGO1PjPfsW
 /yzVWrPoD58mOhuiJJNju0w81y6FZCpEKGSTuxlN+00Co5zbfwcrcfPtlmqh8J+Uow12
 1DhLLyWIgVWRMqZDYv9Z5FAAWDqzwkHod11vMOdxCPzIQLuP/kvW86NAKfvyksHyk4cm
 oGy9L3HMeI1NKwt/63T9ULierDqkPjQzhOrsfBY7xQUwP2utv6+Ew71ZdGoojMDcMnnD
 w9kR3O9adnBNfsGCHH2OL1EMW2SE9VDOb+M+ASFVXMKQb54Ue+BZk1Kq4RZDpMC2HT0A
 0Skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782761392; x=1783366192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DHdLpaNOUeUV+STUAjjaSBZ2VsTIednKSLRAdXIn0AU=;
 b=GEQeyb7aEkm9cOCZBXljxLn8RKAHVoHwVR7kTcjt+LpJpgPr5l/tuBEFMnoc5dZV3W
 pRAxfAMeeRdJlQWGRwIpwXGYvH6haGHen3yF27PSRtpgIOx8nAcxkJaZ4j8aiyRQ6LEn
 5moXJdoKBIcqa+0fSQ3nQsrm2WYcCkNxxOqswAaGGdvaSAkkHrvL5YOoE4DP59UwfUBd
 IEtuz+cBtRvh+KUPlx5JUdL15D1+4P34LJUyhuTWQ/rlpKNc/PMkjIzyUTBlEH6pMuqc
 NL/cf5XD+oS/tzsYda12+c0VA8R+/OgV8w8Ba/gAVcWObtJroe9h678hTWcDegRk70JI
 cL4w==
X-Gm-Message-State: AOJu0YwBYNwrOOXW2GNtGrWBgbivJ63PwCfdPH6zx+Wil9Qyr/0SXBQC
 ic122qCvDLndxyUKjEV/thum0S+CvW5oErvaRxe5AmxOe3k7SL+dN1xndMiYBhJUgPIyqwNbs/b
 mm8j1ajBoxK7G8I0aBuVk3QC00ftU9pk=
X-Gm-Gg: AfdE7ckdyyDtAver3vq8yUvZURvpXPoSsMOpaSDqgMsYXFY8JNhsjtDWZf0+jkKxMkJ
 6D6d42w5ycPM0tdc7qEmb6EmtFILtF/FPtu/7csX1UpQUz6QR5Uc6fmC2YEkTTrt58qnsztGuIj
 4ne7/xwJVSL1bi28VZ3lGmXDk16E92FfuzpUN3p3b+BBLdXrHog8FXo403YbAxv9QFIbSLGZqL3
 LH4SVw0vnAtw1ucy/yVA6lQCzRDZ/GkEFAg0MEhJTyUzGTKDedcqkj6KynglL+BDVsGoIigUBMC
 UXawypfXkp/ZCpDxKB8FuT/YnsuNoi1Z0oN/pm8=
X-Received: by 2002:a05:7300:72c3:b0:30c:a942:c913 with SMTP id
 5a478bee46e88-30ee1346277mr487043eec.13.1782761391536; Mon, 29 Jun 2026
 12:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260623163535.366104-2-rclobus@rclobus.nl>
 <CAJ+F1C+3RF9q3HMntDFeNj+WPv0whPi8-6Uj-_mwKEfDriBq+A@mail.gmail.com>
 <0ae2e095-9fa2-4322-962d-3e7ad20367e2@rclobus.nl>
In-Reply-To: <0ae2e095-9fa2-4322-962d-3e7ad20367e2@rclobus.nl>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Jun 2026 23:29:38 +0400
X-Gm-Features: AVVi8CfAmc6uGtrZxBE6aAlcavpAZrz7pQO7guY3qtcaiCiEJqpTAh9eGaSImR0
Message-ID: <CAJ+F1C+9qTAO0ZLDypPhMdFdcxBc9a2sB87xRugCuuWP9qb4JA@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: Support the configurable EDID fields
To: Roland Clobus <rclobus@rclobus.nl>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Jun 29, 2026 at 7:20=E2=80=AFPM Roland Clobus <rclobus@rclobus.nl> =
wrote:
>
> Hello Marc-Andr=C3=A9,
>
> Thank you for the review. I will prepare changes based on the suggestions=
 in your next answer.
>
> On 29/06/2026 13:14, Marc-Andr=C3=A9 Lureau wrote:
> > On Tue, Jun 23, 2026 at 8:38=E2=80=AFPM Roland Clobus <rclobus@rclobus.=
nl> wrote:
> >>
> >> This patch adds support for the fields that are currently configurable
> >> in the function qemu_edid_generate.
> >>
> >> Signed-off-by: Roland Clobus <rclobus@rclobus.nl>
> >> ---
> >>   hw/display/virtio-gpu-base.c | 41 +++++++++++++++++++++++++++++++--
> >>   qapi/virtio.json             | 44 ++++++++++++++++++++++++++++++----=
--
> >>   2 files changed, 76 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base=
.c
> >> index a68b184829..5391189add 100644
> >> --- a/hw/display/virtio-gpu-base.c
> >> +++ b/hw/display/virtio-gpu-base.c
> >> @@ -69,9 +69,39 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int=
 scanout,
> >>
> >>       for (output_idx =3D 0, node =3D g->conf.outputs;
> >>            output_idx <=3D scanout && node; output_idx++, node =3D nod=
e->next) {
> >> -        if (output_idx =3D=3D scanout && node->value && node->value->=
name) {
> >> +        if (output_idx !=3D scanout || !node->value) {
> >> +            continue;
> >> +        }
> >> +
> >> +        if (node->value->vendor) {
> >> +            info.vendor =3D node->value->vendor;
> >> +        }
> >> +        if (node->value->name) {
> >>               info.name =3D node->value->name;
> >> -            break;
> >> +        }
> >> +        if (node->value->serial) {
> >> +            info.serial =3D node->value->serial;
> >> +        }
> >> +        if (node->value->has_widthmm) {
> >> +            info.width_mm =3D node->value->widthmm;
> >> +        }
> >> +        if (node->value->has_heightmm) {
> >> +            info.height_mm =3D node->value->heightmm;
> >> +        }
> >> +        if (node->value->has_xres) {
> >> +            info.prefx =3D node->value->xres;
> >> +        }
> >> +        if (node->value->has_yres) {
> >> +            info.prefy =3D node->value->yres;
> >> +        }
> >> +        if (node->value->has_xmax) {
> >> +            info.maxx =3D node->value->xmax;
> >> +        }
> >> +        if (node->value->has_ymax) {
> >> +            info.maxy =3D node->value->ymax;
> >> +        }
> >> +        if (node->value->has_refreshrate) {
> >> +            info.refresh_rate =3D node->value->refreshrate;
> >>           }
> >>       }
> >>
> >> @@ -237,6 +267,10 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
> >>       for (output_idx =3D 0, node =3D g->conf.outputs;
> >>            node && output_idx < g->conf.max_outputs;
> >>            output_idx++, node =3D node->next) {
> >> +        if (node->value->has_widthmm && node->value->has_heightmm) {
> >> +            g->req_state[output_idx].width_mm =3D node->value->widthm=
m;
> >> +            g->req_state[output_idx].height_mm =3D node->value->heigh=
tmm;
> >> +        }
> >>           if (node->value->has_xres !=3D node->value->has_yres) {
> >>               error_setg(errp,
> >>                          "must set both outputs[%zd].xres and outputs[=
%zd].yres",
> >> @@ -248,6 +282,9 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
> >>               g->req_state[output_idx].width =3D node->value->xres;
> >>               g->req_state[output_idx].height =3D node->value->yres;
> >>           }
> >> +        if (node->value->has_refreshrate) {
> >> +            g->req_state[output_idx].refresh_rate =3D node->value->re=
freshrate;
> >> +        }
> >>       }
> >>
> >>       g->hw_ops =3D &virtio_gpu_ops;
> >> diff --git a/qapi/virtio.json b/qapi/virtio.json
> >> index 1fc4e38a44..e1cd5864fe 100644
> >> --- a/qapi/virtio.json
> >> +++ b/qapi/virtio.json
> >> @@ -952,24 +952,54 @@
> >>   ##
> >>   # @VirtIOGPUOutput:
> >>   #
> >> -# Describes configuration of a VirtIO GPU output.  If both @xres and
> >> -# @yres are set, they take precedence over root virtio-gpu resolution
> >> -# configuration and enable the corresponding output.  If none of @xre=
s
> >> -# and @yres are set, root virtio-gpu resolution configuration takes
> >> -# precedence and only the first output is enabled.  Only setting one
> >> -# of @xres or @yres is an error.
> >> +# Describes configuration of a VirtIO GPU output.  Matches the fields
> >> +# of struct @qemu_edid_info.
> >> +# If both @xres and @yres are set, they take precedence over root
> >> +# virtio-gpu resolution configuration and enable the corresponding
> >> +# output.  If none of @xres and @yres are set, root
> >> +# virtio-gpu resolution configuration takes precedence and only the
> >> +# first output is enabled.  Only setting one of @xres or @yres is
> >> +# an error.
> >> +#
> >> +# @vendor: a 3 letter code for the vendor (since xx.x TODO)
> >>   #
> >
> > It should be uppercase. Validation is missing in qemu_edid_generate() t=
oo
>
> Agreed. The code does (ch - '@') & 0x1f), so even lowercase will work.
>
> I've focussed on adding the missing fields that are consumed by qemu_edid=
_generate, irrespective whether they were validated or not.
> I can widen the scope of this change request, to add the missing verifica=
tion of these fields.

thanks

>
> > We should also document the default values
>
> I can duplicate the default values from qemu_edid_generate. Should there =
be a comment in both files which recommends to keep both in sync?

a comment in the source code could help, but in general any documented
default value as a counterpart in the code

> >>   # @name: the name of the output
>
> Historically name was the first field in the struct VirtIOGPUOutput. Sinc=
e the scope of this change request is widening, can it now become an option=
al field, given that every other field can be changed independently?
>

I think this is backward compatible, so yes

> >>   #
> >> +# @serial: the serial number (since xx.x TODO)
> >> +#          must be numerical
> >
> > Then why do we accept a string? We should also fix qemu_edid_info then
>
> I was also wondering about that (but I tried not to touch the existing co=
de too much). By using uint32, it will never change its data type (and ther=
e will be no need for atoi in the generator code).
>

ok

> >> +#
> >> +# @widthmm: width of the display in mm (since xx.x TODO)
> >> +#           If @widthmm is set, @heightmm must be set too
> >> +#
> >> +# @heightmm: height of the display in mm (since xx.x TODO)
> >> +#           If @heightmm is set, @widthmm must be set too
> >
> > Setting one without the other would be weird. Maybe we should have a
> > struct with both fields mandatory?
>
> That would make the JSON to set the values slightly more complex, but doa=
ble. (I'm also working on a patch that does so, but that needs more work, a=
nd would be independent of this change request)
> But xres/yres will be an (the only?) exception to having a mandatory pair=
.

we can keep xres/yres for compatibility, but mark them as deprecated?

> >> +#
> >>   # @xres: horizontal resolution of the output in pixels (since 11.0)
> >>   #
> >>   # @yres: vertical resolution of the output in pixels (since 11.0)
> >
> > Same, but pre-existing.
>
> But here the situation is slightly more complex. If at least one of the p=
air xres,yres is set to zero, the display is considered inactive. So it wou=
ld be legal to only set one of them to zero or non-zero to turn the display=
 off or on (enabled_output_bitmask)

we could still mandate both xres/yres to be set in the new struct

>
> I have a local patch in preparation to allow modifications, but that need=
s some more work. It is not a blocker for this change request.
> If that patch is ready, one can modify all fields of this struct on-the-f=
ly, simulating the (dis)connect of a new display to the VM.
>
> FYI that would eventually allow something similar to:
> ```
> qom-set -j /machine/peripheral/vga001 outputs [ { "yres": 768, "name": "A=
AA", "widthmm": 40, "serial": "42", "heightmm": 30, "vendor": "IVM", "xmax"=
: 2048, "ymax": 1536, "refreshrate": 50000, "xres": 1024 }, { "yres": 768, =
"name": "DDD", "widthmm": 1000, "serial": "43", "heightmm": 750, "vendor": =
"RHT", "xmax": 1024, "ymax": 768, "refreshrate": 60000, "xres": 0 } ]
> ```
>
> But that's not in scope for this change request, where setting the widthm=
m/heightmm values will be able to trigger HiDPI scenarios.
>

I see, well you could make this part of the same series imho

> >>   #
> >> +# @xmax: maximum horizontal resolution of the output in pixels
> >> +#        (since xx.x TODO)
> >> +#
> >> +# @ymax: maximum vertical resolution of the output in pixels
> >> +#        (since xx.x TODO)
> >
> > Same
>
> If you prefer a struct of two elements, the names for the value-pair-stru=
ct could become: `resolution`, `maxresolution`, `sizemm`. Please say your p=
reference.

wdyt Markus?

> >> +#
> >> +# @refreshrate: refreshrate in mHz (since xx.x TODO)
> >> +#
> >>   # Since: 10.1
> >>   ##
> >>
> >>   { 'struct': 'VirtIOGPUOutput',
> >> -  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
> >> +  'data': { '*vendor': 'str',
> >> +            'name': 'str',
> >> +            '*serial': 'str',
> >> +            '*widthmm': 'uint16',
> >> +            '*heightmm': 'uint16',
> >> +            '*xres': 'uint32',
> >> +            '*yres': 'uint32',
> >> +            '*xmax': 'uint32',
> >> +            '*ymax': 'uint32'
> >
> > It changes the existing xres/yres fields type.
> > Is it necessary to accept uint32?
>
> g->req_state[0].width (and height) are uint32_t in virtio_gpu_requested_s=
tate, and passed along in the generator code as uint32_t, so I updated the =
struct to match that.
>
> But in the end only 16 bits are used in qemu_displayid_generate (`stw_le_=
p(did + 12, 0xffff & (xres - 1));`)

I think we should stay u16, if that's what EDID is limited to

>
> >> +            '*refreshrate': 'uint32' } }
> >>
> >>   ##
> >>   # @DummyVirtioForceArrays:
> >> --
> >> 2.53.0
>

thanks


--=20
Marc-Andr=C3=A9 Lureau

