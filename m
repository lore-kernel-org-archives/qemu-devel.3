Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FE3CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkIh-0000XD-RB; Mon, 05 Oct 2026 11:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkIf-0000We-5v
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:08:21 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkIX-00064m-Ag
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:08:16 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 956f58d0204a3-6768036283dso1314938d50.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212890; cv=none;
 d=google.com; s=arc-20260327;
 b=OHtZIIpExu3VHfU6XGaPzkRvOtNz2xce0lqC9evKvFxmUA6blJZ+1sUEr7mnFVEIOM
 Hptx1TCy2V/dTu0jcoH1bMTrqkXR+EIxF+Dl2b4Xt5XgTPbd9OmV4kl7jvX/RBxvbjbR
 mR/4K5eWsxWCpW+vSzFo/DQEj2Or2Ne6ofsdh/lIeqQfSMJtdQQ0G6wxL6FaJFQwZEOX
 vWh6AunLwJXKXa+fh7YLbG5JLYeW5u4VXQf7Os8D8D87zx4gPsSff4mMCM8tK34RtCBM
 z9vU6/2ggxUDZCerSKTxd6+aUmYj6XiRJLQ9Cll4UKDgBI14kKuJFECNTf4pScU9YWsX
 K8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g9XDQERIpEJdOMP2/uzhWF5CSnKyHjRJ3Uin0QIeTek=;
 fh=EjplmlcXR8MWJXDdpR5ncThIs/e4S293bvxZuvqDLMM=;
 b=FPHD3kkTbWbE2AsyaOhVSB2jkV7deeR04k+mxnEMrie7h+TqO+yVEnn/bhobhHjCjo
 ducPbxITg/iM32NMj8PDNTzz/9dS/7umX8puuXCi+GnTcylLsIYPX06McosAN5wnDno3
 SQzRDiGUuP8T9Kki5rFyKGnTuISk+WuktCndfIHsci7tnkwP6iwVFn1AnYLgZE2zyaOP
 rSXFk2z4Igiqixf0z+1+BblkJSIeUf7rCvHZVFajlBXgLXL4IXtpMn9nbc6XrsPqB5Fn
 oIQyZfPdtIB1DSopo7CuNBRubzSV2q6wJPjWuqyokyQ6izrMcGW6Q7q/qhQMbgohB9GI
 mbAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791212890; x=1791817690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g9XDQERIpEJdOMP2/uzhWF5CSnKyHjRJ3Uin0QIeTek=;
 b=OoxopEwil5PXpWv8p6/HqW88hLLO8Fy+lPjDyAs4i6F9ecMQ4yiqV1IkHq7Voht0gl
 3B+dIMrQQAfEWlKtzdx+LZjKkf8Odmpy2TArEUZrt7iujL6Nket3V/PkoLiTvT4VugtY
 4ZP6prLAOrvEuhcBy081whk0cFK3bE3Rvu9Dsj0wmJDzEDqe1mjet7C6puTxEeonOpWA
 IK7swOOLS+H61W8jYZD59soyD+XWeOLVx5vaxelEDz3jjylZxNjN3mSUDv0MuuTJE2AO
 dUHJE6F1xPfAyGTNpduoEwYtsfxGXDK0xQQrxyVOxAWGERUbwiu8bJTErpglo4Ezjm0i
 gY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791212890; x=1791817690;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g9XDQERIpEJdOMP2/uzhWF5CSnKyHjRJ3Uin0QIeTek=;
 b=rQzXZdQPngzASA7JS34UxYjFqOcCZ3omF1VyNQLsJpdHdY12Y53BNF8yazKN7xZ368
 BwFK2N0NsU1VbFyvbL/8CPAPoa1DaBjN9lUcyMqqnipx31vUek4vkgH9AiqYMP9TFmaU
 OZs8RZ4n4Y+Er1X3o++X1bKg/rD0Zn5+XvixcsrCErIEk1y7yZgPl413CKaA99Rxf5GA
 poH167w5UryrKXzpv64Z97fzE0mLLWid94kooBQ3t6F76xZSG300r9HVIVzMoP+JqUEK
 1dOIIXl68xSSLB5+NKRJPOeEhfrMtcEBbTXrT6MgzoH89ZAZnj4qrIoT1OJlrx5UluFP
 whpw==
X-Gm-Message-State: AFuF++mMdepdTqiA8BDvZ2hSUkEZ4iLvlBPIQnxpEYjMLpPJpR/G6Svy
 Xw7jA7TEeT3hxnfkRnwMmHbOHsvMkmVYFW6vRyxCQwOg2uhK99WL6hCcghFpcIX4/2aY4eLFDUp
 iAJbHJztQ3e1j7DaXRE862UIi9Pr7ryY=
X-Gm-Gg: AYBFou01Jb5wQ+0b4PJ5LNTMt8veDv76MUToD4swTvMTmWQHRMQYfOsiot15j7LOOQQ
 Mhd2zRRiLBQU1p2dyoODPWJu79JpojJBJE6nBFPfZ4d0TZdWC3GFDVwDjxbhbf6kGRb0gxeCSgX
 yaWNxaDQBx8DHtKAtV4jmx+OLqwDK7VCyEB78Ig4m38fZCtDz1nDN4J2eoqW95BicGNj8Yv7UZ7
 vyixrjMzuwwmt31EWuXEu2ubv6vX0cAFOsMkiV52WLL0GA1PYsNc8Vlt4Ma5nIlEKHWXWOYftNu
 7btVvfdF5qV297Vb6lxMozrkqtMP2/9bxs8ESYrCXlCwwVIkOW/wps1DK+t1sunVhbelzmw75PK
 csoWDYXi9qaUmAEM4X5S6HHecog==
X-Received: by 2002:a05:690e:11c9:b0:677:bf19:f06b with SMTP id
 956f58d0204a3-677bf19f758mr2332695d50.84.1791212890137; Mon, 05 Oct 2026
 08:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-15-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-15-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 23:07:57 +0800
X-Gm-Features: AclHuK8z3qK3xccJoMLL7NVz7FZQRz7m_Sh4-My2IkNTLcGIon1NGaq0QsjSEuk
Message-ID: <CAEUhbmUBYsV77Pb+uPL1OBnCurhYpbvObisXtpGX-mcY+TtqZg@mail.gmail.com>
Subject: Re: [PATCH v3 14/31] hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 5, 2026 at 6:23=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
> machine reset.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/arm/fsl-imx6.h | 5 ++---
>  hw/arm/fsl-imx6.c         | 4 +---
>  hw/arm/sabrelite.c        | 2 +-
>  3 files changed, 4 insertions(+), 7 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

