Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0CBC4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 17:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgnN-0004wf-UD; Tue, 14 Jul 2026 13:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjgnJ-0004tb-PH
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:19:47 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wjgnH-000737-FL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:19:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E404977D94;
 Tue, 14 Jul 2026 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784049580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5Q1jlxh26EsZfMUiRSf6XbsXoeotepO2u3n4L88H0g=;
 b=T+2CBAClejoazGdOGXZScxl7ZcmV/rakmM9Zi651QCBBEwXbDIbCKM75cpXB/XTK0N8iSS
 8A9DeyO05Sa/UORLmEcgOxUUtuvGSHBrm2skKix34p1j0GVYH5hmQJ07+qdJt6BwbgDc/5
 4EK6tLLKok1fsRGaPeybFOd1TUunMg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784049580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5Q1jlxh26EsZfMUiRSf6XbsXoeotepO2u3n4L88H0g=;
 b=xaLyTpSM2lkw1OiTYW1QmoYFnQc1YhyI4mc3JIUybtFfhAq2XPr4kt2fHmYnX16K5tnsKb
 zEUJxh4g9ZIiriCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784049579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5Q1jlxh26EsZfMUiRSf6XbsXoeotepO2u3n4L88H0g=;
 b=fFJ4VsmF90k1vQf70i44d9IxR+XlGnGp8yZUZzJkArO0Yd45Y97ENYLXqBRYnaW2a9NUtL
 RylzO6r2hPjC8xwRUpoo8VTtnEbAeaZUXgnAedUm3JG922AIZY66VAWHRd7gij97WkyTWf
 vvLdqMa/xd55ViFIZNbM/EphP7XmoBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784049579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5Q1jlxh26EsZfMUiRSf6XbsXoeotepO2u3n4L88H0g=;
 b=3soxYdVPgNisWXmyThDMIFUIZrjH/msl4vlRARWkcOgo+dRrGgjJJGMag66RpjIyI4bmio
 i7aKe6+nR22ymxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EC1F779AE;
 Tue, 14 Jul 2026 17:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LCT0D6tvVmqvRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Jul 2026 17:19:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Shivang Upadhyay <shivangu@linux.ibm.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU
 Developers <qemu-devel@nongnu.org>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Pedro Barbuda
 <pbarbuda@microsoft.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: what is qemu_system_guest_panicked() for?
In-Reply-To: <bc94506bd307f3273b199a432a4f6df8c219b212.camel@linux.ibm.com>
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <87pl0rdnar.fsf@suse.de>
 <0dbbac06-8fdf-45ef-9cd4-eaf2510394d2@linux.ibm.com>
 <bc94506bd307f3273b199a432a4f6df8c219b212.camel@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:19:37 -0300
Message-ID: <87v7ah4hg6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_ENDS_QUESTION(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,microsoft.com,unpredictable.fr,gmail.com,linux.ibm.com];
 RCPT_COUNT_TWELVE(0.00)[13]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Shivang Upadhyay <shivangu@linux.ibm.com> writes:

> On Tue, 2026-07-14 at 15:54 +0530, Aditya Gupta wrote:
>> > guest code.
>> >=20
>> > PPC folks, please confirm, it's been years since I looked at this.
>> True. The way the spec mentions it seems the OS can get control back
>> after
>> execution of ibm,os-term.
>>=20
>> This difference is noticeable with `panic=3D15`. On an LPAR, this would
>> print the
>> following line and do a reboot after a timeout of 15s (this happens
>> in linux
>> after it has done the os-term call):
>>=20
>> =C2=A0=C2=A0 =C2=A0 [=C2=A0 338.186072] Rebooting in 15 seconds..
>>=20
>> But on QEMU, this isn't printed, and the machine powers down:
>>=20
>> =C2=A0=C2=A0 =C2=A0 qemu-system-ppc64: OS terminated:
>>=20
>> Maybe worth taking a look. Didn't notice this earlier, thanks Fabiano
>> !
>>=20
>
> Hi Aditya Fabiano,
>  As we register the rtas(os-term) as the panic handler for spapr in
> linux, I think we expect the machine to be shut-down properly and not
> handle any of the work. I am not sure how else would we implement this
> function in qemu without using `qemu_system_guest_panicked`. I mean,
> the name conveys, the guest has "paniced".
>
> But then again as per PAPR, we should expected limited number of rtas
> calls from the OS (the following list).
> - nvram-fetch
> - nvram-store
> - display-character
> - power-off
> - ibm,power-off-ups
> - system-reboot
> - check-exception
>
> PAPR reffers to host as "live-halt" after it has called os-term. Not
> very sure on the meaning of this.
>
> Maybe other platforms then linux will rely on this? As Fabiano
> suggested he found some case where he needed to comment it out, That
> would be interesting scenario to explore.
>

To be clear: I don't know of anything that currently depends on a more
rigorous behavior of os-term.

If Linux, and probably other major OSes, use os-term to relay a panic
state to the hypervisor, this is fine. For the purposes of Peter's
question I think we can leave it at that.

---

PS:
The use-case I had in the past was related to this test suite:
https://github.com/legoater/pnv-test. I was looking for a way to do
clean termination of a vm from the guest OS while conveying the test
output in the message.

E.g:

$ cat slof.s
li      3,0
ori     3,3,61440       # H_RTAS
li      4,argbuf
.long 0x44000022
b .

argbuf:
.long 0x201f    # ibm,os-term
.long 0x65786974 # "exit"
.long 0=20
.long . -8

$ ./qemu-system-ppc64 -bios slof.bin -d guest_errors
qemu: OS terminated: exit
Guest crashed

