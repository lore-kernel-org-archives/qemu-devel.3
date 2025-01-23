Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E269C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 09:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tatUg-0007gv-2g; Thu, 23 Jan 2025 04:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tatUe-0007gS-1f
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:27:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tatUb-0006UP-Ru
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737624435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRAt+EBDydf8E3UMbddzHHhrJ81CYp/yg4UufRki7f4=;
 b=MArgeEAJ6v33heDhr71+M5mivwnPiV8OOl/NXjviLTsvRb7XnXaFzICXeZht8fDuj03EvE
 Ltz38MthNDRJFSCTzYrF0fTFcuFenS4NX/ExFwZm/bB04vOz5xJS2YLZevoyWQLB6w8aH2
 l6F1xSdFJtwmJiFN/dsTzTbbAz2ftCI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-v_xMutDFP0C1JfGmpDtBHw-1; Thu, 23 Jan 2025 04:27:13 -0500
X-MC-Unique: v_xMutDFP0C1JfGmpDtBHw-1
X-Mimecast-MFC-AGG-ID: v_xMutDFP0C1JfGmpDtBHw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso425159f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 01:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737624432; x=1738229232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRAt+EBDydf8E3UMbddzHHhrJ81CYp/yg4UufRki7f4=;
 b=AEqkSp7C+FtQqWAIgrvBB+20jm4xuRHi/O9NJEXcDxDFlCYFZp5/NcNHMm3tep5Nnr
 5+b8mlqBFhQMAqi8tBizYRVZvg1i/qh7UtLoV0JILzwvjitCfMJIdw3e0E7Te2SN+/X5
 TgghNCzdo6IWH1olk5Wh5flucEXG7752Y4wJ5odgnJrf2YyXw5SWkjISJvyipldBJx1o
 5mzOXaMbfgFrRB1z8s8fSGIDCjntKKnPOhk4a3gpDx87v2wrH4CIQpaccGTQOHaBBcUr
 OjkWb48/a6RZ25Q31ySbaOgJ2kdREa8iIQnhZrIfWur58MLd1rsrTPsBWduEaYRucwCV
 dq/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFKTEE/mkAkAd9y2dzocEHdtUSygxd1woGaVjTCrDFVMS/hOO3luj4v3CoWzQycofDtM5yG3X08aKe@nongnu.org
X-Gm-Message-State: AOJu0YwNWdHNksQYSRPHUr7MCtG7Yf0dTBk7mBxvLS0MwzKUkL9ixKaQ
 69WA4hioe3SaXOu842wJ6ubTBhMcmM7vZA4WhXX9g9zEhv2h0WCXsIOhs63l4g8GS76yyr6YuFj
 9P010nYVb3LXrBb1kBqX6G+T9doVHRON8WiZGY5jvFn88TQqn7Laxm84kKQ69Ih63geVAbu2sei
 Q45ZdrqiDWf5Ne01yz2+Wep4B0lXw=
X-Gm-Gg: ASbGnctJpAw7jIRe2hPZJxyQ9M3k4ZLZcXbaaOk6f4G5PtREdoOn0574DQmn3ijcThx
 yqZXbVsjUj9WxY0X/c/Jflk0DsCOUKXBm1JP7GZ43VhSMSB719Ls=
X-Received: by 2002:a5d:648a:0:b0:385:fb8d:865b with SMTP id
 ffacd0b85a97d-38bf57be4a2mr26650571f8f.48.1737624432629; 
 Thu, 23 Jan 2025 01:27:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrnVICL8VuXZBvjbyI9zHTPwhHz9TWdybdDSxdHs/SoIuYE6nliRsoOjrti8Qem/1CQNf1KKNHw5GDxeo0V28=
X-Received: by 2002:a5d:648a:0:b0:385:fb8d:865b with SMTP id
 ffacd0b85a97d-38bf57be4a2mr26650534f8f.48.1737624432274; Thu, 23 Jan 2025
 01:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20250122135843.543387-1-mordan@ispras.ru>
In-Reply-To: <20250122135843.543387-1-mordan@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Jan 2025 10:26:52 +0100
X-Gm-Features: AWEUYZl1Yo49uYAW_BFJjh_KkQzuHQAY_o4S7B4rT9dSGtSOZnh2tsR7T_jofdE
Message-ID: <CABgObfY+xCMEENKoKX4siyyAMNGWkqoGda1dWvLy5BW7ic-puw@mail.gmail.com>
Subject: Re: [PATCH] Fix a data race with goflag in rcutorture test
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org, 
 Vadim Mutilin <mutilin@ispras.ru>, Alexey Khoroshilov <khoroshilov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On Wed, Jan 22, 2025 at 2:59=E2=80=AFPM Vitalii Mordan <mordan@ispras.ru> w=
rote:
>
> This patch addresses a potential data race involving the global variable
> goflag in the rcutorture test. The issue is resolved by adding the atomic
> qualifier to ensure proper synchronization.

Hello!

QEMU does not use _Atomic; in general, the C11 committee decision to
default to sequentially consistent atomics is a bad idea and we prefer
to annotate _accesses_ rather than _variables_ (yes, I'm aware that
volatile has the same issue!).

Can you redo the patch to access goflag with qatomic_read and qatomic_set?

Paolo

> Fixes: 8fda74a52b ("rcu: add rcutorture")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2750
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---
>  tests/unit/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/unit/rcutorture.c b/tests/unit/rcutorture.c
> index 7662081683..c4971632f8 100644
> --- a/tests/unit/rcutorture.c
> +++ b/tests/unit/rcutorture.c
> @@ -70,7 +70,7 @@ int nthreadsrunning;
>  #define GOFLAG_RUN  1
>  #define GOFLAG_STOP 2
>
> -static volatile int goflag =3D GOFLAG_INIT;
> +static _Atomic int goflag =3D GOFLAG_INIT;
>
>  #define RCU_READ_RUN 1000
>
> --
> 2.34.1
>


