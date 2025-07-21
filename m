Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2839FC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 14:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udrWF-0003e6-FV; Mon, 21 Jul 2025 10:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udrVm-000354-Sb
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:29:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udrVg-0003sF-54
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:28:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 91A00219FC;
 Mon, 21 Jul 2025 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753108131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cmrfQBZn/1A0BhcEey5622fXZ7EmSctRCWTRuC299Co=;
 b=KyHesW8FfWPQ5RW54p2z1Lo6o5WJeKvKRUGN8BQvz1T0dykR6WSbNDDOLxSnHuvYOk4wOE
 eoAqoCrPIgtbx5wOmQj+jhv1MjHw5dcpfT7nO7eZ/CO6IXI2CWxrrZ6Vvr+4njz3Qw8ap3
 75mQlkF9wK4gCpanGfzqXQevDPMjRgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753108131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cmrfQBZn/1A0BhcEey5622fXZ7EmSctRCWTRuC299Co=;
 b=T0SvDTDsI4DuLxKYeCdMU3lz8dhVU/dfCk91auE7V+fLihgq10qk8GYzCKr41l+H6sggXU
 EJVZblEfS6/dDHCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753108131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cmrfQBZn/1A0BhcEey5622fXZ7EmSctRCWTRuC299Co=;
 b=KyHesW8FfWPQ5RW54p2z1Lo6o5WJeKvKRUGN8BQvz1T0dykR6WSbNDDOLxSnHuvYOk4wOE
 eoAqoCrPIgtbx5wOmQj+jhv1MjHw5dcpfT7nO7eZ/CO6IXI2CWxrrZ6Vvr+4njz3Qw8ap3
 75mQlkF9wK4gCpanGfzqXQevDPMjRgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753108131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cmrfQBZn/1A0BhcEey5622fXZ7EmSctRCWTRuC299Co=;
 b=T0SvDTDsI4DuLxKYeCdMU3lz8dhVU/dfCk91auE7V+fLihgq10qk8GYzCKr41l+H6sggXU
 EJVZblEfS6/dDHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C7FF13A88;
 Mon, 21 Jul 2025 14:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pg4+L6JOfmjwZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Jul 2025 14:28:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Prasad
 Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/3] migration: Fix possible access out of bounds
In-Reply-To: <20250716182648.30202-1-farosas@suse.de>
References: <20250716182648.30202-1-farosas@suse.de>
Date: Mon, 21 Jul 2025 11:28:48 -0300
Message-ID: <87ikjllisf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Fabiano Rosas <farosas@suse.de> writes:

> Fix the issue detected by Coverity in format_time_str() and move
> the function into the generic utils as suggested.
>
> v2:
> - Fix the incorrect loop condition.
> - Make the array static and fix argument name in signature.
>
> Fabiano Rosas (3):
>   migration: HMP: Fix possible out-of-bounds access
>   migration: HMP: Fix postcopy latency distribution label
>   cutils: Add time_us_to_str
>
>  include/qemu/cutils.h          |  1 +
>  migration/migration-hmp-cmds.c | 19 ++-----------------
>  util/cutils.c                  | 13 +++++++++++++
>  3 files changed, 16 insertions(+), 17 deletions(-)

Queued patches 1 & 2.

Patch 3 can go along with Daniel's suggestion of unifying all the
helpers that add string labels to a number.

