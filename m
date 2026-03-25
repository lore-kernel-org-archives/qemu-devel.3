Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91894109C05B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 20:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5UZC-0000cO-3G; Wed, 25 Mar 2026 16:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5UZ9-0000bV-Ij
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 16:10:59 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5UZ6-0008HE-Fl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 16:10:59 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EAE855BD67;
 Wed, 25 Mar 2026 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774469454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tm1VqbbJmHcjS/G7kmxwNcYxzQxNsOWzN4KuB9eqpkI=;
 b=r+fiNmGJ2TyJ1Wbh/LetnoZMOPaaGrys1jYehL949tzbyAMVLN0iQpbTP5rXDhoEkMDRHc
 TYRszYLz7GkEaxGgDsTIViG9iA4GJS785cOu/0WSfOPqJDaWwIRw6LxSsAkz4HUNGzrG3I
 jJkEXbzVe+VkN0ZOarBtnp9QqRTzPeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774469454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tm1VqbbJmHcjS/G7kmxwNcYxzQxNsOWzN4KuB9eqpkI=;
 b=at9ly6eUQnCrbiMfkxJFMT0GVV5bEBo/N9g8FFHIItjhdUuSxJ/IPuzEwqrmjPmippd+Ec
 RwkJDhMe/2v6ClBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774469453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tm1VqbbJmHcjS/G7kmxwNcYxzQxNsOWzN4KuB9eqpkI=;
 b=kXBxW9w44cANdStZ2/3T2Gr2u8DY4pkDxOdB/4/9tUILSIakE1gGOUp2P9EhJb9/ZbIyy+
 KDlY2N/vyLFSP0ifEENs34yaw3Sro8wh3EyBbfi0tySYpiWdIuPg9l+DYvQyBCU2HMh3Sy
 Nokn0/0tHM1YN7z4BcjZnFLlJZQ7CZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774469453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tm1VqbbJmHcjS/G7kmxwNcYxzQxNsOWzN4KuB9eqpkI=;
 b=DmzcARBPHqJjawkBhCKXPEtBFE5hi7C9810MT2geoZMkBrvGCdvDeI1V9z/F4ShedAMr/R
 rBYJTRD0BI6kBCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 865334A0A2;
 Wed, 25 Mar 2026 20:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PxtdFU1BxGn6JgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 25 Mar 2026 20:10:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 00/17] migration: vmstate_save|load changes for
 peterx
In-Reply-To: <acQ61yMtzZPfLUAj@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <acQ61yMtzZPfLUAj@x1.local>
Date: Wed, 25 Mar 2026 17:10:51 -0300
Message-ID: <87mrzvk6us.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Tue, Mar 24, 2026 at 04:43:15PM -0300, Fabiano Rosas wrote:
>> Too much stuff to mention inline on the series, here's some patches on
>> top. Let me know what you think! Feel free to drop it all or
>> incorporate or whatever.
>> 
>> Based-on: [PATCH RFC 00/10] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
>> 20260317232332.15209-1-peterx@redhat.com
>> https://lore.kernel.org/r/20260317232332.15209-1-peterx@redhat.com
>> 
>> which is in turn based on https://gitlab.com/farosas/qemu/-/commits/migration-staging
>> 
>> I pushed it all to https://gitlab.com/farosas/qemu/-/commits/migration-rfc-auto-alloc
>> 
>> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2406278684
>> 
>> Fabiano Rosas (17):
>>   vmstate: fixup the use of AUTO_ALLOC flag
>>   vmstate: Remove vmstate_use_marker_field
>>   vmstate: Stop checking size for nullptr compression
>>   vmstate: Set error inside of vmstate_save_field_with_vmdesc
>>   vmstate: Remove vmdesc_loop
>>   vmstate: Put array of pointers code together
>>   vmstate: Create and save ptr marker in same function
>>   vmstate: Don't recompute size and n_elems in vmstate_size
>>   vmstate: Increase scope of vmstate_handle_alloc
>>   vmstate: Remove curr_elem_p
>>   vmstate: Introduce vmstate_first
>>   vmstate: Introduce vmstate_next
>>   vmstate: Drop VMS_ARRAY_OF_POINTER_AUTO_ALLOC
>>   vmstate: Move VMS_MUST_EXIST check
>>   vmstate: Invert exists check
>>   vmstate: Declare variables at the top
>>   vmstate: Reduce indentation levels
>
> Considering that this prior series may block the nvme series, I'll be
> slightly conservative on what to collect, but I'll collect as much as I can
> that makes me still feel confident when I repost; we'll see.
>

Sure, if there's anything you still find valuable but won't take for the
repost let me know and I can send a separate series on top if that's the
case.

