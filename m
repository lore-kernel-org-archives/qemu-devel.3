Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CA6C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 15:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txotg-0003vb-5Y; Thu, 27 Mar 2025 11:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txotd-0003uw-HC
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:11:53 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txotb-0002xZ-8K
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:11:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 52AC21F461;
 Thu, 27 Mar 2025 15:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743088308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCA67Q+jXfVUszgDSNXpg0gsoStCvUCutoA4w7M1XO4=;
 b=17queSlvlbcZECRIW8/sgc+jJ20do56G35Y4OYfhTY9ntDuu1eELt0u1sWjjXiaGijciuO
 9v4Jamg9NCyuhw1ZWJSr8gs30ZEl7p66Bwy2gF2W9oEYC6utiHdSDCea8Xgbb3jad4JEJ9
 dqKqYG6KDFxIMXgFFQ3nTKv9/eXP0oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743088308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCA67Q+jXfVUszgDSNXpg0gsoStCvUCutoA4w7M1XO4=;
 b=H1lQxrpBLJSnc6OEd5hxVSulsLPucjXzWfAoS6znInTVMTybCp/+ChnF0GsdloIXnUZuJk
 GSGheZazZIqQVbDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743088308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCA67Q+jXfVUszgDSNXpg0gsoStCvUCutoA4w7M1XO4=;
 b=17queSlvlbcZECRIW8/sgc+jJ20do56G35Y4OYfhTY9ntDuu1eELt0u1sWjjXiaGijciuO
 9v4Jamg9NCyuhw1ZWJSr8gs30ZEl7p66Bwy2gF2W9oEYC6utiHdSDCea8Xgbb3jad4JEJ9
 dqKqYG6KDFxIMXgFFQ3nTKv9/eXP0oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743088308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCA67Q+jXfVUszgDSNXpg0gsoStCvUCutoA4w7M1XO4=;
 b=H1lQxrpBLJSnc6OEd5hxVSulsLPucjXzWfAoS6znInTVMTybCp/+ChnF0GsdloIXnUZuJk
 GSGheZazZIqQVbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D77401376E;
 Thu, 27 Mar 2025 15:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oKXvJ7Nq5WdjcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 15:11:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, Marco Cavenati
 <Marco.Cavenati@eurecom.fr>
Subject: Re: [PATCH 1/4] migration/savevm: Add a compatibility check for
 capabilities
In-Reply-To: <Z-Vms2l4jZ_eV-aa@redhat.com>
References: <20250327143934.7935-1-farosas@suse.de>
 <20250327143934.7935-2-farosas@suse.de> <Z-Vms2l4jZ_eV-aa@redhat.com>
Date: Thu, 27 Mar 2025 12:11:41 -0300
Message-ID: <875xjua4pe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Mar 27, 2025 at 11:39:31AM -0300, Fabiano Rosas wrote:
>> It has always been possible to enable arbitrary migration capabilities
>> and attempt to take a snapshot of the VM with the savevm/loadvm
>> commands as well as their QMP counterparts
>> snapshot-save/snapshot-load.
>>=20
>> Most migration capabilities are not meant to be used with snapshots
>> and there's a risk of crashing QEMU or producing incorrect
>> behavior. Ideally, every migration capability would either be
>> implemented for savevm or explicitly rejected.
>
> IMHO, this a prime example of why migration config shouldn't be held
> as global state, and instead passed as parameters to the commands
> that need them.  The snapshot-save/load commands would then only
> be able to accept what few settings are actually relevant, instead
> of inheriting any/all global migration state.
>

Right, I remember we got caught around the fact that some migration
options are needed during runtime as well... but I don't remember the
details, let try to find that thread.

>> Add a compatibility check routine and reject the snapshot command if
>> an incompatible capability is enabled. For now only act on the the two
>> that actually cause a crash: multifd and mapped-ram.
>>=20
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2818
>
> Issue is 2881 not 2818                                   ^^^^^^^
>

It seem that was your own C-t =3D)

>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 26 ++++++++++++++++++++++++++
>>  migration/options.h |  1 +
>>  migration/savevm.c  |  8 ++++++++
>>  3 files changed, 35 insertions(+)
>
> With regards,
> Daniel

