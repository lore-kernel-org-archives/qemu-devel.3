Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675BFFF493A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w74IP-0002sG-W8; Mon, 30 Mar 2026 00:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w74IN-0002rI-H6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 00:32:11 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w74IL-0005hw-Uf
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 00:32:11 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b980b35534eso781093066b.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 21:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774845128; cv=none;
 d=google.com; s=arc-20240605;
 b=X+zPlokL6Gi7prYZACyVGscbCp5qRwXhgvCNtNNrQfrlS+h0lzemaiZWZVzEFi0Le1
 +DupKHC3rqV+N+cQtxgB80pHtnmUAaVGfR2OUawrVGxZFvsff6LxubWV7l4gQCv9EtbC
 ncHLpB+3SCNWdoZUThMFOCRLsJXVBxhE8K/+mfpOeGkfEu9lv9eoLNNA1pnZF2gc762w
 arh5/invzNXBcaMXoP1V4RHQRcplsbJsSoaJSnpQSRkY85np/UrqGwEurM7vh1bFI/t/
 +ejdE1dtmFt+e2Sc2n1Lhr5v88Cer5qnkCgSyh/aEWeWQTJOKJo/rpdE2yuCvavY1vVP
 Yq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HUxknrcLJxiaIaqDvu9lU6L2M21SLrou8EajFFXcWPQ=;
 fh=XYopJtAKGwtrHsauzFx2fKFe4j1cAbUlbvLylt/rFJo=;
 b=O22O9taCLUSjIl4oPTnWDmarHS0lsF9CgknbDC8YeCNyk3MyZqjA1O/zEcfMHEGCAU
 omSrDqVxEsCpxpoJFuJjj0EbteirVOJq7QR1jyswBPI861U89IJuquW9xX7KpCwR00PX
 lr6EoPJ8VdGYhm+hboQx5JDhrTomSs5fnu+FRCTl6wxRfU1uFURSCv9vM5TRwjONCS9P
 93E13AN6ghIITrSVwgsWhvnQ+hYuX0/zOtuwtOS+uYoAbZc/psSbP/Jb3cwdPIUIZjLk
 bsOt1ck8nXtcnbVh86q48n5uzm+XACUQbLY8+Rk9jLBw4QlhaEk4SQHADSlY7AggLjxL
 zd2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774845128; x=1775449928; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUxknrcLJxiaIaqDvu9lU6L2M21SLrou8EajFFXcWPQ=;
 b=aYynbLEVX/F2hpqf8H/VlZuELvs1zli5pM/mfD0PkpR3gKTfe3sBeT5C24djLijJhJ
 +uTpLRLUolFMpuwNGGlznGzGrt76s6Tz0ZGfMA6ef1zwraD1nhti2ocCJaL/w1OQjPB3
 DQaj0CuWAkJ4LYv+hGNukwiWbn74aSR7LLwChhdB4iaOouqVYsLYXqUZDvp4ytuQMi1A
 VqJRQf+tIRnK3byGJpyeBN+XTGCbwXXufjg92YHJsX99fyJyjKSE2WSU5lZSkEXg9RN0
 IS/qXrSxZpXgmlSZidQtMw6LC0y/TYcPnoolNxJGd6K9lop3KFBilciu5RlmRodplhwS
 kkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774845128; x=1775449928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HUxknrcLJxiaIaqDvu9lU6L2M21SLrou8EajFFXcWPQ=;
 b=eBdwSO2kiWebtlZ1ca75Uz78IlNaaETj4rduJVx4GKT/+5+EfmqFhjLqJngPW9AlRm
 x7TkpGwxYyEttYT+cX5l2bVQtxY2y4COczSjbM5ZhjdHqASgxiawEs7L6zgelP6zFiAe
 RL2yAmfmonAbSVqSSMf3Bo9pj613EhZ4zMO9yUz9LFQJq7oENyDqyy78asJI0PntlIRE
 dGn3dMp4RIyixFTdL7teflBJCPrW5aoaRVE1zVo5ZU3wYiF1UWFbSH/w1EKQ9aq+cWbr
 f4hHFv/k0th5CeyjXiz3vqngFLwyQlSEPw3ECFm/zOBbKUr9ToS3nRNWTieg8ruioxMT
 N+NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIEXRD52MsDi19PEFJZMD4vJo/0YO1/F3q7In6Ff71cFlq/JqBnNTXN7ZiXYqxh5hQJWodgMAHnBP+@nongnu.org
X-Gm-Message-State: AOJu0Yxl4prKcsZw+W6zixPZj/zqWjkze5SCkDJESoyyZH8oLlNUkEx3
 BqbMt9uaGLm8oNDIRPH/Ykt6bGzWW/AbDR8sd8QTnXepJJDAy6Wz+j1iVOx5b01DFFjeANFd/jM
 FcjM0pXGIpGHDEikXbwnf7qZ//9NhxOo=
X-Gm-Gg: ATEYQzwnMA41jBNwDlm4tVbHjh+GIBBy+fcRtob5SFRTx6lQY/qVihxXqZRZnafYTT0
 3E1ChHh3mU2LSr6PFY2go5LcqRs7gwmKUsp+yY37RASAZUaRU2tmNwjEQ4THTCuA+mJHqonmzQT
 8bwva6nCTS/1BZKGj6q5m7Uu9EV6Y5TE7k3OKqTPwwps3dHc+QO8G2RYEqD0/OUDCEbkMd48F6r
 0QA1YqML8hTMoimm89eKJ31Ehc4O67IvulH3X2bEGFim5XXV5yFl2g/7fINvGm56ULhwQHdTWtS
 b6Z7AAYzLMMlxG8JDByaLSD/yxbPyxe5KdeWtg==
X-Received: by 2002:a17:907:3dac:b0:b98:14e:32c0 with SMTP id
 a640c23a62f3a-b9b2e5e6da4mr780864766b.14.1774845127653; Sun, 29 Mar 2026
 21:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260327145012.907264-1-peter.maydell@linaro.org>
In-Reply-To: <20260327145012.907264-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Mar 2026 14:31:40 +1000
X-Gm-Features: AQROBzDHnQetwKvhJmhU56mAsxFqJ47B6DALJ8v3qewDB70SpyuLfbCm6tH3coQ
Message-ID: <CAKmqyKMUaHQ2uiqVnT7M98AFenmZOGJd5AAShgtKt5RgDo8APg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode
 option values
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Mar 28, 2026 at 12:51=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> In zynq_set_boot_mode() where we parse the string the user has set
> the boot-mode option to, we use strncasecmp(str, "qspi", 4) and so
> on.  This is wrong, because it means that we will ignore any trailing
> junk on the end of the option string, and handle
>  -machine boot-mode=3DsdXYZZY
> the same as
>  -machine boot-mode=3Dsd
>
> In the documentation we say:
>  Supported values are ``jtag``, ``sd``, ``qspi`` and ``nor``.
> and that's obviously what we meant to implement.
>
> The correct tool for this job is a simple strcasecmp operation.
> Switch to that.
>
> We use the g_ascii_strcasecmp() rather than plain strcasecmp()
> because we're comparing ASCII strings here and don't want the
> potentially locale-specific behaviour that strcasecmp() implies (and
> we're trying to standardize on the glib function for this kind of
> string comparison).
>
> Fixes: 7df3747c92d13 ("hw/arm/xilinx_zynq: Add boot-mode property")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Kostiantyn: I sent this patch out while it was on my mind, but
> don't worry about conflicts with your series -- assuming your
> patchset goes in first I'll fix this one up later.
> ---
>  hw/arm/xilinx_zynq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index d43f36b718..9dcded9219 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -186,13 +186,13 @@ static void zynq_set_boot_mode(Object *obj, const c=
har *str,
>      ZynqMachineState *m =3D ZYNQ_MACHINE(obj);
>      uint8_t mode =3D 0;
>
> -    if (!strncasecmp(str, "qspi", 4)) {
> +    if (!g_ascii_strcasecmp(str, "qspi")) {
>          mode =3D 1;
> -    } else if (!strncasecmp(str, "sd", 2)) {
> +    } else if (!g_ascii_strcasecmp(str, "sd")) {
>          mode =3D 5;
> -    } else if (!strncasecmp(str, "nor", 3)) {
> +    } else if (!g_ascii_strcasecmp(str, "nor")) {
>          mode =3D 2;
> -    } else if (!strncasecmp(str, "jtag", 4)) {
> +    } else if (!g_ascii_strcasecmp(str, "jtag")) {
>          mode =3D 0;
>      } else {
>          error_setg(errp, "%s boot mode not supported", str);
> --
> 2.43.0
>
>

