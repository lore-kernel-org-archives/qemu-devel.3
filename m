Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD6DCD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 13:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruXd5-0005kV-U6; Wed, 10 Apr 2024 09:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruXd3-0005k6-W6
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:04:42 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruXd2-0003wp-B6
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:04:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 275CC5CD9F;
 Wed, 10 Apr 2024 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712754277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=833KdwBVc/6iHNzwEBgUBOn0FJVXa0vmpXv0314L7VY=;
 b=0kQYTOjNZXv4FYV8M1lavzQrp1FZBsXyGhEHyYziVl7BOjnx7aHei1B0hIOiIceYGTK/n1
 qacabkAZWGHcSb6GojjU3YDfgWJw0Bd0TxFASeO6z/zaceAwFBy+Cgd5bULgTUlkBXCGvA
 chzMAXyJtzoZ9cI+YDoIxLzkwFCgUXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712754277;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=833KdwBVc/6iHNzwEBgUBOn0FJVXa0vmpXv0314L7VY=;
 b=Lso1p0NSR+M95FzEEV3dIscJAkFtQECniIZEXmiVda3YnaJb1sTEXAtG2LKjmHGBAtPSZi
 dQIWdYLw3SPoS9CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0kQYTOjN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Lso1p0NS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712754277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=833KdwBVc/6iHNzwEBgUBOn0FJVXa0vmpXv0314L7VY=;
 b=0kQYTOjNZXv4FYV8M1lavzQrp1FZBsXyGhEHyYziVl7BOjnx7aHei1B0hIOiIceYGTK/n1
 qacabkAZWGHcSb6GojjU3YDfgWJw0Bd0TxFASeO6z/zaceAwFBy+Cgd5bULgTUlkBXCGvA
 chzMAXyJtzoZ9cI+YDoIxLzkwFCgUXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712754277;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=833KdwBVc/6iHNzwEBgUBOn0FJVXa0vmpXv0314L7VY=;
 b=Lso1p0NSR+M95FzEEV3dIscJAkFtQECniIZEXmiVda3YnaJb1sTEXAtG2LKjmHGBAtPSZi
 dQIWdYLw3SPoS9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A286213942;
 Wed, 10 Apr 2024 13:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WsNdGmSOFmaACQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Apr 2024 13:04:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, prerna.saxena@nutanix.com, Het Gala
 <het.gala@nutanix.com>
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none()
 to use new QAPI syntax"
In-Reply-To: <20240410111541.188504-2-het.gala@nutanix.com>
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com>
Date: Wed, 10 Apr 2024 10:04:33 -0300
Message-ID: <874jc9v066.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 275CC5CD9F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.94%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,nutanix.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
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

Het Gala <het.gala@nutanix.com> writes:

> This reverts commit 8e3766eefbb4036cbc280c1f1a0d28537929f7fb
>
> After addition of 'channels' as the starting argument of new QAPI
> syntax inside postcopy test, even if the user entered the old QAPI
> syntax, test used the new syntax.
> It was a temporary patch added to have some presence of the new syntax
> since the migration qtest framework lacked any logic for introducing
> 'channels' argument.

That wasn't clear to me when we merged that. Was that really the case?

>
> Now that the qtest framework has logic to introduce uri and channel
> argument separately, we can remove this temporary change.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>

Anyway, I can see the point of this.

Reviewed-by: Fabiano Rosas <farosas@suse.de>


