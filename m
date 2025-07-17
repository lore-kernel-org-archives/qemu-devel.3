Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC1BC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLGm-0006Oc-Mw; Thu, 17 Jul 2025 05:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucKz9-0000Kb-R0
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:33:03 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucKz7-0001jK-HL
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:33:03 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e4043c5b7so6512697b3.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752744779; x=1753349579; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2eDfCkJRKvCC4vrCEpJ6RDo2VY+OKvz+R0kL3RT7qaY=;
 b=ra0obK5uF64BgbTylf7CB2CAdahO5vTKkzkfGXRX8iXBrFh5L+FB5TTzeEDjzrQ+18
 HjOtrSYJRUkwujJ6FHHu4EoAlXBVtY+3wKqLt4+tAj2Y22RBRHT3s7SupvIo1jn+W1Ad
 4eey64uIDPOpI6HuQ8m9Fhl9Drv4mL/kThHro3sip0lvncaMY2oySPPWqowkpdJVG08U
 D0GP+PTN7/CMBlbvqFUTKkFVSWjpnLGwjYqiKnHvYGgzaTVZM/CRIqsGWj8KLD27IzEJ
 jSi2yZysMtwuDWaUTw5NSJitfqXZHj1yVJwmnHJOdZykKX2oOrSqKL9p3yKGcYC+Mw8C
 2Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752744779; x=1753349579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2eDfCkJRKvCC4vrCEpJ6RDo2VY+OKvz+R0kL3RT7qaY=;
 b=wdlQDpBY6x5BdQp2v+es1tM0N7W4y3zQPdHwTtIXM98ol5a1CE8dtNIhRpawvfclcG
 kPAxMDgVtMPZqNS1kkOkxPmvUXyktyP48ErECcLlFG1ojcqGrDOh/fZ7bsCqjz8JX1RM
 wj7yJ4d2GdUWAE1QWvEvzVBv/+l2GsRDuH0tVzDeU63wKXYXPhIjH9R/FrcBvftToakn
 sYrAQotzjYDgfr4VauggHXGr+9iEbHbMf+VDSc3HROfUPIVjK+2fGh2R9nYTcdCPg2Lb
 3f+Xtr2s7ZPdeGp1YNFEVWxIl0evuNTgqimXtWogeGNSrNvcvINhBL1DYzFVnobkhfm+
 LD3g==
X-Gm-Message-State: AOJu0YyydGPmf6+i+1q5bMQVulOjWlLVBq/g/3teqw3Fj4XlbLqa8qA+
 ujXrpOscQk2edaPmIXGiesxZWllLmtd+KvOZn1ziVUhu+blz0C7t0KQoKwZA031k4aJacLy2eoa
 MDTkHeY1HuRw7qFjEcs3q/NTQwW1DjzsTKph3HWED6y6x3qsgiVgI
X-Gm-Gg: ASbGnctOZ1MBO71F1pv27PSXesY6x28C2dj4pVmbh1uClDpdeRmHjwgZNB3UpqSvfpa
 OeY3WtIbD4r8r2YkztW5ljICN3jj5aiv59Lh0grWMpWH7a4zqnCscl7WQU2L2frFSjWf6Uu0P5y
 PVcl+RNYIhNc3OAYKQusuUuO1a+6RapF/hEKR3VWjZYpi/UUNgeEcobrjVpcSsrqT+6/vR0GqO5
 yUfgKxL
X-Google-Smtp-Source: AGHT+IE/7lRs6tu6otEFCHlyTfIbpz8Ei8U0Ju3LrkLJi7oBmYxxbFpBBIoxtep1g57FCP7BK5v5DNIS5VId0iPP18k=
X-Received: by 2002:a05:690c:34ca:b0:717:9ea1:ab2b with SMTP id
 00721157ae682-71837124ab4mr70982007b3.9.1752744779398; Thu, 17 Jul 2025
 02:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250715043524.21719-1-jasowang@redhat.com>
 <20250715043524.21719-14-jasowang@redhat.com>
In-Reply-To: <20250715043524.21719-14-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 10:32:48 +0100
X-Gm-Features: Ac12FXxbEtuRJ4plgNqG4Wr_AlwGiVu4i_zszCVENzi88W-S5tsf6-4xLwfs1_c
Message-ID: <CAFEAcA-VvzJN9AY2aezaV1-Zs8bqJjm7ExbYEO8pm=hC0U6wkQ@mail.gmail.com>
Subject: Re: [PULL V2 13/16] net/passt: Implement vhost-user backend support
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 15 Jul 2025 at 05:37, Jason Wang <jasowang@redhat.com> wrote:
>
> From: Laurent Vivier <lvivier@redhat.com>
>
> This commit adds support for the vhost-user interface to the passt
> network backend, enabling high-performance, accelerated networking for
> guests using passt.
>
> The passt backend can now operate in a vhost-user mode, where it
> communicates with the guest's virtio-net device over a socket pair
> using the vhost-user protocol. This offloads the datapath from the
> main QEMU loop, significantly improving network performance.
>
> When the vhost-user=on option is used with -netdev passt, the new
> vhost initialization path is taken instead of the standard
> stream-based connection.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Another couple of coverity issues:

> +static int passt_vhost_user_start(NetPasstState *s, VhostUserState *be)
> +{
> +    struct vhost_net *net = NULL;
> +    VhostNetOptions options;
> +
> +    options.backend_type = VHOST_BACKEND_TYPE_USER;
> +    options.net_backend = &s->data.nc;
> +    options.opaque = be;
> +    options.busyloop_timeout = 0;
> +    options.nvqs = 2;
> +    options.feature_bits = user_feature_bits;
> +    options.max_tx_queue_size = VIRTQUEUE_MAX_SIZE;
> +    options.get_acked_features = passt_get_acked_features;
> +    options.save_acked_features = passt_save_acked_features;
> +    options.is_vhost_user = true;
> +
> +    net = vhost_net_init(&options);
> +    if (!net) {
> +        error_report("failed to init passt vhost_net");
> +        goto err;
> +    }
> +
> +    if (s->vhost_net) {
> +        vhost_net_cleanup(s->vhost_net);
> +        g_free(s->vhost_net);
> +    }
> +    s->vhost_net = net;
> +
> +    return 0;
> +err:
> +    if (net) {

There is no path of code execution which can get here with
net not being NULL, so this code in the if() is dead. CID 1612371.

> +        vhost_net_cleanup(net);
> +        g_free(net);
> +    }
> +    passt_vhost_user_stop(s);
> +    return -1;
> +}
> +
> +static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
> +{
> +    NetPasstState *s = opaque;
> +    Error *err = NULL;

We declare err here...

> +
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        if (passt_vhost_user_start(s, s->vhost_user) < 0) {
> +            qemu_chr_fe_disconnect(&s->vhost_chr);
> +            return;
> +        }
> +        s->vhost_watch = qemu_chr_fe_add_watch(&s->vhost_chr, G_IO_HUP,
> +                                               passt_vhost_user_watch, s);
> +        net_client_set_link(&(NetClientState *){ &s->data.nc }, 1, true);
> +        s->started = true;
> +        break;
> +    case CHR_EVENT_CLOSED:
> +        if (s->vhost_watch) {
> +            AioContext *ctx = qemu_get_current_aio_context();
> +
> +            g_source_remove(s->vhost_watch);
> +            s->vhost_watch = 0;
> +            qemu_chr_fe_set_handlers(&s->vhost_chr, NULL, NULL,  NULL, NULL,
> +                                     NULL, NULL, false);
> +
> +            aio_bh_schedule_oneshot(ctx, chr_closed_bh, s);
> +        }
> +        break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
> +    }

...but we never use it in any of the event handling code..

> +
> +    if (err) {
> +        error_report_err(err);

...so this if() block is dead code. CID 1612375.

> +    }
> +}

thanks
-- PMM

