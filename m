Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8DDC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWceP-0002UI-JI; Tue, 01 Jul 2025 11:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWceN-0002Tg-RQ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:11:59 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWceH-0000cG-Hy
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:11:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A56243E7F;
 Tue,  1 Jul 2025 15:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C5AC4CEEB;
 Tue,  1 Jul 2025 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751382700;
 bh=M+bQwFmLXTxBWOnu4wlcoc4EDLvR5mXpIb1b4efgzsQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uKk9ctLAIOmkAX/PrO/jYKf1GxSvSUWMiWFBuQRzqpeYCc86kRHRzoF0VvEEhf6KX
 YTbfyf5B4XTEGEX0TyQLD+dH+oe4XUS5HS0DPefWL7NA1uBCgyfXU7/2HQXD00LPVy
 hlDPMi2OzMXJy2DNlEiWM2Mt1mWnDikXVlmOZUN8MHMMjftOAzE+GPXuc05ONsP/6c
 Vp0yrgaPsrBzXcP4FIgbtd4/fbHyMp8zl11gQMW6mM8Mk01zvgOP/hhvwDdQqNi9dK
 /5AV+HjMlBF0P8LDJLy4Iz1fTcGpXw2CqETs5TB5Cq4pZofZPU201wsltll/DFV7DK
 P4MFsgYRJpotQ==
Date: Tue, 1 Jul 2025 15:11:39 +0000
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
Subject: Re: [RFC PATCH 24/25] target/i386/mshv: Implement mshv_vcpu_run()
Message-ID: <aGP6q20CEV5_Y2UM@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-25-magnuskulke@linux.microsoft.com>
 <aC0Ht-541wBzrUoc@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <aGOd1jSBsAMQ3OSj@example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGOd1jSBsAMQ3OSj@example.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
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

On Tue, Jul 01, 2025 at 10:35:34AM +0200, Magnus Kulke wrote:
> On Tue, May 20, 2025 at 10:52:39PM +0000, Wei Liu wrote:
> > On Tue, May 20, 2025 at 01:30:17PM +0200, Magnus Kulke wrote:
> > > +    default:
> > > +        msg = &exit_msg;
> > 
> > Do you not get any HALT exit? How are you going to shut down the VM?
> > 
> 
> In the WHPX accelerator there is this comment:
> 
> 	case WHvRunVpExitReasonX64Halt:
> 		/*
> 		 * WARNING: as of build 19043.1526 (21H1), this exit reason is no
> 		 * longer used.
> 		 */
> 		ret = whpx_handle_halt(cpu);
> 		break;
> 
> I wonder if this also applies to HVMSG_X64_HALT from the MSHV driver?

IIRC that's still used in our driver.

You can try shutting down the VM with `poweroff` or `halt` and see if
you get the exit.

Wei

