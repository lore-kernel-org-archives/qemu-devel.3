Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73026C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglpQ-0006vJ-TQ; Wed, 21 Aug 2024 09:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sglpO-0006su-Fw; Wed, 21 Aug 2024 09:56:47 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sglpM-0007cB-PT; Wed, 21 Aug 2024 09:56:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6AFFA21C3F;
 Wed, 21 Aug 2024 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724248601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2T37xBdSvZZLS6IFHbQ7iDsE0FClHX1T0uIHLjtLaw=;
 b=ciFffWpc/x8VdCIUfZSYdWpW4Jq7KwhWShMo7iXa2LNoBj2kqJWldyaZrCzupriGW3TJtc
 uqBVJWkTSbOdPW9BxqiUHRXeHQiNy45jinhWKRkyhbHJLqkkzd09c48yWDrvsX6XsOBMco
 zLnvg7uJptiV1PQB/Rc0BbP7UiZHWtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724248601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2T37xBdSvZZLS6IFHbQ7iDsE0FClHX1T0uIHLjtLaw=;
 b=V6NKtYorBxqn0momJ0ZncjCZmZkPDKkvC9BtBd3BC/JFau65suLbH3DCFjbJnXfRZDHlHA
 hKG7cvjR3d12x/Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ciFffWpc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V6NKtYor
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724248601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2T37xBdSvZZLS6IFHbQ7iDsE0FClHX1T0uIHLjtLaw=;
 b=ciFffWpc/x8VdCIUfZSYdWpW4Jq7KwhWShMo7iXa2LNoBj2kqJWldyaZrCzupriGW3TJtc
 uqBVJWkTSbOdPW9BxqiUHRXeHQiNy45jinhWKRkyhbHJLqkkzd09c48yWDrvsX6XsOBMco
 zLnvg7uJptiV1PQB/Rc0BbP7UiZHWtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724248601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2T37xBdSvZZLS6IFHbQ7iDsE0FClHX1T0uIHLjtLaw=;
 b=V6NKtYorBxqn0momJ0ZncjCZmZkPDKkvC9BtBd3BC/JFau65suLbH3DCFjbJnXfRZDHlHA
 hKG7cvjR3d12x/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EABC6139C2;
 Wed, 21 Aug 2024 13:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tEGdKxjyxWYdKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Aug 2024 13:56:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Arisetty, Chakri" <carisett@akamai.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "Peter Xu <peterx@redhat.com>"@imap1.dmz-prg2.suse.org,
 "Kevin Wolf <kwolf@redhat.com>"@imap1.dmz-prg2.suse.org,
 "Eric  Blake <eblake@redhat.com>"@imap1.dmz-prg2.suse.org
Subject: Re: Issue with QEMU Live Migration
In-Reply-To: <1ABDAA2B-8582-4B98-81D3-8F71DE62718C@akamai.com>
References: <1ABDAA2B-8582-4B98-81D3-8F71DE62718C@akamai.com>
Date: Wed, 21 Aug 2024 10:56:38 -0300
Message-ID: <874j7e0yjt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6AFFA21C3F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.58 / 50.00]; BAYES_HAM(-2.07)[95.48%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,akamai.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"Arisetty, Chakri" <carisett@akamai.com> writes:

> Hello,
>
> I=E2=80=99m having trouble with live migration and I=E2=80=99m using QEMU=
 7.2.0 on Debian 11.
>
> Migration state switches to pre-switchover state during the RAM migration.
>
> My assumption is that disks are already migrated and there are no further=
 dirty pages to be transferred from source host to destination host. Theref=
ore, NBD client on the source host closes the connection to the NBD server =
on the destination host. But we observe that there are still some dirty pag=
es being transferred.
> Closing prematurely NBD connection results in BLOCK JOB error.
> In the RAM migration code (migration/migration.c), I=E2=80=99d like to ch=
eck for block mirror job=E2=80=99s status before RAM migration state is mov=
ed to pre-switchover. I=E2=80=99m unable to find any block job related code=
 in RAM migration code.
>
> Could someone help me figuring out what might be going wrong or suggest a=
ny troubleshooting steps or advice to get around the issue?
>
> Thanks
> Chakri

Hi, I believe it was you who opened this bug as well?=20

https://gitlab.com/qemu-project/qemu/-/issues/2482

So the core of the issue here is that the block job is transitioning to
ready while the migration is still ongoing so there's still dirtying
happening.

Have you looked at the documentation at
docs/interop/live-block-operations.rst? Section "QMP invocation for live
storage migration with ``drive-mirror`` + NBD", point 4 says that a
block-job-cancel should be issues after BLOCK_JOB_READY is
reached. Although there is mention of when the migration should be
performed.

