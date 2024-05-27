Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A02BC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBc0v-0007lF-7n; Mon, 27 May 2024 11:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sBc0u-0007kr-EV; Mon, 27 May 2024 11:11:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sBc0s-0007au-Oq; Mon, 27 May 2024 11:11:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 62D7221FB7;
 Mon, 27 May 2024 15:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716822708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxcypN/WX/DKx++otX0UJqQ0tJryPB6bDYSc2jGsa5Y=;
 b=KCtVWJmKQd5uW2vZQMk/++l0S3w51fj14s6f/NX4m25VpR0P3T4d3DI8hXuFjMWkp/Gi7z
 J47I1cMtDh/hs95Jvv7MC+iZnqORAs6e6B+zhfw7oXWaViLaMkHtkhSAWO+ioUkOfVgD9O
 XRyANBII/IzuFfo5Gmyphf8yACkRXCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716822708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxcypN/WX/DKx++otX0UJqQ0tJryPB6bDYSc2jGsa5Y=;
 b=dosT+BKsmvURWZ07EDzBa51hnIC1/8FtaaNDKCdC1XdJ2D/TlGe6Lmc6h65IUs6FpnxOMw
 GoID/lACPjNP8bBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KCtVWJmK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dosT+BKs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716822708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxcypN/WX/DKx++otX0UJqQ0tJryPB6bDYSc2jGsa5Y=;
 b=KCtVWJmKQd5uW2vZQMk/++l0S3w51fj14s6f/NX4m25VpR0P3T4d3DI8hXuFjMWkp/Gi7z
 J47I1cMtDh/hs95Jvv7MC+iZnqORAs6e6B+zhfw7oXWaViLaMkHtkhSAWO+ioUkOfVgD9O
 XRyANBII/IzuFfo5Gmyphf8yACkRXCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716822708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxcypN/WX/DKx++otX0UJqQ0tJryPB6bDYSc2jGsa5Y=;
 b=dosT+BKsmvURWZ07EDzBa51hnIC1/8FtaaNDKCdC1XdJ2D/TlGe6Lmc6h65IUs6FpnxOMw
 GoID/lACPjNP8bBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7E5513A6B;
 Mon, 27 May 2024 15:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q6NAJ7OiVGbzPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 May 2024 15:11:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Yury Kotov <yury-kotov@yandex-team.ru>, "Dr . David
 Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC PATCH 3/3] tests/qtest/migration-test: Enable
 test_ignore_shared
In-Reply-To: <ZlSfNe6DhBgft79p@x1n>
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-4-npiggin@gmail.com> <87a5kbh1e3.fsf@suse.de>
 <ZlSfNe6DhBgft79p@x1n>
Date: Mon, 27 May 2024 12:11:45 -0300
Message-ID: <8734q3guha.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 62D7221FB7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.08 / 50.00]; BAYES_HAM(-2.57)[98.06%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,linux.ibm.com,redhat.com,yandex-team.ru];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Mon, May 27, 2024 at 09:42:28AM -0300, Fabiano Rosas wrote:
>> However, there is an issue here still on all archs - which might very
>> well have been the original issue - which is the fact that the
>> containers on the Gitlab CI have limits on shared memory usage.
>> Unfortunately we cannot enable this test for the CI, so it needs a check
>> on the GITLAB_CI environment variable.
>
> Another option is we teach migration-test to detect whether memory_size of
> shmem is available, skip if not.  It can be a sequence of:
>
>   memfd_create()
>   fallocate()
>   ret = madvise(MADV_POPULATE_WRITE)
>
> To be run at the entry of migration-test, and skip all use_shmem=true tests
> if ret != 0, or any step failed above.

There are actually two issues:

1) Trying to run a test that needs more shmem than available in the
container. This is covered well by your suggestion.

2) Trying to use some shmem while another test has already consumed all
shmem. I'm not sure if this can be done reliably as the tests run in
parallel.

