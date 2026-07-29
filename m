Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F2BC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6uq-0000pW-N7; Wed, 29 Jul 2026 12:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wp6uk-0000p0-Vt
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 12:13:52 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wp6ui-0007Km-KF
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 12:13:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0FB0F3DF5;
 Wed, 29 Jul 2026 16:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785341622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSXa2xhLiA3PfzXP449HBTT00t6D+sZUVhNhHbMOU1M=;
 b=005Mai4zBFqoHjGpGSVvrSYKjOISW1W7ROmazTs35+H5t+57X4WJqUNcIzDCWmQEraE0OM
 A3bM3YsJqLXcCkIGwPcTOqyQNPIpVh04cDl64GNNrRgc14FWUP1MyEyHu3YwN4nxUUxuEe
 AnVAt3Q35Y4+ttryKV0UgNBERtk0r68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785341622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSXa2xhLiA3PfzXP449HBTT00t6D+sZUVhNhHbMOU1M=;
 b=lOaL8fjxf/+QmCy5rIPNPWk//uGwwH7vT7RbeTOH508zznodbTkBFgje5JtoiC3RbrIKwi
 0pvfhEvwcLrF9lDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XLM2HHmn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KTUDjIeW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785341618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSXa2xhLiA3PfzXP449HBTT00t6D+sZUVhNhHbMOU1M=;
 b=XLM2HHmnjNw9uF1n+79baOgpEgfWM6mY+pZ0122YnERZRFUFYgusklaRqRy8PvKRFHHQn1
 lyjWqEpHOjUICt6AJNtzeMiHIwm4rESx9j8hOQG+rcvXjDorHV72oDAeUh5HAJVmmr2VhF
 tYFkUA3aAveYPRkEuVpwRKH9rIDl1PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785341618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSXa2xhLiA3PfzXP449HBTT00t6D+sZUVhNhHbMOU1M=;
 b=KTUDjIeWLpshzQ/GuM/WfGIE0+ZteD+wNijP5u2qb72aSk1gnbJrEgIRqnGC2cW1gp4cPl
 wCWQsgI6BOdC5QDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4169779A1;
 Wed, 29 Jul 2026 16:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1UwlHbEmamrdHwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jul 2026 16:13:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, =?utf-8?B?6rmA7Iq57KSR?=
 <seungjung0711@gmail.com>, Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
In-Reply-To: <amof2Vbn_nTHR5H9@x1.local>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de> <amoHbVsgzkYclCt2@x1.local>
 <878q6toopr.fsf@suse.de> <amof2Vbn_nTHR5H9@x1.local>
Date: Wed, 29 Jul 2026 13:13:27 -0300
Message-ID: <875x1xojtk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0FB0F3DF5
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,gmail.com,yandex-team.ru];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jul 29, 2026 at 11:27:44AM -0300, Fabiano Rosas wrote:
>> Hm, but isn't it better to have a global cap anyway? So we don't need
>> every device code to change with similar checks.
>> 
>> > If we go this route, I'd rather merge Michael's version to support u64,
>> > even if we don't need a u64 size.  But I really don't want to introduce yet
>> > another VMS flag just for this... we'll have no real use if we have noticed
>> > this problem when the vhost inflight patch was reviewed.  It will be a
>> > uint32_t or int32_t already.  I just can't come up with some users need
>> > size >2G.
>> >
>> 
>> I agree with making all u64. I think we can actually remove all the
>> extra VMS_VARRAY_* and VBUFFER_* flags and instead doa single type-check
>> of "int <= 64bit". Give me a couple of hours and I will post an RFC.
>
> I confess I don't yet get what is the global cap you mentioned.. but sure,
> I'll wait and read the RFC first.

I was thinking the vmstate code could define a limit to the size (of
anything) and always enforce it. The device code can then use some
custom macros (not yet existent) to limit even further.

