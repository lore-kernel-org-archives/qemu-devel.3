Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D428C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 11:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuUqv-0007aM-OU; Tue, 18 Mar 2025 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tuUqZ-0007TO-Tm
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:11:03 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tuUqY-0007uU-34
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:10:59 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4F2121F770;
 Tue, 18 Mar 2025 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742296256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Omb9fL9pYBVNmsBr/NUGlX2X/ezKCtai37AGxThYSk=;
 b=ZyoTSZcesFPDDHGhxDBLlrXJCZSxUN4gplIbngiR+/qxbQhfa7NZynhpWpPpb1fynjz+YP
 szyiJ1mlAziuH1aKrM+9jHzLZuXLGZDC85dJgZ2m4rVlK44t67mm/nr5eoF9O5hSrQB27y
 MLzbwsxe3X4m9C1S46CHkB2LnB3SpxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742296256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Omb9fL9pYBVNmsBr/NUGlX2X/ezKCtai37AGxThYSk=;
 b=cO2BuV+MLqrFuREJEEwO3KZE7Ek+IeoLVa63q692S4j2xBUbfff5OCT9Gd3yu+Zcs9G8Py
 AJg/N8Y1TI5zRADg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZyoTSZce;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cO2BuV+M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742296256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Omb9fL9pYBVNmsBr/NUGlX2X/ezKCtai37AGxThYSk=;
 b=ZyoTSZcesFPDDHGhxDBLlrXJCZSxUN4gplIbngiR+/qxbQhfa7NZynhpWpPpb1fynjz+YP
 szyiJ1mlAziuH1aKrM+9jHzLZuXLGZDC85dJgZ2m4rVlK44t67mm/nr5eoF9O5hSrQB27y
 MLzbwsxe3X4m9C1S46CHkB2LnB3SpxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742296256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Omb9fL9pYBVNmsBr/NUGlX2X/ezKCtai37AGxThYSk=;
 b=cO2BuV+MLqrFuREJEEwO3KZE7Ek+IeoLVa63q692S4j2xBUbfff5OCT9Gd3yu+Zcs9G8Py
 AJg/N8Y1TI5zRADg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 0C83B4A0561; Tue, 18 Mar 2025 12:10:56 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
In-Reply-To: <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de> (Helge Deller's
 message of "Tue, 18 Mar 2025 11:36:03 +0100")
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
Date: Tue, 18 Mar 2025 12:10:56 +0100
Message-ID: <mvmr02uh9vj.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [15.15 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_SPAM_SHORT(2.86)[0.952];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; RCVD_NO_TLS_LAST(0.10)[];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmx.de]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_ENVRCPT(0.00)[gmx.de]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 4F2121F770
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: +++++++++++++++
X-Spam: Yes
Received-SPF: pass client-ip=195.135.223.131; envelope-from=schwab@suse.de;
 helo=smtp-out2.suse.de
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

On Mär 18 2025, Helge Deller wrote:

> My current (unreliable) way to detect it is using uname.
> The kernel string and arch name don't match:
>
> (sid_hppa)root@paq:/# uname -a
> Linux paq 6.1.0-31-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.128-1 (2025-02-07) parisc GNU/Linux
>
> (sid_hppa)root@paq:/# uname -r
> 6.1.0-31-amd64
>
> (sid_hppa)root@paq:/# uname -m
> parisc
>
> This is a qemu-linux-user parisc(hppa) emulation running on x86-64.

That is highly distribution specific, by default the release part does
not contain anything arch specific.

For riscv the most reliable way is to look for "uarch *: qemu" in
/proc/cpuinfo.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

