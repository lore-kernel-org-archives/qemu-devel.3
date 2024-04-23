Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F118C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 17:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzKOd-0006S9-24; Tue, 23 Apr 2024 13:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzKOa-0006Rl-Rr
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:57:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzKOX-0008RA-Fy
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:57:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3DA221D91;
 Tue, 23 Apr 2024 17:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713895043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Xm5RT+zsiGPnWCJeRdjH3khcWychiTR5ZN35NJGS0k=;
 b=YtTM8U4Y10yS0Dt66ZwQSwhJ9VM2KhG6YTH8pRFEEwCIeS6rlDsQetu3ItQ+CffvfgWle6
 mkYGnUJYUp8BRStH6a/c1cN28BtT9/8jZO/lPeiybrwM7ntcPkmfnQeBNnPzQ3Cb1J3zrn
 8u3EP9+l6NwJ8veE4kPgWaKVTYhmFj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713895043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Xm5RT+zsiGPnWCJeRdjH3khcWychiTR5ZN35NJGS0k=;
 b=bwp+dN3VbDaq/N4ywUZjutUdj0p+JHSdxsYjdjV8DjR789T3lFujPnXjUEuWIruis7Fwyy
 e3I4KuimAqBO68DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YtTM8U4Y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bwp+dN3V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713895043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Xm5RT+zsiGPnWCJeRdjH3khcWychiTR5ZN35NJGS0k=;
 b=YtTM8U4Y10yS0Dt66ZwQSwhJ9VM2KhG6YTH8pRFEEwCIeS6rlDsQetu3ItQ+CffvfgWle6
 mkYGnUJYUp8BRStH6a/c1cN28BtT9/8jZO/lPeiybrwM7ntcPkmfnQeBNnPzQ3Cb1J3zrn
 8u3EP9+l6NwJ8veE4kPgWaKVTYhmFj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713895043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Xm5RT+zsiGPnWCJeRdjH3khcWychiTR5ZN35NJGS0k=;
 b=bwp+dN3VbDaq/N4ywUZjutUdj0p+JHSdxsYjdjV8DjR789T3lFujPnXjUEuWIruis7Fwyy
 e3I4KuimAqBO68DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37CD613929;
 Tue, 23 Apr 2024 17:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n+6BO4L2J2a4OgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Apr 2024 17:57:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: Re: [PATCH 00/22] configs: switch boards to "default y"
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
Date: Tue, 23 Apr 2024 14:57:20 -0300
Message-ID: <87o7a0hshr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B3DA221D91
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Some boards, notably ARM boards that use TCG, are already using
> "default y".  This was done to remove TCG-only boards from
> a KVM-only build in commit 29d9efca16 (2023-04-26).
>
> This series converts all other boards to that, so that the requirements
> of each board are clearer in the Kconfig files.
>
> For now, the only such use is MIPS's 64-bit and endianness requirements.
> In the future, it will be possible to enable/disable boards based
> on the presence of required libraries, for example libfdt, or
> their deprecation status.
>
> There is an important difference in that Kconfig symbols for boards
> have to be enabled in a --without-default-devices build, similar to
> devices.

And how do we make that happen?

>
> Paolo
>
> Paolo Bonzini (22):
>   configs: list "implied" device groups in the default configs
>   alpha: switch boards to "default y"
>   arm: switch boards to "default y"
>   avr: switch boards to "default y"
>   cris: switch boards to "default y"
>   hppa: switch boards to "default y"
>   i386: switch boards to "default y"
>   loongarch: switch boards to "default y"
>   m68k: switch boards to "default y"
>   microblaze: switch boards to "default y"
>   meson: make target endianneess available to Kconfig
>   mips: switch boards to "default y"
>   nios2: switch boards to "default y"
>   openrisc: switch boards to "default y"
>   ppc: switch boards to "default y"
>   riscv: switch boards to "default y"
>   rx: switch boards to "default y"
>   s390x: switch boards to "default y"
>   sh4: switch boards to "default y"
>   sparc: switch boards to "default y"
>   tricore: switch boards to "default y"
>   xtensa: switch boards to "default y"
>
>  configs/devices/alpha-softmmu/default.mak     |  5 ++--
>  configs/devices/arm-softmmu/default.mak       |  5 +++-
>  configs/devices/avr-softmmu/default.mak       |  5 ++--
>  configs/devices/cris-softmmu/default.mak      |  5 ++--
>  configs/devices/hppa-softmmu/default.mak      |  5 ++--
>  configs/devices/i386-softmmu/default.mak      | 11 ++++---
>  .../devices/loongarch64-softmmu/default.mak   |  6 +++-
>  configs/devices/m68k-softmmu/default.mak      | 13 ++++----
>  .../devices/microblaze-softmmu/default.mak    |  9 +++---
>  configs/devices/mips-softmmu/common.mak       |  5 ++--
>  configs/devices/mips64-softmmu/default.mak    |  4 ++-
>  configs/devices/mips64el-softmmu/default.mak  | 10 ++++---
>  configs/devices/nios2-softmmu/default.mak     |  7 ++---
>  configs/devices/or1k-softmmu/default.mak      |  9 ++++--
>  configs/devices/ppc-softmmu/default.mak       | 30 +++++++++++--------
>  configs/devices/ppc64-softmmu/default.mak     |  8 ++---
>  configs/devices/riscv32-softmmu/default.mak   | 17 +++++------
>  configs/devices/riscv64-softmmu/default.mak   | 19 ++++++------
>  configs/devices/rx-softmmu/default.mak        |  3 +-
>  configs/devices/s390x-softmmu/default.mak     |  5 ++--
>  configs/devices/sh4-softmmu/default.mak       |  7 ++---
>  configs/devices/sparc-softmmu/default.mak     |  7 ++---
>  configs/devices/sparc64-softmmu/default.mak   |  7 ++---
>  configs/devices/tricore-softmmu/default.mak   |  7 +++--
>  configs/devices/xtensa-softmmu/default.mak    | 11 ++++---
>  meson.build                                   | 12 ++++----
>  hw/alpha/Kconfig                              |  2 ++
>  hw/arm/Kconfig                                |  2 ++
>  hw/avr/Kconfig                                |  3 ++
>  hw/cris/Kconfig                               |  2 ++
>  hw/hppa/Kconfig                               |  2 ++
>  hw/i386/Kconfig                               | 10 ++++++-
>  hw/loongarch/Kconfig                          |  2 ++
>  hw/m68k/Kconfig                               | 10 +++++++
>  hw/microblaze/Kconfig                         |  6 ++++
>  hw/mips/Kconfig                               | 12 ++++++++
>  hw/nios2/Kconfig                              |  9 +++---
>  hw/openrisc/Kconfig                           |  4 +++
>  hw/ppc/Kconfig                                | 26 ++++++++++++++++
>  hw/riscv/Kconfig                              | 14 +++++++++
>  hw/rx/Kconfig                                 |  2 ++
>  hw/s390x/Kconfig                              |  2 ++
>  hw/sh4/Kconfig                                |  4 +++
>  hw/sparc/Kconfig                              |  4 +++
>  hw/sparc64/Kconfig                            |  4 +++
>  hw/tricore/Kconfig                            |  4 +++
>  hw/xtensa/Kconfig                             |  6 ++++
>  target/Kconfig                                |  3 ++
>  target/i386/Kconfig                           |  1 +
>  target/ppc/Kconfig                            |  1 +
>  50 files changed, 252 insertions(+), 115 deletions(-)

