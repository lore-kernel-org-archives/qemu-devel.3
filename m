Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36291C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj18t-0003qU-4x; Mon, 04 Aug 2025 15:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uj0qg-0004kw-QC
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:27:56 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uj0qc-0002cU-Ey
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:27:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D679211EF;
 Mon,  4 Aug 2025 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754335668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeR66d6NwlOi9pjH2LSwhv0i6WD5hOD6OKRFWYA2B0A=;
 b=EZnnBkvxduMtj/8xWry6WOTf+fBa4bzX/nzuXAePUm3EzlkT1a8hXWIqlPXRXZyvL0UOtU
 BQC22P4nj+URkFLAXnAMpZANU/fWdZCeaWZArOP5HUVJBlZPfxrOPTu6UiGMUowYgEboor
 lNshmO4BDcndySbzqaegHn/AKu/Vmlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754335668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeR66d6NwlOi9pjH2LSwhv0i6WD5hOD6OKRFWYA2B0A=;
 b=cu5D8VHXS4Us+pNw0jxLNKG9k3CumfwgVmydJ4UN7YQepbTC4sDnP/h5N2li3q098D68tH
 bHOUhV9cFG2kckDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754335668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeR66d6NwlOi9pjH2LSwhv0i6WD5hOD6OKRFWYA2B0A=;
 b=EZnnBkvxduMtj/8xWry6WOTf+fBa4bzX/nzuXAePUm3EzlkT1a8hXWIqlPXRXZyvL0UOtU
 BQC22P4nj+URkFLAXnAMpZANU/fWdZCeaWZArOP5HUVJBlZPfxrOPTu6UiGMUowYgEboor
 lNshmO4BDcndySbzqaegHn/AKu/Vmlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754335668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeR66d6NwlOi9pjH2LSwhv0i6WD5hOD6OKRFWYA2B0A=;
 b=cu5D8VHXS4Us+pNw0jxLNKG9k3CumfwgVmydJ4UN7YQepbTC4sDnP/h5N2li3q098D68tH
 bHOUhV9cFG2kckDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2F7C13695;
 Mon,  4 Aug 2025 19:27:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7Z1AGbMJkWg5PAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Aug 2025 19:27:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juraj Marcin <jmarcin@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
In-Reply-To: <d5xctfzcrtbanvkndamonxgqo3tc5nejhyrvh54m3y5bhg4cms@ue7siue2yw7o>
References: <20250801170212.54409-1-berrange@redhat.com>
 <d5xctfzcrtbanvkndamonxgqo3tc5nejhyrvh54m3y5bhg4cms@ue7siue2yw7o>
Date: Mon, 04 Aug 2025 16:27:45 -0300
Message-ID: <87jz3i3n0u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Juraj Marcin <jmarcin@redhat.com> writes:

> Hi Daniel,
>
> On 2025-08-01 18:02, Daniel P. Berrang=C3=A9 wrote:
>> This is a followup to previously merged patches that claimed to
>> workaround the gnutls bug impacting migration, but in fact were
>> essentially non-functional. Juraj Marcin pointed this out, and
>> this new patch tweaks the workaround to make it actually do
>> something useful.
>>=20
>> Daniel P. Berrang=C3=A9 (2):
>>   migration: simplify error reporting after channel read
>>   migration: fix workaround for gnutls thread safety
>>=20
>>  crypto/tlssession.c   | 16 ----------------
>>  migration/qemu-file.c | 22 +++++++++++++++++-----
>>  2 files changed, 17 insertions(+), 21 deletions(-)
>>=20
>
> thanks for finding a fix for the workaround. I have tested it and it
> resolves the issue.
>
> However, it significantly slows down migration, even with the workaround
> disabled (and thus no locking). When benchmarking, I used the fixed
> version of GNUTLS, VM with 20GB of RAM which were fully written to
> before starting a normal migration with no workload during the
> migration.
>
> Test cases:
> [1]: before this patchset
> [2]: with this patchset applied and GNUTLS workaround enabled
> [2]: with this patchset applied and GNUTLS workaround disabled
>
>   | Total time | Throughput | Transfered bytes |
> --+------------+------------+------------------+
> 1 |  31 192 ms |  5450 mpbs |   21 230 973 763 |
> 2 |  74 147 ms |  2291 mbps |   21 232 849 066 |
> 3 |  72 426 ms |  2343 mbps |   21 215 009 392 |

Thanks testing this. I had just managed to convince myself that there
wouldn't be any performance issues.

The yield at every buffer fill on the incoming side is probably way more
impactful than the poll on the RP.

