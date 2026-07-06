Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F01C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgkvV-0000nP-TB; Mon, 06 Jul 2026 11:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wgkvU-0000mk-Cb
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:08:04 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wgkvS-0002TV-F0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:08:04 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664cdeab266so4820313d50.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783350481; cv=none;
 d=google.com; s=arc-20260327;
 b=SvF87J0ID24MHC1/FBZihFBD+2NHlUwWYEX0YXJ8KOh8OO9gUUNOfrJlqVXpSWMlNA
 wQpSBXW2a94XzbvAnzcT3gH6n6QRuIoy1IU9lyJmt1l2bomfYsl0QyoRlm6kNwvZ0elO
 S99cfdLiSUTcYhUsnEAHAWI9xdquI0aHMLGEd/tly1VoCSkSmZOyrP3ADkpFKsZSMtdk
 l07KqdHbZdz/wPb2X7lDE6OAkwiSXXV11p9kImMQ6Uob6uJnD6iyEdOHS6aQ9fYXAHvI
 NvJzZWAjmsA4pWYftEZJYa610La7QqnJNtV2D+Aye2MGgvYnBN5Kwf7lxWKA8In6ZXlr
 OGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FXjq1104HfKFYgZx7H1BX7GlcJLsPRttQWnN4h13CtE=;
 fh=iDp5i+ro4oOWeHQdE5F92zc2sb8szbNgm/kYGOQWLcY=;
 b=EwDdDBHFh9rIrHQIKD3v7v2wYHBiRXc12FnPOqheljXomBJllJjXrKuDfgRxrNmmrj
 eOWM77VRbyx9DweZoQFdpGC0h65tM7fHd+kFp6Nz1Ddd+pPSsLQB+MXcw3/N/XcqxWqR
 ORReMC3bjwAcGfk1DYivLLMbteJnpTP9/Jk9PpTfIlICRWwAcvWrMYnlOBErS4C1X5zC
 OyQVm1p/4B0lCkMW3gWjsTOgyqiuzxMYpw7VDEbFKyYYGswGxaT40melpJnGvdsMx9Ng
 psdv13D7KA1gXzMT5aW42aepDdVI5n37EOaXRTdpBm/Tw3hhqL+5tnAwX4lRzUXsPJhY
 AsfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783350481; x=1783955281; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXjq1104HfKFYgZx7H1BX7GlcJLsPRttQWnN4h13CtE=;
 b=Ce4Wsoc6n6zQ1qg1wPi5sw8ePix4Fsp/ItAdOPq26e/gWOs5sBWoG2Ar4SHqeGObQ3
 RGO3UbIeelekgoIGgh1Vut9hQMZc0WoNrSzn8N6jW/G/CAJ/wu6zAJ4rDAh7UySi312C
 mx/3jBBPAodpCCz7G93ayMAmi8BdV4R7sbSZ06Nglz29smwtGSXvdzVpitaz5LCpm8ad
 1zaFXBkr2nR8xzXyBmi1HP/FDs26g2WPRgP6qGlzD+utheKyveKP3hdkusPVfo03THnq
 VMRsHGb8SVeuDaDty5TTsVNzEJsInZJ2p/+Z0rxJrNbabluG3teTwtHEF9KI6SZ9vQbo
 1eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350481; x=1783955281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FXjq1104HfKFYgZx7H1BX7GlcJLsPRttQWnN4h13CtE=;
 b=ArKggKQduXKmeSM1X7RxLbGOG3hx81OloBlL4O3S/NEQtNeMtwI9sh95l11jt/QAYt
 aij4bhMSzTAqYllFeuPgRHFOn9N5dCYIcZhBSWbqJxg60XtwyBx0774CkCBYZdwVYu9e
 XwkyUioWWODaWoAUNokOX8NpzQZ1SsWPLNWeSrhozezJU0xl1gwUTed3YX1Km529t0Mc
 KeLH1IOvwA7j0rPrD1tqbsSB6+njolp/isZ04Vv5dQKGFbRKzAYyjJDXSAp1ubVhbyY8
 BQ5l2fwsQ9K0msqOhlpHCbqn9bMVttTO2A/RUO+bRKmlgnsNg1JPSYu5CYvXdlgkvqX+
 MRhQ==
X-Gm-Message-State: AOJu0YxqrEQwnaftVrenpZqYaQIxWle0hbuFsAh1F6e9cDApOMt7L+zW
 gLFXdCNzbD9Mehu1rGaeSghySFC1XsMZ2ZOxLjQY9gUDNq6u0gHUC2QjIEQ+i4gw3uhKbSOA5AA
 YWxT/omvodM6/FXDlnzAWrUfQzZbtoVU=
X-Gm-Gg: AfdE7clCwLlIMGA5EZfVSRgMReOunS4En2JMPHFRarPYR4GTRn8MnLeYFZnupjwzepn
 OquUsz5XLFkhO/gLbjmAlOIKc8e3T97Ebhya7oN2+Y9Sz1MBSotyAlTdxiWa70VQfYp/YKRbNBN
 2X+GqlVylmuagO4Rh9YaC0dQHm6b7BWR9vdBDQHxEXgij2aXLQ/LFg1e9f3t/B0oLEnwzDCOzIT
 BAMXsbMYIfpdr1/xKEhYkdK6Do1OrByJYc+e647jDTpCOY0ifRgj4t2JqGwzoGfcTPmNXr9LbiG
 F2rO4fETZnS2
X-Received: by 2002:a53:c059:0:20b0:664:f107:6cff with SMTP id
 956f58d0204a3-6677fa5904amr717066d50.16.1783350480893; Mon, 06 Jul 2026
 08:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260701155759.43328-1-dingtao0430@163.com>
 <20260701155759.43328-3-dingtao0430@163.com>
In-Reply-To: <20260701155759.43328-3-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 6 Jul 2026 23:07:49 +0800
X-Gm-Features: AVVi8CdCgPba8JYMNuoI75zh601Rq06_cOoR3SDTtK464WIJWYw48pZHCb6YzB4
Message-ID: <CAEUhbmWyBs9iW0dVVYBq5DytsDFnCa38qv-FCYQ6Qe5JYvtiBg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] qtest: add xilinx-zynq SDHCI sdma test
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12c.google.com
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

On Wed, Jul 1, 2026 at 11:59=E2=80=AFPM Tao Ding <dingtao0430@163.com> wrot=
e:
>
>
> Add a standalone qtest for the SDHCI controller on the
> xilinx-zynq-a9 machine.
>
> The test covers the SDMA boundary continuation case for a
> multi-block read. After the controller stops at a boundary,
> software updates SYSAD to continue the transfer. This verifies
> the generic SDHCI behavior that previously failed when the
> continuation SYSAD write was ignored and the transfer stalled.
>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
> Build:
>   mkdir build
>   cd build
>   ../configure --target-list=3D"arm-softmmu"  --disable-slirp --enable-de=
bug --disable-werror
>   make -j4
>
> Run:
>   QTEST_QEMU_BINARY=3D./qemu-system-arm \
>   tests/qtest/xilinx-zynq-sdhci-test
>
> Before the fix, the test fails with a BLKCNT assertion:
>   ERROR:../tests/qtest/xilinx-zynq-sdhci-test.c:90:wait_for_block_count:
>   assertion failed (qtest_readw(qts, XILINX_ZYNQ_MMC_BA + SDHC_BLKCNT) =
=3D=3D expected): (1 =3D=3D 0)
>
> After applying the fix, the test passes:
>   ok 1 /arm/xilinx-zynq-sdhci/sdma/read-boundary-continue
>
>  tests/qtest/meson.build              |   1 +
>  tests/qtest/xilinx-zynq-sdhci-test.c | 178 +++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+)
>  create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

