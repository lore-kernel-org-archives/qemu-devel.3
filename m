Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DCFC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Gqa-0007tc-B2; Fri, 25 Apr 2025 07:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u8GqX-0007tT-QY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u8GqV-0002iO-MY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745579029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFfa90yyQhl8PiwtjIrYuAl7OQXtwM3NIofCfNndnHs=;
 b=B7gqv0jvnoooWUv1ySIMOYUj7lFKA97/iJl7qZEHpnLBCt9teL4E37fcwy85YCCuR7XLFt
 MOcc1rdubhFiR/5hhM/HTMuKxbh5XaK/3EcBsj98xOnQeFiD/27mjwA8rgK/NvqaphlN4F
 CrGXAd2KY3oPSAwWMbL/rPAiOnorkCY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-rw5yQDHsN3ipyv7oCxXg4g-1; Fri, 25 Apr 2025 07:03:47 -0400
X-MC-Unique: rw5yQDHsN3ipyv7oCxXg4g-1
X-Mimecast-MFC-AGG-ID: rw5yQDHsN3ipyv7oCxXg4g_1745579026
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so15655035e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745579025; x=1746183825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFfa90yyQhl8PiwtjIrYuAl7OQXtwM3NIofCfNndnHs=;
 b=X1iSd3WMH4/WS7oLmgo0sQtmuF95TsAox1db6Ac5pN/EnrHvwy1LQaR2JTU0Eb67wc
 bBuYqsIXiJ+M+ARGHKGjzBkfk+ubNBlP4hBrcgqBD4EXAIvatn0RizirpAVQh5qSA8aI
 J3XsQyrDKgflzMLD0bUVWuO6e4Vgdwew6WLVuGnmkPV/G1rI969gQdQgHUASMkaKZutt
 fnAW1gkD690L3L4+ZX5v3w7siVZLLlD65ka3Hl8HrFydpOK8aj4LAl8krfmb8pU51SCG
 ALtpRjXrc9BK2U4l3mO5aJAV6KR9YdIqN7EoovosBZf2oo4o+ok06npkR5q9kZj3NNZn
 wgyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoZob9J3NxV2miZtRjzUPoEWxtQwgkci9Y36n2m9QEkXmkElXpCrY609q64BGuO1ZucyFsniS6Ufr1@nongnu.org
X-Gm-Message-State: AOJu0YxyQx160X8PdX37PHJd4zG1Dp1W2MUQgmSYPSJ0PemkC22rRojS
 W30qR1xH2+BR7CnFdhE25M2h+iOx6Mvz3Dz/BWbCw34fn/+QB4eIP6vhw77WTyZzWy02QPXJ+Kb
 CqC2XDGZ95CEwSX4qUS5Tn03DIZe++slLyCecpYnopJlL34ftIz3TCVhwxkBIHQCA3Ck/0LrDrL
 LVWOLTg4OaAGPMyOHoJRzBgTp6rgxXaToIG3s=
X-Gm-Gg: ASbGncvD4fy7uTFHSxLZ1RmZt1lpJE/qgexaVkS9w9At5RmLH/SL2SCuOu3axgNj3jh
 pHNH6k7Ufn+JEJ58Tgu6QClxd+zCCc8cJ+P+AIw7kjPLP27roNXQMni1A6zGNb/jBvK3Ewg==
X-Received: by 2002:a05:600c:3548:b0:43c:e8a5:87a with SMTP id
 5b1f17b1804b1-440a65fe6ebmr17510225e9.16.1745579025469; 
 Fri, 25 Apr 2025 04:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYyuLU68b/06zW8+ExmbBDnqTLRzx5KMmj1zpiCGWDJ/KFuv8HhPrdET3QZliiYsMsY45XoLha9HChYJ3ZZ4s=
X-Received: by 2002:a05:600c:3548:b0:43c:e8a5:87a with SMTP id
 5b1f17b1804b1-440a65fe6ebmr17509895e9.16.1745579025118; Fri, 25 Apr 2025
 04:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <CAKmqyKO=-QhuKNAKJBXfGiwPdSt=uT6M16pgVJENLxgEiy5Adg@mail.gmail.com>
 <c0dd76b5-da8d-4193-9ea1-5fb5e55b35a8@redhat.com>
 <CABgObfYy53Z-LsW2QNdWdtEhnXq9=2f9aDdZHZrou4sNQN_ZYQ@mail.gmail.com>
 <98f9c6cb-a731-48ec-b5a8-3f170b07b7b0@linaro.org>
In-Reply-To: <98f9c6cb-a731-48ec-b5a8-3f170b07b7b0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Apr 2025 13:03:33 +0200
X-Gm-Features: ATxdqUFzALcdaI_TyMEpVAbL7N-oT4rI8bLHuDN432pzjQFmXCvXHpuEhcMfEkI
Message-ID: <CABgObfZ3__40VT1TzbQS+rX8XOMT3+cfmGfzs1ustb0ad7-+GQ@mail.gmail.com>
Subject: Re: [PATCH 10.1 v3 00/27] target/riscv: SATP mode and CPU definition
 overhaul
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 25, 2025 at 1:02=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 25/4/25 12:55, Paolo Bonzini wrote:
> > On Thu, Apr 24, 2025 at 4:39=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.=
com> wrote:
> >>> Thanks!
> >>>
> >>> Applied to riscv-to-apply.next
> >>
> >> As Daniel noticed, I was expecting
> >> https://lore.kernel.org/qemu-devel/20250210133134.90879-1-philmd@linar=
o.org/
> >> to get in before this series.
> >>
> >> If you need a version that applies without that series, you can pull
> >> from branch riscv-for-alistair of https://github.com/bonzini/qemu.
> >
> > More conflicts have appeared so I've updated the branch and will also
> > send v4 for review.
>
> FYI I tested my PR and should post it today.

Ok, then I might as well wait for that one as well.

Paolo


