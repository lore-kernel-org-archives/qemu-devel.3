Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE0CC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmxrf-0003Ax-Pd; Thu, 23 Jul 2026 14:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wmxrc-0003AP-Mv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:09:45 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wmxra-0000le-Vl
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:09:44 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-51a868b6962so1317291cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 11:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784830182; cv=none;
 d=google.com; s=arc-20260327;
 b=O+TTRhBo8vgo1FZ+TKF4SAU794dQk24Ty7ev5bCS42oZtYJC//f21Td7BYXDrK9EXo
 aN2S54cPMxOTI4USOrOOU+419cZIkWM0cnaQ09z5Z509Lre4cR2C5gkRITkzfILuMNeR
 tCD6FHZ92arfF+NKMxlHCuOo0piNJ2LIhN7K+e1aHWIfJauiw6ot9KrDXwfNwe+joivV
 kZQgfxcw0opO1Cy6sbW8hg8SzsZbr5xORwMy71To+HJ8Xlca4BFEL+tS02sPDo0KbwYD
 XHZY7caROGDYRI6150grHoARXqe6uTcEoDiiAGUnB6IETYu1DbiCiC3ltWUf/TGmIXH3
 CG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZdHfwo/c2fNDIFGr28EVTHPKSRnKfCLdEAnOGn9hiag=;
 fh=cPe4IYHTtn1ykOOCqzMT2uM2XMFKbV/uhYZBiShF70I=;
 b=XnVa9WUEoPH2FjY70Mw46saIiMTrn//60r3T7dSvq4Spzz7Y02Y2O5qXUVSxYb9UA0
 YFhaUL6FTbvTOAUuaLeKU/mBP7vf0dLcrqekNcmdnOafe8v+hkSgruevgdLUpPcx0rGc
 WSIbvL+zfT41r/HTfxOgQOsYGEHPNdCLmLaFlPuI+VbMyuaHyt9OpOHuvAuFZ/59jLS/
 HabZcNz8CAPWCSjG0ZaU64vwNOikoPxYU8H3OADqDMA2GKot5TYKI9a3EVn6G/oALclV
 O+uLOIEkUh3dg5z/55AdjVMjSnz6ruzJxXqpnvTrZ8Tf0mg0I+ecNSR+3Aoz5rLsqv29
 hU+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784830182; x=1785434982; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZdHfwo/c2fNDIFGr28EVTHPKSRnKfCLdEAnOGn9hiag=;
 b=Mpqv1aqjITQdJDoLmhBXhp3OA65spkkdf7JR14dBmVBmaZnqmXygcXkLIUu9lMwibu
 tugL4dky89EjcdM1j+VtvSM40DwTFN2Mn7KSL+e2UkXWr08exIW2f6MBOOe32lByfL37
 uYTxnw/2a8s1Z9xhMPLYraeAhAXB1/xVxs5XkLp8fdbyXXtBS1oAWz7Tm9viRMvfWtsS
 nRIzMvw+wqGTKunGqv43LrRHohuRiQ6/wUJPgbW9+5r+htlvnIjWP5uXlYFzhcNek8SM
 Nd/8/beHmj6++KpZ+U4ZjvweJPAWq7Qd2H5hBcCHnFUrWVcPNDWUwmH4ksRQvYx5hVRX
 zxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784830182; x=1785434982;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZdHfwo/c2fNDIFGr28EVTHPKSRnKfCLdEAnOGn9hiag=;
 b=U2BM8YI79aqAbDUM8Ru98ioVlKd6vOqk6Ob/cvpAoOJbUtMljyKXmQAetUsWwDWbua
 R/LM5B0u4NTIXQa1ZTq0nDw3fMRILulkgZESzZpdLElNZe1BbK4PpZuMPOEhs4+eDA89
 VapcUH3g8ZNZafA2IkrzO9P6JyuKC9mvjn0FBxp4RkefiWQGSKu1NzuY+W0oyKGsSSUd
 LvpOuVyhqwinZ3BmYS/amlErHHV/sT6VOqgu28OtL+Bu9uhP3so0T+iNaaG+esDms86G
 DHyV8hsJd9khWsH7uFCUjEovZIEtuDtDDxMGvNh5E0rCLmHIVnQaRXZ0DRSKC9oCr0mD
 CXeg==
X-Gm-Message-State: AOJu0YxjpH3Q/Q2qWz4shPJqQ4FtxGk6HYoQIZNrTHY/8Bo7Op19lZ+V
 wL9xi5TH56D4sZCid/Z9oRyfs9yoxMFwsQCBJJsBL2jJ2E0ZNKesZWv+dziygPVSvwMoFww7cJR
 i/gRKNlH74UR+AXnKutcI4QuwfImtUU8=
X-Gm-Gg: AR+sD10JKGlNTBGwlnELx0Tbw9IIgP5r7T85AVx8Nujp+c3jrONYI21vGGw8VQ+ypAS
 ttthn9acjRLCGjCFj1XZwsaKLEE1MIazWmAhdtRXUy9qhw75/uYBc+ynsEhIDaUqEC+QiE5uuyG
 C+y2+FW8PonkoRyq0aTdIB81LVDofAtxXcZYSYN/Tt8PMK2aw5APIA0zA0Hivnt+MzxugZxSNRZ
 1yx+DiLLe+crzfjiMRL6KqvFGVNWY2U/YH6UEOm10Q3WlXdUo6hUyHMIC5+iseXPJgAucMlTReM
 ZS8J2dUcYyGgJIc9w9k=
X-Received: by 2002:a05:622a:1b24:b0:51c:511:c5 with SMTP id
 d75a77b69052e-5283dda2c1bmr40831561cf.16.1784830181780; Thu, 23 Jul 2026
 11:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260722200951.553764-2-connorkite@gmail.com>
 <CAJSP0QWQwxCYL+xCOZNoNUSEXHdekSkEvGmcyThkVk3Od0=a5w@mail.gmail.com>
In-Reply-To: <CAJSP0QWQwxCYL+xCOZNoNUSEXHdekSkEvGmcyThkVk3Od0=a5w@mail.gmail.com>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 11:09:30 -0700
X-Gm-Features: AUfX_mzfF7NxWNTJ7Cl08TJIaEhK0cdwsFLMPN9eJ2Iu_d2VUsKeQtzalw__bjk
Message-ID: <CA+spn3qk+ab-Xqtfd-WV+Eow7FO4TfSbus4fWEtBvXZQ4Ok2FA@mail.gmail.com>
Subject: Re: [PATCH] util/iova-tree: gapless map
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000f8321306574b28d9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f8321306574b28d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Confirmed that your suggested root cause makes sense.  I did the following:
  1.   Reverted the changes to iova-tree on my end
  2.   Subtracted 1 from `needle.size` in `vhost_svq_translate_addr`
  3.   Refactored the vhost-user memory isolation code to use
inclusive size when dealing with vhost-iova-tree
  4.   Confirmed that region mapping and data transfer in isolation mode
have the same level of functionality

I was finishing up the RFC patch series for vhost-user isolation mode when
I saw your message, so I will update svq there, rendering this patch to
iova-tree unnecessary.

Thanks!
Connor

On Thu, Jul 23, 2026 at 7:05=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

> On Wed, Jul 22, 2026 at 4:11=E2=80=AFPM Connor Kite <connorkite@gmail.com=
> wrote:
> >
> > iova-tree prevents mapping of overlapping ranges, but range checks
> > inflate the effective size of regions by 1 byte, resulting in gaps
> > between regions in the iova address space.  If there are alignment
> > requirements for regions in the iova space, this can throw them off.
> >
> > Adjust range checks to allow adjacent regions with no gap between them.
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >  util/iova-tree.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
>
> I think iova-tree is fine as-is and the root cause is
> vhost_svq_translate_addr() treating size as an open interval rather
> than a closed interval.
>
> The "qemu/iova-tree.h" DMAMap struct documents the size field as
> "Inclusive" (i.e. closed interval where the size only goes up to the
> last byte included in the interval) and the code touched in this patch
> was written with that in mind.
>
> Looking at other iova-tree users in the source tree, they all use size
> - 1 (closed interval), which is consistent with the iova-tree API.
>
> If you fix vhost_svq_translate_addr() to use a closed interval, then
> no changes to iova-tree are necessary. I think this approach is
> preferrable since this patch otherwise breaks the other iova-tree
> users (vhost-vdpa, intel_iommu, amd_iommu).
>
> By the way, I suspect the fundamental reason to use a closed interval
> is that the entire address space can be covered (e.g. HWADDR_MAX)
> using hwaddr or uint64_t. The open interval representation requires a
> larger type or a special case (e.g. treating ~0 differently) to cover
> the entire address space.
>
> Stefan
>

--000000000000f8321306574b28d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Confirmed that your suggested root cause makes=C2=A0sense.=
=C2=A0 I did the following:<div>=C2=A0 1.=C2=A0 =C2=A0Reverted the changes =
to iova-tree on my end</div><div>=C2=A0 2.=C2=A0 =C2=A0Subtracted 1 from `n=
eedle.size` in `vhost_svq_translate_addr`</div><div>=C2=A0 3.=C2=A0 =C2=A0R=
efactored the vhost-user memory isolation code to use inclusive=C2=A0size w=
hen dealing with vhost-iova-tree</div><div>=C2=A0 4.=C2=A0 =C2=A0Confirmed =
that region mapping and data transfer in isolation mode have the same level=
 of functionality</div><div><br></div><div>I was finishing up the RFC patch=
 series for vhost-user isolation mode when I saw your message, so I will up=
date svq there, rendering this patch to iova-tree unnecessary.</div><div><b=
r></div><div>Thanks!</div><div>Connor</div></div><br><div class=3D"gmail_qu=
ote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Ju=
l 23, 2026 at 7:05=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanh=
a@gmail.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Wed, Jul 22, 2026 at 4:11=E2=80=AFPM Co=
nnor Kite &lt;<a href=3D"mailto:connorkite@gmail.com" target=3D"_blank">con=
norkite@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; iova-tree prevents mapping of overlapping ranges, but range checks<br>
&gt; inflate the effective size of regions by 1 byte, resulting in gaps<br>
&gt; between regions in the iova address space.=C2=A0 If there are alignmen=
t<br>
&gt; requirements for regions in the iova space, this can throw them off.<b=
r>
&gt;<br>
&gt; Adjust range checks to allow adjacent regions with no gap between them=
.<br>
&gt;<br>
&gt; Signed-off-by: Connor Kite &lt;<a href=3D"mailto:connorkite@gmail.com"=
 target=3D"_blank">connorkite@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 util/iova-tree.c | 26 +++++++++++++-------------<br>
&gt;=C2=A0 1 file changed, 13 insertions(+), 13 deletions(-)<br>
<br>
I think iova-tree is fine as-is and the root cause is<br>
vhost_svq_translate_addr() treating size as an open interval rather<br>
than a closed interval.<br>
<br>
The &quot;qemu/iova-tree.h&quot; DMAMap struct documents the size field as<=
br>
&quot;Inclusive&quot; (i.e. closed interval where the size only goes up to =
the<br>
last byte included in the interval) and the code touched in this patch<br>
was written with that in mind.<br>
<br>
Looking at other iova-tree users in the source tree, they all use size<br>
- 1 (closed interval), which is consistent with the iova-tree API.<br>
<br>
If you fix vhost_svq_translate_addr() to use a closed interval, then<br>
no changes to iova-tree are necessary. I think this approach is<br>
preferrable since this patch otherwise breaks the other iova-tree<br>
users (vhost-vdpa, intel_iommu, amd_iommu).<br>
<br>
By the way, I suspect the fundamental reason to use a closed interval<br>
is that the entire address space can be covered (e.g. HWADDR_MAX)<br>
using hwaddr or uint64_t. The open interval representation requires a<br>
larger type or a special case (e.g. treating ~0 differently) to cover<br>
the entire address space.<br>
<br>
Stefan<br>
</blockquote></div>

--000000000000f8321306574b28d9--

