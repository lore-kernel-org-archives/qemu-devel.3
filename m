Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3952C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPKi-0004PF-3F; Fri, 21 Aug 2026 09:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxPKg-0004Oq-0L
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:30:54 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wxPKe-0007CZ-AQ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:30:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 47C9E3E7E;
 Fri, 21 Aug 2026 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787319045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FAIfH9p/fy9Ay559NoIl8wm1AQWIUEcj+0Nm4yJip8=;
 b=Va/j+fNjFuWnG/UZ3kLqEaVvjKAU2ULka+vasTC4bXiJzzh19YS3d3hW23WoRWNo0U90hS
 EAsW0rsqLXNDqpOIszmUOX7fOvW24AZvqGlTn22jEo/A0e0qTo3oTOVoiZ6/n6blFr7nIy
 Q61FCoxBAIEBabo+N3f7riJkYNMUgQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787319045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FAIfH9p/fy9Ay559NoIl8wm1AQWIUEcj+0Nm4yJip8=;
 b=GA0kEt8kwfe9vJIwsYzwSEKyljstRH0kTVqAwXf/kfFncL1XwwAvWpPU4RRQ+zTPNZu9tC
 CzAsaLQYdMQc0qDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UwEsaQm2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=boHxDPSp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787319041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FAIfH9p/fy9Ay559NoIl8wm1AQWIUEcj+0Nm4yJip8=;
 b=UwEsaQm2rEwmVeqM1fPZDgwUPKBKJp3HCZHz99CN5yRzJiSXSi5A6J0LSnAwoJagbQ1z1u
 vlQpYNVBorreB6u9SOUnlr49UrB8Svaew9JR219ND2FuoEl/L4e5C14Gf3qFDI8THqlHuk
 npyGxh/WY0g7px8c7sBGZip4H4KL5k8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787319041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FAIfH9p/fy9Ay559NoIl8wm1AQWIUEcj+0Nm4yJip8=;
 b=boHxDPSpXOcGj3cI8QbyaNBZc0fCgD9HzdqKfeUzmZK6zw38cKIQbHpaDfKKZ0blpBe6sK
 AhFkdZEMADU0xLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCCB7351D;
 Fri, 21 Aug 2026 13:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id foofKwBTiGoxGQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Aug 2026 13:30:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>, Samuel
 Zhang <guoqing.zhang@amd.com>, Yanfei Xu <yanfei.xu@bytedance.com>, Jinpu
 Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH v2 07/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST on buflen
In-Reply-To: <20260820200322.3321036-8-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
 <20260820200322.3321036-8-peterx@redhat.com>
Date: Fri, 21 Aug 2026 10:30:30 -0300
Message-ID: <87cxvblhxl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gitlab.com:url,suse.de:email,suse.de:mid,suse.de:dkim,ionos.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[gitlab.com:url,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,ionos.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 47C9E3E7E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

> RDMA header supports head.repeat on RDMA_CONTROL_REGISTER_REQUEST, which
> can include >1 memory registrations.  The current code did check over
> head.repeat to guard against RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE, however
> it didn't further check the buffer size (head.len) to make sure the
> received data is large enough to include the repeated entries.  Check it.
>
> This is almost only to harden this piece of code, in reality on source side
> QEMU never uses repeat>1..  However since it's a protocol, still keep it.
> Check the buffer size instead.
>
> In case it's not obvious to new RDMA readers: head.len should be the size
> RDMA has last received, as qemu_rdma_exchange_get_response() checked on it
> against byte_len (which was further fetched from ibv_wc.byte_len in
> qemu_rdma_poll()).
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4028
> Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 683c24ba4d..f7356e759f 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3360,6 +3360,14 @@ int rdma_registration_handle(QEMUFile *f)
>              reg_resp.repeat = head.repeat;
>              registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
>  
> +            /* Making sure the register buffers to read are valid */
> +            if (head.len != head.repeat * sizeof(RDMARegister)) {
> +                error_report("%s: Invalid RDMA_CONTROL_REGISTER_REQUEST "
> +                             "(head.repeat=%"PRIu32", head.len=%"PRIu32")",
> +                             __func__, head.repeat, head.len);
> +                goto err;
> +            }
> +
>              for (int count = 0; count < head.repeat; count++) {
>                  uint64_t chunk;
>                  uint8_t *chunk_start, *chunk_end;

Reviewed-by: Fabiano Rosas <farosas@suse.de>

