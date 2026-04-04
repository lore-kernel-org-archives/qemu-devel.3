Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F0AE88D66
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 11:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ynG-0001nv-OG; Sat, 04 Apr 2026 07:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w8yn9-0001l4-5n
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 07:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w8yn6-0002Vh-Bk
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 07:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775300626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cqXqaPSdUnRrX/cCnZt4GbAwTGazbRdhCHgsI5DnClo=;
 b=YZpzCF7UqQ2xsKW9EGR8rBKO5jtYdIwJE9leYryC1RgYrsDoyRsNTrY14URosM13iaimfb
 1pd6hzmL7IW1bAF/ibO6SQcQYH0X57HhOZ5RjqpC+lqbF1i3TLs/k65qZhy2YEqT0vnOse
 ufLngIqf6UQ7JMKOqj3Wfu2B2oykS/4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-_Gt7fNfwMpyfQjlqMQubQQ-1; Sat, 04 Apr 2026 07:03:44 -0400
X-MC-Unique: _Gt7fNfwMpyfQjlqMQubQQ-1
X-Mimecast-MFC-AGG-ID: _Gt7fNfwMpyfQjlqMQubQQ_1775300623
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so34136365e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 04:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775300623; cv=none;
 d=google.com; s=arc-20240605;
 b=I6ix504LY4r+/JNatEkv3+S8gJz9ebaxvSN05GEU5uyuyPWH3t1A2hIzn6OnBIJsvY
 344134Z3II+Uh6/0WDyEx5dt/uYORt6hOC7aJsES7lQjmBL7Ne263Kp9997igRNgtX8a
 FBDBekVUCReCAK0oxY6W1o+kBN3f/u36LEt2ys6JVw5gxFmedeQgA2tOJua6cHuHd9G5
 ZEM0nawgA/tKHQ4H5i8hbBmqb0rlOWVJz/Xo9QFkf9iA3ldbNwQIxVqZzR0HWgYj5aqq
 ADAmAT8hXQBxgDJ6h5FVR9U+Ymuhmye9BNj1w4ilDZojqsHQWjcNhpQfx85Zsww9AATa
 W2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cqXqaPSdUnRrX/cCnZt4GbAwTGazbRdhCHgsI5DnClo=;
 fh=5hZJEXX0Gn3bRuB26CPDi+X/5+IzCk2jpdmIzNkkhAg=;
 b=Bu+pqASBrYgL1Hzb+/kUSobhq224RyiV9ZpSZH/MaUxkDV7hMuCgMFfDUz11YG8wkp
 VGvLZmwKtv/c8fH19GYf/HuSMy4JBG/nd0McTVZQJtZFk6gu1k172e2Gz4+xoFudFK2Q
 92Y1+MHpAYp7nGggjJwoIg2Z6/z4Pi0ZukdAMA1Y+ZGy9H9UNo04TGv5lyevAcY86K4J
 jexFBuOTOhKhXWEsVLH8TGqxlAUItmaLvjSmD24QfDMZuvHYwKUrPXZ0EkyCBn0sf4UY
 YpmaLfv086SRtHAePJZU5CqAkv66Mv0lbqeCdr+Xv8D1EdzsSCaDfeZ14GlMOt1xdajr
 MAjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775300623; x=1775905423; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cqXqaPSdUnRrX/cCnZt4GbAwTGazbRdhCHgsI5DnClo=;
 b=A0CV2wn1isMGImEIBz1EIZwf0viJ15oQelsJ/eQNrkNKrzQ2DzeP+pbsMNRsAeEE6U
 +BLO0noRPU+2BhgvPel5Ikv30LzsdLj2JsUBF3h+pMeQpS0g47kR0wfPhSPT63hqh7KV
 YuyTTWxg60pu082gAjhJPp7X0B0iA4NEopC4qlQPtIzqi5AHJ+iM0UPJ0ccTqXQl5Thb
 /txcJNPcco77bold128r2PBBytLeZYK4E5dq44nJjCb99QZCyt62Np/xg0US4Erv3q5I
 08EJ9fjgbZv7nRQAKoDgumSwSe8qaYLkGorzXwEyPXOc2Aorxzj1X+3Hs+hKe1wg3tP5
 3NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775300623; x=1775905423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqXqaPSdUnRrX/cCnZt4GbAwTGazbRdhCHgsI5DnClo=;
 b=Gemuuww1LjAKD47qNGh81vnZG1xMQ95ZyFUGKJXFVbuyfcI/v4/JI2fdFcXbnSXKVE
 RlSd3TlsB8vqu5uVOdjmq2kfyc3R/G1b8Z6Y5koHjcOXSLroCZliAczH3K+BmYs4SO2y
 zKOTDkaDBtKXJ0LgPN1b+7G3tmNHDJ0r6mHVNCk1OCXR44jUZ3DR2jnXbBnWuy0zJwiF
 KxQT+19pxgCeGmX3XYxENivliAge0aGIwceLDdBqNKYHRhyGEmlmqvtXXyIVkaVseD9x
 iN3EAkmSTE2URR81pZ896bJVlldKVV+JHk1DLBjBksHXrlE6xXgIHJZN85426J4/TNt0
 h4Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKqL+PX9R6V4JGbVguIcQ7bDgpWBeVNnPWnDtXjICDWWg1Mi9MjHX7LTAE6xIoMW3DWPi2g4BrH/DD@nongnu.org
X-Gm-Message-State: AOJu0YzH3amWIJueFB7BOz9x+wutS8bPzqtCmfq4+4kXr/GJ/VfnAP9A
 gVpgsOS4z2Wdkie78TiyB/ZJrfYy9wzC2V2DEmXLsYWqILJ0tvof7Ex/Tzb+5A7pFZ7xZFUrCrB
 kcyypO4im/1poyLWebKury/Rk+sDHn/wt5u8SKNfGbanQmTmz0VUN0KcbYHZ6HDR1sFFERQnipA
 d1IR44I887eJWNZT0Fn8COikfWw8ndpOg=
X-Gm-Gg: AeBDieuqbQ3Vs/xSzqrd/r87DKlLNeAYcP2CG3AKPFM0beQP+Vtq+iJnKXZT/rfRwnD
 fS9HRSwb/HZSRU4OicYucvGqZLWpdBQIir8jaXnPVqn+bWtgslZgbO83/Sp46cq30BMszhSXtMw
 Lo7xDTpUYqpvfrOQ+B9jLYNl9/2SUkXOllkxml1hDyX4S4ug1z/FKXTJejD6bPicmfXKtjxArl+
 2pktI6+hMLwNWWSiB8vQx4ICkMUDmuVWgCCvLYCoGA7Z64GmU1+FUTsMnRG/4w4SwUhZWPzhYRS
 OpeX
X-Received: by 2002:a05:6000:611:b0:43c:f8a7:3b09 with SMTP id
 ffacd0b85a97d-43d292c7739mr10409124f8f.23.1775300622800; 
 Sat, 04 Apr 2026 04:03:42 -0700 (PDT)
X-Received: by 2002:a05:6000:611:b0:43c:f8a7:3b09 with SMTP id
 ffacd0b85a97d-43d292c7739mr10409082f8f.23.1775300622347; Sat, 04 Apr 2026
 04:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <20260403104327.1163942-7-mjt@tls.msk.ru>
 <eb9b80b4-78a9-4a0e-be63-aecfa8b426c5@linaro.org>
 <64e92c21-86b1-4828-b9b1-a7372986288e@redhat.com>
 <0b5eb7b7-7b99-4170-9553-fa92c187b9a3@tls.msk.ru>
In-Reply-To: <0b5eb7b7-7b99-4170-9553-fa92c187b9a3@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 4 Apr 2026 13:03:30 +0200
X-Gm-Features: AQROBzAlVWwaDpS64vPWRXwipA3dOxUfNrTjJXe8QxgzEiQkHB-fhS_RxXHA0og
Message-ID: <CABgObfYPjpQxHXOf-fQ6ESGP3+G8giEUrn2kTC+DNh5gFz1dbQ@mail.gmail.com>
Subject: Re: [PATCH for-11.0 6/6] RFC: Allow building qemu tools on 32-bit
 hosts
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f700f1064ea062f3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000f700f1064ea062f3
Content-Type: text/plain; charset="UTF-8"

Il sab 4 apr 2026, 11:51 Michael Tokarev <mjt@tls.msk.ru> ha scritto:

> On 04.04.2026 09:38, Paolo Bonzini wrote:
> > On 4/4/26 01:49, Richard Henderson wrote:
>
> >> Since the goal is tools, which do not have to interact atomically with
> >> guest emulation, we can fall back to libatomic.  But that requires
> >> that we make the meson.build changes to actually link with libatomic.
> > I think we should just do the guest agent, and limit tools to 64-bit
> hosts.
>
> What's the prob with the tools on 32bit anyway?
>
> BTW, tools doesn't even use atomics, while qga does :)
>

They do, and in fact Stat64 was removed as part of dropping 32-bit support.

Tools share all the storage code with system emulation, which is way more
complex than qga and would be mostly untested for 32-bit hosts.

Paolo


> Thanks,
>
> /mjt
>
>

--000000000000f700f1064ea062f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 4 apr 2026, 11:51 Michael=
 Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; ha sc=
ritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 04.04.=
2026 09:38, Paolo Bonzini wrote:<br>
&gt; On 4/4/26 01:49, Richard Henderson wrote:<br>
<br>
&gt;&gt; Since the goal is tools, which do not have to interact atomically =
with <br>
&gt;&gt; guest emulation, we can fall back to libatomic.=C2=A0 But that req=
uires <br>
&gt;&gt; that we make the meson.build changes to actually link with libatom=
ic.<br>
&gt; I think we should just do the guest agent, and limit tools to 64-bit h=
osts.<br>
<br>
What&#39;s the prob with the tools on 32bit anyway?<br>
<br>
BTW, tools doesn&#39;t even use atomics, while qga does :)<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">They do, and in f=
act Stat64 was removed as part of dropping 32-bit support.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Tools share all the storage code with sy=
stem emulation, which is way more complex than qga and would be mostly unte=
sted for 32-bit hosts.</div><div dir=3D"auto"><br></div><div dir=3D"auto">P=
aolo=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Thanks,<br>
<br>
/mjt<br>
<br>
</blockquote></div></div></div>

--000000000000f700f1064ea062f3--


