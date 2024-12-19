Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F08E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 06:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOA4W-0000bY-JF; Thu, 19 Dec 2024 01:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOA4N-0000b8-BG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 01:31:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOA4K-0008Og-VF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 01:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734589889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jsx8h249WxpVgl/ARc3kRdycQhSKY/AaHGzTtsQ5gNc=;
 b=Q2NFvJMHwGOqXsCNWULbGK7uPiwAx4jn5HcZWUdf/SQeq3BO7Gs0DNK5fNKOSWXYi+uZp6
 0YoukT3Mgg6UC9lIBrju2bPVbzFEe9Wwq1l4e9LJQlUSctXSz1DoChVT9eBd69CfCQWW8F
 JWdGoJET+XQg6TOKXGz3NqWZdwJonUU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-y2DlZYm8OimXvN-ZFQGVWA-1; Thu, 19 Dec 2024 01:31:27 -0500
X-MC-Unique: y2DlZYm8OimXvN-ZFQGVWA-1
X-Mimecast-MFC-AGG-ID: y2DlZYm8OimXvN-ZFQGVWA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e9c69929so197372f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 22:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734589886; x=1735194686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jsx8h249WxpVgl/ARc3kRdycQhSKY/AaHGzTtsQ5gNc=;
 b=bPrgI24xpLQB7sN4nnUmpMaOmvDgROr17n72QXjSK5zfL6UnVElWsjFn1gNKUNKBdI
 hn29Bor4vhfoVknybyrWeaQcpoRDyB6JDYLR92cNHkqUOPlwVrGbU+yZcZ35xU5RRF4Z
 lnp4occdEaRRkNRTbpVfW/y5NRvfQt6n3oF/B7wKEjW1SFjlCNWqLAET4BrMzJsXTspw
 Z11ZX8w6oln3jZydggZwDL2cSE6d1GH2O+karKxyECpKDeeWWeG40VXya5ZVWh0wVfgC
 YZor0D/4aKC+IFWRgN+zuwdlWtgweiVCnEW0f4L7ZX8frIXaQ5+HxwY8iSJRjO9WRYJi
 Bruw==
X-Gm-Message-State: AOJu0YzHfhWPT3iL+COvU6qQolMpICDDCz2xlbJW1x3CpyAV3DGgXkUA
 2wGxZ1kn1EgQTgIXTcPMYvNg72b5GmEDqoL3zqdhwGF3QkHkFxnAfo6nRWVRF/fUH2phKZNRuj6
 CTRtKuv+YDzpjrK44iZ7GpIcK7Xi0q8XIYr9KZP2/BdN0THTEdh0uivAYylZzD48pPiWlCUk9lA
 s7k3ZSGQ22lWyEs1i4BgtLdj6qi0Y=
X-Gm-Gg: ASbGncuRxHSvZRkS8xORITYyiQu/3mco7PMjpWj52M2pm4qB/XMyWUpXZsLfegXlo/n
 cmhkiTGZu1T1jMqVaTrLwGFBxmpswEcsqVmctDQ==
X-Received: by 2002:a05:6000:79e:b0:385:e055:a28d with SMTP id
 ffacd0b85a97d-388e4db69bamr4223570f8f.57.1734589886577; 
 Wed, 18 Dec 2024 22:31:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM4sscGNRGV0K+4r/N79UUPlg8jsZycQ2xPTUVzviN35atlEki0drZQzzKUhgvXA7lAvOhpLWkasmC3x4xRnI=
X-Received: by 2002:a05:6000:79e:b0:385:e055:a28d with SMTP id
 ffacd0b85a97d-388e4db69bamr4223558f8f.57.1734589886271; Wed, 18 Dec 2024
 22:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-3-pbonzini@redhat.com>
 <Z2OjU3CdoBFI7xA8@intel.com>
In-Reply-To: <Z2OjU3CdoBFI7xA8@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 19 Dec 2024 07:31:14 +0100
Message-ID: <CABgObfYaV=70CT0WoV2_CGVfnqJbuLSwXurGg9qgrKAtxNwzSA@mail.gmail.com>
Subject: Re: [PATCH 2/7] rust: pl011: match break logic of C version
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000000ad60062999ae7b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

--00000000000000ad60062999ae7b
Content-Type: text/plain; charset="UTF-8"

Il gio 19 dic 2024, 05:20 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> But when I double-check where to set up the rsr, I realized that the
> rust version and the C version seem to be inconsistent?
>
> IIUC, I guess Rust should uses to_be_bytes()[2].


Yes, that's patch 4 in this series. :)

Paolo

[*]: https://doc.rust-lang.org/std/primitive.u32.html#method.to_be_bytes
>
> Regards,
> Zhao
>
>
>

--00000000000000ad60062999ae7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 19 dic 2024, 05:20 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">But=
=C2=A0when I double-check where to set up the rsr, I realized that the<br>
rust version and the C version seem to be inconsistent?<br>
<br>IIUC, I guess Rust should uses to_be_bytes()[2].</blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, that&#39;s patch 4 in =
this series. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=
=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"></div><div dir=3D"au=
to"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
[*]: <a href=3D"https://doc.rust-lang.org/std/primitive.u32.html#method.to_=
be_bytes" rel=3D"noreferrer noreferrer" target=3D"_blank">https://doc.rust-=
lang.org/std/primitive.u32.html#method.to_be_bytes</a><br>
<br>
Regards,<br>
Zhao<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000000ad60062999ae7b--


