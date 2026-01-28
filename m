Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FA4D46BFA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlBkW-0000qZ-0J; Wed, 28 Jan 2026 15:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vlBkN-0000oe-2Z
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:02:40 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vlBkK-0004zB-RB
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:02:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C80075BCD1;
 Wed, 28 Jan 2026 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769630553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MACGkJeqBb/7DACv+Pw27/cTmbgXejHiNa64Y8sP1R8=;
 b=0XNzM4yZWb6j0luuXWoGpKtaf3aef0bzhnDkwfW0QLOt7eiKYEnyJjCJ7E6zz6mdFzwSlI
 oHMg3UjA6iw6jVpVTuoFC1r3+UQjyYfPmrfUM9n+gYpOIEazcNviG4mxoWvCKFAc+su4N0
 QPx+jLbmK2H2//Yq2XZz0vZkNCpGDF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769630553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MACGkJeqBb/7DACv+Pw27/cTmbgXejHiNa64Y8sP1R8=;
 b=y7HTYlFFihbZ+ge8JIE7Pq4IkCEi1oOUvPxM532CbmFLwQdhTauEfr2d/lwpoqieZ6m2BK
 1ei7eFqkYx5T9cAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0XNzM4yZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y7HTYlFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769630553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MACGkJeqBb/7DACv+Pw27/cTmbgXejHiNa64Y8sP1R8=;
 b=0XNzM4yZWb6j0luuXWoGpKtaf3aef0bzhnDkwfW0QLOt7eiKYEnyJjCJ7E6zz6mdFzwSlI
 oHMg3UjA6iw6jVpVTuoFC1r3+UQjyYfPmrfUM9n+gYpOIEazcNviG4mxoWvCKFAc+su4N0
 QPx+jLbmK2H2//Yq2XZz0vZkNCpGDF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769630553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MACGkJeqBb/7DACv+Pw27/cTmbgXejHiNa64Y8sP1R8=;
 b=y7HTYlFFihbZ+ge8JIE7Pq4IkCEi1oOUvPxM532CbmFLwQdhTauEfr2d/lwpoqieZ6m2BK
 1ei7eFqkYx5T9cAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E10B3EA61;
 Wed, 28 Jan 2026 20:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G8GRAFlremk8QAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 20:02:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang
 Chen <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Juan Quintela
 <quintela@trasno.org>
Subject: Re: [PATCH v3 04/10] multifd: Add COLO support
In-Reply-To: <aXoYfad-i-au-xpM@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
 <87ms20h2ae.fsf@suse.de> <20260126203358.0f8dc224@penguin>
 <878qdkgin8.fsf@suse.de> <aXkh0Sy9WUqi_3Rr@x1.local>
 <87v7glgbrz.fsf@suse.de> <aXoYfad-i-au-xpM@x1.local>
Date: Wed, 28 Jan 2026 17:02:30 -0300
Message-ID: <87jyx1eca1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[web.de,nongnu.org,redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,trasno.org];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C80075BCD1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jan 28, 2026 at 09:30:24AM -0300, Fabiano Rosas wrote:
>> >> >> > @@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> >> >> >          p->zero[i] = offset;
>> >> >> >      }
>> >> >> >  
>> >> >> > +    if (migrate_colo()) {
>> >> >> > +        multifd_colo_prepare_recv(p);
>> >> >> > +        assert(p->block->colo_cache);
>> >> >> > +        p->host = p->block->colo_cache;  
>> >> >> 
>> >> >> Can't you just use p->block->colo_cache later? I don't see why p->host
>> >> >> needs to be set beforehand even in the non-colo case.
>> >> >
>> >> > We should not touch the guest ram directly while in colo state, since
>> >> > the incoming guest is running and we either want to receive and apply a
>> >> > whole checkpoint with all ram into colo cache and all device state,
>> >> > or if anything goes wrong during checkpointing, keep the currently
>> >> > running guest on the incoming side in pristine state.
>> >> >
>> >> 
>> >> I was asking about setting p->host at this specific point. I don't think
>> >> any of this fits the unfill function. However, I see those were
>> >> suggested by Peter so let's not go back and forth.
>> >
>> > Actually I don't know why p->host existed before this work; IIUC we could
>> > have always used p->block->host.  Maybe when Juan was developing this Juan
>> > kept COLO in mind; or maybe Juan wanted to avoid frequent p->block pointer
>> > reference.
>> >
>> 
>> Maybe p->block was being reset at some point and p->host was passed
>> being the point where the (whatever) lock was release. I checked and
>> today there's no such thing. The p->mutex seems to be there just to
>> protect against this in multifd_recv_sync_main:
>> 
>> WITH_QEMU_LOCK_GUARD(&p->mutex) {
>>     if (multifd_recv_state->packet_num < p->packet_num) {
>>         multifd_recv_state->packet_num = p->packet_num;
>>     }
>> }
>
> It should be protected by various checks over migration_is_running().
>
> E.g., QMP device-add & device-del are forbidden so no new pc-dimm hotplug /
> removal allowed.  Similarly, virtio_mem_is_busy() would return true during
> migration too.
>
> We should definitely make sure ramblock will not be reset during the whole
> lifecycle of migration; I believe we're not ready for that..

The pointer reset, not the block. Anyway, it doesn't happen.

