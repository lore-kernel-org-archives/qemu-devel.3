Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D90C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhmO-0000nP-Av; Thu, 29 Feb 2024 09:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfhmL-0000ms-W4
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:52:58 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfhmJ-00049a-Pe
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:52:57 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5640fef9fa6so1422704a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 06:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709218372; x=1709823172; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0lJW7VKl+ZdmgtPDRMi4ICDB7PcSbUaZv45OAKkX+hI=;
 b=GNO8yb9WGSkNbAV916+ZH+W4e5bBEecKo3jaSzsUlU77URyEjvw4WYLiVyIgRKoymn
 mXh5A5zAKZVNlCPM7m1jSVKbjJmwLDOuSSLi8KJaphgDC43DdQxMJdqVR2+vmXnAxunu
 9r0Sm/h2Dy3YIQOY8a5tecxMk+eZ1SdmcF9M3BH7wH2E/2aa8QPan1k2jbg0nMB7MhbB
 H/EP61grw+qZAwe95plQyYewMk+ZF6dl99p4dOeqrXpYbbY1+z/EjMLRIZOVP/yFl6BO
 TjaYXyB4RCs9b0GdjZ4KgsOkNtZs0jHf/QvXmoxoZuXmW3gdWPTSkzeXRSOy6ZLtQf5z
 axYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709218372; x=1709823172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0lJW7VKl+ZdmgtPDRMi4ICDB7PcSbUaZv45OAKkX+hI=;
 b=ufgcbkqpZDzhALrjkIpIwLGO9kDJ9Bepf5t6t4WB+F3EQrKk4vjRI4ers2WXzlJ84H
 H30xI7jLtdYjrOB9Cy16YBYq1fdjs4W6DGw59aHRDNGyy+9T6xvlDTbtYHlEkzxJi9Bt
 MB3RzXD/ocYRAJBT3nmieF6OUl04EsrycMNsIIpj/Ek3TzZIf1o+TQ1E5yvBBAHGE8l9
 LPLWDOIoFw9UgLzg8TvHR7bimWKQDj36jLAAzM+nxuQh665dLj9Pi9AT2xd8Rh3AA+im
 Y26gyesIyGhbFut4BBOkmbhmdaDERrZjD6MYHJYEVW7uA48zx2SbPHXc5cI9nLX+N0uP
 2XVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpVkm23v1X2hpSdt29tinRuEJ27r1Sc8nCEhF0l6t89lP5QWEY93rzct4/AxRfcNzI3HZqxf5NkABM7TlW3+fAo6cjcTw=
X-Gm-Message-State: AOJu0YzTZ3CXLkAyLhjf7jTbC0Xd9HbAX8qQYNn9eooyeDUHir/xDc4u
 gnm7JFAqMzb7WZq4KP+Ko0pCQyfOeDmBjcTDR9Kn9nzsVgiY6OlcrsqQYzI8cMZQyGuxMaqJa2y
 EyP1DfzQ7MTdsSFB8G10T4P+56yLeFmy75NQjtA==
X-Google-Smtp-Source: AGHT+IEeKJIUWca90pVOEZNgQSZY3L1Hx50UHmNUjWtED/4Qd0Mo5oMnXkTNrpIzK1KIl7JszKd6WZrqlDU1raLhRs4=
X-Received: by 2002:a05:6402:901:b0:565:471b:c047 with SMTP id
 g1-20020a056402090100b00565471bc047mr1654957edz.0.1709218372158; Thu, 29 Feb
 2024 06:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
 <20240229105900.0000490e@Huawei.com>
 <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
 <bf3e44c8-a6ad-48b6-8825-ba8ce0dd19f8@canonical.com>
 <CAFEAcA85nwJ-qfzFVYBY0kiD7mEtr5UHRD_X_s=Vv7eaoHD_bA@mail.gmail.com>
 <4797d9ef-65f4-483e-9bb7-f79bbfa5172d@canonical.com>
In-Reply-To: <4797d9ef-65f4-483e-9bb7-f79bbfa5172d@canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 14:52:40 +0000
Message-ID: <CAFEAcA8eNNbzR=fReyjK3VavTB3WLC3JYgcY8nkRNLVrrW0JUA@mail.gmail.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mattias Nissler <mnissler@rivosinc.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 29 Feb 2024 at 14:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 29.02.24 13:34, Peter Maydell wrote:
> > On Thu, 29 Feb 2024 at 11:17, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>> But yes, I'm not surprised that CXL runs into this. Heinrich,
> >>> are you doing CXL testing, or is this some other workload?
> >>
> >> I am running the UEFI Self-Certification Tests (SCT) on EDK 2 using:
> >>
> >> qemu-system-riscv64 \
> >>         -M virt,acpi=off -accel tcg -m 4096 \
> >>         -serial mon:stdio \
> >>         -device virtio-gpu-pci \
> >>         -device qemu-xhci \
> >>         -device usb-kbd \
> >>         -drive
> >> if=pflash,format=raw,unit=0,file=RISCV_VIRT_CODE.fd,readonly=on \
> >>         -drive if=pflash,format=raw,unit=1,file=RISCV_VIRT_VARS.fd \
> >>         -drive file=sct.img,format=raw,if=virtio \
> >>         -device virtio-net-device,netdev=net0 \
> >>         -netdev user,id=net0
> >>
> >> This does not invoke any CXL related stuff.
> >
> > Hmm, that doesn't seem like it ought to be running into this.
> > What underlying memory region is the guest trying to do
> > the virtio queue access to?

> The error occurs while the SCT is executing function
> BBTestReadBlocksConformanceAutoTest
> (https://github.com/tianocore/edk2-test/blob/cabb98d44be94e7547605435a0be7c4946d10f8b/uefi-sct/SctPkg/TestCase/UEFI/EFI/Protocol/BlockIo/BlackBoxTest/BlockIoBBTestConformance.c#L45)
>
> This code is accessing the drive defined as
> -drive file=sct.img,format=raw,if=virtio .
>
> In the conformance test correct error handling for invalid parameters of
> the UEFI block IO protocol is tested. This includes calling the UEFI API to
>
> * read with incorrectly aligned buffers
> * read with invalid LBA parameter
> * read with buffer size not being a multiple of the sector size
>
> In all these cases the UEFI API implemented by EDK II is expected to
> return an error.

OK, but where is it actually reading/writing to ? Even if the
buffer isn't aligned right it ought not to be in a non-host-ram-backed
memory region, I would have thought.

-- PMM

