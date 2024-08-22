Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBEDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 11:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5e9-0000Xa-Dp; Thu, 22 Aug 2024 07:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sh5e6-0000TD-0l
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sh5e3-0005jv-KS
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724324781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVs0nvpbM1qtEFRuYob12A7bImstyQw6UapXCvl7s1E=;
 b=X9Br2x8mXsIMBFGw5aGj0gpR13geIotNjfC/Vyllynd7qQyEHKn5+6QvCrYNeEAmBa6t/k
 QvJ2KAjkX4JSZmXfJ483OiESB9B+uE39DM92XANW9WOK6A1Roi5iOUw8KUEx5lCdm3arlG
 /gjieDV1PB5inzwrJCdN2COm8DPHc+8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-eH-StdgRNTyUKALLTZudbg-1; Thu, 22 Aug 2024 07:06:20 -0400
X-MC-Unique: eH-StdgRNTyUKALLTZudbg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3719ee7c72eso323814f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 04:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724324779; x=1724929579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cVs0nvpbM1qtEFRuYob12A7bImstyQw6UapXCvl7s1E=;
 b=XFmRJNf4hKpmMfBq/TjrD8XREBEsFWLRbWSqP7PdEO0PmYnxw9t9/0Pq79CIMSUXFQ
 Vcv1fxhffAkiudbKR8eleEV8c6l/2xiiJ/fpESNH+d7RIx4GoTrWYjyXhQk/sJf4wJF3
 m0msSY55Oq1nZ8aATBqRwfVymnEZ2k+eRJ1Qt5BghxcOifj9cin95CCJ2C+63uYMVCzo
 JK9J6/hmjNjH+w2AAqGmZGlMY4WGe+R8lL1qRdp2OrZCemYx25VhrU+iJNbEqq27gE/x
 mDxLc6AoD8c4JK5y4YP5tJcD3MZ1uLmIwTXWAg9cYzKjI0TDt8q0QxSo5SDPiMIJebm7
 dNiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNHI8m1pdn+tn+OM9gD+/5/mlqdxTZUoWjtcCwCbw/Gq7VYTX1M1FGOVqBbElbS/N/Hq8EpBI1tk6X@nongnu.org
X-Gm-Message-State: AOJu0Yxa7sTmOeXY3tGBztqcItPp+ZYIny0Gb7FQrFA6Z/7NW+EiTGfE
 OA+HtH342RL+iTuyRfNl6KvRZAhwkze5RL+LZD+Jus6Z0+BraxAkKCU/hWyTdjXdV9UiPeGQv14
 PAGgwCZs1pqD0KeuapX9qqhz3il+1srp9nS030f90Jx+85293xzCvL3cUgxyJKQZO9A39AHQj6v
 ZoPmvZpE8Cer8qTpfSyptr7Ea7e8g=
X-Received: by 2002:adf:fdcc:0:b0:367:8c65:3c9 with SMTP id
 ffacd0b85a97d-37308c0924dmr1004115f8f.2.1724324778904; 
 Thu, 22 Aug 2024 04:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs/jrI6v8vswOjlZ52eCpsV9abaKdPT1T3BZ1BA0ndzsqpRTtGnOzwjiCm0KAPCpvUlLSXIzNcFfCE3GhLfQE=
X-Received: by 2002:adf:fdcc:0:b0:367:8c65:3c9 with SMTP id
 ffacd0b85a97d-37308c0924dmr1004082f8f.2.1724324778342; Thu, 22 Aug 2024
 04:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
 <20240820170907.6788-5-yichen.wang@bytedance.com>
In-Reply-To: <20240820170907.6788-5-yichen.wang@bytedance.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 22 Aug 2024 16:36:01 +0530
Message-ID: <CAE8KmOzK=Qe3nJ_ReRmQr5hkUgoZe9nOBi5G0hByvG3oVuzG+g@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] migration: Introduce 'qatzip' compression method
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, 
 Xiaoning Ding <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello,

On Tue, 20 Aug 2024 at 22:40, Yichen Wang <yichen.wang@bytedance.com> wrote:
> +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    QatzipData *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +
> +    q = g_new0(QatzipData, 1);
> +    p->compress_data = q;
> +    /* We need one extra place for the packet header */
> +    p->iov = g_new0(struct iovec, 2);
> +
> +    /*
> +     * Initialize QAT device with software fallback by default. This allows
> +     * QATzip to use CPU path when QAT hardware reaches maximum throughput.
> +     */
> +    ret = qzInit(&q->sess, true);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzInit failed";
> +        goto err;
> +    }
> +
> +    ret = qzGetDefaultsDeflate(&params);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzGetDefaultsDeflate failed";
> +        goto err;
> +    }
> +
> +    /* Make sure to use configured QATzip compression level. */
> +    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
> +    ret = qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzSetupSessionDeflate failed";
> +        goto err;
> +    }
> +
> +    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
> +        err_msg = "packet size too large for QAT";
> +        goto err;
> +    }
> +
> +    q->in_len = MULTIFD_PACKET_SIZE;
> +    /*
> +     * PINNED_MEM is an enum from qatzip headers, which means to use
> +     * kzalloc_node() to allocate memory for QAT DMA purposes. When QAT device
> +     * is not available or software fallback is used, the malloc flag needs to
> +     * be set as COMMON_MEM.
> +     */
> +    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
> +    if (!q->in_buf) {
> +        q->in_buf = qzMalloc(q->in_len, 0, COMMON_MEM);
> +        if (!q->in_buf) {
> +            err_msg = "qzMalloc failed";
> +            goto err;
> +        }
> +    }
> +
> +    q->out_len = qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess);
> +    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        q->out_buf = qzMalloc(q->out_len, 0, COMMON_MEM);
> +        if (!q->out_buf) {
> +            err_msg = "qzMalloc failed";
> +            goto err;
> +        }
> +    }
> +
> +    return 0;
> +
> +err:
> +    error_setg(errp, "multifd %u: [sender] %s", p->id, err_msg);
> +    return -1;
> +}

* Need to release (g_free OR qatzip_send_cleanup) allocated memory in
the error (err:) path.


> +static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    QatzipData *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +
> +    q = g_new0(QatzipData, 1);
> +    p->compress_data = q;
> +
> +    /*
> +     * Initialize QAT device with software fallback by default. This allows
> +     * QATzip to use CPU path when QAT hardware reaches maximum throughput.
> +     */
> +    ret = qzInit(&q->sess, true);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzInit failed";
> +        goto err;
> +    }
> +
> +    ret = qzGetDefaultsDeflate(&params);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzGetDefaultsDeflate failed";
> +        goto err;
> +    }
> +
> +    ret = qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzSetupSessionDeflate failed";
> +        goto err;
> +    }
> +
> +    /*
> +     * Reserve extra spaces for the incoming packets. Current implementation
> +     * doesn't send uncompressed pages in case the compression gets too big.
> +     */
> +    q->in_len = MULTIFD_PACKET_SIZE * 2;
> +    /*
> +     * PINNED_MEM is an enum from qatzip headers, which means to use
> +     * kzalloc_node() to allocate memory for QAT DMA purposes. When QAT device
> +     * is not available or software fallback is used, the malloc flag needs to
> +     * be set as COMMON_MEM.
> +     */
> +    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
> +    if (!q->in_buf) {
> +        q->in_buf = qzMalloc(q->in_len, 0, COMMON_MEM);
> +        if (!q->in_buf) {
> +            err_msg = "qzMalloc failed";
> +            goto err;
> +        }
> +    }
> +
> +    q->out_len = MULTIFD_PACKET_SIZE;
> +    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        q->out_buf = qzMalloc(q->out_len, 0, COMMON_MEM);
> +        if (!q->out_buf) {
> +            err_msg = "qzMalloc failed";
> +            goto err;
> +        }
> +    }
> +
> +    return 0;
> +
> +err:
> +    error_setg(errp, "multifd %u: [receiver] %s", p->id, err_msg);
> +    return -1;
> +}

* Need to release (g_free OR qatzip_recv_cleanup) allocated memory in
the error (err:) path.

Thank you.
---
  - Prasad


