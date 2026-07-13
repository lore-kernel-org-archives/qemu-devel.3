Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B401C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjGpd-0006co-0j; Mon, 13 Jul 2026 09:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjGpY-0006c8-6r
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:36:20 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjGpV-00038h-SL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:36:19 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4ECE0778D1;
 Mon, 13 Jul 2026 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783949776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/7xmby3RNEVfHYO4Vikv7VUi48YAA8qi8QQM5SirDl4=;
 b=kT5v+s5BQFXi0QSz7ndoc+mZuioSoX58dyK5GX3F0Lta2ZHDyZ1hSzR+HzwyE3zozEfcQ1
 NZ/LUtd8KWLC0KDlsrO72SsSJZ5Mik9CvhNNdNf5UoDAd9wgdqIo6I8XNHadLo4DJ68/4V
 GplrohCJjHuxbwKYW5YSGoAWUwvZ1Ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783949776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/7xmby3RNEVfHYO4Vikv7VUi48YAA8qi8QQM5SirDl4=;
 b=HR9UowxDvUXoXhAdp7xlmMjCt0PqjjzGsgxvwm1lhuEvzaSZYZGfHMM8oF82trHvFSaacQ
 OmhxKg2LG85JdXDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783949775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/7xmby3RNEVfHYO4Vikv7VUi48YAA8qi8QQM5SirDl4=;
 b=Wvapq7WNhyGA+hANAVbh7wOi3yn6Ianp7ye0xaxgECK9rW5/onJ4vb9bZv1BSM8urFiR54
 IelwwhpbhstsIy1NOqd71cEMQDhVHVoHZ1n7T7h0BX97eot7FPvY9N/IRh3RHJq1HLAjq8
 lKBMuKFAxYEBTIMnKExu543nzrTCMaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783949775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/7xmby3RNEVfHYO4Vikv7VUi48YAA8qi8QQM5SirDl4=;
 b=CT9i/a/xmIRGbKgDbwLEUKDLTUVWSjquPQ6qIs8651Jixm3hlhBrGM/gxZtFAdrdGqKg+Y
 666f17ApevPIeDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D464A779AF;
 Mon, 13 Jul 2026 13:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yIb2KM7pVGozdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 Jul 2026 13:36:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Pedro Barbuda
 <pbarbuda@microsoft.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "Daniel
 P. Berrange" <berrange@redhat.com>
Subject: Re: what is qemu_system_guest_panicked() for?
In-Reply-To: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
Date: Mon, 13 Jul 2026 10:36:12 -0300
Message-ID: <87pl0rdnar.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_ENDS_QUESTION(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,microsoft.com,unpredictable.fr,gmail.com,linux.ibm.com];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 linaro.org:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> (cc list is a random mix of maintainers of code that calls this
> function, Paolo as "main loop maintainer" and a few others who
> I thought might have an opinion.)
>
> We have a qemu_system_guest_panicked() function which causes QEMU
> to report this to the user and do one of a couple of possible options
> (shutdown, pause the VM, do nothing). This seems mostly intended for
> "the guest OS told us by some mechanism that it just panicked". But
> we use it more widely than that...
>
> Cases which are "the guest told us about a panic":
>  - accel/kvm/kvm-all.c handling of the KVM_EXIT_SYSTEM_EVENT SEV_TERM
>    and CRASH subtypes
>  - the pvpanic device
>  - the spapr ibm,os-term RTAS call

I think I remember this one is arbitrary and the spec doesn't really
interprets this as an error state of any sort. It's just that this is
the way it has been used.

I had to comment that qemu_system_guest_panicked line a few times when
experimenting with using os-term to do a clean termination _from_ the
guest code.

PPC folks, please confirm, it's been years since I looked at this.

>  - x86 kvm: tdx_panicked_on_fatal_error()
>  - x86 xen: the SHUTDOWN_crash shutdown subtype
>
> Cases which are not:
>  - hw/spapr/rtas.c: if the FDT has no RTAS address during system reset
>  - hw/spapr/spapr_events.c: if we wanted to deliver a machine check
>    exception to the guest but the FDT has no RTAS address
>  - hw/spapr/spapr_events.c: if we want to deliver a machine check
>    but the guest is still dealing with a previous machine check
>  - arm whpx, if we get an unknown/unexpected exit code trying to run the VM
>  - x86 nvmm, for an unknown/unexpected VM exit code
>  - ppc TCG, in powerpc_checkstop(), for a machine check exception I think
>  - s390_handle_wait(): not sure exactly what this is
>  - s390 unmanageable_intercept(): again not sure, think this is where
>    the guest has gone off the rails and we can't keep running
>
> At least one or two of the above have comments to the effect that
> they don't want to use e.g. cpu_abort() because they want to give
> the user the ability to examine the VM after this unrecoverable
> guest error, rather than just exiting QEMU.
>
> So I guess my question is, is it OK to mash these two categories of
> "we can't keep running the VM" together, or should we define a new
> one for the "unrecoverable guest error" case, or do we already have
> some better thing to do that I missed?
>
> In particular, "do nothing" might be a reasonable response for the
> user to configure to a guest panic notification, since the guest will
> presumably stick the vcpu into a do-nothing loop, but "do nothing"
> doesn't make sense for "unrecoverable guest error" because we'll
> probably then sit in QEMU in a tight loop retrying whatever it
> was that failed.
>
> If we had some kind of qemu_system_unrecoverable_guest_error() then
> we could maybe convert some uses of cpu_abort() over to that (though
> uses of cpu_abort() are a very mixed bunch, some of which should be
> LOG_UNIMP or LOG_GUEST_ERROR and continue and some of which should
> be straightforward assertions, as well as some which might be this
> new exit case).
>
> (This query was prompted by a patch for arm whpx which adds a new
> qemu_system_guest_panicked() call for an unhandled VM exit situation.)
>
> thanks
> -- PMM

