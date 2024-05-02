Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FCAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2d8Y-0001iU-4A; Thu, 02 May 2024 16:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2d8Q-0001hn-C9
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:34:30 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2d8O-0004jI-8v
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:34:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65E671FD13;
 Thu,  2 May 2024 20:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714682065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60vLc/49QFY8fDwLLEXKxkWu/t+AAawSZXYUWozx5iw=;
 b=zswEemVNxEWMKjbN0SpcYZqZjlgpcBGUcfluwZSN5h7vEtr8Z4ZkKkCdmSaTRpu7n3Tvf9
 3fyNu3X+Rw7X4CHPSPGYeJf4iLWlNGmnosIH/ldWgqYQB95TJQTye0S+wS+dcs7eSQOl1+
 WahP18ByX2xXHaW0BrGBqLDQDH9nDKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714682065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60vLc/49QFY8fDwLLEXKxkWu/t+AAawSZXYUWozx5iw=;
 b=BDY85WIXRDJS4Oy0rCgklQtRzxd1lavBzbDg8zUM78uUS5SMWoDaVZ+oVRN5jXM0DZV6Do
 EGMHNXBJWEu/6TCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zswEemVN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BDY85WIX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714682065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60vLc/49QFY8fDwLLEXKxkWu/t+AAawSZXYUWozx5iw=;
 b=zswEemVNxEWMKjbN0SpcYZqZjlgpcBGUcfluwZSN5h7vEtr8Z4ZkKkCdmSaTRpu7n3Tvf9
 3fyNu3X+Rw7X4CHPSPGYeJf4iLWlNGmnosIH/ldWgqYQB95TJQTye0S+wS+dcs7eSQOl1+
 WahP18ByX2xXHaW0BrGBqLDQDH9nDKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714682065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60vLc/49QFY8fDwLLEXKxkWu/t+AAawSZXYUWozx5iw=;
 b=BDY85WIXRDJS4Oy0rCgklQtRzxd1lavBzbDg8zUM78uUS5SMWoDaVZ+oVRN5jXM0DZV6Do
 EGMHNXBJWEu/6TCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5EC113957;
 Thu,  2 May 2024 20:34:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sYDCJtD4M2ZUVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 May 2024 20:34:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 0/9] migration/mapped-ram: Add direct-io support
In-Reply-To: <ZjPxLLwtJL3ATUML@x1n>
References: <20240426142042.14573-1-farosas@suse.de> <ZjPxLLwtJL3ATUML@x1n>
Date: Thu, 02 May 2024 17:34:22 -0300
Message-ID: <87ikzwneb5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 65E671FD13
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

> On Fri, Apr 26, 2024 at 11:20:33AM -0300, Fabiano Rosas wrote:
>> If the user is not passing in a file name which QEMU can open at will,
>> we must then require that the user pass the two file descriptors with
>> the flags already properly set. We'll use the already existing fdset +
>> QMP add-fd infrastructure for this.
>
> Yes I remember such requirement that one extra fd is needed for direct-io,
> however today when I looked closer at the man page it looks like F_SETFL
> works with O_DIRECT too?
>
>        F_SETFL (int)
>               Set the file status flags to the value specified by arg.
>               File access mode (O_RDONLY, O_WRONLY, O_RDWR) and file
>               creation flags (i.e., O_CREAT, O_EXCL, O_NOCTTY, O_TRUNC) in
>               arg are ignored.  On Linux, this command can change only the
>               O_APPEND, O_ASYNC, O_DIRECT, O_NOATIME, and O_NONBLOCK flags.
>               It is not possible to change the O_DSYNC and O_SYNC flags;
>               see BUGS, below.
>
> ====8<====
> $ cat fcntl.c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <fcntl.h>
> #include <assert.h>
> #include <unistd.h>
>
> int main(void)
> {
>     int fd, newfd, ret, flags;
>
>     fd = open("test.txt", O_RDWR | O_CREAT, 0660);
>     assert(fd != -1);
>
>     flags = fcntl(fd, F_GETFL);
>     printf("old fd flags: 0x%x\n", flags);
>
>     newfd = dup(fd);
>     assert(newfd != -1);
>
>     flags = fcntl(newfd, F_GETFL);
>     printf("new fd flags: 0x%x\n", flags);
>
>     flags |= O_DIRECT;
>     ret = fcntl(newfd, F_SETFL, flags);
>
>     flags = fcntl(fd, F_GETFL);
>     printf("updated new flags: 0x%x\n", flags);
>     
>     return 0;
> }
> $ make fcntl
> cc     fcntl.c   -o fcntl
> $ ./fcntl 
> old fd flags: 0x8002
> new fd flags: 0x8002
> updated new flags: 0xc002
> ====8<====
>
> Perhaps I missed something important?

The dup()'ed file descriptor shares file status flags with the original
fd. Your code example proves just that. In the last two blocks you're
doing F_SETFL on the 'newfd' and then seeing the change take effect on
'fd'. That's what we don't want to happen.

