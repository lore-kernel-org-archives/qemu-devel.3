Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6121EC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc3xu-0006Mu-1g; Wed, 16 Jul 2025 11:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uc3rk-0007u7-OU
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uc3ri-0001sm-R9
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752678971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ePfrTVRq6sn+0K/t/mCFoDM9kB0hv14LsTt++CRVbnA=;
 b=Bj5vYghCQ+v3hzg/B8vgpIh3FwENqOC+8qykCUnyZaVt/o7n1sLcjxDeYq45XmaREgWC4x
 ygBli2qQIdKtp6A6Y/swtO+qM3wIOPSSJh8biQZTrSfPu0Ri0aAbh+wYeOHMqTKqnKL/7O
 +0+P6dwzZG5hBRswG3jzaVJ8RTlr2bY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-S_oaO2JfOxSzCvZA7vkK_w-1; Wed, 16 Jul 2025 11:16:08 -0400
X-MC-Unique: S_oaO2JfOxSzCvZA7vkK_w-1
X-Mimecast-MFC-AGG-ID: S_oaO2JfOxSzCvZA7vkK_w_1752678968
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b3642ab4429so5124296a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 08:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752678968; x=1753283768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePfrTVRq6sn+0K/t/mCFoDM9kB0hv14LsTt++CRVbnA=;
 b=knJvsByfkv5hVczhnZYZ58sN3N1+DujVJoBNy4eJiLoAyquN9bBvvtSFe+2OZ9lWE2
 jkOWqZYpWX2iehAMnWY/3FUe0P4rT3tMmALoNqIExsEW5d4AQY5wNiHynmL9J4P84+uj
 GxXgRGuwk/WjlG6Qw6pKZd5bI0WzFOS46t/NkPFDIAf1LY7gMVTcnIRvh08M4NBpM6Tt
 nvWqLA/DNpO4lU6tVIcV0I5kZzpBuUJJliQcJGhWdOgHvWZP2RRd/6zKm7w8SWabFGEg
 YVfi+YVfxR8iMAmiQ+5tc/5/BcrgHHQ5T9MROwTolGo60m9AqqP9orpVQQVzHOy8op5I
 HFcQ==
X-Gm-Message-State: AOJu0Yy3UrMQWZL81+P3VWk6TW5zaIbL0+e9UfkHlYMkW/12xJ3xZeoV
 C+eQyivdepuYpcUiJjcIiWzUZWSRoSmZgHuPDZzi6D7cMqOBbwYIC3c3DtxlV/QRdIYpGHFA09m
 f/DWnc4CqX76fJnQkMzd0rOgWgaJY1benBW5TQdgVVXHqyrfCIRkipkHJPMbq+v8exZKULhY/Uc
 nQOzCUQOL0uj1O5t2r9IvPKpe7cyayfas=
X-Gm-Gg: ASbGncsE8GEC2UPuuNSaJMDUjvhX73LaTZtnSQ83fQoHHJCJWdKL+w0UPurN0U+Fc3Q
 B3rbvyu2PTfIc7NBGqggBEJgkI5hF7gFhHYbtCl5ZPZ9G5I3Sh9zOhU8pmCFXSuPYS3+smOz01s
 0lWwav68VNVxW1kSRh7tlOtUfdTvPsbr7MslcckX8Nr2v9H9S5xSQ=
X-Received: by 2002:a17:90b:1f81:b0:31c:36f5:d95 with SMTP id
 98e67ed59e1d1-31c9f3c3429mr4399132a91.2.1752678967651; 
 Wed, 16 Jul 2025 08:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCoxgdnN2kl/ZvbtZ8EvHn/o1vAd+0uyLqOVaD2hRjodgLmbRFcf4so0uh4Jjk0GsRhEs9yw+D1sXvWTMWGLg=
X-Received: by 2002:a17:90b:1f81:b0:31c:36f5:d95 with SMTP id
 98e67ed59e1d1-31c9f3c3429mr4399086a91.2.1752678967160; Wed, 16 Jul 2025
 08:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250715212848.171879-1-jsnow@redhat.com>
 <87jz48rxbl.fsf@pond.sub.org>
In-Reply-To: <87jz48rxbl.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 16 Jul 2025 11:15:55 -0400
X-Gm-Features: Ac12FXxCzhL3Z7QF3xbzvQnI8z12Zx_16IdpHnVo5X51Ng01JUsLc1GRofcn57M
Message-ID: <CAFn=p-aLpc4RMsq+2rc3qjQw0TcmOCz7sFN_Edovnb0VxXSPEg@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs, python: bump sphinx preferred version
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003e5234063a0d5f32"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000003e5234063a0d5f32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025, 11:04=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Okay to include this in my next QAPI PR?
>

That would be very convenient, thank you!

(And thanks to Akihiko Odaki for spotting and fixing the issue, even if it
took me a while to sort through our policy.)

>

--0000000000003e5234063a0d5f32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 16, 2025, 11:04=E2=
=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Okay to =
include this in my next QAPI PR?<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">That would be very convenient, thank you!</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">(And thanks to Akihiko Od=
aki for spotting and fixing the issue, even if it took me a while to sort t=
hrough our policy.)</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000003e5234063a0d5f32--


