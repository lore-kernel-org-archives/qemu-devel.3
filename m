Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754F3C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 09:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5Jnc-0001jK-Fg; Sat, 12 Sep 2026 05:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x5JnT-0001j2-BH; Sat, 12 Sep 2026 05:13:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x5JnP-0003T5-UF; Sat, 12 Sep 2026 05:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789204356; bh=Yd89fj8L+9qIPsIRAn1lytqb/LaEm9soA6iaLd3E/9U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=D8EfY1WVwBwfMrrjZVrzDIs9iw0yMkHt1oXOgAT6vk229FvZJ2RaFgVUwftaaWg5r
 17TEJntC6OM01nHxznSK8iVzWX7inQ1LSx9KaSaxuljJqMQEU1LfFIL+mp3wbd28yA
 u4bDbk5OQCszY4t8MxJaTOGDC5ViVhlCDBxfewhXzA+58e+EKDpdhlk66g36ktsoeN
 vEJA1GFFq44k3oIU0Le9ztiUfpTxU87UfQ2PfHRuIQdymfqYJcpsIwF9AlOUa7u0LI
 EBC4ECou7t/lwR8I+dJ+bniAMjXUq8KTnN+RBSJ4qySWBdXmPh6qeSLsaG5NfCxzaK
 oKdJTFozTKeqA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 003821D3F89;
 Sat, 12 Sep 2026 12:12:35 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8EC014264D3;
 Sat, 12 Sep 2026 12:13:10 +0300 (MSK)
Message-ID: <83065cc3-e299-4b50-9a78-8f7b669daa85@tls.msk.ru>
Date: Sat, 12 Sep 2026 12:13:10 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] virtio-scsi: set dataplane_started to false upon failure
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>
References: <20260825154854.263819-1-stefanha@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260825154854.263819-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/25/26 18:48, Stefan Hajnoczi wrote:
> Commit e24a47c5b73e ("virtio-scsi: do not use vring in dataplane") set
> dataplane_started to true when virtio_scsi_dataplane_start() fails. This
> is likely a typo since dataplane is not functional after failure.
> 
> The non-ioeventfd fallback is broken because dataplane_started is true
> after virtio_scsi_dataplane_start() failure. As a result, the following
> assertion failure occurs when a virtio-scsi device exceeds the open file
> descriptor ulimit when setting up notifiers (eventfds):
> 
>    $ ulimit -n 104 # exact number can vary based on QEMU version
>    $ qemu-system-x86_64 -M q35,accel=kvm -m 1G -cpu host -smp 14 \
>           --blockdev file,node-name=drive0,filename=test.img,cache.direct=on,aio=native \
>           --blockdev file,node-name=drive1,filename=data01.img,cache.direct=on,aio=native \
>           --device virtio-scsi-pci,id=virtio-scsi-pci0 \
>           --device scsi-hd,drive=drive0,bus=virtio-scsi-pci0.0 \
>           --device virtio-scsi-pci,id=virtio-scsi-pci1 \
>           --device scsi-hd,drive=drive1,bus=virtio-scsi-pci1.0
>    qemu: virtio-scsi: Failed to set guest notifiers (-24), ensure -accel kvm is set.
>    qemu: virtio_bus_start_ioeventfd: failed. Fallback to userspace (slower).
>    qemu-system-x86_64: ../hw/scsi/virtio-scsi.c:1017: virtio_scsi_reset: Assertion `!s->dataplane_started' failed.
>    Aborted                    (core dumped)
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: e24a47c5b73e ("virtio-scsi: do not use vring in dataplane")
> Buglink: https://redhat.atlassian.net/browse/RHEL-193328
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
I'm picking this one for currently active qemu stable series.
Please let me know if I shouldn't.  Maybe it's a too specific
bug but it's not good to throw assertion failures to the user.

Thanks,

/mjt

