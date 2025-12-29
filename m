Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022B3E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBBR-0002cf-9J; Mon, 29 Dec 2025 06:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBBP-0002bY-J1
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:13:03 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBBN-0005Ba-Pu
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:13:03 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b736d883ac4so1514326866b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006780; x=1767611580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6pMWD35aeuphPucl3Npq6/d89n0zYp4AcSKRcbZu9A=;
 b=O8yk8Xb4MxbeU+KH1hc/llayeD9xKSDfhPVZy3EIcQ4YE8bFd3L7oP0rcR3/Vc75N0
 XCqSQGv/ivITHh1W7YgwF1EKIcRcHkYRZiHmREaaE2f5xBP14n8OFacvlHsRuSEGXTqw
 yJFYjZGww5TFPAWtewfWa6FR6zcTyc6EvNaqioE/Ue6963edObGZt3coXAf/1GgFXA5p
 e5y1TsKdB0x2UkAjgh5G78lE29isPLf90hG5V3qMaLLnpvQrD31y6RU4V9VPId6dtRzZ
 sO2Zp+oGswog1BpSp+Oi7S9hWqEU1h1R8mTIbuyi0Ofs/O8psE6Oxay4Pm4JnXQXadBe
 8+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006780; x=1767611580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g6pMWD35aeuphPucl3Npq6/d89n0zYp4AcSKRcbZu9A=;
 b=hL+5+kdHbYpoHTp76wDW9CLjwwj/bsFSp68TzcX+fexOsWjZD5iOioBp19E/lzsiKN
 apmEsm+sCT9x7xwPV5DMeKRjQexChVg6xNJz49QxMN62q8i8OS+fgNX37VLEAd9GHJDp
 kDPONkwzPGAKypjaZkFXvUSPv8APgafZ+5VPzJQBTPlcNByba4yuFx4hbOJlqNSpVlBO
 /LAI8nUrJ8/V0+vJGjbKtwoAxvceOX6imzqbXnuRET2XlvFx42QYsFMux2Byr2R+EkCO
 QKr+dMHRdXFzyrIhJS37Crr4FWhMYnkDb6ZCfPsuDcztvC20DLUhE4/hIMX3bEomW+r5
 n+6A==
X-Gm-Message-State: AOJu0YwGvvetqTaQH59gCmwaBl3eVc/VHGbhz8XM91fssrETOHwAAlHm
 1SzPECAzd6eFEQs9AX2MebMaFNn2bc6uzsPQ8aj3d+MytJ2UwuxP//LDEIvh8jSFioBLCpCyFyE
 +xOo9c4r8HLtWgv+OWXFYH1wZYn1WKN4gZVfedtwang==
X-Gm-Gg: AY/fxX6iQSNT5dmbYAEa9iH3q1ZqCmMKph+3xpWoEs64wtNW/YRO6sCuMr6rutKPBAz
 KoCTMpIhSGXIvPMrhn7scss7qDl2tRks0npccZBeLzri1YfJ8tq/vt+Z6BT5vuBOjjg2Dlg43rJ
 7Y3rHbWqNr6EO35pWJWI6mCiYLp/lQQlDbIM4SeQ6w4atJE66zzqjhpHJRWJct3WSlSCctwvZlg
 nJo0KJiAGMdB9K9Vl5RqFDxrBaUpUBdUbGGF48vX1BkiU1w18i3abjfuRcq9+VU+keS9QcF+q5j
 j9iOKA+83SQod5BZS3rGogc9zFBsxLLKchkw2FXr7A77MgfRUA==
X-Google-Smtp-Source: AGHT+IGRFXx8OF6cLn9WdrPMm+s+hSWTUxHLxMcajIn6AINGMo5sdEtgFr+5NECbGhdKD10YQwXnpYMCw0+plY43zpA=
X-Received: by 2002:a17:907:6e9f:b0:b7c:e4e9:b13f with SMTP id
 a640c23a62f3a-b803717d9b0mr3275179266b.39.1767006779946; Mon, 29 Dec 2025
 03:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-9-philmd@linaro.org>
In-Reply-To: <20251224162036.90404-9-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:12:34 +0200
X-Gm-Features: AQt7F2pxroyVq-6uY52HuJ9_G8l-0oBn0rp_GC2rF9UbNWV5MNhBs9_CTnIZj7Q
Message-ID: <CAAjaMXb1zpCcnVerLVo3SjgYfY7_Jhy+r+Q_XETwD=yY3=zxrA@mail.gmail.com>
Subject: Re: [PATCH 8/8] configs/targets: Forbid S390x to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, Dec 24, 2025 at 6:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All S390x-related binaries are buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  configs/targets/s390x-linux-user.mak | 1 +
>  configs/targets/s390x-softmmu.mak    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/configs/targets/s390x-linux-user.mak b/configs/targets/s390x=
-linux-user.mak
> index 68c2f288724..e3723f5dc54 100644
> --- a/configs/targets/s390x-linux-user.mak
> +++ b/configs/targets/s390x-linux-user.mak
> @@ -4,3 +4,4 @@ TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_XML_FILES=3D gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xm=
l/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xm=
l gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-so=
ftmmu.mak
> index 76dd5de6584..544657cfe2d 100644
> --- a/configs/targets/s390x-softmmu.mak
> +++ b/configs/targets/s390x-softmmu.mak
> @@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=3Dy
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xm=
l/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xm=
l gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.52.0
>

