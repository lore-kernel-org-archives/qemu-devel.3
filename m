Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB71C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPOq-0006Mq-GX; Fri, 21 Aug 2026 09:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxPOo-0006HN-FC
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:35:10 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxPOm-00009R-Pv
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:35:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF0A6856B2;
 Fri, 21 Aug 2026 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787319303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vn7H2vGU5QAWOyCXJSOS0VoQ7NBJXw4HYZ/bXhJRivY=;
 b=ExjejKAJYKn9KOwrPPsTibmRgnlhlQ/33vujKLv+NzAU/1yFCl/gAetO5ekRmbJ7IniJ3n
 vcozH5s7pgKbtn4IXwKV8doThKB7VEk4IDLCvVdS51oI/eMf66KTNu3KFSkpyjTT0IRzhI
 GJdYDz6hC/Co17VCp/RFsOb6xI5cMPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787319303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vn7H2vGU5QAWOyCXJSOS0VoQ7NBJXw4HYZ/bXhJRivY=;
 b=Tfgza51j6eSY5tAfesVL7GGaUGhB2Qifnocp9ShM2M0LKDGyi6ein/PTbQaILFxzg8at6F
 zpJCN720lJPFnrBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787319298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vn7H2vGU5QAWOyCXJSOS0VoQ7NBJXw4HYZ/bXhJRivY=;
 b=erXhWjVaWdvWpq0Z5Vv5WBqibWn+HBroLcyK4cncGyQGjisGvSelsOxvr+0Uv7nArbD4gy
 i9qIUx5MUrCmHZLKaUMTXuyN0BMSSlX6sQAv4ruSB57nSbPXIGmEKqsyMufxTm0OjP6uF4
 vPGBzYH4kUHO6bu2Nb6fQiTYc0rUhyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787319298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vn7H2vGU5QAWOyCXJSOS0VoQ7NBJXw4HYZ/bXhJRivY=;
 b=SWlBQLubjKX4cktz3JtURE0AQXajT//rbWtF2MMKu3rUHTK5aBseKveQ+qYUzrCC73y4sq
 FkYMDk/qcO/bSzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80E143329;
 Fri, 21 Aug 2026 13:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v0HGFAJUiGqCHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Aug 2026 13:34:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>, Samuel
 Zhang <guoqing.zhang@amd.com>, Yanfei Xu <yanfei.xu@bytedance.com>, Jinpu
 Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH v2 09/10] migration/rdma: Sanity check upper bound of
 register MR address
In-Reply-To: <20260820200322.3321036-10-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
 <20260820200322.3321036-10-peterx@redhat.com>
Date: Fri, 21 Aug 2026 10:34:52 -0300
Message-ID: <877bljlhqb.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:email, gitlab.com:url,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:email]
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

Peter Xu <peterx@redhat.com> writes:

> Before registration of RDMA ranges, QEMU destination checks for validity of
> current_addr no less than the target ramblock's start address.  But it
> didn't check for the upper bound to make sure the address is within the
> size of the ramblock.  Add it.
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4007
> Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index cf6688a4bc..d8953363fe 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3387,7 +3387,8 @@ int rdma_registration_handle(QEMUFile *f)
>                      goto err;
>                  }
>                  block = &(rdma->local_ram_blocks.block[reg->current_index]);
> -                if (block->offset > reg->current_addr) {
> +                if (block->offset > reg->current_addr ||
> +                    block->offset + block->length <= reg->current_addr) {
>                      error_report("rdma: bad register address for block %s"
>                          " offset: %" PRIx64 " current_addr: %" PRIx64,
>                          block->block_name, block->offset,

Reviewed-by: Fabiano Rosas <farosas@suse.de>

