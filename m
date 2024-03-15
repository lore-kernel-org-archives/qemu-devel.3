Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5953AC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 18:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlBs4-0000y5-11; Fri, 15 Mar 2024 14:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rlBs2-0000xx-Gv
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 14:01:30 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rlBrm-00048P-W7
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 14:01:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BFF6F21BDC;
 Fri, 15 Mar 2024 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710525672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK1JdQUnefKLoBf+eOx6KSAZTu16t4nHN0wlMRjuxZg=;
 b=YennCYhhR1W7aE2UoG2lw5dFpLzHaxlm8d/8tVfjMmboqB1viKMoyWBmb1RWzKRfPqrIeR
 eIOYgZGAhulQpabChXErmHQpbFuImARs1o73fMS1n7x5jIPsi5OxChQ2DwqsgZks7m0J2u
 XT9nnfCOkzfhTo2332yLCF9KtwELr8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710525672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK1JdQUnefKLoBf+eOx6KSAZTu16t4nHN0wlMRjuxZg=;
 b=zV7cHG1m9bGFn84QNKMeKpJeK1fLMLvQmdSTi4gEe1sufjpP4P2iAadcdvP7rvpuGiWydS
 n2leS29jPz9QZZDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710525672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK1JdQUnefKLoBf+eOx6KSAZTu16t4nHN0wlMRjuxZg=;
 b=YennCYhhR1W7aE2UoG2lw5dFpLzHaxlm8d/8tVfjMmboqB1viKMoyWBmb1RWzKRfPqrIeR
 eIOYgZGAhulQpabChXErmHQpbFuImARs1o73fMS1n7x5jIPsi5OxChQ2DwqsgZks7m0J2u
 XT9nnfCOkzfhTo2332yLCF9KtwELr8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710525672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK1JdQUnefKLoBf+eOx6KSAZTu16t4nHN0wlMRjuxZg=;
 b=zV7cHG1m9bGFn84QNKMeKpJeK1fLMLvQmdSTi4gEe1sufjpP4P2iAadcdvP7rvpuGiWydS
 n2leS29jPz9QZZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A56113460;
 Fri, 15 Mar 2024 18:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Niw9BOiM9GWCBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Mar 2024 18:01:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [RFC PATCH v3 3/3] migration: Add fd to FileMigrationArgs
In-Reply-To: <ZfRxwml7m0DQVO2b@x1n>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-4-farosas@suse.de> <ZfQNDv--4BnN5zYx@redhat.com>
 <ZfRxwml7m0DQVO2b@x1n>
Date: Fri, 15 Mar 2024 15:01:09 -0300
Message-ID: <87y1aj74t6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YennCYhh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zV7cHG1m
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: BFF6F21BDC
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> [I queued patch 1-2 into -stable, leaving this patch for further
>  discussions]
>
> On Fri, Mar 15, 2024 at 08:55:42AM +0000, Daniel P. Berrang=C3=A9 wrote:
>> The 'file:' protocol eventually calls into qemu_open, and this
>> transparently allows for FD passing using /dev/fdset/NNN syntax
>> to pass in FDs.=20
>
> If it always use /dev/fdsets for files, does it mean that the newly added
> SOCKET_ADDRESS_TYPE_FD support on mapped-ram will never be used (so we can
> drop them)?

We already have SOCKET_ADDRESS_TYPE_FD + file since 8.2 when the
MigrationAddress was added. So this:

'channels': [ { 'channel-type': 'main',
                'addr': { 'transport': 'socket',
                'type': 'fd',
                'str': 'fdname' } } ]

works without multifd and without mapped-ram if the fd is a file or
socket.

So yes, you're correct, but given we already have this^ it would be
perhaps more confusing for users to allow it, but not allow the very
same JSON when multifd=3Dtrue, mapped-ram=3Dtrue.

That's the only reason I didn't propose reverting commit decdc76772
("migration/multifd: Add mapped-ram support to fd: URI").

For mapped-ram in libvirt, we'll definitely not use
SOCKET_ADDRESS_TYPE_FD (as in the JSON), because I don't think libvirt
supports the new API.

As for SOCKET_ADDRESS_TYPE_FD as in "fd:", we could use it when
direct-io is disabled. With direct-io, the fdset will be required.

>
> What about the old getfd?  Is it obsolete because it relies on monitor
> object?  Or maybe it's still in use?
>
> It would be greatly helpful if there can be a summary of how libvirt uses
> fd for migration purpose.
>
> Thanks,

