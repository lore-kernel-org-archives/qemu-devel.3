Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1915DCCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJ1F-0005TL-DK; Tue, 21 Oct 2025 16:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJ1A-0005R2-M3
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:31:40 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJ18-00064d-0S
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:31:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3EC0C211A5;
 Tue, 21 Oct 2025 20:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761078686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RRfqwnbwms6EpuMatAnfZafRVIhp5f5wupASckogbk=;
 b=Y7SHqhUVxaslo8nH0gYIS41riCMTcgg6KwzfcIfwZfTAdJu04MqB+ll/IPCsf0Rcmvopsx
 rz6Zjgct8pdm/TYhirZD1frMC75vskUszWabGSB19MpaXLCUOU5YamEtDSZO+u623VXJpg
 XpBQ6ZufR/KWlzO40GsYSWUWrc1CG44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761078686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RRfqwnbwms6EpuMatAnfZafRVIhp5f5wupASckogbk=;
 b=yM2P6TDlHgRynfvzSbk+lRk+KBQPtn8fVqTqCYNrEC0bhbaSyAyrPEgsr4xi96X3PWnswD
 Gsx5WXcH/naBz1DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761078682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RRfqwnbwms6EpuMatAnfZafRVIhp5f5wupASckogbk=;
 b=s1tcMCdr8R47jAE7YCJ1f4lCAh/XSdYg9VTQW5NgcNFWDSxKT05CpkzBEUPvBj9+oAwkIY
 KCL9XWwQ4ltlOm+OJtGwrjUXE1JcYpAtXcGeK9TtulH7L+RlBWEw76gvORAPLk5on+DAj1
 aCAkByWMHPziEOjGg8ZfcjpAjCR7WQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761078682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RRfqwnbwms6EpuMatAnfZafRVIhp5f5wupASckogbk=;
 b=q3T73n43Jzh8Sfp6Piw3TtmJ6xFapAfGLQtZp44BGbhOsfyasHqBmz4hmpwb0BEP5icw+A
 N/AVXgiNBymxaHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB791139B1;
 Tue, 21 Oct 2025 20:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ajHzH5nt92hBRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 21 Oct 2025 20:31:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Cc: Dhruv Choudhary <dhruv.choudhary@nutanix.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] Improve error propagation via return path
In-Reply-To: <aPelsAunpYhiQJ0h@x1.local>
References: <20251021075254.600961-1-dhruv.choudhary@nutanix.com>
 <aPeaBNIzrq0Ni4IM@x1.local>
 <41985b55-f99d-47ff-964c-79adc05f3ea1@yandex-team.ru>
 <aPelsAunpYhiQJ0h@x1.local>
Date: Tue, 21 Oct 2025 17:31:19 -0300
Message-ID: <87tszst2so.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Oct 21, 2025 at 05:54:09PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 21.10.25 17:34, Peter Xu wrote:
>> > On Tue, Oct 21, 2025 at 07:52:53AM +0000, Dhruv Choudhary wrote:
>> > > Use the return-path thread to send error details from the
>> > > destination to the source on a migration failure. Management
>> > > applications can then query the source QEMU for errors, as
>> > > the single source of truth, making failures easy to trace.
>> > > 
>> > > Signed-off-by: Dhruv Choudhary <dhruv.choudhary@nutanix.com>
>> > 
>> > +Vladimir, Dan
>> > 
>> > IIUC we may still need to know whether the src QEMU supports this message
>> > or not.
>> > 
>> > OTOH, we have introduced exit-on-error since 9.1:
>> > 
>> > # @exit-on-error: Exit on incoming migration failure.  Default true.
>> > #     When set to false, the failure triggers a :qapi:event:`MIGRATION`
>> > #     event, and error details could be retrieved with `query-migrate`.
>> > #     (since 9.1)
>> > 
>> > This patch is going the other way.  That feature suggests the mgmt query
>> > the error from dest directly.
>> > 
>> > We should stick with one plan rather than doing both.
>> > 
>> 
>> Why?
>> 
>> exit-on-error=false is good anyway: when QMP connection is established, the
>> management of target QEMU process is the same: we do call qmp commands to
>> add devices, etc. We get QMP events. Actually, exiting is unexpected, better
>> to fit into QMP protocol, continuing to send events and wait for qmp quit
>> to exit.
>> 
>> Passing error back to the source simply improves error message on source,
>> which otherwise is often confusing.
>> 
>> Using both, we of course see same error in two places.. But we do have two
>> QEMU processes, which both handled by on-host managing services. We should
>> correctly report error on both parts anyway.
>> 
>> Improving error messages on source is just and improvement, which makes
>> current behavior better (with or without exit-on-error=false).
>> 
>> Removing exit-on-error=false semantics (with or without passing errors back)
>> would be a step backward, to violating of QMP protocol by unexpected exits.
>
> I didn't mean to propose removing exit-on-error, what I meant is when with
> it this patch doesn't look like helpful.
>
> Has libvirt been integrated with exit-on-error?  If so, IMHO we don't need
> this patch anymore.  To me it's not an improvement when with exit-on-error,
> because duplicating the error from dest to src makes it harder to know
> where the error happened.

Yeah, this does introduce some complexity of the "whose error is this?"
kind. I can imagine future users of migrate_has_error() having to handle
the error differently whether it came from this machine or the remote
one. Maybe with current code there's no issue, but we need to think from
a design perspective. Another point is whether the source machine is
always prepared to see an error that has nothing to do with its own
operation as it usually gets to know about a destination error only when
TCP connections start to fail.

That said, from a usability perspective, I'm in favor of having the
source machine be able to inform the user about the destination
machine's error. It goes in the direction of relying less on the
management layer, which we already agree might be a good idea.

