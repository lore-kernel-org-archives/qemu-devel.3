Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB219D10362
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0lo-0000W0-HM; Tue, 25 Nov 2025 16:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vO0ln-0000TK-6Z
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:40:19 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vO0ll-0003qv-GD
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:40:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7EDD65BD11;
 Tue, 25 Nov 2025 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764106815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9caCpriWRMYRyfGm3fLLWjrexw5F2gwIzV+gu9E0xg=;
 b=XtHTcG1vL91XQjpU0KjrfYYQLxjZFGL4GmgZP30y2SKOdvQ1UTVHicFdqBygtryGCT388F
 ba1yPO0+5+wqLPf5HPZSVQDV+NZHgCfKaaSvGrP0/0zEBD1te9FtaG1pHrKuBD1fSQH3WH
 D9iPt9yjv2DEIl+UCjzgR6oGzi0b6H8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764106815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9caCpriWRMYRyfGm3fLLWjrexw5F2gwIzV+gu9E0xg=;
 b=HgUoR0K0y9xPBpFmRNhJcRHzHJIBy1GkoK6WbzA/3mlUd/VmiwaF3L1OK4jxZXYCbmRtzg
 KeZL0KWHJErVSRBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764106815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9caCpriWRMYRyfGm3fLLWjrexw5F2gwIzV+gu9E0xg=;
 b=XtHTcG1vL91XQjpU0KjrfYYQLxjZFGL4GmgZP30y2SKOdvQ1UTVHicFdqBygtryGCT388F
 ba1yPO0+5+wqLPf5HPZSVQDV+NZHgCfKaaSvGrP0/0zEBD1te9FtaG1pHrKuBD1fSQH3WH
 D9iPt9yjv2DEIl+UCjzgR6oGzi0b6H8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764106815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9caCpriWRMYRyfGm3fLLWjrexw5F2gwIzV+gu9E0xg=;
 b=HgUoR0K0y9xPBpFmRNhJcRHzHJIBy1GkoK6WbzA/3mlUd/VmiwaF3L1OK4jxZXYCbmRtzg
 KeZL0KWHJErVSRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFEB33EA63;
 Tue, 25 Nov 2025 21:40:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z6E7Kj4iJmkXBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 25 Nov 2025 21:40:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Pawel Zmarzly <pzmarzly0@gmail.com>
Cc: qemu-devel@nongnu.org, michel@michel-slm.name
Subject: Re: [PATCH] migration: fix parsing snapshots with x-ignore-shared flag
In-Reply-To: <aSYE_rdMhH36KBxf@x1.local>
References: <20251125174649.257457-1-pzmarzly0@gmail.com>
 <aSYE_rdMhH36KBxf@x1.local>
Date: Tue, 25 Nov 2025 18:40:12 -0300
Message-ID: <87tsyheqpv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[redhat.com,gmail.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Nov 25, 2025 at 05:46:49PM +0000, Pawel Zmarzly wrote:
>> Snapshots made with mapped-ram and x-ignore-shared flags are
>> not parsed properly.
>> 
>> Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
>> ---
>>  migration/ram.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 29f016cb25..85fdc810ab 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -4277,6 +4277,11 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
>>          id[len] = 0;
>>          length = qemu_get_be64(f);
>>  
>> +        if (migrate_ignore_shared()) {
>> +            /* Read and discard the x-ignore-shared memory region address */
>> +            qemu_get_be64(f);
>> +        }
>> +
>>          block = qemu_ram_block_by_name(id);
>>          if (block) {
>>              ret = parse_ramblock(f, block, length);
>> -- 
>> 2.52.0
>> 
>
> Thanks for the patch, though the u64 was parsed in parse_ramblock()
> instead.  Would you consider refactoring that function instead?

There's actually not much going on in terms of "parsing" in
parse_ramblock(). I think we could move the migrate_ignore_shared() from
the end of the function to before the mapped-ram check().

