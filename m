Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D22C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 22:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4R6A-0000TH-Bu; Wed, 09 Sep 2026 18:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x4R68-0000T0-Le; Wed, 09 Sep 2026 18:48:56 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x4R65-0006dK-VL; Wed, 09 Sep 2026 18:48:56 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 53D8621B76;
 Wed,  9 Sep 2026 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788994127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6BMmpOkR13YwIo/gvWLWo0DptDRoApxRPaxZwu52Kfc=;
 b=StGVojKCGOxmK9pewc65mtKCVPcJyYwXGOQut+ib7k2XiAsW0WON63bxPxeM6XNfM7fJW1
 D5A5ocNQirke5KwyzKtxn1jXmQPhIXYzSQIsyrQi0vIs4ik96YNOWpzo1pWfYDOWqtggv+
 lGIb7Fv4Jcze2zElB9GEhx+8mpUj1pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788994127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6BMmpOkR13YwIo/gvWLWo0DptDRoApxRPaxZwu52Kfc=;
 b=XLqYOErMdPeTdiaIrf3qSRphi67r3n1sohH/fq/ABSBGy1j0ZPxzgA1dDg5C2Gr8uF19yK
 EKyYY5Bw198fBnBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=twXs7Hcc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hgvm6wQS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788994123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6BMmpOkR13YwIo/gvWLWo0DptDRoApxRPaxZwu52Kfc=;
 b=twXs7HccUe61Yjv1N3W21wsJ+sxoXyoaqAPGgxJkXaq55Qa14/Mrh0WYGPQyz0untkZsis
 SSnb4b2CHey8GaQj22yvlRS6x2dUy1w1d0shYQeDu4cuDZrVFHcmxKXz4ZANDBaR7jxD8K
 Vib7/RBMTQ0maEDrMPr78IgxV5IlQbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788994123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6BMmpOkR13YwIo/gvWLWo0DptDRoApxRPaxZwu52Kfc=;
 b=hgvm6wQShCf3LwqBtsMcayqupf0XMwIB956ehoSnAdEL2nBpASd00CU6JeNcXwI1w8jmMN
 5/EUTuit2Ai4kVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD41713185;
 Wed,  9 Sep 2026 22:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 93BjH0rioWrMJQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Sep 2026 22:48:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 1/1] tests/qtest/ahci: fix a racy deadlock in the engine
 stop test
In-Reply-To: <20260830183534.104435-1-den@openvz.org>
References: <20260830183534.104435-1-den@openvz.org>
Date: Wed, 09 Sep 2026 19:48:40 -0300
Message-ID: <87fqzi6nxz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 53D8621B76
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:email, suse.de:mid]
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

"Denis V. Lunev" <den@openvz.org> writes:

> From: Denis V. Lunev <den@openvz.org>
>
> test_write_engine_stop_in_flight() resumes the suspended backend write
> and goes straight on to restart the command engine and read the second
> sector back. Whether the write has retired by then is a race. While it
> is still outstanding the drive is busy, and handle_cmd() drops a
> command that arrives in that state instead of queueing it. Nothing
> retries the drop, so the PxCI slot stays set and no D2H FIS is posted.
> ahci_command_wait() polls both with no timeout, so the test deadlocks
> until the harness kills it.
>
> Drain the port before issuing the read, so the abandoned write has
> retired and the engine is idle. Host load stretches the gap between the
> resume and the write completing, which is why the deadlock only shows
> up on a loaded machine.
>
> Fixes: d05ae87e7a6a ("tests/qtest/ahci: regression test for a PIO write vs. engine stop")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  tests/qtest/ahci-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index b143862ce7..2552fa39f1 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -1914,6 +1914,12 @@ static void test_write_engine_stop_in_flight(void)
>  
>      g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume wr\""));
>  
> +    /*
> +     * Retire the abandoned write. handle_cmd() drops a command that arrives
> +     * while the drive is still busy and nothing retries it.
> +     */
> +    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"aio_flush\""));
> +
>      /* Round-trip through the device to confirm qemu is still alive. */
>      ahci_px_rreg(ahci, port, AHCI_PX_TFD);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

