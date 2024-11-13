Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4602D41C0A
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 06:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB7KN-0005qV-Jj; Wed, 13 Nov 2024 01:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tB7KH-0005pr-Hl; Wed, 13 Nov 2024 01:58:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tB7KF-0003ex-Qs; Wed, 13 Nov 2024 01:58:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CE3F45C55D8;
 Wed, 13 Nov 2024 06:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52827C4CED2;
 Wed, 13 Nov 2024 06:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731481081;
 bh=iL8xR6/fZyknPIirBu4QmU0cQpDTBqHhpvaeoBMFPfM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CIFEoDX/sMGcGk+EAxEN9ElyA7m5RMLS4h1tFblCR7xKd2EutpmZoN387f+Kc1/WC
 Bf6weZD6MWlVAvsICyHXLrH288PV65jn4Z8ta5OKoSztK/xad1+nvmt59MS8HELzF/
 DIVZQW9v9P1iMKQHTmORWi/iAyrYEkuQhGdOd2j41gheMZMsZRomrXofVT9aqclkuB
 k+OUc2PDclOfQSsizEGmwsQZD44DYRg8nI59sAHnnuYFdjIjIDZOIZ6MoFSEZFULD1
 TwZet7nltCCtWdtF7qIao+rd2YtvNcL5JVY0TD09H54lAKNRgwm0Ba/Nlts02ip5rB
 6j8qIKDhCdObQ==
Date: Wed, 13 Nov 2024 07:57:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao
 Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 0/5] Change ghes driver to use HEST-based offsets
Message-ID: <20241113075756.370c5056@foz.lan>
In-Reply-To: <20241113075418.5fa1ac61@foz.lan>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
 <20241002154534.3c58db06@imammedo.users.ipa.redhat.com>
 <20241113075418.5fa1ac61@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Wed, 13 Nov 2024 07:54:18 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Wed, 2 Oct 2024 15:45:34 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Tue,  1 Oct 2024 13:42:45 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > This RFC series was part of the previous PR to add generic error injection
> > > support on GHES.
> > > 
> > > It contains only the changes of the math used to calculate offsets at
> > > HEST table and hardware_error firmware file.
> > > 
> > > The first patch adds a new firmware file to store HEST address.
> > > The second patch makes use of it.
> > > The remaining ones add migration support.
> > > 
> > > PS.: I'm sending this as a RFC as using the proceudure defined at the
> > > pseudo-migration of:
> > > 
> > > 	https://www.linux-kvm.org/page/Migration
> > > 
> > > Didn't work. I tried to use two different QEMU versions to check a
> > > real life case and also to use just one QEMU and trying to load a
> > > virt-9.1 state on a virt-9.2 machine. 
> > > 
> > > For instance, trying to restore a virt-9.1 state on virt-9.2 gave me
> > > this error:
> > > 
> > > 	(qemu) qemu: Machine type received is 'virt-9.1' and local is 'virt-9.2'
> > > 	qemu: load of migration failed: Invalid argument    
> > 
> > that's expected (idea is to keep machine type (virt-X) ABI stable so
> > it would work the same way on old and new QEMU)
> > migration is meant to move VM of the same machine type to a new/another QEMU instance.  
> 
> I found a couple of issues and, after the fixes, it can successfully
> migrate both virt-9.1 and virt-9.2 machines. 
> 
> > 
> > i.e try migrate 
> > 
> > qemu-9.1 -M virt-9.1  => qemu-9.2 -M virt-9.1
> > and vice-versa
> > migration should succeed and memory error injection should still work
> > the old way in both instances (I don't recall anymore how to simulate SEA,
> > perhaps original author left a description how to do that somewhere on mail-list).  
> 
> Those work as well, but I had to pass -cpu cortex-a57 to both 9.1
> and 9.2, as using -cpu max caused qemu to refuse loading the guest.
> 
> I tested with both:
> 
> 	qemu-9.1 -M virt-9.1 -cpu cortex-a57 => qemu-9.2 -M virt-9.1 -cpu cortex-a57
> 	qemu-9.2 -M virt-9.1 -cpu cortex-a57 => qemu-9.1 -M virt-9.1 -cpu cortex-a57

Forgot to mention, but I modified qemu-9.1 to use GPIO instead of SEA, as
it is a lot easier to do the tests using the error injection logic.
Also, I don't know how to test SEA errors.

> I'll address your other comments to the series and post a new version
> today.
> 
> Thanks,
> Mauro



Thanks,
Mauro

