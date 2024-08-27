Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF334C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1rA-0001Cw-MV; Tue, 27 Aug 2024 15:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj1r3-0000xu-9S
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:27:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj1r1-00037H-K5
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:27:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 887A51FB85;
 Tue, 27 Aug 2024 19:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724786865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xmP7O7+DvFcHl4SYE92FwnBm6/iVVJX2kanx745/yE=;
 b=bebBscmp5jldVAC91pubTNlgRC6BZtMqxIoaDyh8uHM03mm1+a6oW2uv17ucfPQT7X9aoa
 wUjtxHa+HbtW+hEgVIEkHzxEBTpcQI5Irm1aFAU5+RwUOKsRtsDsXtrvQK6SesHvnGCct+
 OYlp2OrWB0OFdnwLvm6VEbhSdymA0LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724786865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xmP7O7+DvFcHl4SYE92FwnBm6/iVVJX2kanx745/yE=;
 b=LuWnffm1/a7q2nSRnRBA7iERdzGVNa7MpVLmBQ+6h+QMIS0PB7JOl1iULGM2ZxUMwO5ZDq
 AAsG3S1s939skIAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bebBscmp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LuWnffm1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724786865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xmP7O7+DvFcHl4SYE92FwnBm6/iVVJX2kanx745/yE=;
 b=bebBscmp5jldVAC91pubTNlgRC6BZtMqxIoaDyh8uHM03mm1+a6oW2uv17ucfPQT7X9aoa
 wUjtxHa+HbtW+hEgVIEkHzxEBTpcQI5Irm1aFAU5+RwUOKsRtsDsXtrvQK6SesHvnGCct+
 OYlp2OrWB0OFdnwLvm6VEbhSdymA0LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724786865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xmP7O7+DvFcHl4SYE92FwnBm6/iVVJX2kanx745/yE=;
 b=LuWnffm1/a7q2nSRnRBA7iERdzGVNa7MpVLmBQ+6h+QMIS0PB7JOl1iULGM2ZxUMwO5ZDq
 AAsG3S1s939skIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0425813724;
 Tue, 27 Aug 2024 19:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Lnb8LrAozmbNbgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Aug 2024 19:27:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v6 18/19] migration/multifd: Stop changing the packet on
 recv side
In-Reply-To: <Zs4jeFpSgp1osMn3@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-19-farosas@suse.de> <Zs4V8HajCAzNS3ZZ@x1n>
 <87plptx0so.fsf@suse.de> <Zs4jeFpSgp1osMn3@x1n>
Date: Tue, 27 Aug 2024 16:27:42 -0300
Message-ID: <87h6b5wytt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 887A51FB85
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Aug 27, 2024 at 03:45:11PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Aug 27, 2024 at 02:46:05PM -0300, Fabiano Rosas wrote:
>> >> @@ -254,12 +250,10 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>> >>          return 0;
>> >>      }
>> >>  
>> >> -    /* make sure that ramblock is 0 terminated */
>> >> -    packet->ramblock[255] = 0;
>> >> -    p->block = qemu_ram_block_by_name(packet->ramblock);
>> >> +    ramblock_name = g_strndup(packet->ramblock, 255);
>> >
>> > I understand we want to move to a const*, however this introduces a 256B
>> > allocation per multifd packet, which we definitely want to avoid.. I wonder
>> > whether that's worthwhile just to make it const. :-(
>> >
>> > I don't worry too much on the const* and vars pointed being abused /
>> > updated when without it - the packet struct is pretty much limited only to
>> > be referenced in this unfill function, and then we will do the load based
>> > on MultiFDRecvParams* later anyway.  So personally I'd rather lose the
>> > const* v.s. one allocation.
>> >
>> > Or we could also sanity check byte 255 to be '\0' (which, AFAIU, should
>> > always be the case..), then we can get both benefits.
>> 
>> We can't because it breaks compat. Previous QEMUs didn't zero the
>> packet.
>
> Ouch!
>
> Then.. shall we still try to avoid the allocation?

Can I strcpy it to the stack?

char idstr[256];

strncpy(&idstr, packet->ramblock, 256);
idstr[255] = 0;

