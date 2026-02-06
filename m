Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07E3EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 19:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voRtI-00029I-5j; Fri, 06 Feb 2026 14:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voRtE-00025j-Bl
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 14:53:17 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voRtA-00061P-On
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 14:53:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 328313E6EA;
 Fri,  6 Feb 2026 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770407591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QR2M0g3AWdsmSVNCOdbUdON0vJRFw8bJrkxEUTYWT+0=;
 b=TUeqVFzLp5s7jaVDemniKkJ+lluQbAky4TJ1YfrPIzslJdcFpdhl6pd6MO7cwZVF9bwj7d
 RemHYuRhK4tlWeaCXEXIjRrKW1pozOUh6dQ3ewqZldPlq58M/2gDKw7rB9/AvEKcgnMYC0
 fsG/B0oXxY5LY6BTnS4aKwWSE1fLOhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770407591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QR2M0g3AWdsmSVNCOdbUdON0vJRFw8bJrkxEUTYWT+0=;
 b=Zz8plGsk1IiAfpiW5egln6e6Hc4AbolJipTaK9zBZj6v5n4C4lQRfrcLEoUJKfmOyQKbDV
 OKBBqoqDkKp9+nCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TUeqVFzL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zz8plGsk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770407591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QR2M0g3AWdsmSVNCOdbUdON0vJRFw8bJrkxEUTYWT+0=;
 b=TUeqVFzLp5s7jaVDemniKkJ+lluQbAky4TJ1YfrPIzslJdcFpdhl6pd6MO7cwZVF9bwj7d
 RemHYuRhK4tlWeaCXEXIjRrKW1pozOUh6dQ3ewqZldPlq58M/2gDKw7rB9/AvEKcgnMYC0
 fsG/B0oXxY5LY6BTnS4aKwWSE1fLOhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770407591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QR2M0g3AWdsmSVNCOdbUdON0vJRFw8bJrkxEUTYWT+0=;
 b=Zz8plGsk1IiAfpiW5egln6e6Hc4AbolJipTaK9zBZj6v5n4C4lQRfrcLEoUJKfmOyQKbDV
 OKBBqoqDkKp9+nCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 915043EA63;
 Fri,  6 Feb 2026 19:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d/XTE6ZGhmn7FgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Feb 2026 19:53:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: chao.liu.zevorn@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, Chao Liu
 <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v3 0/2] tests/qtest: Add RISC-V IOMMU bare-metal test
 using iommu-testdev
In-Reply-To: <cover.1770127918.git.chao.liu.zevorn@gmail.com>
References: <cover.1770127918.git.chao.liu.zevorn@gmail.com>
Date: Fri, 06 Feb 2026 16:53:07 -0300
Message-ID: <87y0l5bqe4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,wdc.com,ventanamicro.com,dabbelt.com,linux.alibaba.com,redhat.com,phytium.com.cn];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[13];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,googlegroups.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 328313E6EA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

chao.liu.zevorn@gmail.com writes:

> From: Chao Liu <chao.liu.zevorn@gmail.com>
>
> Hi,
>
> This patch series adds a bare-metal qtest for the RISC-V IOMMU using the
> iommu-testdev framework. The test exercises address translation paths
> without requiring a full guest OS boot.
>
> Motivation
> ----------
>
> The existing RISC-V IOMMU qtest (riscv-iommu-test.c) focuses on PCI device
> enumeration and register-level validation:
> - PCI configuration space verification (vendor/device ID)
> - Register reset value checks
> - Queue initialization procedures (CQ/FQ/PQ)
>
> However, it does not test the actual address translation functionality.
> This new test fills that gap by using iommu-testdev to trigger DMA
> transactions and validate the IOMMU's translation logic.
>
> Comparison with Existing Test
> -----------------------------
>
> | Feature               | riscv-iommu-test.c | iommu-riscv-test.c (new) |
> |-----------------------|--------------------|--------------------------|
> | PCI config            | Yes                | No                       |
> | Register reset        | Yes                | No                       |
> | Queue init            | Yes                | Yes (via helper)         |
> | Bare translation      | No                 | Yes                      |
> | S-stage (SV39)        | No                 | Yes                      |
> | G-stage (SV39x4)      | No                 | Yes                      |
> | Nested translation    | No                 | Yes                      |
> | DMA verification      | No                 | Yes                      |
> | Uses iommu-testdev    | No                 | Yes                      |
>
> The new test provides:
> - Device context (DC) configuration and validation
> - SV39 page table walks for S-stage translation
> - SV39x4 page table walks for G-stage translation
> - Nested translation combining both stages
> - FCTL register constraint validation
> - End-to-end DMA verification
>
> Note: The current implementation only supports SV39/SV39x4. Support for
> SV48/SV48x4/SV57/SV57x4 can be added in future patches.
>
> Testing
> -------
>
> QTEST_QEMU_BINARY=./build/qemu-system-riscv64 \
>   ./build/tests/qtest/iommu-riscv-test --tap -k
>
> Changes v2 -> v3
> ----------------
> - Removed duplicate header includes in both patches (Tao)
> - Fixed memory leak of state->iommu_dev and state->testdev in
>   riscv_iommu_test_setup() in patch 2 (Fabiano)
>
> Changes v1 -> v2
> ----------------
> - Removed unused 'mode' parameter from qriommu_get_pte_attrs() function
> - Simplified PTE mask definitions in header file by using direct hex
>   values instead of individual bit defines (removed QRIOMMU_PTE_V/R/W/X
>   /U/G/A/D macros), added comment referencing target/riscv/cpu_bits.h
> - Cleaned up variable declarations in qriommu_setup_translation_tables()
>   to follow C99 style (declare at point of use)
> - Minor code style improvements
>
> Thanks,
> Chao
>
> Chao Liu (2):
>   tests/qtest/libqos: Add RISC-V IOMMU helper library
>   tests/qtest: Add RISC-V IOMMU bare-metal test
>
>  MAINTAINERS                          |   2 +
>  tests/qtest/iommu-riscv-test.c       | 279 +++++++++++++++++++
>  tests/qtest/libqos/meson.build       |   2 +-
>  tests/qtest/libqos/qos-riscv-iommu.c | 403 +++++++++++++++++++++++++++
>  tests/qtest/libqos/qos-riscv-iommu.h | 164 +++++++++++
>  tests/qtest/meson.build              |   5 +-
>  6 files changed, 853 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/iommu-riscv-test.c
>  create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
>  create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h

I'm queuing this, but if riscv folks want to pull it, it's fine as well.

