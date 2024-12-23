Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A9CE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 01:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPXGp-0000hf-N6; Sun, 22 Dec 2024 20:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hhan@redhat.com>) id 1tPXGi-0000dZ-Bb
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 20:30:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hhan@redhat.com>) id 1tPXGe-0000W2-6o
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 20:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734917394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7hA3AZRVD4+1UKEu0JMZr10iSIMDRUaEYs3uUl+qSoE=;
 b=JfxUX3qobXRofk1kLGXG1PiCYKVVORnofx4qj+r5DwyUJlfC8U0mViqyPnl7x1yIUqH/6R
 nH8tKHXTEDXEak6KhrKdBut6TSGKS6xqGzxF7TlJJJvrwGatQq0h7gNszJMdaLr9hGzeXW
 8Xo6PxFMExJQzA8IvggVg0U6ZDglw2g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-V122mZPQO4CIXCRNbjgrPg-1; Sun, 22 Dec 2024 20:29:52 -0500
X-MC-Unique: V122mZPQO4CIXCRNbjgrPg-1
X-Mimecast-MFC-AGG-ID: V122mZPQO4CIXCRNbjgrPg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aab9f30ac00so303418366b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 17:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734917390; x=1735522190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7hA3AZRVD4+1UKEu0JMZr10iSIMDRUaEYs3uUl+qSoE=;
 b=P4xgo9d8TqD9mnSlLpwGvvUVdxibxPT0HaynT7nj3oRYVqiS/T8Cidk7K8IlRoZocK
 D8FL93CO/XPERR1gICBfSokDMcXzrjXg8FfNzn5IW0AT+S4ZLvgseLLG4YNKxX3TY0hy
 jkuKUDsw6ardq9EWqGRR4FKcGyzkqER/7tCyvJEOMv/aHUuYJx/JMB8XGv93UwVmeFvx
 E06SgJS9GqQ2rflV9w57RUSNKOQcUpiHuv7db+ls2FY091lw1izbbjHAi7GZAKnbWJri
 QVyzS5wvCB4u8E5MozztOTW0S8tcrMgWv9hiKH06boPQExheZ1TfEEK2g+ioieqSYuhe
 67lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdXqP/DktfO9c1EbAL7hSyvvUVFTAKzbwQwBrelcITbyvel180+XtFw9mVWUvJ7WnHWGGZyjTC+etX@nongnu.org
X-Gm-Message-State: AOJu0Ywa4e5yvU9mavtdQa5NxbgFIm7k+QPKYj6AU5RBbGepOz5y5Kyk
 rifR4dBty/E9tS1aNPUU3lJi/0fLGVdsbJ+wfEHTHTltqmrx9sYQM88EpbcQOzGHOEsQFoTdF4w
 Ah6IE7/taAC0F499Vm7auu7wq8Sfdq/I6F0NAnasI0p/gghKNMxjZMo0jWLeCObfZ7VX+dWhDw/
 iS8lNH3ogwJPLqDl5wrp/dfBr6Fns9r+U9V3OfhA==
X-Gm-Gg: ASbGncsUb/KJp/CLCYFYqzy5Cs/pnjd4EF+u+XbgxRWBgIGOjiSeSGSpFRWqLKX53/I
 dZylFDN8tMEby9uqSW77JqH73k8jWKL+P8pm2gw4=
X-Received: by 2002:a17:907:94c2:b0:aa6:19c9:ad08 with SMTP id
 a640c23a62f3a-aac334f31e9mr1019650266b.48.1734917389903; 
 Sun, 22 Dec 2024 17:29:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh/SCuGFH17Wt8QTW7Xb7oYn+uANG7jweu+1VS+Sne54cVlEXIwyekuvJh2kadoXhF0ff0aEB3Sp1Eet+3WkY=
X-Received: by 2002:a17:907:94c2:b0:aa6:19c9:ad08 with SMTP id
 a640c23a62f3a-aac334f31e9mr1019648966b.48.1734917389641; Sun, 22 Dec 2024
 17:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20241219085141.1857343-1-hhan@redhat.com>
 <710b775b-41b6-40ae-8467-dea9ddc3ecf9@tls.msk.ru>
In-Reply-To: <710b775b-41b6-40ae-8467-dea9ddc3ecf9@tls.msk.ru>
From: Han Han <hhan@redhat.com>
Date: Mon, 23 Dec 2024 09:29:38 +0800
Message-ID: <CAHjf+S-OeNVT=KQxVEg6MW4efVTfXy1iTb85QyL6Zja62PD0fw@mail.gmail.com>
Subject: Re: [PATCH] target/i386/cpu: Fix notes for CPU models
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-trivial@nongnu.org, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b97ada0629e5eee7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hhan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

--000000000000b97ada0629e5eee7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 4:59=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> 19.12.2024 11:51, Han Han wrote:
> ...
>
> Applied to the trivial-patches tree, thank you!
>
> Please do Cc: qemu-devel@ the next time.
>
> OK. Thanks for your advice

> /mjt
>
>

--000000000000b97ada0629e5eee7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 22,=
 2024 at 4:59=E2=80=AFPM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.=
ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">19.12.2024 11:51, Han Han wrote:<br>
...<br>
<br>
Applied to the trivial-patches tree, thank you!<br>
<br>
Please do Cc: qemu-devel@ the next time.<br>
<br></blockquote><div>OK. Thanks for your advice<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
/mjt<br>
<br>
</blockquote></div></div>

--000000000000b97ada0629e5eee7--


