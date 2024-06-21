Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEE1C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdSq-0006KN-M0; Fri, 21 Jun 2024 08:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKdSn-0006JX-Av
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:33:57 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKdSj-00036P-Pu
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:33:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB57A21B0B;
 Fri, 21 Jun 2024 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718973231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y3dxlx3JSyPbJJp5AaJo21r+PJnZbrMfD8ke6R8dXOA=;
 b=PtTFUw2BI/1L0HyKJyYfKQTsH6WJiksbzYwin4f3Bae1xgCG/9l3pqz107skTwJ/HUmoUz
 ZFWyHkqNctgoeAbgUmptXJLLS4whuNllyqs97sHxPepFgkYh3KmAgcnuCqRc6XfvvyhNf7
 T041DIxXLZzWUkeNtWOpUecH3U7R97I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718973231;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y3dxlx3JSyPbJJp5AaJo21r+PJnZbrMfD8ke6R8dXOA=;
 b=W4XDtsi2gyUBGi0vD0tTLIfYE+Gs8jyoSBqA/OzbZt+UYT7+BHeKwImVF795vwpT0QmZHw
 VRevZj8SlD6s7BAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PtTFUw2B;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W4XDtsi2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718973231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y3dxlx3JSyPbJJp5AaJo21r+PJnZbrMfD8ke6R8dXOA=;
 b=PtTFUw2BI/1L0HyKJyYfKQTsH6WJiksbzYwin4f3Bae1xgCG/9l3pqz107skTwJ/HUmoUz
 ZFWyHkqNctgoeAbgUmptXJLLS4whuNllyqs97sHxPepFgkYh3KmAgcnuCqRc6XfvvyhNf7
 T041DIxXLZzWUkeNtWOpUecH3U7R97I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718973231;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y3dxlx3JSyPbJJp5AaJo21r+PJnZbrMfD8ke6R8dXOA=;
 b=W4XDtsi2gyUBGi0vD0tTLIfYE+Gs8jyoSBqA/OzbZt+UYT7+BHeKwImVF795vwpT0QmZHw
 VRevZj8SlD6s7BAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3501213ABD;
 Fri, 21 Jun 2024 12:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kOfUOi5zdWaYAQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 12:33:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 16/16] tests/qtest/migration: Add a test for
 mapped-ram with passing of fds
In-Reply-To: <ZnCOLGWajlKxtzfo@x1n>
References: <20240617185731.9725-1-farosas@suse.de>
 <20240617185731.9725-17-farosas@suse.de> <ZnCOLGWajlKxtzfo@x1n>
Date: Fri, 21 Jun 2024 09:33:48 -0300
Message-ID: <87y16yiifn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AB57A21B0B
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jun 17, 2024 at 03:57:31PM -0300, Fabiano Rosas wrote:
>> Add a multifd test for mapped-ram with passing of fds into QEMU. This
>> is how libvirt will consume the feature.
>> 
>> There are a couple of details to the fdset mechanism:
>> 
>> - multifd needs two distinct file descriptors (not duplicated with
>>   dup()) so it can enable O_DIRECT only on the channels that do
>>   aligned IO. The dup() system call creates file descriptors that
>>   share status flags, of which O_DIRECT is one.
>> 
>> - the open() access mode flags used for the fds passed into QEMU need
>>   to match the flags QEMU uses to open the file. Currently O_WRONLY
>>   for src and O_RDONLY for dst.
>> 
>> Note that fdset code goes under _WIN32 because fd passing is not
>> supported on Windows.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> - dropped Peter's r-b
>> 
>> - stopped removing the fdset at the end of the tests. The migration
>> code should always cleanup after itself.
>
> Ah, that looks also ok.

I made a mistake here. We still need to require that the management
layer explicitly removes the fds they added by calling qmp_remove_fd().

The reason I thought it was ok to not remove the fds was that after your
suggestion to use monitor_fdset_free_if_empty() in patch 7, I mistakenly
put monitor_fdset_free() instead. So the qmp_remove_fd() was not finding
any fdsets and I thought that was QEMU removing everything. Which is
silly, because the whole purpose of the patch is to not do that.

I think I'll just fix this in the migration tree. It's just a revert to
v2 of this patch and the correction to patch 7.

