Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0530C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4eQH-0004g2-Fc; Thu, 10 Sep 2026 09:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4eQG-0004fu-Bq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:02:36 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4eQE-0006v6-Bj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:02:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 517161FDA5;
 Thu, 10 Sep 2026 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789045348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D26ZpG9EDQ1JmO1QI0IQMTmzQGz4i3JxM415CFd3T18=;
 b=Ynia9tTLJuyTDYBVuUaUyAMgsZbzVVB3YDhekxd4uM64Rp0r1PGZGncWvY449jqNnKBNOr
 hTp7szRnQJBaBrCYJw3oYfYhEO15swgAkJCMj6z8rw0dJPJEmSV9G2tQzS+heOmD2PwmpX
 /0ITjoFlIsnx+FfjHxhb0EZkXo4wZMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789045348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D26ZpG9EDQ1JmO1QI0IQMTmzQGz4i3JxM415CFd3T18=;
 b=nqcACb0vKmUZ+3M4ti/QisYYo61T3xKsmF5mT9n91vMNgHOhu+MrvOEOO3IBpWQyBJYCJJ
 BJWM8+uTTQwAmgBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WfqLkYDN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TUQrvYKk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789045344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D26ZpG9EDQ1JmO1QI0IQMTmzQGz4i3JxM415CFd3T18=;
 b=WfqLkYDNANWJPTUG2u/eHaGqZfkL/mTzUP1bgL4ZNkbGXdyQExGAxq+SR0NuBK6iCH9H2k
 /9q8SzwpvvT1GFFVrH3OAqTQiOfo46FniBJW3GRZrZvCMEIxD/jXiuiRFmdiRbv2K0dg4I
 KwXVEu8Hzq9jb6xRMcus3YVG+OmQEkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789045344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D26ZpG9EDQ1JmO1QI0IQMTmzQGz4i3JxM415CFd3T18=;
 b=TUQrvYKkUSXGdoug+nPpb5sIKxMVXRWJA3ytkSpTD1oXay5yFZR3RRfhLQpM2U/Mw7Z+8O
 T+B9QtyPfq2lN0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7D071326D;
 Thu, 10 Sep 2026 13:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OiMSJl+qompBcwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 13:02:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 12/18] migration: Change HMP 'info
 migrate_parameters' output
In-Reply-To: <87v78dftni.fsf@pond.sub.org>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-13-farosas@suse.de> <87v78dftni.fsf@pond.sub.org>
Date: Thu, 10 Sep 2026 10:02:21 -0300
Message-ID: <87wlsttg2q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 517161FDA5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> The output of 'info migrate_parameters' includes units of measurement
>> for a few parameters. This is convenient for a user.
>
> Yes.
>
>>                                                      It also requires
>> every parameter to be individually listed in the
>> hmp_migrate_set_parameter() function, which in turn requires the
>> MigrationParameter (singular) enum to exist.
>
> I think I understand what you mean, but your text doesn't express it
> clearly.
>
> How does having in "info migrate" imply the need for parameter-specific
> code in "migrate_set_parameter"?  Perhaps with the (unstated)
> requirement that "migrate_set_parameter" must take values in the units
> shown by "info migrate_parameters"?
>
> Let me try to explain the why differently.
>
> hmp_info_migrate_parameters() and hmp_migrate_set_parameter() both have
> code for each parameter, and they both use enum MigrationParameter.
>
> You want to replace this parameter-specific code by code that works for
> any parameter, in both functions.
>
> Your new code really doesn't want to do special per-parameter stuff.
> That's why you want to get rid of all that.
>

Right, you got the point, it's that having the units requires custom
formatting which needs to be per-parameter and therefore requires the
parameters to be enumerated in the code which increases the maintenance
burden. I'll update the commit message with something more clear.

> You split the work as follows:
>
> * Get rid of special units in migrate_set_parameter [previous patch].
>   Interface change, simple patch.
>

This one is separate because it affects how the user _sets_ those
values, while the rest of the changes only affects how the user _sees_
the values.

> * Don't show units in info migrate_parameters [this patch].
>   Interface change, simple patch.
>
> * Replace parameter-specific code [next patches].  More interesting, but
>   no interface change.
>
> I like this split, it helps reviewers.
>
>>                                              While the latter is not
>> bothersome at all, the former is.
>
> The values of enum MigrationParameter duplicate the members of struct
> MigrationParameters.  That's plenty bothersome, isn't it?
>

As Peter pointed out in v1, this is now less bothersome than it used to
be, since we stopped requiring documentation for MigrationParameter in
commit 2220c2b9ef (qapi/migration: Don't document MigrationParameter,
2025-12-15).

> As far as I can tell, the only remaining uses of enum MigrationParameter
> at the end of the series are an assertion in
> migrate_mark_all_params_present(), which we discussed in review of v1,
> and hmp_completion_single() in qtest/migration/misc-tests.c.  Any chance
> we can get rid of it entirely?
>

We need something that ensures migrate_mark_all_params_present() will be
updated when a new parameter is added. My attempt in v1 of converting to
MigrationParameters to QDict didn't work because the has_ fields are not
carried over to the QDict. At the moment, the best I can do is to use
the enum.

As for the test, we could simply not test the completion of
parameters. It's not the end of the world, QEMU's implementation of
readline is already wonky.

There might be other situations in the future where we'd like to have a
mapping of parameter to user-friendly parameter name, in which case I
fear we'd probably just reintroduce the enum.

>> From a development and maintenance perspective, having a list of
>> parameters explicitly written in several parts of the code brings
>> several annoyances: conflicts during rebase, multiple extra hits when
>> grepping, requires contributors to search for every location a change
>> needs to be mirrored to, etc.
>>
>> Remove the units from the output so we can write this code in a more
>> convenient way. The HMP output is not part of any ABI.
>>
>> Also remove quotes from around the TLS options strings as this is
>> inconsistent with all the other strings.
>>
>> Change block-bitmap-mapping format to a single line. This requires
>> updating one of the iotests to match.
>>
>> Before:                                      After:
>>                      (unchanged entries omitted)
>> announce-initial: 50 ms                      announce-initial: 50
>> announce-max: 550 ms                         announce-max: 550
>> announce-rounds: 5                           announce-rounds: 5
>> announce-step: 100 ms                        announce-step: 100
>> tls-creds: ''                                tls-creds:
>> tls-hostname: ''                             tls-hostname:
>> tls-authz: ''                                tls-authz:
>> max-bandwidth: 134217728 bytes/second        max-bandwidth: 134217728
>> avail-switchover-bandwidth: 0 bytes/second   avail-switchover-bandwidth: 0
>> max-postcopy-bandwidth: 0 bytes/second       max-postcopy-bandwidth: 0
>> downtime-limit: 300 ms                       downtime-limit: 300
>> x-checkpoint-delay: 20000 ms                 x-checkpoint-delay: 20000
>> xbzrle-cache-size: 67108864 bytes            xbzrle-cache-size: 67108864
>> x-vcpu-dirty-limit-period: 1000 ms           x-vcpu-dirty-limit-period: 1000
>> vcpu-dirty-limit: 1 MB/s                     vcpu-dirty-limit: 1
>> x-rdma-chunk-size: 1048576 bytes             x-rdma-chunk-size: 1048576
>> block-bitmap-mapping:                        block-bitmap-mapping: bitmaps: name: bmap0 alias: bmap0 node-name: node-src alias: node-dst
>>   'node-src' -> 'node-dst'
>>     'bmap0' -> 'bmap0'
>
> Uh, the value of block-bitmap-mapping can become really long.  Its QAPI
> type is array of BitmapMigrationNodeAlias, and each array element
> contains another array.
>
> Why is this change useful?
>

Not so much useful as required, we can't have generic printing of QDict
and QList if block-bitmap-mapping needs custom arrows and spacing.

I can try to tweak hmp_migrate_print_qobject() in patch 14 to add some
newlines where appropriate.

>> Signed-off-by: Fabiano Rosas <farosas@suse.de>

