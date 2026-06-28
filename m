Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EFAC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdnt4-0002Pp-8W; Sun, 28 Jun 2026 07:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wdnt3-0002PH-7d
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 07:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wdnt1-0008T4-O6
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 07:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782646877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEIvwfsuh5prhw9/WbnbAOfcysLJsGRnFhCaxm626ek=;
 b=D8tFjucN1bjeSKrYwIqglsLDkPEx7PDlNNW9PI4of7dMOpb1HShAC5htNR3aTQOA8g1yEI
 O7+1mD+uRVXRbAPLqOJT13R6kFEhmfF8YGOKqChfq/t1j/jqyZZoMiqCft2ujdFiSXMelz
 nK26gT1YiHpOxOF4RoI0IhZL5b3lQMA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-JB6a4oV6MuSIMw-J0D9N8w-1; Sun, 28 Jun 2026 07:41:16 -0400
X-MC-Unique: JB6a4oV6MuSIMw-J0D9N8w-1
X-Mimecast-MFC-AGG-ID: JB6a4oV6MuSIMw-J0D9N8w_1782646875
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so17338635e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 04:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782646875; cv=none;
 d=google.com; s=arc-20260327;
 b=iUDSx/ew9oJmLzZHKL2mVY17aNoMDODrDPdoVpgDj4YTKc+dWbl26Sh6PJSh9W14lI
 WuXgmceG82sKZCX+LJVkyfmqLMe1cmyCkfx2FOwng7+uVqdtMYqFR5CD1FMkWw6OImjA
 KN4YZGrznhJmVeTs5CXg5tlUCCwVv4MAtl0a8sOhAqYobUEcOwDKBolsSiPSiVnUrtiz
 6nNbUIBXpgdRqYra+uYNXtUaJvzpbRxsHbMEcPJSE7hi0I6t72mKH4pobT1OaorEZHu2
 F5nBkfm5/bobynh5JJP/Whtkm9eULA9t73MfLkKAWM/C/M8GwODSHOodctLcHm7UX7o/
 04IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mEIvwfsuh5prhw9/WbnbAOfcysLJsGRnFhCaxm626ek=;
 fh=xbDwZdtmIkHtzhppOucZjKOREKF0wGnrlK71Bi+Q0/c=;
 b=a/3IZbiQRAzwKzc3NdZs/RaWWmzc8+tKHvnfip3ZI6j9eTd+bynS8JX7nKTnZITrXU
 44jjjnUi24qk7U4zMqpRSPolnNinA6fS5ZDRS072NjGkxaLic/XynWYtXAPFKiNGqmDB
 rJVBk7gjGXsIyXYfTKUC2gPbgI4Wz15hbFGZzxJZxUji+lLYYH76yF4miAE+6ngN7l+h
 dfoTgSRDyCsofm28evnDA18JqM7W3Cm0BXchnHyYUsf9VKOHVNweMUAbvpqxg5UHtx8x
 MGlePwzfC7AlDvcurxyDkM+J1/IT9dc8oo0Ygh+gxp1Xa97CFJHgJf7NIsqaHGo6ME5a
 PYww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782646875; x=1783251675; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mEIvwfsuh5prhw9/WbnbAOfcysLJsGRnFhCaxm626ek=;
 b=PkfNEh1wIgPAVBS8JRr3+GX5QPZK3/GQo90opwcdXb6AdE96n0/JPyhstrwcEPlxQW
 UCukkkI85hgNTgVDE6Vg5qNZyCu1fXABjZJS5owIU3kOto40Tb2Rau2qA3cJwvamyylu
 28ZFcVtqy4ixMYoM/4cUCtYH5sKmyKoBq9OdzWyA/JlByhbLJ1P1tZxnhmMrBojyOzgV
 0oQDBwC1lE96yOTV7uZDslyusXsS8Go9t2HPso+xlargWI/SrXiM1lUmaFnS/KYu3q7Y
 fYov/PuwMYI45ZibtwRZmG1fCYCQaSqYnYzgZZKAO9M5AthsxWk/PLir8CDnTXS/hPwR
 Ex7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782646875; x=1783251675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEIvwfsuh5prhw9/WbnbAOfcysLJsGRnFhCaxm626ek=;
 b=j5uUrpkJkzqwsdDJO5XAKM3glN3JE+vSkFKx+IzwIXB3WcuDTgQ3cZBewVQR2vROMM
 3UjkaLx8iwwxILuXmNbh/hiKnZdK6iWzaJQtAty6eEOuSP/H+xM5YoaZqBACF3R463xB
 mbGNJgvXLFhVU09pKOZSGrijebTuL+bV/4Uq2wupJ4iEfwbbjj76epTERJPB5IZcqc6l
 jHqvXTBGehBMbGkUjPU950CMJH6FS0X+LGnWq6HDDwpQOOOBigvEs7k6LnI6/g9vKGDN
 lIAXfoy0dwVif62eJFzrR5Chj1uftjSiVNkQjtV34E4aNmIQRXRXzOQ1Evn1wM/Y6ie8
 CW3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8WlESGoN1X2hJpx1yXkskDNiiEKjg1xkojSuvyVaCfdhnnneukGhlF5yirINxOjAq1kn+zFyGjiMi@nongnu.org
X-Gm-Message-State: AOJu0Yznto7Q/EHavikNhzSDzq9RqJZ84x79F0jWXFB4t2ayIdTTQTjC
 /vU6ifxLNxamFBIsMmrutxdhOisQoDkh4BlWXCKnIclGci+RZlpgyxYvqBuaNxXQ6t5GHnl2hDb
 5rFLoFTkDy4TwJagsom6et1jrQ2CzrpvsYsda+zqIpH45xiU0D92HyRITKHV7rWpR0xlg8PM3nb
 C7o2BwQY8uNIpsrvS4TldXs1Iq9dYAPFU=
X-Gm-Gg: AfdE7ck2bKOIblm340qIJGxc3LLcXW1CcqTn/NSR4icV+el/8Dm1b+/fyF/GgC4pkoQ
 Ezk7CJ1IkuA/LqxG4vGQltXxOFwW3MKIMhPa5nyg04Lc+N8C1wcGzo+iUAEQ1WSkSggwNuXqmSO
 cNi5mpz3yn7McrLK8YLfKSBApu/s7++CltGBHjGGmXTvJncoo5HbNfFrkJuFJpKBIcEm47xxDQy
 oZqJVvknsgOV5E8EKbwlNQ05/3NYPdijw6OI34GUktRgUtDx9IM6hJoarRpEpZZ39UpEQ==
X-Received: by 2002:a05:600d:4441:10b0:492:7015:bced with SMTP id
 5b1f17b1804b1-4927015bd1dmr79772405e9.18.1782646874825; 
 Sun, 28 Jun 2026 04:41:14 -0700 (PDT)
X-Received: by 2002:a05:600d:4441:10b0:492:7015:bced with SMTP id
 5b1f17b1804b1-4927015bd1dmr79772255e9.18.1782646874489; Sun, 28 Jun 2026
 04:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
 <20260416121116.527927-3-magnuskulke@linux.microsoft.com>
 <4d47920e-f7f7-4021-b7d0-0d75ec4fb730@tls.msk.ru>
In-Reply-To: <4d47920e-f7f7-4021-b7d0-0d75ec4fb730@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Jun 2026 13:41:02 +0200
X-Gm-Features: AVVi8CeGa5l4jNuHfX79NTSQip6Fj-MqpLesOf_WPtotJJe9u__sT1yR-JDInnI
Message-ID: <CABgObfaVgKfDbn_K_tqbemoK=q8XLam-GWGMFg9fCFNO9axHiA@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] target/i386/mshv: fix cpuid propagation bug
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <liuwe@microsoft.com>, 
 Magnus Kulke <magnuskulke@microsoft.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b6da5b06554ed14e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000b6da5b06554ed14e
Content-Type: text/plain; charset="UTF-8"

Il dom 28 giu 2026, 13:24 Michael Tokarev <mjt@tls.msk.ru> ha scritto:

> Hi!
>
> Is this a qemu-stable material (11.0.x)?
> I'm not sure how matur mshww is to begin with, whenever it is worth to
> consider for the stable series.
>

I am not even sure anyone can run it outside Microsoft... That's probably a
no ;)

Paolo


> Thanks,
>
> /mjt
>
>

--000000000000b6da5b06554ed14e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il dom 28 giu 2026, 13:24 Michae=
l Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; ha s=
critto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
<br>
Is this a qemu-stable material (11.0.x)?<br>
I&#39;m not sure how matur mshww is to begin with, whenever it is worth to<=
br>
consider for the stable series.<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">I am not even sure anyone can run it outside=
 Microsoft... That&#39;s probably a no ;)</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
/mjt<br>
<br>
</blockquote></div></div></div>

--000000000000b6da5b06554ed14e--


