Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E2606A338
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=taktcycles.com header.i=@taktcycles.com header.a=rsa-sha256 header.s=takt1 header.b=AVDksJ5G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwIi-0007Ts-IZ; Fri, 13 Nov 2026 13:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRwIe-0007IX-3S
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:47:00 -0500
Received: from mail.taktcycles.com ([136.243.71.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRwIb-00062U-Pg
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:46:59 -0500
Received: from mail.taktcycles.com (unknown [192.168.64.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
 (No client certificate requested)
 by relay.taktcycles.com (Postfix) with ESMTPSA id 3A2F68A69;
 Fri, 13 Nov 2026 18:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taktcycles.com;
 s=takt1; t=1794595615;
 bh=nGIhS5C+GQn65CWZDda8//vSnwQfyQkbiXpdIl1JvwQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AVDksJ5GJAAoM7op0iSIrLq3UOml7DaPzfS6fecu4MaI76xXqEVdrwl+luNe5dUP4
 qToBe0b42JOV1UiO8XDBlxwhuHJo+SEEP9JvqD/AmwSlOmqVDYFR36sRcBtmRBHNba
 mfNOaGxR2Zco2pMl9PM5mlptF5gYo7qNM5KSZV13efrG+A0AKk44QKjd2Nfgh1obnX
 IVIGOgiFsiprfuuBYjCS05GG/UtTwLFYMY8vkLpzhqB+dof7sX4wdVC6Ts5CwQPueC
 PZ9eIOrjZ1teUBd5vXuAOULaEa2Ip0Gj3dpee66ueNaZb3XpAL2TjqAwvvqQiZA3bh
 NtlBG16pmY/cA==
Received: from [192.168.64.27] (localhost [127.0.0.1])
 by mail.taktcycles.com (Postfix) with ESMTP id BDF1A1DFDB;
 Fri, 13 Nov 2026 18:46:55 +0000 (UTC)
From: Dmitry R <rdmitry@taktcycles.com>
To: =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v3 4/8] hw/display/vhost-user-gpu: reset scanouts on the
 main loop
Date: Fri, 13 Nov 2026 18:46:55 -0000
Message-ID: <179459561539.1113933.6848786174905421911@taktcycles.com>
In-Reply-To: <20261113-issue-4848-v3-4-98e4fa3e77eb@redhat.com>
References: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
 <20261113-issue-4848-v3-4-98e4fa3e77eb@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=136.243.71.244;
 envelope-from=rdmitry@taktcycles.com; helo=mail.taktcycles.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marc-André,

On Fri, 13 Nov 2026 18:29:56 +0400, Marc-André Lureau wrote:
> Defer the display cleanup to a bottom half, as virtio_gpu_reset() does,
> and wait for it when reset is triggered from a vCPU thread.

Retested v3 on top of master 49559567 with the same setup as before.
With a D-Bus listener attached, QEMU and vhost-user-gpu stay up through
the guest's virtio_gpu probe and five system_reset/boot cycles in a
row, and the listener gets a new ScanoutDMABUF after each of them.
-device vhost-user-gpu-pci,help, device-list-properties, a refused
device_add and tests/qtest/device-introspect-test no longer abort.
#4846-#4849 don't reproduce with v3 either.

Tested-by: Dmitry R <rdmitry@taktcycles.com>

Dmitry


