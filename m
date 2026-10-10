Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C59ACA9EC1
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 16:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFa8Y-0006XB-1o; Sat, 10 Oct 2026 12:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1xFa6Q-000688-8G
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 12:39:34 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1xFa6O-0003rc-Iz
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 12:39:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cc7d154ec4fso223546a12.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 09:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791650354; cv=none;
 d=google.com; s=arc-20260327;
 b=dkMyTULXvZzeuXbvSAbOtKMZ3Tggq9kSM25cXT6VwvyZSBQOTThHZWGWHtX+f1QxrQ
 I3NNECJatBoHrkHDfSriKWA4aLTEsyKplugXiP50oyJTqwqpzymgqkVhj+UNC52CJrZ2
 WIH7I1LJG3yuQCOOW5DhPbbihm8eNYdEQISGx9wqW4s9YDOjoDyDyY98BeQdeTbHR7u1
 RUkSVPQ72vc+ODfUiM+Eu37neYtqktiiM+xC8d6airT7/+CGecryvRGSy6hFQLR8bwEx
 fvAqA9QIzSzgA0sVVNvU+Ywa9jpZec99C7dmOdXe7T6Cr7lqGEoe/Yz4ZkD3rRpKmFvX
 m55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zNm3WtNHWZQADNQjEMrygTzNnfitUnKGPIErXx0AduQ=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=mcH5qFdiQd4WdrjqHkGqzxCFUl3XNd6/mL516B2eyIidrrxo84368PVWy7r+vp55eS
 dkJv9QN5G7uYf1MTXu+cbsGHI0k8TQU9dWO0AL65J8CJsy00CmCIZbXcnLcaFS6Oeg/w
 eilqX5Z75ycuhO6exqVEsdqgVXfIObXL8MM5+u4kWWstZjce8zzxL9mBVVUcxU6ylf8Y
 3btggNmAt5LIkll94orXQC25tMTTho0uhc92Qnzz2Z5Gvq7LAEw5lU8CjVIKArSRD5Of
 tkl2hLxhS5hC3j4vXEaO49RKq6E7h4/5WJfPQxwmO3P1ZXKxRPJpE6Yq3q5y7PnecZQz
 XSDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791650354; x=1792255154; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zNm3WtNHWZQADNQjEMrygTzNnfitUnKGPIErXx0AduQ=;
 b=lTb+JJpjBcPYhp4POfCEo20bQeDq3C4tDKe+BiR9vWio0e+hAMcbwADm51EWYk6ana
 Y6UskfUw+a9myn7VHG6Gcena0r4CuvkLIV2uwxs9/5Av+eF33objnQGSYLJhHDWBuHO4
 bNCoa9HaGE2F1nGgSsNwlYz0HCIgKNvG0do39sZqQ3DvR2mtOWb/nonUlnv4gpq6RTqZ
 kjHvNG9D0bmpWJhznH5GnP4Ai/KK9+duMql+sK7FvB2iqcfIjQdI52+qLowAaMdA6eot
 K7KnttJ36/YzHQZ1yx3/qp+kGvo6moxK6sK3ac3GkJV6Pvu98FGey2BU8pfigkK2xC/C
 jDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791650354; x=1792255154;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zNm3WtNHWZQADNQjEMrygTzNnfitUnKGPIErXx0AduQ=;
 b=axULg4gHZ3EbuN0mzvJYLaEkIW7U1MFmB1Woem98lRkvOhFOkn4aPMtoKVnWAyw7BL
 dL0PckEuhS0xcbPTKGCLJGeyB8Hhprs7/y2+b8Xka9FYUM8NrhY6cMOzGaQ9m83ilgjD
 +fG71s16UoN2LGayOa2WWCNw1J0HveT+9Poy6f0S3byXeyK826tfZfQ4ks4Q4wpiV4o+
 R1e3iHKBa+LICEuUgO1LL24Yle5rA60QZYNX/I98qt6VBFJ0pLoF7zl0ml2gwAZo4V9V
 a777sgCJQ1PWXXwl05H6WB8VOK8ibaOHVoHTQiUybrhOB5fHB0dg26BXD/6V7n8+CtIX
 X1/A==
X-Gm-Message-State: AFq9FYKr/ptRq9weoj8lee88adr5RnzdTK/Q7mwKVyif2cbp6OwIM+Uh
 lkQswMa1nZG1R7BHP1wLmC/ie0bkvG2XIjr7Y1L6uLAudiv3cRIIbwPuB4ybnm8WxFrztnUPG7n
 qQe8jcNifcPF0i2W4GUR5HoIvgKnnSZk=
X-Gm-Gg: AYBFou37O4y6xO1VLlPBPgNhUnBmUQl/NKkCbITTNNdTBIeUWoiklmPDMsj43SOtKiF
 tAKwy8xmY5UpdspHMuJEVJt9va1NdwwPb2aySN2ZKymAW8WnuPHCYDQ7gl8EhIuKdhZnGyq58Wz
 T5TGiQsyRbY7H0BWC3ncu98SqmsmXpPM+QkIFHBKDJkfsqNgY7HyxUPus4y+p+8nEZ+di5yKXYW
 Nz+sIxRl0Y1SedAwRKhPWHHzhcP8hKEjCbswgKyxeFGCD6XMONxGIS9l7YpZYhbv6E/DN4U3yqf
 MacCd3p+08cp7rMHUgvHKkLRxcPP34ciFtK/7duni0wwBzP6vbyhulfiqCiq8h5Ojsa8vTO418U
 n58PV+8CrTg==
X-Received: by 2002:a17:90b:5343:b0:3a8:cc4f:3475 with SMTP id
 98e67ed59e1d1-3ab3ace463bmr5019957a91.60.1791650354182; Sat, 10 Oct 2026
 09:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
 <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 10 Oct 2026 10:39:01 -0600
X-Gm-Features: AclHuK9h-fDmCgGeYGzZDSwZj_d0vIBlDoBiaR5W3D63b998Cb9TxRuqrwk3R7w
Message-ID: <CAATN3Nr8CAMDNUtuVaPe31GDoSq6XVTQVwqTnaPsQLUC=09_Qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] target/hexagon: pass the packet PC to lock
 implementations
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000ec3db9065d7f1a21"
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x531.google.com
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

--000000000000ec3db9065d7f1a21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:10=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> Hand the k0lock/tlblock lock implementation functions the packet PC as a
> constant instead of relying on next_PC's opcode-dependent staging.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_mmu.h    |  2 +-
>  target/hexagon/sys_macros.h |  4 ++--
>  target/hexagon/hex_mmu.c    | 16 +++++++++-------
>  target/hexagon/op_helper.c  | 16 +++++++++-------
>  4 files changed, 21 insertions(+), 17 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000ec3db9065d7f1a21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 8, =
2026 at 3:10=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qua=
lcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Hand the k0lock/tlblock lock implemen=
tation functions the packet PC as a<br>
constant instead of relying on next_PC&#39;s opcode-dependent staging.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/hex_mmu.h=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0target/hexagon/sys_macros.h |=C2=A0 4 ++--<br>
=C2=A0target/hexagon/hex_mmu.c=C2=A0 =C2=A0 | 16 +++++++++-------<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 | 16 +++++++++-------<br>
=C2=A04 files changed, 21 insertions(+), 17 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylor=
simpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div><=
/div></div>

--000000000000ec3db9065d7f1a21--

