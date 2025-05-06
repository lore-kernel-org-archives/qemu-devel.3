Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFF6C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIXN-0007zn-WA; Tue, 06 May 2025 09:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uCIXM-0007zf-Rt
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:40:44 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uCIXK-0001pn-V3
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:40:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE41021219;
 Tue,  6 May 2025 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746538840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Axh9iIwugGHQTOEQUStY2Kd0seJ4D7h1OrpGETWxyQ=;
 b=opmZRhMEnalFOzSPi36na2T1eejBzyPliVZ4BJ/IV8VklekFoqdiuMXz6bDgxiFk+aYKf5
 Egd5MF+ge/1br/DiDaUU3P57a1oErlJV057v070f7EGGdAz1V1DFvoWQZgDt0aDYwRFs7m
 unwMsLJ62p0bmxz2f+4NMOPUwG4VpLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746538840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Axh9iIwugGHQTOEQUStY2Kd0seJ4D7h1OrpGETWxyQ=;
 b=6zKuAXgM9AiUqOYTWkYNgxN/yoYtn9VcZn2fJrsYCPy6x1pTMtELuqLsNOb05R5L2Icguv
 JVX54soZDf9jxmAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=opmZRhME;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6zKuAXgM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746538840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Axh9iIwugGHQTOEQUStY2Kd0seJ4D7h1OrpGETWxyQ=;
 b=opmZRhMEnalFOzSPi36na2T1eejBzyPliVZ4BJ/IV8VklekFoqdiuMXz6bDgxiFk+aYKf5
 Egd5MF+ge/1br/DiDaUU3P57a1oErlJV057v070f7EGGdAz1V1DFvoWQZgDt0aDYwRFs7m
 unwMsLJ62p0bmxz2f+4NMOPUwG4VpLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746538840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Axh9iIwugGHQTOEQUStY2Kd0seJ4D7h1OrpGETWxyQ=;
 b=6zKuAXgM9AiUqOYTWkYNgxN/yoYtn9VcZn2fJrsYCPy6x1pTMtELuqLsNOb05R5L2Icguv
 JVX54soZDf9jxmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48AB5137CF;
 Tue,  6 May 2025 13:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v6NFAlgRGmjsQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 May 2025 13:40:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <CAE8KmOzBZd=_FmmJTiwqKw5yPoYR7_+q+umpXBFJGPYZYuMgWw@mail.gmail.com>
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
 <87v7qeg9r3.fsf@suse.de>
 <CAE8KmOzBZd=_FmmJTiwqKw5yPoYR7_+q+umpXBFJGPYZYuMgWw@mail.gmail.com>
Date: Tue, 06 May 2025 10:40:37 -0300
Message-ID: <87plglg8mi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CE41021219
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hi,
>
> On Tue, 6 May 2025 at 00:34, Fabiano Rosas <farosas@suse.de> wrote:
>> >> # Running /ppc64/migration/multifd+postcopy/tcp/plain/cancel
>> >> # Using machine type: pseries-10.0
>> >> # starting QEMU: exec ./qemu-system-ppc64 -qtest
>> >> # {
>> >> #     "error": {
>> >> #         "class": "GenericError",
>> >> #         "desc": "Postcopy is not supported: Userfaultfd not available: Function not implemented"
>> >> #     }
>> >> # }
>> >
> ===
> [ ~]#
> ...
> PPC KVM module is not loaded. Try modprobe kvm_hv.
> qemu-system-ppc64: -accel kvm: failed to initialize kvm: Invalid argument
> qemu-system-ppc64: -accel kvm: ioctl(KVM_CREATE_VM) failed: Invalid argument
> PPC KVM module is not loaded. Try modprobe kvm_hv.
> qemu-system-ppc64: -accel kvm: failed to initialize kvm: Invalid argument

The tests should fallback to TCG and that should be enough to reproduce
this issue. I don't think you even need a ppc machine, the CI uses a
x86_64 container.

> [ ~]#
>
> [ ~]# modprobe kvm-hv
> modprobe: ERROR: could not insert 'kvm_hv': No such device
> [ ~]#
> [ ~]# ls -l /dev/kvm /dev/userfaultfd
> crw-rw-rw-. 1 root kvm  10, 232 May  6 07:06 /dev/kvm
> crw----rw-. 1 root root 10, 123 May  6 06:30 /dev/userfaultfd
> [ ~]#
> ===
>
> * I tried to reproduce this issue across multiple Power9 and Power10
> machines, but I -qtest could not run due to above errors.
>

There are several considerations to take into account with ppc64le, you
probably have either a distro version that doesn't provide the KVM
module or a machine that doesn't have KVM support at all.

>> We're missing a check on has_uffd for the multifd+postcopy tests.
>
> * If it is about missing the 'e->has_uffd' check, does that mean
> Postcopy tests are skipped on this machine because 'e->has_uffd' is
> false?
>

I haven't verified, but yes, the ones that check has_uffd should be
skipped.

I don't think you need to go to the extent to reproduce this. Look at
migrate_caps_check(), whenever postcopy-ram is enabled for the first
time, it will call postcopy_ram_supported_by_host(), so it follows that
any test that enables postcopy-ram must first check env->has_uffd.

>
> Thank you.
> ---
>   - Prasad

