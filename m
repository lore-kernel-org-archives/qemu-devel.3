Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBADD0E6C1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2nP4-0003J0-Vv; Mon, 21 Oct 2024 04:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2nP3-0003In-BM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2nP1-0001Lv-Ov
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729497873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WdJ4zpodPWvS9uPs3IgOyttCLDwO1xAev81lliVqpSc=;
 b=U9Zr1CyJrhHpISpxsElcpPbXyz3qdW0EVSOZAMDr2ncO44+R2hzrLC75hD46cu+mpr8uYz
 uHg3p2QWiwb70vDHQe+3OamG3kwGI0FxgXzwudI6lYtH/TzhaUJ9FGj6PQvVgE2YDUr+4s
 9AbrdHggPfaSBpqUzlsa1bIUV+CucdQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-VNR5BU2PNiKaHuvXqpO-vg-1; Mon, 21 Oct 2024 04:04:31 -0400
X-MC-Unique: VNR5BU2PNiKaHuvXqpO-vg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d609ef9f7so1982516f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729497870; x=1730102670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WdJ4zpodPWvS9uPs3IgOyttCLDwO1xAev81lliVqpSc=;
 b=gJzDft+mX7AFfwG1lEaswk116cRc/5BIlgpD5P8/sX1iNr1cLwc9YD09GRBthwVZ5N
 +FCpMXOkPQMcGFqa5QbKHcx0PFEd7tx2IQONgUxmTweg0VqEggDcwwA29MHv9mrsYnfN
 Q8xmCpPeYjN6MdUNex+UpDtUjqhNSKfM0oyvqz337Yw08Jp1TP0YWSG/kBEXyXRP06Ef
 eDwEyCRUYA34ZaSfyncITXtjIwkgYgU8sec08Gz0Z3W1u+mZEE/H2KdgD4VebOSFrdoJ
 4Lx7VZ+tUG5F14PmKjzlBuV+ICXwdV4FYpdnVghZWWqFU8gmuuUD5d5WRJglcBEQnKZC
 qEoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVueHa1EoRW3XRL7sUnerAhxnkDV+5TBwXWyXMxXAxl/AlQV1tWnrnJ6qiXju7EzfXI9NaTG3REIXNs@nongnu.org
X-Gm-Message-State: AOJu0Yz8A1IPkdHHsKpjxCWR7ugXi49h/O8QvyvsZOb1jpL0kXVMEYZz
 lZCsz3x+h8AXEczXnvNZgIuL3GISLLD3EgUNoGknXMH/qU8MsHrhWvwu3IdJUx2aqYMnOxt9N9y
 UbWghvoZZREJfJRKxijxXtQfOXvK7EEm61UJRHOMg5UtK6tSNpch2SRaHvY3HWspmXyGsRPm8Lq
 lWoFTtgG7YM+mehiVq7SUrVLK04zixl4Z0014=
X-Received: by 2002:a5d:4044:0:b0:37d:4e03:ff8e with SMTP id
 ffacd0b85a97d-37ea21a1f42mr7771234f8f.28.1729497870298; 
 Mon, 21 Oct 2024 01:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAkY3oG0tJ6ESPTwi7a5UsB+9/yu43Lw9j4lB8CznCta8DBLcIhWaegemREXWjhi2lzFzXab/An8bvXTNNDDo=
X-Received: by 2002:a5d:4044:0:b0:37d:4e03:ff8e with SMTP id
 ffacd0b85a97d-37ea21a1f42mr7771218f8f.28.1729497869996; Mon, 21 Oct 2024
 01:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <SY0P300MB10265E25557DB71EE426525795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <5db62c58-b6e3-4f83-9954-ff2bcb1108bc@redhat.com>
 <SY0P300MB10261816C21DC5FCC6D39F6295432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB10261816C21DC5FCC6D39F6295432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Oct 2024 10:04:18 +0200
Message-ID: <CABgObfZWHKvGFRhfUHoCVeqB1bH=ui6x3rORYXH8WsE905=eLw@mail.gmail.com>
Subject: Re: [PATCH] rust: introduce alternative implementation of offset_of!
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002e69c10624f81af8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002e69c10624f81af8
Content-Type: text/plain; charset="UTF-8"

Il lun 21 ott 2024, 09:24 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

> > Thanks.  I still prefer to keep the procedural macro code minimal, and
> have the
> > code generation in a separate macro, but this is a nice start!
> >
>
> I'm not sure if I get your point right.
>
> My understanding is that preferring minimizing proc macros is because
> they generate a big, arbitrary block of code that is hard to read and
> debug directly (which requires cargo expand the whole crate). That is
> thus more error-prone and makes maintenance harder.
>
> As for having "the code generation in a separate macro", are you
> referring to `macro_rules!`?
>

Yes, keeping the generation of the impl block in with_offsets!. Then you
can get the best of both worlds in my opinion, for example the #[repr(C)]
check is more robust in the procedural macro.

Sure. Will use quote_spanned! here and make reported errors being a
> tuple of error msg and span to use.
>

If it's okay for you let's first get the fixes in, and then I can repost
the MSRV series and include your procedural macro and unit tests.

Paolo


> >
> > Paolo
>
> --
> Best Regards
> Junjie Mao
>
>

--0000000000002e69c10624f81af8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 21 ott 2024, 09:24 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:</di=
v></div></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">&gt; Thanks.=C2=A0 I still prefer to keep=
 the procedural macro code minimal, and have the<br>
&gt; code generation in a separate macro, but this is a nice start!<br>
&gt;<br>
<br>
I&#39;m not sure if I get your point right.<br>
<br>
My understanding is that preferring minimizing proc macros is because<br>
they generate a big, arbitrary block of code that is hard to read and<br>
debug directly (which requires cargo expand the whole crate). That is<br>
thus more error-prone and makes maintenance harder.<br>
<br>
As for having &quot;the code generation in a separate macro&quot;, are you<=
br>
referring to `macro_rules!`?<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Yes, keeping the generation of the impl block i=
n with_offsets!. Then you can get the best of both worlds in my opinion, fo=
r example the #[repr(C)] check is more robust in the procedural macro.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Sure. Will use quote_spann=
ed! here and make reported errors being a<br>
tuple of error msg and span to use.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">If it&#39;s okay for you let&#39;s first=
 get the fixes in, and then I can repost the MSRV series and include your p=
rocedural macro and unit tests.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Paolo<br>
<br>
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
</blockquote></div></div></div>

--0000000000002e69c10624f81af8--


