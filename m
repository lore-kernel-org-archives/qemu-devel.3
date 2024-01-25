Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CE0C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 20:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT6nO-0004gu-I9; Thu, 25 Jan 2024 15:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rT6nK-0004gR-CG
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:57:54 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rT6nG-0003uK-3H
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:57:54 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3FEE7224DF;
 Thu, 25 Jan 2024 20:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706216258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEzsg8VQkqMx0qzkdTqRrbObGFnN0ZWT3ONh+e3yOEo=;
 b=n8Sb6UCbJUqKvbSqv+WiNCMgKhSVU7KuXgQcwJDpiYRBcJSbpVa/qLdDbnn7/9mRWEYXFM
 tZBSUXH9a7AxPRT+l8C0TR9bAhEGCjJ48KUfJzm6AAZbObCa+xbE+md797TPCYqryV802L
 cR8rWtaMB7GCfrHHB5lpUJJNrG8vHVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706216258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEzsg8VQkqMx0qzkdTqRrbObGFnN0ZWT3ONh+e3yOEo=;
 b=vku3u/zAeWX056q6HoGsEE9KEFpaXnCbqozXeziv0KizN0PCwik3PhS+4HUuFmgQ1O8/AY
 9158Eai8leqmPjCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706216258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEzsg8VQkqMx0qzkdTqRrbObGFnN0ZWT3ONh+e3yOEo=;
 b=n8Sb6UCbJUqKvbSqv+WiNCMgKhSVU7KuXgQcwJDpiYRBcJSbpVa/qLdDbnn7/9mRWEYXFM
 tZBSUXH9a7AxPRT+l8C0TR9bAhEGCjJ48KUfJzm6AAZbObCa+xbE+md797TPCYqryV802L
 cR8rWtaMB7GCfrHHB5lpUJJNrG8vHVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706216258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEzsg8VQkqMx0qzkdTqRrbObGFnN0ZWT3ONh+e3yOEo=;
 b=vku3u/zAeWX056q6HoGsEE9KEFpaXnCbqozXeziv0KizN0PCwik3PhS+4HUuFmgQ1O8/AY
 9158Eai8leqmPjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D9F134C3;
 Thu, 25 Jan 2024 20:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tAhZH0HLsmVDRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Jan 2024 20:57:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 04/17] migration/multifd: Set p->running = true in the
 right place
In-Reply-To: <20240125162528.7552-5-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-5-avihaih@nvidia.com>
Date: Thu, 25 Jan 2024 17:57:35 -0300
Message-ID: <87a5otw2ps.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n8Sb6UCb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="vku3u/zA"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[99.98%]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,nvidia.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.994];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 3FEE7224DF
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> The commit in the fixes line moved multifd thread creation to a
> different location, but forgot to move the p->running = true assignment
> as well. Thus, p->running is set to true before multifd thread is
> actually created.
>
> p->running is used in multifd_save_cleanup() to decide whether to join
> the multifd thread or not.
>
> With TLS, an error in multifd_tls_channel_connect() can lead to a
> segmentation fault because p->running is true but p->thread is never
> initialized, so multifd_save_cleanup() tries to join an uninitialized
> thread.
>
> Fix it by moving p->running = true assignment right after multifd thread
> creation. Also move qio_channel_set_delay() to there, as this is where
> it used to be originally.
>
> Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Just for context, I haven't looked at this patch yet, but we were
planning to remove p->running altogether:

https://lore.kernel.org/r/20231110200241.20679-1-farosas@suse.de

