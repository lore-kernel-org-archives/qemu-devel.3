Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F56FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHNj6-0006u4-BS; Mon, 27 Apr 2026 11:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHNj1-0006tb-I9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:18:19 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHNiz-00054f-T6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:18:19 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4235D6A924;
 Mon, 27 Apr 2026 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777303094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIvwTMrLNWmTYAWa+k/IWSUz2nESougvKJtzwtiKjMM=;
 b=XJnDcbj7UXnQEir1IA5dhhucU4DlPTGShXBz+RF9ACAb7s+ZlbZX72H1cltozqn36TxGbk
 +ejzN36fjKupc9fMfaKeZwMeGqH4Jbqxyv4FdyU0qRwIZW+kXUsaX/1dhV83Fd4XDeI2uO
 pFGoP8zS3SxY7ukzHxuN/LgnkmNdjdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777303094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIvwTMrLNWmTYAWa+k/IWSUz2nESougvKJtzwtiKjMM=;
 b=SQ4D+Yso7BgfddhUTy8ioqGkrGYWKwTs6+c0gQYUGr4RhTpKFQHB1BYA9V0EMyLRFFwdGt
 f39Vv2lA0wdjR+AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777303094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIvwTMrLNWmTYAWa+k/IWSUz2nESougvKJtzwtiKjMM=;
 b=XJnDcbj7UXnQEir1IA5dhhucU4DlPTGShXBz+RF9ACAb7s+ZlbZX72H1cltozqn36TxGbk
 +ejzN36fjKupc9fMfaKeZwMeGqH4Jbqxyv4FdyU0qRwIZW+kXUsaX/1dhV83Fd4XDeI2uO
 pFGoP8zS3SxY7ukzHxuN/LgnkmNdjdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777303094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIvwTMrLNWmTYAWa+k/IWSUz2nESougvKJtzwtiKjMM=;
 b=SQ4D+Yso7BgfddhUTy8ioqGkrGYWKwTs6+c0gQYUGr4RhTpKFQHB1BYA9V0EMyLRFFwdGt
 f39Vv2lA0wdjR+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3604593B0;
 Mon, 27 Apr 2026 15:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zYNWKDV+72nJSAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Apr 2026 15:18:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Elisey Konstantinov <elisey.konstantinov@gmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org, philmd@linaro.org
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
In-Reply-To: <6B7E6259-86A8-4CAB-8FFF-A406FA36F277@gmail.com>
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com>
 <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
 <aes4kEdQ_x8eI-m6@redhat.com>
 <4FFF1823-815E-4956-9C80-9C62A98033B0@gmail.com>
 <CAFEAcA_gX4N6YrhQBTi-YDvkafJXWEkkDU8Y9vz5nYce9OrHwQ@mail.gmail.com>
 <a4fd79f8-43fa-4894-80d3-ed31ffec1ff6@ilande.co.uk>
 <87a4usdmcp.fsf@suse.de> <6B7E6259-86A8-4CAB-8FFF-A406FA36F277@gmail.com>
Date: Mon, 27 Apr 2026 12:18:11 -0300
Message-ID: <87jytsig98.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

Elisey Konstantinov <elisey.konstantinov@gmail.com> writes:

> Oh, thanks for the feedback, however, could you please describe the envir=
onment you=E2=80=99re using?

x86_64 host running Linux kernel 6.4.0. QEMU configured with:

../configure
--target-list=3Dx86_64-softmmu,aarch64-softmmu,ppc64-softmmu,ppc-softmmu,s3=
90x-softmmu,riscv64-softmmu,aarch64-linux-user,mips64-softmmu
--disable-plugins --enable-modules --enable-werror --enable-debug --disable=
-docs

QEMU cmdline:

qemu-system-ppc -machine mac99 -boot d -d guest_errors,unimp,cpu_reset
-cdrom osx_100_4k78_install.iso -prom-env "boot-args=3D-v"

Connecting via VNC shows the machine runs up to and past the point shown
in the screenshot posted as the working example in:
https://gitlab.com/qemu-project/qemu/-/work_items/3276#note_3105980116

Clicking around, the VM seems functional.

