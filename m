Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A625E8FDBE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 20:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZxBS-0002Rq-P9; Sun, 28 Dec 2025 15:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZxBQ-0002RC-Hm
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZxBO-0002Jr-Dl
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766952964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kD3BmLCLFA0gPZoalspggDI2AuO3FXcQde07PKc7p98=;
 b=P5mzlZihKAMGQmfDNQqFV0tH+B4yxnULkKySPVm8zzK8o+A4egbc7Mk4Wq2/SQ8lCdIWoN
 R/L4jo8989f6/qDunrjtLx2max+8L9LywZThyeJDHPJoI/Xi8gIkIGrJD7PX/TIYH/05lg
 nBLGVivIYNMxX2X4b2jzt+wcdPO0T7E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-olM4ZacYNG23Hyq5FcWHWA-1; Sun, 28 Dec 2025 15:16:00 -0500
X-MC-Unique: olM4ZacYNG23Hyq5FcWHWA-1
X-Mimecast-MFC-AGG-ID: olM4ZacYNG23Hyq5FcWHWA_1766952959
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fcf10287so6003721f8f.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 12:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766952959; x=1767557759; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kD3BmLCLFA0gPZoalspggDI2AuO3FXcQde07PKc7p98=;
 b=ZmYJ5vKFTnL3RPZQrCcQPIIvLD9veOIWaylEspXCmGp60EETO0LqTfBvEghgfWhoBY
 NzsvIrtVybNCh00tnnMtsHZxy/xWIHySdA0kr7nSkp9XOFMsvSSq+Wh+FJGUE5t4mNck
 ubAA9PLc9oevNjc3qx+JhZY8Aa723G9UqqnDZK8xTqgwLquEbLtE4hAaI+IhbIfHG88D
 8mUZMADWYsej1DpaBp3mlpjELZxMrQhH76+IYQBoBgKm4c1yZAwMdeOBKiO9Dvi80HnN
 Hxoh6KE1pSg5tp/Lq2PpAzAAcMWE40w5ZcdRVGB9rjFS5zWncxnV2hgQ4dS81Po7OtxI
 GFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766952959; x=1767557759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kD3BmLCLFA0gPZoalspggDI2AuO3FXcQde07PKc7p98=;
 b=aSUSKs3W4eRo4TWa54oFstNaexcwzzE46mW3EMEB/rY8Ed02qqvW3tS7GKVLPkUW5x
 8xyXYpCPWy1TQrhT8eSb0fn91c74O6BIs3sNcd6e4PM42dx9A57WOoGFI90VPm+Y2m/Q
 qJKgExDQzY7www75DH9c5iW/keRkwrK3DIjeAsnbsVslbmF7dnjjcMNlA6pZ+3KUHoHe
 /0FgoDmR7U//NZIZ0Rzg4iAXki56nKhO/rt4UEjb6l56Nm3STgygClDiBnG8IkkJqIeB
 0M1My4xbgFil0242DdxGANBzp5JYmzuC9pV2cKhT5DHEhsQPaINf1U12PaOK3cKGcmRc
 WFiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ/yqqW0ZG1BNcKy9FelBNhTAY8vWKuVBvUwg+nXH6oQC86nocpEG/Ie6II9kYeY4LCLvYLf7xTJsI@nongnu.org
X-Gm-Message-State: AOJu0YwkdoHdI0t7SdIYjojzfLC1gXHkI9tRPqaIPIHQNqFTg1KOhiVl
 Sy+PCkdITETT/aCv44HKdD2fv+P6W/6JFwLQF/0OJgkUXUkRlXYUy0/zm5gwfA9QGwQLnGjLiRt
 96/AdXO9j3ageY8uY3xLBe7chHe/OGsLwWhFUIl/XsS0FHFdvBAjM7a0egV94uVVPS961Wi0BWT
 tOAl7QhXXJCNbStW1c8LOI+LVs2CuC8ZI=
X-Gm-Gg: AY/fxX7mZbH/94h+++RGHbDsjKqGyr1tz2KO8XRwp9O5JOXmKpfWOiDuLd5xiZJety0
 i139v7n8HTNYyKeZ5OYVU7IzE0tefIcZ2NHAj6OPssMJvlMMX/wr32C2C4z3vQXi0WOAQs9L7dJ
 lFZqJdjoT9oWA5+3NL98evBXbcXirT6D1D30N7FWM7iqvN0eq5I8cwpPMNltA582LYc/027lix6
 EevdZtwjnqy5k9Uh4sLmFuBsmQ/XctHaSuylRfPH/79aqaeBiUgb2sLXM6erQVAg9CFiVE=
X-Received: by 2002:a05:6000:4014:b0:431:2ff:1289 with SMTP id
 ffacd0b85a97d-4324e4c9dfemr29604873f8f.16.1766952959129; 
 Sun, 28 Dec 2025 12:15:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHn6/JEeotoaKjLOCldyFHW7HfsO+JAxeEpgpeya2nq22O8ySyRoEFVmFbB6I77oGfTeOzr2ovfLxdLOMFlXc=
X-Received: by 2002:a05:6000:4014:b0:431:2ff:1289 with SMTP id
 ffacd0b85a97d-4324e4c9dfemr29604858f8f.16.1766952958721; Sun, 28 Dec 2025
 12:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
 <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
 <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
 <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
 <CABgObfaXgpdPe32ks+xkzOuNxvJMJhsfpvtjFobBJTueR1X24A@mail.gmail.com>
 <913b7541-d8f0-47b9-8523-9e1389bf4f84@linaro.org>
 <CABgObfYXW7RqZjqHVQd8T-RfZvy8oxb7-uWK0Au1W5VXzHVSNA@mail.gmail.com>
 <1b73aeb0-fa3f-4ced-9c07-5f0accebc324@linaro.org>
 <CABgObfbquY+4KqQn+o5nKhWPuFJnOB_LYTJzVCjF-GgH8VcQNg@mail.gmail.com>
 <CAFEAcA-s=w6+_mEM7pq1Z49OOkQVpOGGS-xqqjEjT5VNqX+FSQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-s=w6+_mEM7pq1Z49OOkQVpOGGS-xqqjEjT5VNqX+FSQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 21:15:46 +0100
X-Gm-Features: AQt7F2qlv3vJLR2Zkysx0RQcRlv7ik6KTv8D3EfOfA3HQ-84S5av4s5UJ7vn_Mw
Message-ID: <CABgObfaVm0=RhTe1it5vMiSwbZTNGZnSxXbMei1SvaVZpCtNRQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="000000000000709997064708cb56"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000709997064708cb56
Content-Type: text/plain; charset="UTF-8"

Il dom 28 dic 2025, 18:19 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> But an inline memcpy() is hard to read and easy to get wrong:
> we have a pointer-cast and some pointer arithmetic going on here.
> What we want is to express our intent: "I am doing a load/store
> of N bytes which are in the host byte order and which might not
> be aligned". That's what the _he_p() functions are all for.
>

Yes, I think (hope :)) that Phil wants to define ldn_he_p/stn_he_p as a
memcpy instead of a switch statement.

Paolo


> thanks
> -- PMM
>
>

--000000000000709997064708cb56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il dom 28 dic 2025, 18:19 Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">But an inline memcpy() is hard to read and easy to get wrong:<br=
>
we have a pointer-cast and some pointer arithmetic going on here.<br>
What we want is to express our intent: &quot;I am doing a load/store<br>
of N bytes which are in the host byte order and which might not<br>
be aligned&quot;. That&#39;s what the _he_p() functions are all for.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, I =
think (hope :)) that Phil wants to define ldn_he_p/stn_he_p as a memcpy ins=
tead of a switch statement.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000709997064708cb56--


