Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92730C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcR3r-0001ck-M9; Mon, 27 Jan 2025 10:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcR3o-0001bN-Ut
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:30:01 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcR3j-0004Xl-IB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:30:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33F9021114;
 Mon, 27 Jan 2025 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737991794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wkDBAJxvCfp+daZyH1BjJ/hKooC6ZUqCKhatyx4HMXc=;
 b=u+z11hWYGKNiYKp+8xPri0uLLiGtbZXox5A/WQhkUeFxFzRKpyUYzayB/M/zUpRzfKnvHu
 ANF2ZiR2Kc/NPCIUbaBAC5naZO4NRMGOVvAOgXrHHhu5Ks3EF86YE11iyh31f/u5RpZUuP
 /n74qgkApqSldNhFqsAs/2LPNvnFF7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737991794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wkDBAJxvCfp+daZyH1BjJ/hKooC6ZUqCKhatyx4HMXc=;
 b=RcujxELHXGZTNE+n/wkyyQMv887gwQZ28/jO5mRuvntHC+XfNSkSYFs6L0PcgBVPLl0V6G
 XtsRAhhy3F02jxAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u+z11hWY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RcujxELH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737991794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wkDBAJxvCfp+daZyH1BjJ/hKooC6ZUqCKhatyx4HMXc=;
 b=u+z11hWYGKNiYKp+8xPri0uLLiGtbZXox5A/WQhkUeFxFzRKpyUYzayB/M/zUpRzfKnvHu
 ANF2ZiR2Kc/NPCIUbaBAC5naZO4NRMGOVvAOgXrHHhu5Ks3EF86YE11iyh31f/u5RpZUuP
 /n74qgkApqSldNhFqsAs/2LPNvnFF7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737991794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wkDBAJxvCfp+daZyH1BjJ/hKooC6ZUqCKhatyx4HMXc=;
 b=RcujxELHXGZTNE+n/wkyyQMv887gwQZ28/jO5mRuvntHC+XfNSkSYFs6L0PcgBVPLl0V6G
 XtsRAhhy3F02jxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98819137C0;
 Mon, 27 Jan 2025 15:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VjGpFXGml2dFagAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Jan 2025 15:29:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ani Sinha <anisinha@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 0/3] tests/qtest/libqos: add DMA support for writing
 and reading fw_cfg files
In-Reply-To: <20250120043847.954881-1-anisinha@redhat.com>
References: <20250120043847.954881-1-anisinha@redhat.com>
Date: Mon, 27 Jan 2025 12:29:50 -0300
Message-ID: <871pwos2a9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 33F9021114
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[gitlab.com:url,suse.de:email,suse.de:dkim,suse.de:mid,linaro.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,nongnu.org:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, nongnu.org:email, suse.de:email,
 suse.de:dkim, suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, linaro.org:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Ani Sinha <anisinha@redhat.com> writes:

> This patchset enables DMA interface support for writing fw-cfg files in
> libqtest. The first patch is just a code refactoring so that fw-cfg
> directory parsing can be part of a separate helper function.
> The second patch is the actual patch that introduces two new apis for
> writing and reading fw-cfg files using DMA interface. The apis are
> tested by writing a new basic qtest for vmcoreinfo device in patch 3.
>
> $ MALLOC_PERTURB_=255  QTEST_QEMU_BINARY=./qemu-system-x86_64  /workspace/qemu-ani/build/tests/qtest/vmcoreinfo-test
> TAP version 13
> # random seed: R02S33ea0ae4568aae69a6191a97e6ea37fc
> 1..1
> # Start of x86_64 tests
> # Start of vmcoreinfo tests
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-267380.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-267380.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -device vmcoreinfo -accel qtest
> ok 1 /x86_64/vmcoreinfo/basic-write
> # End of vmcoreinfo tests
> # End of x86_64 tests
>
> CI pipeline is green with this patch series: https://gitlab.com/anisinha/qemu/-/pipelines/1629670893
>
> checkpatch is clean:
>
> $ ./scripts/checkpatch.pl patches-v6/*
> Checking patches-v6/v6-0000-cover-letter.patch...
> total: 0 errors, 0 warnings, 0 lines checked
>
> patches-v6/v6-0000-cover-letter.patch has no obvious style problems and is ready for submission.
> Checking patches-v6/v6-0001-libqos-fw_cfg-refactor-file-directory-iteraton-to.patch...
> total: 0 errors, 0 warnings, 80 lines checked
>
> patches-v6/v6-0001-libqos-fw_cfg-refactor-file-directory-iteraton-to.patch has no obvious style problems and is ready for submission.
> Checking patches-v6/v6-0002-tests-qtest-libqos-add-DMA-support-for-writing-an.patch...
> total: 0 errors, 0 warnings, 175 lines checked
>
> patches-v6/v6-0002-tests-qtest-libqos-add-DMA-support-for-writing-an.patch has no obvious style problems and is ready for submission.
> Checking patches-v6/v6-0003-tests-qtest-vmcoreinfo-add-a-unit-test-to-exerciz.patch...
> total: 0 errors, 0 warnings, 111 lines checked
>
> patches-v6/v6-0003-tests-qtest-vmcoreinfo-add-a-unit-test-to-exerciz.patch has no obvious style problems and is ready for submission.
>
>
> cc: kraxel@redhat.com
> cc: farosas@suse.de
> cc: lvivier@redhat.com
> cc: pbonzini@redhat.com
> cc: armbru@redhat.com
> cc: philmd@linaro.org
> cc: berrange@redhat.com
> cc: qemu-devel@nongnu.org
> cc: farosas@suse.de

I'll give it the rest of the week and take this series via qtest-next
unless there's objections.

