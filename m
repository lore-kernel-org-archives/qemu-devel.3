Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB609C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1LM-0004mE-6c; Tue, 12 Mar 2024 08:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rk1LJ-0004ef-K3
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:34:53 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rk1LI-0006bV-1h
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:34:53 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d28051376eso55577811fa.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710246889; x=1710851689; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dz6mkZfvIg+cU6S14MGqd9CBaPH+Vm2xfOlfw5fIN7Q=;
 b=m6lEdR+il+/OehEjYTbR+hyehYpBp+VB22LT65SjtXrpHoYmo9gJBQ4MuCBNbpNvHa
 u0hk6iU1Ot2DRFyUrkB4Cv2y1X8VujnOLGNREPki1pOey9ZvatVGZ5linC6Eik98O16f
 VgJ35xXn6Gf511Z9v9C9+ldukb07AVd9bEI98jcii410iQySA04YtwHL8fJMgXKZwUPm
 wQqsYhzMID0ofNJ+jYoFicJpO1AETKYxYsswYLJ8qd6ntIALbfruvpubs61AZvgj9ixx
 idwvUYY3BKZAHN+Pm0l6ikoNISxZxL9ExsHEDsrRw10Uzkg+ca/288jIMYlX/nOO/y0G
 1W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710246889; x=1710851689;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dz6mkZfvIg+cU6S14MGqd9CBaPH+Vm2xfOlfw5fIN7Q=;
 b=a5SPfoaB01KxUh036lUQyJCb2aVhcPdj2NpEoVXs/KZaXbUe+WYWXVVbstmV8Ik8/U
 I/FWOMphoibelsnaD3o7sv6vE9K9YFB1SK9mrokp1fAHAkW8Dq9aW2FYlIGOupuhjxWF
 cZNAk9A7K1Pk8qJA9ytWCsjD5iakFuz2rvfNyO4kQ9i9Hf4yAbXtaQunh9fAUhRTEFec
 Cw7j6VqFj5og4l9EGqDKxQFj+lJiZc7c/h8kPGvpcWR4x4Kq7PG+BlWfBaVfr10vI5JK
 h7V5FTL2yLMgUf9HaJGiHCySiESeVR+XoJSZ8C+om3+gLrylE3Q5oigTUKM3TzU/ZmFY
 l10A==
X-Gm-Message-State: AOJu0YwRxtZZbwEXWcSbOmhtiCb90HsXSMjrZjD3eA4YMweogluQDnb2
 DcF1ZcZ9kHdXN0361p3zP0e0N8+KqK3LPl1DeCJj5/ItUSpeShZaHMe4rABYFiVVnQ==
X-Google-Smtp-Source: AGHT+IG9S0CR/tAMPdb4sNT5OfeXcb5PoSR1TkoY2IHcdeD1cewO3wtPEFXun9/qjRjxXzMGNGnfBw==
X-Received: by 2002:ac2:4c9c:0:b0:513:7ef5:1059 with SMTP id
 d28-20020ac24c9c000000b005137ef51059mr6510315lfl.18.1710246889175; 
 Tue, 12 Mar 2024 05:34:49 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 be37-20020a056512252500b00513b15ac2a2sm638575lfb.94.2024.03.12.05.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 05:34:48 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:34:48 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org
Subject: Running x86 hypervisors inside QEMU x86 TCG outer guest?
Message-ID: <ZfBL6KEfgIXANulr@toto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi!

I'm trying to figure out if QEMU supports running x86 hypervisors (KVM and Xen) inside emulated (TCG) x86_64 guests.
I.e, using TCG emulated x86 hardware virtualization (Intel VMX/EPT or AMD SVM/NPT).

So far, I've been able to run nested x86 KVM when the host is on KVM but no luck with TCG.
With intel TCG cores kvm-ok in the guest says there's no KVM support.
With AMD TCG cores, kvm-ok looks fine but as soon as I try to run a guest, it doesn't run anything.

Am I doing something wrong or is this expected?

Some of the command-lines I've tried:
This is the command-line I use for AMD like outer TCG guest:
${QEMU} -M q35,accel=tcg -m 6G \
        -cpu "EPYC-Rome-v2" \
        -smp 1 \
        -display none \
        -serial mon:stdio \
        -kernel ubuntu-23.10-server-cloudimg-amd64-vmlinuz-generic \
        -append "root=/dev/sda1 console=ttyS0 intel_iommu=on" \
        -initrd ubuntu-23.10-server-cloudimg-amd64-initrd-generic \
        -device intel-iommu,intremap=on,device-iotlb=on \
        -device virtio-net-pci,netdev=net0,romfile="" \
        -netdev type=user,id=net0,hostfwd=tcp::2228-:22 \
        -drive file=ubuntu-23.10-server-cloudimg-amd64.img \
        -drive file=cloudimg-user-data.img,format=raw,snapshot=yes \
        -drive file=hd.qcow2 \
        $*

This is the one for Intel TCG guests:
${QEMU} -M q35,accel=tcg -m 6G \
        -cpu "Haswell,vmx=on" \
        -smp 1 \
        -display none \
        -serial mon:stdio \
        -kernel ubuntu-23.10-server-cloudimg-amd64-vmlinuz-generic \
        -append "root=/dev/sda1 console=ttyS0 intel_iommu=on" \
        -initrd ubuntu-23.10-server-cloudimg-amd64-initrd-generic \
        -device intel-iommu,intremap=on,device-iotlb=on \
        -device virtio-net-pci,netdev=net0,romfile="" \
        -netdev type=user,id=net0,hostfwd=tcp::2228-:22 \
        -drive file=ubuntu-23.10-server-cloudimg-amd64.img \
        -drive file=cloudimg-user-data.img,format=raw,snapshot=yes \
        -drive file=hd.qcow2 \
        $*

This is the one that works (nested KVM):
${QEMU} -M q35,accel=kvm,kernel-irqchip=split -m 6G \
        -cpu host \
        -smp 1 \
        -display none \
        -serial mon:stdio \
        -kernel ubuntu-23.10-server-cloudimg-amd64-vmlinuz-generic \
        -append "root=/dev/sda1 console=ttyS0 intel_iommu=on" \
        -initrd ubuntu-23.10-server-cloudimg-amd64-initrd-generic \
        -device intel-iommu,intremap=on,device-iotlb=on \
        -device virtio-net-pci,netdev=net0,romfile="" \
        -netdev type=user,id=net0,hostfwd=tcp::2228-:22 \
        -drive file=ubuntu-23.10-server-cloudimg-amd64.img \
        -drive file=cloudimg-user-data.img,format=raw,snapshot=yes \
        -drive file=hd.qcow2 \
        $*

Best regards,
Edgar

