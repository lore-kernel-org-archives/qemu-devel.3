Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA8AC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPQb-00015Q-EQ; Fri, 21 Aug 2026 09:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxPQW-00014t-Kf
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:36:58 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxPQU-0000fT-9j
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:36:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87ECC3EDA;
 Fri, 21 Aug 2026 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787319407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+i+jZ98v8K3oaMP6alYTTUJY+vgpPjioce2J0+64xbo=;
 b=N30/Q4nDbYntUxd7BngdIiNEvRQ2V2tRi1DlUhSj6uRiWVSwD9p0GSnQiDa6G9EVpZcADz
 dmIxKtHY2bPKScZssXW8v3FQ5nAQQMXS6nkm068NaafwUzsG8eCXa8YJ4aOEvrqQ5qUXRw
 rBIPaw2qf1pJPTdDwBs73juwtV1HRMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787319407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+i+jZ98v8K3oaMP6alYTTUJY+vgpPjioce2J0+64xbo=;
 b=hph9lWRc0UgadJcEy+BeTwJkpCYXt7a9Qs/wYZJSOy8aNWC+GF7VkJtdtAaqvcQI1jiyfV
 ofwP4MqAjU5Pi7DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787319403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+i+jZ98v8K3oaMP6alYTTUJY+vgpPjioce2J0+64xbo=;
 b=oLtJHD5TiY2UFeAB9pG4blAEOyrY7J3EE90iEgwbHAEKQ35u+ApJZSSod69TZ6+vFgIUbn
 YGBSZlsI+RicXHVxSI6W4/1aVGtXiNwx5M7U0wILJICATSai89cvcNPAbcLGeiLmlCpOap
 MbyDE92rhGFP9GcprYzqbRUUs0A+u04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787319403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+i+jZ98v8K3oaMP6alYTTUJY+vgpPjioce2J0+64xbo=;
 b=+t9XqAq/wHssS0Acnfu0Q1/pzbZknyYHz7NGPvE53I2uraLMLx42LVJenBg8LLJkObYfjF
 YpC/AaNR90UsJDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28DF026F8;
 Fri, 21 Aug 2026 13:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Jge7OmpUiGp0HwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Aug 2026 13:36:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>, Samuel
 Zhang <guoqing.zhang@amd.com>, Yanfei Xu <yanfei.xu@bytedance.com>, Jinpu
 Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH v2 10/10] migration/rdma: Sanity check compress request
 ranges
In-Reply-To: <20260820200322.3321036-11-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
 <20260820200322.3321036-11-peterx@redhat.com>
Date: Fri, 21 Aug 2026 10:36:25 -0300
Message-ID: <874ignlhnq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, suse.de:mid, suse.de:email,
 ionos.com:email, imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> The offset/length ranges are not sanity checked in RDMA requests, add the
> checks.
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4005
> Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index d8953363fe..e976739fad 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3198,6 +3198,28 @@ static int dest_ram_sort_func(const void *a, const void *b)
>      return (a_index < b_index) ? -1 : (a_index != b_index);
>  }
>  
> +static bool rdma_compress_range_check(RDMALocalBlock *block,
> +                                      RDMACompress *comp)
> +{
> +    uint64_t block_end = block->offset + block->length;
> +    uint64_t comp_end;
> +
> +    if (uadd64_overflow(comp->offset, comp->length, &comp_end)) {
> +        goto fail;
> +    }
> +
> +    if (comp->offset < block->offset || comp_end > block_end) {
> +        goto fail;
> +    }
> +
> +    return true;
> +fail:
> +    error_report("%s: compress request range outside range"
> +                 " (block=%s, offset=%"PRIu64", length=%"PRIu64")",
> +                 __func__, block->block_name, comp->offset, comp->length);
> +    return false;
> +}
> +
>  /*
>   * During each iteration of the migration, we listen for instructions
>   * by the source VM to perform dynamic page registrations before they
> @@ -3277,7 +3299,9 @@ int rdma_registration_handle(QEMUFile *f)
>                  goto err;
>              }
>              block = &(rdma->local_ram_blocks.block[comp->block_idx]);
> -
> +            if (!rdma_compress_range_check(block, comp)) {
> +                goto err;
> +            }
>              host_addr = block->local_host_addr +
>                              (comp->offset - block->offset);
>              if (comp->value) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

