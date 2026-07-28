Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7739C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonNA-0001IV-Sw; Tue, 28 Jul 2026 15:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonNA-0001IA-0O
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:21:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonN8-0007Sr-Az
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:21:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5199F7C17B;
 Tue, 28 Jul 2026 19:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785266383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F60Q1vQ3B4Ah8PotaI3Jxt6+2qAE0LYeLkWKlxL/dyI=;
 b=NFjeH+xuG2vEJTZKyQRFboHYbELvFolcPUgTprvbJ7+ZTOL/pS+3a7KEPJ9JkHfNlJ/BTt
 /2GKnLG9HTVyaiyMfxUztwaYkZnfOS8q06L9INmh78PphhWYcOsCB7uCLyeG+Em9nW1Idp
 2dT6Bu0+ys4yCmpk3OnH7L9oNRzY5ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785266383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F60Q1vQ3B4Ah8PotaI3Jxt6+2qAE0LYeLkWKlxL/dyI=;
 b=KvV9UYP5rc6dmKBF4dr1NTYHw9YjMPaamJmQUA+kNkgj3vOamAENBv0xOyAElhh0pfbKKg
 upPgKvp58mYF8rCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785266379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F60Q1vQ3B4Ah8PotaI3Jxt6+2qAE0LYeLkWKlxL/dyI=;
 b=j1Gtxn1W9UaHPDtDlZtrHToULJRyyvzQbudXtorM4y1CY3/vGXcHVQIMF3zX4v0c82Dn80
 Oey6kCSdqxeweLAbAGX5x4m9jrjS3TnCb74yaSlwlS1iWgzwjBumQqst89eH/cfwwqEXFT
 GkTATQB9hMqmqKruQKDCH7x9/JEC8M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785266379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F60Q1vQ3B4Ah8PotaI3Jxt6+2qAE0LYeLkWKlxL/dyI=;
 b=a0HgfEKa26LT5olcC/e7FvU5t4kb5s4p8110sKPayjUloGu85/lUJpV1nFz/DLRyERQusN
 xXKXOJIjy6Nxm0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E45E0779B1;
 Tue, 28 Jul 2026 19:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q0K0LMoAaWoxLAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jul 2026 19:19:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>, Feifan Qian
 <bea1e@proton.me>, qemu-stable <qemu-stable@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/5] migration: Fix possible overflow in
 vmstate_handle_alloc()
In-Reply-To: <20260728155247.1894355-2-peterx@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-2-peterx@redhat.com>
Date: Tue, 28 Jul 2026 16:19:32 -0300
Message-ID: <87zezaoraz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,suse.de:mid,suse.de:email]
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

> Migration incoming side almost always trusted the stream data and allows
> allocation to happen with whatever size received.  With it, malicious
> migration stream can manipulate destination QEMU behavior on g_malloc(), in
> path of vmstate_handle_alloc() on specific VMSD fields.  Fix it by limiting
> all sizes with int32_t positive values (INT_MAX) explicitly.
>
> We have quite a few bug reports recently leveraging this defect. It can be
> reproduced in many ways for (I think) all archs binaries, but the simplest
> reproducer is:
>
>   $ hexdump -C ./vm.img
>   00000000  51 45 56 4d 00 00 00 03  07 80 00 00 00 00 00 00  |QEVM............|
>
>   $ ./qemu-system-x86_64 -incoming file:./vm.img
>   VNC server running on ::1:5900
>   qemu-system-x86_64: GLib: ../glib/gmem.c:106: failed to allocate 18446744071562067968 bytes
>   Aborted                    (core dumped) ./qemu-system-x86_64 -incoming file:./vm.img
>
> We could assert here, but since we have errp right above the stack this
> patch routes the errp over to allow destination QEMU fail gracefully.  This
> means there's no way to DoS coredumpctl as well because we don't generate
> core dumps at all. The output message could also hopefully help triage
> issues when it's not a malicious stream but only wrong image used.
>
> When at this, making sure multiplex also won't overflow.
>
> After patched:
>
>   $ ./qemu-system-x86_64 -incoming file:./vm.img
>   VNC server running on ::1:5900
>   qemu-system-x86_64: load of migration failed: Invalid argument: vmstate_size: VMState field 'name' overflow
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3805
> Reported-by: Feifan Qian <bea1e@proton.me>
> Reported-by: dong ling (@dongling226655)
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

