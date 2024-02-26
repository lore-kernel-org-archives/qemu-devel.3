Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA6AC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reb2L-0002On-IV; Mon, 26 Feb 2024 08:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1reb2K-0002Oc-1A
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:28:52 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1reb2I-0002Ha-Eu
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:28:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 876C81FB57;
 Mon, 26 Feb 2024 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708954128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ya0P5cejSYM7wTflZEDP27Od7KzdfRujqBUmMXlktPc=;
 b=hmxKTtgXc3PvksT0CS6msxh4sjAXOQeX28hBY1gmaVEyJnUGrkM+9rsHag5s8LnhOTXElg
 0QYZktRkbh1FU11rEQTzJmM5HYbQPDjZwf8HdlU1Iz9GvHJ9ec1SK+G063xIzB8PKrOOlA
 Vb/YLFyWjb3C7cRAWSHP639cN39mWqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708954128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ya0P5cejSYM7wTflZEDP27Od7KzdfRujqBUmMXlktPc=;
 b=Mfc6uHlJJs+aX2LGNxGFtA65m8IQTiP6SnBpIXkiDad2PXxVYO99WeO1HCIYv4d5g4V6Qn
 CMCoxz7PxXTVlMAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708954128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ya0P5cejSYM7wTflZEDP27Od7KzdfRujqBUmMXlktPc=;
 b=hmxKTtgXc3PvksT0CS6msxh4sjAXOQeX28hBY1gmaVEyJnUGrkM+9rsHag5s8LnhOTXElg
 0QYZktRkbh1FU11rEQTzJmM5HYbQPDjZwf8HdlU1Iz9GvHJ9ec1SK+G063xIzB8PKrOOlA
 Vb/YLFyWjb3C7cRAWSHP639cN39mWqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708954128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ya0P5cejSYM7wTflZEDP27Od7KzdfRujqBUmMXlktPc=;
 b=Mfc6uHlJJs+aX2LGNxGFtA65m8IQTiP6SnBpIXkiDad2PXxVYO99WeO1HCIYv4d5g4V6Qn
 CMCoxz7PxXTVlMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13FBB13A3A;
 Mon, 26 Feb 2024 13:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DusvMw+S3GVFXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Feb 2024 13:28:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 27/34] migration: Add direct-io parameter
In-Reply-To: <ZdxQ4fU4RivwMgWE@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-28-farosas@suse.de> <ZdxQ4fU4RivwMgWE@x1n>
Date: Mon, 26 Feb 2024 10:28:45 -0300
Message-ID: <878r37bbhu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hmxKTtgX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Mfc6uHlJ
X-Spamd-Result: default: False [-1.42 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-1.11)[88.31%];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 876C81FB57
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Tue, Feb 20, 2024 at 07:41:31PM -0300, Fabiano Rosas wrote:
>> Add the direct-io migration parameter that tells the migration code to
>> use O_DIRECT when opening the migration stream file whenever possible.
>> 
>> This is currently only used with the fixed-ram migration that has a
>> clear window guaranteed to perform aligned writes.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> I didn't read into this patch and followings yet.
>
> I think we have a discussion last time and the plan is we hopefully can
> merge part of fixed-ram already for 9.0 (March 12th softfreeze).
>
> I suggest we focus with the first 26 patches and land them first if
> possible.  If you agree then feel free to respin without direct-ios.  Then
> we can keep the discussions separate, and direct-ios can be concurrently
> discussed, but then posted as another patchset (with proper based-on:
> tags)?

Ok, I'll be working on the respin without direct-io.

Thanks

>
> Thanks,

