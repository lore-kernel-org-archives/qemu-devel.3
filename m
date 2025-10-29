Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51E9CCF9F7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 19:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vECFf-0000Ts-I5; Wed, 29 Oct 2025 15:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1vECFW-0000PI-2e
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 15:54:30 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1vECF7-0007wI-Mc
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 15:54:14 -0400
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4BF0C5C551;
 Wed, 29 Oct 2025 19:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761767627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPKuRCtRL+cGFEISJPZpkrApshhoy8kZay3T7ph1BY8=;
 b=C7Q3gOI6kmERxvs74t0egUwH7m7NezGuwT1J8o/PcJPPL6MKdjSIgcZIsAmfTdNIITqqvu
 FnBH6dVl6r+/dOMLyFKEOh3G9Kbikdp+ncGrAmWy5b/aY4TBhHMmVhv2iCZFYhupdis9SX
 0c70YYQ0Xk++ZtO+Ctxt2vRKDpzSB4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761767627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPKuRCtRL+cGFEISJPZpkrApshhoy8kZay3T7ph1BY8=;
 b=kyU4Om3rTn7cn6qiWi1M4P34MvfF4+0iO51SR/7z+QznWZgOMXPbj3WZRU/r3ZuN+dMwzu
 gELeh4jqtdreaECQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761767627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPKuRCtRL+cGFEISJPZpkrApshhoy8kZay3T7ph1BY8=;
 b=C7Q3gOI6kmERxvs74t0egUwH7m7NezGuwT1J8o/PcJPPL6MKdjSIgcZIsAmfTdNIITqqvu
 FnBH6dVl6r+/dOMLyFKEOh3G9Kbikdp+ncGrAmWy5b/aY4TBhHMmVhv2iCZFYhupdis9SX
 0c70YYQ0Xk++ZtO+Ctxt2vRKDpzSB4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761767627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPKuRCtRL+cGFEISJPZpkrApshhoy8kZay3T7ph1BY8=;
 b=kyU4Om3rTn7cn6qiWi1M4P34MvfF4+0iO51SR/7z+QznWZgOMXPbj3WZRU/r3ZuN+dMwzu
 gELeh4jqtdreaECQ==
Date: Wed, 29 Oct 2025 20:53:46 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v2 00/11] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
Message-ID: <aQJwyoC-BclJRdXE@kitsune.suse.cz>
References: <20251021084346.73671-1-philmd@linaro.org>
 <aPdpjysqFBAMTvG-@kitsune.suse.cz>
 <1f952d10-9630-42d6-8d24-b7461f90aa9f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f952d10-9630-42d6-8d24-b7461f90aa9f@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_ZERO(0.00)[0]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[10]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_CC(0.00)[linaro.org,nongnu.org,linux.ibm.com,gmail.com,vger.kernel.org,redhat.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=msuchanek@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 29, 2025 at 11:00:18PM +0530, Shivaprasad G Bhat wrote:
> Hi Michal,
> 
> On 10/21/25 4:37 PM, Michal Suchánek wrote:
> > Hello,
> > 
> > I noticed removal of old pSeries revisions.
> > 
> > FTR to boot Linux 3.0 I need pSeries-2.7 (already removed earlier).
> > 
> > The thing that broke booting linux 3.0 for me is
> > 357d1e3bc7d2d80e5271bc4f3ac8537e30dc8046 spapr: Improved placement of
> > PCI host bridges in guest memory map
> > 
> > I do not use Linux 3.0 anymore which is the reason I did not notice this
> > breakage due to old platform revision removal.
> 
> I tried booting linux kernel 3.13.0-170-generic from ubuntu 14.04.6 LTS with
> the oldest supported machine pseries-5.0 as of now.
> 
> It worked fine.
> 
> 
> qemu-system-ppc64 -machine pseries-5.0 -accel tcg -nographic -m size=12G
> -cpu power8 -smp 1 -drive file=/root/images/ubuntu16.04.qcow2,format=qcow2,if=none,id=drive-virtio-disk0
> -device virtio-blk-pci,drive=drive-virtio-disk0,id=virtio-disk0 -serial
> mon:stdio -kernel /root/images/vmlinux-3.13.0-170-generic -initrd
> /root/images/initrd.img-3.13.0-170-generic -append
> "BOOT_IMAGE=/boot/vmlinux-4.4.0-142-generic
> root=UUID=94fba90c-dbb0-4f8d-bc3e-acd5f2e54749 ro vt.handoff=7"
> 
> 
> shiva@ubuntu:~$ uname -a
> Linux ubuntu 3.13.0-170-generic #220-Ubuntu SMP Thu May 9 12:44:25 UTC 2019
> ppc64le ppc64le ppc64le GNU/Linux
> shiva@ubuntu:~$ cat /proc/cpuinfo
> processor    : 0
> cpu        : POWER8 (architected), altivec supported
> clock        : 1000.000000MHz
> revision    : 2.0 (pvr 004d 0200)
> 
> timebase    : 512000000
> platform    : pSeries
> model        : IBM pSeries (emulated by qemu)
> machine        : CHRP IBM pSeries (emulated by qemu)
> 
> 
> Hope that helps.

How does that help?

Of course newer kernels do work.

However, distributions using Linux 3.0 don't anymore, at least that
particular Linux 3.0 build.

I am not particularly concerned, only noting that the qemu pSeries
emulation is not suitable for running very old distributions because
they are not compatible with newer qemu.

It can be a bug in the old kernel but it's not triggered by actual
hardware nor older qemu. Or it may bee a bug with that new qemu PCI bus
organization that is not triggered by newer kernel. I don't know and
since nobody cared enough to diagnose it so far we will probably never
know.

Thanks

Michal

