Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37ACCCD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slV9w-0003d1-Cu; Tue, 03 Sep 2024 11:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slV9t-0003c0-Au
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:09:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slV9r-0000zx-Om
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:09:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 118081F397;
 Tue,  3 Sep 2024 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725376166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3t+2khLuok8/MuRCDDjJ68e1sS1q7STeV0T3UgN1BzU=;
 b=j2VVMYSye5tmWxWYAkoPMfXYkH0JT4Zmy4gIYvDGzNa9i9Gqf7YHgeWXT5LnjuBH1oRLMX
 OeX/QV+Nf8e9euKL7r6b31ZQwuK658LbnqRYKv66yez+vmQhYTYNkTAEisNbZ0HQB8tb3y
 gWqqXqa1tepavrlYJuGEw5FsGz/fdOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725376166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3t+2khLuok8/MuRCDDjJ68e1sS1q7STeV0T3UgN1BzU=;
 b=PF5qc5voEKT114OHhxMyodw4IsXav0HJcw4sxFJ3Jp+VQHLeeS54ioZFPitbJUgr3Al8xO
 JNE/WB4l0ur3C5AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j2VVMYSy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PF5qc5vo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725376166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3t+2khLuok8/MuRCDDjJ68e1sS1q7STeV0T3UgN1BzU=;
 b=j2VVMYSye5tmWxWYAkoPMfXYkH0JT4Zmy4gIYvDGzNa9i9Gqf7YHgeWXT5LnjuBH1oRLMX
 OeX/QV+Nf8e9euKL7r6b31ZQwuK658LbnqRYKv66yez+vmQhYTYNkTAEisNbZ0HQB8tb3y
 gWqqXqa1tepavrlYJuGEw5FsGz/fdOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725376166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3t+2khLuok8/MuRCDDjJ68e1sS1q7STeV0T3UgN1BzU=;
 b=PF5qc5voEKT114OHhxMyodw4IsXav0HJcw4sxFJ3Jp+VQHLeeS54ioZFPitbJUgr3Al8xO
 JNE/WB4l0ur3C5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9025913A80;
 Tue,  3 Sep 2024 15:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EACTFaUm12aiaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Sep 2024 15:09:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Dan?=
 =?utf-8?Q?iel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Joao
 Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 13/17] migration/multifd: Add
 migration_has_device_state_support()
In-Reply-To: <4aaad112-5fdf-4172-bfb4-65dd7880202d@maciej.szmigiero.name>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <8407eb455dfc1dea3cabf065f90833fab337eb98.1724701542.git.maciej.szmigiero@oracle.com>
 <8734mlon65.fsf@suse.de>
 <4aaad112-5fdf-4172-bfb4-65dd7880202d@maciej.szmigiero.name>
Date: Tue, 03 Sep 2024 12:09:23 -0300
Message-ID: <87a5gon598.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 118081F397
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> On 30.08.2024 20:55, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>> 
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Since device state transfer via multifd channels requires multifd
>>> channels with packets and is currently not compatible with multifd
>>> compression add an appropriate query function so device can learn
>>> whether it can actually make use of it.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> 
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> 
>> Out of curiosity, what do you see as a blocker for migrating to a file?
>> 
>> We would just need to figure out a mapping from file offset some unit of
>> data to be able to write in parallel like with ram (of which the page
>> offset is mapped to the file offset).
>
> I'm not sure whether there's a point in that since VFIO devices
> just provide a raw device state stream - there's no way to know
> that some buffer is no longer needed because it consisted of
> dirty data that was completely overwritten by a later buffer.
>
> Also, the device type that the code was developed against - a (smart)
> NIC - has so large device state because (more or less) it keeps a lot
> of data about network connections passing / made through it.
>
> It doesn't really make sense to make snapshot of such device for later
> reload since these connections will be long dropped by their remote
> peers by this point.
>
> Such snapshotting might make more sense with GPU VFIO devices though.
>
> If such file migration support is desired at some later point then for
> sure the whole code would need to be carefully re-checked for implicit
> assumptions.

Thanks, let's keep those arguments in mind, maybe we put them in a doc
somewhere so we remember this in the future.

>
> Thanks,
> Maciej

