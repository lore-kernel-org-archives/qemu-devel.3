Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CDDFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 06:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJn7f-0002vF-Q7; Mon, 04 May 2026 02:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wJn7b-0002ur-V0
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:49:40 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>) id 1wJn7a-0000GR-Ez
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:49:39 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id AD13C20B7168; Sun,  3 May 2026 23:49:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD13C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777877374;
 bh=5pyTPpkI7AHLV5BxlEg6i5StaLO80oCMag+o9rcRVX8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SrHvNZkWxlTcerTbOO6DqH4bWm7vPhrB7theB55TkNBcVJa+kSTm6QlwLSQgfHAWU
 JwJ4PzrGh26kW9pB6xN7QxtlCLKcloYUflietW/hqu8a7zkXpCpDl+0nyFOdrgzHx/
 d/O2dwaaL2QP7YdTK47OyUZMdCqducU5W1p2W46E=
Date: Sun, 3 May 2026 23:49:34 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 09/14] accel/mshv: implement cpu_thread_is_idle() hook
Message-ID: <afhBfqw9KJe6RQiO@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-9-469f544778ba@linux.microsoft.com>
 <66ebbc64-7509-47bc-b7cf-27c0b5fd0eee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ebbc64-7509-47bc-b7cf-27c0b5fd0eee@linaro.org>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Thu, Apr 23, 2026 at 11:55:43AM +1000, Richard Henderson wrote:
> On 4/21/26 15:21, Aastha Rawat wrote:
> > From: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > 
> > In MSHV the hypervisor APIC is always used, so we to implement this hook
> > to make sure the AP's vcpu thread is not blocked waiting for an INIT SIPI
> > by the BSP. Without this change soft reboots with -smp cpus>=2 will
> > hang.
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > ---
> >   accel/mshv/mshv-all.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> > index 5ce76e86db..6c0ddbf3ca 100644
> > --- a/accel/mshv/mshv-all.c
> > +++ b/accel/mshv/mshv-all.c
> > @@ -704,11 +704,23 @@ static const TypeInfo mshv_accel_type = {
> >       .instance_size = sizeof(MshvState),
> >   };
> > +/*
> > + * MSHV manages the LAPIC in the hypervisor. SIPI for APs are handled
> > + * internally. Halted vCPUs must still enter mshv_cpu_exec() so that
> > + * MSHV_RUN_VP is called and the hypervisor will deliver SIPI to wake APs.
> > + */
> > +
> > +static bool mshv_vcpu_thread_is_idle(CPUState *cpu)
> > +{
> > +    return false;
> > +}
> 
> The comment, at least, is x86 specific.

The function itself is correct for both architectures (returns false).
The logic applies to x86 (SIPI) and ARM64 (PSCI), haulted vCPUs must
still enter MSHV_RUN_VP so that hypervisor can wake them. I can update
the comment.

Thanks,
Aastha

