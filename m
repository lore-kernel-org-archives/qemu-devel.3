Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FD4D6ACF5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 12:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWCs3-00009s-U3; Thu, 18 Dec 2025 07:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWCs2-00009U-Fd
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:12:38 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWCrz-0006Pw-8t
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:12:37 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4BF25BE15;
 Thu, 18 Dec 2025 12:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766059951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkQKyQus8yDXS/76xhLuFZMwrZEwbEKoz52RMqrJaNI=;
 b=vQrfzXU2F6ZeVqnrVIT1dQhcbspSx9wzH8269PivSVNX1LlQZmQqUQbz8eQ82ByxPlAXTj
 2aueqhrq7mRVXMKXxctLfBWZKGxls0JqYwB1ge9roBbaOid0IS6r0B0F3HVc3W9ncJeGgR
 J4PGc5u1jZTtBwLJpnJHZX+6FIz7+rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766059951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkQKyQus8yDXS/76xhLuFZMwrZEwbEKoz52RMqrJaNI=;
 b=ASkH0WiLznJOjyxYmTYLnWsWGF/sOb52/vX6Lx7s2UY0px3qU9j7vEHbHSWqCHlHfmN/1U
 QwRgmal438X/u6BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766059950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkQKyQus8yDXS/76xhLuFZMwrZEwbEKoz52RMqrJaNI=;
 b=uRu3IvYg60EIeQnJlKJWkgxlS0LCTA2sWxlVUKuZFHsrazM4sW2CgpIO6p+6m6q46TrEpM
 VxCHKA0VUPi3XEZZBWEjEbZqqVQz5h7vpt4F9FVQgYDtrgSl1uJY6J5EcRpmKXRcZjC3xY
 LsIwF4hb0Ds4tjy0k5jerOwVeNJ4c2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766059950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkQKyQus8yDXS/76xhLuFZMwrZEwbEKoz52RMqrJaNI=;
 b=o8jZFEGZSjHCUuv1VNYZeufjDgYhNJP9gtVIeFK69v2pLrqgW1RnfIIMeI1mb1LwThiccp
 Wndjbz8K5+ZUNzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A3393EA63;
 Thu, 18 Dec 2025 12:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9QHwBq7vQ2lVbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Dec 2025 12:12:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, peterx@redhat.com, david@kernel.org,
 philmd@linaro.org, Chuang Xu <xuchuangxclwt@bytedance.com>
Subject: Re: [PATCH v4 1/1] migration: merge fragmented clear_dirty ioctls
In-Reply-To: <20251218114220.83354-1-xuchuangxclwt@bytedance.com>
References: <20251218114220.83354-1-xuchuangxclwt@bytedance.com>
Date: Thu, 18 Dec 2025 09:12:27 -0300
Message-ID: <878qf00z10.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, bytedance.com:email]
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

"Chuang Xu" <xuchuangxclwt@bytedance.com> writes:

> In our long-term experience in Bytedance, we've found that under
> the same load, live migration of larger VMs with more devices is
> often more difficult to converge (requiring a larger downtime limit).
>
> Through some testing and calculations, we conclude that bitmap sync time
> affects the calculation of live migration bandwidth.
>
> When the addresses processed are not aligned, a large number of
> clear_dirty ioctl occur (e.g. a 4MB misaligned memory can generate
> 2048 clear_dirty ioctls from two different memory_listener),
> which increases the time required for bitmap_sync and makes it
> more difficult for dirty pages to converge.
>
> For a 64C256G vm with 8 vhost-user-net(32 queue per nic) and
> 16 vhost-user-blk(4 queue per blk), the sync time is as high as *73ms*
> (tested with 10GBps dirty rate, the sync time increases as the dirty
> page rate increases), Here are each part of the sync time:
>
> - sync from kvm to ram_list: 2.5ms
> - vhost_log_sync:3ms
> - sync aligned memory from ram_list to RAMBlock: 5ms
> - sync misaligned memory from ram_list to RAMBlock: 61ms
>
> Attempt to merge those fragmented clear_dirty ioctls, then syncing
> misaligned memory from ram_list to RAMBlock takes only about 1ms,
> and the total sync time is only *12ms*.
>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

