Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B69FFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOl2-0004pv-3L; Thu, 30 Apr 2026 06:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIOkg-0004Ro-T5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIOke-0003iY-Pp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777545371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cuo/I0qTAOKOsTUzJ1xXEABkBKahF/yrt2iDIGc7SH0=;
 b=EOQyrWcrnSdLW+2N2SrN5JtSP7gDf10WtwBH7BeY9FDhZt+PfYG/xI+6RUSv6uXal+5vJR
 hD823ZST0zOB9GWAA8duw6ls1mC5BS5Tnu59vbj5Hy+wY+pfMYpWxRRAeTw1QLHoYt8AIo
 iaBw7Zmlr+RO0WQa2tIBDdgy//jYuJY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-uLkSW27IPiKMmdi14KDN5w-1; Thu, 30 Apr 2026 06:36:10 -0400
X-MC-Unique: uLkSW27IPiKMmdi14KDN5w-1
X-Mimecast-MFC-AGG-ID: uLkSW27IPiKMmdi14KDN5w_1777545369
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4470d6d2a4fso961644f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777545369; cv=none;
 d=google.com; s=arc-20240605;
 b=KmHLZzAMmeYHZ8zA+x044JDgYJ21MvvMRQE9U4C18mrYMHxI7d57XkqPL3Lj5f2hWM
 NL+NXgcqLA3jf2t/LycJw61KROcAu7l422ijxapNGjcN3qYaOva5orVxk+BcX4S091ko
 d8tUAZPMHMogez7Bg0DwXA2zg2iMBXQ8RwGr5ZAb5Df1+3wCjNSd09qTxaRvE/P0VGmu
 nYu+Mo4tId6jsR1sBDXR8IJGQsOKS0xuwkQfbOjFlh2gJdR1nW5hav6aCqS39F0ZStB/
 8kFWy9cMb5NZ1pzk9ZO0exMOANkVzs2ijvkNc54XkSEY52qW+8XTniPYfvRIMp35iLw+
 JV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cuo/I0qTAOKOsTUzJ1xXEABkBKahF/yrt2iDIGc7SH0=;
 fh=a48Yz94NrSN1VfxXFKxdHg5tRcnTkBUqJPewYKl8hN0=;
 b=Q/+OYiPHfKcoaHQoUe2UryCIbJVs3s0mP0mWgytEy1YRte3VRJKE3Ca/NyWvycqYWG
 qGW+A+3kOZggmnBKMAaV8+P7/ZFQ2eNyRcwex9JcLa5eO/Zk0dhtxi77uzGn87mmATVH
 Py8aSErRMkwdqffWojHIulmr+1xr8PwCyNQFUll79iGvQYV/EcPBn25kC7kpnYuClou9
 f832CafZctx6gp0jFTNg5W1lmYxu6VG6LhG5oN0ZyfH2cJsQOXmYxDaliOqauZfq8rEw
 yDpvSlC4sOLjyVxP0NiKWqcDAiy3fJDRKwGf7VEzuLl7HRZp8bn8QTedjKsDgDWardyB
 Szsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777545369; x=1778150169; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cuo/I0qTAOKOsTUzJ1xXEABkBKahF/yrt2iDIGc7SH0=;
 b=K/HMwUIFKeKnwwURk+/v1EL3iSiQ2kpjLx4rUal2KxiQYYkZP6Bv2Owi+DssUDWWTl
 eavrXJ1ukUPZkLjUKgbuLxFxmpsINpNpWXUl4+0jaeaPgSvWdgLg20e+1KtS38LrAPmR
 Ewg67JhAXXYZ+Wd01oWr5B2tIQOxe8SdrtUzkhm+PkzIjy7SqqpHFC2F7umr1uQexqUT
 zDxBNTtlptrKKY42pafJXhprC1pkiVvNXV56GvpZkVNhL5GUiaO1jzmIn1Wa44k3cuJl
 OIvGENSKw6IUYeohSRYnQACrQCHghToOL6WWwNCX8gJy7tUeH0B9n8VmVXUw8aggPdio
 /iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545369; x=1778150169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cuo/I0qTAOKOsTUzJ1xXEABkBKahF/yrt2iDIGc7SH0=;
 b=BUWXm+YoaVVJmuZ3Qa7GcyifrDu4ityVYPWXjsNStMhOQ1EtGnIHWdXCbmCkoBuw+f
 mh5hnqOfTwjUL6xZ76b7YCa/v7VDx9Rb1l5tO7xPL54vgFB0xaq/pHBuanlgqwZD0Z5T
 OxOHcMs/WrOQm28FEvTUOIWVXbj+CSQtMu4acVlFtL9joOSys/3uT4slRn/57LkDRL7l
 Y6UFMT9DEr3NCHSA8TIPQO6OXB73DUwKvc1dvgwabX9M7ekyuxOLTF6vgZ3oZqYARtZT
 eiWEOmsXNnJz2Ac7cICnjm7UejMPgAclrr3pVZG1A139REZ0R5IsTISgcyapiWLuaEqY
 K83Q==
X-Gm-Message-State: AOJu0YyREZjVe4S0/3N/gbCOhaVGrFl3poCg1ZkRoX10HlR3kfCFT5Y6
 ksROy+oYMsJc5zQTcJKY6fgS0CU3tZ/HEYPSR5SeZk+do3AWKOIQ9GHN/3WWt+kvmPXFkiWwRvH
 y4V5XipzVXifIPw2loDp8O0Zp/8mIbzmIVvoIEE3RwxjrPo1hM+TMG4/8sqW0x9HdqY39zbtKoV
 88pT7l3NLmFt68WH3yAULU1JRaHDm5Z3c=
X-Gm-Gg: AeBDiesO5MXhBXHCg5pd3cFQJHxNPlxSEKKcUqv9Kir+4bXqYvO5ChZQSE/FBlcDFgG
 P5u0jgrwZWW1Q18FMOfGtG2fC8U949NZXS/EpYf3xchIYgzlY0P5Pwu1T6uw2nsbuC3FwxK5elT
 Sg0FM9LxP0bvnOHz+J8RwpOxQoIhxWhUH5CegHN9D1FLGO1MV7jBorlimmDKHCoSG/xjYr2pERz
 l2FwRnig6bidI207FBR99s3SetzzCagFtQZcurlCfRdZGf2/xmXqXCnT9gXYDAoQSYP4uYYimS6
 ZzhLgUw0HzQT68M=
X-Received: by 2002:a05:6000:220b:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-4493ef44331mr4252357f8f.31.1777545369042; 
 Thu, 30 Apr 2026 03:36:09 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-4493ef44331mr4252297f8f.31.1777545368614; Thu, 30 Apr 2026
 03:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260430090534.841894-1-pbonzini@redhat.com>
 <20260430090534.841894-9-pbonzini@redhat.com>
 <177754529909.1138192.2800708626696584583.b4-review@b4>
In-Reply-To: <177754529909.1138192.2800708626696584583.b4-review@b4>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 Apr 2026 12:35:45 +0200
X-Gm-Features: AVHnY4KTiDyDVBrmRrsmnBCc9v2KAoqspPAMWSgX5RqRe9C1kDnOVjrXgn3_TEg
Message-ID: <CABgObfaE3Jj-i2Qazeb7MxPOVJ7o4JA+6ZFVZfrshYg-poHCzQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] minikconf: modernize handling of include chain
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 30, 2026 at 12:35=E2=80=AFPM <marcandre.lureau@redhat.com> wrot=
e:
>
> On Thu, 30 Apr 2026 11:05:29 +0200, Paolo Bonzini <pbonzini@redhat.com> w=
rote:
> > diff --git a/scripts/minikconf.py b/scripts/minikconf.py
> > index 3d63cc6b21f..07a5152ef54 100644
> > --- a/scripts/minikconf.py
> > +++ b/scripts/minikconf.py
> > @@ -15,11 +15,30 @@
> >  import random
> >  import re
> >  import sys
> > +from dataclasses import dataclass
> >
> >  __all__ =3D [ 'KconfigDataError', 'KconfigParserError',
> >              'KconfigData', 'KconfigParser' ,
> >              'defconfig', 'allyesconfig', 'allnoconfig', 'randconfig' ]
> >
> > +@dataclass
> > +class IncludeInfo:
> > +    file: str
> > +    line: int
> > +    parent: IncludeInfo | None
>
> Add `from __future__ import annotations` with this patch or add the annot=
ations with patch 13?

Yes, I will move them.

Paolo


