Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F40C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmIy-0005m5-LO; Thu, 13 Mar 2025 13:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tsmIv-0005kt-An
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:25:09 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tsmIq-0008V1-JS
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:25:08 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6AA02116E;
 Thu, 13 Mar 2025 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741886701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJve770nDPFh2HCH1ykBnGeheySshzoPb3XMGNBe72o=;
 b=mn7svxwQr/SgcfppYqXfFQwDK/RxjBOP3aWQ0Z5tEdVgSrTHV8hmqqdzaAYfJG+W19SmHX
 deUKnjlDP2ZqkkE9DyQi3jrP4CIHB1nZYgfGSkSsTD+S7iBibwRChTxqWIqCfnx8twbhjQ
 GavptTY+vfsQe5Gxyu0CEqfpkY4ejIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741886701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJve770nDPFh2HCH1ykBnGeheySshzoPb3XMGNBe72o=;
 b=k51icg+rYK5pGNwdAk9Cd/Z44KUk5IgNFlt2cNyTTy3F5B8IHpq/dcCs6WPleN1xam2oeD
 8cSyErkxvFE52xDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741886701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJve770nDPFh2HCH1ykBnGeheySshzoPb3XMGNBe72o=;
 b=mn7svxwQr/SgcfppYqXfFQwDK/RxjBOP3aWQ0Z5tEdVgSrTHV8hmqqdzaAYfJG+W19SmHX
 deUKnjlDP2ZqkkE9DyQi3jrP4CIHB1nZYgfGSkSsTD+S7iBibwRChTxqWIqCfnx8twbhjQ
 GavptTY+vfsQe5Gxyu0CEqfpkY4ejIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741886701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJve770nDPFh2HCH1ykBnGeheySshzoPb3XMGNBe72o=;
 b=k51icg+rYK5pGNwdAk9Cd/Z44KUk5IgNFlt2cNyTTy3F5B8IHpq/dcCs6WPleN1xam2oeD
 8cSyErkxvFE52xDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D3D9137BA;
 Thu, 13 Mar 2025 17:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iR+cOuwU02f1PwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Mar 2025 17:25:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Peter Xu
 <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 0/4] skip memory init during CPR
In-Reply-To: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
References: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
Date: Thu, 13 Mar 2025 14:24:58 -0300
Message-ID: <87bju4c07p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Fix bugs where the realize method re-initializes some memory regions during
> CPR.  See the individual commit messages for details.
>
> Steve Sistare (4):
>   migration: cpr_is_incoming
>   pflash: fix cpr
>   hw/loader: fix roms during cpr
>   hw/qxl: fix cpr
>
>  hw/block/block.c        |  5 +++++
>  hw/core/loader.c        |  5 ++++-
>  hw/display/qxl.c        | 27 ++++++++++++++++++++++++---
>  include/migration/cpr.h |  1 +
>  migration/cpr.c         |  5 +++++
>  5 files changed, 39 insertions(+), 4 deletions(-)

I'm queing this for the freeze to ensure people using CPR with qxl can
get a complete feature in 10.0. If anyone has concerns, please speak up.

