Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADDDC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWf3-0007Ao-B4; Thu, 01 May 2025 12:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAWeu-000771-Fi
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAWer-0001UC-PC
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746116468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HVKrUdJe1wYUDC9Uydj05qe8X/SD/VRyneT9qiiCQuc=;
 b=N2je2PuVx5CXpTdDINxY3PuRj0S7vhfMTrJXeeZOWx/WhTDs04L/lnd4zIzR9qHDimn0ga
 ocIPCcUig2dJi/izYCsT5tKKwRO0PBa8O9Wbq6iHytKLqlP5P6+ydSHPmBSBcYKnd7NvWM
 F0j74xF3A+1XuX3kqoCmriV5bk1u+T8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-s83uTMxUMNqa4n-oAkP7FA-1; Thu, 01 May 2025 12:21:05 -0400
X-MC-Unique: s83uTMxUMNqa4n-oAkP7FA-1
X-Mimecast-MFC-AGG-ID: s83uTMxUMNqa4n-oAkP7FA_1746116464
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39ee57e254aso536424f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746116464; x=1746721264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HVKrUdJe1wYUDC9Uydj05qe8X/SD/VRyneT9qiiCQuc=;
 b=qATCQSO+zMcAatBd/vv+bkklqguAPgqJjDZsLfLbrTrOC0eMGkiRgDNkyhq250hcZ0
 TVG2D06ZgSlAcixKWhDurTB1/u4Y/D7GeYBzxWIdb1CbTsVz7KGN1jv/IRr3R3O2/L41
 lz9OILA8mgu2HHqpgk4rrh227EvAcMN/drYCksn9GuZdFH9fakVVhXFKUOmivegccvmh
 K88YH/Zahuu54BQ+zGr1F9s3aMo0LxTD9/03w7huby7CVreOnLjdt3u3qI2i9xmwpa0j
 jqLtghJsXXBZqzrPuCmxo+CwSbD9uC78XNMO4utJNVz6Z/0X0c7QOg4a2JLFU4wJn9fk
 wNOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtfFPdUJIK5zgMz+86ukPOVcVdvplobzaScndrODPIJIYh1Fc9Z5qSRkoPnS9+R87foTNBsLAST57C@nongnu.org
X-Gm-Message-State: AOJu0YxcvR5J4tzsOUk55wuNuuYT+yM7BqvXq0VNq62tF2/AGCKYW29x
 12A/7bT/wx7kgzk9bVsllMwM9r3O5vAzZD3QhEJyvEpiUYO50bOsqbUlrlO+R/QR8EIC1k2VbqP
 djon0p/m3ZnqJGSrvJhqTE41yRpBfvaS9f68JIr2mqwt0umLprL6lVgEucsvl+FHWgTuign1bYg
 YqZIz2jL9h5zY/DIsHo4BbwfWbwZ8=
X-Gm-Gg: ASbGncvBRj2SG/4bNlaxMl+lqnUWzvN8kh8T3HJK1/ZUcMSPzKsKbcXDd41+vRIqHKg
 REcPoha3CAsDYx0WVURQngJWUEcKillxNSxMGBBfJ1bKtUiuYGGwvbm7xizpEvpb9wNu0
X-Received: by 2002:a05:6000:4310:b0:3a0:7aa3:cc74 with SMTP id
 ffacd0b85a97d-3a08f75250dmr6586549f8f.6.1746116464404; 
 Thu, 01 May 2025 09:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiO+cfTX1fq+ichGvQ2c37D9VtoYR3dhvhkaKShw4clsB1BsDjf9xm5pBUdlLjnvH9qJf0adaU3/IIz90F7A4=
X-Received: by 2002:a05:6000:4310:b0:3a0:7aa3:cc74 with SMTP id
 ffacd0b85a97d-3a08f75250dmr6586536f8f.6.1746116464118; Thu, 01 May 2025
 09:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <CABgObfa-ViHvve=oqV-Y88ghXGkevu1wTug=+24E4dKuG54c3Q@mail.gmail.com>
 <CAJSP0QVpxQDfuBOQiMyP41ufaJ=56Xh2sRhWSON=FvVuxDabaw@mail.gmail.com>
 <aBOYZsfT0retojQf@redhat.com>
In-Reply-To: <aBOYZsfT0retojQf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 May 2025 18:20:50 +0200
X-Gm-Features: ATxdqUHfpV8wM2cTb6yj5JWEd7fM3INfLEjwzVca6241NIGV2wvTIDH-zaQzDgU
Message-ID: <CABgObfa9O6V00H9Z7iawvUZWvXqQkj2XsdXejPW0tjXb_a7Erg@mail.gmail.com>
Subject: Re: OSUOSL in trouble
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Hajnoczi,
 Stefan" <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000094a68d0634156baa"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

--00000000000094a68d0634156baa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 1 mag 2025, 17:51 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> > Paolo, please let me know how I can help with migrating VMs or setting
> up a
> > CI Kubernetes cluster on Amazon.
>

Since in the past Camilla did it but I am not sure if she has bandwidth,
let's run it with Red Hat first. All I did was give her admin privileges on
Azure.

In the meanwhile I will start migrating the VMs.

Please ensure the any new CI machines for gitlab have persistent cache
> enabled. Our functional test jobs are still downloading images on every
> run due to lack of configured cache, which makes them unreliable when
> sites have transient outages, as well as making jobs slower.
>

Thanks for the suggestion=E2=80=94just to be clear do the Azure runners hav=
e that?

Paolo

>
>

--00000000000094a68d0634156baa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 1 mag 2025, 17:51 Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
berrange@redhat.com</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
&gt; Paolo, please let me know how I can help with migrating VMs or setting=
 up a<br>
&gt; CI Kubernetes cluster on Amazon.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Since in the past Camilla did it but =
I am not sure if she has bandwidth, let&#39;s run it with Red Hat first. Al=
l I did was give her admin privileges on Azure.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">In the meanwhile I will start migrating the VMs.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Please ensure the any ne=
w CI machines for gitlab have persistent cache<br>
enabled. Our functional test jobs are still downloading images on every<br>
run due to lack of configured cache, which makes them unreliable when<br>
sites have transient outages, as well as making jobs slower.<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks for the =
suggestion=E2=80=94just to be clear do the Azure runners have that?</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
</div></div>

--00000000000094a68d0634156baa--


