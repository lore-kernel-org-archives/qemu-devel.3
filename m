Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBA6F46C40
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kXh-0006qt-6O; Mon, 06 Apr 2026 10:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w9kXe-0006qM-7m
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:03:02 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w9kXc-0003jo-D3
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:03:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8EC64DF1C;
 Mon,  6 Apr 2026 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775484178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1D9ZZAWMhuYberkTPUAj3hZ53JRnixMT6JeYMoRfAt4=;
 b=0ZAoo4UZH3X47uxjdxfCV4fzjr+1JRoM9JXVZk0ORDctb8szzCx1/ukz4m8Plkkpoa1ZKa
 clcbymIOUBZv8hS3i3k0rD3l4rtDjOEPPjIMNV6fkfIoXaHLHekwv4Bbr5rs7D4ueAOYKr
 C9g0jL7SGkZsspZCZPz8mWqkI+Ykw8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775484178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1D9ZZAWMhuYberkTPUAj3hZ53JRnixMT6JeYMoRfAt4=;
 b=nnlx9Sz8rnFnmdZrtPhiJtZVncupt/kzGDW2X0OqPp64pVAzDhvITw4bsUoOm32ReOjbxt
 bcb/xqo5BEXi23Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775484178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1D9ZZAWMhuYberkTPUAj3hZ53JRnixMT6JeYMoRfAt4=;
 b=0ZAoo4UZH3X47uxjdxfCV4fzjr+1JRoM9JXVZk0ORDctb8szzCx1/ukz4m8Plkkpoa1ZKa
 clcbymIOUBZv8hS3i3k0rD3l4rtDjOEPPjIMNV6fkfIoXaHLHekwv4Bbr5rs7D4ueAOYKr
 C9g0jL7SGkZsspZCZPz8mWqkI+Ykw8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775484178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1D9ZZAWMhuYberkTPUAj3hZ53JRnixMT6JeYMoRfAt4=;
 b=nnlx9Sz8rnFnmdZrtPhiJtZVncupt/kzGDW2X0OqPp64pVAzDhvITw4bsUoOm32ReOjbxt
 bcb/xqo5BEXi23Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CB724A0B0;
 Mon,  6 Apr 2026 14:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NbJhBhK902mqWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 06 Apr 2026 14:02:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Claudio Fontana <cfontana@suse.de>,
 Peter Xu <peterx@redhat.com>, Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
In-Reply-To: <20260405152612.93027-1-viking4@gmail.com>
References: <20260405152612.93027-1-viking4@gmail.com>
Date: Mon, 06 Apr 2026 11:02:56 -0300
Message-ID: <878qb05gq7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.de,redhat.com];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 gitlab.com:url]
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

Trieu Huynh <vikingtc4@gmail.com> writes:

> From: Trieu Huynh <vikingtc4@gmail.com>
>
> When query-migrate is called on the *destination* QEMU after a precopy
> migration completes it returns only {"status": "completed"} =E2=80=94 no =
timing,
> no RAM statistics.  The source correctly returns total-time, downtime,
> setup-time, and full ram stats.
>
> This series fixes the gap in two commits:
>
> * commit 1: Track start/end timestamps and per-page-type counters in
>   MigrationIncomingState, recorded in the receive path.
>
> * commit 2: Make source-only MigrationStats fields optional in the QAPI
>   schema so the destination can populate info->ram with only the fields
>   that are meaningful on the receive side.  Fields computed from tracked
>   counters (transferred, normal, duplicate, mbps, pages-per-second) are
>   shown; source-only fields (dirty-sync-count, precopy-bytes, etc.) are
>   absent.
>
> The QAPI change (commit 2) is ABI-compatible: optional fields that are
> not set are simply absent from the output.  Source-side callers are
> unaffected because populate_ram_info() sets all optional fields via
> has_* setters, so the source output is identical to before.
>
> On dst, {"execute":"query-migrate"}
> * As-is:
> {
>     "return": {
>         "status": "completed"
> }
> * To-be:
> {
>     "return": {
>         "status": "completed",
>         "total-time": 94,
>         "ram": {
>             "total": 554508288,
>             "pages-per-second": 1440234,
>             "page-size": 4096,
>             "remaining": 0,
>             "mbps": 97.955404255319152,
>             "transferred": 1150976,
>             "duplicate": 135101,
>             "normal-bytes": 1150976,
>             "normal": 281
>         }
>     }
> }
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3151
>
> Trieu Huynh (2):
>   migration: track timing and received pages in MigrationIncomingState
>   migration: expose RAM stats and timing on destination via
>     query-migrate
>
>  migration/migration.c | 37 +++++++++++++++++++++++++++++++++++++
>  migration/migration.h | 17 +++++++++++++++++
>  migration/ram.c       |  3 +++
>  qapi/migration.json   | 14 +++++++-------
>  4 files changed, 64 insertions(+), 7 deletions(-)

Hi, remember to copy the interested people in your series. Using
get_maintainers is correct, but when there's already a discussion about
the topic it's good to add some CCs manually.

+CC Daniel and Claudio

