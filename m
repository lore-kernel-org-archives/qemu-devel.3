Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8EEC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 20:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhF3P-0004Ko-No; Mon, 04 Mar 2024 15:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhF3N-0004De-Vu
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:36:54 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhF3M-0000ES-4C
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:36:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 28F13205E8;
 Mon,  4 Mar 2024 20:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709584609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxnr65KLM3QTYTNZrtNs/JQUcaQ9SYCnxksu4V4Z+SY=;
 b=0ElQA/j/AjuGDMgiDu2EiQ3n0c+2ImrzMg3dKbhu/mTjZ8ww/0L6TW+mGa4LJaW26xf+6H
 p/cnECyt1iltbC871hBCS5yE8F5gfo/Sa6osPgdIgws85FRtdUYzrTfAuHFwh1aiuwXUVH
 ksPbZRLZ4cNBM0oImsVEfjU4uCIQYmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709584609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxnr65KLM3QTYTNZrtNs/JQUcaQ9SYCnxksu4V4Z+SY=;
 b=9yxgkTfLjqs8zwW1Qk2haNDDpQZwdspiy0q2JmvsuxTVi7frFYqJ5Qo3uG4XRNieEJJnRY
 bCMr/ZXu3AzT2GDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709584609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxnr65KLM3QTYTNZrtNs/JQUcaQ9SYCnxksu4V4Z+SY=;
 b=0ElQA/j/AjuGDMgiDu2EiQ3n0c+2ImrzMg3dKbhu/mTjZ8ww/0L6TW+mGa4LJaW26xf+6H
 p/cnECyt1iltbC871hBCS5yE8F5gfo/Sa6osPgdIgws85FRtdUYzrTfAuHFwh1aiuwXUVH
 ksPbZRLZ4cNBM0oImsVEfjU4uCIQYmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709584609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxnr65KLM3QTYTNZrtNs/JQUcaQ9SYCnxksu4V4Z+SY=;
 b=9yxgkTfLjqs8zwW1Qk2haNDDpQZwdspiy0q2JmvsuxTVi7frFYqJ5Qo3uG4XRNieEJJnRY
 bCMr/ZXu3AzT2GDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7C4513A5B;
 Mon,  4 Mar 2024 20:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tG2zG+Aw5mUuQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Mar 2024 20:36:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Peter Xu <peterx@redhat.com>, "Wang, Lei"
 <lei4.wang@intel.com>, Joao Martins <joao.m.martins@oracle.com>, Avihai
 Horon <avihaih@nvidia.com>
Subject: Re: [PATCH v2 0/3] migration: Don't serialize devices in
 qemu_savevm_state_iterate()
In-Reply-To: <20240304105339.20713-1-avihaih@nvidia.com>
References: <20240304105339.20713-1-avihaih@nvidia.com>
Date: Mon, 04 Mar 2024 17:36:46 -0300
Message-ID: <87msrd20pt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="0ElQA/j/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9yxgkTfL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-7.10 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-2.09)[95.58%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 28F13205E8
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

Avihai Horon <avihaih@nvidia.com> writes:

> Hi,
>
> This small series is v2 of the single patch I previously sent [1].
>
> It removes device serialization in qemu_savevm_state_iterate() and does
> some VFIO migration touch ups. More info provided in the commit
> messages.
>
> Thanks.
>
> Changes from V1 -> V2:
> * Remove device serialization in qemu_savevm_state_iterate() always,
>   regardless of switchover-ack.
> * Refactor vfio_save_iterate() return value.
> * Add a note about migration rate limiting in vfio_save_iterate().
>
> [1] https://lore.kernel.org/qemu-devel/20240222155627.14563-1-avihaih@nvidia.com/
>
> Avihai Horon (3):
>   migration: Don't serialize devices in qemu_savevm_state_iterate()
>   vfio/migration: Refactor vfio_save_state() return value
>   vfio/migration: Add a note about migration rate limiting
>
>  hw/vfio/migration.c | 12 +++++++-----
>  migration/savevm.c  | 15 ++++++---------
>  2 files changed, 13 insertions(+), 14 deletions(-)

Series:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

