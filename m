Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7B9C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdAn-0006go-G1; Tue, 01 Jul 2025 11:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWdAj-0006fd-Gq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:45:28 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWdAb-0000vq-G4
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:45:24 -0400
Received: from example.com (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 12C8C206B745;
 Tue,  1 Jul 2025 08:45:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12C8C206B745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751384713;
 bh=24SthVIePFZJRa3l4YeacFXeXtoo9IMQcuQGVK6qVhQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qm9367h+6KFxsye6HhM7NLtttOGtjAfZz5bHbT3KTGFJI0VX88LmxCadL79jeAkpM
 YAqjlWrdbJjwSXLOcNa1mZFFijIl3Ywx9L1gOsRkpRlBwA6SzCfiGYV/oJcyZY+Oik
 SsNYXb4cIoegl8i8JLNUvNGXc2kf3WaDSihqd+SM=
Date: Tue, 1 Jul 2025 17:45:07 +0200
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
Subject: Re: [RFC PATCH 24/25] target/i386/mshv: Implement mshv_vcpu_run()
Message-ID: <aGQCg+yzwyNaFdAV@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-25-magnuskulke@linux.microsoft.com>
 <aC0Ht-541wBzrUoc@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <aGOd1jSBsAMQ3OSj@example.com>
 <aGP6q20CEV5_Y2UM@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGP6q20CEV5_Y2UM@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
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

On Tue, Jul 01, 2025 at 03:11:39PM +0000, Wei Liu wrote:
> On Tue, Jul 01, 2025 at 10:35:34AM +0200, Magnus Kulke wrote:
> > On Tue, May 20, 2025 at 10:52:39PM +0000, Wei Liu wrote:
> > > On Tue, May 20, 2025 at 01:30:17PM +0200, Magnus Kulke wrote:
> > > > +    default:
> > > > +        msg = &exit_msg;
> > > 
> > > Do you not get any HALT exit? How are you going to shut down the VM?
> > > 
> > 
> > In the WHPX accelerator there is this comment:
> > 
> > 	case WHvRunVpExitReasonX64Halt:
> > 		/*
> > 		 * WARNING: as of build 19043.1526 (21H1), this exit reason is no
> > 		 * longer used.
> > 		 */
> > 		ret = whpx_handle_halt(cpu);
> > 		break;
> > 
> > I wonder if this also applies to HVMSG_X64_HALT from the MSHV driver?
> 
> IIRC that's still used in our driver.
> 
> You can try shutting down the VM with `poweroff` or `halt` and see if
> you get the exit.
> 
> Wei

I wasn't able to trigger the exit with `poweroff` or `halt -p`. Or a
kernel module that performs:

```
local_irq_disable();
__asm__("hlt");
```

(it will just hang the guest).

I have added the handler, but it looks like it's dead code currently.

