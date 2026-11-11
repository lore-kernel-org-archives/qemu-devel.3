Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240960A2606
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJ5gna+V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR48c-0000NL-2y; Wed, 11 Nov 2026 03:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1xR48V-0000LM-0E; Wed, 11 Nov 2026 03:56:57 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1xR48S-0008Ak-O8; Wed, 11 Nov 2026 03:56:54 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D42D24068F;
 Wed, 11 Nov 2026 08:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE8E1F00A05;
 Wed, 11 Nov 2026 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794387400;
 bh=zUh7BgdIOFpLEpkJ6X2Y9nJLJ8KSFfxW3Xf7xe5ENoY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EJ5gna+VKb86Kmp0EGZj5IHZMcmi4MejLRiKsBvAQbzepsFmsLSNpmrwMMM6AdEaC
 QlHVCPW7pDYHvlIe8LU7SJtw9LUdeB7+TPTw0BNycMdHKdiupqiPyUVnaPunJ8CuXn
 zn2aB7b6d+A2dVFa63tbudtxJb2UZcYLAmcivh7wUltnAQcnyILsnVgc+GHvagXBp6
 Fwq8Toah26nMkY1kZIDu7jkcRrMxGVwNWiPn0/u7OGzFscYxrDm7ZwZZXKHOHpYK7k
 CvxbExJ0KSQV9/qob3xAPuGqOtClh6C50Sm1gDaAVS6Ut9yPJhOHiAoKvE+8E2Ky8K
 4X1kyQ6UY6L8A==
Date: Wed, 11 Nov 2026 09:56:34 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gavin Shan <gshan@redhat.com>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 00/24] Add Realm support to QEMU-VMM
Message-ID: <avQtwvArH3we5GBp@lpieralisi>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
 <atkokvqTHygpI8dt@p14s>
 <5dba456f-26b4-4f05-9271-fb784736d581@redhat.com>
 <atvCNKxpCRRSFL58@p14s> <avLM3UdwUcgUHLgP@FCCLS0092175.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avLM3UdwUcgUHLgP@FCCLS0092175.localdomain>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=lpieralisi@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 05:01:14PM +0900, Kohei Enju wrote:

[...]

> > > > > (1) qemu is terminiated on qmp command 'dump-guest-memory'
> > > > > 
> > > > > (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
> > > > > **
> > > > > ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> > > > > Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> > > > > 
> > > > 
> > > > On my side this command causes the Realm to abort, as I expected it to be.
> 
> Hi Mathieu, Gavin.
> 
> I've tested RFC v5, and I reproduced issue (1) on my side as well:
> 
>     (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
>     Failed to set KVM_REG_ARM_TIMER_CNT
>     ./qemu-ram-realm.sh: line 21: 77580 Aborted                 (core dumped) $QEMU -no-reboot -M confidential-guest-support=rme0,memory-backend=ram0 ...
> 
> This was resolved by adding kvm-no-adjvtime=on.
> 
> > > > Realm memory should not be observable from the host.  There may be a debug mode
> > > > to enable this kind of operation but I will have to look at the documentation
> > > > for details.
> > > > > (2) qemu emulation can't be stopped and resumed
> > > > > 
> > > > > (qemu) stop
> > > > > (qemu) cont
> > > > > Failed to set KVM_REG_ARM_TIMER_CNT
> > > > > 
> > > > 
> > > > That too I was expecting.  Anything that can comprimise a Realm will cause the
> > > > HW to abort.  I'll investigate the "Failed to set KVM_REG_ARM_TIMER_CNT" error
> > > > message though.
> 
> kvm-no-adjvtime=on also resolved issue (2) above.
> 
> Setting KVM_REG_ARM_TIMER_CNT for Realm VMs is not allowed, so we should
> either add this option or consider making it the default for Realm VMs
> in the future. What do you think?

I think that we should do something like we do for *put_registers(),
where we detect whether we are running a Realm VM or not, regardless
of the command line parameter or default that param to on for Realms.

Lorenzo

