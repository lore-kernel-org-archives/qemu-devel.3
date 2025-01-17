Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563D1C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 20:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsZw-0004Yc-2i; Fri, 17 Jan 2025 15:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYsZu-0004XF-K5
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 15:04:26 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYsZt-0005I8-10
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 15:04:26 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 79ADE1F457;
 Fri, 17 Jan 2025 20:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737144262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0tJ8ib/tM9lXgRVySnVJvPGO0/4Yf6ZAA+UrKpfZ+8=;
 b=o/AjX7FK4Vpzpbme9rc0d20yYFSVVntz4hgOTJZWb9ypThdix8s/zhbpVs3AMV9iLdwly6
 70xAA3cNVkIaT+S/3k1gPnmXZMcmCRDqLtWBG0rIuf0PZHNrC68vwRqWe1hE7XzXWA5qYt
 wj5hA8gb0uNXb9pIvhE5EUDoY7Qe89w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737144262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0tJ8ib/tM9lXgRVySnVJvPGO0/4Yf6ZAA+UrKpfZ+8=;
 b=P8Od0wCQKMzRrbeK1RRLPgODdoQVT7lhMWzu6C4ZqZ5LG/lPO68GasT/vEaK3ZK3kvIOds
 FLO+/lEMN3RLktCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737144261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0tJ8ib/tM9lXgRVySnVJvPGO0/4Yf6ZAA+UrKpfZ+8=;
 b=UqXjlNBfivGZv9CsFhZqENwWbWLdVcIEtUGQ7LLHtuz0LjO6s2V3fR+kwqbEqxe2Vkbock
 5nfsljaQ6fmjUQsbFKZ/YalcZSXj5tvvrKXTDcpDDjoFDtsj9zIrD4aUdgX+8VVftKCi95
 gvp/AlvHCwTKf4WqARfXoCsGOEmKsUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737144261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0tJ8ib/tM9lXgRVySnVJvPGO0/4Yf6ZAA+UrKpfZ+8=;
 b=S8vAZ9ZDl0NhN9zuH/NRcJ/L1agr3cAEChC4497HUQHqzpRYTaZE9athuioHcjmrsnByVK
 KWWICwJpSPXSYFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2451139CB;
 Fri, 17 Jan 2025 20:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DO+xJ8S3imdjBgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 17 Jan 2025 20:04:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V7 24/24] migration: cpr-transfer documentation
In-Reply-To: <823cae1e-7553-4735-8aa6-21d6f1b81b14@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-25-git-send-email-steven.sistare@oracle.com>
 <87tt9xec2y.fsf@suse.de> <68bee183-ba2b-420c-b885-a6ba630f74fe@oracle.com>
 <87r051e9xb.fsf@suse.de> <19a1f016-981e-49ea-9ead-bc64f69fa0c1@oracle.com>
 <87o705dzvn.fsf@suse.de> <823cae1e-7553-4735-8aa6-21d6f1b81b14@oracle.com>
Date: Fri, 17 Jan 2025 17:04:18 -0300
Message-ID: <87ldv9dx6l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:mid,oracle.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, oracle.com:email,
 suse.de:mid]
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 1/17/2025 2:06 PM, Fabiano Rosas wrote:
>>   Steven Sistare <steven.sistare@oracle.com> writes:
>> 
>>> On 1/17/2025 10:29 AM, Fabiano Rosas wrote:
>>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>>
>>>>> On 1/17/2025 9:42 AM, Fabiano Rosas wrote:
>>>>>> Steve Sistare <steven.sistare@oracle.com> writes:
> [...]
>>>
>>> Thank-you for the simple example.  I reproduced the failure.
>>> To fix, add "-machine aux-ram-share=on -machine memory-backend=ram0"
>>> (The previous longer example had the former but lacked the latter).
>>> Without that, the volatile pc.ram region is still in the mix.
>> 
>> There you go, that kvm-tpr-opt message is almost always indicative of
>> user error. I think because it's the first vmstate to be loaded.
>> 
>> Nonetheless, we better update the documentation to:
>> 
>> -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m -4G \
>> -machine memory-backend=ram0 \
>> -machine aux-ram-share=on
>
> Agreed.  Will you squash it in to both examples?

Yep, no worries.

>
> - Steve

