Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715DAC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5RmR-0006BN-2J; Thu, 17 Apr 2025 12:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u5RmO-0006B4-Ke
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:07:56 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u5RmM-0002b7-27
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:07:56 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D76A1F74A;
 Thu, 17 Apr 2025 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744906072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FR7r8A0497dJaYv5HeCyoqHkMIIS+hrKMg+NY4L2XaY=;
 b=XTIgKARL/wVWFiXiA7XYFCuic24CVVW6bfJB+BnCOlDx9UYq1T9pfsBJiGL1hbmC231WKa
 bz9wLvRMNotmuGCVuqbuLE0JKQciwDMjeucUzwZr3t1luFwbRhhAtdGq/XxSk1e21T6Tn1
 pnyfrZ+LmI490dCa/WL7BkuvghN1NHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744906072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FR7r8A0497dJaYv5HeCyoqHkMIIS+hrKMg+NY4L2XaY=;
 b=EMwE3JS95lWBg8zUg7PSiztdPD1vmIOH+sn+dJL5jNVpJUDbVXg18pWWQ5iXvamhI8p+co
 06N+EdXZ73HqKzDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XTIgKARL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EMwE3JS9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744906072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FR7r8A0497dJaYv5HeCyoqHkMIIS+hrKMg+NY4L2XaY=;
 b=XTIgKARL/wVWFiXiA7XYFCuic24CVVW6bfJB+BnCOlDx9UYq1T9pfsBJiGL1hbmC231WKa
 bz9wLvRMNotmuGCVuqbuLE0JKQciwDMjeucUzwZr3t1luFwbRhhAtdGq/XxSk1e21T6Tn1
 pnyfrZ+LmI490dCa/WL7BkuvghN1NHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744906072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FR7r8A0497dJaYv5HeCyoqHkMIIS+hrKMg+NY4L2XaY=;
 b=EMwE3JS95lWBg8zUg7PSiztdPD1vmIOH+sn+dJL5jNVpJUDbVXg18pWWQ5iXvamhI8p+co
 06N+EdXZ73HqKzDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE0AD1388F;
 Thu, 17 Apr 2025 16:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ByyEKlcnAWj6cQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Apr 2025 16:07:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v9 3/7] migration: Add save_postcopy_prepare() savevm
 handler
In-Reply-To: <20250411114534.3370816-4-ppandit@redhat.com>
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <20250411114534.3370816-4-ppandit@redhat.com>
Date: Thu, 17 Apr 2025 13:07:49 -0300
Message-ID: <87sem6eppm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 8D76A1F74A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> From: Peter Xu <peterx@redhat.com>
>
> Add a savevm handler for a module to opt-in sending extra sections right
> before postcopy starts, and before VM is stopped.
>
> RAM will start to use this new savevm handler in the next patch to do flush
> and sync for multifd pages.
>
> Note that we choose to do it before VM stopped because the current only
> potential user is not sensitive to VM status, so doing it before VM is
> stopped is preferred to enlarge any postcopy downtime.
>
> It is still a bit unfortunate that we need to introduce such a new savevm
> handler just for the only use case, however it's so far the cleanest.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

