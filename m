Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F3CCD11BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxiE-0003sL-Ag; Wed, 20 Mar 2024 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmxiB-0003s8-J2
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:18:39 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmxi9-0000e3-UV
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:18:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F6FC346B2;
 Wed, 20 Mar 2024 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710947916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+oF9V9AbTwdGT7kc6KUZJ0A+tEE0UPUgYOezGRpYrP0=;
 b=psjv4IogLHd1dcg3cSiCXQgsY+n62LtgxFYXlnEd+QESxDhQ+Fu5OBQR/WWSOieLSnUyyY
 OAyVpXpRGm5uNFPM3ihwv+76bXFQzewL9UWmX/3Xe784zLQoWu9K+OoEs01Vsc6AWPYwRT
 OqUplFt7/M0GJq+OPutc3NlCOzY9TUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710947916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+oF9V9AbTwdGT7kc6KUZJ0A+tEE0UPUgYOezGRpYrP0=;
 b=c/ZXBKkPpEEOVW0q4pEVU5qq00+GFA42WgKscFHnoEb6mrakEjL3G7hJrMLGXQUm6rVdM8
 /LxJi0X810HyIWCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710947916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+oF9V9AbTwdGT7kc6KUZJ0A+tEE0UPUgYOezGRpYrP0=;
 b=psjv4IogLHd1dcg3cSiCXQgsY+n62LtgxFYXlnEd+QESxDhQ+Fu5OBQR/WWSOieLSnUyyY
 OAyVpXpRGm5uNFPM3ihwv+76bXFQzewL9UWmX/3Xe784zLQoWu9K+OoEs01Vsc6AWPYwRT
 OqUplFt7/M0GJq+OPutc3NlCOzY9TUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710947916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+oF9V9AbTwdGT7kc6KUZJ0A+tEE0UPUgYOezGRpYrP0=;
 b=c/ZXBKkPpEEOVW0q4pEVU5qq00+GFA42WgKscFHnoEb6mrakEjL3G7hJrMLGXQUm6rVdM8
 /LxJi0X810HyIWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF74A136CD;
 Wed, 20 Mar 2024 15:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K8BcHUv++mWOUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 20 Mar 2024 15:18:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com,
 bryan.zhang@bytedance.com, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v5 2/7] migration/multifd: put IOV initialization into
 compression method
In-Reply-To: <20240319164527.1873891-3-yuan1.liu@intel.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-3-yuan1.liu@intel.com>
Date: Wed, 20 Mar 2024 12:18:32 -0300
Message-ID: <87bk79lynr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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
Authentication-Results: smtp-out1.suse.de;
	none
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

> Different compression methods may require different numbers of IOVs.
> Based on streaming compression of zlib and zstd, all pages will be
> compressed to a data block, so two IOVs are needed for packet header
> and compressed data block.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  migration/multifd-zlib.c | 4 ++++
>  migration/multifd-zstd.c | 6 +++++-
>  migration/multifd.c      | 8 +++++---
>  3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> index 99821cd4d5..8095ef8e28 100644
> --- a/migration/multifd-zlib.c
> +++ b/migration/multifd-zlib.c
> @@ -70,6 +70,10 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
>          goto err_free_zbuff;
>      }
>      p->compress_data = z;
> +
> +    assert(p->iov == NULL);
> +    /* For packet header and zlib streaming compression block */
> +    p->iov = g_new0(struct iovec, 2);
>      return 0;
>  
>  err_free_zbuff:
> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> index 02112255ad..9c9217794e 100644
> --- a/migration/multifd-zstd.c
> +++ b/migration/multifd-zstd.c
> @@ -52,7 +52,6 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
>      struct zstd_data *z = g_new0(struct zstd_data, 1);
>      int res;
>  
> -    p->compress_data = z;
>      z->zcs = ZSTD_createCStream();
>      if (!z->zcs) {
>          g_free(z);
> @@ -77,6 +76,11 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
>          error_setg(errp, "multifd %u: out of memory for zbuff", p->id);
>          return -1;
>      }
> +    p->compress_data = z;
> +
> +    assert(p->iov == NULL);
> +    /* For packet header and zstd streaming compression block */
> +    p->iov = g_new0(struct iovec, 2);
>      return 0;
>  }
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0179422f6d..5155e02ae3 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1181,9 +1181,11 @@ bool multifd_send_setup(void)
>              p->packet = g_malloc0(p->packet_len);
>              p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>              p->packet->version = cpu_to_be32(MULTIFD_VERSION);
> -
> -            /* We need one extra place for the packet header */
> -            p->iov = g_new0(struct iovec, page_count + 1);
> +            /* IOVs are initialized in send_setup of compression method */
> +            if (!migrate_multifd_compression()) {
> +                /* We need one extra place for the packet header */
> +                p->iov = g_new0(struct iovec, page_count + 1);
> +            }

This^ should go into nocomp_send_setup:

static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
{
    if (migrate_zero_copy_send()) {
        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
    }

    if (multifd_use_packets()) {
        /* We need one extra place for the packet header */
        p->iov = g_new0(struct iovec, p->page_count + 1);
    } else {
        p->iov = g_new0(struct iovec, p->page_count);
    }

    return 0;
}

>          } else {
>              p->iov = g_new0(struct iovec, page_count);
>          }

