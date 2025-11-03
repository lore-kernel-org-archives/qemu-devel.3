Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3672CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFpUo-0005k1-BV; Mon, 03 Nov 2025 03:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vFpUf-0005gd-Rc
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vFpUM-0001zr-SS
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762156827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEOnqvrVe5lqRvRwouMSuCkR6COK8rXwo9PiUuo9tEc=;
 b=S+CgpU2yukHIpuj5guzHexgzWzlQWvFz2ZAdjKCigF8eNUQg4jOOxXEnlwF6+RFHYY4oEX
 HcP/C97DPobNKgi1mtS9dBm6sAcoNFWHPuT75MGQENd4Ykwg6BM7QuLyzQ10OBmUfD7X+m
 NZRLutCaj49WH0zbhdLw4rF9EuDtYWA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-F5e3U51rM_-PnenZFQnTpw-1; Mon, 03 Nov 2025 03:00:25 -0500
X-MC-Unique: F5e3U51rM_-PnenZFQnTpw-1
X-Mimecast-MFC-AGG-ID: F5e3U51rM_-PnenZFQnTpw_1762156825
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78e5b6f1296so98604186d6.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 00:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762156825; x=1762761625; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WEOnqvrVe5lqRvRwouMSuCkR6COK8rXwo9PiUuo9tEc=;
 b=kWWgyVF6w8Ew6p3J1RJLVkbyRJx1mdLLmNBRixvO2j71yzrOv6QGSEFQ12NE4cWQgc
 jaKo2KtMVTBbFkq+9vQ8HSQaCrtdWP626orFk0b0YoKBVOfq6Lt6A7ykYcFnHSejtr/x
 ORQct9C/5A3SnsOIH4KoN5KlNYXAvl0Obhv0owsyH6UHoaw5t2uDKN+ts7QdPHlz+qyU
 XcpPa86MfAJJhzBE9T1D/LYDrSj7DrbnOOGzxEmqgHLDES2DDd9RQlU9Loo6fRG5+0ap
 3Psycqi7+Af3E40zSzzj+LikHrkpgae82uzXQG5lyaH9FlzWcoQZkbc65HBA6MiWACME
 8DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762156825; x=1762761625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WEOnqvrVe5lqRvRwouMSuCkR6COK8rXwo9PiUuo9tEc=;
 b=QcKx8MmTlcYosJQuOqKEzgpjcSniV6fnZj6FOsMP7su7bKjULH+8jeasOeheYrO2ty
 rm7ArO78Iv/Q5COJ+utycYyhNMB1rz/fbp+k8PxDpM+BJfK0FL5p4PUSyhSDIWED3omV
 nMsDE+X5/ujTk4rVfT41Hwpg/qElHFLmedbKw4DYFTWjuF8QZ9Kz6ulqgKADmrtANHYL
 PM6WwK68d0KMvx5FYCQeNRbb43U+t+DHFluApEO8UdtTbhw1lKEzQkr02OZWGWTzeTQl
 I+Ew9QQDtDsFPo0DNbK6X8xLDCR6yoDTdEujlccUnz2ma2WGvP01iU2xt91oD/XWW5x5
 yOFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxihbHh5cavbztj6mXODTWbtSu2MoAyvp4qCr6iTjQdBXBDZknKwYcgQ66Pf1yCE3RU0UbEs8zVGNE@nongnu.org
X-Gm-Message-State: AOJu0YxR6v4dAmnsN/KbzvVF8S8wVCGvz0cz+dvZTOdBDCsynuuldG9l
 260Jn4wMmShKl/8Tiu0bjtFp+wB5umOpUjKWd714//0ig5YCw4zyDDaNqxPJaakfLtatPd5HT0k
 ghmeIwYyxPIl1XtKKCep8rkyBAFEuRIf+axspOJ3K+9EeoDrcI7Irefwx/HLfECkTEbfFTnj5Sa
 RG4QLWzimL1dUClZWqUARhLErEygVMLQE=
X-Gm-Gg: ASbGnctepw9t9ByMs7lmKP2KzQ0H6yfjZZZ3EKgLtTQlaTNmBfqlRFLWn3XzC/Of3Cl
 LRE5dqgyP+iQMqc4NuwNK04XU9Ux9SvS1eQE3lZ3xw9XM+YHs0HPkL2j7fdek/Y5+G6DmQ/Sp+f
 hNDRyG9rWQWowc1BpvOWUHnXPyQDyEsRAz5TLop6GYjtd4uMenLMcb1zMzrQ==
X-Received: by 2002:a05:6214:1d01:b0:880:4b27:1888 with SMTP id
 6a1803df08f44-8804b272595mr68791946d6.3.1762156824926; 
 Mon, 03 Nov 2025 00:00:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1qEUI/ji5phzzEoagggFXrUYC2UIIeJn4HBlyYL2Gi6J9cT2vmZi4cuUvY6/qkTe5fkFYwziw6oblDyzBhqo=
X-Received: by 2002:a05:6214:1d01:b0:880:4b27:1888 with SMTP id
 6a1803df08f44-8804b272595mr68791476d6.3.1762156824395; Mon, 03 Nov 2025
 00:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20251101131456.792868-1-mjt@tls.msk.ru>
 <DDXQYO68GHXQ.NZTDPMLYKROT@drigo.nl>
 <7dd27991-9fd2-4efe-8fe9-0c8e61c182ee@tls.msk.ru>
In-Reply-To: <7dd27991-9fd2-4efe-8fe9-0c8e61c182ee@tls.msk.ru>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 3 Nov 2025 10:00:13 +0200
X-Gm-Features: AWmQ_blsRTQHvEDPr1zDvnMhC9qxjBXnwyEzwDXuGlDXgU7WQFIceqQATZu_ioU
Message-ID: <CAPMcbCp042BZuMMzuW-VXPj6UF8Z296Y_p=PEB_Sc1By6s5PMw@mail.gmail.com>
Subject: Re: [PATCH trivial v3] qga: use access(2) to check for command
 existance instead of questionable stat(2)
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Rodrigo Dias Correa <r@drigo.nl>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008e9ad40642ac1bd4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000008e9ad40642ac1bd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Best Regards,
Kostiantyn Kostiuk.


On Sun, Nov 2, 2025 at 12:15=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> On 11/2/25 02:29, Rodrigo Dias Correa wrote:
> ..> Thanks for fixing it.
>
> Hi!
>
> It wasn't really broken per se.  Just confusing.
>
> Thanks,
>
> /mjt
>
>

--0000000000008e9ad40642ac1bd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto=
:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><d=
iv><br></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Kostiant=
yn Kostiuk.</div></div></div></div><br></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 2,=
 2025 at 12:15=E2=80=AFPM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk=
.ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 11/2/25 02:29, Rodrigo Dias Correa wrote:<br>
..&gt; Thanks for fixing it.<br>
<br>
Hi!<br>
<br>
It wasn&#39;t really broken per se.=C2=A0 Just confusing.<br>
<br>
Thanks,<br>
<br>
/mjt<br>
<br>
</blockquote></div>

--0000000000008e9ad40642ac1bd4--


