Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A8ACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCsw-0000gh-2Z; Tue, 21 Oct 2025 09:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vBCsf-0000W9-20
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:58:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vBCsc-0007zq-4U
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:58:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so4993658b3a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761055103; x=1761659903; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pPdygudXA5Lxli1F/++PwS4Z3c1EOK1lIXgoZ6EeQsQ=;
 b=TFGqHwg7hH2xldqgUC1mwqR3qW4aNiF3iz6QG5PAeGPGR4bwtXqw09iOSZqyQDbaSf
 BqT2EUAIen/U3ECJVUINI12ucqWU9A+jqJ2VqC2l9XatvtWSwqx5cxE5oULj2MIBDhx8
 4daVIroorEvC2aN4OBenphJcCpxnTOW6nqkzOwqgZ1b+Lk9MbqX6J3Nl2TMUG9ATej0C
 l03vWDd4Wm9q1ylXoNti2a0z421uuTiRtv318bZ5t/UrtqPHc8pR0UDLP/J9P07UeLh7
 o3yjbEfzH6D8nGKig8ZyQMN2rTb2m1U7XxMo1UOHTIcYFK+WB/nluhD7/pFm+dA6CTdn
 zReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761055103; x=1761659903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPdygudXA5Lxli1F/++PwS4Z3c1EOK1lIXgoZ6EeQsQ=;
 b=b4128rbOVy2vuc0rtgHXwL+EbdTL/eeGVzhOpY1HgskwBCf/rws21h9JhIcASJVFKw
 RQJEZH2pD04+fDlrJMxMd7me1CRU8Uj8osd/o+4UZp7FVJyjOdYri65XANeMaplfOJlF
 Orq9VkEjK967qllYtE5bhrIpFJg9gIcJC8O+f7a5QW04o6V64lSfC+kS3E7h4zoQ+zxj
 DexgtCTD58E00FxEuhc+Dpg/tH//IMJ3pgXzuuNya/3nR1M2+X1VHa3hrobApSSEZB+s
 DSLJZU1LMefsRh3kYQ38zPpRuHQivMH0pDlj0kx0LegczD/xMgGeR+JFV+X2l50VL1Fd
 Cilg==
X-Gm-Message-State: AOJu0Yx6xDf+mNFzU1FWHsc7rCWHpS2qu2RHvHevnJMq4YUZbUUWkqCM
 dfMEqAVtSKKPUYUxbX8pVkprkIf92SeX14kuKgRMZSqfTpr2E2e7nlmI05mYzVQoaiBgSh40t++
 WQ3B+YgtyhjJGgFYecypWlp4wM59/2JtJMQGBOQ3aoA==
X-Gm-Gg: ASbGncs+vu3uyHYqx5cJUr/x6u9hjQkpvqjo0zZizdefbfHYQQzZR4tikm3yMeBp4R0
 k3U9Qu4ta9Bg3uNkhd9hGfZNFM2QiUR3Dpn0GKlMPwF2vAYaSo2fWiwIYvClXpDYJWIe3L3GQlq
 sQx+QJhFyyVXOKXUmvxdp53tsHArMJ9Ztcjoq047l3V5JKwualvysOcx4k1ZK22+7k6lVEYXnfz
 88cbyAc7o/7ewmm6S4WHNUvatwTPthyvdkIFfkWdkkLbok1ZRqw5rLuVKAFHzlFMBqE1A==
X-Google-Smtp-Source: AGHT+IE0+jvJP+jHgFuOGd7AG/ldZHoV3AfhKDbcZoT/QZC6z/r+l4UHVkiL0/gXj0woSudmdvCYrWf6uSTZqfAxvCw=
X-Received: by 2002:a17:903:94e:b0:290:533b:25c9 with SMTP id
 d9443c01a7336-290c9c8ae4dmr192613605ad.2.1761055103171; Tue, 21 Oct 2025
 06:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251017155136.16540-1-roger.pau@citrix.com>
In-Reply-To: <20251017155136.16540-1-roger.pau@citrix.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 21 Oct 2025 15:58:09 +0200
X-Gm-Features: AS18NWA58CeS14FdkkCNsTOZQHqLAPZdt-7l1MEooVrAG7tg9H44TnVA3_KoSpQ
Message-ID: <CAJy5ezpoN0mdSWStgF_RjtrnkbfkaMMsnrHHGuiQqNd4aNp0nQ@mail.gmail.com>
Subject: Re: [PATCH] hw/xen: pass PCI domain to xc_physdev_map_pirq_msi()
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Content-Type: multipart/alternative; boundary="000000000000dabea70641ab9724"
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000dabea70641ab9724
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:51=E2=80=AFPM Roger Pau Monne <roger.pau@citrix.c=
om>
wrote:

> It's currently impossible for passthrough devices on segment different th=
an
> 0 to work correctly, as the PCI domain is not provided to
> xc_physdev_map_pirq_msi(), and hence it's unconditionally assumed that al=
l
> devices are on segment 0.
>
> Adjust the call to xc_physdev_map_pirq_msi() to pass the PCI domain in th=
e
> high 16bits of the bus parameter.  On versions of Xen where this is not
> supported the passed segment will be ignored and assume to be 0, no worse
> than the current state.
>
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

--000000000000dabea70641ab9724
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 17,=
 2025 at 5:51=E2=80=AFPM Roger Pau Monne &lt;<a href=3D"mailto:roger.pau@ci=
trix.com">roger.pau@citrix.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">It&#39;s currently impossible for passthrough=
 devices on segment different than<br>
0 to work correctly, as the PCI domain is not provided to<br>
xc_physdev_map_pirq_msi(), and hence it&#39;s unconditionally assumed that =
all<br>
devices are on segment 0.<br>
<br>
Adjust the call to xc_physdev_map_pirq_msi() to pass the PCI domain in the<=
br>
high 16bits of the bus parameter.=C2=A0 On versions of Xen where this is no=
t<br>
supported the passed segment will be ignored and assume to be 0, no worse<b=
r>
than the current state.<br>
<br>
Signed-off-by: Roger Pau Monn=C3=A9 &lt;<a href=3D"mailto:roger.pau@citrix.=
com" target=3D"_blank">roger.pau@citrix.com</a>&gt;<br></blockquote><div><b=
r></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.igl=
esias@amd.com">edgar.iglesias@amd.com</a>&gt;</div><div><br></div></div></d=
iv>

--000000000000dabea70641ab9724--

