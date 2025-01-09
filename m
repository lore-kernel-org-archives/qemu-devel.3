Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCCCE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 20:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVyiV-0004Np-SZ; Thu, 09 Jan 2025 15:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVyiQ-0004NL-As
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 15:01:14 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVyiO-0008FF-2p
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 15:01:14 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9418321101;
 Thu,  9 Jan 2025 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736452869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETT3IHM0hQKIWE8DOHBowLxjmr4v6qGk2SUNyMbwPF8=;
 b=icz0yDrVgoidGtZ4EqY4A+DXfGS7EQLtqkzGe2Jk6LBWnM5Lb1CvoAMCj5jVcVg2JtX8Lp
 6dIivhgpcryNHHCTjcvBtJgn/ijuB2XUCkED/IlR74BlOAJnitnhZqrHvemX6bN6T5O+Os
 YJTVyk3I/Xxk87jNKg5TPxm5slf4S1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736452869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETT3IHM0hQKIWE8DOHBowLxjmr4v6qGk2SUNyMbwPF8=;
 b=t/oq+rYaIss4JHGJAsNe5/dR6DWl1c9Wqn6W24A7MhxG0LVjYf6WBwALeraEeYDK8SS2eU
 m6pJgjJramqv0vBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736452868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETT3IHM0hQKIWE8DOHBowLxjmr4v6qGk2SUNyMbwPF8=;
 b=SORqdye33o8y8uq7KcVzZUl9On2GOAqU8YnaPK5ltKvBvYvIxAkh/owtzP6LtfJa+iMqcb
 3XgeQYg2CkTuAUfNVTab7dzXY19lMZnIgqw+m57NQGVLp/cgDnCXiMUWVzLTS36e/1uEk4
 rZiQOpSiR4bFmMb9MPeTRIft9L0uIRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736452868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETT3IHM0hQKIWE8DOHBowLxjmr4v6qGk2SUNyMbwPF8=;
 b=ymmnK0djF4gkK5fYRejwnJx6P4RijnPKIyX5/4BRJBXtfjZKhoz2QtlfjI3EHVHCcwlpre
 ACz/rGs1eM2KPhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1834313876;
 Thu,  9 Jan 2025 20:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ennTMwMrgGerQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 20:01:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ani Sinha <anisinha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, armbru@redhat.com, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/2] libqos/fw_cfg: refactor file directory iteraton
 to make it more reusable
In-Reply-To: <20250109074929.252339-2-anisinha@redhat.com>
References: <20250109074929.252339-1-anisinha@redhat.com>
 <20250109074929.252339-2-anisinha@redhat.com>
Date: Thu, 09 Jan 2025 17:01:05 -0300
Message-ID: <87ldvjeozi.fsf@suse.de>
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
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Ani Sinha <anisinha@redhat.com> writes:

> fw-cfg file directory iteration code can be used by other functions that may
> want to implement fw-cfg file operations. Refactor it into a smaller helper
> so that it can be reused.
>
> No functional change.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/libqos/fw_cfg.c | 63 ++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 22 deletions(-)
>
> diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> index 89f053ccac..f1ed4898f7 100644
> --- a/tests/qtest/libqos/fw_cfg.c
> +++ b/tests/qtest/libqos/fw_cfg.c
> @@ -60,6 +60,39 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>      qtest_writew(fw_cfg->qts, fw_cfg->base, key);
>  }
>  
> +static bool
> +find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
> +                uint16_t *sel, uint32_t *size)
> +{
> +    g_autofree unsigned char *filesbuf = NULL;
> +    uint32_t count;
> +    size_t dsize;
> +    FWCfgFile *pdir_entry;
> +    uint32_t i;
> +    bool found = false;
> +
> +    *size = 0;
> +    *sel = 0;
> +
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> +    count = be32_to_cpu(count);
> +    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
> +    filesbuf = g_malloc(dsize);
> +    g_assert(filesbuf);

g_malloc already aborts the program if the allocation fails.

> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> +    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
> +    for (i = 0; i < count; ++i, ++pdir_entry) {
> +        if (!strcmp(pdir_entry->name, filename)) {
> +            *size = be32_to_cpu(pdir_entry->size);
> +            *sel = be16_to_cpu(pdir_entry->select);
> +            found = true;
> +            break;
> +        }
> +    }
> +
> +    return found;
> +}
> +
>  /*
>   * The caller need check the return value. When the return value is
>   * nonzero, it means that some bytes have been transferred.
> @@ -75,32 +108,18 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>  size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>                        void *data, size_t buflen)
>  {
> -    uint32_t count;
> -    uint32_t i;
> -    unsigned char *filesbuf = NULL;
> -    size_t dsize;
> -    FWCfgFile *pdir_entry;
>      size_t filesize = 0;
> +    uint32_t len;
> +    uint16_t sel;
>  
> -    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> -    count = be32_to_cpu(count);
> -    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
> -    filesbuf = g_malloc(dsize);
> -    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> -    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
> -    for (i = 0; i < count; ++i, ++pdir_entry) {
> -        if (!strcmp(pdir_entry->name, filename)) {
> -            uint32_t len = be32_to_cpu(pdir_entry->size);
> -            uint16_t sel = be16_to_cpu(pdir_entry->select);
> -            filesize = len;
> -            if (len > buflen) {
> -                len = buflen;
> -            }
> -            qfw_cfg_get(fw_cfg, sel, data, len);
> -            break;
> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
> +        filesize = len;
> +        if (len > buflen) {
> +            len = buflen;
>          }
> +        qfw_cfg_get(fw_cfg, sel, data, len);
>      }
> -    g_free(filesbuf);
> +
>      return filesize;
>  }

