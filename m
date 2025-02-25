Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1D6C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 13:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmuev-0001sE-4V; Tue, 25 Feb 2025 08:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tmuem-0001rl-SH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:07:28 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tmuek-00067i-0l
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:07:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A9272117A;
 Tue, 25 Feb 2025 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740488841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5JRHjMwKgVnWdYuTn9YhNKD9croLpiioVa3Js3CENqo=;
 b=mck5du3v4RW2hgK+N/M8WgOrfFxFSMwRby8xDbuNd67EJfFY2ujhSebR+7qMgXazrb5GQc
 5p4n0rxC1YbjMrrfmRp8L9hYDrIUMmilvzxnF/rmfpASs4p4QQ5ySPlmN65MgqUciaHuqK
 WbVq7C5y861UWurxdn17r5LA94M0fCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740488841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5JRHjMwKgVnWdYuTn9YhNKD9croLpiioVa3Js3CENqo=;
 b=IvipDMrYBvY+BI6qKqI7M/qoxaZiGX1llq6bwlxup6j0KzF9gTfQUHKilTsYKAfiZC/1Py
 eUIJsOcXMYuCh5Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mck5du3v;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IvipDMrY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740488841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5JRHjMwKgVnWdYuTn9YhNKD9croLpiioVa3Js3CENqo=;
 b=mck5du3v4RW2hgK+N/M8WgOrfFxFSMwRby8xDbuNd67EJfFY2ujhSebR+7qMgXazrb5GQc
 5p4n0rxC1YbjMrrfmRp8L9hYDrIUMmilvzxnF/rmfpASs4p4QQ5ySPlmN65MgqUciaHuqK
 WbVq7C5y861UWurxdn17r5LA94M0fCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740488841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5JRHjMwKgVnWdYuTn9YhNKD9croLpiioVa3Js3CENqo=;
 b=IvipDMrYBvY+BI6qKqI7M/qoxaZiGX1llq6bwlxup6j0KzF9gTfQUHKilTsYKAfiZC/1Py
 eUIJsOcXMYuCh5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9738D13332;
 Tue, 25 Feb 2025 13:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RSYcFYjAvWeJXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 25 Feb 2025 13:07:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v6 4/4] tests/qtest/migration: add postcopy tests with
 multifd
In-Reply-To: <CAE8KmOzNoMrpPjvTinVrcQ0VKbgFUyyRWWdHE02_HwU4dpjx=g@mail.gmail.com>
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-5-ppandit@redhat.com> <871pvwvb69.fsf@suse.de>
 <CAE8KmOzknFTcKnSp3iQwhV__e0_r-kJnXDy3x3zeyrohH5B6Tg@mail.gmail.com>
 <875xl79vjv.fsf@suse.de>
 <CAE8KmOzNoMrpPjvTinVrcQ0VKbgFUyyRWWdHE02_HwU4dpjx=g@mail.gmail.com>
Date: Tue, 25 Feb 2025 10:07:17 -0300
Message-ID: <875xkyyxyy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 2A9272117A
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Hello Fabiano,
>
> On Tue, 18 Feb 2025 at 19:58, Fabiano Rosas <farosas@suse.de> wrote:
>> >> > +static void test_multifd_postcopy_tcp_cancel(void)
>> >> > +{
>> >> > +    postcopy_ram = true;
>> >> > +    test_multifd_tcp_cancel();
>> >> > +    postcopy_ram = false;
>> >>
>> >> You could pass this in, there's just one other caller.
>>
>> To make postcopy_ram be passed in as an argument to
>> test_multifd_tcp_cancel(). Having globals tend to get in the way of
>> refactoring stuff later. We already had issues with tmpfs being global
>> all over the place.
>
> * This looks tricky to do. test_multifd_tcp_cancel() is called via
> migration_test_add(), which expects a function pointer of type => void
> (*fn)(void). Changing 'migration_test_add' signature would entail
> adding a parameter to all functions called by it.
>

Indeed. Leave it then. If I think of something I'll let you know.

> Thank you.
> ---
>   - Prasad

