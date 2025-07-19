Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D99C83F27
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 19:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udDgP-0007Tt-CA; Sat, 19 Jul 2025 15:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDdN-0005Wa-NF
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:54:13 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDdM-0001AP-9H
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:54:13 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-718409593b9so33267037b3.3
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752954850; x=1753559650; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iZsEBGZqcndRHg4ftW2DzSPeYKVcmp/MSsW5S5Bx3hc=;
 b=RcS25DJu9VA/DpkSkragAT2H20vzaK8sMW0TX8Y9sWiiCrT3jkZ243Bj9j3YJXhNUg
 FZG/8Q+kaw2xByqa+a0ve10Tk4jjqFR3q8CZQ8ZtR4leUEuD1lt6NRwUbG6VcVNR31ZT
 EzfAdNMKhWGqVEhUf2qo1HlRCh5DaQRJ6jYPtKGUaJdVVsATZkg4rD6qYLqCPA0FiCr+
 iMXo0z6u+J2D7M9IQHdZWpF+/th98HVlyoIKR2N6u2v+uY7hjMVDUliknysKgLi7HTMn
 q2pmq8D2atgyH2UVd0Owe3QgxvGPq09vfdjR+X5zAolL6hAgFW+vk3kNDtWXHFKUwsno
 I5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752954850; x=1753559650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iZsEBGZqcndRHg4ftW2DzSPeYKVcmp/MSsW5S5Bx3hc=;
 b=mwO/hY46ICLqt42puAYQieqaWCwkwrfoXM+Y06ldHxVeWxo0WuW5LH9op8cHY5qN+1
 +k7d5Ku+CM2ew992o5FxxHSpeiyYpJZB8I40KFVS+AYY07TD7yMewh/+11RY3mMvck8O
 1XOshMGlCBoWWxfpNrRLfoCiFWhdyJlECzHLvKUUeIu5rKYsyIRMebmAH314CjQ7huEo
 E/WkRtD4GBaZVRZany+331y5kIdZiTmSpcSSmAITfecbXZPpUvkEMh6k+7rzRetGs34P
 qiZGsiNS5/xqgV4M8bZ1nUak2HvzIjepv5imNFr987T70eD02w6conO6JlhnByUnj798
 8OVw==
X-Gm-Message-State: AOJu0Yy6K7SB9dVEcf0pn1Ihv7w4eJaDEDs5rCh2Z8JORSAnuEogwim8
 w2wNmphLkp6c7Udk5uhXNFGKfOrFt7PB7D/rQP2OpgkNZaQ3jABhVxVK0zhxbrzjfFiEOmtIrLp
 oa+XayBhanRvLP3cnuYRCAnKTxHW3gzlA1kR38d+7NQ==
X-Gm-Gg: ASbGncscL7Z1ztLtn0+1q3CMZsjNcWYgbamlTJZrYAWz0K5Q2XC6CEK804iisiToRE7
 35v82D54Cqswm7V/MS6SCjXx+vxgZlcS2tFwlH9qYuxyd539AMggMzE/UEuAXGMy+g3eUKtzrB6
 F2zhNAo2AoAjhSiBkene6UhlIkFpIl9cuXAFFuMvtOyPZceszHEJdFhHde3MNAThsN7aWykYZmX
 JS/B720IJRacdW09m4=
X-Google-Smtp-Source: AGHT+IHh3YuQukUbiWhjQ6i8wx4fwTKeoU4UQ3NrgwIPmm+l/Q29lAfoAmu6cqqWn9pnO+vI4DOwL2CDbnsx8wl86Wc=
X-Received: by 2002:a05:690c:fd4:b0:718:5e1e:b821 with SMTP id
 00721157ae682-719523189ccmr96655357b3.31.1752954850672; Sat, 19 Jul 2025
 12:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250717150805.1344034-1-lvivier@redhat.com>
 <20250717150805.1344034-3-lvivier@redhat.com>
In-Reply-To: <20250717150805.1344034-3-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 19 Jul 2025 20:53:59 +0100
X-Gm-Features: Ac12FXyFk8ipKdOSuoN9i8LZwXNZCWGr-sfzheHtZtqxakhBJiRfJgOXwesc8v8
Message-ID: <CAFEAcA8pHoWJAPbc=ny1mciKDPoN8of10M-Xa_v+K5NSF6=w=w@mail.gmail.com>
Subject: Re: [PATCH 2/6] net/vhost-user: Remove unused "err" from
 net_vhost_user_event() (CID 1612372)
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 17 Jul 2025 at 18:52, Laurent Vivier <lvivier@redhat.com> wrote:
>
> The "err" variable was declared but never used within the
> net_vhost_user_event() function. This resulted in a dead code
> warning (CID 1612372) from Coverity.
>
> Remove the unused variable and the associated error block
> to resolve the issue.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  net/vhost-user.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 1c3b8b36f351..cec83e925ff0 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -329,7 +329,6 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
>      NetClientState *ncs[MAX_QUEUE_NUM];
>      NetVhostUserState *s;
>      Chardev *chr;
> -    Error *err = NULL;
>      int queues;
>
>      queues = qemu_find_net_clients_except(name, ncs,
> @@ -375,10 +374,6 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
>          /* Ignore */
>          break;
>      }
> -
> -    if (err) {
> -        error_report_err(err);
> -    }
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

