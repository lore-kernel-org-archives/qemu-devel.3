Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B3ECCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC15B-0007yP-4M; Thu, 23 Oct 2025 15:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlunev@gmail.com>) id 1vC12J-00066y-EJ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:31:47 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dlunev@gmail.com>) id 1vC12D-00073Q-4h
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:31:47 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso4608833a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761247897; x=1761852697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F8d+6oPnInbGZ7+4BTXBj7vYFYXKluwMCnvlbVyHaQY=;
 b=AsWaM9NhS3qp2AsxtC4cyvYHBSUwhM4mfe7BgddtTKq1XUgxgHy9eglbEmURyhlxBR
 52nyaW9FaAU5YfCqqKdlqrr/tnUQlWQV4jevr9b8d0UUQjxbOecQVnA6WTn5HdSsOQkA
 vBz9zxfj2RnijOL1e7NC55sTnqTtNEF9kK/FDYT2VoAqEygIQ9WA3NL7U4mC9yGrvuwp
 dAfU/ges7Z2yAqMxjdDhpsxErcR3BugCfmrsGC7RuouA9kP4XxeyEhQcw2ayBUzn1qj4
 /9dWCMyXKtdjBFysKGPdNe9SBZcWHbfUdVkJdrOGLw8s1mvdOmzKxFiuXTiJtgS/n4r4
 guzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761247897; x=1761852697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8d+6oPnInbGZ7+4BTXBj7vYFYXKluwMCnvlbVyHaQY=;
 b=kdC8vqluoAz8FRFSiKitml/BRIIOgKNnavD+yg8dSMGBbL8Z3GK0n2bF/ViPJ0Xl1k
 pEKdV/XomHHqgnTDeI53NUCIBTl+H+sJ5xkbHrpzb1hptkTjcKvALjUyHAxzbKJKnP+g
 ef79m1gEsuDL8ziWvoEL/m4oR/T4qXj9TTbNGw1d47vG9aBJEMaZS2A/u3sjqPL5RW6W
 yyZnaTn/JYXWM5r0K0VVAiheKQjwcoTis4z/NmSk4skQFltspwSgwHm4aKuseosbgkQS
 GWTYDFwYjvqRHUSxH2qQcXTd2zD3Wv0oyzc31lzY+othyf14gYrr3abxxFt8e7r24ezP
 YduQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgUOXIhSB5omiUiTuMOC4sqGk+HbpXj0kipOH9JGjRln1f9W54XTaKgwOXA+8KeLMbQCJIwOrfLh7J@nongnu.org
X-Gm-Message-State: AOJu0YyYSDMpmPEITB6DAEKZprO7K7exIu9oAzCuFa4ISRyGl5vb04cO
 IBIFnqovDH+hN7R2I4rRbvUMRruBtP6Cv06vVW/tB3PIDz7n7M4GIdqd
X-Gm-Gg: ASbGncse9Zo45mcZyIevfDdXpYg+d1csPvPjLcpQ7kQu2WMFtREJcTZTeqlI3AHhAd5
 OY0uZ02CPcb0rFTK/U8mx9v+pydQvH/9+tWrYfSHtU0did23dq/clEhoWTJxnjOs9A0o2G9Ypf/
 0xRNWMRGkyojUmotMJ6OnkYoNw1Oyy7nBnZmI8l2DI3JRFaH8WSbTMZ0M5PGcoM9nD0EzhoD7Hb
 DDI/fB9FRXI2748nVrtj5ZzpoQpIvsnO+IoteORXQ5jEwIzRB47QT27PAMcS7rxsUuji14fMUD9
 7PYZW0L9y0F9Ks34wyEKy+2oKR5YScuAQ0rTmwQNN6/hD2q4KijNHhBiZ6Oq+7SXXcuUMnBbVWD
 wLJOBRPL+f1cGatfcV0fcO8alUhm66+6YbpSm8HkhNWmNcZffIEbLXbgJTejzLc6etKdSoyNaTQ
 RtLuyJNnw=
X-Google-Smtp-Source: AGHT+IH+80Y+LYTIVyqH/Nt2JvLf0kZSMafu8vqoz22amc4h5X4H8o9ZNJKdHH73/mhNUsJKIcoOlg==
X-Received: by 2002:a17:907:6d25:b0:afe:159:14b1 with SMTP id
 a640c23a62f3a-b6d6bb1810dmr11381566b.9.1761247897037; 
 Thu, 23 Oct 2025 12:31:37 -0700 (PDT)
Received: from [192.168.1.18] ([79.175.78.10])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b6d514172besm289838866b.46.2025.10.23.12.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 12:31:36 -0700 (PDT)
Message-ID: <f099f697-0c98-4aa2-8b7a-3a243712687c@gmail.com>
Date: Thu, 23 Oct 2025 21:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] block/qcow2: Improve I/O performance in write-through
 cache mode for qcow2 driver
To: zhangjiaji <zhangjiaji1@huawei.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 zhuyangyang14@h-partners.com, eric.fangyi@huawei.com,
 suxiaodong1@huawei.com, wangjian161@huawei.com, wangyan122@huawei.com,
 liuxiangdong5@huawei.com, wangqinxiao@huawei.com, luolongmin@huawei.com
References: <20251023122457.2610426-1-zhangjiaji1@huawei.com>
 <20251023122457.2610426-3-zhangjiaji1@huawei.com>
Content-Language: en-US
From: "Denis V. Lunev" <dlunev@gmail.com>
In-Reply-To: <20251023122457.2610426-3-zhangjiaji1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=dlunev@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 15:34:38 -0400
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

On 10/23/25 14:24, zhangjiaji via wrote:
> From: Zhu Yangyang <zhuyangyang14@huawei.com>
>
> Optimize IO performance in writethrough cache mode by immediately performing
> write cache after updating the L2 entry and only flushing the portions that
> have actually changed.
>
> Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> ---
>   block/qcow2-cache.c   |  7 +++++++
>   block/qcow2-cluster.c | 15 +++++++++++++++
>   block/qcow2.h         |  3 ++-
>   3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> index b5378d003d..3491cea7fb 100644
> --- a/block/qcow2-cache.c
> +++ b/block/qcow2-cache.c
> @@ -463,6 +463,13 @@ void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table)
>       c->entries[i].dirty = true;
>   }
>   
> +bool qcow2_cache_is_dirty(Qcow2Cache *c, void *table)
> +{
> +    int i = qcow2_cache_get_table_idx(c, table);
> +    assert(c->entries[i].offset != 0);
> +    return c->entries[i].dirty;
> +}
> +
>   void *qcow2_cache_is_table_offset(Qcow2Cache *c, uint64_t offset)
>   {
>       int i;
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index ce8c0076b3..95b0e44c6e 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1032,6 +1032,10 @@ int coroutine_fn qcow2_alloc_cluster_link_l2(BlockDriverState *bs,
>       int i, j = 0, l2_index, ret;
>       uint64_t *old_cluster, *l2_slice;
>       uint64_t cluster_offset = m->alloc_offset;
> +    bool part_flush = false;
> +    /* I haven't figured out yet how to perceive this IO
> +     * as a writethrough cache mode. */
> +    bool writethrough = true;
>   
>       trace_qcow2_cluster_link_l2(qemu_coroutine_self(), m->nb_clusters);
>       assert(m->nb_clusters > 0);
> @@ -1061,6 +1065,13 @@ int coroutine_fn qcow2_alloc_cluster_link_l2(BlockDriverState *bs,
>       if (ret < 0) {
>           goto err;
>       }
> +
> +    /* If the cache is clean before qcow2_cache_entry_mark_dirty(),
> +     * we can flush only the modified L2 entries..
> +     */
> +    if (writethrough && !qcow2_cache_is_dirty(s->l2_table_cache, l2_slice)) {
> +        part_flush = true;
> +    }
>       qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>   
>       assert(l2_index + m->nb_clusters <= s->l2_slice_size);
> @@ -1102,6 +1113,10 @@ int coroutine_fn qcow2_alloc_cluster_link_l2(BlockDriverState *bs,
>        }
>   
>   
> +     if (part_flush) {
> +        qcow2_write_l2_entry(bs, s->l2_table_cache, l2_slice, l2_index,
> +                             m->nb_clusters);
> +     }
>       qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
>   
>       /*
> diff --git a/block/qcow2.h b/block/qcow2.h
> index b0ba2e1996..8fb59c4e87 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -1000,9 +1000,10 @@ qcow2_cache_create(BlockDriverState *bs, int num_tables, unsigned table_size);
>   
>   int qcow2_cache_destroy(Qcow2Cache *c);
>   
> +bool qcow2_cache_is_dirty(Qcow2Cache *c, void *table);
>   void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
>   int qcow2_write_l2_entry(BlockDriverState *bs, Qcow2Cache *c, void *l2_tabel,
> -                         int l2_index, int nb_clusters)
> +                         int l2_index, int nb_clusters);
>   int GRAPH_RDLOCK qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
>   int GRAPH_RDLOCK qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c);
>   int GRAPH_RDLOCK qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
At my taste this approach is incorrect. I think that we do NOT need to write
dirty L2 entry at all until flush comes from OS. This is what how this
code was written in mind a lot of time ago.

With this approach in mind we will have doubled amount of IOPS in host
to ones from the guest.

If this approach stops working for some reason, that would be
good to check.

Den

