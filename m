Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936ADE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 11:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM3nb-0004DF-IQ; Fri, 13 Dec 2024 06:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tM3nR-00048t-N1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:25:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tM3nJ-0000jH-FY
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734089110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1N+aZYuNIMt+bY5jVpnrGhR8IijEESQefd14Y8VT6KQ=;
 b=cuA6lOq1H8ikDLNumuilwMuJqsPi5Tq0bjVAPEYAC5Vd4oM21xU9McrMkBr6RBseK7+M1r
 3hqLmhxJZJd6z3hwuhqVRj5kjDsefc8bZuK7PG6FTik/gHaAGurCVOC+V27E6Ad8ROZcuK
 w8vfpNb7j0jzrVji9YluOwoQ//BmxAk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-3LBe5HttMyuAnipzKoqpKg-1; Fri, 13 Dec 2024 06:25:06 -0500
X-MC-Unique: 3LBe5HttMyuAnipzKoqpKg-1
X-Mimecast-MFC-AGG-ID: 3LBe5HttMyuAnipzKoqpKg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso1086633f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 03:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734089105; x=1734693905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1N+aZYuNIMt+bY5jVpnrGhR8IijEESQefd14Y8VT6KQ=;
 b=HojP1JKAgOX3liQtNj9abmDBFjsRed2DyYEK1O2s2wg7LQHsLZy4e7FS70FADGvHXn
 zMaVCCVh5/d57t3NLxFEwx0LDKksdk+nVNwNzb6qmh5moC13BD5Upq7qS64Sy+NnDXHi
 NTTvOZ+qt3GUffQU18bZ3gfSwcIg/K3mkf/bP9dYqVwieNjPApCSchNfW7bPaOuVjbpP
 c8+dCGobJ5G01quzD5ntZRbB2e2aJUb8sDXsTrwS3E6oJXEwK8dC3wxbWzN5CZFxeJIH
 +8gdSqciuw4olZFiM+UNw//iSZ7xImJ/LOAfDVWJ1yCUfxX4QSPNXTavdo/5Noq4hew8
 eBOQ==
X-Gm-Message-State: AOJu0Yz4yUMsGdMCv04iRgsOlAp+/+PEbOe1CqDbmbNUZ7R6iJpdS72I
 U9AptnKzmDWc/Sluh/bjopMjeS87HZ1HuNAE/CWanygADySUp93BCXGsUhesZ6Ge13HStBpfQpu
 mIXeFatCg9/JXVbLfyn5TA0rOWfkqhrugZwj9fN1+MbhlW09lqJC/8DJqMIzceEpTbPiziYOA9/
 EbEOHcO2WDhkO0F6sXmV7t+VYO7N8=
X-Gm-Gg: ASbGncvhyr1t3DnhMTnNc1vh0RU7gxvr6M+GxykjDPdoCjTng+YnrqPwK9ncioE7J7d
 NNnzJANRFS13j1gwo/TehjqOq+UHLEKLUse3uxg==
X-Received: by 2002:a5d:64a9:0:b0:385:fb34:d5a0 with SMTP id
 ffacd0b85a97d-38880ae140cmr1807757f8f.29.1734089105304; 
 Fri, 13 Dec 2024 03:25:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9WAVNzuPvLGPPwTNfmY1+QhvWNDm/MHqeM6dV95fcacfIOaKveU8JF8Pq2TDE2B4d4h9hHt5ZhFKhTn66Bfw=
X-Received: by 2002:a5d:64a9:0:b0:385:fb34:d5a0 with SMTP id
 ffacd0b85a97d-38880ae140cmr1807731f8f.29.1734089104965; Fri, 13 Dec 2024
 03:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-20-pbonzini@redhat.com>
 <Z1qyeThRA8yJMMoM@intel.com> <a0bdbf2a-8430-480e-bc56-e8a4875dd577@redhat.com>
 <Z1v8NhJb/xBp/K2D@intel.com>
In-Reply-To: <Z1v8NhJb/xBp/K2D@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Dec 2024 12:24:53 +0100
Message-ID: <CABgObfZb67eLK=kwJXWK6V=+5wB41NuPchbDBERdHtLWN-4ThA@mail.gmail.com>
Subject: Re: [PATCH 19/26] rust: rename qemu-api modules to follow C code a
 bit more
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Junjie Mao <junjie.mao@hotmail.com>
Content-Type: multipart/alternative; boundary="0000000000001c6a91062925153e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000001c6a91062925153e
Content-Type: text/plain; charset="UTF-8"

Il ven 13 dic 2024, 10:01 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> I found vmstate_array_of_pointer_to_struct missed a `info` field, and I
> could submit a patch to fix this nit next week (along with other cleanup
> you and other miantainers suggested for HPET).
>

I wouldn't worry too much about VMState, it's not in its final form and
anything that isn't needed to pass qtests can wait.

Paolo


> for which my idea is to implement a trait on
> > types to retrieve a basic VMStateField (for example something like
> > vmstate_uint32 would become an implementation of the VMState trait on
> u32).
>
> This makes sense.
>
> > Then you'd write something like "vmstate_of!(Type,
> > field).with_version_id(2)" (i.e. vmstate_of retrieves the basic field and
> > fills in the offset, then you apply more changes on top).  But that may
> take
> > a while, and I think it cannot be done without the const_refs_to_static
> > feature, which is only stable in 1.83.0.
>
> I also like this idea!
>
> Thanks,
> Zhao
>
>
>

--0000000000001c6a91062925153e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 13 dic 2024, 10:01 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I fou=
nd vmstate_array_of_pointer_to_struct missed a `info` field, and I<br>
could submit a patch to fix this nit next week (along with other cleanup<br=
>
you and other miantainers suggested for HPET).<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">I wouldn&#39;t worry too much=
 about VMState, it&#39;s not in its final form and anything that isn&#39;t =
needed to pass qtests can wait.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
&gt; for which my idea is to implement a trait on<br>
&gt; types to retrieve a basic VMStateField (for example something like<br>
&gt; vmstate_uint32 would become an implementation of the VMState trait on =
u32).<br>
<br>
This makes sense.<br>
<br>
&gt; Then you&#39;d write something like &quot;vmstate_of!(Type,<br>
&gt; field).with_version_id(2)&quot; (i.e. vmstate_of retrieves the basic f=
ield and<br>
&gt; fills in the offset, then you apply more changes on top).=C2=A0 But th=
at may take<br>
&gt; a while, and I think it cannot be done without the const_refs_to_stati=
c<br>
&gt; feature, which is only stable in 1.83.0.<br>
<br>
I also like this idea!<br>
<br>
Thanks,<br>
Zhao<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000001c6a91062925153e--


