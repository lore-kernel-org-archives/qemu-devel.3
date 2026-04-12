Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA48E937E4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBveW-0005BK-DZ; Sun, 12 Apr 2026 10:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivien.leger@gmail.com>)
 id 1wBv8x-0000O2-6i
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 09:46:31 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vivien.leger@gmail.com>)
 id 1wBv8v-0006vP-8D
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 09:46:30 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-651c5d525f6so164138d50.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 06:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776001588; cv=none;
 d=google.com; s=arc-20240605;
 b=jdtddYOBAms2eZdUzRi2fn5SO77Os4aP3eUM6Q4Fg19Lo56u4T88laWwdLI7Koepef
 e/npi7VMSayCeiGfELnKwhTvkE6xXWTmgu9EpA+SBT7QqpChtGcbenCv1LfZYksn7t5K
 E1HfCNnxMT2QLDkhz9NiaXfkd0CD7xwYKZDPrzyHePaHttJNoH2rGjWOBgdGJVB4IYlY
 n53XYF9QJaeCGO6uOa/mizy2k01EgtGAxTby7dIbiFxhgCitwixoIigq1CCNuLAjU1NA
 g4B3hmba+TFUaeFrMEOG2qBYhqADwHIQUl8g7+KOgSRKR2IThyvzkw/RwCX3xrg8MmFA
 NLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LuycblBG4OatntN7O3mptYnh6pNK+VWRPkFlUJoyxJY=;
 fh=76RAnM4tYXvEX1Hqn2N0uxku3pB8Byh+Liy8T6gQkWw=;
 b=Mw06tvWvQyB/om/T0jbfLXA2/CH0XXfgeSa7twYTwVRMt+9cJnCeglwB2QcFHyRnjZ
 +wxPvFG+/glWrZvEw49kgWk1c9q5tVnOlDmKp0ama/tI4D5CisZNtNC8SXCm84c7WXCV
 FnlRtD9TeixTUO8V488Ax/43F3XSwAJNo1/2qrwZmkyvYrcnT19xl9Ay0sfbutJfV69J
 0D4l5PLBQOD+HvZ7o5Ho/dFYUK9yUN7ZgA+KLVbpRw/2i5DwSp4aZjr/IJrttIvZ7fTj
 trndggz0ndNgvtBIOvrV22GpcwbpDT7vuUHWN9nbdv1tEc8Ut26j6yzyGMWTt12l0Z0W
 yGoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776001588; x=1776606388; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LuycblBG4OatntN7O3mptYnh6pNK+VWRPkFlUJoyxJY=;
 b=h0Fv3s5PBpByNa1MqVV+uV2R7GyRnLM+Y+eiLxT7uwGTbVGj4r8PBSaMURx86AyLAi
 uXxbo5nb+nzcLsQi1urpd5IxDyzsXxoFAtF5TpHPVs3sqZl4bLbbHb7nivLgM92j3upS
 Slf5fuJDGbny6reZtB4s/OE4VeB4lc6HPwx2q4XVpfsN0TY8J1Cqb6hU4OQuG8XkuV7n
 QfzMf5THN1U+IQUdN1lBLHcBi5hQtWND16YecM+Su3Qre6c7ZqaHkQayS9PnzHLxrLPx
 06e0c6ExG22zQ+C4lSMFbu8ovyPTJHrdztAqud3Ekcu8KexL/hg1YHipt8XHiejPr82o
 JYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776001588; x=1776606388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuycblBG4OatntN7O3mptYnh6pNK+VWRPkFlUJoyxJY=;
 b=Fs/YinvfSHr+/aLXjLRZGLZQlFdsq4GbfWoXq8JIlVS6BD6W+Z8SL0ZijsSOvxUn/1
 K0vAz/LQFKe2tapRj/43dOk0CDfg8oo0ksBmVmpwvKi+lubFO8z8ktl5tWwfIECYYhF7
 /xGDiAjjTto0ofWnM2+dYbHuohlaEVh95hfC5SJYn/rXqU7I5V+779uauC9dm+KKLBws
 vHli3jncvzG6jI8WtXDxBCqM3lGpCoRutN8dZkilib2WVsKYFVLiKm15ClTLl8vN0iD/
 dDg6QRZabf1RkJN9nU2B37plXDXXEptZn7VDccu9952bkjlxhJUXVrlee7UAEwTKh+X5
 IQ7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YnXJuXW3kCSnse/2kIf59mIjyDiI0WMFOfrls6BoIhLQQv+qP0RIEBjsA9uTMKAN7aBCVvLW7JD+f@nongnu.org
X-Gm-Message-State: AOJu0Yy1Mu7yT8fzmGXevBJBHVXYJfwLv3IE7T1hqE/CaoQPZTvxDDy6
 3Ta52m6zfat+6Ngj82dhy6+jyBzDi9/N7W2u4Xz2MRWWtdYf+fMorszy7zQmWGMP4czqCop1/0y
 6EmWXMUz/iKXEaY9EOxUEYrWbYSE2ebQ=
X-Gm-Gg: AeBDiesQZForyE732Dm0thYXraLWV7Y089X6fMkFVHCpGr04uvqSoBiIWDM96iHi8DV
 qq+1BrSoiezu9pbx/Ls3XnauNC/Pv8YKnpsfalcGgzr0CkFjc4lmQgoMT8yP/5VNcrVUsFV7i1w
 5o8X+80n0jnbhxplk6ALEFchQTN3gBjstvl/2vxmhK0ZhudljoAHNrnLVJsjHa1A9hew+MRh63y
 kEvHpnWy9JD+5G7QtrOxuHu1P+w9r6jXPSsL1jCEwxJfNghuGXIb3RQB1gi9BQdvFcfld95jIgc
 JdCqiKa6phqnThwwxcfyQXMc+7BD7KN1q7LF5oaXdsjeCeHH6Tn5GdnYv+aANBMaIa1wIY4=
X-Received: by 2002:a05:690e:425c:b0:650:7a27:65db with SMTP id
 956f58d0204a3-65198ab491fmr6455106d50.20.1776001587664; Sun, 12 Apr 2026
 06:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260412134016.1640882-1-vivien.leger@gmail.com>
In-Reply-To: <20260412134016.1640882-1-vivien.leger@gmail.com>
From: Vivien LEGER <vivien.leger@gmail.com>
Date: Sun, 12 Apr 2026 15:46:14 +0200
X-Gm-Features: AQROBzDcXbkumMh8mqGsGyoR9sELx4VJPvKXt0WmgantVKXic-ji0tTHPb4vLc4
Message-ID: <CA+X=5Xj=MLSMnpKqfOMQFw7uRrHpTdgC3c2S1wt5VpWtaJ-X6Q@mail.gmail.com>
Subject: Re: [PATCH] hw/net/fsl_etsec: implement RCTRL[CFA] FCS stripping on
 receive
To: qemu-ppc@nongnu.org
Cc: shentey@gmail.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c0dd6b064f43975e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=vivien.leger@gmail.com; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 12 Apr 2026 10:19:06 -0400
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

--000000000000c0dd6b064f43975e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard the previous patch.
The RCTRL[CFA] bit reference was incorrect; CFA appears in the DFVLAN
register context, not RCTRL.
The patch needs further research before resubmission.
Sorry for the noise.

On Sun, Apr 12, 2026 at 3:40=E2=80=AFPM Vivien LEGER <vivien.leger@gmail.co=
m> wrote:

> The eTSEC hardware strips the 4-byte FCS from received frames by
> default (RCTRL[CFA]=3D0). When CFA=3D1, FCS is copied to the application
> buffer and bd->length includes it.
>
> Previously QEMU always included FCS in bd->length regardless of CFA,
> causing guests using the default RCTRL to receive 4 extra bytes per
> frame, breaking protocols that validate frame length (e.g. ARP).
>
> Fix by subtracting 4 from bd->length when RCTRL[CFA]=3D0 (default).
>
> Signed-off-by: Vivien LEGER <vivien.leger@gmail.com>
> ---
>  hw/net/fsl_etsec/registers.h |  1 +
>  hw/net/fsl_etsec/rings.c     | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/hw/net/fsl_etsec/registers.h b/hw/net/fsl_etsec/registers.h
> index f085537ecd..1766e39a1a 100644
> --- a/hw/net/fsl_etsec/registers.h
> +++ b/hw/net/fsl_etsec/registers.h
> @@ -103,6 +103,7 @@ extern const eTSEC_Register_Definition
> eTSEC_registers_def[];
>  #define RCTRL_PRSDEP_MASK   (0x3)
>  #define RCTRL_PRSDEP_OFFSET (6)
>  #define RCTRL_RSF           (1 << 2)
> +#define RCTRL_CFA           (1 << 11)  /* Copy FCS to application */
>
>  /* Index of each register */
>
> diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
> index 22660c32b8..38e27ad6d8 100644
> --- a/hw/net/fsl_etsec/rings.c
> +++ b/hw/net/fsl_etsec/rings.c
> @@ -442,6 +442,16 @@ static void fill_rx_bd(eTSEC          *etsec,
>              cpu_physical_memory_write(bufptr, padd, rem);
>          }
>      }
> +
> +    /* Strip FCS unless RCTRL[CFA] requests copy to application.
> +     * Per FSL eTSEC architecture (RCTRL field descriptions):
> +     * CFA=3D0 (reset default): FCS is checked and discarded by hardware=
,
> +     *   bd->length should not include the 4-byte FCS.
> +     * CFA=3D1: FCS is copied to the application buffer, bd->length
> includes FCS.
> +     */
> +    if (!(etsec->regs[RCTRL].value & RCTRL_CFA) && bd->length >=3D 4) {
> +        bd->length -=3D 4;
> +    }
>  }
>
>  static void rx_init_frame(eTSEC *etsec, const uint8_t *buf, size_t size)
> --
> 2.53.0
>
>

--000000000000c0dd6b064f43975e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please disregard the previous patch.<br>The RCTRL[CFA] bit=
 reference=20
was incorrect; CFA appears in the DFVLAN register context, not RCTRL.<br>Th=
e patch needs further research before resubmission.<br>Sorry for the noise.=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Sun, Apr 12, 2026 at 3:40=E2=80=AFPM Vivien LEGER =
&lt;<a href=3D"mailto:vivien.leger@gmail.com">vivien.leger@gmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The eTS=
EC hardware strips the 4-byte FCS from received frames by<br>
default (RCTRL[CFA]=3D0). When CFA=3D1, FCS is copied to the application<br=
>
buffer and bd-&gt;length includes it.<br>
<br>
Previously QEMU always included FCS in bd-&gt;length regardless of CFA,<br>
causing guests using the default RCTRL to receive 4 extra bytes per<br>
frame, breaking protocols that validate frame length (e.g. ARP).<br>
<br>
Fix by subtracting 4 from bd-&gt;length when RCTRL[CFA]=3D0 (default).<br>
<br>
Signed-off-by: Vivien LEGER &lt;<a href=3D"mailto:vivien.leger@gmail.com" t=
arget=3D"_blank">vivien.leger@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/net/fsl_etsec/registers.h |=C2=A0 1 +<br>
=C2=A0hw/net/fsl_etsec/rings.c=C2=A0 =C2=A0 =C2=A0| 10 ++++++++++<br>
=C2=A02 files changed, 11 insertions(+)<br>
<br>
diff --git a/hw/net/fsl_etsec/registers.h b/hw/net/fsl_etsec/registers.h<br=
>
index f085537ecd..1766e39a1a 100644<br>
--- a/hw/net/fsl_etsec/registers.h<br>
+++ b/hw/net/fsl_etsec/registers.h<br>
@@ -103,6 +103,7 @@ extern const eTSEC_Register_Definition eTSEC_registers_=
def[];<br>
=C2=A0#define RCTRL_PRSDEP_MASK=C2=A0 =C2=A0(0x3)<br>
=C2=A0#define RCTRL_PRSDEP_OFFSET (6)<br>
=C2=A0#define RCTRL_RSF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt;=
 2)<br>
+#define RCTRL_CFA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 11)=
=C2=A0 /* Copy FCS to application */<br>
<br>
=C2=A0/* Index of each register */<br>
<br>
diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c<br>
index 22660c32b8..38e27ad6d8 100644<br>
--- a/hw/net/fsl_etsec/rings.c<br>
+++ b/hw/net/fsl_etsec/rings.c<br>
@@ -442,6 +442,16 @@ static void fill_rx_bd(eTSEC=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *etsec,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_physical_memory_write(b=
ufptr, padd, rem);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 /* Strip FCS unless RCTRL[CFA] requests copy to application.=
<br>
+=C2=A0 =C2=A0 =C2=A0* Per FSL eTSEC architecture (RCTRL field descriptions=
):<br>
+=C2=A0 =C2=A0 =C2=A0* CFA=3D0 (reset default): FCS is checked and discarde=
d by hardware,<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0bd-&gt;length should not include the 4-b=
yte FCS.<br>
+=C2=A0 =C2=A0 =C2=A0* CFA=3D1: FCS is copied to the application buffer, bd=
-&gt;length includes FCS.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!(etsec-&gt;regs[RCTRL].value &amp; RCTRL_CFA) &amp;&amp=
; bd-&gt;length &gt;=3D 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bd-&gt;length -=3D 4;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void rx_init_frame(eTSEC *etsec, const uint8_t *buf, size_t si=
ze)<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div>

--000000000000c0dd6b064f43975e--

