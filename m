Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75895C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4I7d-0001Nk-81; Wed, 09 Sep 2026 09:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4I7b-0001NM-M4
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4I7Y-0002SI-Uk
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788959627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Uez7mcFNT7KQG9IhBhJdybIwuAk7NmJ3pzUyaY0kr4=;
 b=LNSUce22FWJ+sTRWg2DGe1jlkrxZsn7w+U4dmpkhgCMv8ZNmEwYotWU8Slgi3JQ+Y4f5V5
 5UQRF2IaSJQ5WeDK3cCx0EKqau+xL21D4rtxrNBmKZ0K3qSADj5KqffsPcwuiXshDxCbfp
 IfcgixdqsomMB9gNb60+uSxrp53ctYY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-m5D6igBKPrajzYH2gCsQVQ-1; Wed, 09 Sep 2026 09:13:43 -0400
X-MC-Unique: m5D6igBKPrajzYH2gCsQVQ-1
X-Mimecast-MFC-AGG-ID: m5D6igBKPrajzYH2gCsQVQ_1788959623
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53098feb642so36908791cf.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 06:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788959623; cv=none;
 d=google.com; s=arc-20260327;
 b=X1VV3YGUJYNpc+HQtEOQ4Laf3g57kgpGJQxVnd8un6lctD/nUyidjqD6sZrQb7rcwc
 ZGIOo3qoUkkr4NjYCiDH4TDF0BKeFJQaLlXWQPgAFMAh7lbApjwI4vrSeNzGlMBPrdOD
 roWaYNqBChLqe64xGngLrjDDDFLmhOUPtNMvkaHsqAlG38ZhkqJI5Nsc02WKfRPvq/E3
 71h1dVBpSMY2kCNDiiumxH1dfKfAaeDRa+1a1tslgYKh2N+59wKlsl7YwO4xNjnqE2Rs
 B2NO7+4nSZaFxJkLLZhQhp7GOHxfDiKBFh/lKMhOELFsAwFpJ2LaI5/Ns9YGJNye91wp
 QuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2Uez7mcFNT7KQG9IhBhJdybIwuAk7NmJ3pzUyaY0kr4=;
 fh=ikIROAe4FG7GY6nFHcpMBS0Tm5PK5AkxRv1HH7kUZUo=;
 b=KdNiJAcKfGD4QEhvHuXst1f163+tOTlksaUJcjP4BDzjCY6G8Hjf6QLboLBgFWS8DD
 U2q5DInbmdYaqP6CpJvrwxJdJqG61noX6Gan2qPhsb9LZfCyrtX5V589l9uT5J3tiFbe
 5z/Vpdpm3HQHP3GGXAuQV36KKTos6SJuccKLiHZFRDJBqrIHRDBoY876nyjPA1XSnh3S
 fYPFvC8SJ1fwJ6XZFNUgENkFj0jMEktv1ZIPEIYmlZ/hZDH+lU5aZvdqpC1EbL4BBi/c
 SNbZa5kGILA8//IK2lhue33tXEIAVesfTfRCqUaPKJ/Bi7ka3ihaDnakLzyiLrCId8fq
 gqhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788959623; x=1789564423; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2Uez7mcFNT7KQG9IhBhJdybIwuAk7NmJ3pzUyaY0kr4=;
 b=Tc8eUW58opWMXvbKVyPSjNOm+2J7VIGakv5/IrpV3tgiDl1Gt1A7+TJH0t42KiVaJk
 NHXvPWoP2qBpC2EK/7UdLwNjTLmRRabjErA3M8DjgG4p1mIWoN6eZPMErM8+SSlA7AJF
 YaAbv1Ay6UhELfJ+vSxee20auq9RLfgitcfX8YC4Kc0MfhYo9nYpFEoPmdSR9KEJqMO4
 n4AQZ1/s1tEr/RTZAJSs99e1IzkKL2OP9NlcCiqrypMLzrhzpkYAiS4Fp8WrNOF6kF06
 mkxPq0ntqvVBF0fL/xD0v+PtQKuwXeFieXQS1w37YdZdH0yOLNUBPSUflahdfNDXULsF
 LLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788959623; x=1789564423;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2Uez7mcFNT7KQG9IhBhJdybIwuAk7NmJ3pzUyaY0kr4=;
 b=s1oAjxX1RJ/Z8zyF2SU2x6p7Ppag6+n7kim1oNamyiaLr+ClzaMow9mCMrpdO4b3qm
 xLgwcH06XjzoH6HTup3dc/tT+fe+A+u48cRDf0oF6Oci4p3TvgjeuuP3iNJRdnIXcYrZ
 58PYoFYwWhRplSwmUaVKvS3FFEH+hMQDgdH7Dm56vaFXINEtq9juf9XdGONuwLZZpRiL
 KxBOoQPnwoLjfoOMt0U+Sr7g9Z0ckjT+/gQkiKoR0yAuOIyRJmwyiAWMmOwhrrwqreFs
 gZ8N0uzdZmivbC9f0F3LeqUDAjuOi5V5gvb/hrN5R1cukFErZLhO43b6l9M1KJeNPTkw
 kAAQ==
X-Gm-Message-State: AFuF++nDgvpe2BvSdT3lAXJVIjAj+H3njNO0hkK8WmEO9OGN+0WEDXUN
 pRGqlnVkVt+XM1Yvf4EmlOzMkkYc1Qkb5MO7jJrO2uBWqDcrLx7S16QfZizvlNIkmNenGuyCGMp
 vvgKWJlz8FnEMHHWobnoGuCZVifwFXX3i8m+8WFZi7GFYBGILmqakmjKH4YYegZ4Kn01WP59zTe
 iUTYXYEh2xPr8zMp8IMvVy1vgB1tL9iIM=
X-Gm-Gg: AYBFou118/RtN8D5Bp4/d6shps2Yn8jBENHJ6kPwWQajH9sKNa33ZYbU/3ft7jv7Yuv
 U88kAz9zSU5o5Xonow/uO66CktXsqPchZsqZ6aRSd3jcIF54jusxi+sF3CnxbMkMFJOyeaXnXu1
 f5VY3YvKe9g1ZI9q3jsSQytSwjnEaaCOvyJMb70udUe85wKVbVp61vAbLfV5hc04rD9/+DAQk5O
 q8YNRmIS46SEL1KvGOiy2HrV14ebLbPxbhK76oZjg0=
X-Received: by 2002:a05:622a:649:b0:51c:ace:de6a with SMTP id
 d75a77b69052e-5305487d2bdmr408773611cf.18.1788959623101; 
 Wed, 09 Sep 2026 06:13:43 -0700 (PDT)
X-Received: by 2002:a05:622a:649:b0:51c:ace:de6a with SMTP id
 d75a77b69052e-5305487d2bdmr408773021cf.18.1788959622572; Wed, 09 Sep 2026
 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260909125923.75340-1-afishman@redhat.com>
 <20260909090119-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260909090119-mutt-send-email-mst@kernel.org>
From: Alex Fishman <afishman@redhat.com>
Date: Wed, 9 Sep 2026 16:13:31 +0300
X-Gm-Features: AcwNN1Wi4LzX3ok7v8CsX3mtuPP-r9Dmszz92N1WKGLpDsmsfGThIk5vtBlQoS4
Message-ID: <CAGqnWRZzkQZ8Yi1fypHbtZMuXm9U3uQeE8hzeaogNTFye9hcGg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] vhost: Handle vrings crossing virtio-mem slots
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000d258ac065b0c9eb9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afishman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000d258ac065b0c9eb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

https://redhat.atlassian.net/browse/RHEL-146583
Windows guests when hotplugging memory

On Wed, Sep 9, 2026 at 4:01=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:

> On Wed, Sep 09, 2026 at 03:59:21PM +0300, Alex Fishman wrote:
> > Virtio-mem dynamic memslots are intentionally exposed as separate memor=
y
> > regions. If a guest places a vring part across two adjacent slots, a
> later
> > memory update fails vhost ring verification because the complete ring
> part
> > is not contained in one vhost memory region.
>
> when does this happen?
>
> > Coalesce coherent adjacent sections only when a descriptor table,
> > available ring, or used ring crosses their boundary. Unrelated
> > unmergeable sections remain separate so they can still be updated
> > independently.
> >
> > Patch 2 adds an end-to-end qtest reproducer using a fake vhost-user
> > backend and virtio-mem dynamic memslots. It also verifies that a newly
> > activated slot is not folded into the merge required by the crossing
> > vring.
> >
> > Tested with the vhost-user/mem-slots/boundary qtest.
> >
> > Buglink: https://redhat.atlassian.net/browse/RHEL-146583
> >
> > Alex Fishman (2):
> >   vhost: coalesce unmergeable sections across vring boundaries
> >   tests/qtest: Add vhost-user memslot boundary test
> >
> >  hw/virtio/vhost.c             |  72 ++++++-
> >  tests/qtest/vhost-user-test.c | 395 +++++++++++++++++++++++++++++++++-
> >  2 files changed, 452 insertions(+), 15 deletions(-)
> >
> >
> > base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
> > --
> > 2.52.0
>
>

--000000000000d258ac065b0c9eb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a href=3D"https://redhat.atlassian.net/browse/RHEL-146583=
">https://redhat.atlassian.net/browse/RHEL-146583</a><div>Windows guests wh=
en hotplugging memory</div></div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2026 at 4:0=
1=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Wed, Sep 09, 2026 at 03:59:21PM +0300, Alex Fishman wrote:<br=
>
&gt; Virtio-mem dynamic memslots are intentionally exposed as separate memo=
ry<br>
&gt; regions. If a guest places a vring part across two adjacent slots, a l=
ater<br>
&gt; memory update fails vhost ring verification because the complete ring =
part<br>
&gt; is not contained in one vhost memory region.<br>
<br>
when does this happen?<br>
<br>
&gt; Coalesce coherent adjacent sections only when a descriptor table,<br>
&gt; available ring, or used ring crosses their boundary. Unrelated<br>
&gt; unmergeable sections remain separate so they can still be updated<br>
&gt; independently.<br>
&gt; <br>
&gt; Patch 2 adds an end-to-end qtest reproducer using a fake vhost-user<br=
>
&gt; backend and virtio-mem dynamic memslots. It also verifies that a newly=
<br>
&gt; activated slot is not folded into the merge required by the crossing<b=
r>
&gt; vring.<br>
&gt; <br>
&gt; Tested with the vhost-user/mem-slots/boundary qtest.<br>
&gt; <br>
&gt; Buglink: <a href=3D"https://redhat.atlassian.net/browse/RHEL-146583" r=
el=3D"noreferrer" target=3D"_blank">https://redhat.atlassian.net/browse/RHE=
L-146583</a><br>
&gt; <br>
&gt; Alex Fishman (2):<br>
&gt;=C2=A0 =C2=A0vhost: coalesce unmergeable sections across vring boundari=
es<br>
&gt;=C2=A0 =C2=A0tests/qtest: Add vhost-user memslot boundary test<br>
&gt; <br>
&gt;=C2=A0 hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 72 ++++++-<br>
&gt;=C2=A0 tests/qtest/vhost-user-test.c | 395 ++++++++++++++++++++++++++++=
+++++-<br>
&gt;=C2=A0 2 files changed, 452 insertions(+), 15 deletions(-)<br>
&gt; <br>
&gt; <br>
&gt; base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd<br>
&gt; -- <br>
&gt; 2.52.0<br>
<br>
</blockquote></div>

--000000000000d258ac065b0c9eb9--


