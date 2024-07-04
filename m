Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF11C31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLeD-0008CK-W3; Thu, 04 Jul 2024 08:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPLeC-0008Bt-0Q
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:33:12 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPLe9-0004Ie-Tn
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:33:11 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a77af4cd570so37739766b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720096388; x=1720701188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f19Bs9ZT0OpY9y4aYpk3+UQ7z4NKFudecNznbxwtnC0=;
 b=I+kccLUH/0C1rQH0Lnk1xi03wHQpdyFdTDXyF0+RSty0mdh9D4LQyidZvi9V6d3c+f
 fZvZothY5HjhzasJDY49LfXOkbGqiFxRRskzcPk830zkXLsp+g1uQ532laUpgqRSdgkc
 LnuIJtzUAAECoGFZ8O/zxlY4btg1njGvwwv5Sox2nn4ETyU7JPqHY7744dZiRNQWoa+z
 PutClP7ie0r3PaWFVRu8ZLBGWwvxO142tU3+ht6uFnK/R4Kg+X3/EcNV8khwVAm3bJyr
 ByvXxWvmPs+Cx6SKpw/S6ynkgvfv6+P0I2L3WQIWw9pAWanqH0IZIQoUaQrorGVRjlXt
 ZZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720096388; x=1720701188;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f19Bs9ZT0OpY9y4aYpk3+UQ7z4NKFudecNznbxwtnC0=;
 b=MLuDhFtIFk4n1/GhLWhaAIMUqkDix97VNj8p/unDjHeoSXAWKfH1Yl263uJqDy3+wo
 pCWYuYPXhxDmCHFARpwVLAfuXWd+IM2iKsRG+06NuUN8WKc3i9Hn/ZPQtjnS2YYv2hMA
 /3FsIMUPeTQ0xo0Q11swgG6VHS9OvD4+YR6vrtT1mh66klOLU0xCh0fz8nwHglqj03NM
 l2Z/q9RkO0KCw2lU9q2D+H+xPcfiNOUJAvQZKDQF6VcT+ofTuVxOUXZz+3bDHLtQC955
 rm8XDjYSeqT2SS2xYsRFlZYFYuutJLOhyoRP2c5i+70YV959eeGh+ZCftGtaXoO4H2mz
 zTrw==
X-Gm-Message-State: AOJu0YxwwPDj78rWwVpk4yBPFO3PwLid+HBaF4FDK/tJm6XQ1iko0RX2
 iKUXXL6xXR7l0F+bkq3zBwfrIFUntl0116SJl3DWYl5qLyXWyZVZaIoK3N+0jLc=
X-Google-Smtp-Source: AGHT+IHJ3ZLpuxYytL1DyxnCP+DvoaUgRS13CTvCqP8SY1N58Wkfb2LrCUmoL6UbQ+1/8ezcXP5vYQ==
X-Received: by 2002:a05:6402:22f0:b0:58c:8c63:22ee with SMTP id
 4fb4d7f45d1cf-58e5be72411mr1004212a12.42.1720096387662; 
 Thu, 04 Jul 2024 05:33:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58d50c4dad9sm1817894a12.10.2024.07.04.05.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 05:33:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AD645F839;
 Thu,  4 Jul 2024 13:33:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org,  sstabellini@kernel.org,  anthony@xenproject.org,
 paul@xen.org,  edgar.iglesias@amd.com,  xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/2] physmem: Bail out qemu_ram_block_from_host() for
 invalid ram addrs
In-Reply-To: <CAJy5ezpD6i3Fc9K-i58=V0e1uxrB-VZ2sd+gtoOc4TnbkWHSZQ@mail.gmail.com>
 (Edgar E. Iglesias's message of "Thu, 4 Jul 2024 14:42:25 +0300")
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
 <20240701224421.1432654-2-edgar.iglesias@gmail.com>
 <87ikxlo3lx.fsf@draig.linaro.org>
 <CAJy5ezpD6i3Fc9K-i58=V0e1uxrB-VZ2sd+gtoOc4TnbkWHSZQ@mail.gmail.com>
Date: Thu, 04 Jul 2024 13:33:05 +0100
Message-ID: <875xtlnxq6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

"Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:

> On Thu, Jul 4, 2024 at 1:26=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
>  "Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:
>
>  > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>  >
>  > Bail out in qemu_ram_block_from_host() when
>  > xen_ram_addr_from_mapcache() does not find an existing
>  > mapping.
>  >
>  > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>  > ---
>  >  system/physmem.c | 4 ++++
>  >  1 file changed, 4 insertions(+)
>  >
>  > diff --git a/system/physmem.c b/system/physmem.c
>  > index 33d09f7571..59d1576c2b 100644
>  > --- a/system/physmem.c
>  > +++ b/system/physmem.c
>  > @@ -2277,6 +2277,10 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, b=
ool round_offset,
>  >          ram_addr_t ram_addr;
>  >          RCU_READ_LOCK_GUARD();
>  >          ram_addr =3D xen_ram_addr_from_mapcache(ptr);
>  > +        if (ram_addr =3D=3D RAM_ADDR_INVALID) {
>  > +            return NULL;
>  > +        }
>  > +
>
>  Isn't this indicative of a failure? Should there at least be a trace
>  point for failed mappings?
>
> Yes but there are already trace points for the failure cases inside xen_r=
am_addr_from_mapcache().
> Do those address your concerns or do you think we need additional
> trace points?

Ahh that will do.

I am curious for the reasons why we might not have an entry in the
mapcache. I guess the trace_xen_map_cache() covers all insertions into
the cache although you need to check trace_xen_map_cache_return() to see
if anything failed.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

