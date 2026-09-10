Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E49C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4eWi-0006Wp-3q; Thu, 10 Sep 2026 09:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4eWh-0006Wf-0i
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:09:15 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4eWf-0008Gz-Gv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:09:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 878DC21C6C;
 Thu, 10 Sep 2026 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789045747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rbl8Yaneie1mfhvv7Ou7hL61EPC6PkfekCFc9t7pXAA=;
 b=zGTpm6/Qum03XvO3n+N15JTQsBiyalE46FGLiFRyUq+3PcX94SvPCEgLZY3y3jD0AvRmAX
 CVRvQrCYlpXYHrtjx8rrmW1ahPCH5Aa6Qnbk3CN9n8LUt69CMfpOdwmoT7ngTlGSqG5hry
 Pqqh6cwZ8ZvwNJGjuUDBhMxQtFXvqtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789045747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rbl8Yaneie1mfhvv7Ou7hL61EPC6PkfekCFc9t7pXAA=;
 b=e8G7j9CLYJT2HPE7uS00B0mSVafLGgVdNK/1WyWEqFVJLElg3Lf4ssvG9CUqKl4B4EPpVo
 NCw5QhnuE8BlSVAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E76LyXgF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jYZfVkog
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789045743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rbl8Yaneie1mfhvv7Ou7hL61EPC6PkfekCFc9t7pXAA=;
 b=E76LyXgFPDaBCxPecUWGEPbVcZvtUtHcHgjfy+PQ0ywwpWoadbWDLg1jfpa9L8ZBYMyIF+
 EWo1FWNdX2wgZyHtLpgeWWZxxd8/PZSCuBwbB02EtogdglggwwP+Qm2V5K6QEGoDOAf1eH
 z3MteOe9+2IRkYgbsb3LoTzdRzuGmxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789045743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rbl8Yaneie1mfhvv7Ou7hL61EPC6PkfekCFc9t7pXAA=;
 b=jYZfVkognDQKWOOyAMXuddCVei7aUO2mld2LHjV8SD0TAI2KvS6yv+14588dshWM9J5liC
 BzEe3SY+V9ulXwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 078031326D;
 Thu, 10 Sep 2026 13:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /JONMu6rompYegAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 13:09:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Dr . David Alan
 Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 15/18] migration: Rewrite
 migrate_set_parameter_completion using QDict
In-Reply-To: <878q59e4nt.fsf@pond.sub.org>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-16-farosas@suse.de> <878q59e4nt.fsf@pond.sub.org>
Date: Thu, 10 Sep 2026 10:09:00 -0300
Message-ID: <87tsnxtfrn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 878DC21C6C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> The migrate_set_parameter_completion function is the last user of the
>> MigrationParameter enum.
>
> Not true, there's still the assertion in
> migrate_mark_all_params_present(), and hmp_completion_single() in
> tests/qtest/migration/misc-tests.c.
>
> The assertion is unclean: it uses MIGRATION_PARAMETER__MAX for number of
> MigrationParameters members, which tacitly assumes MigrationParameter
> matches MigrationParameters.
>

I'm not sure I understand what you mean here. The usefulness of
MigrationParameter is quite diminished if it doesn't always match the
members of MigrationParameters.

In fact... could we code-generate the enum from MigrationParameters
without the need for explicitly declaring MigrationParameter? That way
we keep the usefulness of having a lookup function and a "max" and do
away with the task of updating MigrationParameter to match
MigrationParameters.

>>                          Write the code using an output visitor and
>> QDict instead so we can remove the enum in a future patch.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>

