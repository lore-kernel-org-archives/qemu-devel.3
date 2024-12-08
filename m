Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60136E77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 09:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKDcs-0005F6-AH; Sun, 08 Dec 2024 04:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKDcq-0005Ea-QE
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 04:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKDco-0005LJ-F7
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 04:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733650248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2rmLG3d447gSg4MtN5KAmy0j3oHN9UluUCGk7IN/5E=;
 b=eNJ20mQ/CGtUGiQsAcdvFa1LKXa9sO7kbhX9W2ikWSIQIjO7l/f2iyyi1OnIktjx62G7pg
 ZBrLZFJ+dU7XFwRzX06o1C+GcoKiojPf68eN2n9/mbL2H/T7DXW01kFY8ALe+FXlR6LHqn
 Yl8/5h+PEFiYExSvF1feq8GKpYqLuO0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-XYvWO33KOgabpHoG71JoEw-1; Sun, 08 Dec 2024 04:30:46 -0500
X-MC-Unique: XYvWO33KOgabpHoG71JoEw-1
X-Mimecast-MFC-AGG-ID: XYvWO33KOgabpHoG71JoEw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so1229219f8f.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 01:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733650245; x=1734255045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d2rmLG3d447gSg4MtN5KAmy0j3oHN9UluUCGk7IN/5E=;
 b=Th1ydb/0I+HpB9TSIO6iQfW7eQrBBEbdpgOXuZUSGjvECrJ2vLE/NUsnAlF2B5NfmS
 kR7+ZEaHhHqM0BI6nGvXw4OG5WM8D6qs76EPkb+/tyvvgrrx8txSQQZui46YK0wRu8KE
 bbs5+kEY2vBF+EsH46ldsvP1yLceuj6hMMLwhWkmNo1j4Z6FEUpJPyuRSODtQjNn4ORh
 MjfU4N8oBWBCcuiafB0+JNRSR0HfaBoj6p3DLDoHLnHD0q2F1Za0rxcORHgwaZOGQ2Tx
 Jm0A7ShIwu8dtOt74oj4jSwy2ozb+mFYvdRVK/zbONerAky3vmLOkYnrmNIOYrcfLqXX
 mlGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLWeC16RZz7R1nFeKQ6nzbhIE2M+C/ZAl2pPaDhYTmePU7+EOaPax7XzZmNLNIYewazWol1WWUf5Rw@nongnu.org
X-Gm-Message-State: AOJu0YyqnBHgbDHzVjyesHsbkNmD1N/udevWos77ShT+89cQPK/0Uc7d
 A4wqJtMyl6atzaIFjKASLsfMgWrkulFpMrPgjBwXQOkO/Uvq8wvLDBN8HVPRjegP/8fCJcj8Krq
 8JqFP713ZbenSVqWLhPT7lr0gRyOb04AGIYWUyvuFc5aJNW2KOM0t/3PYgL4WsYzDpeY6RbM/IQ
 6QQdgZmtGzLkeErak8MaxGiZ9Nm/M=
X-Gm-Gg: ASbGnct6II4QfZ6nt+k/UAZfsJ/wBfYWmduc+ivUnrMfm/a9WXzt+ARpg8GM4hVW266
 PaEWf2Yg5xmzMJabUmEMsV6n00UrL3Bs=
X-Received: by 2002:a05:6000:18a7:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-3862b3cefbbmr7517677f8f.51.1733650245375; 
 Sun, 08 Dec 2024 01:30:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG42347YA2RS3WGKuiu97ood0dzN6lxRkr8coNAoo/6acZUNKAtnhDC5EmuslichPx71zPE1sxzWTTTz5itXdM=
X-Received: by 2002:a05:6000:18a7:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-3862b3cefbbmr7517651f8f.51.1733650245013; Sun, 08 Dec 2024
 01:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
 <06e90014-40b3-4928-b61f-6598193151f1@linaro.org>
In-Reply-To: <06e90014-40b3-4928-b61f-6598193151f1@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 8 Dec 2024 10:30:34 +0100
Message-ID: <CABgObfbYfR=OjsQk78TyqUwyfAr0Mxn2bgX062Ck5kuAwW3f3g@mail.gmail.com>
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000004ed000628bee713"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000004ed000628bee713
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 7 dic 2024, 10:21 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> >> is still decently packed and simplifies things a lot.
> >
> > The old struct is 4 bytes, and the new one is 8 bytes. We do
> > a lot of directly passing 'struct MemTxAttrs' arguments around
> > as arguments to functions (i.e. not passing pointers to them),
> > so increasing it in size is not completely free.
>
> Should we add a check to not pass 8 bytes?
>
>    QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) !=3D sizeof(uint64_t));
>

Yes, why not.

Paolo


>

--00000000000004ed000628bee713
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 7 dic 2024, 10:21 Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scritt=
o:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;&gt; is still decently packed and simplifies things a lot.<br>
&gt; <br>
&gt; The old struct is 4 bytes, and the new one is 8 bytes. We do<br>
&gt; a lot of directly passing &#39;struct MemTxAttrs&#39; arguments around=
<br>
&gt; as arguments to functions (i.e. not passing pointers to them),<br>
&gt; so increasing it in size is not completely free.<br>
<br>
Should we add a check to not pass 8 bytes?<br>
<br>
=C2=A0 =C2=A0QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) !=3D sizeof(uint64_t));<b=
r></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Ye=
s, why not.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
</blockquote></div></div></div>

--00000000000004ed000628bee713--


