Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BE0CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWa3s-0004Dz-Mg; Mon, 08 Jun 2026 09:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWa3q-0004DC-Ax
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:30:38 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWa3o-0002mZ-Kc
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:30:38 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-660456349d9so4151051d50.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925435; cv=none;
 d=google.com; s=arc-20240605;
 b=Tqr03ExrKL/FyLNH5rKN7VfHRy2/2tkGyIR0H+HavZ4h8I2+DYTuDEKBs40QaF8NAw
 ge7THANxNZG46ewp6Z3L4m4QHCsQ1OsbWYsBXSkPvC52Wxb0e6CpqsqIvaue42wLbeXW
 QNxl+T2vRCL/ady/m+yHxGvXLRNlC8YM21LL0rueqxHg+V77o30Rgr3fWg29mI7yxGud
 VU84A3pfQXg9FPqzxW4iFeWw0BgYQ1CF2xzY+fhaSp0aJfX2TDNRuXhH7EtAsTS+q5PY
 AxpJTB1z2S1r6sOp+g3R+ZlbGNeePACm/+cPogyFJXCaiX9QIP5xnxlhhMNCMxqaY6o1
 AShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PsLWL74BoRjUjdW6fn0hi8lSYZTAAtYLAmP4Y8UoPqk=;
 fh=VdU0ZIHHM7Xuu0AoHAY9TnsLw+Rmx6THNQ8Qxyqt4ys=;
 b=LM/fHJXL2kkJDeid5leofiE8ePW4LMvBeHSjScTxJV8EmGjxabAzHNsiTCr96HhMzk
 IIsLrlcaw3LtbB6YyNjHudP889viy8wpOTiSXcS1rftlRD3ONl3kK4QYB5O8Fp1LKIP/
 DgM1GHsRWrXt8GhtF49vyJEVP85FnC98JzUibw6+d9s480enOGiEX2EvYKESC5yzRkfN
 +uaCLEtyOTfoVaXIVSCWFucCXLFVwWk+gTIavEkukjeU2ISUlkiq9bTHFkfr443wfKf6
 6g8Xf7mmwqOVdS5KqmWav4WBka2OiA3swhLmNNMht5tffD1drqCAgJ/dig/XCaVguPa/
 xSMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780925435; x=1781530235; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PsLWL74BoRjUjdW6fn0hi8lSYZTAAtYLAmP4Y8UoPqk=;
 b=iqq10YXkA6SWJgZijndLbVB6Dzbu8hiSmTvMezAV3wvucwL1PAuuTfNr3tJo4FjUhl
 /c/ul0twI4R+KH4Q03KoEUWGnEQfoW+SAk0JT1c7v27ar4Ft6amqiBLO5jaQSqO/SSkG
 N9gLZz8aUKdtMWgnK1jx5zuuFvAEi4996WGzjz8blFTYdqwJyOAtnzYCEflWofxnpS+w
 Rn60AJS5CBF/e2unCPZ4VCGg/LuPg0xGlthZBXuOVSVm5yzkcvzehF1kC1fM7YTptC6b
 tFoGipisbX/4zhxC1kBihL4B9CK/khgGzLRhRvMC94fRMRj7M9ZUIS6cUrDBbBHn83qQ
 jKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925435; x=1781530235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsLWL74BoRjUjdW6fn0hi8lSYZTAAtYLAmP4Y8UoPqk=;
 b=LA2MWLETdmzY2AYDwmdvvgyQ3YSQt+ViRpg+l/oYLadQ+RIQKORvtWXK06VqQ6FHTr
 uU01UzRX4WDJNg/6gdS6XIu3rotwNya7U9kdfI5F1hVVQsK4ojVmcvFrTRxEhepwc+yr
 LUGK2eSZThjmev5UQmraSEEu4DUNktsZjA9AmUAdYwBdiaO7dR6Ig66HZqnvfkTDPXSf
 FJcANqD72Mf3eFRyw91LKCpTbObRgegDpU/XxXqvaXO+IlQFEyMh3tbmkFtL8shqXneQ
 2LIk3q0825FWIoi+OlR97STQSZhQ2pG9UwfX//ah18fYp3zu+bm3OVHOyXFuEgnG5LQ3
 yfUA==
X-Gm-Message-State: AOJu0YwJSt30bMf9AGzWB7lbktqIFz3CSMcfTQ9D1oIqqaY423QjA0lZ
 hFElmST79q70Y2FUBs5xWTnPgJk0y65O52xwHFdq7oksPGeGckSHfu4EbTfraNHIq7VIE2VNSov
 mfUuMiwMqighzVdVdIRDSiUKeGIl5RJ58Y13iZutUEA==
X-Gm-Gg: Acq92OE4shsZjvX/aSTjIVE4GV8IwNz3b/Qgp6/duWVM5P3BeWvJcSZ3Lih1t9GiZ5i
 80Y4lwT51aDtE1uFfLrkBKkCrtk3KVmwpds8TklEgFBFz+3bNPjv1/Z3P6cwyMDCSzhlOqIzw1p
 Y0/5cimC8mbuAz5xLz70nAgFRDrHTYSpyfg+vFgui4hYj5tEVCLn4NPFo215VWrsx9j/8h1y306
 BozLh5HoCfYYRlyD23HVcrCam7F10eYuASB0Va9znhthmwTcYYW1Yx17jDhvsTaneD8Nhgok8dk
 6AugV+kvFCCQ2WrsfL/hLhO7OPfVbVWxuHdZUnbXdG5ZABp4bVjZPqal3YDDCapFvZQ3WXFISic
 JlQ==
X-Received: by 2002:a05:690e:120a:b0:661:37ed:6461 with SMTP id
 956f58d0204a3-66137ed65dbmr3430968d50.1.1780925435175; Mon, 08 Jun 2026
 06:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260521112806.504961-1-kraxel@redhat.com>
 <CAFEAcA8hbObntY8Tp+kOV7btb-io92O9GW99-6SPxigPJUjPrw@mail.gmail.com>
 <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
 <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
 <aia8iXGozAclWQCb@sirius.home.kraxel.org>
 <CAFEAcA9oB_-ao5C8fGYonE7njUMWLHo5-iETeN_XtnFL4PzyvA@mail.gmail.com>
 <aibALjyPTXVUDpDv@sirius.home.kraxel.org>
In-Reply-To: <aibALjyPTXVUDpDv@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 14:30:23 +0100
X-Gm-Features: AVVi8CetmNrwVukKIi-1g4-LBK3y_qq1bRAZUL-3XCNm9LKAy6WWUy7gT_Xf7FI
Message-ID: <CAFEAcA-VQWKzJ-aNnzYHZ7a+sVP1y6tkUnE3YCPydsqP0uVXvg@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 8 Jun 2026 at 14:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > When not booting via UEFI you can ignore that.
> >
> > But if I'm doing direct kernel boot then by definition I'm
> > not booting via UEFI, I'm directly booting the kernel...
>
> You can (on aarch64) do direct kernel boot both with and without
> UEFI firmware ...
>
> Without firmware qemu will load the kernel binary, then start the VM
> with the instruction pointer register pointing to the elf entry point.
>
> With firmware qemu exposes kernel + initrd (and with this patch shim
> too) via fw_cfg, and the firmware can pick it up from there and run
> it (instead of trying to boot via disk / cdrom / network).

I don't really think of the latter as being direct-boot, and
nor does our documentation:

https://www.qemu.org/docs/master/system/invocation.html#hxtool-8

# There are broadly 4 ways you can boot a system with QEMU.
#
#  - specify a firmware and let it control finding a kernel
#  - specify a firmware and pass a hint to the kernel to boot
#  - direct kernel image boot
#  - manually load files into the guest's address space
#
# The third method is useful for quickly testing kernels but as there is
# no firmware to pass configuration information to the kernel [...]

Anyway, I'll reply to your patch updating the documentation
with some suggestions for expanding it.

-- PMM

