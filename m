Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A0EE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 20:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVzAa-0002Kd-B7; Thu, 09 Jan 2025 15:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVzAY-0002KL-7N
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 15:30:18 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVzAW-0004UA-3O
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 15:30:17 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D98401F456;
 Thu,  9 Jan 2025 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736454613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8YI2o3Ks6WjF6MvbTWLO+g5TVhkP3+Gf6nK4AM/X5U=;
 b=YGXd/N5PC6G57bK0o4O/0MFEWM3Z3Lf1Y9hZR0c36sIWUYVbwohfRMcWANCiYyuawEBQ5s
 AFhL+eAqC+gzqkk00gMrITUpA+ezyMdyrLizOKPrjA94DyodGzzG9gboYpB/YLQI5dr+Pj
 m2xu+StiPl11jQ4f49Y1nN80WY9BEWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736454613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8YI2o3Ks6WjF6MvbTWLO+g5TVhkP3+Gf6nK4AM/X5U=;
 b=7QX1rq+tmCKB0dY2Y4WR5DMGmgOxCS+vXq5sx4lv2BHsu37i3Cb3byszfbyxuJAt5IYS7g
 UvllRFFyjfEiauCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YGXd/N5P";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7QX1rq+t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736454613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8YI2o3Ks6WjF6MvbTWLO+g5TVhkP3+Gf6nK4AM/X5U=;
 b=YGXd/N5PC6G57bK0o4O/0MFEWM3Z3Lf1Y9hZR0c36sIWUYVbwohfRMcWANCiYyuawEBQ5s
 AFhL+eAqC+gzqkk00gMrITUpA+ezyMdyrLizOKPrjA94DyodGzzG9gboYpB/YLQI5dr+Pj
 m2xu+StiPl11jQ4f49Y1nN80WY9BEWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736454613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8YI2o3Ks6WjF6MvbTWLO+g5TVhkP3+Gf6nK4AM/X5U=;
 b=7QX1rq+tmCKB0dY2Y4WR5DMGmgOxCS+vXq5sx4lv2BHsu37i3Cb3byszfbyxuJAt5IYS7g
 UvllRFFyjfEiauCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FB2013A8B;
 Thu,  9 Jan 2025 20:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ooR5CdUxgGcUSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 20:30:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ani Sinha <anisinha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, armbru@redhat.com, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/2] tests/qtest/libqos: add DMA support for writing
 and reading fw_cfg files
In-Reply-To: <20250109074929.252339-3-anisinha@redhat.com>
References: <20250109074929.252339-1-anisinha@redhat.com>
 <20250109074929.252339-3-anisinha@redhat.com>
Date: Thu, 09 Jan 2025 17:30:10 -0300
Message-ID: <87ikqnenn1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D98401F456
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> At present, the libqos/fw_cfg.c library does not support the modern DMA
> interface which is required to write to the fw_cfg files. It only uses the IO
> interface. Implement read and write methods based on DMA. This will enable
> developers to write tests that writes to the fw_cfg file(s). The structure of
> the code is taken from edk2 fw_cfg implementation. It has been tested by
> writing a qtest that writes to a fw_cfg file. This test will be part of a
> future patch series.

What's the blocker for the rest of the series? It would be preferable to
merge it all together, rather than this going in first without any
users.

>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/libqos/fw_cfg.c | 138 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqos/fw_cfg.h |   6 +-
>  2 files changed, 143 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> index f1ed4898f7..b3ae97d32d 100644
> --- a/tests/qtest/libqos/fw_cfg.c
> +++ b/tests/qtest/libqos/fw_cfg.c
> @@ -14,6 +14,8 @@
>  
>  #include "qemu/osdep.h"
>  #include "fw_cfg.h"
> +#include "malloc-pc.h"
> +#include "libqos-malloc.h"
>  #include "../libqtest.h"
>  #include "qemu/bswap.h"
>  #include "hw/nvram/fw_cfg.h"
> @@ -60,6 +62,65 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>      qtest_writew(fw_cfg->qts, fw_cfg->base, key);
>  }
>  
> +static void
> +qfw_cfg_dma_transfer(QFWCFG *fw_cfg, QOSState *qs, void *address,
> +                     uint32_t length, uint32_t control)
> +{
> +    FWCfgDmaAccess access;
> +    uint32_t addr;
> +    uint64_t guest_access_addr;
> +    uint64_t gaddr;
> +
> +    /* create a data buffer in guest memory */
> +    gaddr = guest_alloc(&qs->alloc, length);
> +    g_assert(gaddr);

Same here, none of these asserts are needed.

> +
> +    if (control & FW_CFG_DMA_CTL_WRITE) {
> +        qtest_bufwrite(fw_cfg->qts, gaddr, address, length);
> +    }
> +    access.address = cpu_to_be64(gaddr);
> +    access.length = cpu_to_be32(length);
> +    access.control = cpu_to_be32(control);
> +
> +    /* now create a separate buffer in guest memory for 'access' */
> +    guest_access_addr = guest_alloc(&qs->alloc, sizeof(access));
> +    g_assert(guest_access_addr);
> +    qtest_bufwrite(fw_cfg->qts, guest_access_addr, &access, sizeof(access));
> +
> +    /* write lower 32 bits of address */
> +    addr = cpu_to_be32((uint32_t)(uintptr_t)guest_access_addr);
> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 8, addr);
> +
> +    /* write upper 32 bits of address */
> +    addr = cpu_to_be32((uint32_t)(uintptr_t)(guest_access_addr >> 32));
> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 4, addr);
> +
> +    g_assert(!(be32_to_cpu(access.control) & FW_CFG_DMA_CTL_ERROR));
> +
> +    if (control & FW_CFG_DMA_CTL_READ) {
> +        qtest_bufread(fw_cfg->qts, gaddr, address, length);
> +    }
> +
> +    guest_free(&qs->alloc, guest_access_addr);
> +    guest_free(&qs->alloc, gaddr);
> +}
> +
> +static void
> +qfw_cfg_write_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
> +                    void *buf, uint32_t len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_WRITE);
> +}
> +
> +static void
> +qfw_cfg_read_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
> +                   void *buf, uint32_t len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_READ);
> +}
> +
>  static bool
>  find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
>                  uint16_t *sel, uint32_t *size)
> @@ -123,6 +184,83 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>      return filesize;
>  }
>  
> +/*
> + * The caller need check the return value. When the return value is
> + * nonzero, it means that some bytes have been transferred.
> + *
> + * If the fw_cfg file in question is smaller than the allocated & passed-in
> + * buffer, then the first len bytes were read.
> + *
> + * If the fw_cfg file in question is larger than the passed-in
> + * buffer, then the return value explains how much was actually read.
> + *
> + * It is illegal to call this function if fw_cfg does not support DMA
> + * interface. The caller should ensure that DMA is supported before
> + * calling this function.
> + *
> + * Passed QOSState pointer qs must be initialized. qs->alloc must also be
> + * properly initialized.
> + */
> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
> +                         void *data, size_t buflen)
> +{
> +    uint32_t len = 0;
> +    uint16_t sel;
> +    uint32_t id;
> +
> +    g_assert(qs);
> +    /* check if DMA is supported since we use DMA for read */
> +    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
> +    g_assert(id & FW_CFG_VERSION_DMA);
> +
> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
> +        if (len > buflen) {
> +            len = buflen;
> +        }
> +        qfw_cfg_read_entry(fw_cfg, qs, sel, data, len);
> +    }
> +
> +    return len;
> +}
> +
> +/*
> + * The caller need check the return value. When the return value is
> + * nonzero, it means that some bytes have been transferred.
> + *
> + * If the fw_cfg file in question is smaller than the allocated & passed-in
> + * buffer, then the buffer has been partially written.
> + *
> + * If the fw_cfg file in question is larger than the passed-in
> + * buffer, then the return value explains how much was actually written.
> + *
> + * It is illegal to call this function if fw_cfg does not support DMA
> + * interface. The caller should ensure that DMA is supported before
> + * calling this function.
> + *
> + * Passed QOSState pointer qs must be initialized. qs->alloc must also be
> + * properly initialized.
> + */
> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
> +                          void *data, size_t buflen)
> +{
> +    uint32_t len = 0;
> +    uint16_t sel;
> +    uint32_t id;
> +
> +    g_assert(qs);
> +    /* write operation is only valid if DMA is supported */
> +    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
> +    g_assert(id & FW_CFG_VERSION_DMA);
> +
> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
> +        if (len > buflen) {
> +            len = buflen;
> +        }
> +        qfw_cfg_write_entry(fw_cfg, qs, sel, data, len);
> +    }
> +    return len;
> +}
> +
>  static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
>  {
>      uint8_t *ptr = data;
> diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
> index b0456a15df..6d6ff09725 100644
> --- a/tests/qtest/libqos/fw_cfg.h
> +++ b/tests/qtest/libqos/fw_cfg.h
> @@ -14,6 +14,7 @@
>  #define LIBQOS_FW_CFG_H
>  
>  #include "../libqtest.h"
> +#include "libqos.h"
>  
>  typedef struct QFWCFG QFWCFG;
>  
> @@ -33,7 +34,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
>  uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
>  size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>                          void *data, size_t buflen);
> -
> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
> +                          void *data, size_t buflen);
> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
> +                         void *data, size_t buflen);
>  QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
>  void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
>  QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);

