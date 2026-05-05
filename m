Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2FFCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKB1I-0007zp-MQ; Tue, 05 May 2026 04:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKB1D-0007xN-8F
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:20:39 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKB1B-0000Hu-Lz
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:20:38 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65318dafbcbso4236652d50.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 01:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777969236; cv=none;
 d=google.com; s=arc-20240605;
 b=G5FhuexNli0pHIFeWMT4gr4MXqvA+YbrYu8FQ3qppE/3/VRsHGuTMb15NrhaRZzjZ8
 g9vy+oIFkQmksYcr1sbpVb+Q2a4gRJ1dfQWrMklgltuxb8KpJhUUyhUiPMl4qKO00hf9
 OyPez3lM+XZsqZAcjPynW6RimM9K6j3xCTTYUufFXjRTcNcuENJ+zXsPY+8uPbTxkVE+
 KJmx0Q/+325ZP+BSH1+4n9OJV7wORgF5QXuIFLArLQmIgpbwgdM8gFC8PIh2S8TfbU37
 50UkYOpMYVRyP/VTY1YswT5BeuvYolKltCdEFwC6DCLQ5YjsEOcAmORk27ElreQ31XBd
 iI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K1qmTy8EJ4ZyKCWKWXi86+TnrbsA4KVefudBDw3LYkk=;
 fh=pCPQ+cPoIXLx4VGPY3mRrggTY/Py4knFfpFq4pfjKR8=;
 b=RXfKuhzMe6QkWOwndaO0059QVEO2z+p0aXH1P+9nL15/UqZIjjTeGfsx9QR+TJb0Q0
 Mo8wgqvQcmsJUblrZ766kquuj6nrj2BT+UgVyaW8cTFYQp25uRO9tmgEcoG4tSNRRt7z
 P3y3kPTZCZ7qhXvnO05SOAfvoOtalKMj+eUSb3gnL0wkFKEC6pQUpoLxWW+qsQdfnq94
 p0Bn6cjUgh2kdIwoxmY8bem7Bk3zl4R+AK1iDhQyoU4tAHfOoseE0OC1+Sw4isC0r0Im
 v+fLz5q21EqJ3KBECUqaEtU97ht6HURHX9xZJanYYmo+9Y8XmoZ9Lnmfcv/8H4phYC9r
 mRHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777969236; x=1778574036; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K1qmTy8EJ4ZyKCWKWXi86+TnrbsA4KVefudBDw3LYkk=;
 b=SN5xVOtVm6xYg77szPhUb8MmGb1SwuLqHFJqtzHHuwEQ+hcLXm5/JMpGZ9x32IO3D4
 rbDVxPezLBdciztvSSyVN5o1kLK3O4Di4p8Shgtkfxhbf++kRmtckHUXJ3hOK3sBovyi
 qafWpz+W4u+O7CMDw9RuvMF2iyLPQ6af06SSpgHuX7Bkzs/0k2iF3gJnqG45gAqcuBr1
 Uu5HIgCf5LXMgHSUO6ysNOOrN4hOh1JFTBB/MZYIVwCq44vxIJaz88sMpsEPbQ+m5qjl
 n9iX6gr9DpJ88t4PdmaJJLCAHGtM8HXOUFr+VCLE3g/mkaXijaRh29q0o6ExnEv/HY1x
 gR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777969236; x=1778574036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1qmTy8EJ4ZyKCWKWXi86+TnrbsA4KVefudBDw3LYkk=;
 b=k8r2WewKVM1NubIBpcDcRwd5ojojl1K9GEgy370lOSNKaijF2/hcPAqSSb7dQtN+wG
 5lPIYKe6FIuEppYDf5uvlPsm38IbYvRxsUR4ELmt5wqrK654C1O81+xjEClYSkDETc39
 4JAn+fry9PVFG0simMWp2ra2uUAUcZx0lvkq9hElG+qnFsMMaeUg6vNwhpHUwM7fKQOG
 XaTOebNqd6aqYHfDIK6R/Z5sJU3G4T/inEPpqJBejP9naIH6GibnpdZwAGdiMW32h/dt
 fECfNu8cvULD9oegxnRPzRFvHlfcYF8tPFRagHCMkfUBAHH/O5hKVM/Mjw5/gcP4qLcc
 9vQQ==
X-Gm-Message-State: AOJu0YygLXwin7YXT9uT6Twgh+f8fi11qr4TaIO0eUwFSINE9D1QhalA
 k0vmqIW4YUjpZ5D1mxidhuoxCKsk6/EIybfEn0M+ESUR7EDEBGzjgVLm1mj5dm8WH4dRg5DK8K4
 h/bAuXeajD8Xk/FBnN1iCC/qm0HVWPubPJaRsvV0z5UlycUGElkCL
X-Gm-Gg: AeBDiet1sX9DorgRSrgg6hAk8TnEyevBiJkjeH9v/Gg5bBz7hOMaV0LHDTbd+9+m8Xi
 L0R++8qdCb2UkAqmaVRGHkWzSu+7G98jc90FXBWN2+3Ri+orO/rKkAfpBarktnFe3O6idWz8ro2
 Plpi12RdZtDHm15B8g0E+i4P1vdJDdkTewuSxC3Sy6kuuBcJy/x45NmZXGHbteLMU6t7ysL2LIH
 0fkmoXSyYJrbAzHJYB52/swNIKbB7pzBALS2b5ZyMu7RbsDMAZNC5U1ImvdZm8dmv2XPPJeodAt
 QU9S6JGUOFBh/mV9hoNxjs66n3gCmNKd+JnbunZv/EB1iGr2i3QIoyh0x4IVVV7pDID1l//BvCB
 eDQ==
X-Received: by 2002:a53:e94a:0:b0:651:d430:7832 with SMTP id
 956f58d0204a3-65c3da13f63mr10727684d50.10.1777969236054; Tue, 05 May 2026
 01:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260504165043.213704-2-alexander.hansen@9elements.com>
In-Reply-To: <20260504165043.213704-2-alexander.hansen@9elements.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 09:20:19 +0100
X-Gm-Features: AVHnY4J0q4y04_BCa69sOSyiUlrSnq3461VczJK1c9Chz5iZXge0kFO2pmb-myE
Message-ID: <CAFEAcA8QB6=vBYpdFAxYYC5XPOLR_5wcj-Gt4rHadVTpSfM17A@mail.gmail.com>
Subject: Re: [PATCH 0/4] initial support for yosemite v4
To: Alexander Hansen <alexander.hansen@9elements.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

Cc'ing the aspeed maintainers as this is a new aspeed board.

On Mon, 4 May 2026 at 17:52, Alexander Hansen
<alexander.hansen@9elements.com> wrote:
>
> Add initial and incomplete support for yosemite v4 BMC-side emulation.
>
> As part of this effort 3 new sensor ICs are added.
>
> Alexander Hansen (4):
>   hw/sensor: MAX31790 support
>   hw/sensor: support MAX11615
>   hw/sensor: support Texas Instruments ADC128D818
>   ast2600: yosemite4 initial support
>
>  hw/arm/Kconfig                 |   3 +
>  hw/arm/aspeed_ast2600_fby4.c   | 298 ++++++++++++++++++++
>  hw/arm/meson.build             |   1 +
>  hw/sensor/Kconfig              |  12 +
>  hw/sensor/adc128d818.c         | 414 +++++++++++++++++++++++++++
>  hw/sensor/max11615.c           | 200 +++++++++++++
>  hw/sensor/max31790.c           | 497 +++++++++++++++++++++++++++++++++
>  hw/sensor/meson.build          |   3 +
>  hw/sensor/trace-events         |  24 ++
>  include/hw/sensor/adc128d818.h |  20 ++
>  include/hw/sensor/max11615.h   |  20 ++
>  include/hw/sensor/max31790.h   |   7 +
>  12 files changed, 1499 insertions(+)
>  create mode 100644 hw/arm/aspeed_ast2600_fby4.c
>  create mode 100644 hw/sensor/adc128d818.c
>  create mode 100644 hw/sensor/max11615.c
>  create mode 100644 hw/sensor/max31790.c
>  create mode 100644 include/hw/sensor/adc128d818.h
>  create mode 100644 include/hw/sensor/max11615.h
>  create mode 100644 include/hw/sensor/max31790.h
>
> --
> 2.54.0

thanks
-- PMM

