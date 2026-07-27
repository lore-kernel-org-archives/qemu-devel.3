Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10F8C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKlY-00065I-AE; Mon, 27 Jul 2026 08:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woKlW-000655-IZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woKlV-0003vj-24
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785156543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QSccd9kbOyU9AE2iGfpyrvWGfETrCr0o09sREo5WUI=;
 b=EahQs6MRKCUBZ8uCsTOSLRhZOj4Ja2Vwm9SYgU36kqypdoeOyFgg+HXKMZitfH9Vu7tL4H
 58cH2kaxPS1Kr5TE10mHHlN9gUnMCiZmOWnV/+31Kt371aj9qG0ogu6kgvcV9ohVue7pa/
 NVfuvsBK64QXvlQBvi/Xph/NeJcTE+w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-nqHfFojaMcWu_3cpaCWgEw-1; Mon, 27 Jul 2026 08:49:01 -0400
X-MC-Unique: nqHfFojaMcWu_3cpaCWgEw-1
X-Mimecast-MFC-AGG-ID: nqHfFojaMcWu_3cpaCWgEw_1785156540
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955d314945so19239945e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785156540; x=1785761340; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5QSccd9kbOyU9AE2iGfpyrvWGfETrCr0o09sREo5WUI=;
 b=J6ZdGNDNbap0ra5uSwKpPssaa4uX6vjdzOVfEDfxTRj1Rk431Pj+PW0kzr2FJ4Ent3
 2LzQnqiux9mxUN3BKR+bANJOgobtOSw2z+VbRyAFvcDFNdaJcmNOEEg3od9uR5qhI7tj
 FH1rKkvTC6YPFfiaB3m389CiWNlpAIlrgRXT4Qt+A+rePM3EFQfj3wCL6UG0MuSbXp06
 u9Hnrso6pd/9o5PPhjT7r0Fo5eNHDLDIK25B8WCnZe5PHVMfroCY2uwQbleLgt902twP
 STDxwGnlZLHQZthTd+si6QnX8BazsNvsWHU7m9tf2yLbpyah2wUx8HTddCb6WzeUvinD
 EjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785156540; x=1785761340;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5QSccd9kbOyU9AE2iGfpyrvWGfETrCr0o09sREo5WUI=;
 b=kRLU5C2wU4yLnzP1Vlll2iHMqiC0R6S18hV8Pu52/JGXTFhqCVGN8PL7SsJW+I1w28
 hQrV271QADDP8UVDb1CSVz0HDswdzoF7f+VVWXpPPW+/EL0Th1Z7qPo29ZzHUdbYst4L
 wctBh1o1LZzLL86IelJSxsId9ErbZ13AWHWn5aHhuW6sttcMWMs9i5pBVdsRvPyQQb/u
 y19r2jLMUlvQuStL/y/+TIldN6dZj0nV+PEDuSNg3kGuS33rNUEfLEcPHsUOriSb5z1J
 iBo2Hbwb/TXOKYSShOBTPHV8PNFcnp4wRYb2lhvoTG07SKEAwrf7voLdVIsvSch8jBlH
 q5Tg==
X-Gm-Message-State: AOJu0Yyo7FK1FxLumeKOf/Q7FVd026+9tK6SQb/m0SN3ClnHHd1Tj47N
 DpR7C8VRqy7C5sS/lTj+mit3ztVaWK/YO41wl8CEweMVAhGElpqeG/lP3j40oW1DpwkXRjnrPM7
 xEe2cP9wkTraxO/8Xybx+6jzMqZEhPrXETvui3Tj83+T7QnN/xjfWEdIc
X-Gm-Gg: AR+sD12J/1bf8c4QLtiMdgpEx+V1umpwtth9haFmFDqlMMZ3rcYetf1DUJg72bojIv8
 ZS1dStvSIR3Xf8aFzXK+pXM+OD4TQ1fyBWUFt+KK9qtNIwzT9w6zs9OtXbv/QjGDZ/bi1Ya0Fj4
 dS+IWff7rgvFwjNGUt43G4CsqfgQ2Isz29dTkb5jozSsvYulegaR2m8sZ/0fY3wJC3HOBLBRCq4
 lrUmNTXcqkJ3r6CavDpOOzVmVPSYHXCQZHrdZ5Jl2oo26121W2h5EFQ7A1/aVuIoOXfFfQzh/I5
 kxz+y+fenmWHG1sGpFxPlrinugJGDWVRsDb6LpsQWR5Pa2pi5Q0VM2zUL7CpXhWB99iKpiUF0yN
 ebBo79FcYtzvdZ7G+uh2/fw==
X-Received: by 2002:a7b:c3cb:0:b0:495:607e:5ee7 with SMTP id
 5b1f17b1804b1-496b571fef8mr71326125e9.17.1785156539700; 
 Mon, 27 Jul 2026 05:48:59 -0700 (PDT)
X-Received: by 2002:a7b:c3cb:0:b0:495:607e:5ee7 with SMTP id
 5b1f17b1804b1-496b571fef8mr71325885e9.17.1785156539119; 
 Mon, 27 Jul 2026 05:48:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5f35a1sm217136675e9.0.2026.07.27.05.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 05:48:58 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:48:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [PATCH] vhost: Reject oversized inflight migration buffers
Message-ID: <20260727084637-mutt-send-email-mst@kernel.org>
References: <CAHntc+O1jaJhj1_k6kTHDp7u_1DdPUCKZNA_AxWYh+SKraXS8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHntc+O1jaJhj1_k6kTHDp7u_1DdPUCKZNA_AxWYh+SKraXS8A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 27, 2026 at 05:45:47AM -0700, 김승중 wrote:
> The inflight buffer size is migrated as a uint64_t, but vmstate_size()
> reads VMS_VBUFFER sizes as int32_t. Values above INT32_MAX therefore
> become negative and are converted to a very large size_t while loading
> the buffer, allowing writes beyond the smaller memfd-backed mapping.
> 
> Reject sizes that cannot be represented by vmstate_size() before
> allocating the destination buffer.
> 
> Fixes: CVE-2026-6426

This CVE really shouldn't be there.

> Reported-by: Seungjung Kim <seungjung0711@gmail.com>
> Signed-off-by: Seungjung Kim <seungjung0711@gmail.com>

This doen't fix it properly, it only fixes values 2g to 4g, but above 4g
is still wrong.

A better fix here:
https://lore.kernel.org/all/9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com/

> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b52..82eb9407ae 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2022,11 +2022,18 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
>  static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
>  {
>      struct vhost_inflight *inflight = opaque;
> -
>      int fd = -1;

pls don't make unrelated changes like this.

> -    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> -                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> -                                  &fd, errp);
> +    void *addr;
> +
> +    if (inflight->size > INT32_MAX) {
> +        error_setg(errp, "inflight buffer size %" PRIu64
> +                   " exceeds maximum %d", inflight->size, INT32_MAX);
> +        return false;
> +    }
> +
> +    addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> +                            &fd, errp);
>      if (!addr) {
>          return false;
>      }
> -- 
> 2.50.1 (Apple Git-155)


