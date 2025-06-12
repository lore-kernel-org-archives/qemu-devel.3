Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119F0C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 09:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPeD7-0004oN-Jw; Thu, 12 Jun 2025 05:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPeAl-00035L-Rj
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 05:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPeAd-0006jR-5F
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 05:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749720262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EaVDFQRyFhrvUbX6GFcTmrBkopzxt0kndnCrWdyEUk=;
 b=jHYwlJ3k6e5DLz2N2s0d1+1/YjJJUgMVHP5hNV1DK8pG5SxA0WgCCYqa+PRLw8zQ24rhA/
 4bKweSCREzYpsERgRLTAorZG4ouvGPm7DMg2DFW4/NInOoCQ9/Rpk57Vu1z8NSQ5mGXZA2
 DSInSKR/A8KdqOI3X3amhETEIrdzszo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-lVh3oXuAN-CxQM92JuSP1A-1; Thu, 12 Jun 2025 05:24:21 -0400
X-MC-Unique: lVh3oXuAN-CxQM92JuSP1A-1
X-Mimecast-MFC-AGG-ID: lVh3oXuAN-CxQM92JuSP1A_1749720260
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so3531085e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 02:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749720260; x=1750325060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4EaVDFQRyFhrvUbX6GFcTmrBkopzxt0kndnCrWdyEUk=;
 b=mEbKWisLdCUWEO4p2FUyOwFOqOw1dxrNqFREyxZXXQCbpxmbE1yvF4ThHa6nvYpfGR
 YCa08k444eHwFQ4cV4vZTr8sRmil4zrl5tz90n6hfkrBccB+OGOfkiNPxvPKCvc+7VOv
 QsxjF8IWib4+W/g5vrSDOMKYFop5kdxo2RroEHp9wCQT+9aHLEvVhKbFAYDoh5mNlT7B
 iN5Rtcc26lwAIP+2EFtljqx9D0AzdHLvCG0P0HNan2kLJu3vfwHGbNGjw8yettesnSA0
 fb1PGwcgXnRn5Gsi8KCRwDjP/T/LNfYLcSSG+w8m6izidjtrahsIQu633UqEgDQz+NR9
 Cy9Q==
X-Gm-Message-State: AOJu0YzOASHfg9p/q6dNorCedI27FZRWwL7kPnE9Uy8eTvV91jXNyANC
 j7lW7AnrSYmmYPOY5LJhxV1M8XBffvRi8sfDI1wFAUO+UcwR9ZB/3ZnR20WxALmMCr6jmlfe2PD
 TPjBi21BSOC4Y8ZJEM/ILOQPH/L18gcdGNkj6biX7gPlF5twiyDIRYo0kCf0KARFqlPyszaqseF
 bnEb/GvcEA8CU8SAegA9gtZyKFEFRIH38=
X-Gm-Gg: ASbGncuID4lPypoWGksq3FeSgaDAXtejfrZGhW7cXqmHs3ezswYYB8dRZO6ewR9daPh
 SsRcs1SttihAvKuceUAk+cl2rdvaM+iZ80LMeuo13dPqOxDOt2y4dlCgNElYjZUbE+xvicuhPVf
 bw5yA=
X-Received: by 2002:a05:600c:a105:b0:442:e9eb:cb9e with SMTP id
 5b1f17b1804b1-453248ca563mr41291335e9.26.1749720260148; 
 Thu, 12 Jun 2025 02:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsi+ghfKbHvwKS6frnq48KsB0a+dyRT63N7gr3cGBDuVtHuDrC7Ht5xKdTwfCfsaNsNt9od26XYs2BBGGaTNQ=
X-Received: by 2002:a05:600c:a105:b0:442:e9eb:cb9e with SMTP id
 5b1f17b1804b1-453248ca563mr41291195e9.26.1749720259856; Thu, 12 Jun 2025
 02:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250609154423.706056-1-pbonzini@redhat.com>
 <20250609154423.706056-5-pbonzini@redhat.com>
 <aEqcGiGmZiMoIhY5@intel.com>
 <CABgObfb8CWy5zthqHRJrKqjP4xmBC=Zh3FrDjcK2Z6wsZJu-ew@mail.gmail.com>
 <aEqg5j9LFgszQzAv@intel.com>
In-Reply-To: <aEqg5j9LFgszQzAv@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jun 2025 11:24:05 +0200
X-Gm-Features: AX0GCFu0JGsIvZatRLCpgDOa2tn-ZgT4FfAm4yXQorvDkrs183gfNujoXhCL_aw
Message-ID: <CABgObfYJx8SQjqi8-wnm_MJPuUEzfW7gsA2bdmpTSV4kCB7Yqg@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: qom: make ParentInit lifetime-invariant
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jun 12, 2025 at 11:20=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
> > Right, I put it there because '2 lives until the second println!. The
> > problem is not so much that it's returning token1, it's that the
> > println uses it.
>
> Even after I comment out the last intln line, the compiler still
> complains about returning token1. It seems the compiler's checking is
> stricter.

Oh, you're right. Anything that the closure returns must have a longer
lifetime than the closure itself!

Paolo


