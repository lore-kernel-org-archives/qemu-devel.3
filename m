Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63BAE7DF0F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzIk-0006BW-93; Mon, 02 Feb 2026 14:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmzIj-0006BG-5s
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 14:09:33 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmzIg-0005N9-Fj
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 14:09:32 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1B1E3E6C4;
 Mon,  2 Feb 2026 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770059368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cugcf8yqoyDIG0ibT9yBNsrlpDAL8g/ZkMrHEO5/JgM=;
 b=1mNZyFZLrZL5YxB7uzI3mvTobjrEHivep4jyt0cC7bNf8I3rZlU7LY+N6RxSSJAHAEOmBJ
 gzrAdufkiorzMx4BkAZaG6ySeP4cWPIW4MuGPZZsinhdEy0A5FHUXcXERdheelZbwFI49i
 lDMRnxTQIN7nvf0IOQMrPZFCdRLpviY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770059368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cugcf8yqoyDIG0ibT9yBNsrlpDAL8g/ZkMrHEO5/JgM=;
 b=CpSI1NKA6r1DOF/icFTvWz1F0Sn5rDfaKzUg0Y5CRCkNujmk3KmXg5T9L/79su4Wv+RbEj
 8PTzgEEz9ig66ZAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770059368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cugcf8yqoyDIG0ibT9yBNsrlpDAL8g/ZkMrHEO5/JgM=;
 b=1mNZyFZLrZL5YxB7uzI3mvTobjrEHivep4jyt0cC7bNf8I3rZlU7LY+N6RxSSJAHAEOmBJ
 gzrAdufkiorzMx4BkAZaG6ySeP4cWPIW4MuGPZZsinhdEy0A5FHUXcXERdheelZbwFI49i
 lDMRnxTQIN7nvf0IOQMrPZFCdRLpviY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770059368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cugcf8yqoyDIG0ibT9yBNsrlpDAL8g/ZkMrHEO5/JgM=;
 b=CpSI1NKA6r1DOF/icFTvWz1F0Sn5rDfaKzUg0Y5CRCkNujmk3KmXg5T9L/79su4Wv+RbEj
 8PTzgEEz9ig66ZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33B8B3EA62;
 Mon,  2 Feb 2026 19:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wTJTOWf2gGmSfAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 19:09:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Chao Liu <chao.liu.zevorn@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, Weiwei
 Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, Chao Liu
 <chao.liu.zevorn@gmail.com>
Subject: Re: [RFC PATCH v2 2/2] tests/qtest: Add RISC-V IOMMU bare-metal test
In-Reply-To: <7cc1e085432336463dd19e11212cda516b97a33e.1769678103.git.chao.liu.zevorn@gmail.com>
References: <cover.1769678103.git.chao.liu.zevorn@gmail.com>
 <7cc1e085432336463dd19e11212cda516b97a33e.1769678103.git.chao.liu.zevorn@gmail.com>
Date: Mon, 02 Feb 2026 16:09:25 -0300
Message-ID: <87sebjq7x6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,googlegroups.com,gmail.com];
 FREEMAIL_TO(0.00)[gmail.com,wdc.com,ventanamicro.com,dabbelt.com,linux.alibaba.com,redhat.com,phytium.com.cn];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Chao Liu <chao.liu.zevorn@gmail.com> writes:

> Add a qtest suite for the RISC-V IOMMU PCI device on the virt machine.
> The test exercises bare, S-stage, G-stage, and nested translation paths
> using iommu-testdev and the qos-riscv-iommu helpers.
>
> The test validates:
> - Device context (DC) configuration
> - SV39 page table walks for S-stage translation
> - SV39x4 page table walks for G-stage translation
> - Nested translation combining both stages
> - FCTL register constraints
>
> This provides regression coverage for the RISC-V IOMMU implementation
> without requiring a full guest OS boot.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>

...

> +static bool riscv_iommu_test_setup(RiscvIommuTestState *state)
> +{
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return false;
> +    }
> +
> +    state->qts = qtest_init("-machine virt,acpi=off "
> +                            "-cpu max -smp 1 -m 512 -net none "
> +                            "-device riscv-iommu-pci "
> +                            "-device iommu-testdev");
> +
> +    qpci_init_generic(&state->gbus, state->qts, NULL, false);
> +    riscv_config_qpci_bus(&state->gbus);
> +
> +    state->iommu_dev = find_riscv_iommu_pci(&state->gbus, &state->iommu_base);
> +    g_assert(state->iommu_dev);
> +
> +    state->testdev = find_iommu_testdev(&state->gbus, &state->testdev_bar);
> +    g_assert(state->testdev);
> +

These two will leak. Otherwise, looks good.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

