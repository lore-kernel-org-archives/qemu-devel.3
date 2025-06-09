Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B23C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 18:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhaa-0008Qv-U3; Mon, 09 Jun 2025 14:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOhaT-0008QJ-ID
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOhaR-0006vt-62
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749495068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k85Yk3+IdxmfnPuABqvl6pFP/vpTKiIkw4UDNk4Pf0I=;
 b=OxrXQtDTthfA2pyhPlIQD+yy3Gj2auwq5Vwz9Yg76DgC4UOUX4MrM7V9aJqkmFNJUtgOwm
 4+j0gyw3LNi2vdMQrwbWA/pTRz/d6OL3bOfo2pKBnFQmg2uPDBO1eYfzKpoLolaq+G6f//
 JdJRqHjUQh9n+1ftSfykBO4IE0AcQxA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-_fpZc7DhPcSvvTxeJH6mXA-1; Mon, 09 Jun 2025 14:51:04 -0400
X-MC-Unique: _fpZc7DhPcSvvTxeJH6mXA-1
X-Mimecast-MFC-AGG-ID: _fpZc7DhPcSvvTxeJH6mXA_1749495063
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a37a0d1005so3103628f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 11:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749495063; x=1750099863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k85Yk3+IdxmfnPuABqvl6pFP/vpTKiIkw4UDNk4Pf0I=;
 b=vMJi4nkBOwRpiVBZRIoE4P9yTFzNeVouda++o0E5bMtAnii+0AG0aq7rfO0+T8ufa3
 bRrEHOm5gTd3zPWCVTtCOCtqW5IuPE7Tip4v2iaOVyFA3lBPzhPLbRDgBp7vbxdj67iH
 FVgLY0nRtVLq7dPL6dPuJClvKv1pdNJSgxrygxeL3z5G4uohubbl3u+UdNm8PDJAJVfv
 VRL6JcdkvX27jHxL/JEnnqHErczOcrHxuXwDO+tHSKUaFVqLuFvhzfgV9yMLElqrazfv
 96+XOIwbWa/JH4H/loAHZQRaXb4/yDvntsRM9zffHLeuTO4zX/ZLnelaK2ENPTDib61D
 VtVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuoesYPyzf2R9QZh65THU2BppmUquSADfqYwt5njA/mkMsQPpVYb8SUnxBJOS6EBDrv8sLQgJpqfWD@nongnu.org
X-Gm-Message-State: AOJu0YwQfqV0TxqFC6tpjPm0/4Cdfl4zN+Mk3DazYEQIV+BngsI16jLN
 bKojI5/VSXKWT8UTX2S+GFIzPU/p+jZwxw8iZABeaJUwqx1aXMTEwezn+Clb8R+30q08h4GGokL
 vUXXlt2IKlN9NHHZ2dnQjbTEkj3SUqCAAti5oTTRQRAHa/6rXh0mbdyr/zraQvzWY/ZmoD4sksC
 9QFaVzP126YkdZfO3L9ScAQMco/5d6dlU=
X-Gm-Gg: ASbGncuEzcardLkVrr+38+Fvqj9wKJtEW1jXnIt8N/T6EeUl4xAVjZVF0XTBKpiYEEy
 sBJcFa62wwCRZ3u5DfGGeIGfp6vTxuFJdw/nGYGmKlihV/5PlWSjnCmkjfpTBagq1+WVoBsL6Cq
 Q+Sw==
X-Received: by 2002:a5d:584d:0:b0:3a4:e6e6:a026 with SMTP id
 ffacd0b85a97d-3a531caffd6mr11435018f8f.28.1749495063472; 
 Mon, 09 Jun 2025 11:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7ivnqZlC9DkR/SKkK+mr2lq0CBjTYxppSOsF8lHx417Lbm1ER9jumoJWE+SvBXRNYWkSjZDahjgiq1EXtvZM=
X-Received: by 2002:a5d:584d:0:b0:3a4:e6e6:a026 with SMTP id
 ffacd0b85a97d-3a531caffd6mr11435008f8f.28.1749495063148; Mon, 09 Jun 2025
 11:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-3-tanishdesai37@gmail.com>
 <20250602222434.GB320269@fedora>
 <7f4eefa2-9e00-4ba2-898f-c480c2123904@redhat.com>
 <CAJSP0QX=e3GkB5L0rpAf8YfkJDKOZYJcx553tut+7Hp2NK3XYg@mail.gmail.com>
 <03c067fc-2a47-4fc5-9204-1ac6ded4301b@redhat.com>
 <CAJSP0QULzQsJEN7q-QiG+Tj0ngstKcu_=0fyTytx11uMUDXmrw@mail.gmail.com>
In-Reply-To: <CAJSP0QULzQsJEN7q-QiG+Tj0ngstKcu_=0fyTytx11uMUDXmrw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 9 Jun 2025 20:50:51 +0200
X-Gm-Features: AX0GCFtcWM5TSMJG_1DsdxZIOBg5MWZ-Y-z8qS-KpkofKi0KPQBnrGuLLyzSAOM
Message-ID: <CABgObfY80S95N_qJ-LJwQb5q0i0oFMFaRdQ8o+c-O8LkUHxGwQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] trace/ftrace: seperate cold paths of tracing functions
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="000000000000c68e8e0637280fdc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000c68e8e0637280fdc
Content-Type: text/plain; charset="UTF-8"

Il lun 9 giu 2025, 20:27 Stefan Hajnoczi <stefanha@gmail.com> ha scritto:

> > If you disagree with this change we can certainly live without them---I
> > asked Tanish to start with this as an exercise to get familiar with
> > tracetool, and he's learnt a bunch of things around git anyway so it's
> > all good.
>
> A maintainer's life is easy when patches have a clear motivation. With
> this patch series I'm not convinced there is a clear motivation, and
> that makes me hesitate about applying them.
>

Indeed. Tanish just posted a patch that should get basically all of the
benefit without the downsides, so thanks for hesitating. :)

Paolo

If it's okay with you, Tanish and Paolo, please hold on to the patches
> and let's see how they fit into the larger goal of Rust tracing
> support. If they help with that then I would be happy to merge them
> together with Rust tracing patches.
>
> >
> > We'll also try to take a look at the code that is generated in the
> > function that invokes the tracepoint, to see if it's improved.
> >
> > Paolo
> >
>
>

--000000000000c68e8e0637280fdc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 9 giu 2025, 20:27 Stefan =
Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>&g=
t; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; If you disagree with this change we can certainly live without them---=
I<br>
&gt; asked Tanish to start with this as an exercise to get familiar with<br=
>
&gt; tracetool, and he&#39;s learnt a bunch of things around git anyway so =
it&#39;s<br>
&gt; all good.<br>
<br>
A maintainer&#39;s life is easy when patches have a clear motivation. With<=
br>
this patch series I&#39;m not convinced there is a clear motivation, and<br=
>
that makes me hesitate about applying them.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Indeed. Tanish just posted a pat=
ch that should get basically all of the benefit without the downsides, so t=
hanks for hesitating. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">If it&#39;s okay with you, Tanish and Paolo, please hold on to the p=
atches<br>
and let&#39;s see how they fit into the larger goal of Rust tracing<br>
support. If they help with that then I would be happy to merge them<br>
together with Rust tracing patches.<br>
<br>
&gt;<br>
&gt; We&#39;ll also try to take a look at the code that is generated in the=
<br>
&gt; function that invokes the tracepoint, to see if it&#39;s improved.<br>
&gt;<br>
&gt; Paolo<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000c68e8e0637280fdc--


