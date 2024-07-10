Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968F5C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 16:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRa4z-0004Kj-1r; Wed, 10 Jul 2024 12:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRa4w-0004FM-Sz; Wed, 10 Jul 2024 12:22:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRa4t-00020q-Va; Wed, 10 Jul 2024 12:22:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F08811F83C;
 Wed, 10 Jul 2024 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720628516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RIt9q3p6x1Kz3QuVNdguVQl8K7kOlu305zqd0XHCMtU=;
 b=ESkfFuhmuloMc2tLwFLU+zCpmE5LHNafa8erp+mpIXhpyy3Ex8uN72kx7i14Q5o/KSBSXa
 sGu7GYwSGCOq+uJos0988eeqX1wKiDWfCkvsgYHxbI01rJ7WdfySqHHTyS6eHy+wpN57/P
 CYTQawXlcO+IRbrEcVTtglzOxtpmXFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720628516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RIt9q3p6x1Kz3QuVNdguVQl8K7kOlu305zqd0XHCMtU=;
 b=9mSfjowY+5gfzAjsXNdFYOL8zUpNJp9AMrwWFD1FXfjopoRYxR1nLePPC4jJW19RRxoExI
 JevCY5e8nFT54qDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720628515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RIt9q3p6x1Kz3QuVNdguVQl8K7kOlu305zqd0XHCMtU=;
 b=QWR5prXJFCrt39Tli2ITQeBIEeDcNOT+k1W/IlKheyAdo+2E8eUL0vj3WK9xKRJrfDH77i
 S9AU8FEohz0ZdGos33lR7j+WN6JBSzeeug+cP79FWtr2klbhV/h3hlFXTGhghS+JUkSkau
 4th6EP+Gpl1m249smr5GG/5XKr0bjiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720628515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RIt9q3p6x1Kz3QuVNdguVQl8K7kOlu305zqd0XHCMtU=;
 b=ESzcnA5mozriFoqVpAqy2paogJzAXC2l9a4xT+t6B/WxKKdUswRphHYLDXkoCpvyq8EZTX
 NIZ2l4fDtaDlQIAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65E9F137D2;
 Wed, 10 Jul 2024 16:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1a0xCyK1jmYzYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Jul 2024 16:21:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Tyrone Ting
 <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>, Hao Wu
 <wuhaotsh@google.com>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-arm@nongnu.org, Joel
 Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>, =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 06/17] hw/sd/sdcard: Do not store vendor data on
 block drive (CMD56)
In-Reply-To: <Zo6iZjc8YpI1_9dW@x1n>
References: <20240627162232.80428-1-philmd@linaro.org>
 <20240627162232.80428-7-philmd@linaro.org> <87cynmfggx.fsf@suse.de>
 <Zo2lLLAwcZ8bBvO2@x1n> <87a5ipfigb.fsf@suse.de> <Zo6iZjc8YpI1_9dW@x1n>
Date: Wed, 10 Jul 2024 13:21:51 -0300
Message-ID: <874j8xfc9s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_TWELVE(0.00)[18];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[linaro.org,nongnu.org,redhat.com,nuvoton.com,gmail.com,google.com,amd.com,kaod.org,jms.id.au,lists.libvirt.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> On Wed, Jul 10, 2024 at 11:08:20AM -0300, Fabiano Rosas wrote:
>> >> I think it's ok:
>> >> 
>> >> {
>> >>   "field": "unused",
>> >>   "version_id": 1,
>> >>   "field_exists": false,
>> >>   "size": 512
>> >> },
>> >> 
>> >> vs.
>> >> 
>> >> {
>> >>   "field": "vendor_data",
>> >>   "version_id": 0,
>> >>   "field_exists": false,
>> >>   "num": 512,
>> >>   "size": 1
>> >> },
>> >> 
>> >> The unused field was introduced in 2016 so there's no chance of
>> >> migrating a QEMU that old to/from 9.1.
>> >
>> > What happens if an old qemu 9.0 sends rubbish here to a new QEMU, while the
>> > new QEMU would consider it meaningful data?
>> 
>> It will send zeros, no? The code will have to cope with that. The
>> alternative is to put the vendor_data in a subsection and the code will
>> also have to cope with the lack of data when the old QEMU doesn't send
>> it.
>
> Ah indeed, that "static const uint8_t buf[1024]" is there at least since
> 2017.  So yes, probably always sending zeros.

@Philippe, can vendor_data be 0 after migration? Otherwise 9.0 -> 9.1
migration might crash.

>
> Nothing I can think of otherwise indeed, if we want to trust that nothing
> will migrate before 2016.  It's just that we may want to know how that
> "2016" is justified to be safe if we would like to allow that in the
> future.

It's not about trust, we simply don't support migrations other than
n->n+1 and (maybe) n->n-1. So QEMU from 2016 is certainly not included.

>
> One thing _could_ be that "rule of thumb" is we plan to obsolete machines
> with 6 years, so anything "UNUSED" older than 6 years can be over-written?

