Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4623CC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zi3-0003Ah-LS; Tue, 22 Sep 2026 08:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zhf-00030n-EA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:34:31 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zhd-0008VM-R8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:34:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 485EE21BF8;
 Tue, 22 Sep 2026 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790080462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7TTJYBTCwIG7sMMiYYCQI0T7Grnfbgncxmzt1Ufwos=;
 b=SW0mvJp47DLVaiKVo5jgbPlMyY5CpvPXwdRddOT18UDqMYzB2VRapdW3I2sZ8jlYy8ytIt
 l6/tFNMmUiK6gIxW3O4SI3xrAYzLJeCwIN5qTWpr9jVgtL1MYOt3pTRTzcJuAgJYNeT8xm
 QeU/Qj8BdEIn6uddqXuMF0rUDdIt+ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790080462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7TTJYBTCwIG7sMMiYYCQI0T7Grnfbgncxmzt1Ufwos=;
 b=DML+yGweak/QHTrw6ZGwIu2XXWnUbA1pE5e1D+kJdmFajYdB149dCS6fKyiV4c9Cu1CBev
 bJr379RXHIB4DPBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HOpgf/pl";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p04ArP3l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790080458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7TTJYBTCwIG7sMMiYYCQI0T7Grnfbgncxmzt1Ufwos=;
 b=HOpgf/plQLh/ZVDmpDF9/yMPUUDjyWgCI8B1yEWzQi0mSrq0Y/IVcHzrkoSIBcogldQQ4i
 MM+hcnz5pqfsx6kCaYMl6xrE9ZNJsd/uZxtEzRBXj1Eu2Sjuy4LPtvsNH83C40p4ZPkYiR
 fOAQWTxdWoxL87XcsPFYVJ9hog0VfDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790080458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7TTJYBTCwIG7sMMiYYCQI0T7Grnfbgncxmzt1Ufwos=;
 b=p04ArP3l4VdFYeLy6fBy29pvIi/ch/QaTi3RWhECiHQFY3D0OeyhppdGfj5eeuljU/pmuB
 XArq2iRbCuN13IAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 951C213A01;
 Tue, 22 Sep 2026 12:34:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ox+iDsl1smosOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Sep 2026 12:34:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, peterx@redhat.com, eblake@redhat.com
Subject: Re: [PATCH] qapi/migration: Make migration parameter @local
 consistently unstable
In-Reply-To: <20260912045350.2139416-1-armbru@redhat.com>
References: <20260912045350.2139416-1-armbru@redhat.com>
Date: Tue, 22 Sep 2026 09:34:07 -0300
Message-ID: <874ifhbh34.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 485EE21BF8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

> @local is unstable in MigrationParameters, but not in
> MigrationParameter.  Fix the latter.
>
> Fixes: c9affb8e9b (qapi: add local migration parameter)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/migration.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f7628b55e9..9a1cc7c4e5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -804,8 +804,8 @@
>  #
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @local, @x-checkpoint-delay, @x-rdma-chunk-size,
> +#     and @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
>  ##
> @@ -831,7 +831,7 @@
>             'direct-io',
>             { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>             'cpr-exec-command',
> -           'local'] }
> +           { 'name': 'local', 'features': [ 'unstable' ] } ] }
>  
>  ##
>  # @migrate-set-parameters:

Queued, thanks!

