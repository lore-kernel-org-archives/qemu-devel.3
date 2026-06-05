Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB680CD6E75
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIMZ-0004mc-P6; Thu, 04 Jun 2026 20:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wVIMZ-0004mB-8K
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 20:24:39 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wVIMX-0001OQ-F0
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 20:24:39 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68ae265815aso2434455a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 17:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780619076; cv=none;
 d=google.com; s=arc-20240605;
 b=KQlbvdqc/hrmvST3RSRSr4JS+2IB1Xa9U+LRhbL5k+ltI/oM/V1VGK5u7uxQxkdEh+
 I7gTSFNI2NylGh+Q9vRPpc2b3s2fpf1Gdixz5F4le06kbUTtLL+/hJSgaLty4ZkixwHy
 pRlOvRB7ZDn0KZO+6Jpu3e3jpv/bBdcvegmVfnu/IntdIK7T6NOiNke4Ve26SKcgoyaQ
 hoQu9CHxJekAQW+OwZpJ6tvv0MgNPGGD85gqVe5vrXN2T6uEzV2rgDx7jIHnTCA6GVDV
 Kex3wpCb7vBCAQx6x8cndI6iSbyZE2yzGcDHRSA9KfpaHmBsosG66y+1n5eB7G5F+QW2
 NmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5PENnKPIUyscqOJXAJJYOCoPRLH4XUM9LEFtE/s6m6w=;
 fh=V6INWbzQe0y1ROSVxnx580DdClWrTznivLYC9O65CLs=;
 b=evNMu+4IHpWOUqNEFe871jpVA6XDr3Km6wgxKarwmrHSjtb35UVXP1eeucxFCWiYX1
 kyMGtzA4cBbETFj1m7aXgTo6Sqyk07GQ9vv87DT9KOf119pUYobHYHUd+zjCBBTHlvV4
 tZ7YMHLB9BPi13DwasiLexCUU/6+x1K+qcj0h3gRdI0jBgHTXmhg/e++5ZMOychirxv3
 zutiMNxp3BEcDuxPXlGZTTaEZIRcT4zhAzbtADQQzne1jJFeyPy/pK6NMcMX7gpJRDHy
 hQkgdWPpdYs1iGZGI9dqqlmUm/aK9HRRpKVpctOmXqt836YQaukBmFXnqCYehZXVxCo8
 1zGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780619076; x=1781223876; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PENnKPIUyscqOJXAJJYOCoPRLH4XUM9LEFtE/s6m6w=;
 b=TMfAVL4w652PqrBL9tErH9S2kO1KuE6seSCPTLdTNlUhIYI8phxyEYUsftTEuT2vf6
 E3XDANf15j7jAY/+Y70DKotMEvQX6NVcCE+ovXEEz7iyQGllxGwxHWZRntmGHDD4S1Kb
 7GAghcpcgy+M3SYA2Obfv8zsg5bAhW/sQsXO5ndHRd6YoUZLWEk5wC/vimNSgUb7j3kf
 +JXZBc3QprGo8gRZZoVluEhUbRq/s00FewZaHXXeT7sOtaz/9Kk2g9Xoiri4RGmdfsJ7
 gbWd0xrQyinnNiIiMaDiqGtWLocABIzweM2s7efYkqnRVh3oNENmtw8oF2U7nlKLZ7aP
 0DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780619076; x=1781223876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5PENnKPIUyscqOJXAJJYOCoPRLH4XUM9LEFtE/s6m6w=;
 b=qZBVo1Q0ERh7ClGdwhe8XwDyOVrvG9YGOUv+tWp1tVnZnX3uDFt7i/klyv0bDa3ryd
 MENAB3+7vRMRAJTgQtHUPLMl0Ks2640UC+I8Jo9MvJ2u9ZQXT7PVhX4lYgT+NFo6N5f2
 nVKiL+tekDVWpDor8tsWqZOXYuNYhqZxJMyVJ4Jw4IMjcB724qHJ44lVKR4TjlPjMJ6j
 3ckORqyA3Z0ItAHX1e5HxIdIdtIXjB6rixxXYSI5Cv7WymdvFsarlY/ytYQ/Q3jI1cAd
 1RxJr+bu47w1jDt1BItFjtOX9TOpENmzwdSh7Nxxc1FedqzqXE2FCRS46ipPkQVYgxKf
 6yFw==
X-Gm-Message-State: AOJu0YzN4R2RbLTZ3o4BHw8iw+rknPaLXMVCm1g5HI64AnMc/ZQwTcbI
 AxP7FJntaXTQ2RzyN/KSmLzt3GPTs1v3OJI9YQAnHP9uH59O4b6iie3mizQu96wYi/ed2V+BagG
 nkFZCiYMyNcQ02qTA/zqhMjiA/NEldus0FnF9
X-Gm-Gg: Acq92OFSUHPzoXKsobt4VXNdqO/PaQHoRH5HpS+r67sXSyylNdu+rJauqBAncyFAuVs
 iIr3QJTXGteitodvMG3OijIlEH03EYcnrmrrExNQ8QpRDeLxLDkFK4Gkk3iO8DJQ50D1wWPIQL9
 qb94V9uwpnVaZifGAnufyVxY4Dgl5gxY9D72+sEARhyu3aHzzoE1AtZ0nFrxAgxK5qLytIQI9mH
 iEzLUYIVcnrZlQP+Wkn9aTjGGgTeJMLONxfaapKbM5Q6yxhRtUxN9TZ384n+yA8v9JvJK56xeoA
 pxONTCDw2/6VeTDW39AZUTBkymi9R/YsoAisTH0YncDUxZJW
X-Received: by 2002:a17:907:944e:b0:bde:137a:45a8 with SMTP id
 a640c23a62f3a-bf372d29f23mr47163966b.39.1780619075645; Thu, 04 Jun 2026
 17:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-15-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-15-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 5 Jun 2026 10:24:08 +1000
X-Gm-Features: AVVi8CdbCwkhYmPCJYT4NHTP6-7dhs4qihrryP9IWiwWfAlwNkJkqNuIyBun1ZQ
Message-ID: <CAKmqyKMjFD00b5Px4Ma76+UMi8Ne1+oRcBWWb4E+x3mgae4OiA@mail.gmail.com>
Subject: Re: [PATCH v2 14/38] MAINTAINERS: Drop bad F: from "Xilinx Zynq"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jun 3, 2026 at 4:44=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> include/hw/misc/zynq_slcr.h never existed.
>
> Fixes: 246f530cdb (adc: Move the zynq-xadc file to the adc directories, 2=
021-05-18)
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 367d37f40a..8b28a21fe4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1141,7 +1141,6 @@ F: hw/misc/xlnx-zynq-ddrc.c
>  F: hw/misc/zynq_slcr.c
>  F: hw/adc/zynq-xadc.c
>  F: include/hw/misc/xlnx-zynq-ddrc.h
> -F: include/hw/misc/zynq_slcr.h
>  F: include/hw/adc/zynq-xadc.h
>  X: hw/ssi/xilinx_*
>  F: docs/system/arm/xlnx-zynq.rst
> --
> 2.54.0
>
>

