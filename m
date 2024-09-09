Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93A1ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 21:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmLc-0001fq-0U; Mon, 09 Sep 2024 17:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1snmLX-0001cy-0y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:54:55 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1snmLV-0006jp-2w
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:54:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C743B1F7E8;
 Mon,  9 Sep 2024 21:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725918891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8U/FH3QP1N25Ma0EM1Oxc7l/mPd9m9svY0s8/JMFnM=;
 b=nrNmLLy/nNTvym8DHDV6dOUm7Xboq8L6EXk7YH7aj/r7gkpnw6ufUdwCcyzSTWEijiaKMk
 TxRLXLvITZ4P3sVejS+YRNNc91d7fzffO4NGkVnbJ7jOkeTNFBqkVsnkvVs9hoDUvT43TL
 HNi08iCqE/fUvNHeA1ComHoRV+KLwQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725918891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8U/FH3QP1N25Ma0EM1Oxc7l/mPd9m9svY0s8/JMFnM=;
 b=317Hr72065gm0YMXkOL+k/8nMezBbA3Q6DuxtBkOQQe4uESVjJhhQCTVYZwByaBvZNAL/H
 Df26pmi4ziLpXXBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ExjiHw1i;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u6ZDAYk9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725918889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8U/FH3QP1N25Ma0EM1Oxc7l/mPd9m9svY0s8/JMFnM=;
 b=ExjiHw1iWsTom3R0esOVb3hJH/TsOIm8ZZz6m5ecreEgUVqIzE2t7EaDLcdHxrmg6hGrLq
 HyiOe4vtzTY0SWX/mOzi7ybdm/oFshpMLMYpGyN8AW1ZW+AlsRe5yJrGHjIPSDu4Pf+tIn
 fHtxSJwfkL1Gyn36+HBBh/5ybGGTo1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725918889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8U/FH3QP1N25Ma0EM1Oxc7l/mPd9m9svY0s8/JMFnM=;
 b=u6ZDAYk9dpv02hknxiJ7FjKbkZygTUk/cz+aUHOVwX2CPe7KRFIy7Xa9yrIdJxZj9E1Jvk
 DB56+wwIFNAcGIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C74713312;
 Mon,  9 Sep 2024 21:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q8tUBalu32bdEwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Sep 2024 21:54:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, David
 Hildenbrand <david@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
In-Reply-To: <Zt8H6pC2yQ2DD7DV@x1n>
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n>
Date: Mon, 09 Sep 2024 18:54:46 -0300
Message-ID: <87frq8lcgp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C743B1F7E8
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, smartx.com:email, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

> On Mon, Sep 09, 2024 at 03:02:57PM +0100, Peter Maydell wrote:
>> On Mon, 9 Sept 2024 at 14:51, Hyman Huang <yong.huang@smartx.com> wrote:
>> >
>> > Despite the fact that the responsive CPU throttle is enabled,
>> > the dirty sync count may not always increase because this is
>> > an optimization that might not happen in any situation.
>> >
>> > This test case just making sure it doesn't interfere with any
>> > current functionality.
>> >
>> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>> 
>> tests/qtest/migration-test already runs 75 different
>> subtests, takes up a massive chunk of our "make check"
>> time, and is very commonly a "times out" test on some
>> of our CI jobs. It runs on five different guest CPU
>> architectures, each one of which takes between 2 and
>> 5 minutes to complete the full migration-test.
>> 
>> Do we really need to make it even bigger?
>
> I'll try to find some time in the next few weeks looking into this to see
> whether we can further shrink migration test times after previous attemps
> from Dan.  At least a low hanging fruit is we should indeed put some more
> tests into g_test_slow(), and this new test could also be a candidate (then
> we can run "-m slow" for migration PRs only).

I think we could (using -m slow or any other method) separate tests
that are generic enough that every CI run should benefit from them
vs. tests that are only useful once someone starts touching migration
code. I'd say very few in the former category and most of them in the
latter.

For an idea of where migration bugs lie, I took a look at what was
fixed since 2022:

# bugs | device/subsystem/arch
----------------------------------
    54 | migration
    10 | vfio
     6 | ppc
     3 | virtio-gpu
     2 | pcie_sriov, tpm_emulator,
          vdpa, virtio-rng-pci
     1 | arm, block, gpio, lasi,
          pci, s390, scsi-disk,
          virtio-mem, TCG

From these, ignoring the migration bugs, the migration-tests cover some
of: arm, ppc, s390, TCG. The device_opts[1] patch hasn't merged yet, but
once it is, then virtio-gpu would be covered and we could investigate
adding some of the others.

For actual migration code issues:

# bugs | (sub)subsystem | kind
----------------------------------------------
    13 | multifd        | correctness/races
     8 | ram            | correctness
     8 | rdma:          | general programming
     7 | qmp            | new api bugs
     5 | postcopy       | races
     4 | file:          | leaks
     3 | return path    | races
     3 | fd_cleanup     | races
     2 | savevm, aio/coroutines
     1 | xbzrle, colo, dirtyrate, exec:,
          windows, iochannel, qemufile,
          arch (ppc64le)

Here, the migration-tests cover well: multifd, ram, qmp, postcopy,
file, rp, fd_cleanup, iochannel, qemufile, xbzrle.

My suggestion is we run per arch:

"/precopy/tcp/plain"
"/precopy/tcp/tls/psk/match",
"/postcopy/plain"
"/postcopy/preempt/plain"
"/postcopy/preempt/recovery/plain"
"/multifd/tcp/plain/cancel"
"/multifd/tcp/uri/plain/none"

and x86 gets extra:

"/precopy/unix/suspend/live"
"/precopy/unix/suspend/notlive"
"/dirty_ring"

(the other dirty_* tests are too slow)

All the rest go behind a knob that people touching migration code will
enable.

wdyt?

1- allows adding devices to QEMU cmdline for migration-test
https://lore.kernel.org/r/20240523201922.28007-4-farosas@suse.de

