Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E89C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 21:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHVVC-0000Po-Pe; Wed, 12 Jun 2024 17:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHVVB-0000PL-21
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHVV8-0002MN-O4
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718227645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oocnC6jrXx7PnVPiUtqm1FuGMZuhMeGZ4P0PvK33PH8=;
 b=BvtMuaDn8q74V2wOaK7wpbqfgpT87kxv4PK1XqkoPAw9q6VIALbxcCwDIibbm1xkft0VHf
 ia2dcHpQ0nAkAfmFdQN9nohe9Z3V/12Jd+9oO+FwpWF+y+n4BF4gUwZkvDLgbEVPZQz2Xa
 I+i0Xk2esj1rDc/jk9kS3gqUxB0lC6s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-6RE-qUd1M1WTHycY5Wyt1w-1; Wed, 12 Jun 2024 17:27:18 -0400
X-MC-Unique: 6RE-qUd1M1WTHycY5Wyt1w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35f2c0abd54so139924f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 14:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718227637; x=1718832437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oocnC6jrXx7PnVPiUtqm1FuGMZuhMeGZ4P0PvK33PH8=;
 b=kEeHMK3Vy6xKjvuwAvaKctj+T5soAHTijHN4O3mjPpolc4bltso1934h0GUiLj+LBG
 qSlIwUGg5dvN6G0c6vG2/H7pik0/rtul4uUuV3ohR9W2wxKZ+Z0CySAFp+6Z42tSWuY+
 MLETtH7n/5jKCiwPZ3DzSuvH8qVDxS2AKkDRgjVPnozmeXu7MaSlkwJ59sASe6SC5p+4
 sfmIDoYgFI8dx3lrUwN+zfYgZQpzf1mBNHonANk6K2W/61Lh/sI0B6O0NKIDc9wDomj1
 WqtynyUAiY/KvoYu5M8lZb33jNO3wLcYAB7InUaH2EQSemJPTb+94H5oNdiXOS7soa/v
 m91A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8jpbUUVOlAVVnS7T3tlqiV5m+2NIEAPjzsoEzNr45n7aCjQUwNXCjrhd2owFb18+rvJy3M2Mffpvcldw9ycDjM7YQlmU=
X-Gm-Message-State: AOJu0YyHDrI5epxsljY7nIlLwhI+Ic4wJcwmACR/jzSUPIElLDbJ1+oI
 YHVtDdkGRc7ZJgMnJbpF2HRqO5s5UtyzE3PdsTGhwoe9M2559ZXk9BcsURbLYgI3jftLSJhmnvr
 q4gmSxwCr5hmTkH/X4wTm3qGxwYWqJWX3UNFHENBcqUTXtSuxsb/+yccC/fEv8h7xDElspCOW4u
 I+L00k8UI6zChZMjV3NyP4QPdz8cE=
X-Received: by 2002:adf:eb82:0:b0:360:71aa:3f5d with SMTP id
 ffacd0b85a97d-36071aa4008mr514045f8f.26.1718227637422; 
 Wed, 12 Jun 2024 14:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYBirWSanZCnTWW8Uga/VvP3jEGVzZr/TUTNI7F/7paMrpxgFeLU7Qt5to32y7RehF6ZnVoNAdLZlXIRb/5/w=
X-Received: by 2002:adf:eb82:0:b0:360:71aa:3f5d with SMTP id
 ffacd0b85a97d-36071aa4008mr514025f8f.26.1718227637035; Wed, 12 Jun 2024
 14:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
In-Reply-To: <ezjl0.qx0tmsp6d6t@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 23:27:04 +0200
Message-ID: <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f30d03061ab80b54"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000f30d03061ab80b54
Content-Type: text/plain; charset="UTF-8"

Il mer 12 giu 2024, 22:58 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> In any case, it is out of scope for this RFC. Introducing wrappers would
> be a gradual process.
>

Sure, how would you feel about such bindings being developed on list, and
maintained in a (somewhat) long-lived experimental branch?

Paolo


> Thanks,
> Manos
>
>

--000000000000f30d03061ab80b54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 12 giu 2024, 22:58 Manos Pitsidianakis &lt;<a h=
ref=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidianakis@linaro.or=
g</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">In any case, it is out of scope for this RFC. Introducing wrappers wo=
uld <br>
be a gradual process.<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Sure, how would you feel about such bindings being dev=
eloped on list, and maintained in a (somewhat) long-lived experimental bran=
ch?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Manos<br>
<br>
</blockquote></div></div></div>

--000000000000f30d03061ab80b54--


