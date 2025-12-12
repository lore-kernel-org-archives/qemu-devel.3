Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9694DD59D77
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU700-0007s4-5P; Fri, 12 Dec 2025 12:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vU6zw-0007qv-OT
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vU6zs-0004xC-GL
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765560719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeM7VSRBvt+OYAhkYM+UA59+QjpCwloF9pSJ1ymONKc=;
 b=OCd8uPvA7Qi6eQss01s8rqWCwA8+Lj/BzbjW98lL/FLQ+W2+vljc98+zOzYVCP8r3ZLRYt
 VKpkTDMbTq6iMXO0u5d5L1Fi7TTZV+XHuG45BxQZHeCdrME0QZZADJYFJnNclAG8PQbicF
 g8g9K+QzElhC8BgGe21AAARxBIQnuSM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654--P5Z8W8pM_uXKTkgP5RK1Q-1; Fri, 12 Dec 2025 12:31:57 -0500
X-MC-Unique: -P5Z8W8pM_uXKTkgP5RK1Q-1
X-Mimecast-MFC-AGG-ID: -P5Z8W8pM_uXKTkgP5RK1Q_1765560716
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so11303245e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765560715; x=1766165515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oeM7VSRBvt+OYAhkYM+UA59+QjpCwloF9pSJ1ymONKc=;
 b=eDID783eohTia8fvFARg8rqqAREBkXx0A7FL4obqKnE8axtrcv0X4UvMdFCx7mJrjr
 m67VF+9km0MY778rqpDgd2L/lLkKfDaDWkPSZqhOZUgva5svs2m9/snqS2j8Bk3Baxxi
 uaRPHlLmvNvi8AGVKq/JgwaR5j6B5SgLVxEzqB6abDcphZY0VatgHCfkT5LM4mYtiKWx
 hYQQL8Qx2Jt8zwiJriIDuiwzhVu/hKO8cpUGGRy78XrIu4/V0H/zmZsAbl5FL8oOr/H4
 a9hJbW1DCB8VdUo7ZY7T4f/x/Z5Kt/pIupo6CRD8spUmzIKugWaqo1Tc4m1NeB0x7TsZ
 IQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765560715; x=1766165515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oeM7VSRBvt+OYAhkYM+UA59+QjpCwloF9pSJ1ymONKc=;
 b=lI3ESdlS3PtFfGwQ42rR1yN5RYuIHGQ16eRJwXmeSZGJT565h3uWBzN8JgCrjJ0zpg
 /zF0vgzj+ASmm9fOusD/1NFEvc4ZbYPiFzPsI83gYYOdwTCclUI60UEzPj1PLpjwu8o/
 JVn1DTua9SUiJC6DQIU3sFAVhgDz0lm31vBT+UTK5wb4xPpv4fnsXmigv/8x6Zty545V
 qpDpuxoT2zoz/OV3RIMHJefpruCjHeuzJxKD0aaFtrZ5HnW5lvM9cM/C7xB/MRhbxFFh
 GFS8G3eH/LvD+sUKgy95Zdze44jWa3hGIFvJilLxGCNYdlMRhxy3EwZpNLpI9ROGWAZA
 5YWQ==
X-Gm-Message-State: AOJu0YzQQIRICqYfjMs5Ao1X9c1X2GL+zbe1Mw26dtQlBJjKl8tI53Fu
 /li2e2ytlF9b52EmHKdFl2Ce+zbYHW5pHy/eEFgrviTxzUnV28f19Qj3+KRiuIhaN8mpTVD61ok
 LzrC96jiICopskEGf9vjv/e34YP+OMY5orJ8aPf2JQj1HbFnR9haLssjQGqulmmdB
X-Gm-Gg: AY/fxX6emiWPTpIvOI7D4bJUy5sNBhbFBgoOuGiqCIH/izoA0szJbNWK6iLBvp9Lr/w
 jDSq4NMqlXwxePl6kitNCwyvNu2QULAB0MNkEYkj/OynDZbbMxNFb9wsMB5UDx351RIS5uN5dLJ
 Gapsjt9/TAiSIBhfFVMpE0yb5k4pCQMx+E7OIEtZTcf0KtgNNYMhF3vvkAXH1j03/ebG22RUD8U
 WaouNdRZy50dgOX11bLYwKSa4tK2dd5y5YPpzbAECw8YAHJLax/vqvuUeaxKNyEzhQLRLlc/ZZ/
 4mZTnwlFJCXlffHlDSoY0e7+iIDSoVcHWwOUqNg6SV5vCB72FsVJF/UJ897OMReoiiXLpDwzRgj
 OAXrN+3hiCOQuzvNC3AISKcvuwQdudrkuo6Lj0RjexPw93iG98zdZFMkDdMmIcex5Q2ShXJ5pRY
 6pQDGB15l64fiq/P5CPA9KUl+Epq+ZRpSAzw==
X-Received: by 2002:a05:600c:444d:b0:476:84e9:b571 with SMTP id
 5b1f17b1804b1-47a8f8c6828mr29727325e9.14.1765560715570; 
 Fri, 12 Dec 2025 09:31:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX2g8DzPL7IlJCKhNAA7491aujfbFLjDMic4qC/EHD0xb7pZ8qmFYOFq6YJDQPIZeirH7mYw==
X-Received: by 2002:a05:600c:444d:b0:476:84e9:b571 with SMTP id
 5b1f17b1804b1-47a8f8c6828mr29727055e9.14.1765560715159; 
 Fri, 12 Dec 2025 09:31:55 -0800 (PST)
Received: from ?IPV6:2003:cf:d717:1fba:423c:67:1f5d:bd5f?
 (p200300cfd7171fba423c00671f5dbd5f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fba:423c:67:1f5d:bd5f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f70509bsm16048485e9.6.2025.12.12.09.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 09:31:54 -0800 (PST)
Message-ID: <3165bbdb-b777-4a3e-b0a4-549af926da06@redhat.com>
Date: Fri, 12 Dec 2025 18:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2] Revert "nvme: Fix coroutine waking"
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
References: <20251212102522.38232-1-hreitz@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20251212102522.38232-1-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12.12.25 11:25, Hanna Czenczek wrote:
> This reverts commit 0f142cbd919fcb6cea7aa176f7e4939925806dd9.
>
> Lukáš Doktor reported a simple single-threaded nvme test case hanging
> and bisected it to this commit.  While we are still investigating, it is
> best to revert the commit for now.
>
> (This breaks multiqueue for nvme, but better to have single-queue
> working than neither.)
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Lukáš Doktor <ldoktor@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>   block/nvme.c | 56 +++++++++++++++++++++++++---------------------------
>   1 file changed, 27 insertions(+), 29 deletions(-)
>
> diff --git a/block/nvme.c b/block/nvme.c
> index 919e14cef9..c3d3b99d1f 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c

[...]

>   /* Put into NVMeRequest.cb, so runs in the BDS's main AioContext */
>   static void nvme_rw_cb(void *opaque, int ret)
>   {

[...]

> -        aio_co_wake(data->co);
[...]
> +    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
>   }

 From testing, this bit seems to be the important one: The hang seems to 
be caused by entering directly the coroutine directly instead of always 
going through a BH.  Why that is, I haven’t yet found out, only that 
s/aio_co_wake()/aio_co_schedule()/ seems to make it work.

I’ll spend more time trying to find out why.

(The only thing I know so far is that iscsi similarly should not use 
aio_co_wake(), and for that we do have a documented reason: 
https://gitlab.com/qemu-project/qemu/-/commit/8b9dfe9098 – in light of 
that, it probably makes sense not to use aio_co_wake() for NFS either, 
which was the third case in the original series where I replaced a 
oneshot schedule by aio_co_wake().)

Hanna


