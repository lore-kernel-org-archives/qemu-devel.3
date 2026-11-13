Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0223606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=taktcycles.com header.i=@taktcycles.com header.a=rsa-sha256 header.s=takt1 header.b=ABK1+GdH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrk6-00039q-Ud; Fri, 13 Nov 2026 08:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRqWH-0006Cj-AX
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:36:41 -0500
Received: from mail.taktcycles.com ([136.243.71.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRqWF-0000gh-DA
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:36:41 -0500
Received: from mail.taktcycles.com (unknown [192.168.64.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
 (No client certificate requested)
 by relay.taktcycles.com (Postfix) with ESMTPSA id D82228A5D;
 Fri, 13 Nov 2026 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taktcycles.com;
 s=takt1; t=1794573397;
 bh=8vpNqwX30OMAAceXZkSsbTHIGmOnKKuqUqh/1UOO9v4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ABK1+GdHBBi5UEA6vANGfirF8eg1aM4FqXYU7joYd3t36reHl0GHjpCjEqOaNHDbB
 H0vPzcTxHCmu829CT/qW7RSFfYkVBIQkVG52SH7JottvR/x8dQPJIhugvQ188QvkUj
 U0iAEMtfwcHJ0vNnCp2WpTBAZhnU7MqV+/iN5MMn4TuUdX4MYeMczaINJF4etgKHUe
 WzPILs0UPwrzVL9BJa3j+n/zDJukrm8ao5MucG1okNHzMh3F1mwFF6fOA/Z/ZMRCx1
 aiHiRD1qHWJHQ225WeJ3DxWscMr1eCL0TFV4eBFDkXdLEDFxMdV6wupHMwmD4zdppl
 w/8OUCduAtiyQ==
Received: from [192.168.64.27] (localhost [127.0.0.1])
 by mail.taktcycles.com (Postfix) with ESMTP id 660BD1DF87;
 Fri, 13 Nov 2026 12:36:37 +0000 (UTC)
From: Dmitry R <rdmitry@taktcycles.com>
To: =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry R <rdmitry0911@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 4/8] hw/display/vhost-user-gpu: reset scanouts on the
 main loop
Date: Fri, 13 Nov 2026 12:36:37 -0000
Message-ID: <179457339706.955135.2425240084935401636@taktcycles.com>
In-Reply-To: <20261113-issue-4848-v2-4-631414664bca@redhat.com>
References: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
 <20261113-issue-4848-v2-4-631414664bca@redhat.com>
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
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:54 -0500
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marc-André,

On Fri, 13 Nov 2026 14:42:16 +0400, Marc-André Lureau wrote:
> Defer the display cleanup to a bottom half, as virtio_gpu_reset() does,
> and wait for it when reset is triggered from a vCPU thread.

This fixes the abort I reported on v1. Same setup as before (master
49559567 + v2, -display dbus,gl=on, vhost-user-vga backed by
vhost-user-gpu --virgl, Debian 13 guest, a D-Bus listener attached):
QEMU and vhost-user-gpu stay up through the guest's virtio_gpu probe
and through five system_reset/boot cycles in a row, and the listener
receives a new ScanoutDMABUF after each of them.

There is one new abort, though:

> @@ -631,13 +632,16 @@ vhost_user_gpu_instance_finalize(Object *obj)
> [...]
> +    g_clear_pointer(&g->reset_bh, qemu_bh_delete);
> +    qemu_cond_destroy(&g->reset_cond);

reset_cond is initialized at the end of realize but destroyed in
instance_finalize, so finalizing an instance that was never realized
aborts:

  qemu-system-x86_64: ../util/qemu-thread-posix.c:207: qemu_cond_destroy: Assertion `cond->initialized' failed.

With v2 this happens on
  - qemu-system-x86_64 -device vhost-user-gpu-pci,help
    (the same with vhost-user-vga);
  - QMP device-list-properties with typename vhost-user-gpu-pci;
  - a device_add of vhost-user-gpu-pci that is refused, e.g. with
    "Device 'vhost-user-gpu-pci' does not support hotplugging" on q35;
and tests/qtest/device-introspect-test fails in
/x86_64/device/introspect/concrete/defaults/none. Master passes all of
them. virtio-gpu destroys its reset_cond in unrealize.

I'll retest v3 and send Tested-by for 3/8 and 4/8 then.

Dmitry


