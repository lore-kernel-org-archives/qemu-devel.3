Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39D9CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNGu-00080O-Fy; Mon, 11 May 2026 05:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMNDf-0006lF-HE
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:47:13 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMNDb-0002p3-W0
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:46:35 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-2ecf9e398f4so11021288eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778492768; cv=none;
 d=google.com; s=arc-20240605;
 b=TISnBxlGwLitggCHgV9jVgh+U8fqiBAStkrzk5ph3biG4KE8/5EW3iP52zHbmjPGzU
 fsUX46JAi0BMFxKUaR2C4gM4pu5YoVI8G3nFwMlAgl/YGO8mJ/0k5PE5bLIAuplOFBkb
 SI6Jhx81IAboQv2KyzJN8OlE/+aOPwz5mr4U82FnRdqktrb7t34R3a0TRUFMuoNKXR67
 rKT2RwRBQj9K8QOhg0pwzZRPQyz8Z1ZR+GCb5oVcgyg+v9CVtIi/ANuNAUA3Go0lOz67
 0cYDAKdChIZNdstTT22W0mDsOqVN3p82Gqgbkru46vPK3Yem4j7uYytECBO2rKEPUe/H
 7zGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7m2jz84B9ksxD8ZH9ghgs3kEtAtNrw6tbDwuxw0Q0T8=;
 fh=iOPeBV+aT+ySosZM5kjW3IjuwJ3i3sJrRgGCZ5/70bk=;
 b=jh2QhKFsEWMdSGU5diBhgzzWg0UbEkY/EIuVWX1O+p2/xyrh97qs0P2NyspAI20Km3
 mv1ohPziNwFEh0pPzO/1/62ZSf9zBar3lw6Yt63KUpz/G7gT7cD9s+tx8J32tWMQV0tx
 ILdtuVBGrM7bhZbTlXe65bLCjVQLjH7BxtJhdRvatrcIg1QAH0UCGN/fuDN69TJAAbtc
 LDzfPxoWiFUfx9mdzgMBC7wM2VtxZU6Gd+f21lPnVUDy0kP2qWj0YHLFYgZY7kIEmkgK
 bUTke2yQcgB1iw0U9enmAegy3jpGIGwDcV75sFVL4AW+J8v0cASWhZEp6CaJbd7LPq3n
 a0rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778492768; x=1779097568; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7m2jz84B9ksxD8ZH9ghgs3kEtAtNrw6tbDwuxw0Q0T8=;
 b=K1SYbmQs3kMt7LX2gHihQeOi0WYH9XuhjDvLmJS7NhG4Wd8k6FsfPP1iAX4iLWObh7
 f5BYUFRodCLbBhT9fOtpB+Nsd4ZwwU5V0Ift+WJa964GzWdHmt6dZ8+lDRmn/M/0F9iT
 rshRr5Pl/ixkrnV6u9yy4A3RH6bzUnUoZQpePlpFNMptHv6ARZo2Ie7gv4sBgXAmjlAY
 umMt7r5hmqSamlNF6NLTmxLH+6iKLo3ORUpiGDRXuFNsERachuMoYE4bUiLUHsIEDRm3
 0GSMviMH/TcgqSE8SIsGoVwQxnjYJ6U74lAk0L8SgEai7MvsljpRNHy40m+e6FC4fW2f
 edsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778492768; x=1779097568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7m2jz84B9ksxD8ZH9ghgs3kEtAtNrw6tbDwuxw0Q0T8=;
 b=O8F3q/K7skAL3PP1SDaG3xt83YlBrs2+XCy0RcesEGTlejY9jdLtpl8LaDsoHJlCaE
 f9Q6hVw+DJvd2i2A6mNgh/CzkPt9EN7vPIRG/HsQlnagIv342EN6vlpJusAZ8g7Jw8WQ
 Bbu6mxlf9ZDs2tfFGlZFpoTNmB+V3qTgLMibwuyYBW/x+4lyQeO4Y0Y8Nfpct6SMa58O
 UsDRqyFwmiIsPyn1g3dJB87W3Oz2peoxa4V8LdXOsISeWqvrCGKA7HuJRRwrRVu5ARYI
 8k1UHhsjNhvBqGS5ehL9hVi+ITB0IbYR8NVE40dKduIhVoCVLE0kqofeqoyTQ6g4ySf/
 fD/g==
X-Gm-Message-State: AOJu0YxGL6TTz9i6AtlDrlLGcpeUJloCvQUhR4CdOLqeQ/fZ+sSB2zxJ
 +3qUP+6XYmNKuJ68LRPirPIQM5VjSkOUSBEGYfw7efrzIkOgzA6qE83Pjtsj9yqsd/LrjRUR+CD
 4CaVrMlhaIda6j8/WxkxECC47UZWbMrLY17i3aNjT/VydZKZJKyYI
X-Gm-Gg: Acq92OHOOGYuu+emH5sBj+5cDE2OjWhHN65N9q2sOw1i49iWkOLlJGg3VOXZK+q07/X
 +ymww3/8Uo3bx59ESYTWfAdxfZFPkclYXhWPoB8s7Z8ABOHKLVU8avQa8/cwyAarx+rnG81Cpgx
 QIvJATPNh/MV/ZPyqWkHyT4wMlsxSzY9/exVdFWZEdYoW5FN/lqej3ZraJUhrydLfAL57i2MpP8
 YAljE/p/iUtMXc9W3+Ea2zsD7ewuzi5qkwGbRWi8EoOKF8Xb8HaPvYot/KsJqCck1aZ4Hp73pEh
 a4QWST479ZXh5IqSyTUXWlA/jX08DFv7aY4cuFNHmTMdVlAWRSJS1AFpemcdB7PrJGU=
X-Received: by 2002:a05:690e:168c:b0:651:b938:188b with SMTP id
 956f58d0204a3-65c79c46c58mr22996973d50.24.1778485629370; Mon, 11 May 2026
 00:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260508183717.193630-1-tdave@nvidia.com>
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 08:46:57 +0100
X-Gm-Features: AVHnY4KJvyGgwSg3VDb4jYfnlrdFQ4HsXNAOChkVA_oRqH9XIYfUWmwNkWZrZBA
Message-ID: <CAFEAcA9KxUF6c555Q_Kqn_NVE3z1ojr91+KuatYudj_T4GjbxA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI pre-enumeration and
 fixed BAR allocation
To: Tushar Dave <tdave@nvidia.com>
Cc: qemu-devel@nongnu.org, alwilliamson@nvidia.com, jgg@nvidia.com, 
 skolothumtho@nvidia.com, qemu-arm@nongnu.org, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=peter.maydell@linaro.org; helo=mail-dy1-x132a.google.com
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

On Fri, 8 May 2026 at 19:37, Tushar Dave <tdave@nvidia.com> wrote:
>
> This RFC introduces a mechanism to specify Guest Physical Addresses
> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
> addresses to match host physical addresses for assigned devices.
>
> On some platforms, P2P DMA is performed between devices within the same
> IOMMU group. The PCI fabric ACS is configured to permit direct P2P
> without going through the host bridge in order to achieve the required
> performance.
>
> To support this multi-device IOMMU group P2P scenario in virtualization,
> the VM may need to use the same MMIO BAR addresses as the host physical
> address layout.

This feels like something's wrong in the design. A VM doesn't
necessarily have the same memory layout as the host: the
VM hardware is all about making that possible.

> Why QEMU programs PCI resources rather than EDK2:
>
> To support fixed BAR placement, QEMU performs PCI bus enumeration and
> resource assignment prior to firmware execution. EDK2 already provides
> a PCD-controlled mechanism (PcdPciDisableBusEnumeration) that allows
> the platform to skip PCI enumeration and resource allocation. This
> series leverages that mechanism so that, when enabled, firmware runs in
> a discovery-only mode and preserves the configuration established by
> QEMU.

I'm definitely not enthusiastic about having QEMU do PCI bus
enumeration. This isn't the way the hardware does it, and it's a
lot of code that's duplicating what the guest already has (there's
over a thousand lines of code in this patchset).

> We use the virt machine in this series as the concrete example
> consuming the fixed-BAR model. Other machines may require their own
> machine-specific mechanism (such as pcie-mmio-window) if they want to
> adopt the same approach.
>
> Example usage:
>
>   -machine virt,...,pcie-mmio-window=0x400000000000:0x400000000000,pci-pre-enum=on \
>   -device vfio-pci,host=0009:06:00.0,id=dev0 \
>   -set device.dev0.fixed-bars=bar2@0x6b8000000000,bar4@0x6c8000000000

...and you end up with enormous command lines like this full of
magic numbers relating to address space layout.

I think it would be better to find a way of doing this that
doesn't have the "VM address space layout has to match the
host layout" restriction.

-- PMM

