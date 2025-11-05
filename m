Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB07CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGjYX-00032D-C4; Wed, 05 Nov 2025 14:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vGjYV-00031e-JF
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:52:31 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vGjYT-0008Lo-M8
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:52:31 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b3c2c748bc8so22973466b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762372348; x=1762977148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gXmES6vJZwCjqUC/zDfnWqDCTHuhj/G64WNmTGcO5M=;
 b=fnoMA5WlKMf5sWOWW0Mc5M7RG3qPiEPEoJtqESQZf0C6TP1/mtCBsN05hqtOIoMw1x
 nhe6JYVtYlEn7SP3l5SfTyoB6uzwzZ5Mblw0P45vLMkPByAEiNM4nB0JtoM521UtUVpi
 /lRF+wda4mnXRaXGt7sHDr19CsylFVWXkI96XNgE8mvF44vftVRnWUerBIQ/rVKSbnZU
 EUufbHiPyk9JsWfIWsh+Khr0mwCn1q9EfI2DrEqg3NwoVibbLJ1Ax2eZphTgNCkzpNHy
 5iYhGx4+a4XSqJs0bTL9R+a2Jd/0wObt41avIuXeCzqnurb323BB1jyba5YsSuLmPHJE
 x0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762372348; x=1762977148;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5gXmES6vJZwCjqUC/zDfnWqDCTHuhj/G64WNmTGcO5M=;
 b=Kel6kUhH97Nw/Uf+heFC8ks35XCvYEVQuToyynMx4H+Fu4GD0DOSst9IRLpqixGXjY
 1TGwky+fn/pfpf5Sno4TlslxMvYe6CoAGVfZp+b47IMrRsakXPFCgo0/6Q/6iXpJ1O36
 juo73IkznZL4WGz91oB5g7ddsNJ18oIrB7Y5rVf5hJ9xYacLTSP/HuSli+6e+E6SQdLr
 +YWBL8zqmjUEcizcRrzTw3udlaAmGamkwDmX6wKpAzDHFwyPfzhnLwCTqvVbIt2cSYj/
 60ler5DKpPiQ9roGGLhj/xMdOywL9DJT9VpweZjUXTVTcNrFHdJer4Wupo/5djKGOvbb
 yGxQ==
X-Gm-Message-State: AOJu0YxGMXm+RSii3xjcONuLEbD8MLSw4PpNblqdgivFLvYrRlqIX7hS
 BD167U9mWy13yVJ4H+hggou5ZveKtrJgmtjeDTmj0DWxiTn5kVEUf/xxkAhIeTzVB3A=
X-Gm-Gg: ASbGnctSzqj8JD2jyv9epohX3nbCOSUDgYUOCnZU8Y86VM953OYKQ1MmUfy6d2Jl5dy
 RaFxsjq2Hrgu4gpeXd2VeJBCqnH3FGX1sIjgiDQpaNSJA541X9Ut7Ba6P08iaL82PFf22SgJNG+
 XOUW3k6hgRK+c/IH+nAEYiTaoseJyazJn0wVc/CTDfvFgpo3u3rvTsaD5oWoAyaTXsxV3YdqSyz
 akIYxkKr8MRL8112OcOtEREDBeuOUYmgMAkzGOEnGRCZoFB4QY3MT1Kvqh9zO37liXVay+Ea3tq
 d0EaIq0OsenZesToGxDMDZOoisDkEhAWGypXXy8tRfoYT8CNiqGrOWe9w2X9UQh05+nbyav5XqG
 jRabquroZKPd7+bJzuPXviNywKZYhizVF3ntUGLNTindehC6kkH5w9ZerkIw0j20MS4lxS2AOLp
 aiYWX9pzbcguM=
X-Google-Smtp-Source: AGHT+IHlh+6y4ng7X+7hWFUO6Pl87/M0xtbRdXr6xYEu5Re5laTrEcedebrejwHhP6b5lY2P0J6K+g==
X-Received: by 2002:a17:907:3f24:b0:b42:9840:eac1 with SMTP id
 a640c23a62f3a-b726553b597mr430898566b.49.1762372347760; 
 Wed, 05 Nov 2025 11:52:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72893cc686sm46862466b.32.2025.11.05.11.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:52:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D40E5F88E;
 Wed, 05 Nov 2025 19:52:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org,  mst@redhat.com,  bill.mills@linaro.org,
 edgar.iglesias@amd.com
Subject: Re: [PATCH v1 5/5] docs: Describe virtio-msg-amp-pci
In-Reply-To: <20251028152351.1247812-6-edgar.iglesias@gmail.com> (Edgar E.
 Iglesias's message of "Tue, 28 Oct 2025 16:23:50 +0100")
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
 <20251028152351.1247812-6-edgar.iglesias@gmail.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Wed, 05 Nov 2025 19:52:25 +0000
Message-ID: <87tsz8tfye.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  .../devices/virtio/virtio-msg-amp-pci.rst     | 70
> +++++++++++++++++++

You also need to add this to index.rst otherwise the docs build will
fail.


>  1 file changed, 70 insertions(+)
>  create mode 100644 docs/system/devices/virtio/virtio-msg-amp-pci.rst
>
> diff --git a/docs/system/devices/virtio/virtio-msg-amp-pci.rst b/docs/sys=
tem/devices/virtio/virtio-msg-amp-pci.rst
> new file mode 100644
> index 0000000000..c73f7a878b
> --- /dev/null
> +++ b/docs/system/devices/virtio/virtio-msg-amp-pci.rst
> @@ -0,0 +1,70 @@
> +Virtio-msg AMP PCI
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document explains the setup and usage of the virtio-msg-amp-pci dev=
ice..
> +The virtio-msg-amp-pci, is an emulated PCI device that provides a small
> +set of features to enable virtio-msg over shared-memory queue's.
> +
> +Usecase
> +-------
> +
> +Virtio-msg is a virtio transport where driver and device communicate over
> +messages rather than using memory accesses that get trapped and emulated.
> +Virtio-msg depends on a lower lever virtio-msg-bus responsible for deliv=
ering
> +these messages. In this case, we're using the Virtio-msg AMP bus which m=
oves
> +messages back and forth using a FIFO on top of shared-memory and interru=
pts.
> +
> +The virtio-msg-amp-pci device exposes a BAR with RAM and doorbell regist=
ers
> +so guests can implement the shared-memory FIFO protocol and QEMU impleme=
nts
> +the backend side of it.
> +
> +Virtio pmem allows to bypass the guest page cache and directly use
> +host page cache. This reduces guest memory footprint as the host can
> +make efficient memory reclaim decisions under memory pressure.
> +
> +Virtio-msg-amp-pci PCI device
> +-----------------------------
> +
> +The virtio-msg-amp-pci device has the following layout:
> +
> +- BAR 0: Registers (Version, features and notification/doorbell regs)
> +- BAR 1: RAM for FIFOs
> +
> +Each FIFO gets an MSI-X interrupt reserved for it and a dedicated doorbe=
ll
> +register::
> +
> +        REG32(VERSION,  0x00)
> +        REG32(FEATURES, 0x04)
> +        REG32(NOTIFY0,  0x20)
> +        REG32(NOTIFY1,  0x24)
> +        REG32(NOTIFY2,  0x28)
> +        And so on.
> +
> +How does virtio-msg-amp-pci compare to virtio-pci emulation?
> +------------------------------------------------------------
> +
> +Both virtio-msg-amp-pci and virtio-pci emulate PCI devices and allow use=
rs
> +to plug virtio devices behind them. The main difference is in how the
> +guest uses virtio-msg vs virtio-pci to discover and configure the virtio=
 dev.
> +
> +virtio pmem usage
> +-----------------
> +
> +A virtio-msg-amp-pci can be greated by adding the following to the QEMU
> +command-line::
> +
> +    -device virtio-msg-amp-pci
> +
> +Virtio devices can then be attached to the virtio-msg bus with for examp=
le
> +the following::
> +
> +    -device virtio-rng-device,bus=3D/gpex-pcihost/pcie.0/virtio-msg-amp-=
pci/fifo0/virtio-msg/bus0/virtio-msg-dev
> +
> +Multiple virtio devices can be connected by using bus1, bus2 and so on.
> +
> +Device properties
> +-----------------
> +
> +The virtio-msg-amp-pci  device can be configured with the following prop=
erties:
> +
> + * ``num-fifos`` number of fifos (default 2).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

