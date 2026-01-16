Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D5EC982C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 22:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgrz8-0007Jk-C9; Fri, 16 Jan 2026 17:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vgrys-0007Fg-Ry
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:07:46 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vgryr-0008Pd-C6
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:07:46 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FBA25BCE0;
 Fri, 16 Jan 2026 22:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768601262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjORzk+LUco2iNUbw9NhyklFSAQKQE8GCe3cEAIOzD4=;
 b=WLduFtnGzq3VdiNMk/KUcapOZa0h1/iZquVpqexOzwOKCFXhXnOyYwzG/Y/mG392mu+Y1R
 zO0C0KFf8Z0KsZndIo4ChKCODpVmi9NXvEIFr7fbWmqcQTFFkfpfExezYITLdpeKJtZcyg
 PlfIvKCm4udKnjnG9+wmKNP7sIJ/lK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768601262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjORzk+LUco2iNUbw9NhyklFSAQKQE8GCe3cEAIOzD4=;
 b=Qz2XZKTETzgerZDSEvn0lrPOVnV/yUf0bp/sRIvzB1BrQbbFB890ZJpxtd9fDEJWcrfPWz
 n9QtmgcTgzx4QSDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768601262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjORzk+LUco2iNUbw9NhyklFSAQKQE8GCe3cEAIOzD4=;
 b=WLduFtnGzq3VdiNMk/KUcapOZa0h1/iZquVpqexOzwOKCFXhXnOyYwzG/Y/mG392mu+Y1R
 zO0C0KFf8Z0KsZndIo4ChKCODpVmi9NXvEIFr7fbWmqcQTFFkfpfExezYITLdpeKJtZcyg
 PlfIvKCm4udKnjnG9+wmKNP7sIJ/lK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768601262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjORzk+LUco2iNUbw9NhyklFSAQKQE8GCe3cEAIOzD4=;
 b=Qz2XZKTETzgerZDSEvn0lrPOVnV/yUf0bp/sRIvzB1BrQbbFB890ZJpxtd9fDEJWcrfPWz
 n9QtmgcTgzx4QSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 090B43EA63;
 Fri, 16 Jan 2026 22:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gO+pLq22amkhJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 16 Jan 2026 22:07:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: migration-stress tests
In-Reply-To: <CAFn=p-YHkDpE62N_gn0MAqDaLfuOxrj-5jt-MUDTvE=1ZopC_g@mail.gmail.com>
References: <CAFn=p-YHkDpE62N_gn0MAqDaLfuOxrj-5jt-MUDTvE=1ZopC_g@mail.gmail.com>
Date: Fri, 16 Jan 2026 19:07:39 -0300
Message-ID: <87h5slmct0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Heya folks:
>
> I'm working on a series that removes the qemu.qmp package from the
> qemu.git tree and notice that
> tests/migration-stress/guestperf/engine.py makes use of the
> QEMUMachine class (which depends on qemu.qmp) -- Can you please let me
> know which test(s) utilize this code so I can ensure that there are no
> disruptions to these tests after the pivot to utilizing an external
> library?
>
> If they aren't executed by "make check", could you please give me some
> instructions for how they are normally run?
>
> Thanks,
> --js

Hi!

This is a little benchmarking tool we have. You need to first build the
guest workload (might need to install a couple static libraries):

cd build
make ./tests/migration-stress/initrd-stress.img

Then:

./run ../tests/migration-stress/guestperf.py --debug --verbose --output
output.json

It starts a guest and migrates it, but with the --debug flag you'll
already see lots of qemu.qmp debug messages flying past.

Beware this is poorly maintained, I just checked it's working, but it
might bite you. Let's us know!

