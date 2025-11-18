Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B29CED26E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJM0-0002Hj-Kk; Tue, 18 Nov 2025 05:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vLJLz-0002Gp-08; Tue, 18 Nov 2025 05:54:31 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vLJLu-0007wJ-1m; Tue, 18 Nov 2025 05:54:27 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C73A60192;
 Tue, 18 Nov 2025 10:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF396C2BCAF;
 Tue, 18 Nov 2025 10:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763463255;
 bh=tAkXN+13vI+etnX7QQ55xN7IwHc8AoV6kMD5t3mLpU0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nVHsPmOaeq54Wx2fCaKDWu2+L49C9ALp3EOkp5UGPh/tN+9l9sbFs16u5xGLRp2th
 /bjAm4fVrFcNhp/iRrn50DDA+NkhM/YxszhS0AJLHOBRwnEDYoCweXKtq8aL7sETPI
 n0ofHU6Kv8AXTYpF/xyHSDeXKPpqwcEDR2ByL8oENIJPnhpwZ8TOiwjiJO2hsign9g
 EMzILgLmIwodT9+TNCbqjCqnGflTrnoPMLVAnrGWH2rsKtwTYNoumxgifB07QOmaq0
 RrU78rskIi+Rf5BQqWwQ/CCdkegZzyI2TGNysN2Bl1gs3+If49DBWO2gpdNTLu9nDx
 U0pSAFjbY/aHA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vLJLf-00000002Wnt-2rHh; Tue, 18 Nov 2025 11:54:11 +0100
Date: Tue, 18 Nov 2025 11:54:11 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org, 
 gengdongjiu1@gmail.com, mst@redhat.com, imammedo@redhat.com, armbru@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 peter.maydell@linaro.org, pbonzini@redhat.com, shan.gavin@gmail.com, 
 zhangliang5@huawei.com
Subject: Re: [PATCH v4 0/8] target/arm/kvm: Improve memory error handling
Message-ID: <lghhh6xohwekbst2bbuqksiono5dgtrkyjxoypb4ahij2t2qgs@7dmgytmbiehd>
References: <20251112172535.403042-1-gshan@redhat.com>
 <20251118104755.000024c8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118104755.000024c8@huawei.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 18, 2025 at 10:47:55AM +0000, Jonathan Cameron wrote:
> On Thu, 13 Nov 2025 03:25:27 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
> > In the combination of 64KiB host and 4KiB guest, a problematic host
> > page affects 16x guest pages. Those 16x guest pages are most likely
> > owned by separate threads and accessed by the threads in parallel.
> > It means 16x memory errors can be raised at once. However, we're
> > unable to handle this situation because the only error source has
> > one read acknowledgement register in current design. QEMU has to
> > crash in the following path due to the previously delivered error
> > isn't acknowledged by the guest on attempt to deliver another error.
> > 
> >   kvm_vcpu_thread_fn
> >     kvm_cpu_exec
> >       kvm_arch_on_sigbus_vcpu
> >         kvm_cpu_synchronize_state
> >         acpi_ghes_memory_errors
> >         abort
> > 
> > This series fixes the issue by sending 16x consective CPER errors
> > which are contained in a single GHES error block.
> > 
> > PATCH[1-4] Increases GHES raw data maximal length from 1KiB to 4KiB
> > PATCH[5]   Supports multiple error records in a single error block
> > PATCH[6-7] Improves the error handling in the error delivery path
> > PATCH[8]   Sends 16x consective CPERs in a single block if needed
> > 
> 
> Hi Gavin,
> 
> Just a quick head's up to say we've had some internal discussions around the
> kernel handling of broader address masks in CPER and think it is probably
> broken. Rectifying that may at least simplify what is needed on the QEMU side
> of things and maybe even handle much larger blocks (2M and larger).

Btw, I just added a logic at rasdaemon to catch SIGBUS errors:
https://github.com/mchehab/rasdaemon/pull/199

But so far, I didn't find a proper way to check such code.

Jonathan/Gavin,

Do you know a good way for us to check how the mm SEA notification
is handled with QEMU?

Regards,
Mauro

