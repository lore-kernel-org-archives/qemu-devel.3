Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D374BFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIE18-000055-Go; Wed, 29 Apr 2026 19:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIE16-0008Vj-2e
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:08:28 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIE14-000335-By
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:08:27 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DF466A7C3;
 Wed, 29 Apr 2026 23:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777504104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqwuFbjZtygzHNj6Mm7EUCP56XvVySQTNRPVo15KQQw=;
 b=SKNUO9YlHItlKRQqhGqPfeDABKg2AAdUlsxIG49LVkeE7E9Vo+nG9Wn12Q6cGUBCEm4Ghd
 EkxAkk8uM/zWZZgY/RJI9+/YyPZw5jCrZpbfYrvOj/abwJbC5zRkOePNgHJ/2/OYrkSTPP
 x0TLw0FhransPoYtm7VnmNXrkHmwJHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777504104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqwuFbjZtygzHNj6Mm7EUCP56XvVySQTNRPVo15KQQw=;
 b=XqssBT980Zr35y/6VHPf2FEsPu3TA3IWnZLxVDJAqEzZqcI4jNHTp0gGf0sw3xxXBeLLqa
 b/YxjGhGyWm946CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SKNUO9Yl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XqssBT98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777504104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqwuFbjZtygzHNj6Mm7EUCP56XvVySQTNRPVo15KQQw=;
 b=SKNUO9YlHItlKRQqhGqPfeDABKg2AAdUlsxIG49LVkeE7E9Vo+nG9Wn12Q6cGUBCEm4Ghd
 EkxAkk8uM/zWZZgY/RJI9+/YyPZw5jCrZpbfYrvOj/abwJbC5zRkOePNgHJ/2/OYrkSTPP
 x0TLw0FhransPoYtm7VnmNXrkHmwJHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777504104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqwuFbjZtygzHNj6Mm7EUCP56XvVySQTNRPVo15KQQw=;
 b=XqssBT980Zr35y/6VHPf2FEsPu3TA3IWnZLxVDJAqEzZqcI4jNHTp0gGf0sw3xxXBeLLqa
 b/YxjGhGyWm946CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34C5D593B0;
 Wed, 29 Apr 2026 23:08:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rJfuAGiP8mnbZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 23:08:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini
 <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Darren Kenny
 <darren.kenny@oracle.com>, Laurent Vivier <lvivier@redhat.com>, Michael
 Roth <michael.roth@amd.com>, Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH v1 2/3] tests/qtest: Individual verbose switches
In-Reply-To: <afJ3GLYIcN9qeOyU@x1.local>
References: <20260429003130.15164-1-farosas@suse.de>
 <20260429003130.15164-3-farosas@suse.de> <afJ3GLYIcN9qeOyU@x1.local>
Date: Wed, 29 Apr 2026 20:08:22 -0300
Message-ID: <874iktqs9l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9DF466A7C3
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Tue, Apr 28, 2026 at 09:31:29PM -0300, Fabiano Rosas wrote:
>> Allow logging to be set for specific parts of QTest. Having a single
>> QTEST_LOG knob creates an output stream that is almost useless due to
>> spamming from some operations.
>> 
>> Add a backward-compatible way of selecting which parts will be made
>> verbose. Reuse the existing QTEST_LOG variable. The new options are:
>> 
>> QTEST_LOG=
>> fuzz - fuzz.c
>> qga - unit/test-qga.c
>> qmp - libqmp.c
>> qtest - QTest device, i.e. -qtest-log option
>> test - generic term for usage of all tests
>> 
>> E.g.:
>> 
>> QTEST_LOG=fuzz,qga,qmp,qtest,test
>>   equivalent to QTEST_LOG=1
>> 
>> QTEST_LOG=qmp,qtest
>>   enables logging of qmp operations from libqmp.c and logging of the
>>   qtest device.
>> 
>> QTEST_LOG=test,qmp
>>   enable test output and libqmp.c output.
>> 
>> QTEST_LOG=-qmp
>>   enable all output, except for libqmp.c
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Ohhh this is nice..
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> Some quick thoughts, doesn't need to do it immediately or at all: make the
> parsing of QTEST_LOG var only once might be nice (e.g. switch to flag for
> qtest_verbose()).  The other nitpick is would the word "test" too hard to
> guess for what it does?  Maybe "misc"?

I'd like to add an _env function, like we did with migration-test. So
all environment stuff is read once there and it's all kept in a single
structure that's exposed to the rest of the code. I see scary messages
in glib code about thread-unsafety of getenv, I would not be surprised
if they start to complain more about it. See my dbus-vmstate-series for
more on that.

About the "test" word, I don't mind changing, but I think "misc" is
worse. My intention long-term is actually to reduce the usage of
QTEST_LOG in tests directly. This should be only for "qtest modules" to
use internally (such as libqmp, libqos). Otherwise the notion of what
counts as verbose gets lost among all the test writers.

The usage in migration-test should be removed at some point. We had an
idea of implementing a filtering scheme like the iotests do, which would
do away with the need for redirecting QEMU's output to devnull.

