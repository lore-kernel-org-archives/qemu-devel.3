Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D18C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6E50-0001m7-A2; Mon, 14 Sep 2026 17:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6E4s-0001jz-JI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:19:04 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6E4q-0002bx-Fd
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:19:01 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fe517774so32849845ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789420739; cv=none;
 d=google.com; s=arc-20260327;
 b=Fd0j5RA3bzxB7mONVGgKp30rnWwFOwFYeZ+r0EF5XTYikm/dJqC7WvFWxXnusX2K9w
 9Xy9S7CK+n/e6gPWYa4K086F0/ZZqLQC1iN/Od/r6dWL3vhyHARkxFtJl3X1EPkbulFk
 m07CU6jmCTkweKuO4X3uSfY2K3CSRaVDEAwPICsFVdNrB0x2zEuRKJVKsYXDrkMauXBt
 WbUuu3a5FD/gSPTgoElbvRfVLR1DV19/sqvHui0mELHT8liLLqMy9E0GE1DKDwvJ3qW2
 475QRdSexmiTRCT745+j9PYeRHrc5BCMtYoJxAsPQpBNeL0ODSucqMa0Y2kt8akNptYg
 ABlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gNO7VZEcWoAnc0780M+mT7IknwLGew5HaCpPcoHsttA=;
 fh=1Jp0KdhqtyfxbCjclbABrQtBrJrCg/j6MU64w81r97g=;
 b=CvADU9PrRtesXHdqoY9uYwyW48gKrvcN4k8q/RDXirr8R4QkVi1hPk+ATJ5euyPCre
 OnQOHrcCjOq0NghCxMEajwBYOEX4K6JW7bJKb5Ur+S1X4JynVy6ZxQCvImFOX3UuEYkG
 DwVwR5cy7wYaNuoD5ymWuclJXeDMdb+jSharyjBiunx5RfBpX2r+XbjiUAAsuSi5L4G9
 dcBT5qUwJ52ktFdnegdSlHlc/61CXp7DMORfkBdWFxKHkXMo/j6UwaRTPT/92pxHpf7e
 VmhUfrNWZ9QsA8qkmH4Di8lh3S6W69kMTKEOIWRiiqRI3JdFsKusy14NBTzvzF0bhXAp
 GUEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789420739; x=1790025539; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gNO7VZEcWoAnc0780M+mT7IknwLGew5HaCpPcoHsttA=;
 b=Y9rLKguoUs1ADFG3+Hb5Gz4SMDbegoi+QCknoQmtmM+pmbpl58JeQZ13IAgv/CqEhG
 Gt+g9HJdcO5WkPtaHnYskCeS0UF7Hy4DWPkeDeEdErp8yo3DhdfIO+OAYCGT1/aWTD/U
 KCA/iDsgiehaQcvlpfRGDWm0BS28WoZwlF2OqHnBoYUqK1rTc8PVwmKU816AkaU+FhCd
 XWlBYM+p5bNC5BvK1y5tdyG1Psm4AXtXRviCsvFL5nFMb5SquoBXK9DWXyeU5qnfFrXy
 GjzkOWOyt3eW61+fV5dm4YTe0IhTENLdkb/ycPUQRE7D+pwtLooLyMvLRcAl2fEnvEmD
 T5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420739; x=1790025539;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gNO7VZEcWoAnc0780M+mT7IknwLGew5HaCpPcoHsttA=;
 b=fShxIvomPN49DLuSCsLYZFk07TpGn1sBrsgkQdgTigI8Sex+sjhrQUZAQ6TyVWr9D6
 jIugaf+9OML6lVNsOHu8LypRjOxXC7fDkBnte1/BcRLcFbrU4tGJwXXKopwOEC0TQHKw
 3ROe4tSNBHM6aDLDRaO/2zgGQTS6XuTrTtgnLJl6I/Xi7RFVD1H2+DyNaIt38Rg7TXBC
 pcKYgxZAyHkLyj9KhLu9sVHgf5Bsg7ZSqBAERD4JIiPLfjxqr/yRPVLdfebD7f29E6nU
 PdDMxDHhXShwSWGUHZr06qwJB2KYMjLzvokjOBT2piv8OF5oN5tdFEv9YggPxmUvf6eQ
 rbFw==
X-Gm-Message-State: AFuF++mcD685+XdotyGcJ1BjYa7V8NdezATe6igewOfsfg3kyJpvNM7X
 qk0NXYFAypScPCftzPo492iHE09Jtzign8E7+L4xJ7qPJtmEbW+ddnqPDXMPXrtNrMi98INct30
 9KG1Qdu0Jd3zyBbd57g28WXIu90to4mIWMoFDCM8=
X-Gm-Gg: AYBFou3vUIl7B7NnW643Rq/hYdgPX3vo1EF7ZDRC7HGt6Gb0bc+Oy8N464OjmuYtQ9P
 cRGWkdoWP8RP1cwRoyR2nETrSG7JfdMAp5SQ8BPgamWdeV1IrrENXIuOHxs55dGOa4eVI9bioE5
 PavVCGniiCIELOEsezkyI2gZjRg5JJntmcRKW/Cv9a0vhfn3ZauUua9P+vMBX+RoMKRpxNxmZxZ
 AhHx76e66k0kL1uI5noBymYpxjwutRaWeXkejlGmcOi+qt9x2YME4HfyMlQCCkdPt5EH8JFzlgE
 ERdvzgrnn7zjzrsnV/sZcL0Cr/+PanGnBPdbVXyPvKGaGtDgg8i+lIDSSIS/Ge+kMXw7D9/RnYo
 GfscJdy3SRUk=
X-Received: by 2002:a17:903:2281:b0:2d6:fd55:3a9d with SMTP id
 d9443c01a7336-2dd6c5c121bmr80994415ad.3.1789420738769; Mon, 14 Sep 2026
 14:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-10-ltaylorsimpson@gmail.com>
 <CAJ+KCYNu_Ba5OdvmRMfcNkHY-jO2pxSkD+EVHe=DyOm-6CrzAA@mail.gmail.com>
In-Reply-To: <CAJ+KCYNu_Ba5OdvmRMfcNkHY-jO2pxSkD+EVHe=DyOm-6CrzAA@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 14 Sep 2026 15:18:47 -0600
X-Gm-Features: AcwNN1XNFyIFCGcvojYrjic-xaeObftqRf31PYpG6k0SIG-W7HKXhYvJ8WHWaCk
Message-ID: <CAATN3NopKuBi0=MFwAGcUyhxEctCRAmvsugEmdhYNcvhLXA=QQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] Hexagon (target/hexagon) Check for sreg
 multiwrite in analyze_packet
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="0000000000007cf85e065b77fbf2"
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj2-x10.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000007cf85e065b77fbf2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:00=E2=80=AFPM Marco Liebel <marco.liebel@oss.qual=
comm.com>
wrote:

> On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gm=
ail.com>
> wrote:
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >  target/hexagon/translate.h | 11 +++++++++--
> >  target/hexagon/translate.c |  4 ++++
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> > index eb0d10d686..b90f7fff1c 100644
> > --- a/target/hexagon/translate.h
> > +++ b/target/hexagon/translate.h
> > @@ -51,6 +51,8 @@ typedef struct DisasContext {
> >      DECLARE_BITMAP(gregs_multi_write, NUM_GREGS);
> >      int sreg_log[SREG_WRITES_MAX];
> >      int sreg_log_idx;
> > +    DECLARE_BITMAP(sregs_written, NUM_SREGS);
> > +    DECLARE_BITMAP(sregs_multi_write, NUM_SREGS);
>
> Do `sregs_written` and `sregs_multi_write` need to be cleared in
> `clear_pkt_ctx` like the other bitmaps?
>

Yes, I caught this when fixing the test-functional failures Brian pointed
out.

Taylor

--0000000000007cf85e065b77fbf2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 14,=
 2026 at 2:00=E2=80=AFPM Marco Liebel &lt;<a href=3D"mailto:marco.liebel@os=
s.qualcomm.com">marco.liebel@oss.qualcomm.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On Fri, Sep 11, 2026 at 5:08=
=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com" =
target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gma=
il.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/hexagon/translate.h | 11 +++++++++--<br>
&gt;=C2=A0 target/hexagon/translate.c |=C2=A0 4 ++++<br>
&gt;=C2=A0 2 files changed, 13 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h<b=
r>
&gt; index eb0d10d686..b90f7fff1c 100644<br>
&gt; --- a/target/hexagon/translate.h<br>
&gt; +++ b/target/hexagon/translate.h<br>
&gt; @@ -51,6 +51,8 @@ typedef struct DisasContext {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DECLARE_BITMAP(gregs_multi_write, NUM_GREGS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int sreg_log[SREG_WRITES_MAX];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int sreg_log_idx;<br>
&gt; +=C2=A0 =C2=A0 DECLARE_BITMAP(sregs_written, NUM_SREGS);<br>
&gt; +=C2=A0 =C2=A0 DECLARE_BITMAP(sregs_multi_write, NUM_SREGS);<br>
<br>
Do `sregs_written` and `sregs_multi_write` need to be cleared in<br>
`clear_pkt_ctx` like the other bitmaps?<br></blockquote><div><br></div><div=
>Yes, I caught this when fixing the test-functional failures Brian pointed =
out.</div><div><br></div><div><span style=3D"background-color:transparent">=
Taylor</span>=C2=A0</div></div></div>

--0000000000007cf85e065b77fbf2--

