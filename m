Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E61E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTNQN-0005i9-2L; Thu, 02 Jan 2025 10:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tTNQL-0005h6-3y; Thu, 02 Jan 2025 10:47:49 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tTNQI-00041j-GJ; Thu, 02 Jan 2025 10:47:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 605A31F38E;
 Thu,  2 Jan 2025 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735832861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzzTzugfY2cOu1CYxY5Exva4j1143V3xxTP+ZttxU9Y=;
 b=sbLc/cJdFzA0DNndjbTYEeMeirfFhZc8AsspjG56zyET4uSQMEtGDGH5XvgqFmD6Oyo8EZ
 ERiSiXQTxpsYwUNFnLcM7KnpiInsi/3RGBdAM3c8CZJpLk3LV5JKpmlkfziz1ORgPbrsYV
 4RmoWdNPc6DmT+pzyj85i+H9EJ4ff5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735832861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzzTzugfY2cOu1CYxY5Exva4j1143V3xxTP+ZttxU9Y=;
 b=p3HehVOoBZa/DAAC5e974qxr6PfYiPg8GIXzJWKuIThUe/LftAHrDbuulMLX4is/70iXB5
 psSF0Tf6s6prZZDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="sbLc/cJd";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p3HehVOo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735832861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzzTzugfY2cOu1CYxY5Exva4j1143V3xxTP+ZttxU9Y=;
 b=sbLc/cJdFzA0DNndjbTYEeMeirfFhZc8AsspjG56zyET4uSQMEtGDGH5XvgqFmD6Oyo8EZ
 ERiSiXQTxpsYwUNFnLcM7KnpiInsi/3RGBdAM3c8CZJpLk3LV5JKpmlkfziz1ORgPbrsYV
 4RmoWdNPc6DmT+pzyj85i+H9EJ4ff5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735832861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzzTzugfY2cOu1CYxY5Exva4j1143V3xxTP+ZttxU9Y=;
 b=p3HehVOoBZa/DAAC5e974qxr6PfYiPg8GIXzJWKuIThUe/LftAHrDbuulMLX4is/70iXB5
 psSF0Tf6s6prZZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3E5A132EA;
 Thu,  2 Jan 2025 15:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cUpXJRy1dme5JwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 Jan 2025 15:47:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, lvivier@redhat.com, pbonzini@redhat.com,
 Ivan Klokov <ivan.klokov@syntacore.com>
Subject: Re: [PATCH v8 0/2] Support RISC-V CSR read/write in Qtest environment
In-Reply-To: <20241225123718.45991-1-ivan.klokov@syntacore.com>
References: <20241225123718.45991-1-ivan.klokov@syntacore.com>
Date: Thu, 02 Jan 2025 12:47:38 -0300
Message-ID: <87ttah8bfp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 605A31F38E
X-Spamd-Result: default: False [-2.97 / 50.00]; BAYES_HAM(-2.96)[99.83%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,dabbelt.com,wdc.com,gmail.com,ventanamicro.com,linux.alibaba.com,redhat.com,syntacore.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Ivan Klokov <ivan.klokov@syntacore.com> writes:

> These patches add functionality for unit testing RISC-V-specific registers.
> The first patch adds a Qtest backend, and the second implements a simple test.
>
> ---
> v8:
>    - Delete RFC label.
> v7:
>    - Fix build errors, add Reviewed-by, Acked-by.
> ---
>
> Ivan Klokov (2):
>   target/riscv: Add RISC-V CSR qtest support
>   tests/qtest: QTest example for RISC-V CSR register
>
>  hw/riscv/riscv_hart.c        | 56 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqtest.c       | 27 +++++++++++++++++
>  tests/qtest/libqtest.h       | 14 +++++++++
>  tests/qtest/meson.build      |  2 +-
>  tests/qtest/riscv-csr-test.c | 56 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 154 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/riscv-csr-test.c

Hi, there are some CI jobs failing with this series, could you take a
look?

https://gitlab.com/farosas/qemu/-/pipelines/1609210965

