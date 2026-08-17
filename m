Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64389C5DF74
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 22:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww5Y9-0005Cq-VG; Mon, 17 Aug 2026 18:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ww5Y8-0005BT-GG
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 18:11:20 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ww5Y2-0001k7-3n
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 18:11:15 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so6507034a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 15:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787004672; cv=none;
 d=google.com; s=arc-20260327;
 b=FMh86/A3WJRZMRETA2HkEwy637hY/DI/BioEryYuYNcD96MLtFhMvbVUM1Ta6ChuOk
 hLZOgFKjnY74JwN7wOCK4sISwF/drjRc1RUq0AvstDMDAj0tM4kRwLmiXoNWaCzFSFjb
 OrnDAX1qJJPqDx3jlnKhba04shOC9SKB5qibc2tOosb61yCFlbFQSOWYotsWTL2V9poJ
 EhKQi7J9RqA8DsRDzQbCJcmP/rTqQcKfpukbvoCaHKciWaYC+EO3eCU72WZvRL2cP8Z+
 U5SBWGGlHGy5wsxSdROryrnE8rY7JyswM9ihyvlEp+cwDgFnwa1u+nFFsRYFU5SEUP/s
 3Abg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Gh7F8Sc6hcNZbhTDeDcutoFD6Xl8QSGKQhbUmXSqTpM=;
 fh=Hc4nTEoqBmpagp52CnE1iGejF/+FU8/z8k5ZvtHWLzs=;
 b=rq0w2JqDrtXxVB7WLcje7K43ZVPxno7DfIHUxIE1i7NeMsn5TfqGswgfQpGXy/ID4q
 tljJokH9pdCEmtlV36J0EbjAEGKUyOOyAjz5ZTPs2kcFohgbksa3b0en1wjcqCy8Pg0x
 iBSLuaShkpK0gL6Jnr9VO5eG4Lj830nxBSF2yb3TPP17yJV0wNJIRjP/GYW+aEZmmrmD
 acvTe5oHLlwbdmeKio85wRmnWogh6TF9K8Gnk/tHxbdONfC7WknNkeYOQt2IpVPLUI40
 /g6flCqFlYXWyXF1ufBDQuhqvZ1Y2Tqs7xHGRwTcNHg7Djifcrx7A6Q/NPqb4GoxAcRZ
 5VwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787004672; x=1787609472; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gh7F8Sc6hcNZbhTDeDcutoFD6Xl8QSGKQhbUmXSqTpM=;
 b=GLg2pPJRgSvCTud51AoF8G64oKB1YZJL1Rry4lUi8gl1QyAnms4Olkxj1L/GxDiLTx
 hnU3LxAo091sJqtGQnWcjAmN2gDCae2dqVctsoI+p23aBn3Rvj4J3/7RCiaDcYLTZWYM
 ZgYQ6pu7pgybqc1wVIHyG3O/5GRAV9YJy6hjgJx3vct6CdKBJk4j8ZNWKNvCf92CHy++
 tM7Wo5Tra1gEGc7DxXzeJp0BMuM/O9jmjHUm8OUIjYLY8EouJYR3+XfPbemcAi4Ze8b4
 Hm3aAZ1cqzNFXbiyKjIcnGs0552EFiPbhp6Cg+kGqCaPD7BQBV67yyNFK1SvB7vAAft7
 gFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787004672; x=1787609472;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Gh7F8Sc6hcNZbhTDeDcutoFD6Xl8QSGKQhbUmXSqTpM=;
 b=DWQkGinbTuYAIKzbP+gGyhWIdEzoVyJN4uQhxXzUJH70LuXReWWTUqa1uzg7K4UxqT
 Ssux+nv/uktVUK9+p6T0VFGO2LJ5sZm5aPcfo2SDVFQqM9TpMzqpsVc47OVPIU9j0alb
 Z81iilPf7wW9ySUlnOv6VMXBuJWmjDMMGgIRhZmYuMJW46Jscoua3Hm/9wbRbao14Y9L
 NZfd+dySz2G5CWEYO+wBRtiCvtxMdS73JCkwVZoyfF49hBpv8yPPHiMdsMoy5dxHaBgU
 BoIxzvmR8UqqcTXurx2koiJRrfgkqADy5xkLA1WfyaLNZcqbB1Fwc6aduR5wJcH1UD6q
 07Sw==
X-Gm-Message-State: AOJu0YwItlks240U8iWmeX9lWbVeRmFaqGEZD56AB1zJFuO/85Hhy7PC
 i9JbqYdzOjh8ZioQOAPkS6Ghf6/oz3fpIQIP3QT4LqcaHSRHwoInj20vaAOzbE4KbSPitc+q4+u
 6brBsKGprVBUNkxEn1jppFcONvw+zK5M=
X-Gm-Gg: AR+sD127F91tfwnlAPez0EISvqiyth0YiNG06b88pqMt1lXIMyw/4JtVM5B/+DA247+
 flKqmiFjH+0YpIcrJqXKtW9dcAoOtFMnbaTU/n0/+ep3EqY1MyPAq9QuY24pP/HTdiaQj4496qH
 Yg/HIPouCV+nG3vr7OOaA4k/iKWVbFCSrXM+wuBRB/lOd+5lXswbGkMY15tBoTgusFxGxVreBtp
 vDOMdbchBrRk/suas3ygicyTaPP+kDHxICEwdzGBMBMJA8T//Ly+DU98IPwbmmdtvz21eQEkrou
 Bb2VqSsMROa/3XYPULPie8GJQVM7lJCtmEjGCm1eZMaXJD67MldSabjyoromaHwhLgeyAM50edT
 Lq4HuXHvyzsfK
X-Received: by 2002:a17:907:7289:b0:c1f:1520:56d4 with SMTP id
 a640c23a62f3a-c212a87882fmr1255171266b.27.1787004672044; Mon, 17 Aug 2026
 15:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260808153057.2641831-1-connorkite@gmail.com>
 <CAJSP0QUdZ36+oU9bHu+rYx8m03Ld7oBWjzNqKKLmX04gFqZocQ@mail.gmail.com>
 <CA+spn3rO3+ag_raj+TDtrwarfSABcLP4ROo5_SaeH4=VVpGV_w@mail.gmail.com>
In-Reply-To: <CA+spn3rO3+ag_raj+TDtrwarfSABcLP4ROo5_SaeH4=VVpGV_w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 17 Aug 2026 18:11:01 -0400
X-Gm-Features: AcwNN1XA5BP35UOr3lbDO189BbEiFSBSIjjSXjhiDC9yaWQXwI9HamfyhQBCNXI
Message-ID: <CAJSP0QWoytPOGqVhgPr7=apwabqqQorCDStrFwa6PFwRgq0nbQ@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost-shadow-virtqueue: range boundary in
 translation
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Hanna Czenczek <hreitz@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: multipart/alternative; boundary="000000000000b072fe06594572f2"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

--000000000000b072fe06594572f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026, 16:59 Connor Kite <connorkite@gmail.com> wrote:

> On Sun, Aug 9, 2026 at 5:46=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> >
> > On Sat, Aug 8, 2026 at 11:32=E2=80=AFAM Connor Kite <connorkite@gmail.c=
om>
> wrote:
> > >
> > > iova-tree expects inclusive range sizing when maps are allocated or
> searched.
> > > Currently, svqs use exclusive sizing when searching their
> > > vhost-iova-tree for a match to the region to be translated.  This cou=
ld
> > > lead to errors if the region to be translated is at the edge of an io=
va
> > > region.
> > >
> > > Fix this by reducing `needle.size` by 1 in
> > > vhost_svq_translate_addr to bring it in line with DMAMap and iova-tre=
e
> > > convention.
> > >
> > > This patch is an updated version of one from the patch series
> "vhost-user:
> > > isolated memory".  The patch has been isolated from the series as it
> > > is not tightly coupled with the rest of the series.
> > >
> > > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > > ---
> > >  hw/virtio/vhost-shadow-virtqueue.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> b/hw/virtio/vhost-shadow-virtqueue.c
> > > index bcb7f2ffc7..c8831d52be 100644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -99,19 +99,25 @@ static bool vhost_svq_translate_addr(const
> VhostShadowVirtqueue *svq,
> > >          const DMAMap *map;
> > >          DMAMap needle;
> > >
> > > +        if (unlikely(iovec[i].iov_len =3D=3D 0)) {
> > > +            qemu_log_mask(LOG_GUEST_ERROR,
> > > +                          "Zero-sized buffer made available by
> guest");
> > > +            return false;
> > > +        }
> > > +
> > >          /* Check if the descriptor is backed by guest memory  */
> > >          if (gpas) {
> > >              /* Search the GPA->IOVA tree */
> > >              needle =3D (DMAMap) {
> > >                  .translated_addr =3D gpas[i],
> > > -                .size =3D iovec[i].iov_len,
> > > +                .size =3D iovec[i].iov_len - 1,  /* Inclusive */
> > >              };
> > >              map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle=
);
> > >          } else {
> > >              /* Search the IOVA->HVA tree */
> > >              needle =3D (DMAMap) {
> > >                  .translated_addr =3D
> (hwaddr)(uintptr_t)iovec[i].iov_base,
> > > -                .size =3D iovec[i].iov_len,
> > > +                .size =3D iovec[i].iov_len - 1, /* Inclusive */
> > >              };
> > >              map =3D vhost_iova_tree_find_iova(svq->iova_tree, &needl=
e);
> > >          }
> >
> > It looks suspicious that only the vhost_iova_tree_find_gpa() calls are
> > modified, so I checked to see if other users of svq->iova_tree treat
> > .size as inclusive or exclusive. There is only one user,
> > hw/virtio/vhost-vdpa.c, and it treats .size as inclusive. This is not
> > obvious from the patch, but it does indeed make everything consistent.
> > (It would be helpful to include this kind of context in the commit
> > message in the future.)
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Resending a message that was accidentally sent just to Stefan:
>
> Yes, I think you will recall that I was also confused about the use of
> inclusive sizes in iova-tree, and exclusive sizes virtually everywhere
> else that does not touch iova-tree.
>
> For clarity, is it worth making a REV2 of this patch with an updated
> message?
>

It would be nice if you could do that. Thanks!

Stefan

>

--000000000000b072fe06594572f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 17, 2026, 16:59 Connor Kite =
&lt;<a href=3D"mailto:connorkite@gmail.com">connorkite@gmail.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sun, Aug=
 9, 2026 at 5:46=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@=
gmail.com" target=3D"_blank" rel=3D"noreferrer">stefanha@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; On Sat, Aug 8, 2026 at 11:32=E2=80=AFAM Connor Kite &lt;<a href=3D"mai=
lto:connorkite@gmail.com" target=3D"_blank" rel=3D"noreferrer">connorkite@g=
mail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; iova-tree expects inclusive range sizing when maps are allocated =
or searched.<br>
&gt; &gt; Currently, svqs use exclusive sizing when searching their<br>
&gt; &gt; vhost-iova-tree for a match to the region to be translated.=C2=A0=
 This could<br>
&gt; &gt; lead to errors if the region to be translated is at the edge of a=
n iova<br>
&gt; &gt; region.<br>
&gt; &gt;<br>
&gt; &gt; Fix this by reducing `needle.size` by 1 in<br>
&gt; &gt; vhost_svq_translate_addr to bring it in line with DMAMap and iova=
-tree<br>
&gt; &gt; convention.<br>
&gt; &gt;<br>
&gt; &gt; This patch is an updated version of one from the patch series &qu=
ot;vhost-user:<br>
&gt; &gt; isolated memory&quot;.=C2=A0 The patch has been isolated from the=
 series as it<br>
&gt; &gt; is not tightly coupled with the rest of the series.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Connor Kite &lt;<a href=3D"mailto:connorkite@gmail=
.com" target=3D"_blank" rel=3D"noreferrer">connorkite@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/virtio/vhost-shadow-virtqueue.c | 10 ++++++++--<br>
&gt; &gt;=C2=A0 1 file changed, 8 insertions(+), 2 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost=
-shadow-virtqueue.c<br>
&gt; &gt; index bcb7f2ffc7..c8831d52be 100644<br>
&gt; &gt; --- a/hw/virtio/vhost-shadow-virtqueue.c<br>
&gt; &gt; +++ b/hw/virtio/vhost-shadow-virtqueue.c<br>
&gt; &gt; @@ -99,19 +99,25 @@ static bool vhost_svq_translate_addr(const Vh=
ostShadowVirtqueue *svq,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const DMAMap *map;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMAMap needle;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(iovec[i].iov_len =3D=3D=
 0)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUES=
T_ERROR,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Zero-sized buffer made available by guest=
&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the descriptor is b=
acked by guest memory=C2=A0 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpas) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Search the GPA=
-&gt;IOVA tree */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 needle =3D (DMAMa=
p) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .tr=
anslated_addr =3D gpas[i],<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =
=3D iovec[i].iov_len,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =
=3D iovec[i].iov_len - 1,=C2=A0 /* Inclusive */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 map =3D vhost_iov=
a_tree_find_gpa(svq-&gt;iova_tree, &amp;needle);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Search the IOV=
A-&gt;HVA tree */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 needle =3D (DMAMa=
p) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .tr=
anslated_addr =3D (hwaddr)(uintptr_t)iovec[i].iov_base,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =
=3D iovec[i].iov_len,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =
=3D iovec[i].iov_len - 1, /* Inclusive */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 map =3D vhost_iov=
a_tree_find_iova(svq-&gt;iova_tree, &amp;needle);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; It looks suspicious that only the vhost_iova_tree_find_gpa() calls are=
<br>
&gt; modified, so I checked to see if other users of svq-&gt;iova_tree trea=
t<br>
&gt; .size as inclusive or exclusive. There is only one user,<br>
&gt; hw/virtio/vhost-vdpa.c, and it treats .size as inclusive. This is not<=
br>
&gt; obvious from the patch, but it does indeed make everything consistent.=
<br>
&gt; (It would be helpful to include this kind of context in the commit<br>
&gt; message in the future.)<br>
&gt;<br>
&gt; Reviewed-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
<br>
Resending a message that was accidentally sent just to Stefan:<br>
<br>
Yes, I think you will recall that I was also confused about the use of<br>
inclusive sizes in iova-tree, and exclusive sizes virtually everywhere<br>
else that does not touch iova-tree.<br>
<br>
For clarity, is it worth making a REV2 of this patch with an updated messag=
e?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">It would be nice if you could do that. Thanks!=C2=A0</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Stefan</div><div dir=3D"auto"><div class=3D"=
gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
</blockquote></div></div></div>

--000000000000b072fe06594572f2--

