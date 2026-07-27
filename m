Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32CFC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woR7y-0004Jr-0V; Mon, 27 Jul 2026 15:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1woR7v-0004Jb-Kl
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:36:39 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1woR7u-0002VL-0G
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:36:39 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51c928bf172so21952461cf.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785180996; cv=none;
 d=google.com; s=arc-20260327;
 b=JDJbdLkkOXnG7pP8gj1JqhtweS2rGUzxVUkqNkSbfvTJxWvlWZaRGKTTzDxmiQbvGI
 hpQh7ypquoqu+yh7zy1zc0twvGsiud2FnsK1pccgM9h7v93VOrzYacJagjSkGviwDhFs
 qF0+d4rWcZR66Cmq/qEUanuUQNcI4GoY/x2poGfGVcpHH1NKVL/BkAx73EPiGJ/uCc1V
 FUfTGIHyxi7oKjWM58tHRkrA9OSqRpdwgbt3CnqYe9Tz/+Q7dbjJb3hF63Q8dGWgbq08
 aetzJSivvTDrr+X8P/WYCOElw5ueyJhvOKC+MI+Y7BT9ZvBpGyJ2mZf+4ZiPAFs8TtHw
 YK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ayTIBS2qufII5YYI4nB6BsradVtiQtUxqIunYmwgjNE=;
 fh=UN3+rNWyPqgXD/KPFKhuoG2yPljyJjxrhzSm/dnPI+o=;
 b=E1wz+qRNdOR/t+O17dQ/CeGgSR09ZsYMtjqV6lfn9fv1JP1dAtoiCL2Y8agtADsVie
 vsPpCshwMIYEbHeSpbyi/jgsJQ+5F9G7tjXuusDwQENqaS8LzRXZNfzNoYmVuv8zYFyu
 UD+Kp8k6EXgXxEDVOvcUhCH2E8rbTtO1lK80St6PwyjPIwtb2iu81Gv+4KWdoaBlSEmy
 zSyZlYKMVrzIHXMjgWf1PuPj43d8D7hlhoL2+0fBynhNcOFB5AHxauxwPJkhjuoJUCjo
 YdB/11EtD7CHSMcVKB/7fChmwjxOjDb9Hlm9A6TYNfWQaSTdFlwst0w+rtrgAUTWCRoG
 RV2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785180996; x=1785785796; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ayTIBS2qufII5YYI4nB6BsradVtiQtUxqIunYmwgjNE=;
 b=jZwKvTV3hBtZ3GIdZd7fIq3SrBXp1837A+dt55yKWihKp9m6f+B8wyfY4M6Cwiz3o3
 eW00GbYApvK+Rszma9P5UPbutdVijg9YPSIGHMKUx6m49fXtR7r0Ekc1q06LGBt8Rm/K
 vbfCWp6+7t4yw19oglKmVGf9O5pi+qbrtP0uqvf3ZoBKAjm98bQs268qYC/In2bkRJiK
 5M194te1MHZiE9UUwHsMwpwHOkVdpmVoZQPNdbFfZ8YBDlcKhfaBdmBFQj2RyrPcnCdi
 jctXoNjk73TWVxp5dGwSboIlSEgArCOb+vQ5bzjCET4BM7GXgoClv9u2hjprQsEwweOY
 tR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180996; x=1785785796;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ayTIBS2qufII5YYI4nB6BsradVtiQtUxqIunYmwgjNE=;
 b=PMuUHRY3bbZWYsa4gQ+NInLysHQzPo+VOu2S6Rx1bQqJ1+9z/iReUBABa0ovb0WWKh
 Bl6Tb0/PF7F8595e9dx+h0w4H79IYEVDJyYydiTVFvaLhBCgX6wL0jrTsZwiQTtEfkrW
 K19Y3wt8pGP0Zj3pGIJKo/m9LkjlUGLA6t47dRFTF2b2gqGJVqF1kOTwvUz6VwyXZuyf
 1Nv3yx5ILa+hPzMFXdJ+w56VwBlflZyxJwfBYjCD7d2WncrkYhS/Cu7hNfupQPcFN5Vh
 +kC2OwFEFHCQfrH+3EVIkY8KDJYpPSzIl3JvBB6T8GmfBaaFLOAVqSPoZkhOr2ogj/U7
 Hk+Q==
X-Gm-Message-State: AOJu0YzLK6peChxvbRLt2+2S9LsLWdQhAEed57SCPfNJd6fKbyUh3Iz4
 6EudhdfECeEDsq6Qfi1f90GS7gnTmW9dNSZOKC3TIpMUj8oEWU9Pc+46DeGJFwvf5WJnFN9JV/7
 iQwcfnql8Adjl7hGo1+JTPP7LX3XwhxM=
X-Gm-Gg: AR+sD111n+j1BjYvJzq0rk2HTpBgmUGySOF8bGlYV6hXIWLSi/8KBzKWrl2ciFI3Lr+
 VVGqzmu6N0VxsG+sb/T/8nan8YWmjRWGxhzCahK9B8uJ2/nhjv2eHs2jSyiqG+4+C1uUTNdIBiB
 7EFQO3NUlG6szAQ3zI02Tze61hHZvEB8qdgeSHZUUEAE9nsNDuFZNH9X/33jUWyxG2BI049Nk09
 ge2glkwm27+x5hQqD0jMZqbV9hB1z1Sl790H+jmh8A9LeJoPOJDmz56wFtABpoeP1iWsw0dTw==
X-Received: by 2002:ac8:7d4d:0:b0:51c:7b12:5fec with SMTP id
 d75a77b69052e-529d1cc66ebmr9302481cf.88.1785180996529; Mon, 27 Jul 2026
 12:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260710222350.9185-1-sun4qemu@gmail.com>
 <7ed63c06-7f36-41bd-beae-2e7cef923a88@ilande.co.uk>
In-Reply-To: <7ed63c06-7f36-41bd-beae-2e7cef923a88@ilande.co.uk>
From: Dmitry Pimenov <sun4qemu@gmail.com>
Date: Mon, 27 Jul 2026 21:36:25 +0200
X-Gm-Features: AUfX_mzkHkHWcgssy_gjvVMeuPHWLvTult24nfarn9uSMhX7EDkjEC-3Xd7CjLI
Message-ID: <CAG8n5zzMoo6epshEucv=7F7S+_3vyDsTSXb+yJX7WxW8K9uv=A@mail.gmail.com>
Subject: Re: [PATCH] hw/sparc64/niagara: use int64_t for vdisk size to avoid
 truncation
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000028721d06579cd7a6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=sun4qemu@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000028721d06579cd7a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late follow-up
Answering directly since it's still an open question: the bug was found by
actually booting a >=3D2GiB pflash image against -M niagara and hitting the
exact symptom described: exit(1) before the CPU ever ran, no OpenBoot
output at all.
Tracing that to blk_getlength() returning int64_t while niagara_init()
stored it in a plain int came after, as the explanation for what was
observed, not before.

It helped advance the investigation into the bootability of the current
sun4v images, especially for Solaris 10 DVD, bigger than 2GiB - several of
those failed for exactly this reason before the fix.

Regards
Dmitry.

On Tue, Jul 14, 2026 at 11:46=E2=80=AFPM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 10/07/2026 23:23, Dmitry Pimenov wrote:
>
> > blk_getlength() returns int64_t, but niagara_init() stored it in an int=
,
> > truncating the if=3Dpflash virtual-ramdisk size for images >=3D 2 GiB. =
A ~4
> GiB
> > image truncated to 0/negative, failed the `size > 0` check, and exit(1)=
'd
> > before the CPU ran, ending with:
> >
> >    qemu-system-sparc64: could not load ram disk
> >
> > AI-used-for: code (bug fix)
> > Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
> > ---
> >   hw/sparc64/niagara.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> > index 1211ecb82d..ad5e5945a8 100644
> > --- a/hw/sparc64/niagara.c
> > +++ b/hw/sparc64/niagara.c
> > @@ -137,7 +137,7 @@ static void niagara_init(MachineState *machine)
> >          outside of the partition RAM */
> >       if (dinfo) {
> >           BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> > -        int size =3D blk_getlength(blk);
> > +        int64_t size =3D blk_getlength(blk);
> >           if (size > 0) {
> >               memory_region_init_ram(&s->vdisk_ram, NULL,
> "sun4v_vdisk.ram", size,
> >                                      &error_fatal);
> > --
> > 2.43.0
>
> Oh, curious - is this a static/AI analysis find, or are you actively usin=
g
> the sun4v
> emulation? Anyhow:
>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
>
> ATB,
>
> Mark.
>
>

--00000000000028721d06579cd7a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Sorry for the late follo=
w-up</div><div dir=3D"ltr">Answering directly since it&#39;s still an open =
question: the bug was found by actually booting a &gt;=3D2GiB pflash image =
against -M niagara and hitting the exact symptom described: exit(1) before =
the CPU ever ran, no OpenBoot output at all.=C2=A0</div><div dir=3D"ltr">Tr=
acing that to blk_getlength() returning int64_t while niagara_init() stored=
 it in a plain int came after, as the explanation for what was observed, no=
t before.<br><br>It helped advance the investigation into the bootability o=
f the current sun4v images, especially for Solaris 10 DVD, bigger than 2GiB=
 - several of those failed for exactly this reason before the fix.<br></div=
><div dir=3D"ltr"><br></div><div>Regards</div><div>Dmitry.</div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 14, 2=
026 at 11:46=E2=80=AFPM Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ay=
land@ilande.co.uk" target=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/07/=
2026 23:23, Dmitry Pimenov wrote:<br>
<br>
&gt; blk_getlength() returns int64_t, but niagara_init() stored it in an in=
t,<br>
&gt; truncating the if=3Dpflash virtual-ramdisk size for images &gt;=3D 2 G=
iB. A ~4 GiB<br>
&gt; image truncated to 0/negative, failed the `size &gt; 0` check, and exi=
t(1)&#39;d<br>
&gt; before the CPU ran, ending with:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 qemu-system-sparc64: could not load ram disk<br>
&gt; <br>
&gt; AI-used-for: code (bug fix)<br>
&gt; Signed-off-by: Dmitry Pimenov &lt;<a href=3D"mailto:sun4qemu@gmail.com=
" target=3D"_blank">sun4qemu@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/sparc64/niagara.c | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c<br>
&gt; index 1211ecb82d..ad5e5945a8 100644<br>
&gt; --- a/hw/sparc64/niagara.c<br>
&gt; +++ b/hw/sparc64/niagara.c<br>
&gt; @@ -137,7 +137,7 @@ static void niagara_init(MachineState *machine)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outside of the partition RAM */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dinfo) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BlockBackend *blk =3D blk_by_l=
egacy_dinfo(dinfo);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 int size =3D blk_getlength(blk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t size =3D blk_getlength(blk);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_in=
it_ram(&amp;s-&gt;vdisk_ram, NULL, &quot;sun4v_vdisk.ram&quot;, size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_f=
atal);<br>
&gt; --<br>
&gt; 2.43.0<br>
<br>
Oh, curious - is this a static/AI analysis find, or are you actively using =
the sun4v <br>
emulation? Anyhow:<br>
<br>
Acked-by: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co=
.uk" target=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt;<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div>
</div>

--00000000000028721d06579cd7a6--

