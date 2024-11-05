Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17107D3176B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 17:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NGb-0002eB-OI; Tue, 05 Nov 2024 12:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8NGZ-0002dt-MF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:22:55 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8NGY-0008Ht-1c
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:22:55 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539e6c754bdso5780898e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730827372; x=1731432172; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b77jNcoN5Lqa6JoDxxgFu+lPjcOAGWcdE2d6nlYtWhQ=;
 b=uOANJ+hwpZAuCF7XZtngKSz4aXcsnResq/1TyfuNqKAWWTRduy5hQj4VrAw9TZ1Spo
 CWzdJh/ryZ19vb2vgPH13vBbBfSxpl2YlYll9B61YWvoyasWtK0qSR8LhoAGbE2LZh3h
 psQdlPufEbYP4rMfjF3hYaX5OGN7jPDQMfTTvo6vLX/0pNr2/qkT6q8OIsgnI2OyScuA
 n9pNFjfgvMQ2OqJxgIxBgnlS81A5XgRBRsoIThmOOVLEUZ57v3XN0Lu2QD8eHwTjBv3F
 IeHOIu7qdC/MJC875NmIQpfkMmHh8Elru9o6ePmnaEtvwb5zTZhEQc3U5SzP0hbUo+3p
 nIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730827372; x=1731432172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b77jNcoN5Lqa6JoDxxgFu+lPjcOAGWcdE2d6nlYtWhQ=;
 b=HhP5yeVCvJudZ29MC70bt3xKl3iapR7onZccVERFhy73K55QdmCXvafEhjYJJGsTpK
 mZREA0pkPio32Db6ftO+pzNsO4kuG6BDgIyOSH+h2TDqvb5PivZCPEDJ4UynEy2XpqsD
 MZpW5LUTeSkp3rq52LtnLQNEft5ZkfsBUWOFQpc6QLj0c/ZcoFnp56cFso9osqBkKMa+
 uwlxzYBvEbzRxHaZr9oAzEacXmAwgRIaFFqRp0TIEaWXdQmdCEPxqoJVObKCBeD4341t
 6UEXoKb6MIkcl+dR5nNN0G9NXsUxX5+IJSVVtqEfGbGOHnL3LpoC0rIjMi0gQn2wZb1I
 W6uQ==
X-Gm-Message-State: AOJu0Ywi2uJftiWjrX4m3RNx+2fNHX3aGcU+i3Ow5rf+eT50qO6iqegJ
 LeMH8K483Y33VVIGB4rBc8wvIQndwpH20re+Nt6PlmT0sQWzWAeMdBVkD2UQA0q6lTa/KUNw+sm
 yylT2w2A8KpenjOwN9gMZl9vw4swiq9ed1fUH7kl7ctZWtqhk
X-Google-Smtp-Source: AGHT+IEnMJLuZdGAUaoCrgxE/vEfnLDqizjkR9Ki8/xPrYmeYhBcKasR60Orr7XzewQ70GHr2RtrVgkW7BfDZ/ndVY0=
X-Received: by 2002:a05:6512:ac3:b0:536:56d8:24b4 with SMTP id
 2adb3069b0e04-53c79e15746mr9628524e87.5.1730827371746; Tue, 05 Nov 2024
 09:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20241105171813.3031969-1-peter.maydell@linaro.org>
In-Reply-To: <20241105171813.3031969-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 17:22:40 +0000
Message-ID: <CAFEAcA_H3oGCs1FgyZ-tjZp7+4AW4qvi=7smK9vJgQ4Vjm7k-g@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc: Don't try to init PCI NICs if there is no PCI
 bus
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Tue, 5 Nov 2024 at 17:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The 'isapc' machine type has no PCI bus, but pc_nic_init() still
> calls pci_init_nic_devices() passing it a NULL bus pointer.  This
> causes the clang sanitizer to complain:
>
> $ ./build/clang/qemu-system-i386 -M isapc
> ../../hw/pci/pci.c:1866:39: runtime error: member access within null pointer of type 'PCIBus' (aka 'struct PCIBus')
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/pci/pci.c:1866:39 in
>
> This is because pci_init_nic_devices() does
>  &bus->qbus
> which is undefined behaviour on a NULL pointer even though we're not
> actually dereferencing the pointer. (We don't actually crash as
> a result, so if you aren't running a sanitizer build then there
> are no user-visible effects.)
>
> Make pc_nic_init() avoid trying to initialize PCI NICs on a non-PCI
> system.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 8d39f9ba14d64 ("hw/i386/pc: use qemu_get_nic_info() and pci_init_nic_devices()")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This shows up if you run "make check" on a ubsan build.

Incidentally, if pci_init_nic_devices() had done the
more standard way to do "get a BusState* from a PCIBus*",
i.e. use the QOM cast macro "BUS(bus)", that would also
have avoided the UB (because QOM cast macros on NULL
are valid and return NULL). But I figured not passing NULL
in the first place was probably the intention rather
than quietly handling NULL.

thanks
-- PMM

