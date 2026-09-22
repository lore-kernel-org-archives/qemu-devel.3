Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91CEC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zlJ-0004d7-Nc; Tue, 22 Sep 2026 08:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zl8-0004Z8-Rj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:38:07 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zl3-0000dg-2y
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:38:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 268E21F848;
 Tue, 22 Sep 2026 12:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790080675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IksqAk/UYz7CDnCB3k/8pkzHgBwXeHt0ttSyc06TZnE=;
 b=J9LMgL3fDgzajkelDGbv4MQUu61II0o/gwrfvefs6CXghBjLVF8S1OTTG5BUH+XNpQVe1d
 XhePfxnKkFH7cTBAVn80DTkGk+G45oPjXVzsc3espnde1koK19wNhGRVfTe8QFuhuqTDcR
 qxvaMcELW0xF0ep9NJCkhq6LUGr2zD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790080675;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IksqAk/UYz7CDnCB3k/8pkzHgBwXeHt0ttSyc06TZnE=;
 b=+AAjXomqsC53+w1X19QiwXgS+RiaRrZbFO06NhwyiIOYe7S4FS+3eq2K3ZsSpws2X4LVjx
 UHI8aVANH0qkfVBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790080671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IksqAk/UYz7CDnCB3k/8pkzHgBwXeHt0ttSyc06TZnE=;
 b=yhSNcF9FhX0CKCMyXV1nSJI1gV3FM7N3Rm8x4nbwNX07snDIGDs1naQ7U5JIe4gsUdE4sc
 cg4X/2h+hNYS2ya57KOKFJv0f9+wSQF1jS2AQGQ0T9rr0C3Mcj+AoKWfXwaMLIzaHtdfR6
 g2ijie4Tw5KTnah9uXmC+Z1Lqo+Nmh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790080671;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IksqAk/UYz7CDnCB3k/8pkzHgBwXeHt0ttSyc06TZnE=;
 b=qS6zli7HFl1LZJRj4KO0zWI43Z4Ua3vI63T1FEe1M18QADHxOcIa/PpPXlHi/ebrHESTUa
 qA/bM68nXaIrYCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C063136D9;
 Tue, 22 Sep 2026 12:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SK8/EJ52smoUPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Sep 2026 12:37:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-devel@nongnu.org,
 peterx@redhat.com
Cc: lizhijian@fujitsu.com, isyanfei.xu@gmail.com,
 jinpu.wang@cloud.ionos.com, Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [PATCH v3 0/4] migration/rdma: Allow multiple writes per chunk
In-Reply-To: <20260913062455.940447-1-yanfei.xu@bytedance.com>
References: <20260913062455.940447-1-yanfei.xu@bytedance.com>
Date: Tue, 22 Sep 2026 09:37:44 -0300
Message-ID: <871palbgx3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[fujitsu.com,gmail.com,cloud.ionos.com,bytedance.com];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

"Yanfei Xu" <yanfei.xu@bytedance.com> writes:

> This series improves RDMA migration throughput during iterative precopy
> and the iterable stop-copy phase by allowing multiple writes to be in
> flight for the same registration chunk.
>
> RDMA tracks RAM in registration chunks.  During the final iterable
> transfer, workloads can leave many scattered 4 KiB dirty pages, with
> multiple pages falling into the same chunk.  The current code waits for
> an earlier write to a chunk to complete before posting the next one.
> These serial completion waits can leave send queue capacity unused and
> limit RDMA bandwidth, increasing downtime.
>
> A ram_save_iterate() call can stop due to rate limiting before the RAM
> scanner completes a full round.  Therefore, it is not the correct
> boundary for ordering page versions.
>
> Add a return-valued notifier at the point where the RAM scanner wraps to
> the first RAMBlock.  Convert multifd's existing per-round
> synchronization to use this notifier, and register an RDMA notifier that
> flushes buffered writes and drains outstanding completions at the same
> boundary.
>
> This provides the explicit completion barrier before a newer version of
> a page can be sent.  The per-chunk wait is therefore unnecessary and is
> removed, together with the now-unused transit bitmap.
>
> The test configuration is:
>
>   RDMA chunk size:       32 MiB
>   Guest:                 32 vCPUs, 128 GiB RAM
>   Test runs:             10
>   Maximum HCA bandwidth: 100 Gbps
>   Workload:              idle
>
>
> Average result(pin-all=true)    Before       After
>   pin-all is true
>   Downtime                      396.7 ms     345.7 ms        ~12.9% improve
>   Final iterable bandwidth      9952.0 MiB/s 11639.10 MiB/s  ~17.0% improve
>
>
> Average results(pin-all=false)  Before       After
>   pin-all is false
>   Downtime                      248.7 ms     191.1 ms        ~23.2% improve
>   Final iterable bandwidth      5605.1 MiB/s 9826.0 MiB/s    ~75.3% improve
>
> "Final iterable bandwidth" is the bandwidth measured during
> qemu_savevm_state_complete_precopy_iterable().  Non-iterable data is
> not transferred using RDMA Write.
>
>
> Changes in v3:
>
>   - Optimze comments about RAMRoundNotifyData in patch1
>   - Collect Reviewed-by tags
>
> Changes in v2 (Suggested by Peter):
>
>   - Add a generic RAM round synchronization notifier.
>   - Drain RDMA writes at the RAM scan-round boundary.
>   - Remove the per-chunk wait and the unused transit bitmap.
>
> Yanfei Xu (4):
>   migration/ram: Add RAM round synchronization notifiers
>   migration/rdma: Drain writes at RAM round boundaries
>   migration/rdma: Allow multiple in-flight writes per chunk
>   migration/rdma: Remove unused transit bitmap
>
>  migration/multifd-nocomp.c | 24 ++++++++++
>  migration/ram.c            | 45 +++++++++++++++---
>  migration/ram.h            | 12 +++++
>  migration/rdma.c           | 97 ++++++++++++++++++++------------------
>  migration/trace-events     |  5 +-
>  5 files changed, 128 insertions(+), 55 deletions(-)

Queued, thanks!

