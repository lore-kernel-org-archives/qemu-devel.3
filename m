Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FDDD6408D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 21:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Wii-0004VY-Nd; Fri, 08 Nov 2024 16:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Wig-0004V9-II
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 16:40:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Wie-0001Ly-Py
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 16:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731102037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=buZL0C20gzAj3DRvEO8INFVW3f47CN7/As39GtDTuIE=;
 b=H64wesPW9lGSWDJwGmoKEC7wOlblJX9GqHJwjzXTDcC0rhI/y3VFK+bC75lxaXkPjA1Ow+
 kXW1DxLJC4QHz/cvshtx4wiVPLbdjbDG6Z4ovwOppa+Af+l/Q3OJDkaPk2HiZScr3iXyKY
 u5emi+eIbycqCpnp+2c+6pK7jFaTnxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-ELlLhwAVPam3ILJivmLYTw-1; Fri, 08 Nov 2024 16:40:36 -0500
X-MC-Unique: ELlLhwAVPam3ILJivmLYTw-1
X-Mimecast-MFC-AGG-ID: ELlLhwAVPam3ILJivmLYTw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso14874595e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 13:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731102035; x=1731706835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=buZL0C20gzAj3DRvEO8INFVW3f47CN7/As39GtDTuIE=;
 b=QzCHknkPVNZHA5/A/C4W46S+Ufq38TantVfPRt7pdkb8bjvSeh0hdAY5Zz2+THZsI/
 U7LfXm+dIqJ58qzXqEHRRYSYcSjfoUHOacUqHlbIWCAWbJGB+wP0wtfNL8mI+Ma7oxxm
 0flVDgIcI2vCQSU/k16BjFqdcYpuIwR5FXO6Y9vwZAsh4wumMHUJ7lJoLGgrQx33fRee
 qTWmHNOlmBEG6af5Gu7zIEK36kiHbj75slvdROH3Yjvj5hDBeOdaMEXab+EBlEAqaMPZ
 kq+EMLEIAAi0tjgCwRoElwdWnweDiXTgnyiXP9E1Xv5KW1ADTzNmhtxcDQOFREm3nJKK
 iKXQ==
X-Gm-Message-State: AOJu0YwfaGNIiA5wlgLCqzY+16oriiYdeEYgmiIo/MK54MBOGwa/UzOz
 ML24YBVBxzEl7NDS38OcXxrFL063hWgx2+dFjFJeSL5jxGvXyhsVC/IQwuZTOMrahsvSUJwrKhv
 +x8z7ZwoW9RVNcCVgVs5dCr4uZ/Q9QXE5VynWRrsia+tNSNdHrwlTbTFkR7E7AN46C+FMxpkxXh
 1dRbFFLyCGoW7asRLgxj64zHjGbFI=
X-Received: by 2002:a05:600c:4f4e:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-432b6858db8mr45404755e9.6.1731102034777; 
 Fri, 08 Nov 2024 13:40:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUrn1c5AdphyrSfh/w/fcE4iKeKWuTr3e+X4i7NQmpD4K3Fm/MladJfo9+6rquOsDu4TLK7j1jLgxUTJXIQCE=
X-Received: by 2002:a05:600c:4f4e:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-432b6858db8mr45404635e9.6.1731102034434; Fri, 08 Nov 2024
 13:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20241108173828.111454-1-pbonzini@redhat.com>
 <20241108173828.111454-7-pbonzini@redhat.com>
 <CAFfO_h7-1KMJoM46a=W8wv4-5VzKcYHEgTmT3GpFVg7E6tHyxg@mail.gmail.com>
In-Reply-To: <CAFfO_h7-1KMJoM46a=W8wv4-5VzKcYHEgTmT3GpFVg7E6tHyxg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 Nov 2024 22:40:22 +0100
Message-ID: <CABgObfYufeHsV73HkFJ=q2-ggh0ijO6zKNW=zzDTbQgD+osR2g@mail.gmail.com>
Subject: Re: [PULL 06/13] eif: cope with huge section sizes
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d5347e06266d99ab"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

--000000000000d5347e06266d99ab
Content-Type: text/plain; charset="UTF-8"

Il ven 8 nov 2024, 18:48 Dorjoy Chowdhury <dorjoychy111@gmail.com> ha
scritto:

> I was looking into doing some changes on top of the original patch and
> this check above should be if (!(*cmdline)), right?
>

Oops, yes it should. I will send a new pull request tomorrow morning.

Paolo

Regards,
> Dorjoy
>
>

--000000000000d5347e06266d99ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 8 nov 2024, 18:48 Dorjoy Chowdhury &lt;<a href=
=3D"mailto:dorjoychy111@gmail.com">dorjoychy111@gmail.com</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I was looking=
 into doing some changes on top of the original patch and<br>
this check above should be if (!(*cmdline)), right?<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Oops, yes it should. I w=
ill send a new pull request tomorrow morning.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
Regards,<br>
Dorjoy<br>
<br>
</blockquote></div></div></div>

--000000000000d5347e06266d99ab--


