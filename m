Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14316C369AB
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 00:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4qgS-0003Ke-0D; Tue, 15 Apr 2025 20:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4qgL-0003KK-EY
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 20:31:13 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4qgJ-0001jC-9X
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 20:31:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3574F1F461;
 Wed, 16 Apr 2025 00:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744763467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cahHzO6kq9dKbV870BlESeh0v/e/AIiw2BA1i5RxIeY=;
 b=z96LZEJ9ZKLhd2MhfXS7PP2Si421kOF3CRKUMjJjCwjWIQtc+Ir2fMcajcArB/25kkZFOL
 fu1fwm4GV8una+Di3ikLPU4tlFRmsQ7GecubatJfhwWK8Oy/zuwovW90iU7JFQk9JES3k1
 iufhB9RJDuLUVC3DUrixucLiQ4iXDFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744763467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cahHzO6kq9dKbV870BlESeh0v/e/AIiw2BA1i5RxIeY=;
 b=13I2KU4txi9d/3wu1u3Y986c3ISIWDpGn3iE+476fjy1n68S2iAblnfvbZvLtqy5zzxVAt
 XAZkkrFKg8fkW5DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z96LZEJ9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=13I2KU4t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744763467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cahHzO6kq9dKbV870BlESeh0v/e/AIiw2BA1i5RxIeY=;
 b=z96LZEJ9ZKLhd2MhfXS7PP2Si421kOF3CRKUMjJjCwjWIQtc+Ir2fMcajcArB/25kkZFOL
 fu1fwm4GV8una+Di3ikLPU4tlFRmsQ7GecubatJfhwWK8Oy/zuwovW90iU7JFQk9JES3k1
 iufhB9RJDuLUVC3DUrixucLiQ4iXDFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744763467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cahHzO6kq9dKbV870BlESeh0v/e/AIiw2BA1i5RxIeY=;
 b=13I2KU4txi9d/3wu1u3Y986c3ISIWDpGn3iE+476fjy1n68S2iAblnfvbZvLtqy5zzxVAt
 XAZkkrFKg8fkW5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3B1F1336F;
 Wed, 16 Apr 2025 00:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XCNzGEr6/megYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Apr 2025 00:31:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <20250411114534.3370816-1-ppandit@redhat.com>
References: <20250411114534.3370816-1-ppandit@redhat.com>
Date: Tue, 15 Apr 2025 21:31:03 -0300
Message-ID: <87ecxteym0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 3574F1F461
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Prasad Pandit <ppandit@redhat.com> writes:

> From: Prasad Pandit <pjp@fedoraproject.org>
>
>  Hello,
>
>
> * This series (v9) does minor refactoring and reordering changes as
>   suggested in the review of earlier series (v8). Also tried to
>   reproduce/debug a qtest hang issue, but it could not be reproduced.
>   From the shared stack traces it looked like Postcopy thread was
>   preparing to finish before migrating all the pages.

The issue is that a zero page is being migrated by multifd but there's
an optimization in place that skips faulting the page in on the
destination. Later during postcopy when the page is found to be missing,
postcopy (@migrate_send_rp_req_pages) believes the page is already
present due to the receivedmap for that pfn being set and thus the code
accessing the guest memory just sits there waiting for the page.

It seems your series has a logical conflict with this work that was done
a while back:

https://lore.kernel.org/all/20240401154110.2028453-1-yuan1.liu@intel.com/

The usage of receivedmap for multifd was supposed to be mutually
exclusive with postcopy. Take a look at the description of that series
and at postcopy_place_page_zero(). We need to figure out what needs to
change and how to do that compatibly. It might just be the case of
memsetting the zero page always for postcopy, but I havent't thought too
much about it.

There's also other issues with the series:

https://gitlab.com/farosas/qemu/-/pipelines/1770488059

The CI workers don't support userfaultfd so the tests need to check for
that properly. We have MigrationTestEnv::has_uffd for that.

Lastly, I have seem some weirdness with TLS channels disconnections
leading to asserts in qio_channel_shutdown() in my testing. I'll get a
better look at those tomorrow.


