Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AC8ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfQR-0002cc-L6; Mon, 09 Sep 2024 10:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snfQP-0002Tb-GN
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:31:29 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snfQL-00054p-HD
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:31:29 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c3d209da98so581796a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725892283; x=1726497083; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eURALgwt9YIOnBT2yR7CpbgUSM0szptNznFU1MjYI1M=;
 b=xTMKf+neDlFTYUaRElMIKaWxKU+HQAzsS3/GECuxxkhOcOjcJbAq+l/cJWcLC2wXFB
 ZTaUdAKXGja0rdjoWQrunUaA38G2wyLsqjQ1JsTPKNK3p1rL0wqegJwXJKubxWRN0SC2
 jU2oLxHlPfzvnqQIVJJoFBYjeBASVYgZMOz3dh8q3ZS0KzxLzXtwDWqnBEo2Vrtt2jwM
 hyxY0ZzJsSuggolLYituKi5nf+OWWnsr3gg/Ue2srDiDRkpeXL5tTR20EXZDg/0n9GF3
 NxwjWm8mLdSSOfdKq5oHmxGEuVEUF7ogeCDlkUycoQGjJArG6hBKoyBITiDbHtYriBfi
 6ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725892283; x=1726497083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eURALgwt9YIOnBT2yR7CpbgUSM0szptNznFU1MjYI1M=;
 b=nrjRlg6LRJ76iOXRsZH+oH373GtnQ4hxMctnVU5+acjEmNSxRrPEjek9Pm+lepo3vl
 wJQBVx273bSz8wXaTwAEJyz+UpYcDERK9GuFb+O1tuCyqiVtMErgKRZDQx3b/hFuXCLy
 n7am2XeASMtnUJSjHrYRkSealjgP6dpNq/mvFVSFuBjArgfY4fu7rnYVpHpGpc2FbaDc
 kyYF8TAUclu9yljfK6W8afl8x7E6M7tI8/Rduk6tsOZdNjpcxGlhboHESgL50ATwVL5b
 nEBPZw1F4VppFtaOh1hhRHFKVpn0fQ4Hb8n4ZBCsvDNo9luVBFTlyrY7vROrBFTGtVIN
 pcrA==
X-Gm-Message-State: AOJu0YwJOpZYz6yK8amSky0YqlLvhwUIOPrEdsXxXmffZUh6d5si3V6a
 ZsZ1OJZj2ikbAJh0ucihqJ+GzNnYy19Iv3spDrdNTNLolksj5o3ZqWyUrKTJUGMzoxy8sx/6xLe
 5Ilh9ArAJL06YO0XVbTXiifHYn8GtCZXVvosDg1VunMKb8lV2
X-Google-Smtp-Source: AGHT+IGTlwTfEv8OA4fAjW3Jlf8WNNr8s7wV3UG/pULEaRo/b9aPLW0uPXW24ozz4QynZ//p1+Q0qErF6UNv39TKnlg=
X-Received: by 2002:a05:6402:51d4:b0:5be:d595:5413 with SMTP id
 4fb4d7f45d1cf-5c3db967a6dmr12880706a12.3.1725892283322; Mon, 09 Sep 2024
 07:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <447984db-8c52-c911-d7bd-6616edaaefa5@hisilicon.com>
In-Reply-To: <447984db-8c52-c911-d7bd-6616edaaefa5@hisilicon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 15:31:11 +0100
Message-ID: <CAFEAcA-qBKn=42SYwU1X_7QrwWZYA1G1Hbf-iUP4GOFu0LwLzw@mail.gmail.com>
Subject: Re: [Bug Report] smmuv3 event 0x10 report when running virtio-blk-pci
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 9 Sept 2024 at 15:22, Zhou Wang via <qemu-devel@nongnu.org> wrote:
>
> Hi All,
>
> When I tested mainline qemu(commit 7b87a25f49), it reports smmuv3 event 0x10
> during kernel booting up.

Does it still do this if you either:
 (1) use the v9.1.0 release (commit fd1952d814da)
 (2) use "-machine virt-9.1" instead of "-machine virt"

?

My suspicion is that this will have started happening now that
we expose an SMMU with two-stage translation support to the guest
in the "virt" machine type (which we do not if you either
use virt-9.1 or in the v9.1.0 release).

I've cc'd Eric (smmuv3 maintainer) and Mostafa (author of
the two-stage support).

> qemu command which I use is as below:
>
> qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-version=3,iommu=smmuv3 \
> -kernel Image -initrd minifs.cpio.gz \
> -enable-kvm -net none -nographic -m 3G -smp 6 -cpu host \
> -append 'rdinit=init console=ttyAMA0 ealycon=pl0ll,0x90000000 maxcpus=3' \
> -device pcie-root-port,port=0x8,chassis=0,id=pci.0,bus=pcie.0,multifunction=on,addr=0x2 \
> -device pcie-root-port,port=0x9,chassis=1,id=pci.1,bus=pcie.0,addr=0x2.0x1 \
> -device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=8,packed=on,bus=pci.1 \
> -drive file=/home/boot.img,if=none,id=drive0,format=raw
>
> smmuv3 event 0x10 log:
> [...]
> [    1.962656] virtio-pci 0000:02:00.0: Adding to iommu group 0
> [    1.963150] virtio-pci 0000:02:00.0: enabling device (0000 -> 0002)
> [    1.964707] virtio_blk virtio0: 6/0/0 default/read/poll queues
> [    1.965759] virtio_blk virtio0: [vda] 2097152 512-byte logical blocks (1.07 GB/1.00 GiB)
> [    1.966934] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
> [    1.967442] input: gpio-keys as /devices/platform/gpio-keys/input/input0
> [    1.967478] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
> [    1.968381] clk: Disabling unused clocks
> [    1.968677] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
> [    1.968990] PM: genpd: Disabling unused power domains
> [    1.969424] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> [    1.969814] ALSA device list:
> [    1.970240] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> [    1.970471]   No soundcards found.
> [    1.970902] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
> [    1.971600] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
> [    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
> [    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> [    1.971602] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> [    1.971606] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
> [    1.971607] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
> [    1.974202] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
> [    1.974634] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> [    1.975005] Freeing unused kernel memory: 10112K
> [    1.975062] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
> [    1.975442] Run init as init process
>
> Another information is that if "maxcpus=3" is removed from the kernel command line,
> it will be OK.
>
> I am not sure if there is a bug about vsmmu. It will be very appreciated if anyone
> know this issue or can take a look at it.

thanks
-- PMM

