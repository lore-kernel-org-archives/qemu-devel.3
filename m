Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDCEC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h8B-0004MQ-9p; Fri, 18 Sep 2026 18:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h89-0004MF-6G
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:32:29 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h87-0000vN-GB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:32:28 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2146521EDE;
 Fri, 18 Sep 2026 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NjZAUxu1YfB1mjPj270FZ7cYB0YSC9+XyeOsFMSb9og=;
 b=iRG1gxWUiTxLTwYlyCpdYnkQfIktnnMvS/SkB/ngLCxBzVzGnrAyHWr9bWnpQUGqRdu8tY
 vLXrf60pKO2zZ7TPzJa3ZxTNx5xm6H9U4XrmdPe3Po61BXG2KFbk7qTKrwHOij0ocPKvPJ
 nAr5X/uBeTaT+N8WY49UHE9urCPMB3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NjZAUxu1YfB1mjPj270FZ7cYB0YSC9+XyeOsFMSb9og=;
 b=xkHwhuGulLDhxeqJNCwflfNcijY22EJBxuEqnE7XzN/+px+OpnqgsO0zBeYcOv/y8GJ5dt
 Dnx+XMJKgRBBHDAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NjZAUxu1YfB1mjPj270FZ7cYB0YSC9+XyeOsFMSb9og=;
 b=kxtNzQ2bdgDLC/x2TfZsXW9X/NR3aRauN9UMgXNAyR3+KyKVv8UVvDw33g8KD8I6KXsrgZ
 2s0b4QMHxghxGUHDttl8sSg+spg6tAg9nuvg4DX4qoZPsb2pSmRCa00/SEECiBRsZLnk4O
 b7Hq4DDAbGYXXO0MOpQWvv7ZLAqTIyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NjZAUxu1YfB1mjPj270FZ7cYB0YSC9+XyeOsFMSb9og=;
 b=ZFIb9A/PdWCf0Q+m43PC8C660D73O1nfFraOZQTfj+tfOPrS7rvdgz7wRj39d+0y+jAaYn
 qbGQTpgVu8OCoJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7448D1348F;
 Fri, 18 Sep 2026 22:32:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pWIvBvG7rWoxeAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:32:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 14/20] migration: Use output visitor in info command
In-Reply-To: <87h5jnnf7u.fsf@pond.sub.org>
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-15-farosas@suse.de> <87zexg2ix9.fsf@pond.sub.org>
 <aqw0anGmdLfHtv3q@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <aqxUMH9Q3OtkV9oW@gallifrey> <87h5jnnf7u.fsf@pond.sub.org>
Date: Fri, 18 Sep 2026 19:32:07 -0300
Message-ID: <87ik42ry1k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

Markus Armbruster <armbru@redhat.com> writes:

> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
>
>> * Peter Xu (peterx@redhat.com) wrote:
>>> On Thu, Sep 17, 2026 at 01:53:22PM +0200, Markus Armbruster wrote:
>>> > Fabiano Rosas <farosas@suse.de> writes:
>>> > 
>>> > > The hmp_info_migrate_parameters function currently open-codes the
>>> > > mon_printf calls for each migration parameter. As with the set command
>>> > > in the last patch, this should not be necessary as the QAPI
>>> > > infrastructure already has generated code that takes type and struct
>>> > > member names into account, including converting _ from C into the '-'
>>> > > character as part of parameter names strings.
>>> > >
>>> > > The current code is also quite painful to rebase if a series has been
>>> > > carried for a long time while parameters have been added in master.
>>> > >
>>> > > Replace all of this with a conversion from MigrationParameters to
>>> > > QDict using an output visitor and a loop over the QDict that prints
>>> > > per-QAPI-type formatted strings.
>>> > >
>>> > > Modelled after block/qapi.c:dump_qobject, but with some changes to
>>> > > keep the migration command output formatting.
>>> > >
>>> > > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> > 
>>> > Old output of info migrate_parameters for me:
>>> > 
>>> >     announce-initial: 50
>>> >     announce-max: 550
>>> >     announce-rounds: 5
>>> >     announce-step: 100
>>> >     throttle-trigger-threshold: 50
>>> >     cpu-throttle-initial: 20
>>> >     cpu-throttle-increment: 10
>>> >     cpu-throttle-tailslow: off
>>> >     max-cpu-throttle: 99
>>> >     tls-creds: 
>>> >     tls-hostname: 
>>> >     tls-authz: 
>>> >     max-bandwidth: 134217728
>>> >     avail-switchover-bandwidth: 0
>>> >     max-postcopy-bandwidth: 0
>>> >     downtime-limit: 300
>>> >     x-checkpoint-delay: 20000
>>> >     multifd-channels: 2
>>> >     multifd-compression: none
>>> >     zero-page-detection: multifd
>>> >     xbzrle-cache-size: 67108864
>>> >     x-vcpu-dirty-limit-period: 1000
>>> >     vcpu-dirty-limit: 1
>>> >     mode: normal
>>> >     direct-io: off
>>> >     x-rdma-chunk-size: 1048576
>>> >     cpr-exec-command:
>>> > 
>>> > New output:
>>> > 
>>> >     cpu-throttle-tailslow: off
>>> >     xbzrle-cache-size: 67108864
>>> >     cpu-throttle-initial: 20
>>> >     announce-max: 550
>>> >     direct-io: off
>>> >     avail-switchover-bandwidth: 0
>>> >     local: off
>>> >     zero-page-detection: multifd
>>> >     multifd-qatzip-level: 1
>>> >     x-rdma-chunk-size: 1048576
>>> >     multifd-channels: 2
>>> >     mode: normal
>>> >     multifd-zstd-level: 1
>>> >     announce-initial: 50
>>> >     downtime-limit: 300
>>> >     tls-authz: 
>>> >     cpr-exec-command:
>>> > 
>>> >     vcpu-dirty-limit: 1
>>> >     multifd-compression: none
>>> >     announce-rounds: 5
>>> >     announce-step: 100
>>> >     tls-creds: 
>>> >     x-vcpu-dirty-limit-period: 1000
>>> >     multifd-zlib-level: 1
>>> >     max-cpu-throttle: 99
>>> >     max-postcopy-bandwidth: 0
>>> >     tls-hostname: 
>>> >     throttle-trigger-threshold: 50
>>> >     max-bandwidth: 134217728
>>> >     x-checkpoint-delay: 20000
>>> >     cpu-throttle-increment: 10
>>> > 
>>> > New output has an unwanted blank line after "cpr-exec-command:".
>>> > 
>>> > New output adds @local, @multifd-qatzip-level, @multifd-zlib-level,
>>> > @multifd-zstd-level.  Commit message should point that out.
>>> > 
>>> > Order of parameters changes, and not for the better.  Hmm.
>>> 
>>> Good point.. it might start to be awkward to users looking for tls-*,
>>> multifd-*, announce-* or cpu-throttle*, etc. after this change, expecting
>>> them grouped.
>>> 
>>> Maybe we can sort them by name with inserting top level to a QList first
>>> from the QDict.
>>
>> Are there any filter visitors in qemu's visitor system - e.g. something that
>> sorts?
>
> No.  Visitors walk members in source order.  Source order is good as
> long as we care to make it good.  But it doesn't help us here, because
> we use the visitor only to convert to QObject, then walk that.  This
> loses order.
>
> If QDict iterated in insertion order, we'd be fine.  Python dict do.
> Could be a fun little project for someone with time to spare.
>
> The other solution is to iterate over sorted QDict keys, as Peter says.
>

Thanks, I didn't notice the output changed so drastically. The readline
completion suggestions are sorted, so I just assumed the parameters were
sorted too. I'll fix it up.


