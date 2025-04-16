Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E9AC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 13:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u52NM-0000wn-N9; Wed, 16 Apr 2025 09:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u52Mn-0000sj-M2
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 08:59:49 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u52Ml-00043s-51
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 08:59:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D4A9921175;
 Wed, 16 Apr 2025 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744808383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKkkEe73aBeiVA1HuV99dUfe+Zfq97nQHFEUkAsUd9k=;
 b=ig13IakO37FbRyjc29DFvPgALbXcBpAC7aEZx+zEa0k8WRfIA5GtBFYIq72muw9Q6WrM5Y
 RDzugJzQ3z5qBQtHa0Q5zK/p2ZlpRtsmZTVk9r1KWb1DcQENLbMQ9LTRBBfxuczFCHK2Dm
 NbHCEbqCQRNGkarsLx60JlLelRMWlAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744808383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKkkEe73aBeiVA1HuV99dUfe+Zfq97nQHFEUkAsUd9k=;
 b=HSXvlFLG19sCAyoyYcUQUTm3Dg1fzl0dy91D4p+RauvRLTzGm56syk6oh6Awtp8Am1re29
 yaTvV+V4SC9jBSAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zpsVmT6o;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oeb524OP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744808382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKkkEe73aBeiVA1HuV99dUfe+Zfq97nQHFEUkAsUd9k=;
 b=zpsVmT6oa0bTaInNT4BBkj0GLV7iajpW5rd56kb3+WMuxqgP4vYd3Sr5rHYAElEmawiGQn
 jfTRw0pD+t9AazAOQ1so1YgA1tpWKXbPQan1FjzD4rQnGYhBOkkAFFah11rVMargqm9y1F
 JE5NvmGXtKWtW1lfj745pEqjI6k35IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744808382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKkkEe73aBeiVA1HuV99dUfe+Zfq97nQHFEUkAsUd9k=;
 b=oeb524OPCb63Mx/rC1N9qt7LH9WrL8vqo5/zSxZeEfcQg/GXltovwuGpHmOb4BY8ogK+Sv
 Io1Abf898/6NDoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 495A413976;
 Wed, 16 Apr 2025 12:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BRrTAb6p/2fLMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Apr 2025 12:59:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <87ecxteym0.fsf@suse.de>
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de>
Date: Wed, 16 Apr 2025 09:59:39 -0300
Message-ID: <87bjswfeis.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D4A9921175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> Prasad Pandit <ppandit@redhat.com> writes:
>
>> From: Prasad Pandit <pjp@fedoraproject.org>
>>
>>  Hello,
>>
>>
>> * This series (v9) does minor refactoring and reordering changes as
>>   suggested in the review of earlier series (v8). Also tried to
>>   reproduce/debug a qtest hang issue, but it could not be reproduced.
>>   From the shared stack traces it looked like Postcopy thread was
>>   preparing to finish before migrating all the pages.
>
> The issue is that a zero page is being migrated by multifd but there's
> an optimization in place that skips faulting the page in on the
> destination. Later during postcopy when the page is found to be missing,
> postcopy (@migrate_send_rp_req_pages) believes the page is already
> present due to the receivedmap for that pfn being set and thus the code
> accessing the guest memory just sits there waiting for the page.
>
> It seems your series has a logical conflict with this work that was done
> a while back:
>
> https://lore.kernel.org/all/20240401154110.2028453-1-yuan1.liu@intel.com/
>
> The usage of receivedmap for multifd was supposed to be mutually
> exclusive with postcopy. Take a look at the description of that series
> and at postcopy_place_page_zero(). We need to figure out what needs to
> change and how to do that compatibly. It might just be the case of
> memsetting the zero page always for postcopy, but I havent't thought too
> much about it.
>
> There's also other issues with the series:
>
> https://gitlab.com/farosas/qemu/-/pipelines/1770488059
>
> The CI workers don't support userfaultfd so the tests need to check for
> that properly. We have MigrationTestEnv::has_uffd for that.
>
> Lastly, I have seem some weirdness with TLS channels disconnections
> leading to asserts in qio_channel_shutdown() in my testing. I'll get a
> better look at those tomorrow.

Ok, you can ignore this last paragraph. I was seeing the postcopy
recovery test disconnect messages, those are benign.

