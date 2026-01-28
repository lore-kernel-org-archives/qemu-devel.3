Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8852FD46C01
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 22:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlES5-0000B1-K9; Wed, 28 Jan 2026 17:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vlES4-0000AS-20
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 17:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vlES0-0003zs-Kg
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 17:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769640950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5YjG6I6pZzWdjbHuoYvdlrTeU17A8auGHKB0ayJHbM=;
 b=ND3uRHuNG0zQqEhWk64zm7D3hrDMayuCHbLDvGZXYz+B7py1Z9gyDwpilSYSWZClL+9RWJ
 Jeghu0tv5q3c4vlvDnawn99sGZV43Ew5t/Equ079rA3Y0ItnGxKSDRdBUQoQyqqWNCNKBk
 FT5EIOhW/NGEBDIE4gkKJ9bXEONJch0=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-YadU8ZZqOYKY14k2PQxE-w-1; Wed, 28 Jan 2026 17:55:48 -0500
X-MC-Unique: YadU8ZZqOYKY14k2PQxE-w-1
X-Mimecast-MFC-AGG-ID: YadU8ZZqOYKY14k2PQxE-w_1769640947
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5662a21d35bso1080619e0c.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 14:55:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769640947; cv=none;
 d=google.com; s=arc-20240605;
 b=HhIhNbm7zuhCa8JFjhxsEwrQ0wEdmWJsLQj00LcRQYj7ZTHFUr+R/r3il5dPU6g4wg
 OuuVpxcAshlnwoNVLmiXzj9jUWn/gohqtgJHlZJf5O2sSgoc8GpkPVkkG28guzRq48Xz
 0MMxKoUAoG+PjgEF1ex2jwnfqwFe0juEkmjTFlPC2E0TN1fIlgcuS9P9WnY+NvTRWkEJ
 shSSEJ7G4LhKAmqkrzdBLs/35euexc8daOufJPzoSzGO59wBKMDItoIt2S4qPsBa7NZ5
 /D+7YQnd04r/85B/c8IogLtRbsu4alvfx5j5IEA1V/8ZRL6NnXmSIstOK5KzacaXqTJl
 s7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z5YjG6I6pZzWdjbHuoYvdlrTeU17A8auGHKB0ayJHbM=;
 fh=HaCEFEA2tPrD84jTR1M9vu0MJKUmDUGUxgAzrm61n10=;
 b=GkwPZrvxgAdVNHiakcsUqUgDx8fwzFQo7CptUZInWOoSW1E/VmZK3dH2nNm6Jc8zQv
 ZS7JlMKlnNKS9BCb4STTwXcK+lk3YUD2xJKU+5w97XUn1yBYrmrvsgrf5hfqRiREUF5u
 NvWHFlC0NnOD8JpX/Ri6ffVFYs3opWhmILjXZJjcSBqVlxhYa0a2A8vlwFm0+mG3wrvY
 HsWzWzR/jANVg97V+vpuwSrHJAW+IgZc2pPCFsz6GXtADx81L0Iv3CHsAisjtbUF1rlB
 inkpVhOuaGaRkQ92aY/O+/tQwo5Q0PTzMRXpgBKPRNLh+fXz8mieRp6hg5aKAFsuFoV5
 QXTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769640947; x=1770245747; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5YjG6I6pZzWdjbHuoYvdlrTeU17A8auGHKB0ayJHbM=;
 b=TTNO4oiw62pBpXovvoAasG0SsabD10cYKuo67qA8yzE+hAyKLJQslf2XYj905JVuvo
 pZL1aPhD1sMZmtP05Q09aZkyJH/80Miv7xCPdJW23WjyJtwA74NZ8uEgdEmxYY7v9nYN
 3ye4w2Ynx6cKO6XUC+RIr2yF2iVwJdhvIS8ZJvCsDlO5U+s8L1LPpkE4NDNjpbOzTaZs
 IBDhd9Ba1TwKLA34mzRrfGr8us9AMTNKIGK/j0B8b463eO2bVvKVNU3ErXK2zkZ+taIB
 veqWDqZ5ufqpSN/gHvSuYrf1J+Y+9fs9OFnH6B4gkBtKBq19YWcQCZXVjKQoXSAhUrnt
 CoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769640947; x=1770245747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5YjG6I6pZzWdjbHuoYvdlrTeU17A8auGHKB0ayJHbM=;
 b=LEHxgEZZJTLPdvdLBKlUEgxGLHQblFHSizN+xRc+yAkLLXPU8UUJ9bjH/8lqr59swf
 AAvnX5pEFY5WjLsgmccycLCrQgkg+ypAIFOq6drg67ZezwzgdK7fZH1XO/nDBFQ0ZgVb
 SvezpT7RSOtNUoEw6OBqxq0GFra9kLSCAeT5u+HO9TTmqFcL2LugCyB85QR53XJ6b0jz
 9JkEHuaFNd0SqmdUWdYiwWU2GWT9F1CoRbmUPVXGmq8y03DUnusPL3/ICiraZ9RMHpky
 iPTzdVtayT6dLWivM9EDy/U7NS/FQ0yFKhKBOsyXjJFZ1EGHSNg32CX0NREHjdr+mn7O
 v1BQ==
X-Gm-Message-State: AOJu0YwBubk7L3XLKQ/ENSp9qh4p32ED9sVy0YX7qd901fe72TZvmk5f
 Of8lxFqXPKnAkXMN7EqrP0iACy5V1seXjbLGe4aYwwDMDewifklcCVjeD+9z3cI4suQye4WwXTz
 CpauiWeX7QsNNyOWUpnYOtMzEGsEInSqurRYoCis5oS5zQtqYsCNG+R1kEW9K5G6vOfmAxze0yQ
 5ZevuA71f6nln/UZiFOxqUWURlIdnN4HEAvuJVEA8=
X-Gm-Gg: AZuq6aIgZaRhmwZE2HLELsuvNWGF4UxVqVMNsE/Kf73TihG+tONTP/e4CBu72oU0wIz
 uSAScbxt51D5whplCChwixGCfbmm0wYUVRIJ6HKWxSiX+ek8Wrway52/Z+KAHzrJhGFk7XD0wWZ
 E4be1rA+Kq3Ua1BLGJ4HJl2je4IZ6n7awRH/KBGfOIE1MgiDoyhiO2tV7MAqBoNl/Y2+c=
X-Received: by 2002:a05:6122:21ab:b0:566:22e6:35df with SMTP id
 71dfb90a1353d-566794eaabdmr2127845e0c.5.1769640947385; 
 Wed, 28 Jan 2026 14:55:47 -0800 (PST)
X-Received: by 2002:a05:6122:21ab:b0:566:22e6:35df with SMTP id
 71dfb90a1353d-566794eaabdmr2127842e0c.5.1769640947024; Wed, 28 Jan 2026
 14:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20260108230311.584141-1-csomani@redhat.com>
In-Reply-To: <20260108230311.584141-1-csomani@redhat.com>
From: Chandan Somani <csomani@redhat.com>
Date: Wed, 28 Jan 2026 14:55:36 -0800
X-Gm-Features: AZwV_QiJvMhVwrbCCY6mA-Oz87VmUWBxUAk9Ed-nXRloIpGnYktL2VQADc_CaFA
Message-ID: <CAHEFcARWkMO9nTrKHdZwRs-+bFTF4Bd+BwRD3JRDWN=Dh-kJ-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] qdev release function cleanups + unit test
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="000000000000071a6806497aa420"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=csomani@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

--000000000000071a6806497aa420
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,
  Could you please take a look at this qdev patch and put it through your
tree if it looks good?

Thanks,
Chandan

On Thu, Jan 8, 2026 at 3:03=E2=80=AFPM Chandan Somani <csomani@redhat.com> =
wrote:

> Hello,
>   This was originally a single patch to make the property array release
> function free the property array instead of having the users free it
> in their exit functions. This fixes leaks and reduces code overhead.
> After review, Marc-Andr=C3=A9 asked to include some work he did on
> this earlier
> (
> https://patchew.org/QEMU/20250429140306.190384-1-marcandre.lureau@redhat.=
com/
> ).
> I have included his patches that added unit testing and made some
> release functions idempotent.
>
> Chandan Somani (1):
>   qdev: Free property array on release
>
> Marc-Andr=C3=A9 Lureau (4):
>   qdev: make release_string() idempotent
>   qdev: make release_drive() idempotent
>   qdev: make release_tpm() idempotent
>   tests: add /qdev/free-properties test
>
>  backends/tpm/tpm_util.c           |  1 +
>  block/accounting.c                |  1 -
>  hw/core/qdev-properties-system.c  |  1 +
>  hw/core/qdev-properties.c         | 24 ++++----
>  hw/input/stellaris_gamepad.c      |  8 ---
>  hw/intc/arm_gicv3_common.c        |  8 ---
>  hw/intc/rx_icu.c                  |  8 ---
>  hw/misc/arm_sysctl.c              |  2 -
>  hw/misc/mps2-scc.c                |  8 ---
>  hw/net/rocker/rocker.c            |  1 -
>  hw/nvram/xlnx-efuse.c             |  8 ---
>  hw/nvram/xlnx-versal-efuse-ctrl.c |  8 ---
>  hw/virtio/virtio-iommu-pci.c      |  8 ---
>  tests/unit/meson.build            |  1 +
>  tests/unit/test-qdev.c            | 96 +++++++++++++++++++++++++++++++
>  15 files changed, 111 insertions(+), 72 deletions(-)
>  create mode 100644 tests/unit/test-qdev.c
>
> --
> 2.51.1
>
>

--000000000000071a6806497aa420
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Paolo,</div><div>=C2=A0 Could you please take a lo=
ok at this qdev patch and put it through your tree if it looks good?</div><=
div><br></div><div>Thanks,</div><div>Chandan</div></div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Thu, Jan 8, 2026 at 3:03=E2=80=AFPM Chandan Somani &lt;<a href=3D"mailto:cs=
omani@redhat.com">csomani@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hello,<br>
=C2=A0 This was originally a single patch to make the property array releas=
e<br>
function free the property array instead of having the users free it<br>
in their exit functions. This fixes leaks and reduces code overhead.<br>
After review, Marc-Andr=C3=A9 asked to include some work he did on<br>
this earlier<br>
(<a href=3D"https://patchew.org/QEMU/20250429140306.190384-1-marcandre.lure=
au@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QE=
MU/20250429140306.190384-1-marcandre.lureau@redhat.com/</a>).<br>
I have included his patches that added unit testing and made some<br>
release functions idempotent.<br>
<br>
Chandan Somani (1):<br>
=C2=A0 qdev: Free property array on release<br>
<br>
Marc-Andr=C3=A9 Lureau (4):<br>
=C2=A0 qdev: make release_string() idempotent<br>
=C2=A0 qdev: make release_drive() idempotent<br>
=C2=A0 qdev: make release_tpm() idempotent<br>
=C2=A0 tests: add /qdev/free-properties test<br>
<br>
=C2=A0backends/tpm/tpm_util.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 1 +<br>
=C2=A0block/accounting.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 -<br>
=C2=A0hw/core/qdev-properties-system.c=C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/core/qdev-properties.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 24 ++++-=
---<br>
=C2=A0hw/input/stellaris_gamepad.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ---<br>
=C2=A0hw/intc/arm_gicv3_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ---<b=
r>
=C2=A0hw/intc/rx_icu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 8 ---<br>
=C2=A0hw/misc/arm_sysctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 2 -<br>
=C2=A0hw/misc/mps2-scc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 8 ---<br>
=C2=A0hw/net/rocker/rocker.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 1 -<br>
=C2=A0hw/nvram/xlnx-efuse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 8 ---<br>
=C2=A0hw/nvram/xlnx-versal-efuse-ctrl.c |=C2=A0 8 ---<br>
=C2=A0hw/virtio/virtio-iommu-pci.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ---<br>
=C2=A0tests/unit/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 1 +<br>
=C2=A0tests/unit/test-qdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 96 =
+++++++++++++++++++++++++++++++<br>
=C2=A015 files changed, 111 insertions(+), 72 deletions(-)<br>
=C2=A0create mode 100644 tests/unit/test-qdev.c<br>
<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div>

--000000000000071a6806497aa420--


