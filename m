Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51174D65525
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 20:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG2YJ-00052D-K7; Tue, 26 Nov 2024 15:52:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tG2YI-00051q-FH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 15:52:54 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tG2YG-0003QZ-W5
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 15:52:54 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D50A5210F7;
 Tue, 26 Nov 2024 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732654371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMYm9+/nJit6YuHsaLh0DrvhFvDZb67HMmyrDKS8pVw=;
 b=JL0DIXPFqQ3FWyA/l4krezl21EDOlmSdtXp9ysf3Ezis+Q/9i/uB5nsMWm5bGLzBmdGJ0y
 c4nOTtW6XMFA7PbCUJA2s4CvlNGKsc/XOvUsakbQC9q+kiv6qYVZ227+84U3rfh+hMoXXo
 7M2vwZk86msPBZUwonCTiVCsLrctTxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732654371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMYm9+/nJit6YuHsaLh0DrvhFvDZb67HMmyrDKS8pVw=;
 b=5Bdex0WTGcoobZLAEuqe2sLmrXXCyYHpDF844pcLRcLAfbKX9CjSCULtgeSu8YrPZYHsKA
 z3/Gw7Us5ou8F4AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732654370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMYm9+/nJit6YuHsaLh0DrvhFvDZb67HMmyrDKS8pVw=;
 b=Udn6aBcu+sREea2RIstqrHRbSC7uQRVy/v95GT3e2Mk/ZdDMlFC5OO4EmLfpnx3OHyA0qc
 mXkMu1tvRjt90Ybwv8p6Ud/klIRkkgq+pPmAk75kRu4fqPKcibglkQQYr/LVPEsU+84Wnh
 qjKMx+gmXgiCZUU3NP+H2WG5ydfTr1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732654370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMYm9+/nJit6YuHsaLh0DrvhFvDZb67HMmyrDKS8pVw=;
 b=Nds1CjSCZumEqf7IEa1VuylHUhhPxYWZRGckZaSCNJbf/sU3m9NpRYphydxMXPtthPVbk3
 l0fzs8SQpI9uoaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D7CA139AA;
 Tue, 26 Nov 2024 20:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EW4ICSI1RmcMcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 26 Nov 2024 20:52:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 16/24] migration/multifd: Send final SYNC only after
 device state is complete
In-Reply-To: <0b8131dc6107841969d254e88e9d6e14220f1ea5.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <0b8131dc6107841969d254e88e9d6e14220f1ea5.1731773021.git.maciej.szmigiero@oracle.com>
Date: Tue, 26 Nov 2024 17:52:47 -0300
Message-ID: <87mshln2e8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-2.90)[99.56%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Currently, ram_save_complete() sends a final SYNC multifd packet near this
> function end, after sending all of the remaining RAM data.
>
> On the receive side, this SYNC packet will cause multifd channel threads
> to block, waiting for the final sem_sync posting in
> multifd_recv_terminate_threads().
>
> However, multifd_recv_terminate_threads() won't be called until the
> migration is complete, which causes a problem if multifd channels are
> still required for transferring device state data after RAM transfer is
> complete but before finishing the migration process.
>
> Defer sending the final SYNC packet to the end of sending of
> post-switchover iterable data instead if device state transfer is possible.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

I wonder whether we could just defer the sync for the !device_state case
as well.


