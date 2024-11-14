Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61652D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe0I-0001ZT-L9; Thu, 14 Nov 2024 12:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe0H-0001YN-GZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:51:37 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe0E-000882-M4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:51:37 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso884925b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731606692; x=1732211492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D0oZY1O2hICyj8/cNhAw2uKNTZU4liD5xu9G4iGXuJ0=;
 b=bqF0x2z3AskLDwKMq19FY8K1xu+2fq5rNTxKoCnJyaZi2q0TxQBcF21K9YqVb/Bx76
 bYxQnnjvSZ7BXb8Tjxz+Lk9AcQ7b5y8J0PFE7+CkW5j3DshyfKLc7n+pzmEII49bXJie
 6Hoy1biT8yo2uirM995psMKlxL9iXKe1QFoWisjZ5HO5Po3/7wyU+jHT2Fica71FDu6E
 arxdXi+WipKuZwsGBQjC4lb923w+UUVpCetJeStLarUwuexFCT1dwFJ2lumxmn8A5abE
 bKwCl1I/rQKCr6i7sHl0hcjNvtwQ6eDz+u0+SqqxteDXdflPLIzKSzHQd4r1H254AE+N
 9iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731606692; x=1732211492;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0oZY1O2hICyj8/cNhAw2uKNTZU4liD5xu9G4iGXuJ0=;
 b=JEU6YP4TlIVMoGEs2b3fxG147OFZYcbPU3vvq9s22bR7bgBUgDeQE6M9JwGrXQgLG0
 9P4vcFWqDjNfiQ6eFNLXCZYZiQvx6+5nMxDE3q8G2GaKpIfIduD48kLaSur8kVb1ihPq
 pbwKFjSVAOzaQfkk3j9J41Ch9lFrS6tysfiy25oj72nVlCkNz9H1NFHri7avKhm4yaRu
 A6yNaN56UF+00/q4etiiwNq5bWYUh/Bf3NQb3MhqigQP/u/Z2NnL/AIAGPDwtZTSVRRO
 sS5MT/aI51xj3ofX6Nrbmoimxs1mIrbL9xoOtvLsPitEJFa3oME3xduEfwOb+phHXMGR
 fg2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgDbHo5wuNbT4sG5eTBU/SYxT+P+9FqQIl3zzw6Y8JaJTW4S/mYax2mb9sSF7x6bOlLg1W8nghfgHL@nongnu.org
X-Gm-Message-State: AOJu0YzXbWFmT8taar7UyVxd8NxCB/JCqeDhrWtUMgJ9So/YKh3uZ+Uo
 JMbh0JlOvFeOfxlZTnmDnMYcQYiGb4hneuZyegsAaM6bi3hUcA57Lq2RCFZQRWk=
X-Google-Smtp-Source: AGHT+IHkWy04B6BbWdXFH0xfLwCKuM8T68SOgTOnnR41/K1QSPOTDBKBY+9Lww2A8DPcu3gUvzT4FA==
X-Received: by 2002:a05:6a00:1488:b0:71e:5d1d:1aa2 with SMTP id
 d2e1a72fcca58-72413289c35mr32447331b3a.7.1731606692549; 
 Thu, 14 Nov 2024 09:51:32 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9a89b5sm1564926b3a.103.2024.11.14.09.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:51:32 -0800 (PST)
Message-ID: <1d4e171a-cc5d-4436-b3c6-0f7164642b6c@linaro.org>
Date: Thu, 14 Nov 2024 09:51:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/54] util/interval-tree: Introduce
 interval_tree_free_nodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 11/14/24 08:00, Richard Henderson wrote:
> Provide a general-purpose release-all-nodes operation, that allows
> for the IntervalTreeNode to be embeded within a larger structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/interval-tree.h | 11 +++++++++++
>   util/interval-tree.c         | 20 ++++++++++++++++++++
>   util/selfmap.c               | 13 +------------
>   3 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/include/qemu/interval-tree.h b/include/qemu/interval-tree.h
> index 25006debe8..d90ea6d17f 100644
> --- a/include/qemu/interval-tree.h
> +++ b/include/qemu/interval-tree.h
> @@ -96,4 +96,15 @@ IntervalTreeNode *interval_tree_iter_first(IntervalTreeRoot *root,
>   IntervalTreeNode *interval_tree_iter_next(IntervalTreeNode *node,
>                                             uint64_t start, uint64_t last);
>   
> +/**
> + * interval_tree_free_nodes:
> + * @root: root of the tree
> + * @it_offset: offset from outermost type to IntervalTreeNode
> + *
> + * Free, via g_free, all nodes under @root.  IntervalTreeNode may
> + * not be the true type of the nodes allocated; @it_offset gives
> + * the offset from the outermost type to the IntervalTreeNode member.
> + */
> +void interval_tree_free_nodes(IntervalTreeRoot *root, size_t it_offset);
> +
>   #endif /* QEMU_INTERVAL_TREE_H */
> diff --git a/util/interval-tree.c b/util/interval-tree.c
> index 53465182e6..663d3ec222 100644
> --- a/util/interval-tree.c
> +++ b/util/interval-tree.c
> @@ -639,6 +639,16 @@ static void rb_erase_augmented_cached(RBNode *node, RBRootLeftCached *root,
>       rb_erase_augmented(node, &root->rb_root, augment);
>   }
>   
> +static void rb_node_free(RBNode *rb, size_t rb_offset)
> +{
> +    if (rb->rb_left) {
> +        rb_node_free(rb->rb_left, rb_offset);
> +    }
> +    if (rb->rb_right) {
> +        rb_node_free(rb->rb_right, rb_offset);
> +    }
> +    g_free((void *)rb - rb_offset);
> +}
>   
>   /*
>    * Interval trees.
> @@ -870,6 +880,16 @@ IntervalTreeNode *interval_tree_iter_next(IntervalTreeNode *node,
>       }
>   }
>   
> +void interval_tree_free_nodes(IntervalTreeRoot *root, size_t it_offset)
> +{
> +    if (root && root->rb_root.rb_node) {
> +        rb_node_free(root->rb_root.rb_node,
> +                     it_offset + offsetof(IntervalTreeNode, rb));
> +        root->rb_root.rb_node = NULL;
> +        root->rb_leftmost = NULL;
> +    }
> +}
> +
>   /* Occasionally useful for calling from within the debugger. */
>   #if 0
>   static void debug_interval_tree_int(IntervalTreeNode *node,
> diff --git a/util/selfmap.c b/util/selfmap.c
> index 483cb617e2..d2b86da301 100644
> --- a/util/selfmap.c
> +++ b/util/selfmap.c
> @@ -87,23 +87,12 @@ IntervalTreeRoot *read_self_maps(void)
>    * @root: an interval tree
>    *
>    * Free a tree of MapInfo structures.
> - * Since we allocated each MapInfo in one chunk, we need not consider the
> - * contents and can simply free each RBNode.
>    */
>   
> -static void free_rbnode(RBNode *n)
> -{
> -    if (n) {
> -        free_rbnode(n->rb_left);
> -        free_rbnode(n->rb_right);
> -        g_free(n);
> -    }
> -}
> -
>   void free_self_maps(IntervalTreeRoot *root)
>   {
>       if (root) {
> -        free_rbnode(root->rb_root.rb_node);
> +        interval_tree_free_nodes(root, offsetof(MapInfo, itree));
>           g_free(root);
>       }
>   }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


