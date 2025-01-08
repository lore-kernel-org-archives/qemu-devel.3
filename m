Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD85E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVVnk-0005if-HR; Wed, 08 Jan 2025 08:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVVni-0005iG-I7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:08:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVVnc-0004vk-MC
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736341718;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qDAUS3kkFkYzGFs5BZAOmNVsGsLHlNZ8yXWpMBJUw1g=;
 b=Rj27KIYWOSEEkBxeccKObHYAKPH8kQUFhwEG1r2tckznnYXbYe0JTt8L2J0ohSjW737vDx
 1CP6IgNSoE/KPeAdu94XYJFrozlN06DP7XZbjPWQ7LOetyvsM/cytAxLrC/yyj6FcvoQJU
 v6JEEVRzo1ghwJoyc2FMz437iUZoGc4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-vPZKVXkzMamdQiiB23MCsg-1; Wed,
 08 Jan 2025 08:08:35 -0500
X-MC-Unique: vPZKVXkzMamdQiiB23MCsg-1
X-Mimecast-MFC-AGG-ID: vPZKVXkzMamdQiiB23MCsg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F6D21956060; Wed,  8 Jan 2025 13:08:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.103])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0801F300018D; Wed,  8 Jan 2025 13:08:29 +0000 (UTC)
Date: Wed, 8 Jan 2025 13:08:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Message-ID: <Z354ytFhuJnohBXx@redhat.com>
References: <20250108125751.199929-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108125751.199929-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 08, 2025 at 06:27:50PM +0530, Ani Sinha wrote:
> At present, the libqos/fw_cfg.c library does not support the modern DMA
> interface which is required to write to the fw_cfg files. It only uses the IO
> interface. Implement read and write methods based on DMA. This will enable
> developers to write tests that writes to the fw_cfg file(s). The structure of
> the code is taken from edk2 fw_cfg implementation. It has been tested by
> writing a qtest that writes to a fw_cfg file. This test will be part of a
> future patch series.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/libqos/fw_cfg.c | 204 ++++++++++++++++++++++++++++++++----
>  tests/qtest/libqos/fw_cfg.h |   5 +
>  2 files changed, 186 insertions(+), 23 deletions(-)

> +static bool
> +find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
> +                uint16_t *sel, uint32_t *size)
> +{
> +    unsigned char *filesbuf = NULL;

Use g_autofree here instead of later g_free.

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
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> +    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));

I'm not familiar with fwcfg data format, but I'm wondering
what the initial 'uint32_t' data field is that you're skipping
over, and whether its value should be validated before this
loop ?

> +    for (i = 0; i < count; ++i, ++pdir_entry) {
> +        if (!strcmp(pdir_entry->name, filename)) {
> +            *size = be32_to_cpu(pdir_entry->size);
> +            *sel = be16_to_cpu(pdir_entry->select);
> +            found = true;
> +            break;
> +        }
> +    }
> +
> +    g_free(filesbuf);
> +    return found;
> +}

> +
>  /*
>   * The caller need check the return value. When the return value is
>   * nonzero, it means that some bytes have been transferred.
> @@ -73,37 +168,100 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>   * populated, it has received only a starting slice of the fw_cfg file.
>   */
>  size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> -                      void *data, size_t buflen)
> +                        void *data, size_t buflen)
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

I'd recommend refactoring of existnig code, be a separate commit
from the newly added functionality.

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
> +    return (size_t) len;

The size_t cast is redundant, since we know sizeof(size_t)
will be >= sizeof(uint32_t) on all platforms

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
> +    return (size_t) len;

Another redundant cast


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


