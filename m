Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17540C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2PKj-0000wC-FU; Fri, 04 Sep 2026 04:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2PKg-0000vY-RL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:31:34 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2PKe-0004PB-Uh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:31:34 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-861f30636f9so10049087b3.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788510691; cv=none;
 d=google.com; s=arc-20260327;
 b=FlHKxq5L3k45vt7wN207RVfkqx8gyNz3Nii5lltqdX2/8jJhxEWBuSbBtP7bFP8GPm
 DKCAG50rD1vKjll3KfOry2ekVovw65BNJq6J0V1qkKmhWEXFIpoaU9HCNxUm6iuoS5PG
 zV1zfAPQ0AmyySl0mszSHkWf3hrghtC09lNQfEOGMZMTAp8atUtqkjlL0CV3Ft2RPoXA
 j6c0LGWMn5sCypf9500D/EVN4F5yNWptK+JY+tBPMyjWVlSqq9hK+FXcm1tBEBdBwLaF
 NQKK6zbiPaQDvoFg2iZR30AsTSrPgp1W76dfVMVAJP5tdWmFJhYd3KzwDI0hr5EaUFUj
 cAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fAbXHDqEuERG933sDQ4k5pM2Sa3mafMb/2uaWrd1rWQ=;
 fh=DhldD8VP9wlhRh0PlOZDeDuHvFo37InCKF722IBu3zg=;
 b=oz9T+Ylsre82XpsJd6UwX0ji6f5PB90lojER6eEjUWrdm00aofguTe7KpYgLP1Uu0a
 PqGV7kmn8RFem1KhgvXUONzth8jZTrpfEqrq1xK6GUDan1JlWZOemKL+F2XmWxcN58AN
 7kpDT8DZ6GbhqqjqrdriLhhd4lvu1yz50Ytqtt8BrpkB0PFuebPjstwYU8qYTUnFg2p1
 Tpw8yEklHxlvKT/MeeMYa6H+XCZHyVEIVfpaKvtUnpxYM2ysNHxKcITNSyoNoZqG9qiq
 jixPiI54yd49yHD8AzT9C1bU05SuC9CbdZojWa3CEhXdQLep3mJVNzCg6rJ70fbTkg1o
 WYIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788510691; x=1789115491; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fAbXHDqEuERG933sDQ4k5pM2Sa3mafMb/2uaWrd1rWQ=;
 b=DY+pE07htUZlZXWuW+hf6j6XVWe+GMbKS4l7bmlKlnxsLUwyRivf3V2zbWGJ6EzcMY
 LUDZ4HhuyYy5e6oR8C+NzxFd1P5NDMKSFuCyjyvmaW7qmrv9GVNrMjB7VFpDjO3+qUOo
 7HaVgkuLwRs1E2ztQW6a/35BwFYrbdaEmo5bwQXKJaGYpzYsWXqKfrIxBttSR2KxQFTp
 SpUE9ZaXchFFjbfqZrIFi1/YvdZ82oa2mMyXUMVLvoYgIJaw1VRwPzHj4PPrv4KYRxBG
 sMalLK0ntTqxhHMVy2ilgK19j6jOw6gGkOc5vkMn22BACxNJ7LTexnD3Y7ZXW5LWJqX/
 myOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788510691; x=1789115491;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fAbXHDqEuERG933sDQ4k5pM2Sa3mafMb/2uaWrd1rWQ=;
 b=m7fM/AX4VLWXRRQbbfFkKSh4S9YQoeNSTRVqXNhOXGt4H9qTUP4xDw1xpaoC+ED6D3
 Ooir9Vpz54Twwz7PVv7Qji3uiVlMEcqM+5efa3bnZXAqYq/4DIgXtlOAh8cex+nLZ1mP
 7l9CZ3YR6kWNesSNOyRXiusz9t/LEmpDLy1mNzUrpCtc7lSrjJQcnEfmQi7AZUCkPQ0f
 zBpSt8GOXTB/njrvK4S6CpAoeh0EGpVsxeBp6Sg624lS8o1w/7/J5ENHHCsdyWRkQMAM
 ighfiO8TcKoHVMy91Tlp2opuB/MIGlclPz8ud/VD3g5z1vyeiexW4dHVyZq7Dwifjv6z
 exxQ==
X-Gm-Message-State: AFuF++mGojErz+355XkO4mYAMSB6CWKK0NyZg8v6syCpuaRL2Zdsm77M
 xWVc2AGs4UpbVHdMiF2HOB7QHsHtRPSWRkj1kpcvnlNDH5IIwOg9TR7zd/FX/0eO0YR1y8YY+Jm
 p4lC50byVrOsgd5Fl15Nusrr28YLNS+alcAWk6iswxg==
X-Gm-Gg: AYBFou1R75f5yS58ToUFdV0UELXJjEDYFD+o+H5BpmPnNZG+t2jXYGD65AyW6pJV0QT
 MkFFWl42ohxjibCeFyhKvbUKint5SR7PkPoiH9tSMI1gh+vLB9h3NtgDlFdbiiM9dcFFnVVOn3a
 k2rzrywiFaZX5Ym8PzZNrzOop+4bLigI8domnQeD3L0ma3l3tLdFXmbczOnCr1yMoiDNZrVsX1O
 AXEJWJEfbjf3i5e2fIad0Qmb7PGB0gke29KqXScmUD0J9m6S/hM8TlT29JeIpXHpXwz8H+bUbiG
 lxTjRvusrx6ZFfmJRCzQmIlW99i10Gj68P3SiRlKL/i78VdUxvA4wb4X6sC/fAcvbu48nu6Onye
 KoEz3HEipuiZBGOeFFcafQaxagE4S
X-Received: by 2002:a05:690c:3385:b0:861:5bb9:c171 with SMTP id
 00721157ae682-871266c4d5emr28435007b3.16.1788510691150; Fri, 04 Sep 2026
 01:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260903220523.2849019-1-farosas@suse.de>
 <20260903220523.2849019-2-farosas@suse.de>
In-Reply-To: <20260903220523.2849019-2-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 09:31:18 +0100
X-Gm-Features: AcwNN1XzulNTTsaDY-hxG_4C2j_J2JytTF3HScqAf2AqpF6ZYXrHbqSiG-o9D-4
Message-ID: <CAFEAcA8j8MYW-YtKJ1trVk2NureE0iUk+E17kX5-jW10x8HyGQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ahci: Fix leak of IRQState
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 3 Sept 2026 at 23:06, Fabiano Rosas <farosas@suse.de> wrote:
>
> ASAN spotted an indirect leak in ahci-test:
>
> Indirect leak of 576 byte(s) in 6 object(s) allocated from:
>     #0 0x556112a08ca0 in malloc
>     #1 0x7f21591e595d in g_malloc
>     #2 0x7f21591ffe38 in g_slice_alloc
>     #3 0x7f21591c988d in g_hash_table_new_full
>     #4 0x556114d756f1 in object_initialize_with_type ../qom/object.c:506:23
>     #5 0x556114d77590 in object_new_with_type ../qom/object.c:706:5
>     #6 0x556114d777e8 in object_new ../qom/object.c:722:12
>     #7 0x556114d6d2be in qemu_allocate_irq ../hw/core/irq.c:94:25
>     #8 0x556114d6d1bc in qemu_extend_irqs ../hw/core/irq.c:82:16
>     #9 0x556114d6d329 in qemu_allocate_irqs ../hw/core/irq.c:89:12
>     #10 0x5561135da9bd in ahci_realize ../hw/ide/ahci.c:1644:12
>     #11 0x55611360156a in pci_ich9_ahci_realize ../hw/ide/ich.c:132:5
>
> Although ahci_realize() frees the return of qemu_allocate_irqs() right
> away, the individual IRQStates are still left around.
>
> Issue qemu_free_irq() at ahci_uninit().
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Classic leak resulting from qemu_allocate_irqs(). Ideally I
would like to be able to remove that function exactly because
it does tend to result in leaks, but we still have some users
nobody's cared enough to try to rework yet.

Another way to fix this would be to embed the IRQState into
the AHCIDevice struct, and then use qemu_init_irq_child(),
similarly to how b38859be76abf removed the qemu_allocate_irqs()
use from hw/isa/piix.c.

But I have no objection to this "just fix the leak by calling
the free function" patch.

thanks
-- PMM

