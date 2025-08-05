Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0B0C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujIDJ-0006LC-Nt; Tue, 05 Aug 2025 10:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujI7F-0000nX-19
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:54:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujI7C-0007bO-V9
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:54:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 575931F38A;
 Tue,  5 Aug 2025 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754402044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cv68eeUUR4VXTO8oQTgycc87Ji7Hyd46dA76WdrFGwE=;
 b=JWnLIExwNo6xaQAB8X/T0lv07aciLag9J0qIPlfG1bvb5RhPUJtCwWu+rZWFuOzO4Q717+
 07Y8GCZ8cryVfYKNIYVBT402XlZFXlTzWsP6FSV6NlF+HEmcv1NU5wN2974HR/ECp6pZb5
 N54U1Q4ln0ZtMKC2MHSHjUoi3AU4SAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754402044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cv68eeUUR4VXTO8oQTgycc87Ji7Hyd46dA76WdrFGwE=;
 b=NTonKPlExD9cLIV2mpiM8Tf9DRe2ldj4SZ6KJN9sXwdro+4/38lUhTQBc1wWh+cdNkYiQj
 E59t3f+GvyngdKBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JWnLIExw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NTonKPlE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754402044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cv68eeUUR4VXTO8oQTgycc87Ji7Hyd46dA76WdrFGwE=;
 b=JWnLIExwNo6xaQAB8X/T0lv07aciLag9J0qIPlfG1bvb5RhPUJtCwWu+rZWFuOzO4Q717+
 07Y8GCZ8cryVfYKNIYVBT402XlZFXlTzWsP6FSV6NlF+HEmcv1NU5wN2974HR/ECp6pZb5
 N54U1Q4ln0ZtMKC2MHSHjUoi3AU4SAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754402044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cv68eeUUR4VXTO8oQTgycc87Ji7Hyd46dA76WdrFGwE=;
 b=NTonKPlExD9cLIV2mpiM8Tf9DRe2ldj4SZ6KJN9sXwdro+4/38lUhTQBc1wWh+cdNkYiQj
 E59t3f+GvyngdKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C295313A55;
 Tue,  5 Aug 2025 13:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QTgOIfsMkmi8JAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Aug 2025 13:54:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hamza Khan <hamza.khan@nutanix.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
In-Reply-To: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
Date: Tue, 05 Aug 2025 10:54:01 -0300
Message-ID: <87cy993mdi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 575931F38A
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Tap and vhost devices can be preserved during cpr-transfer using
> traditional live migration methods, wherein the management layer
> creates new interfaces for the target and fiddles with 'ip link'
> to deactivate the old interface and activate the new.
>
> However, CPR can simply send the file descriptors to new QEMU,
> with no special management actions required.  The user enables
> this behavior by specifing '-netdev tap,cpr=on'.  The default
> is cpr=off.
>
> Steve Sistare (8):
>   migration: stop vm earlier for cpr
>   migration: cpr setup notifier
>   vhost: reset vhost devices for cpr
>   cpr: delete all fds
>   Revert "vhost-backend: remove vhost_kernel_reset_device()"
>   tap: common return label
>   tap: cpr support
>   tap: postload fix for cpr
>
>  qapi/net.json             |   5 +-
>  include/hw/virtio/vhost.h |   1 +
>  include/migration/cpr.h   |   3 +-
>  include/net/tap.h         |   1 +
>  hw/net/virtio-net.c       |  20 +++++++
>  hw/vfio/device.c          |   2 +-
>  hw/virtio/vhost-backend.c |   6 ++
>  hw/virtio/vhost.c         |  32 +++++++++++
>  migration/cpr.c           |  24 ++++++--
>  migration/migration.c     |  38 ++++++++-----
>  net/tap-win32.c           |   5 ++
>  net/tap.c                 | 141 +++++++++++++++++++++++++++++++++++-----------
>  12 files changed, 223 insertions(+), 55 deletions(-)

Hi Steve,

Patches 1-2 seem to potentially interact with your arm pending
interrupts fix. Do we want them together?

