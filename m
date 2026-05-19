Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B750ACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 07:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPFFK-0008Lt-Hf; Tue, 19 May 2026 03:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wPFFF-0008LT-W3
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:52:06 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wPFFE-0001eo-1I
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:52:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D9E05DECC;
 Tue, 19 May 2026 07:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779177121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12wFIfHs7OJ13sbr6CnRgrTaz2VrBLtTDkirBPDQ+IU=;
 b=M8/qUfO83qGe9I19rMxd0OFpBM+Z1Yq0i+TvBeTVzGOQjxP8sQmuRm05Th/0r2HSHTzBO8
 pOLYpUtzjHsFA05M//KU6slWDRvkrE+cOS+gEqGEoUixUmmTE5pTsH7DlVseUq4FZD0Eoc
 1aWCoOnR0KdbnCPoWJnVvzMlUyfpnuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779177121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12wFIfHs7OJ13sbr6CnRgrTaz2VrBLtTDkirBPDQ+IU=;
 b=s6BsYHoD8MdSFCR/MCOzWkFvwrNT1oUfzJ72Hy0jtmWDFBSC0n4gEojBL0XrKhTEU1bbXl
 cyDN34l5xkpuUzAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779177121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12wFIfHs7OJ13sbr6CnRgrTaz2VrBLtTDkirBPDQ+IU=;
 b=M8/qUfO83qGe9I19rMxd0OFpBM+Z1Yq0i+TvBeTVzGOQjxP8sQmuRm05Th/0r2HSHTzBO8
 pOLYpUtzjHsFA05M//KU6slWDRvkrE+cOS+gEqGEoUixUmmTE5pTsH7DlVseUq4FZD0Eoc
 1aWCoOnR0KdbnCPoWJnVvzMlUyfpnuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779177121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12wFIfHs7OJ13sbr6CnRgrTaz2VrBLtTDkirBPDQ+IU=;
 b=s6BsYHoD8MdSFCR/MCOzWkFvwrNT1oUfzJ72Hy0jtmWDFBSC0n4gEojBL0XrKhTEU1bbXl
 cyDN34l5xkpuUzAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3C0A593A8;
 Tue, 19 May 2026 07:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UJr/IKAWDGo8ZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 May 2026 07:52:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Jia Jia <physicalmtea@gmail.com>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/6] tests/qtest/libqos: add qvirtqueue_reset_pool() for
 descriptor pool reset
In-Reply-To: <96cf23eea1204b34443218fe76bd4a5eaf9163e8.1779126034.git.qemu_oss@crudebyte.com>
References: <cover.1779126034.git.qemu_oss@crudebyte.com>
 <96cf23eea1204b34443218fe76bd4a5eaf9163e8.1779126034.git.qemu_oss@crudebyte.com>
Date: Tue, 19 May 2026 04:51:49 -0300
Message-ID: <87o6ib3kh6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[kaod.org,gmail.com,redhat.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Christian Schoenebeck <qemu_oss@crudebyte.com> writes:

> Add a function to reset the virtqueue descriptor pool state without
> reinitializing the device. This is useful for tests that issue a high
> number of requests and are limited by the simplified virtio test
> driver's descriptor tracking, which decrements num_free but never
> increments it back.
>
> The function is safe for synchronous test code where requests are
> sent and completed before the next request is issued.
>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Acked-by: Fabiano Rosas <farosas@suse.de>

> ---
>  tests/qtest/libqos/virtio.c | 23 +++++++++++++++++++++++
>  tests/qtest/libqos/virtio.h |  2 ++
>  2 files changed, 25 insertions(+)
>
> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
> index 010ff40834..ccbb325222 100644
> --- a/tests/qtest/libqos/virtio.c
> +++ b/tests/qtest/libqos/virtio.c
> @@ -464,6 +464,29 @@ bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
>      return true;
>  }
>  
> +/*
> + * qvirtqueue_reset_pool:
> + * @vq: The virtqueue to reset
> + *
> + * Reset the descriptor pool state without reinitializing the device.
> + * This is useful for tests that issue a high number of requests and
> + * are limited by the simplified virtio test driver's descriptor tracking,
> + * which decrements num_free but never increments it back.
> + *
> + * This is only safe for synchronous test code where requests are
> + * sent and completed before the next request is issued. Do not use
> + * with asynchronous code where multiple requests may be in-flight.
> + *
> + * Note: This only resets the available descriptor pool (free_head,
> + * num_free). The used ring position (last_used_idx) is NOT reset
> + * and should continue to track consumed responses across iterations.
> + */
> +void qvirtqueue_reset_pool(QVirtQueue *vq)
> +{
> +    vq->free_head = 0;
> +    vq->num_free = vq->size;
> +}
> +
>  void qvirtqueue_set_used_event(QTestState *qts, QVirtQueue *vq, uint16_t idx)
>  {
>      g_assert(vq->event);
> diff --git a/tests/qtest/libqos/virtio.h b/tests/qtest/libqos/virtio.h
> index e238f1726f..f17be0b9b6 100644
> --- a/tests/qtest/libqos/virtio.h
> +++ b/tests/qtest/libqos/virtio.h
> @@ -150,6 +150,8 @@ void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
>  bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
>                          uint32_t *len);
>  
> +void qvirtqueue_reset_pool(QVirtQueue *vq);
> +
>  void qvirtqueue_set_used_event(QTestState *qts, QVirtQueue *vq, uint16_t idx);
>  
>  void qvirtio_start_device(QVirtioDevice *vdev);

