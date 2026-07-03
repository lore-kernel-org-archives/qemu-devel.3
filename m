Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F334CC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfWIT-0004QB-Vp; Fri, 03 Jul 2026 01:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wfWIE-0004Oh-9c
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 01:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wfWI9-0004ET-QM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 01:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783055897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFfpKc0idGVNyr1/R9WbJqpWatca7gY9B0oTT38BRY4=;
 b=D/z7/HCGDextA3VisV3noKWue6ShKyJfZv7ejd6aaAPpui8YM3NUIIsmk/bhOwnolsjM4x
 mC4nTNAkGjGfG86Jy753ZK0pR+Yc+qbVZuf0vQFkzOgkLryPkrqKCaYdeESvIX4w/Zu65d
 mxzcIw06TC9LXF9tbV2JsK/kImQD4/k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-kuQLMefQOvi73V99zr3C8g-1; Fri, 03 Jul 2026 01:18:15 -0400
X-MC-Unique: kuQLMefQOvi73V99zr3C8g-1
X-Mimecast-MFC-AGG-ID: kuQLMefQOvi73V99zr3C8g_1783055895
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92aea0d801dso17393385a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 22:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783055895; cv=none;
 d=google.com; s=arc-20260327;
 b=EL9qEWQllRgXpVHK7/fCTFRDNEgjVPPoN6KVJD3+/p6PPk9sxPds0M7bJ1iHGY2fMv
 bPmvgNfg2Jnn19ktQ7aZliRdCs1IcUVvDiT6hq94jTsURzSRK+kDW21uwjf+lr7L1nU+
 nN1BqQOcHIxAQdJmN7QbL0YBbMFa51RMeM5cmpwqACLW6DEGszPcR7jR0YGwOGfBqmL5
 7Ryv3y/KLThM1zc7+t6c7saSWeA50zdEcb4TaIPlAwYLOrW6chNfvWh7ilroq1hCanA/
 WnYNfgP2NAwLeAclVxA5NkXRv/cmz2FkhSZgtp2XufdC8wmlOb+1EdR9AxsUYF62NTzf
 tHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PFfpKc0idGVNyr1/R9WbJqpWatca7gY9B0oTT38BRY4=;
 fh=AtlRYeJmQS4sJ58PPAmdQuWMsgCnbfVwePFN0L8H/Ww=;
 b=cVBuhNnlXeyHkAQiWKXYyj3b6VPyLs4n3+ii+67GGZ6ObAEU7NzfbmHQSzt7vW5BZn
 VMVgaWvCMnAIKw0JxBv0vaL7hgaVcfM55w5EA5GNyZsOyMLi11CvN/1G7ITMFVt31NGw
 BKP34b3qbd2/YPX/VVX4yyFug0yYSLFOTHxiBi2rjGXbwVUU5mLiF74Si9jl7vMMUbrF
 +tMp4przLHGPC8tpfmRghZazCAA9kAvWH6/dtySDq2YRwn/C/4yhTdJo5Vp/JlgAbM57
 CraWs9hu4tw0VVWqU8eybcxwRAinO1WKjKqHqCrL0f9+mEewDbD/YW3uwC+bc10WekIl
 JnFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783055895; x=1783660695; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PFfpKc0idGVNyr1/R9WbJqpWatca7gY9B0oTT38BRY4=;
 b=JcbWvmrk3bp5MFQDyBjQReWvdJJPd0eC2Ary2/BfIUsZ4fqP3N9RhfAL/l0ku7gdMO
 3Q9A5fqmciKwtWyAisp4/7aak2kmQnpl22mnvYMO2mJt7SAoByGrHDoh7CGSFlNdstH9
 OiuLfeju2Y3Ou3eAFFcFJQOUKX346ljUdL6kWPfDB7c6sfn80XAgG/PVX5a6UnJkpIah
 GSNUhKMVPs+7cE9eFR2evDPYHyOIjvGUL126iRQDoryWD9r/0/qYiyZkAd3RgJR9P9si
 SIkjhpaTOWEQyen3eGmJ+87oXeRv/CEeFJvTsxzF5qdDca53i51JG2lhIUDuVaP34oj2
 CwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783055895; x=1783660695;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PFfpKc0idGVNyr1/R9WbJqpWatca7gY9B0oTT38BRY4=;
 b=Y+9xuT34oL+oWRjAzAjC0JB19zjJX1ELhTUt56TZ5r2mjNZJu2MTRDKOymGg6k5ve3
 54LGXeiQvwyNYfOPFWJzEKA6rBBETNlr4AEiH+jXLXWxLcdkuFfpJU7Xi0fvuV5yDghH
 gEOUYnyuzsIdWWll0SsyegaTLWFbpM7fE78MsgJyMe8Er782Aw7SXuZnp8KA05eex53J
 /n4zQRciLLhh9GWp8i8sdMq5RtxUBL2v/2WZZO8cZNkzbpCoVBsnW5ABdmTcs3rm+nrn
 mn7onmYwXMA6jRp8WQGh4RJCk+EjMpLwqlNyZk1EAwmoHMizUfMZwBoTsiLzBq0L1eze
 DsWw==
X-Gm-Message-State: AOJu0YxDfbleBG+IEGTqFL7RVVAturmf6ojnoPwoo7QXOKmPrcUXzQC8
 94dr+MF2kD7n5JpbLR2++fnByFNopFFS0Q54mSgR7ww/8vUVoWR7sNDPPiYLIdohYJavwH+Du4O
 d/yGK83pgE2thAy6c5Nr61Ts1BCBvHjNRbOPBcQkHlJw5OLCG/0CcD16amDzVa4tcYWe30iFb3F
 PsjqlL1St2Kv3O4Os1zgIbZOaeGOKbw/U=
X-Gm-Gg: AfdE7cmrB9x/F3IVurYcFK0g2C758hs4LU7UQ+8Q1Zka1Rg3MFd2AHmWUgaeJOQ+hSa
 OEM4odus5Sac7dVIlm+SbpYUmnOzByyXaLpjEBLR4I1QuOBk81yvMrSEu/mL86Jh8Zri/GrKKPA
 +kFHxAebfSeB5OLVvql+yfbn+pCkkdlPMk+8z1A8W9WiX0HUqTDWi0/tpZ+TkC923niJEcf8aOv
 wNMs3iO3bm3DhofR4mkiNTkrchFFBcVjZtPXslaxY/06UfM43ylCN1hQuFh4ZHHnkd/hL6/hjBw
 c6JjHM9dzYBm/4PiBt0XIzl7JjU=
X-Received: by 2002:a05:6214:4991:b0:8e3:fa57:ecb4 with SMTP id
 6a1803df08f44-8f4225906famr116396676d6.16.1783055894932; 
 Thu, 02 Jul 2026 22:18:14 -0700 (PDT)
X-Received: by 2002:a05:6214:4991:b0:8e3:fa57:ecb4 with SMTP id
 6a1803df08f44-8f4225906famr116396496d6.16.1783055894514; Thu, 02 Jul 2026
 22:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260613223513.865744-1-kdutta@redhat.com>
 <20260613223513.865744-3-kdutta@redhat.com>
 <20260617013059.99468-1-guobin@linux.alibaba.com>
In-Reply-To: <20260617013059.99468-1-guobin@linux.alibaba.com>
From: Koushik Dutta <kdutta@redhat.com>
Date: Fri, 3 Jul 2026 10:48:03 +0530
X-Gm-Features: AVVi8CeqA7WAVofJFZbhgFPO55RI1a5hkDSzTsxapGDvIRWQvoVv3Ve-E47imbQ
Message-ID: <CALseRdc2xq8aWQkW=55M_=Xd8ZsZXBi5+gqQWnd=zeeES6NOLQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] Implement VirtIO Network Notification Coalescing
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com
Content-Type: multipart/alternative; boundary="0000000000003522850655ae0d07"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--0000000000003522850655ae0d07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 7:06=E2=80=AFAM Bin Guo <guobin@linux.alibaba.com> =
wrote:

> On Fri, 13 Jun 2026, Koushik Dutta wrote:
> > +        VMSTATE_UINT32(rx_coal_usecs, VirtIONet),
> > +        VMSTATE_UINT32(tx_coal_usecs, VirtIONet),
> > +        VMSTATE_UINT32(rx_coal_packets, VirtIONet),
> > +        VMSTATE_UINT32(tx_coal_packets, VirtIONet),
> >          VMSTATE_END_OF_LIST()
> >      },
>
> These new fields are added directly to the main
> vmstate_virtio_net_device fields list, which breaks both forward and
> backward migration:
>
>   - Forward: old QEMU produces a shorter stream; new QEMU expects
>     more fields and fails to load.
>
>   - Backward: new QEMU emits extra fields that shift the stream
>     layout for older QEMU.
>
> They should go in a subsection with a .needed predicate instead:
>
>   static bool has_notf_coal(void *opaque, int version_id)
>   {
>       return virtio_vdev_has_feature(VIRTIO_DEVICE(opaque),
>                                      VIRTIO_NET_F_NOTF_COAL);
>   }
>
>   static const VMStateDescription vmstate_virtio_net_coal =3D {
>       .name   =3D "virtio-net/notf_coal",
>       .needed =3D has_notf_coal,
>       .fields =3D (const VMStateField[]) {
>           VMSTATE_UINT32(rx_coal_usecs, VirtIONet),
>           VMSTATE_UINT32(rx_coal_packets, VirtIONet),
>           VMSTATE_UINT32(tx_coal_usecs, VirtIONet),
>           VMSTATE_UINT32(tx_coal_packets, VirtIONet),
>           VMSTATE_END_OF_LIST()
>       }
>   };
>
> and registered in the .subsections array of
> vmstate_virtio_net_device.
>

Addressed in v9 patch series:
https://patchew.org/QEMU/20260702131632.1180309-1-kdutta@redhat.com/2026070=
2131632.1180309-3-kdutta@redhat.com/


>
> Regards,
> Bin Guo
>
> Regards,
Koushik

--0000000000003522850655ae0d07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 17,=
 2026 at 7:06=E2=80=AFAM Bin Guo &lt;<a href=3D"mailto:guobin@linux.alibaba=
.com">guobin@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Fri, 13 Jun 2026, Koushik Dutta wrote:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_coal_usecs, VirtIONet),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_coal_usecs, VirtIONet),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_coal_packets, VirtIONet=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_coal_packets, VirtIONet=
),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
<br>
These new fields are added directly to the main<br>
vmstate_virtio_net_device fields list, which breaks both forward and<br>
backward migration:<br>
<br>
=C2=A0 - Forward: old QEMU produces a shorter stream; new QEMU expects<br>
=C2=A0 =C2=A0 more fields and fails to load.<br>
<br>
=C2=A0 - Backward: new QEMU emits extra fields that shift the stream<br>
=C2=A0 =C2=A0 layout for older QEMU.<br>
<br>
They should go in a subsection with a .needed predicate instead:<br>
<br>
=C2=A0 static bool has_notf_coal(void *opaque, int version_id)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 return virtio_vdev_has_feature(VIRTIO_DEVICE(opaque),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_NET_F_NOT=
F_COAL);<br>
=C2=A0 }<br>
<br>
=C2=A0 static const VMStateDescription vmstate_virtio_net_coal =3D {<br>
=C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0=3D &quot;virtio-net/notf_coal&quot;=
,<br>
=C2=A0 =C2=A0 =C2=A0 .needed =3D has_notf_coal,<br>
=C2=A0 =C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_coal_usecs, VirtIONet)=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_coal_packets, VirtIONe=
t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_coal_usecs, VirtIONet)=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_coal_packets, VirtIONe=
t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 };<br>
<br>
and registered in the .subsections array of<br>
vmstate_virtio_net_device.<br></blockquote><div><span style=3D"background-c=
olor:transparent"><br>Addressed in v9 patch series:=C2=A0<a href=3D"https:/=
/patchew.org/QEMU/20260702131632.1180309-1-kdutta@redhat.com/20260702131632=
.1180309-3-kdutta@redhat.com/">https://patchew.org/QEMU/20260702131632.1180=
309-1-kdutta@redhat.com/20260702131632.1180309-3-kdutta@redhat.com/</a></sp=
an>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
Bin Guo<br>
<br></blockquote><div>Regards,<br>Koushik=C2=A0</div></div></div>

--0000000000003522850655ae0d07--


