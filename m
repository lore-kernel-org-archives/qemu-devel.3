Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958CED116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ4wg-00052a-3o; Mon, 01 Dec 2025 09:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vQ4wZ-00051h-OR; Mon, 01 Dec 2025 09:32:00 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vQ4wS-00026W-4W; Mon, 01 Dec 2025 09:31:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D576E4443F;
 Mon,  1 Dec 2025 14:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D6BC4CEF1;
 Mon,  1 Dec 2025 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764599486;
 bh=gbv9rasdmRljV8v7FkHczEyIOWlWNGhkurF1uqJ0KTQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CsbLI6KSNlUjV8BpEulsz9oTGXtykFZa/qkhaqDK/2sOT97PtfT9DUR9k1+zToGQH
 tX+2C3JRuKCxh20/qPMQJw60WL6ZAo7nv7jMPnu7LcRxHLrGwBXitxFEcTiUXhqjx8
 Pfj5yY1EfJvJg/jZoSZB37Kuam/AHIJu5bsL9B5DuR11o+/NIgmIqbOD5rdu+55hwb
 2QMPC7oy56xolHSL65qDbab+JaeSN0PvN8GLpnqUF1NKF2DQTQItWPfNXMwnuSDtkV
 pS4UbCTj6nA0AefTyWPZpmxg6Nc5YTnI3V9lC0gk6IWlLRLHWA/Yyc1vBWsQHSnvUE
 U5boAi+tqzz4w==
Date: Mon, 1 Dec 2025 15:31:21 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 armbru@redhat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/5] acpi/ghes: Error object handling improvement
Message-ID: <20251201153121.190c22ec@foz.lan>
In-Reply-To: <12b7baee-1d6d-440a-a119-971b47d7f3ad@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251201131729.615abe68@foz.lan>
 <12b7baee-1d6d-440a-a119-971b47d7f3ad@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2 Dec 2025 00:13:06 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Mauro,
> 
> On 12/1/25 10:17 PM, Mauro Carvalho Chehab wrote:
> > On Thu, 27 Nov 2025 10:44:30 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> >> This series is curved from that for memory error handling improvement
> >> [1] based on the received comments, to improve the error object handling
> >> in various aspects.
> >>
> >> [1] https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00534.html
> >>
> >> Gavin Shan (5):
> >>    acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
> >>    acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
> >>    target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
> >>    acpi/ghes: Bail early on error from get_ghes_source_offsets()
> >>    acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()  
> > 
> > Patch series look ok on my eyes.
> > 
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >   
> 
> Thanks.
> 
> > -
> > 
> > Btw, what setup are you using to test memory errors? It would be
> > nice to have it documented somewhere, maybe at
> > docs/specs/acpi_hest_ghes.rst.
> >   
> 
> I don't think docs/specs/acpi_hest_ghes.rst is the right place for that
> as it's for specifications. 

Perhaps not, but it would be nice to have it documented somewhere,
either there or at QEMU wiki.

> I'm sharing how this is tested here to make the thread complete.

Thanks!

> 
> - Both host and guest has 4KB page size
> 
> - Start the guest by the following command lines
> 
>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                  \
>    -accel kvm -machine virt,gic-version=host,nvdimm=on,ras=on               \
>    -cpu host -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1   \
>    -m 4096M,slots=16,maxmem=128G                                            \
>    -object memory-backend-ram,id=mem0,size=4096M                            \
>    -numa node,nodeid=0,cpus=0-7,memdev=mem0                                 \
>    -L /home/gavin/sandbox/qemu.main/build/pc-bios                           \
>    -monitor none -serial mon:stdio -nographic                               \
>    -gdb tcp::6666 -qmp tcp:localhost:5555,server,wait=off                   \
>    -bios /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd   \
>    -boot c                                                                  \
>    -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                    \
>    -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                    \
>    -device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                    \
>       :                                                                     \
>    -device pcie-root-port,bus=pcie.0,chassis=16,id=pcie.16                  \
>    -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=drive0      \
>    -device virtio-blk-pci,id=virtblk0,bus=pcie.1,drive=drive0,num-queues=4  \
>    -netdev tap,id=tap1,vhost=true,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
>    -device virtio-net-pci,bus=pcie.8,netdev=tap1,mac=52:54:00:f1:26:b0
> 
> - Trigger 'victim -d' in the guest

Hmm... from where I can get victim?

Regards,
Mauro

