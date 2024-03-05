Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A5BC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 20:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbL1-0002FQ-HO; Tue, 05 Mar 2024 15:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhbKz-0002F9-Ov
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:24:33 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhbKx-0006Id-Sq
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:24:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD700353CD;
 Tue,  5 Mar 2024 20:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709670266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7MZNgJbiWqSHlD7JBQFyTbDKezrdmQ5/4OxQLncoGg=;
 b=UzJIkVySIN7RwpWP+YN7eN/hOdBMNMSqBjC/1R/xTjS1ABaqYfnAbJ7qyR2+yg3MtWRDGz
 ntXSgTSeDqO7hhI9eR7POgfDD5CMZBjo9rzJOGTr9Y7rFHg4YjfpKPDA3j1lu8CYOfavBd
 LQP7xg7dmTXJjL6ITY2fgR7LWwQqpFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709670266;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7MZNgJbiWqSHlD7JBQFyTbDKezrdmQ5/4OxQLncoGg=;
 b=vIBT9K+piPQ3pkKoA5cUgoZACt05f0ZrH9FCFwlj6JOByAEYeCOsmaJrDl2tqXEXItrhRC
 9Ej99g1ABVo4oqAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709670265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7MZNgJbiWqSHlD7JBQFyTbDKezrdmQ5/4OxQLncoGg=;
 b=hQy6lQlsGHQxYf17Z8WAH7UlA1E8RgMhg5ZeH9SekTXnzJ9WGHIOjTkInAZtYZjSf4AgBe
 1kc/Kl94l70daWtp7PS5dnob+oxDCQZ3N4IYn0xgxwzexv1LtQr+UT7loUi2/zzcd9LUsG
 /SPOFPPZAWQpekP7JdQlgZ0OnK+Q7yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709670265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7MZNgJbiWqSHlD7JBQFyTbDKezrdmQ5/4OxQLncoGg=;
 b=8RLqM+diJLoVvgcpcqstxBPNmI2sYugonUb3Lowp5kJ6HMSTBDalVrBQ59J5VU0pTnPgcb
 ohB4KQ8BZ7adIjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63D10139D0;
 Tue,  5 Mar 2024 20:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5xYZC3l/52U2PQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Mar 2024 20:24:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com,
 bryan.zhang@bytedance.com, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v4 2/8] migration/multifd: add get_iov_count in the
 multifd method
In-Reply-To: <20240304140028.1590649-3-yuan1.liu@intel.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
 <20240304140028.1590649-3-yuan1.liu@intel.com>
Date: Tue, 05 Mar 2024 17:24:22 -0300
Message-ID: <877cigig09.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Yuan Liu <yuan1.liu@intel.com> writes:

> the new function get_iov_count is used to get the number of
> IOVs required by a specified multifd method
>
> Different multifd methods may require different numbers of IOVs.
> Based on streaming compression of zlib and zstd, all pages will be
> compressed to a data block, so an IOV is required to send this data
> block. For no compression, each IOV is used to send a page, so the
> number of IOVs required is the same as the number of pages.

Let's just move the responsibility of allocating p->iov to the client
code. You can move the allocation into send_setup() and the free into
send_cleanup().

>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  migration/multifd-zlib.c | 18 +++++++++++++++++-
>  migration/multifd-zstd.c | 18 +++++++++++++++++-
>  migration/multifd.c      | 24 +++++++++++++++++++++---
>  migration/multifd.h      |  2 ++
>  4 files changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> index 012e3bdea1..35187f2aff 100644
> --- a/migration/multifd-zlib.c
> +++ b/migration/multifd-zlib.c
> @@ -313,13 +313,29 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Error **errp)
>      return 0;
>  }
>  
> +/**
> + * zlib_get_iov_count: get the count of IOVs
> + *
> + * For zlib streaming compression, all pages will be compressed into a data
> + * block, and an IOV is requested for sending this block.
> + *
> + * Returns the count of the IOVs
> + *
> + * @page_count: Indicate the maximum count of pages processed by multifd
> + */
> +static uint32_t zlib_get_iov_count(uint32_t page_count)
> +{
> +    return 1;
> +}
> +
>  static MultiFDMethods multifd_zlib_ops = {
>      .send_setup = zlib_send_setup,
>      .send_cleanup = zlib_send_cleanup,
>      .send_prepare = zlib_send_prepare,
>      .recv_setup = zlib_recv_setup,
>      .recv_cleanup = zlib_recv_cleanup,
> -    .recv_pages = zlib_recv_pages
> +    .recv_pages = zlib_recv_pages,
> +    .get_iov_count = zlib_get_iov_count
>  };
>  
>  static void multifd_zlib_register(void)
> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> index dc8fe43e94..25ed1add2a 100644
> --- a/migration/multifd-zstd.c
> +++ b/migration/multifd-zstd.c
> @@ -304,13 +304,29 @@ static int zstd_recv_pages(MultiFDRecvParams *p, Error **errp)
>      return 0;
>  }
>  
> +/**
> + * zstd_get_iov_count: get the count of IOVs
> + *
> + * For zstd streaming compression, all pages will be compressed into a data
> + * block, and an IOV is requested for sending this block.
> + *
> + * Returns the count of the IOVs
> + *
> + * @page_count: Indicate the maximum count of pages processed by multifd
> + */
> +static uint32_t zstd_get_iov_count(uint32_t page_count)
> +{
> +    return 1;
> +}
> +
>  static MultiFDMethods multifd_zstd_ops = {
>      .send_setup = zstd_send_setup,
>      .send_cleanup = zstd_send_cleanup,
>      .send_prepare = zstd_send_prepare,
>      .recv_setup = zstd_recv_setup,
>      .recv_cleanup = zstd_recv_cleanup,
> -    .recv_pages = zstd_recv_pages
> +    .recv_pages = zstd_recv_pages,
> +    .get_iov_count = zstd_get_iov_count
>  };
>  
>  static void multifd_zstd_register(void)
> diff --git a/migration/multifd.c b/migration/multifd.c
> index adfe8c9a0a..787402247e 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -209,13 +209,29 @@ static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
>      return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>  }
>  
> +/**
> + * nocomp_get_iov_count: get the count of IOVs
> + *
> + * For no compression, the count of IOVs required is the same as the count of
> + * pages
> + *
> + * Returns the count of the IOVs
> + *
> + * @page_count: Indicate the maximum count of pages processed by multifd
> + */
> +static uint32_t nocomp_get_iov_count(uint32_t page_count)
> +{
> +    return page_count;
> +}
> +
>  static MultiFDMethods multifd_nocomp_ops = {
>      .send_setup = nocomp_send_setup,
>      .send_cleanup = nocomp_send_cleanup,
>      .send_prepare = nocomp_send_prepare,
>      .recv_setup = nocomp_recv_setup,
>      .recv_cleanup = nocomp_recv_cleanup,
> -    .recv_pages = nocomp_recv_pages
> +    .recv_pages = nocomp_recv_pages,
> +    .get_iov_count = nocomp_get_iov_count
>  };
>  
>  static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
> @@ -998,6 +1014,8 @@ bool multifd_send_setup(void)
>      Error *local_err = NULL;
>      int thread_count, ret = 0;
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    /* We need one extra place for the packet header */
> +    uint32_t iov_count = 1;
>      uint8_t i;
>  
>      if (!migrate_multifd()) {
> @@ -1012,6 +1030,7 @@ bool multifd_send_setup(void)
>      qemu_sem_init(&multifd_send_state->channels_ready, 0);
>      qatomic_set(&multifd_send_state->exiting, 0);
>      multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
> +    iov_count += multifd_send_state->ops->get_iov_count(page_count);
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> @@ -1026,8 +1045,7 @@ bool multifd_send_setup(void)
>          p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>          p->packet->version = cpu_to_be32(MULTIFD_VERSION);
>          p->name = g_strdup_printf("multifdsend_%d", i);
> -        /* We need one extra place for the packet header */
> -        p->iov = g_new0(struct iovec, page_count + 1);
> +        p->iov = g_new0(struct iovec, iov_count);
>          p->page_size = qemu_target_page_size();
>          p->page_count = page_count;
>          p->write_flags = 0;
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 8a1cad0996..d82495c508 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -201,6 +201,8 @@ typedef struct {
>      void (*recv_cleanup)(MultiFDRecvParams *p);
>      /* Read all pages */
>      int (*recv_pages)(MultiFDRecvParams *p, Error **errp);
> +    /* Get the count of required IOVs */
> +    uint32_t (*get_iov_count)(uint32_t page_count);
>  } MultiFDMethods;
>  
>  void multifd_register_ops(int method, MultiFDMethods *ops);

