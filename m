Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE8FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4Jn-0000E2-1R; Mon, 05 Aug 2024 16:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sb4Jm-0000AF-5N
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:28:34 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sb4Jj-00035s-Ts
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:28:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C666A21C91;
 Mon,  5 Aug 2024 20:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722889709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ePoJJiF8D2v8INiMCjSWRfu3g2oSzoZaf7FWrTQeHo=;
 b=G3qmdIKSFAZ3BhL/r7XSNQ/wP3pXTDwtE7cgIRBJRh09MDCFRzmPcvPWulX0HBg1I4DtKP
 ZxrjxzbZXC3P/VDLff2oRcnj8KFopJGWM74XEbgse/wrUf/SnUyxjtx9hOVA3bUakYL82h
 1oFzFZiUcYf2zZvqnFCRLM8F2pjAzME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722889709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ePoJJiF8D2v8INiMCjSWRfu3g2oSzoZaf7FWrTQeHo=;
 b=wsa9PEoILTL4nksCP08n8RNcnvIthsRvd+pBnHfDcE6VornKd4a7p9RLK5d6DBiOVPuPKY
 9JyDOXBhONo60vCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=08C7IaR6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3g82TFsd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722889708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ePoJJiF8D2v8INiMCjSWRfu3g2oSzoZaf7FWrTQeHo=;
 b=08C7IaR6rhBGJgjYyQASqacqptyu16MuRIS/qh15hFNHiQXz3WkTTEYC3UcjS5vZWGoJa3
 7VfqrWbehuGoles7jHaFhtWVm5qR/9tXC19f3cm1xVU9Gu/VxOP4Zvtux5RkQpsrZetJ6j
 bcNmwXbzbvCHSvQ4SnuSG0C8ZkECLS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722889708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ePoJJiF8D2v8INiMCjSWRfu3g2oSzoZaf7FWrTQeHo=;
 b=3g82TFsdOOVBGM3OivKg8Mx1y1l05Lnr5BoQGg1tj+eYFgL8PHNkS7DmJG81vKbOthDt9f
 r6KxEd7sWgoRWDCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CD8B13254;
 Mon,  5 Aug 2024 20:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SzlNBew1sWbtNQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Aug 2024 20:28:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Dario Faggioli <dfaggioli@suse.com>, qemu-devel@nongnu.org
Cc: jpoimboe@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Fabian Vogt
 <fvogt@suse.de>, Nikolay Borisov <nik.borisov@suse.com>,
 fabiano.rosas@suse.com
Subject: Re: SRSO mitigation in microcode not passed through to VMs
In-Reply-To: <68f8b8b1ca1bf58b059f52afbd1c9c51108a074a.camel@suse.com>
References: <68f8b8b1ca1bf58b059f52afbd1c9c51108a074a.camel@suse.com>
Date: Mon, 05 Aug 2024 17:28:25 -0300
Message-ID: <87r0b2hfyu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C666A21C91
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:url];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Dario Faggioli <dfaggioli@suse.com> writes:

> Hello,
>
> So, even if SRSO is fully mitigated on the host, we still see as not
> completely patched inside of the VMs running on Zen 3 and 4 hosts
> (e.g., AMD EPYC 7713)
>
> We can see an example of that here:
> https://bugzilla.suse.com/show_bug.cgi?id=1228079
>
> This specific bug is about SLE15SP5, where we have old versions of QEMU
> and kernel (and the kernel was missing a backport), but we see it also
> on openSUSE Tumbleweed, where we have kernel 6.9.9 and QEMU 9.0.2, e.g:
>
>
>   ### Host
>   virt136:~ # uname -a
>   Linux virt136 6.9.9-1-default #1 SMP PREEMPT_DYNAMIC Thu Jul 11 11:31:54 UTC 2024 (8c0f797) x86_64 x86_64 x86_64 GNU/Linux
>
>   virt136:~ # qemu-system-x86_64 --version
>   QEMU emulator version 9.0.2 (openSUSE Tumbleweed)
>
>   virt136:~ # cat /proc/cpuinfo | grep -e "vendor\|family\|model\|stepping\|microcode" | tail -5
>   cpu family	: 25
>   model		: 1
>   model name	: AMD EPYC 7713 64-Core Processor
>   stepping	: 1
>   microcode	: 0xa0011d5
>
>   virt136:~ # lscpu | grep rstack
>   Vulnerability Spec rstack overflow:   Mitigation; Safe RET
>
>   ### Guest
>   virt136:~ # virsh console opensusetumbleweed
>   Connected to domain 'opensusetumbleweed'
>   Escape character is ^] (Ctrl + ])
>
>   localhost:~ # uname -a
>   Linux localhost.localdomain 6.9.9-1-default #1 SMP PREEMPT_DYNAMIC Thu Jul 11 11:31:54 UTC 2024 (8c0f797) x86_64 x86_64 x86_64 GNU/Linux
>
>   localhost:~ # lscpu | grep rstack
>   Vulnerability Spec rstack overflow:   Vulnerable: Safe RET, no microcode
>
>
> Fabian and Nikolay (Cc-ed) can provide more details, if necessary.
> AFAIUI this is due to how/when the proper bit in CPUID is set, on this
> specific CPU model.
>
> In fact (and I'm quoting Nikolay): "the problem with the IBPB_BRTYPE
> flag is that on CPUs which require the microcode fix, the flag is not
> shown by CPUID despite it actually being available. Ini this case the
> kernel checks whether the feature is valid by doing a specific wrmsr
> and, if it is, it sets the flag internally in the kernel and in KVM's
> cpuid representation".
>
> Yet, we don't see this in the VM, because QEMU seems to be masking it
> (as visible, e.g., here:
> https://bugzilla.suse.com/show_bug.cgi?id=1228079#c2)
>
> In one of the thread on LKML where this mitigation was discussed, we
> found mentions (from Josh, Cc-ed) to a QEMU patch being necessary, and
> also being ready and about to be submitted, e.g.:
>
> https://lore.kernel.org/lkml/20230821170520.dcovzudamnoqp7jc@treble/
>

After reading some more about the subject I think the correct way
forward is indeed a patch like the one above. I sent something to the
list with a slight modification, you are all in copy.

https://lore.kernel.org/r/20240805202041.5936-1-farosas@suse.de

