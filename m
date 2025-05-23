Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159DEC54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 17:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIVpo-0001Ge-Qf; Fri, 23 May 2025 13:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uIVpn-0001GA-Kh
 for qemu-devel@nongnu.org; Fri, 23 May 2025 13:05:27 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uIVpm-0002pH-5o
 for qemu-devel@nongnu.org; Fri, 23 May 2025 13:05:27 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B40D5629CD;
 Fri, 23 May 2025 17:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA8AC4CEE9;
 Fri, 23 May 2025 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748019924;
 bh=0wGbAX/eIv2RPhOVph4++MlhXVmAyp82X6nJFpQw7rY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u8s0e2HktCsUQkDr4vv1+rWqXll/uv3od3D0Ymgjua0avJ0Oq8AFAQU4g74VvdG+C
 TjHRpm4P+u1t5Rgn/hFX6BAEfQFg3ur45W2H7MieIhnyjd9W7EHQubdfn2ZVPwavVP
 jnJLHD7QRS2O9jgxbgbmc7cFIBLks80nxlZoDRP6OU5t2bguQA0hBTQPQVnUyHqVT6
 BKO1asiTx9E5IJM790OOuDFaJzUt/Zi3i550LyGJDgo6I7MdjB6G/j6J5NYO6mkCFE
 pjgctq6uBLcqcQhwyVps/mWJXTjD6bt/O+MX8sCQMo6nlfyTxvf2pYsK/eUBAxYnio
 L4kvAxz6yjbfQ==
Date: Fri, 23 May 2025 17:05:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org,
 liuwe@microsoft.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 12/25] accel/mshv: Add vCPU creation and execution loop
Message-ID: <aDCq0oj1ptOGZpvS@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-13-magnuskulke@linux.microsoft.com>
 <8b65b12c-ca3e-4528-9544-65784c862763@redhat.com>
 <12460861-2be5-4522-9ba7-009f16a61a59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12460861-2be5-4522-9ba7-009f16a61a59@redhat.com>
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

On Tue, May 20, 2025 at 03:54:57PM +0200, Paolo Bonzini wrote:
> On 5/20/25 15:50, Paolo Bonzini wrote:
> > You need support in the hypervisor for this: KVM and HVF both have it.
> > 
> > There are two ways to do it
> 
> Sorry - I left out the other way which is to pass something *into*
> MSHV_RUN_VP since only half of it is currently used (I think).  But that's
> more complicated; the advantage would be to avoid the ioctl in the signal
> handler but it's not a fast path.  I would just do it the easy way.

Thank you for the suggestions. We need some time to discuss kernel side
changes.

Thanks,
Wei.

> 
> Paolo
> 

