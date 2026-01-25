Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2054DE63C9C
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 11:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjyiO-0006LJ-EY; Sun, 25 Jan 2026 06:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vjyiK-0006KD-0V; Sun, 25 Jan 2026 06:55:32 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vjyiH-0008E9-Sq; Sun, 25 Jan 2026 06:55:31 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 15343597470;
 Sun, 25 Jan 2026 12:55:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BvJcKia4KFog; Sun, 25 Jan 2026 12:55:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EE30F59746F; Sun, 25 Jan 2026 12:55:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EADE9597476;
 Sun, 25 Jan 2026 12:55:20 +0100 (CET)
Date: Sun, 25 Jan 2026 12:55:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Alex Williamson <alex@shazbot.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 0/5] Fix use-after-free and make format overflow more
 difficult
In-Reply-To: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <7e064157-1e88-dbfc-f7f6-97591222fb6c@eik.bme.hu>
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 25 Jan 2026, Akihiko Odaki wrote:
> nvme-ns has a use-after-free of a formatted string, so fix it by
> embedding a fixed-length buffer to the object. Embedding a buffer lets
> me avoid a chore to add a function to call g_free().

Isn't that where g_autofree would help?

> But I don't want to worry about a buffer overflow, so let the compiler
> check that the buffer won't overflow; C is so restrictive that it cannot
> enforce the existence of g_free(). Compilers can check the length of
> formatted string on the other hand.
>
> Then GCC started complaining about buffer overflow, so let's treat them.
> Fortunately, the potential buffer overflows it detected are not
> user-facing or very subtle. Treating them by growing buffers can improve
> robustness with practically no cost.

This is useful but maybe there's a better fix for some of these than 
arbitrarily enlarging buffers but I don't care enough about these to 
judge.

Regards,
BALATON Zoltan

> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Akihiko Odaki (5):
>      contrib/elf2dmp: Grow PDB URL buffer
>      vfio/pci: Grow buffer in vfio_pci_host_match()
>      tests: Grow buffers for double string
>      meson: Add -Wformat-overflow=2
>      hw/nvme: Fix bootindex suffix use-after-free
>
> meson.build                              |  1 +
> hw/nvme/nvme.h                           |  1 +
> contrib/elf2dmp/main.c                   | 27 ++++++++++-----------------
> hw/nvme/ns.c                             |  7 +++----
> hw/vfio/pci.c                            |  2 +-
> tests/unit/test-qobject-input-visitor.c  |  2 +-
> tests/unit/test-qobject-output-visitor.c |  2 +-
> 7 files changed, 18 insertions(+), 24 deletions(-)
> ---
> base-commit: d03c3e522eb0696dcfc9c2cf643431eaaf51ca0f
> change-id: 20260125-nvme-b4661e0a409e
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>
>

