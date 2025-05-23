Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFCEC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 16:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIV2x-0007cm-R7; Fri, 23 May 2025 12:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uIV2q-0007cE-4C
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:14:53 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uIV2i-0004M2-E4
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:14:51 -0400
Received: from example.com (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id ACF0D2067890;
 Fri, 23 May 2025 09:13:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACF0D2067890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748016840;
 bh=eD13QmKshkXo5litfHI40Bv/pZp/SKufg5cdhcDJV0k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P1/3F46DcdqYbY12nFLrlJDPBBCw5CoGG/YnwSM/R0zdFfu7SPlTY27W+8LK7MtVT
 jlIXFgP+JpFeGhGCOGbCJkz2SXLehyrdxje0jmkekRyIv6XHfuzsqlRwHz9me6Z8NM
 94kB3W5WGGbDHiNEXO++nFwlZh8H1B2PNMPTl56o=
Date: Fri, 23 May 2025 18:13:54 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
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
Message-ID: <aDCewoDE7iyj1kpt@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-9-magnuskulke@linux.microsoft.com>
 <aCzS2h9UfGe-FZDW@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <aDAwnkXFsEri/e4D@example.com>
 <aDCWHsw0iGd00JyL@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDCWHsw0iGd00JyL@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, May 23, 2025 at 03:37:02PM +0000, Wei Liu wrote:
> On Fri, May 23, 2025 at 10:23:58AM +0200, Magnus Kulke wrote:
> > On Tue, May 20, 2025 at 07:07:06PM +0000, Wei Liu wrote:
> > > On Tue, May 20, 2025 at 01:30:01PM +0200, Magnus Kulke wrote:
> > > > Create the MSHV virtual machine by opening a partition and issuing
> > > > the necessary ioctl to initialize it. This sets up the basic VM
> > > > structure and initial configuration used by MSHV to manage guest state.
> > > > 
> > > > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > > > ---
> > > [...]
> I'm not talking about initialization specifically. I don't think QEMU
> calls the initialization function of an accelerator multiple times.
> 
> What I mean is that after this point, the fd is neither closed nor
> tracked. There is no way to cleanly handle it other than waiting for the
> process to exist. One fd may not seem a lot, but it takes up precise
> space in the file descriptor table in the kernel and is counted against
> the fd limit.
> 
> My suggestion would be if this fd is no longer needed, it can be closed
> in this same function.
> 
> If it is needed throughout the life cycle of the VM, we put it in a
> either a global variable or (better) the accelerator state structure. If
> we do the latter, we should also close it when we deinitialize the
> accelerator if we have such a phase.
> 
> Thanks,
> Wei.
> 

oh yes, that's right. we wouldn't use the mshv_fd anywhere else for the
time being, so we can close it immediately after the create_vm ioctl.

