Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79E5C83F27
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 20:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udDj4-0003L1-9z; Sat, 19 Jul 2025 16:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDct-0005Dh-RM
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:53:44 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDcs-00018W-CG
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:53:43 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e8bc571ce7aso3021685276.0
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752954821; x=1753559621; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kQ27xU8bSrsOxMayVMzoirXDUoPGeYTR+WH+11mq+I8=;
 b=rOFU+stdczvg4Ei4JXYP9kccr7Wc0IwY2gTk5PMMlZu+pKMBpNp4ov/kq1X3j7Q/+9
 4oITP3dfYL1LN9ERpr2Te66T87LqED0AlB6mGisaSMSzeSLXq8Hjyn7EZX6sL6cOO3hS
 3MosLzsRC7vMbKjHDwxgbRtBh/GJ60+lV0PZqavUJRQ7eRnnfk1I5ehep+nJmG4FW/OL
 QJ+PuSgH+GwbiCpcUT2ZJ0LxvLpBOiYtfWpgLl9Rrh1HQNif6/owTsQM/96/pKoSDm+J
 Sqn+F3YAiuKP8TEe7/Uzg8XnFktiyksuSPYATRT2DE7wi/QPTO3HSEunHOQ4G7DZ9pqP
 CYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752954821; x=1753559621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQ27xU8bSrsOxMayVMzoirXDUoPGeYTR+WH+11mq+I8=;
 b=RzWvzZeHY62+HtQEMwAvbuqqseCyFrtSLjccn4aGI9tD8FVZbL7PXa8GgBommusWx3
 qs9VtkTr3eILDFUAzkCI5POH95ORNnnebH9MDESIR3qwnWAu/SBwkEkh7vpxlCGKv7/0
 btskQNER6D+qXKkdR2WPFfwPZN1QxaaE5oTlBkrcPHXZ89mh6jKmAEbtzdDQSdetMbJi
 kvK6aCCypr/cVKxVGRSGq7VbLOJ+55h1Ljex2/imcbneX9u/wFTYg6dUo99cK+MZ5obd
 ahYeGQlM8/jpbm63iI1WPDHZyoClWRZQjaFFXBzplCFqC7qmKwbfYUdyHGIetVasrzXl
 RBPQ==
X-Gm-Message-State: AOJu0Yz6s+UFuVdbbzRmlJjJydITdT8yuaAXo6plr5xyWcnKyElW6XLd
 TsNhvQ7lI+vHAz9GxaypRuplqarqaMiLr7/kUg7lF1/HElc9Dmw2Ca8AYxgOY35ln46GtwjjhWg
 5r68jyil6J3miZUBISDMyKHNroK9v5PqSK/gvw0r6hw==
X-Gm-Gg: ASbGncuhF1VfZYCK1f9OgAu+3UK85kx5Yy1X4LXTSvyLxNaS9UpyvxVFEFZJq/S6zKc
 rVm6FdmfGoSbzV0pt4qMUwbDRTi9qBNvoX+MtlHTF1I73iESUOqvKov/aKUi+jZYI1/BnTHwZXr
 4qAtgLWfZ+supmwPLuZyegtxivIbBpffzMUMPbXbJaWBvsKzKfa/Fr2gBCzF8g12hm6L4np6DLF
 dq6QL1r
X-Google-Smtp-Source: AGHT+IHXmkzkhoUr9fg4kYPeF9RXS7AKBk5RX3Eebsdx91+7rd+BjVf6EDWCMzDuuiv+uUgH9JA0t0IehL0vSjft3aM=
X-Received: by 2002:a05:690c:4905:b0:70c:b882:305 with SMTP id
 00721157ae682-718351ae978mr213577427b3.36.1752954820857; Sat, 19 Jul 2025
 12:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250717150805.1344034-1-lvivier@redhat.com>
 <20250717150805.1344034-7-lvivier@redhat.com>
In-Reply-To: <20250717150805.1344034-7-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 19 Jul 2025 20:53:29 +0100
X-Gm-Features: Ac12FXy_BoX6smqcq9QnJyTBvRgqonwumKP6uNmj_LFHSgxR8hEjLFW369igjLc
Message-ID: <CAFEAcA9M4=S-BsfhGEJ92L6QnaMZy4mcko===XOSQJEg37cy9g@mail.gmail.com>
Subject: Re: [PATCH 6/6] net/vhost-user: Remove unused "err" from
 chr_closed_bh() (CID 1612365)
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Thu, 17 Jul 2025 at 18:50, Laurent Vivier <lvivier@redhat.com> wrote:
>
> The "err" variable was declared but never used within the
> chr_closed_bh() function. This resulted in a dead code
> warning (CID 1612365) from Coverity.
>
> Remove the unused variable and the associated error block
> to resolve the issue.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  net/vhost-user.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index cec83e925ff0..8b96157145a7 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -298,7 +298,6 @@ static void chr_closed_bh(void *opaque)
>      const char *name = opaque;
>      NetClientState *ncs[MAX_QUEUE_NUM];
>      NetVhostUserState *s;
> -    Error *err = NULL;
>      int queues, i;
>
>      queues = qemu_find_net_clients_except(name, ncs,
> @@ -317,9 +316,6 @@ static void chr_closed_bh(void *opaque)
>      qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
>                               NULL, opaque, NULL, true);
>
> -    if (err) {
> -        error_report_err(err);
> -    }
>      qapi_event_send_netdev_vhost_user_disconnected(name);
>  }
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

