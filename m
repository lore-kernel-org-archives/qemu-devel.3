Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DA8D5C0C5
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Ozw-0007fM-KL; Fri, 08 Nov 2024 08:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t9Ozs-0007YE-W3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:25:58 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t9Ozq-0001yb-HS
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:25:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EA7A1F7C0;
 Fri,  8 Nov 2024 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731072350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjF5EPEWSVlY8vSpTC1f+wDfst72hnftqQvPzO1qWP0=;
 b=MkC7CxlZSZk7q2S4L8Va2wMAn3A1C7sK0947SCJW0YtI/YsUWI7O4+JbBcoAGNcLZyJTOm
 nFnHGetD9IaEt6sC6z6U34b3/LpZP19vO5V1z4fIjtb2xkPEhIaV2QSfc5hDG19UktOPQd
 L1Jgh9FX5s7aOXitrf5K5i1uovmBNno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731072350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjF5EPEWSVlY8vSpTC1f+wDfst72hnftqQvPzO1qWP0=;
 b=Y6tLuBa1qmD4lZthnv1igdmgacKwR+jQzZA9NsavVz4kWh0joLwnDpqsGdeGA5G/fR6Qlc
 pU5NP8xtnFvEa8BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MkC7CxlZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y6tLuBa1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731072350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjF5EPEWSVlY8vSpTC1f+wDfst72hnftqQvPzO1qWP0=;
 b=MkC7CxlZSZk7q2S4L8Va2wMAn3A1C7sK0947SCJW0YtI/YsUWI7O4+JbBcoAGNcLZyJTOm
 nFnHGetD9IaEt6sC6z6U34b3/LpZP19vO5V1z4fIjtb2xkPEhIaV2QSfc5hDG19UktOPQd
 L1Jgh9FX5s7aOXitrf5K5i1uovmBNno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731072350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjF5EPEWSVlY8vSpTC1f+wDfst72hnftqQvPzO1qWP0=;
 b=Y6tLuBa1qmD4lZthnv1igdmgacKwR+jQzZA9NsavVz4kWh0joLwnDpqsGdeGA5G/fR6Qlc
 pU5NP8xtnFvEa8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9A0B1394A;
 Fri,  8 Nov 2024 13:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fTd1HF0RLmfzbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 08 Nov 2024 13:25:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
In-Reply-To: <CAE8KmOwOsb-qot3sUfXJF_NvG=zgwxr=siaRCFQmht05v_sT+Q@mail.gmail.com>
References: <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <87ldxw1p8k.fsf@suse.de>
 <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
 <ZyyzjWY-1nPpPgSW@redhat.com> <ZyzoGvOaybHs4uMl@x1n>
 <Zyzxihj37-pfTQWx@redhat.com> <Zyz8wnTkooE4V4UQ@x1n>
 <CAE8KmOwOsb-qot3sUfXJF_NvG=zgwxr=siaRCFQmht05v_sT+Q@mail.gmail.com>
Date: Fri, 08 Nov 2024 10:25:47 -0300
Message-ID: <871pzlkgbo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2EA7A1F7C0
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Hello Peter, Dan, Fabiano,
>
> Thank you so much for the detailed comments, I appreciate it.
>
> On Thu, 7 Nov 2024 at 17:41, Fabiano Rosas <farosas@suse.de> wrote:
>> The handshake will be a QEMU-only feature. Libvirt will then only start
>> the migration on src and QEMU will do the capabilities handling.
>>
> On Thu, 7 Nov 2024 at 18:03, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>> Libvirt does what it does because it has had no other choice,
>> not because it was good or desirable.
>>
>> This kind of handshake really does not belong in libvirt. A number
>> of exposed migration protocol feature knobs should be considered
>> private to QEMU only.
>
> * Right, okay.
>
> * So then IIUC, libvirtd(8) would invoke migration by sending (without
> first checking with the destination libvirtd(8)) the migration command
> to the source QEMU and in qmp_migrate() before setting up the required
> connections, QEMU will add the feature negotiation (or handshake)
> step, right?

Yes, but there are still some points to figure out, as Peter mentioned,
such as how to handle capabilities for which there is a high chance that
libvirt does actually want to control, e.g. multifd. One approach is to
just continue to allow migrate-set-caps before qmp-migrate and take
those into account during handshake as well.

>
>> It has the very negative consequence that every time QEMU wants to
>> provide a new feature in migration, it needs to be plumbed up through
>> libvirt, and often applications above, and those 3rd party projects
>> need to be told when & where to use the new features. The 3rd party
>> developers have their own project dev priorities so may not get
>> around to enable the new migration features for years, if ever,
>> undermining the work of QEMU's migration maintainers.
>
> * True. I've seen the mismatch/disconnect between QEMU features and
> how libvirtd(8)/virsh(1) offers them to the end users. ex. What QEMU
> calls Multifd, virsh(1) calls --parallel-connections. Features like
> 'postcopy-preempt-channel' are implemented in QEMU, but no way for an
> end user to see/enable/disable it from virsh(1) side.
>
> * TBH, Multifd is such a misnomer, it could have been a plain simple
> --threads <N> option.
>     ex: virsh migrate --threads <N>: precopy migration with <N>
> threads, default <N> =3D 1.
>
>    Irrespective of the number of threads, the underlying migration
> mechanism/protocol remains the same. Threads only help to accelerate
> the rate of data transfer through multiple connections. We don't have
> to differentiate channels by sending magic values then.
>
> * Since we are thinking about correcting past wrongs, does having a
> unified migration protocol make sense? OR that is too ambitious a
> thing to think about? (just checking)
>
> * Meanwhile, @Fabiano Rosas If you have not started with the handshake
> or feature negotiation in QEMU, I'd try it on my side and we can
> discuss how the handshake should work. If you've already started with
> it, I'd be happy to help in some way as possible.
>

I'm putting together a prototype that we can iterate on. I'll let you
know as soon as I have something I can share.

> * Are we thinking about dynamically adjusting migration features based
> on their availability on both sides? Ex. say source says open 10
> parallel connections, but destination can do only 5, then source
> reports an error and terminates migration or continues with 5
> threads/connections OR say user does not mention parallel connections,
> but still we automatically start multiple threads because both ends
> support it? Just checking about dynamic adjustments, because earlier
> while discussing with Peter, he mentioned that we can not
> enable/disable user supplied options.
>
> Thank you.
> ---
>   - Prasad

