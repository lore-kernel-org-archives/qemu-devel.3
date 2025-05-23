Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900CBC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 15:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIUSO-0005J2-SZ; Fri, 23 May 2025 11:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uIUSJ-0005Ip-No
 for qemu-devel@nongnu.org; Fri, 23 May 2025 11:37:08 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uIUSH-0008Do-TT
 for qemu-devel@nongnu.org; Fri, 23 May 2025 11:37:07 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 86F5861154;
 Fri, 23 May 2025 15:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06478C4CEE9;
 Fri, 23 May 2025 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748014624;
 bh=lwTm+FlrH7mShAuv4cZRGqVLkSODuC2q0ExGVJsJKKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bloavh2b6de1V+LSqaWFkiZ9IKh0ZDNYZm3RfIaT+iXYmSRBxrfiDmvRDu0KDDNLf
 0ohiiqQjJdEz7grkMimdks3YKiCMJAOWycmtPehDJPSqDrPscFVE1puszNdcA8p2ae
 1huUS9ZR9/YJ1JSWvGbdk6V+Xds1DF2/TqsROQn+8ebAxgK7dzkt1jzEo3rHgHrSi6
 QQHR92LYjRD5zaeMdK5p3Y4MIGSqd9PC7vyshSSxojGq88B2U2P0NUbUY8BK5n1xPO
 XJJqkEQ89hPc/1xoo5Q1PAmRLH8bGzW2RUVzcWT/pEFuuwQZiS+fE9o76ddNHpCGBI
 SZlWw0W/mqgAg==
Date: Fri, 23 May 2025 15:37:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, magnuskulke@microsoft.com,
 qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 08/25] accel/mshv: Initialize VM partition
Message-ID: <aDCWHsw0iGd00JyL@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-9-magnuskulke@linux.microsoft.com>
 <aCzS2h9UfGe-FZDW@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <aDAwnkXFsEri/e4D@example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDAwnkXFsEri/e4D@example.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=wei.liu@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

On Fri, May 23, 2025 at 10:23:58AM +0200, Magnus Kulke wrote:
> On Tue, May 20, 2025 at 07:07:06PM +0000, Wei Liu wrote:
> > On Tue, May 20, 2025 at 01:30:01PM +0200, Magnus Kulke wrote:
> > > Create the MSHV virtual machine by opening a partition and issuing
> > > the necessary ioctl to initialize it. This sets up the basic VM
> > > structure and initial configuration used by MSHV to manage guest state.
> > > 
> > > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > > ---
> > [...]
> > 
> > mshv_fd is neither stashed into a state structure nor freed after this
> > point.  Is it leaked?
> > 
> > Thanks,
> > Wei.
> > 
> 
> AFAIK the accelerator should not be initialized multiple times at runtime,
> so under normal circumstances the fd wouldn't leak. But in certain debug
> scenarios that would be the case. So, yes, we should make this more solid
> and exit early if MSHV_STATE has been previously initialized.
> 

I'm not talking about initialization specifically. I don't think QEMU
calls the initialization function of an accelerator multiple times.

What I mean is that after this point, the fd is neither closed nor
tracked. There is no way to cleanly handle it other than waiting for the
process to exist. One fd may not seem a lot, but it takes up precise
space in the file descriptor table in the kernel and is counted against
the fd limit.

My suggestion would be if this fd is no longer needed, it can be closed
in this same function.

If it is needed throughout the life cycle of the VM, we put it in a
either a global variable or (better) the accelerator state structure. If
we do the latter, we should also close it when we deinitialize the
accelerator if we have such a phase.

Thanks,
Wei.

> > >      s->nr_as = 1;
> > >      s->as = g_new0(MshvAddressSpace, s->nr_as);
> > >  
> > >      mshv_state = s;
> > >  
> > > +    qemu_register_reset(mshv_reset, NULL);
> > > +
> > >      register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
> > >                                    0, "mshv-memory");
> > >      memory_listener_register(&mshv_io_listener, &address_space_io);

