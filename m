Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A47C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVwFm-00013b-9Y; Mon, 22 Jul 2024 12:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVwFg-0000mo-VM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVwFd-0007sC-6S
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721667062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYNZKml2FdQS3KP4kHOZM2YrbGr7a1FIqNA3UmyYKO8=;
 b=J+dAUfuwLJRy56kU1tahaBNQv2FZd4qBTtU6cUAwb6ePYhMP3+xjifzmFueHFhMvn+NM8O
 95lPHLnOVQBvyTK+vzl2bfrRguhox9eKHbTMeFjy6iQalp+qpz2Insy8dEyyFOnUdwsdOD
 x8lLPDHpB6y+LnspdrhrxCBdqJXopDE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-SD5-nXN9O2KjyCV1Qrn2EQ-1; Mon, 22 Jul 2024 12:50:59 -0400
X-MC-Unique: SD5-nXN9O2KjyCV1Qrn2EQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36871eb0a8eso2412208f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721667058; x=1722271858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYNZKml2FdQS3KP4kHOZM2YrbGr7a1FIqNA3UmyYKO8=;
 b=QM40XLWbQp96O2prX7AnHvoEev8kSrUp7Kwt6CgZGMDW2lkMNWwOtL8PavB6NSjfPn
 oXdHQ+m0b5HS6NrG4R9b1LR/bQCYmYmWUjpmkUnYPFJvt/jWxPspzcJuZ8k184UyIgz7
 aYn29DwQvaatWLj/nWp3ruDY+Xi8CRa2QZtrJipKHzPKKQNNFKe4MQQkQgjJqytxfAXI
 606FBf28q9KoKV4lJe8DsvzhIOj6ky07D2ZhL+WUyhZT6nw6VN/Hlj11N9GFNjqfc5RU
 OFiHRszrnNvjgLJNCLdFx/SNQiwEK/Qh8lzTGYUOf+4YJycbN9+Dpz2zbVNATfhQiZgx
 7M1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjDY6Ed8WN5T97D2ACRrZXIYWdtAzQcE6H7IAEB0jPd3PMVpynowoOnWr6nmHMHxUQwxTs18ReqW4rMcknyAY6cdNHozg=
X-Gm-Message-State: AOJu0Yx46IiEamdIVUvzPoftFdMxkOYhGPEWEOC7vA8h/iFs5NlZWLFT
 J8aDyKDdClYshtNPDWkSNv49XqRyvufMMbJVLY8iAjtwlGoDnx80hfvR1d9MK30baFxAWu+Rsk0
 mGYjXTEjTbbpEHeJCjCjnRthxd/xDyXSJizhk3j4XNq0Wp4PffiWnVob1Dn4Jt0VlaWs8uFWbCt
 4QiiiyNuw56Z9fBg+QcRqS7bjub3k=
X-Received: by 2002:adf:eb12:0:b0:368:3079:427f with SMTP id
 ffacd0b85a97d-369ded23d19mr266702f8f.30.1721667058615; 
 Mon, 22 Jul 2024 09:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYzjM2ce9jmRjD9vVYA8cFf5j5KXa9QYql5QUlzgnisLkH85vrcx2RBgp/IAXK6djUOXXFyJ5N8kThmJAl8kE=
X-Received: by 2002:adf:eb12:0:b0:368:3079:427f with SMTP id
 ffacd0b85a97d-369ded23d19mr266690f8f.30.1721667058267; Mon, 22 Jul 2024
 09:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <TY0PR0101MB4285D5A3587179A5788F3356A4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 <CAFEAcA_vY769Yws9t4WWitsShBK01Oua5zgarTj3YHgUuvpzTw@mail.gmail.com>
 <CABgObfbdXXXbygNn3DbN9Q7xB=kTFTFs5yxFQapSn6SAXdpQZw@mail.gmail.com>
 <21bed558-49d2-408d-baaf-97451780c53a@linaro.org>
In-Reply-To: <21bed558-49d2-408d-baaf-97451780c53a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Jul 2024 18:50:47 +0200
Message-ID: <CABgObfbeJEv49mfOte-4ysSDmWkBV5tUSJOh+Ye1hu19bFUZmQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] system/memory: Fix max access size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, TaiseiIto <taisei1212@outlook.jp>,
 qemu-devel@nongnu.org, peterx@redhat.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 4:29=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> It seems this model could be simplified using .min_access_size =3D 8,
> letting the core memory layer handle the % 4 byte accesses (the
> read path is obvious, the write one a bit less). Nothing urgent,
> possibly a BitSizedTask.

The memory access core is not able to do a read-modify-write
operation. You can get a smaller read from a bigger one or split a
large read/write into many small ones, but it cannot convert a small
write into a large one. Even splitting a large read/write into many
small ones is only possible if they don't have side effects.

Paolo

> > +    },
> >       .endianness =3D DEVICE_NATIVE_ENDIAN,
> >   };
> >
> > I'll now look into the other patch for interrupts. Thanks for testing
> > my changes!
> >
> > Paolo
> >
> > [1] https://gitlab.com/bonzini/qemu/-/commits/hpet
> >
>


