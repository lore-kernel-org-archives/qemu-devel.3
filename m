Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002DFC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiDU-0002FG-3n; Fri, 21 Jun 2024 13:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiDR-0002Er-SQ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:38:25 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiDQ-0000QB-BI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:38:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19ECC1F789;
 Fri, 21 Jun 2024 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718991502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAqMnECGpzX6AOtgRyuE33N3nuBc4ar9w/zZi5M0AEE=;
 b=GQObwpBM8obXIWho83eVQ5iRL84//Dst97kN4Yq4GbCB2dVdI6NhIYgcB5HfFK0Z9Mjo0p
 dk1iyMINKpSQIZX7WF+KZT3CyR7z1M+Xse7b2KzfbfZ82e+q+5fntCUDGhIhCQS0P2Win/
 bQasNCqUsbl2RaXPrfGxF3gFzBg/jAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718991502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAqMnECGpzX6AOtgRyuE33N3nuBc4ar9w/zZi5M0AEE=;
 b=zfFjA8tbg7flwEC0ZKQdHesuX9n4gpahp+ooqSiD4RzXxEMa9B5MRXs/AkvDr7ZzZ1w4Wq
 BgQff9J9sQ6FBYBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GQObwpBM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zfFjA8tb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718991502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAqMnECGpzX6AOtgRyuE33N3nuBc4ar9w/zZi5M0AEE=;
 b=GQObwpBM8obXIWho83eVQ5iRL84//Dst97kN4Yq4GbCB2dVdI6NhIYgcB5HfFK0Z9Mjo0p
 dk1iyMINKpSQIZX7WF+KZT3CyR7z1M+Xse7b2KzfbfZ82e+q+5fntCUDGhIhCQS0P2Win/
 bQasNCqUsbl2RaXPrfGxF3gFzBg/jAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718991502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAqMnECGpzX6AOtgRyuE33N3nuBc4ar9w/zZi5M0AEE=;
 b=zfFjA8tbg7flwEC0ZKQdHesuX9n4gpahp+ooqSiD4RzXxEMa9B5MRXs/AkvDr7ZzZ1w4Wq
 BgQff9J9sQ6FBYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2F0913AAA;
 Fri, 21 Jun 2024 17:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 86kVHou6dWbtZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:38:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org,
	Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Jiri Denemark <jdenemar@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 00/11] migration: New postcopy state, and some cleanups
Date: Fri, 21 Jun 2024 14:38:16 -0300
Message-Id: <171899123149.29250.5609086145990756352.b4-ty@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19ECC1F789
X-Spamd-Result: default: False [-4.41 / 50.00]; BAYES_HAM(-2.90)[99.58%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

On Wed, 19 Jun 2024 18:30:35 -0400, Peter Xu wrote:
> Based-on: <20240617185731.9725-1-farosas@suse.de>
> 
> v3:
> - Added one comment in patch 8 explaining why migrate_incoming_qmp() needs
>   to keep enabling "events" capability.
> - Split patch 9 into two patches, which makes migration_event_wait() to be
>   used also in migrate_incoming_qmp()
> - Rename the tests in last patch, and a spell fix
> - Rebased to "[PATCH v3 00/16] migration/mapped-ram: Add direct-io support"
> 
> [...]

Queued, thanks!

