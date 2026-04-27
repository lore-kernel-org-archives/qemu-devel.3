Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52CCFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHL8G-0002ZC-4I; Mon, 27 Apr 2026 08:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHL87-0002WQ-AK
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:32:06 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHL85-0007WB-Br
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:32:02 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so8083641d50.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777293120; cv=none;
 d=google.com; s=arc-20240605;
 b=DRcY7dUOtIOu3lWrIM/5GHPhkCsmJWakzlULRkNXf9jNEMnHxLUkzTEqOBGP69OAb+
 sJgCLlnRhvhd16/ERkas+WasyESe8c5Tl0AtWJ4OPrcw1TJfmWMO5fc2prF8xvkgkEjN
 Id/lfUIPJ6oITAxBD0BDQ8fJ9vG28URgqECV4fPN+NdzxHSVGvU6AevfJfTMti5P1ygH
 QwqCdMY2df/tGUG0ocH7Mze448zjWhSbkP8wCcoMd2lF/FLEn1wQhphWqGYgk60K3CXy
 QvTJf7LpCYnbYXNJWvUDJA2uIJCpz5lKAwxJZW5Vn8qKHPtGfXOjS+e3sU4Ie4lq2e5x
 Nrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J3QRfePnkbaU/eND3pagKGbin8yvdbzMxXJkv2nz9qM=;
 fh=prtNuGYYgiY4eguOJQBPRxO61CDvCpOH737mXpu+jpQ=;
 b=kqRQRqt4sReZkAtfkemyv9UDgljbnVAN7GUBTCNDpt/TwTJMFv+kaSllQknpsKdWrA
 osM74m2O7QifKamz7C5AB0QVIlpULU84t2f25oozuWdG+JsAmNpkIlSIoGG6NJNPSOzi
 pPTbe7QCsKP2Hu6TsY2Mz16bqX9XYvSDs1NEBs85CJYEdmUIp9QrC0jIkTzcU5N2n1bL
 yYIKHe8sjsUCDS8qg6tMNEmurPuYFSgut13gzFzlWjhZflagGapeyW3hrvxt1KPb73EA
 OW9R32ScdFyQLxK0MUJeSSWQIMltUqmI3QY8FSngYwOqaB3f6X6Y/bDDySxVVBAn+YAr
 cwGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777293120; x=1777897920; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3QRfePnkbaU/eND3pagKGbin8yvdbzMxXJkv2nz9qM=;
 b=Agr/AeBTZqC2hgzFNYnh8O3l1Og6YvMOhKTctrajRcKtaYgNuj4dxCnBC5yAL12CKS
 t2pDRmhpHC1lmL+UY+gNqbKUCsGiv1QHXPAc8i1E1TerMWmMAO/TOU1FSmQfHrwwBfbV
 hlpuGxADGZDUZ5tI62R00YAqfCiX5GGC9dCePFE/5IXBApRWcud3vzpsWQspypjz8rnP
 cS/4HOD0atEt6eFWURsYPEVOZdm8b0S/ZKvMRiWvfxs0nOAQs2TEwxjkShO7u8pGyY6R
 /ntokta73Y6hnRgde6Qz1kUG5stSvjDSksEW0Zd2x05MSfilGRzQSixQD2ZOeBbg3tc0
 0izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777293120; x=1777897920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J3QRfePnkbaU/eND3pagKGbin8yvdbzMxXJkv2nz9qM=;
 b=mSKPrBnOKABEHz1+W9etYGMz7ttrO60QLQx6vo1j94t2XNfBpSLHPq1+3Oztw97OSg
 LtmyPmHxGabIjC3bFsFXHSK+ooj8v5r25IP+8+nVMFuHM7of0EDdKLCaOHOtMdscMao9
 wUQLt/fwJrFxntO7d8gPnxxaWBgg2Xtzg+1Vzu3LxPQTcO+4KFHRKF4UxjgG1303mQ4s
 Fz+M1NupL7icvmHE78XBPStKjOMvFcA0qowt/Wx4r/XdoV9XUWGyZL6vYpY5qilCNgIl
 Ap+A5wo0ExKyOc4XCcntyNM+KaHzSkEWuJBLHb0+v1ojBwarxPvfZnGNLMp5mZHQdoNS
 9hSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pUcI+MtjmOmhZWBVqj2CdGpFvkAV+j3tcsO8uRCfT39ObIlDItPTNvus3aVZ4dBp3WwEdq/E/G2uW@nongnu.org
X-Gm-Message-State: AOJu0YwIxdASE0yDcUkCR1MdAeV5YglpaaYfa0FjGB/m6rOssgTb9/6O
 wWkbm71E758mOWpOgBgsxiqqKL8RT1SkJJF/aSQ/WIYfUnLikuHbjFn96JlyamH0IzqbIM0+nKG
 5sVDAEV5YRTqFtBxwzkpvhaToqTcTllRmo9JS+CoKXw==
X-Gm-Gg: AeBDievVGNA0uzTqf4sZBvPFTZhjtn5XGxFHx5SRcS0QG9w8nQi3q1dLjafd6/gFzQy
 xTw919U/LkTzMQ97JQI6aWI+VvjOhgzXcdMfR25ZipILjVToz5MZpBuDBdMmFTrdAKyxCjvTWPD
 ZrH7TDNLJcS+cxDY2lG3O+Dj5qTsRNKrEoKwOAyR2UwTxk+oYX1eUCmLTEBu15qY12W3/KT0mT8
 X7a7+O9jONjBdgE5tIxa4ckD8U0HbtFEVD1bkEdSJLgpe6dKn9i1zyLV9zg8fPDJxo1dOMtrX5M
 h85KUGkuyboZpNamX3T5nGHa2udJxRW035cUigtkoPs6yURsn4voB+tVneDR1sDaxXIImZQNn64
 LcQ==
X-Received: by 2002:a05:690e:b81:b0:652:dd57:af1f with SMTP id
 956f58d0204a3-65310b87f31mr36640237d50.61.1777293120154; Mon, 27 Apr 2026
 05:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-3-clg@redhat.com>
 <CAFEAcA8Dja4yqnaHsXc9pg6EzEAVZFR3=E0sGa9Bz4bvuf+_bA@mail.gmail.com>
 <CAFEAcA8nyngyeWi4Vb=ZWJfxNsyFfSqFJMnWnYG2ce95xaCfPA@mail.gmail.com>
 <SI6PR06MB76313BC0842AFB0A8C204E42F7362@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <94332917-c953-4ccf-9e9e-ccb0f2c784b8@redhat.com>
 <c6b6f903-2afe-4753-a522-64ffdbe427c8@redhat.com>
 <SI6PR06MB763139AAA2BDD4AB53767B56F7362@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <9137d6f9-42e0-4855-bf9e-f345bf6ed2c0@redhat.com>
In-Reply-To: <9137d6f9-42e0-4855-bf9e-f345bf6ed2c0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 13:31:47 +0100
X-Gm-Features: AQROBzCFHHxiec420iorzbM89vkwP45XAuSzyhidlf6C6maxrLDx0O1hzx-ROzY
Message-ID: <CAFEAcA_uid3LJwUZbbgpx6v1wjTbTwAxr8Je285XK8SwHHr0_w@mail.gmail.com>
Subject: Re: [PULL 02/32] hw/misc/aspeed_sbc: Connect ASPEED OTP memory device
 to SBC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 27 Apr 2026 at 11:53, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> Thanks a lot. Peter's test is quite nice too.
>
> build :
>
>    $ ./configure --cc=3Dclang --disable-docs --enable-asan --target-list=
=3Darm-softmmu,aarch64-softmmu
>
> and run :
>
>    $ cat > aspeed-otp.txt
> # set SBC R_ADDR
> writel 0x1E6F2010 0x1000
> # set SBC R_CMD to CMD_READ
> writel 0x1E6F2004 0x23b1e364
>
>    $ ASAN_OPTIONS=3D"fast_unwind_on_malloc=3D0" ./build/qemu-system-arm -=
M ast2600-evb  -accel qtest -qtest chardev:repro -chardev file,id=3Drepro,p=
ath=3D/dev/null,input-path=3Daspeed-otp.txt -display none
>
> Something we should do more often.

I would quite like to get a sanitizer build/test run into our CI;
I worked through a lot of the existing failures in the runup to
the 11.0 release, but need to get the last few fixes in (and
sort out the actual "run in the CI" part, including figuring
out what split between CI jobs and what timeouts to use).

thanks
-- PMM

