Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DCCC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxEK-0005GH-4S; Mon, 05 May 2025 10:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uBxEI-0005G1-BN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:55:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uBxEG-0005s6-E0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:55:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B4401F7B5;
 Mon,  5 May 2025 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746456934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kuQk06jPlnXHl4jkM1deCABhMuhpcbTGONmxdlOmgQ=;
 b=fI4mAzpHVeLKM/3/ENksvYjrnfUMrz49UODLHvNP8tc9vxXdCBgbJO9Xq+Npazn94lNLwW
 2K3XAxx4tw68DdxRdMHIW2ky5VBIpOlNKG/bAQNh+tsYa/gSc3ndIrGjaJjBqjlBryroks
 NAVX2NSnX7V2eFFCUmEn+dNkf/7KxKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746456934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kuQk06jPlnXHl4jkM1deCABhMuhpcbTGONmxdlOmgQ=;
 b=L2Cpm2I3x3gKSCM43gjTPEgx6QV4c30sG/di2DVmpTJ+zi/SkHSD2Ztj/pxn98xabghXkt
 VUJbwVXaKVyp6uDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746456934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kuQk06jPlnXHl4jkM1deCABhMuhpcbTGONmxdlOmgQ=;
 b=fI4mAzpHVeLKM/3/ENksvYjrnfUMrz49UODLHvNP8tc9vxXdCBgbJO9Xq+Npazn94lNLwW
 2K3XAxx4tw68DdxRdMHIW2ky5VBIpOlNKG/bAQNh+tsYa/gSc3ndIrGjaJjBqjlBryroks
 NAVX2NSnX7V2eFFCUmEn+dNkf/7KxKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746456934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kuQk06jPlnXHl4jkM1deCABhMuhpcbTGONmxdlOmgQ=;
 b=L2Cpm2I3x3gKSCM43gjTPEgx6QV4c30sG/di2DVmpTJ+zi/SkHSD2Ztj/pxn98xabghXkt
 VUJbwVXaKVyp6uDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB94B1372E;
 Mon,  5 May 2025 14:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C8JYKWXRGGhYUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 May 2025 14:55:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2] tests/qtest/libqos: Avoid double swapping when using
 modern virtio
In-Reply-To: <20250430132817.610903-1-thuth@redhat.com>
References: <20250430132817.610903-1-thuth@redhat.com>
Date: Mon, 05 May 2025 11:55:30 -0300
Message-ID: <877c2vgl99.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.979]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> The logic in the qvirtio_read/write function is rather a headache,
> involving byte-swapping when the target is big endian, just to
> maybe involve another byte-swapping  in the qtest_read/write
> function immediately afterwards (on the QEMU side). Let's do it in
> a more obvious way here: For virtio 1.0, we know that the values have
> to be little endian, so let's read/write the bytes in that well known
> order here.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  This also decreases our usage of qtest_big_endian() which might (or
>  might not) get helpful for the universal binary one day...
>
>  v2: Use leXX_to_cpu() / cpu_to_leXX() instead of doing it manually
>
>  tests/qtest/libqos/virtio.c | 44 ++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
> index 2e7979652fd..5a709d0bc59 100644
> --- a/tests/qtest/libqos/virtio.c
> +++ b/tests/qtest/libqos/virtio.c
> @@ -25,49 +25,63 @@
>   */
>  static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, uint64_t addr)
>  {
> -    uint16_t val = qtest_readw(qts, addr);
> +    uint16_t val;
>  
> -    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
> -        val = bswap16(val);
> +    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
> +        qtest_memread(qts, addr, &val, sizeof(val));
> +        val = le16_to_cpu(val);
> +    } else {
> +        val = qtest_readw(qts, addr);
>      }
> +
>      return val;
>  }
>  
>  static uint32_t qvirtio_readl(QVirtioDevice *d, QTestState *qts, uint64_t addr)
>  {
> -    uint32_t val = qtest_readl(qts, addr);
> +    uint32_t val;
>  
> -    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
> -        val = bswap32(val);
> +    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
> +        qtest_memread(qts, addr, &val, sizeof(val));
> +        val = le32_to_cpu(val);
> +    } else {
> +        val = qtest_readl(qts, addr);
>      }
> +
>      return val;
>  }
>  
>  static void qvirtio_writew(QVirtioDevice *d, QTestState *qts,
>                             uint64_t addr, uint16_t val)
>  {
> -    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
> -        val = bswap16(val);
> +    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
> +        val = cpu_to_le16(val);
> +        qtest_memwrite(qts, addr, &val, sizeof(val));
> +    } else {
> +        qtest_writew(qts, addr, val);
>      }
> -    qtest_writew(qts, addr, val);
>  }
>  
>  static void qvirtio_writel(QVirtioDevice *d, QTestState *qts,
>                             uint64_t addr, uint32_t val)
>  {
> -    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
> -        val = bswap32(val);
> +    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
> +        val = cpu_to_le32(val);
> +        qtest_memwrite(qts, addr, &val, sizeof(val));
> +    } else {
> +        qtest_writel(qts, addr, val);
>      }
> -    qtest_writel(qts, addr, val);
>  }
>  
>  static void qvirtio_writeq(QVirtioDevice *d, QTestState *qts,
>                             uint64_t addr, uint64_t val)
>  {
> -    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
> -        val = bswap64(val);
> +    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
> +        val = cpu_to_le64(val);
> +        qtest_memwrite(qts, addr, &val, sizeof(val));
> +    } else {
> +        qtest_writeq(qts, addr, val);
>      }
> -    qtest_writeq(qts, addr, val);
>  }
>  
>  uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t addr)

Queued to qtest-next, thanks!

