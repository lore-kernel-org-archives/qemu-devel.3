Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080F8C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 14:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUoml-00075f-E4; Fri, 19 Jul 2024 10:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUomj-000758-Mf
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:40:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUomh-0007CP-0E
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:40:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2D0C1F7B3;
 Fri, 19 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721400033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqCE8VzQPIgrJ0SVAqJK4htKwo877e31dCR/fHcDr3Q=;
 b=erKHJG2pHqk2ATivKD03EmXi4Qd2x2kvzWgYr6TKVk6XiN5RQfMQWqGz0RS699Im1kICPG
 3l0xq+v4bxihwvBVSGOQkOt8xXup876uwY27pr1elt+rWB5gk0WHLo1cNL80RiI+6kO///
 mJ9IQfvJ9wUiaYG32dhnRtErF5jU21U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721400033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqCE8VzQPIgrJ0SVAqJK4htKwo877e31dCR/fHcDr3Q=;
 b=9g4ueRmZLMNlvTTnABc6NR5WQNecmIk7x1uP9G2QKQfbDUYS6uZC7+wqBFYe3mYmrBWo+6
 XzYdaq19KeYR1YDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721400032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqCE8VzQPIgrJ0SVAqJK4htKwo877e31dCR/fHcDr3Q=;
 b=QOBN9M1vrQ8wpVpOVSlgqqpjYRCkH8gU0NAxwksmR+GnLvOIVQ5ZhhvVz2Te7y2Cuo6JiT
 kho7SwP4F19G7KPNxDfPERqPM9Vi/l0AXgAMya/weJtDwcrjSyn5ubDrr0RIx4KMmYKzWY
 eHdGl/cLo1AbEJmUD5+uVRcom5FS0JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721400032;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqCE8VzQPIgrJ0SVAqJK4htKwo877e31dCR/fHcDr3Q=;
 b=HfoY7FP5PGOyUwEwQR7S9ZII2vigJ8R1siENSkM6ZfDwV4EdsTdDjDqVI2stsmuk8ZMkzX
 HvP1U+EGK8eoSyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B46F132CB;
 Fri, 19 Jul 2024 14:40:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y0fEDOB6mmZJJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jul 2024 14:40:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 5/7] migration/multifd: Isolate ram pages packet data
In-Reply-To: <20240620212111.29319-6-farosas@suse.de>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-6-farosas@suse.de>
Date: Fri, 19 Jul 2024 11:40:29 -0300
Message-ID: <87a5id1m3m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_THREE(0.00)[3]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Fabiano Rosas <farosas@suse.de> writes:

> While we cannot yet disentangle the multifd packet from page data, we
> can make the code a bit cleaner by setting the page-related fields in
> a separate function.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 104 +++++++++++++++++++++++++++++---------------
>  1 file changed, 68 insertions(+), 36 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index c4a952576d..6fe339b378 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -407,65 +407,64 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
>      g_free(pages);
>  }
>  
> -void multifd_send_fill_packet(MultiFDSendParams *p)
> +static void multifd_ram_fill_packet(MultiFDSendParams *p)
>  {
>      MultiFDPacket_t *packet = p->packet;
>      MultiFDPages_t *pages = p->data->opaque;
> -    uint64_t packet_num;
>      uint32_t zero_num = pages->num - pages->normal_num;
> -    int i;
>  
> -    packet->flags = cpu_to_be32(p->flags);
>      packet->pages_alloc = cpu_to_be32(pages->allocated);
>      packet->normal_pages = cpu_to_be32(pages->normal_num);
>      packet->zero_pages = cpu_to_be32(zero_num);
> -    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
> -
> -    packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
> -    packet->packet_num = cpu_to_be64(packet_num);
>  
>      if (pages->block) {
>          strncpy(packet->ramblock, pages->block->idstr, 256);
>      }
>  
> -    for (i = 0; i < pages->num; i++) {
> +    for (int i = 0; i < pages->num; i++) {
>          /* there are architectures where ram_addr_t is 32 bit */
>          uint64_t temp = pages->offset[i];
>  
>          packet->offset[i] = cpu_to_be64(temp);
>      }
>  
> -    p->packets_sent++;
>      p->total_normal_pages += pages->normal_num;
>      p->total_zero_pages += zero_num;
> +}
>  
> -    trace_multifd_send(p->id, packet_num, pages->normal_num, zero_num,
> +void multifd_send_fill_packet(MultiFDSendParams *p)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    uint64_t packet_num;
> +
> +    memset(packet, 0, p->packet_len);
> +
> +    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> +    packet->version = cpu_to_be32(MULTIFD_VERSION);
> +
> +    packet->flags = cpu_to_be32(p->flags);
> +    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
> +
> +    packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
> +    packet->packet_num = cpu_to_be64(packet_num);
> +
> +    p->packets_sent++;
> +
> +    if (p->data) {

This needs to be !(p->flags & MULTIFD_SYNC). In v2 I'll add it in a
separate patch to make it clear:

-->8--
From e0dd1e0f10b6adb5d419ff68c1ef3b76d2fcf1d4 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Fri, 19 Jul 2024 11:28:33 -0300
Subject: [PATCH] migration/multifd: Don't send ram data during SYNC

Skip saving and loading any ram data in the packet in the case of a
SYNC. This fixes a shortcoming of the current code which requires a
reset of the MultiFDPages_t fields right after the previous
pending_job finishes, otherwise the very next job might be a SYNC and
multifd_send_fill_packet() will put the stale values in the packet.

By not calling multifd_ram_fill_packet(), we can stop resetting
MultiFDPages_t in the multifd core and leave that to the client code.

Actually moving the reset function is not yet done because
pages->num==0 is used by the client code to determine whether the
MultiFDPages_t needs to be flushed. The subsequent patches will
replace that with a generic flag that is not dependent on
MultiFDPages_t.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3809890082..6e6e62d352 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -431,6 +431,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
     uint64_t packet_num;
+    bool sync_packet = p->flags & MULTIFD_FLAG_SYNC;
 
     memset(packet, 0, p->packet_len);
 
@@ -445,7 +446,9 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 
     p->packets_sent++;
 
-    multifd_ram_fill_packet(p);
+    if (!sync_packet) {
+        multifd_ram_fill_packet(p);
+    }
 
     trace_multifd_send(p->id, packet_num,
                        be32_to_cpu(packet->normal_pages),
@@ -556,7 +559,12 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
 
-    ret = multifd_ram_unfill_packet(p, errp);
+    if (p->flags & MULTIFD_FLAG_SYNC) {
+        p->normal_num = 0;
+        p->zero_num = 0;
+    } else {
+        ret = multifd_ram_unfill_packet(p, errp);
+    }
 
     trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
                        p->flags, p->next_packet_size);
-- 
2.35.3


