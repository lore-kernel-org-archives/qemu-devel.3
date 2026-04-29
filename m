Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DECCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6Ax-000445-QR; Wed, 29 Apr 2026 10:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wI6Aw-00043p-1j
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:06 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>) id 1wI6Au-0004Pp-HV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:05 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id DEA2420B716C; Wed, 29 Apr 2026 07:46:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEA2420B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777473962;
 bh=EDLZ8elOlsTVYsA35Oh4fDGq1XdIXO1GHMrsnFL9zZs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ijFkdY9HEQKpNJrgobnUGFQ/vmlC3MPQh41kGfGgvmDlOkctVSyuWXsJSUPzwV6ct
 wndvnJcmrEXXpsUsuuBjMF9ayhGkaGwhKWWfv3DmqPUj4itNWCIB9KiWItqQAVaB7U
 nhZ4KuR/49yXl59ubUotzSvCqfxK4ApSgayK/fq8=
Date: Wed, 29 Apr 2026 07:46:02 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 03/14] meson, target/arm/mshv: Enable arm64 build &
 add initial MSHV support
Message-ID: <afIZqpIdx3K86lWv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-3-469f544778ba@linux.microsoft.com>
 <b957470b-60b2-4f0b-ab60-a184484a9ff0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b957470b-60b2-4f0b-ab60-a184484a9ff0@linaro.org>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 23, 2026 at 11:12:43AM +1000, Richard Henderson wrote:
> On 4/21/26 15:21, Aastha Rawat wrote:
> > @@ -855,8 +856,8 @@ if get_option('kvm').allowed() and host_os == 'linux'
> >   endif
> >   if get_option('mshv').allowed() and host_os == 'linux'
> > -  if get_option('mshv').enabled() and host_machine.cpu() != 'x86_64'
> > -    error('mshv accelerator requires x64_64 host')
> > +  if get_option('mshv').enabled() and not (host_machine.cpu() in [ 'x86_64', 'aarch64' ])
> > +    error('The mshv accelerator requires an x86_64 or aarch64 host')
> >     endif
> >     accelerators += 'CONFIG_MSHV'
> >   endif
> 
> This error should be handled by
> 
> if 'CONFIG_MSHV' not in accelerators and get_option('mshv').enabled()
>   error('mshv not available on this platform')
> endif
> 
> later in meson.build.
> 
> 
> r~

Thanks for the review. I'll remove the explicit error and fold the CPU
check into the outer condition.

if 'CONFIG_MSHV' not in accelerators and get_option('mshv').enabled()
  error('mshv not available on this platform')
endif

This check is already handling the error.

Thanks,
Aastha 

