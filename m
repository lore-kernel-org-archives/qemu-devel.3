Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1C0CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNDn-0003Tc-MM; Mon, 27 Oct 2025 09:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vDNDg-0003Lm-9B
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:25:09 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vDNDb-0005fI-AW
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:25:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B10D021A4C;
 Mon, 27 Oct 2025 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761571492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oQY9wIeGo50SbrbL2UofGcRSyAhPslmt+OlhfG66gc8=;
 b=J7eWLtpYEjnAX9KEiKH2xlg4N4CdSBZJCPaCSPwZF8uweOK+/LF87fockk9rrMARNCKAJx
 dJJbk3fJv/z2bdy8PC5ExKIjwDir5SRcr4DLoO3dl63m97g9LqdCS/oyYkDmiAncF8ExI/
 S5fAs3njr7n0hT1gJD16OC987Dg8pmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761571492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oQY9wIeGo50SbrbL2UofGcRSyAhPslmt+OlhfG66gc8=;
 b=9mu+sHfjuvRcbwyuD/XuLvFX6OAbAkjbzH57rJFae5nbBvokInDG7aXsUew5SyT+U/4FBd
 1ueZG9qzn7GW2hAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761571492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oQY9wIeGo50SbrbL2UofGcRSyAhPslmt+OlhfG66gc8=;
 b=J7eWLtpYEjnAX9KEiKH2xlg4N4CdSBZJCPaCSPwZF8uweOK+/LF87fockk9rrMARNCKAJx
 dJJbk3fJv/z2bdy8PC5ExKIjwDir5SRcr4DLoO3dl63m97g9LqdCS/oyYkDmiAncF8ExI/
 S5fAs3njr7n0hT1gJD16OC987Dg8pmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761571492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oQY9wIeGo50SbrbL2UofGcRSyAhPslmt+OlhfG66gc8=;
 b=9mu+sHfjuvRcbwyuD/XuLvFX6OAbAkjbzH57rJFae5nbBvokInDG7aXsUew5SyT+U/4FBd
 1ueZG9qzn7GW2hAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CB70136CF;
 Mon, 27 Oct 2025 13:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ghKsN6Ny/2g/TQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Oct 2025 13:24:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, guobin@linux.alibaba.com
Subject: Re: [PATCH 0/3] migration: Cleanup around MigMode sets
In-Reply-To: <20251027064503.1074255-1-armbru@redhat.com>
References: <20251027064503.1074255-1-armbru@redhat.com>
Date: Mon, 27 Oct 2025 10:24:47 -0300
Message-ID: <877bwgeau8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.94%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster (3):
>   migration: Use unsigned instead of int for bit set of MigMode
>   migration: Use bitset of MigMode instead of variable arguments
>   migration: Put Error **errp parameter last
>
>  include/migration/blocker.h |  9 ++----
>  include/migration/misc.h    | 10 +++----
>  hw/vfio/container-legacy.c  |  6 ++--
>  hw/vfio/cpr-iommufd.c       |  6 ++--
>  hw/vfio/cpr-legacy.c        |  8 +++---
>  hw/vfio/cpr.c               |  5 ++--
>  hw/vfio/device.c            |  4 +--
>  migration/migration.c       | 57 +++++++++----------------------------
>  stubs/migr-blocker.c        |  2 +-
>  system/physmem.c            |  8 +++---
>  10 files changed, 40 insertions(+), 75 deletions(-)

Series:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

