Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD213FD4F16
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 19:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w02Tj-0001Kg-74; Tue, 10 Mar 2026 15:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w02Ti-0001KY-3b
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:10:50 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w02Td-0000JS-LL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:10:48 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5a0ff30b240so7746413e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 12:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773169842; cv=none;
 d=google.com; s=arc-20240605;
 b=D71r7JF7tZqjMWInU4r6ozazVsArWU9igiTyW2D0hmv3BVCLrlsf5ADTOF1MWz6IT6
 wImsPMU1OK+xk+P9NcABs78SgcCkHm/kKez8P9+4sgFP69Q4IVhUxloyvurxPu3F42Np
 KF44hC92PPrdIkHRw1mSNJyi7rXFBe4AtWyySWeaQIQJg3RueBN6ZkJkfci3+8YXHIfS
 1FdG3VDtTuVORFkh+mIcboKdoPJI0RLC6S2se6X28SbBBBSARd3AVovNz2hCWVecd8//
 CY5i2yC/HEN+pPTxhNgG6cj4dY2Q/YJA2Ecd+0q4rLMcqcungJG2P3ODLMdY8ya5K1gy
 ov6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e5zdUCkQhIe+TLb2SKW2FMd4RjIDwAxV0FFgbxT7NqU=;
 fh=u1Ij6bqTkRwlP6tLRnDLstdHrbkURegmsm1iNMNy/YQ=;
 b=Pk0PUKkk+xSGJUVLKGfARRKIVP/JLGuHyxi4ALSDGkRRH8IhESV3puitl4YxeWnXOU
 y1lboqWMnp433vFaBttAQP2HQ5LgWuiE/NqCVawFxzG+xQyJmY++lkOH1vxtP5E5tACT
 kZKX3ZbO65G0LXeFjqkvHrENej8GVWOYq+PQGosG+POPSdDeYnj6VEzI77B8LaxxhblE
 v/6yMLHFeTxXGLtjMelM/Qj5VzmNOeviAVBJiWENGeG7jIAhRCd6oWuOXjuXVx240MKX
 F2vQPILaJucdlgWyxbHePhaVJcCWj/WCDQgUwoW52Hpj0PrwR+kr2InrL7bl4YATNSSt
 olXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773169842; x=1773774642; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e5zdUCkQhIe+TLb2SKW2FMd4RjIDwAxV0FFgbxT7NqU=;
 b=DtN2vJPM6LMgUWf9p20tmgHSHablcyF+dS/uzijXg+tLFVg71VRt2PZzjuDSewmOWD
 n86pmoTRtTW2XGacc4fQik8za7jnEI+n+kVE2gaeaGaAvHQxxzsvvqJ97EOr1vjfYjEM
 gfsJB4DeuHW6iff8JeXXOy++vdWvRLL6Vc96iYiUCAr6sLGhJZozbIrNzZzIApanTMFD
 Zgl5yo/oSD+Z+AKch72BwzkkeX/f2Irm4YlTqfyC0c7xljl+IhG1O9l9n45YaXGshIRD
 WU0ybHAP5KMitSBwTzwMR318N4VtEIvJQhkmKyrJ9e/rb6HurTzGW3Hcsl1Ms1lQw+nr
 a/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773169842; x=1773774642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5zdUCkQhIe+TLb2SKW2FMd4RjIDwAxV0FFgbxT7NqU=;
 b=kmCAU4CL2FZxj4+sQQ9rQXgXcV+sWVS4BTab7jg/l31mIsZF19VBo3XpzccIUOFKbw
 rADa45WBVwvP8FyOvdU5TtauaOY0gfvKuSfQC9jGzwF8l1MDzXYYRvCRg8j/NC4HUEKk
 JePI58C3cx8pzQQtCabflCArP0feBmHAmerOngj/wbsHFPLToDCrtLaCEYQG4n5j1jmr
 EWh2aTqWwZ3Zz6nUat1F4h0bTT3ECYuPYghLbxpcQdo0iHEKykpfhIY/0fnHlvrSVq/A
 0vjzhfGnDEcES94eL15zSnAySGicEyG3atDGhPoe8ruEZ93viZ8SZvJC6irvmwhJj6NU
 bf4w==
X-Gm-Message-State: AOJu0YxTmNbegJwJtZPJYfnnZ1u3mcYB8mAVMbPVl0QrWyHBOrzm0Rll
 qc3015tTWvARUUgtBThqyZTOpSzIahhlBVI4OdaonO475vVGt5JtJbRTQy672nCD2kD7DVVZWkV
 n5Z2TAEDydjPOYhVYC2Po/K7PnUrVPI8=
X-Gm-Gg: ATEYQzzuRxHpWmX4cSq0+QLdtGo9Jz8MimPR+Cs9yR31gwqm6kURgJ1Eop/A7MQkDCz
 jquSW5Z1ZnfhCIeiqPzEngQamKlzvkJ3E8MccfhKakZuHtuIeyw/QJVNPeCZFO+5uK9pakzz3rO
 vHIk9+OArUJLOh29t69O6sHQBUCox4kWxdnZyUbcFuuD3rrV9+8vKaSkn1wQLQ0jNkI3uEgE6jz
 IYoDJxdaf0e6XOB1ICVL1jRrk7YT827qI2s2MNyg+Y3ehkNiP4BjsuemfqiPep1psVFN2uQc+PN
 yK/y/t6lT0DZYxMCJdYfW5uP9w/9IEpxNZJspfdJ
X-Received: by 2002:a05:6512:6098:b0:5a1:3350:77a6 with SMTP id
 2adb3069b0e04-5a13ccf2c20mr5371196e87.27.1773169841913; Tue, 10 Mar 2026
 12:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-2-viking4@gmail.com>
 <9a658ec5-a167-4d0a-a08b-50ea90c40be0@linux.ibm.com>
In-Reply-To: <9a658ec5-a167-4d0a-a08b-50ea90c40be0@linux.ibm.com>
From: Trieu Huynh <vikingtc4@gmail.com>
Date: Wed, 11 Mar 2026 02:10:25 +0700
X-Gm-Features: AaiRm51X2icmrzk7P2Vo3-qEPpAQzgPd60FfFZ4Aqe5FjYh3RqP2Fiaf9RvfBDs
Message-ID: <CAMO1v35taymndjHKk1FqdnECoD_vZNZAihcEmeK4h_vrh93bYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/core/loader: fix error handling for
 load_image_targphys callers
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008dc349064cb046a8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=vikingtc4@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000008dc349064cb046a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I was missed on that change.
Pls ignore patch 1/4.

BRs,

V=C3=A0o 02:02=E2=80=AFAM T.4, 11 Th3, 2026 Aditya Gupta <adityag@linux.ibm=
.com> =C4=91=C3=A3 vi=E1=BA=BFt:

>
> On 10/03/26 23:57, Trieu Huynh wrote:
> > From: Trieu Huynh <vikingtc4@gmail.com>
> >
> > Check return value of load_image_targphys() and return early on
> > failure instead of continuing with invalid state.
> > - Use ret < 0 to handle negative return value.
> > - No functional changes.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> >
> > <...snip...>
> >
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 1513575b8f..aecffb211b 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1068,14 +1068,21 @@ static void pnv_init(MachineState *machine)
> >           exit(1);
> >       }
> >
> > -    load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
> > -                        &error_fatal);
> > +    if (load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZ=
E,
> > +                        &error_fatal) < 0) {
> > +        error_report("Could not load OPAL firmware '%s'", fw_filename)=
;
> > +        exit(1);
> > +    }
> >       g_free(fw_filename);
> >
> >       /* load kernel */
> >       if (machine->kernel_filename) {
> > -        load_image_targphys(machine->kernel_filename,
> > -                            KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
> &error_fatal);
> > +        if (load_image_targphys(machine->kernel_filename,
> > +                        KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
> &error_fatal) < 0) {
> > +            error_report("Could not load kernel '%s'",
> > +                         machine->kernel_filename);
> > +            exit(1);
> > +        }
> >       }
> >
> >       /* load initrd */
> > @@ -1084,6 +1091,11 @@ static void pnv_init(MachineState *machine)
> >           pnv->initrd_size =3D
> load_image_targphys(machine->initrd_filename,
> >                                                  pnv->initrd_base,
> >                                                  INITRD_MAX_SIZE,
> &error_fatal);
> > +        if (pnv->initrd_size < 0) {
> > +            error_report("Could not load initrd '%s'",
> > +                         machine->initrd_filename);
> > +            exit(1);
> > +        }
> >       }
> >
> >       /* load dtb if passed */
> >
>
> Thanks for the patch, but as balaton said, atleast in this case, the
> condition is not needed since it's have error_fatal.
>
> Previously the if checks you added used to there, these were recently
> changed to not have the conditions,
> by this patch from vishal:
>
>      commit cd274e83d50ba52ede62d2a8ea0f0ae7cb1ef469
>      Author: Vishal Chourasia <vishalc@linux.ibm.com>
>      Date:   Fri Oct 24 18:36:03 2025 +0530
>
>      hw/ppc: Pass error_fatal to load_image_targphys()
>
>      Pass error_fatal to load_image_targphys() calls in ppc machine
> initialization
>      to capture detailed error information when loading firmware, kernel,
>      and initrd images.
>
> Thanks,
>
> - Aditya G
>
>
>

--0000000000008dc349064cb046a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br></div><div>Sorry, I was missed on that change.</=
div><div dir=3D"auto">Pls ignore patch 1/4.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">BRs,</div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">V=C3=A0o 02:02=E2=80=AF=
AM T.4, 11 Th3, 2026 Aditya Gupta &lt;<a href=3D"mailto:adityag@linux.ibm.c=
om">adityag@linux.ibm.com</a>&gt; =C4=91=C3=A3 vi=E1=BA=BFt:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br>
On 10/03/26 23:57, Trieu Huynh wrote:<br>
&gt; From: Trieu Huynh &lt;<a href=3D"mailto:vikingtc4@gmail.com" target=3D=
"_blank" rel=3D"noreferrer">vikingtc4@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Check return value of load_image_targphys() and return early on<br>
&gt; failure instead of continuing with invalid state.<br>
&gt; - Use ret &lt; 0 to handle negative return value.<br>
&gt; - No functional changes.<br>
&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/413=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-p=
roject/qemu/-/issues/413</a><br>
&gt; Signed-off-by: Trieu Huynh &lt;<a href=3D"mailto:vikingtc4@gmail.com" =
target=3D"_blank" rel=3D"noreferrer">vikingtc4@gmail.com</a>&gt;<br>
&gt;<br>
&gt; &lt;...snip...&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c<br>
&gt; index 1513575b8f..aecffb211b 100644<br>
&gt; --- a/hw/ppc/pnv.c<br>
&gt; +++ b/hw/ppc/pnv.c<br>
&gt; @@ -1068,14 +1068,21 @@ static void pnv_init(MachineState *machine)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 load_image_targphys(fw_filename, pnv-&gt;fw_load_addr, =
FW_MAX_SIZE,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 if (load_image_targphys(fw_filename, pnv-&gt;fw_load_ad=
dr, FW_MAX_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &amp;error_fatal) &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Could not load OPAL fi=
rmware &#39;%s&#39;&quot;, fw_filename);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(fw_filename);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* load kernel */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (machine-&gt;kernel_filename) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 load_image_targphys(machine-&gt;kernel_fi=
lename,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, &amp;error_=
fatal);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (load_image_targphys(machine-&gt;kerne=
l_filename,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, &amp;error_fatal) &lt; 0)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Could no=
t load kernel &#39;%s&#39;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0machine-&gt;kernel_filename);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* load initrd */<br>
&gt; @@ -1084,6 +1091,11 @@ static void pnv_init(MachineState *machine)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pnv-&gt;initrd_size =3D load_i=
mage_targphys(machine-&gt;initrd_filename,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pnv-&gt;initrd_base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 INITRD_MAX_SIZE, &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pnv-&gt;initrd_size &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Could no=
t load initrd &#39;%s&#39;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0machine-&gt;initrd_filename);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* load dtb if passed */<br>
&gt;<br>
<br>
Thanks for the patch, but as balaton said, atleast in this case, the <br>
condition is not needed since it&#39;s have error_fatal.<br>
<br>
Previously the if checks you added used to there, these were recently <br>
changed to not have the conditions,<br>
by this patch from vishal:<br>
<br>
=C2=A0=C2=A0 =C2=A0 commit cd274e83d50ba52ede62d2a8ea0f0ae7cb1ef469<br>
=C2=A0=C2=A0 =C2=A0 Author: Vishal Chourasia &lt;<a href=3D"mailto:vishalc@=
linux.ibm.com" target=3D"_blank" rel=3D"noreferrer">vishalc@linux.ibm.com</=
a>&gt;<br>
=C2=A0=C2=A0 =C2=A0 Date:=C2=A0 =C2=A0Fri Oct 24 18:36:03 2025 +0530<br>
<br>
=C2=A0=C2=A0 =C2=A0 hw/ppc: Pass error_fatal to load_image_targphys()<br>
<br>
=C2=A0=C2=A0 =C2=A0 Pass error_fatal to load_image_targphys() calls in ppc =
machine <br>
initialization<br>
=C2=A0=C2=A0 =C2=A0 to capture detailed error information when loading firm=
ware, kernel,<br>
=C2=A0=C2=A0 =C2=A0 and initrd images.<br>
<br>
Thanks,<br>
<br>
- Aditya G<br>
<br>
<br>
</blockquote></div>

--0000000000008dc349064cb046a8--

