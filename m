Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46323C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHiy-0001lY-0s; Thu, 20 Jun 2024 09:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKHiw-0001lP-Rb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:21:10 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKHip-0001MH-Ur
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:21:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F33E91F8A3;
 Thu, 20 Jun 2024 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718889659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KFZafrVRxaAzkQ4nHKeA+bG9BNWG4bHOWUcaOnNLaz8=;
 b=Lo9eDOaWFIMvumj9cm04bPjHYtZ0JDkJ/LMN9YvlpJPs4Wmxo3GMU1kzCVaan8rGyPFDGx
 jJ39wdUE6FHskS5xIYn580PS4olDxxRrZONfvxADVza0Lejj+6G4UEpT6HaGtg8Jy5kw0O
 HTaGb/fhSIy1vVnBzVy8g2aqFkcM2oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718889659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KFZafrVRxaAzkQ4nHKeA+bG9BNWG4bHOWUcaOnNLaz8=;
 b=CLXqTsm2KVKsXxhx1UGqUB+Dsl2VNRdvUYoOl2tMSFyz/s29+cLj5jSNABiTVxdQA/Rx8j
 JfAxnXaP4OGsp4Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718889659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KFZafrVRxaAzkQ4nHKeA+bG9BNWG4bHOWUcaOnNLaz8=;
 b=Lo9eDOaWFIMvumj9cm04bPjHYtZ0JDkJ/LMN9YvlpJPs4Wmxo3GMU1kzCVaan8rGyPFDGx
 jJ39wdUE6FHskS5xIYn580PS4olDxxRrZONfvxADVza0Lejj+6G4UEpT6HaGtg8Jy5kw0O
 HTaGb/fhSIy1vVnBzVy8g2aqFkcM2oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718889659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KFZafrVRxaAzkQ4nHKeA+bG9BNWG4bHOWUcaOnNLaz8=;
 b=CLXqTsm2KVKsXxhx1UGqUB+Dsl2VNRdvUYoOl2tMSFyz/s29+cLj5jSNABiTVxdQA/Rx8j
 JfAxnXaP4OGsp4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78CC51369F;
 Thu, 20 Jun 2024 13:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mgunD7osdGYiSAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Jun 2024 13:20:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Jiri Denemark <jdenemar@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Eric Blake <eblake@redhat.com>,
 peterx@redhat.com
Subject: Re: [PATCH v3 08/11] tests/migration-tests: Always enable migration
 events
In-Reply-To: <20240619223046.1798968-9-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
 <20240619223046.1798968-9-peterx@redhat.com>
Date: Thu, 20 Jun 2024 10:20:55 -0300
Message-ID: <877cejkax4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.75 / 50.00]; BAYES_HAM(-2.45)[97.49%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Libvirt should always enable it, so it'll be nice qtest also cover that for
> all tests on both sides.  migrate_incoming_qmp() used to enable it only on
> dst, now we enable them on both, as we'll start to sanity check events even
> on the src QEMU.
>
> We'll need to leave the one in migrate_incoming_qmp(), because
> virtio-net-failover test uses that one only, and it relies on the events to
> work.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

