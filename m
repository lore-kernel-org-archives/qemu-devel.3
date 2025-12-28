Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0777D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 20:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZxOz-000590-VL; Sun, 28 Dec 2025 15:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZxOy-00058D-Di
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:30:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZxOw-000506-9q
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766953804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kvnkmNL1ONzQiQhmAlevfxtSA+x28Irc+awzMxwWqx0=;
 b=aa3TNboLnYAgr2AEhb031oVn+ZyTlvBGI7uzDvkstUANd9TqNOnh/vhOIogdvUB5i7IamN
 54dT5Xe/AO5nm2enmOyrgG6DnGBXOLn/VScL+unS4p+MVPS0+nbqre5YuL+doGV6JrI6Sj
 BE5xIWzzr8Y/EWFggXuv7q0Ahm7q9l0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-wB_vFpu9MqSjoJZSxbujow-1; Sun, 28 Dec 2025 15:30:02 -0500
X-MC-Unique: wB_vFpu9MqSjoJZSxbujow-1
X-Mimecast-MFC-AGG-ID: wB_vFpu9MqSjoJZSxbujow_1766953801
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d17fff653so29323315e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 12:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766953801; x=1767558601; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kvnkmNL1ONzQiQhmAlevfxtSA+x28Irc+awzMxwWqx0=;
 b=KNyHn6UZ6JsFXiTydClvErxIaiXKJ8D7opY5M6wa22F9LxWA5oTRGj1KY4UqU4dNum
 0Chu9/AOaahl/WGRwfm/yNs/bGWsKd0KebPaU0K42ND0rr0P83ZHT+BK8yPPyTnMY3Q1
 70rdqkU0UM/7vhXU5R9BSFQM6chYxSIOX5qBShwOqUrSBo7A3VIcmToNz78kJpQLpdOk
 hMAp8qW6+vpye5uWRIIUdi0WNYlR+tdTCvbqaYqa4Dyn7tWpPXe+h2YZAFjyJprnr9/u
 FLDezdJvB2ALb0t2BmXUJ1Mp5bLa+J/NpKpL4LFd6ASrKckqLoDhH2tLJIH1FE4eYbMc
 mcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953801; x=1767558601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvnkmNL1ONzQiQhmAlevfxtSA+x28Irc+awzMxwWqx0=;
 b=rBqTrxdzZlF9apWb0V5tUjBLBiwIdqQ51fG++XcXgzTX8I7tS5TUXgIsWksphllXnQ
 WIxCQWjd4c7GAXMBp0p5IcIhCUGKYLYbyXuoxNzWs6PZtEz2typ4MUmIseRr1DZh+0yN
 NX0Rfhl0e7rkNdcEgRc7u9Sn829vG1Hmw6+uP3VLG+i1L6nKGU/2B86fMiTwLaXq7hSk
 QJN+E5IQe4mm6xrJcSW6ek5t5nHAQQtTCUi3FQ81l2DrfOgw8aPgQJr5iUC1A06CsyYd
 yb6nNmwjCnezNtSJqcmAmws/UxZjrHzJwYNQQN5Odr4SpeMbvr6AItIyWXg8Br06KJRr
 dTzQ==
X-Gm-Message-State: AOJu0YwxvWXtHh62w0LLwywb8TjXk5v/8RtEVNJCH5KuBODb2HV85bVA
 BTaddpaBiml3jLC5uvhLYxNYVkTa4J69i8qm1o0Q/ILb191EfAnOpAI1Bw1w1j9F4Wu2XcBi0uD
 kCp2H/DkdbESfBspun247LJl3khpdmuVvmBZ15rIr31LyLj7TX56bb5ORLIQLYWtD8toNr3EI+P
 0Bkrs6lzDqC52AH//mtAA4M37sZIcQydc=
X-Gm-Gg: AY/fxX4gekF2OHex9UReNQ4ZD1rUMDF3hNxuh9tu29nCzbqWhNQMFC6W228ZiyWkDdi
 BSUCs0E7vAyXYHdtwMx0MCTLviZ/h0KLklCrl0LJjFDEVlhh8E4oMKCp0CFKUHAdDwelT6c2hdK
 zummo0MD4Cg+tl84q8N2DXQP4WR0sMtil27+8OkS/48GsX2gHouIPoLg+dg6wta1/PMFSvS2AEi
 W67R8ZzD5wJeTy2+JzIqoqcFff7u8cdCevkfu+e48vlrRIlZ3OnVCLJEI6f2+rcDEAQXvg=
X-Received: by 2002:a05:600c:6388:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47d19557cd2mr320584135e9.16.1766953801318; 
 Sun, 28 Dec 2025 12:30:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHs7aNkZtym9qJ0mbEbnJqQCznaf5Cy+uLEp4Be+l7vNiwwqzjhtPgyPnAjQoaCHqxSvA0m22UAelWz+kpE56k=
X-Received: by 2002:a05:600c:6388:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47d19557cd2mr320583995e9.16.1766953800950; Sun, 28 Dec 2025
 12:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20251228161837.12413-1-philmd@linaro.org>
 <20251228161837.12413-2-philmd@linaro.org>
In-Reply-To: <20251228161837.12413-2-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 21:29:49 +0100
X-Gm-Features: AQt7F2qA4gFFvkck2GJkEE9X4MKXY-IDOL9DxxDlx_pcGP_6Ozz8UrI_IUSpars
Message-ID: <CABgObfYx8KsRB+6gdWx_U=pJgax8DE6wJMpXSstLDpLpsguu9A@mail.gmail.com>
Subject: Re: [PATCH 1/3] system/memory: Remove ldn_he_p() and stn_he_p()
 helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 David Hildenbrand <david@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a3fb2f064708fdf4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000a3fb2f064708fdf4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il dom 28 dic 2025, 17:18 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> ldn_he_p() and stn_he_p() helpers expand to a plain
> memcpy(), but in a convoluted way. We are not using
> them, just remove so we are not tempted to start to.
>

I am confused, doesn't ati_2d.c use them? And in the future they could also
be used by ram_device_ops etc.

Paolo

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qemu/bswap.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 65a1b3634f4..b77ea955de5 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -412,7 +412,6 @@ static inline void stq_be_p(void *ptr, uint64_t v)
>          }                                                               =
\
>      }
>
> -DO_STN_LDN_P(he)
>  DO_STN_LDN_P(le)
>  DO_STN_LDN_P(be)
>
> --
> 2.52.0
>
>

--000000000000a3fb2f064708fdf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 28 dic 2025, 17:18 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"noreferre=
r">philmd@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">ldn_he_p() and stn_he_p() helpers expand to a plai=
n<br>
memcpy(), but in a convoluted way. We are not using<br>
them, just remove so we are not tempted to start to.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">I am confused, doesn&#3=
9;t ati_2d.c use them? And in the future they could also be used by ram_dev=
ice_ops etc.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" rel=3D"noreferrer noreferrer" target=3D"_blank">philmd@linaro.org<=
/a>&gt;<br>
---<br>
=C2=A0include/qemu/bswap.h | 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h<br>
index 65a1b3634f4..b77ea955de5 100644<br>
--- a/include/qemu/bswap.h<br>
+++ b/include/qemu/bswap.h<br>
@@ -412,7 +412,6 @@ static inline void stq_be_p(void *ptr, uint64_t v)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-DO_STN_LDN_P(he)<br>
=C2=A0DO_STN_LDN_P(le)<br>
=C2=A0DO_STN_LDN_P(be)<br>
<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div></div>

--000000000000a3fb2f064708fdf4--


