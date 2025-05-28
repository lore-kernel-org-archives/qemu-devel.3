Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50796C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 14:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKHoH-00034f-4Y; Wed, 28 May 2025 10:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uKHoF-00034T-A7
 for qemu-devel@nongnu.org; Wed, 28 May 2025 10:31:11 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uKHo7-0000EA-MB
 for qemu-devel@nongnu.org; Wed, 28 May 2025 10:31:09 -0400
Received: from example.com (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id D56FC2078639;
 Wed, 28 May 2025 07:30:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D56FC2078639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748442661;
 bh=+PBrz4nax7wXZf/mnSwD98SkthiZNiEzroWeTfzzzcc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tG7XmgXoJTb3tNVpyHGc18GJlz25g7q9zyBES2WJ8o5CIobunt/OO7H/pAh6ga3hx
 cfBHQnxxVRX9pFNQoRZWk84i53BGaEPjlIprJnuhpi29y8G1ry3seaWh/QgigACJ85
 g/KP0I/fNlhq3jl6bVKE4bY8iqbNa/e3smnSDcrE=
Date: Wed, 28 May 2025 16:30:55 +0200
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
Subject: Re: [RFC PATCH 18/25] target/i386/mshv: Implement
 mshv_arch_put_registers()
Message-ID: <aDceHy3zjGgwBFNm@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-19-magnuskulke@linux.microsoft.com>
 <aC0Ao4TQnV6ZE6Aa@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC0Ao4TQnV6ZE6Aa@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, May 20, 2025 at 10:22:27PM +0000, Wei Liu wrote:
> On Tue, May 20, 2025 at 01:30:11PM +0200, Magnus Kulke wrote:
> > +    /*
> > +     * TODO: support asserting an interrupt using interrup_bitmap
> > +     * it should be possible if we use the vm_fd
> > +     */
> > +
> 
> Why is there a need to assert an interrupt here?
> 

The comment has been carried over from the mshv-ioctl crate:

https://github.com/rust-vmm/mshv/blob/main/mshv-ioctls/src/ioctls/vcpu.rs#L778

I was wondering whether we can/want to set the bitmap here, since we do
have access to the vm_fd, but I didn't follow up on that yet.

