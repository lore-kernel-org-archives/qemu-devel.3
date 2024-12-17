Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155B3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 18:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNc4N-0003At-I0; Tue, 17 Dec 2024 13:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNc4M-0003AW-6t
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:13:18 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNc4J-0007Jt-RQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:13:17 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 345401F394
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734459193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhT1m5y4W5/KE8UD693WG+xW2SLn5J5lqLGqlixBFQs=;
 b=wIg0MZjIE8u03uMeaWWrL+Wa2EcY22JuyMQkaPlEt4jG++sd3UtYDdvA8gpLU4pdST1sU2
 r3HqQFxM7JA1iwaR/j3JdwUqpzXdDEaZazdBxQ49fqBMjsEL1lGVPNPRG3Bdoc6W5CbNfR
 7+AhdAYSQzuOEMQ9J6ArsqipdBgGugk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734459193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhT1m5y4W5/KE8UD693WG+xW2SLn5J5lqLGqlixBFQs=;
 b=hnaA80votmIOfVGeXCNKJlljc1Vp4LJO5FMWTzQq5TrAYcnD/E+apJsnfIDhbDHMnFdIcO
 lIksBU52Cqrs9iDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734459191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhT1m5y4W5/KE8UD693WG+xW2SLn5J5lqLGqlixBFQs=;
 b=UQb7KJzduq+J6K+qqMU+YMb8jTKjXXkb/mvXeh/A7keFFjs7V6E4FB2q7+9M+Ane4ivIdr
 WHtFkPKzvEUnhBnDCWAmTAdw0iap3nIBMsupdf5V2bU+yRjS+t9UzqOjUsozxV2TUITjw4
 /SPng2me4sXpri6y0wioT7WtPY5yHTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734459191;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhT1m5y4W5/KE8UD693WG+xW2SLn5J5lqLGqlixBFQs=;
 b=5DVpbrv1iAA8dpmMv+u3U86F0dri+FckliRd3sWCyixkHKjvb0rEAg3mQ3sxu/AdmdDnUJ
 zUpjqzIDJ4xZL4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACA4F13A3C
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 18:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KW2eHDa/YWetVwAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 18:13:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/6] qtest: Fix some memory issues
In-Reply-To: <20241209204427.17763-1-farosas@suse.de>
References: <20241209204427.17763-1-farosas@suse.de>
Date: Tue, 17 Dec 2024 15:13:07 -0300
Message-ID: <87r066uqj0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Fabiano Rosas <farosas@suse.de> writes:

> I'm trying to get the qtests to run with asan/valgrind without any
> warnings so I can run a test before every PR. Here are a few fixes.
>
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1580782506
>
> Fabiano Rosas (6):
>   tests/qtest/migration: Do proper cleanup in the dirty_limit test
>   tests/qtest/migration: Initialize buffer in probe_o_direct_support
>   tests/qtest/bios-tables-test: Free tables at dump_aml_files
>   tests/qtest/virtio-iommu-test: Don't pass uninitialized data into
>     qtest_memwrite
>   tests/qtest/qos-test: Plug a couple of leaks
>   tests/qtest/test-x86-cpuid-compat: Free allocated memory
>
>  tests/qtest/bios-tables-test.c      |  1 +
>  tests/qtest/migration-helpers.c     |  1 +
>  tests/qtest/migration-test.c        |  5 +++++
>  tests/qtest/qos-test.c              | 35 ++++++++++++++++++++---------
>  tests/qtest/test-x86-cpuid-compat.c |  4 ++++
>  tests/qtest/virtio-iommu-test.c     |  4 ++--
>  6 files changed, 38 insertions(+), 12 deletions(-)

Queuing 1-4 for qtest-next.

