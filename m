Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC4FCED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 22:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfWQ-0001xo-99; Wed, 09 Oct 2024 18:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfWO-0001xI-70
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:51:08 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syfWL-0006BM-D7
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:51:07 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ea16c7759cso197628a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728514263; x=1729119063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9LT38g/UANRgZmTfe408awXmS+rOICD4wqbf03YAu8=;
 b=UEtSrzOJ8RO4ZW3k/Dk1iaE/+/W69wWzrc2mSO328/MjBYZLybwE+9snSfCwAjVIq9
 Tm+u08rzuErZDcZ/GTZUg3P/8EVDcFJZYEXEhV7e+rxj3JAHvPfo41NVAHgXeTTZNSrq
 nQ47by0Erxs4CbXPnqYx0PnagoZ3YIXG+Gd35AxkXWigsn+TROzY/NuZ4nka9j4WT13e
 qwClOJD/brDJrUproqhw6HNs9N3mkuJxMG6KppIW9pz4x6MjH8rQY/qnMhufKKdfY8em
 UKLqGeKxGYBx+8RXnVuuLsbnkglrTT5IZM+aVkEnw4C4T3O1GhyBrwak+bdz0c6gfuIJ
 HTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728514263; x=1729119063;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B9LT38g/UANRgZmTfe408awXmS+rOICD4wqbf03YAu8=;
 b=STNvnVraSC/iSviQ1PydfYrXEROhdgOhZcTLmbXOOb9Qs8Xus62L3FKUtxOD2qhv/f
 4m5GBKT3rJ42ocR5DI6fxWRbPYvZ+EkeMFnpRBa2n6prf2VAn0QbMHose4W7SryZiQ5U
 pXDSCXhTjlQ91wZPRRN9VTJJJZM5ZvdwrB0S2dMaTqdxpUh3xFBgZVc02Lhfe1xOhk9C
 rT89Y41PL8a1PI22/uoUS8UWcj5vGgN0Qx1bzECsmwvmuEHG+I3ouzbh8ldU5z/iWKKL
 fDlvcVex7LOPpv68oImmk6WKb+U8sAsSPoXbLqewE0zuFPkjMfFCpZKbrNe6W/F334aA
 wpGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUBfR5+oqWWWLrYH4L0zMLIhqaVEWS7BFAEziSfikl1Vvp7FoN3fxbYtYiyTAVWXLM5hyCXvuIBTcS@nongnu.org
X-Gm-Message-State: AOJu0YwtiNeeINH3WOaN7yU7r/mNJSrkB1abVTrYqcqL5aQPGfm7osjy
 MszGqmxrXbkGwIQIS3Adw4yOGdFc8BxfhVbHvJKTLDtfwy/N/mBJRueyEWnMY/8=
X-Google-Smtp-Source: AGHT+IFjQCsrCMlUIR0f9fX1KjTb6H8HnPNT3UyFVjV4MQkHXlqBCH2o9fVPn86TK5i8vqQk5o8/KQ==
X-Received: by 2002:a05:6a20:c890:b0:1d6:f83c:8397 with SMTP id
 adf61e73a8af0-1d8a3bf06d8mr7199348637.17.1728514263398; 
 Wed, 09 Oct 2024 15:51:03 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea3459a03csm1339063a12.69.2024.10.09.15.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 15:51:02 -0700 (PDT)
Message-ID: <280442c8-9679-4e8c-97f3-1649b9814302@linaro.org>
Date: Wed, 9 Oct 2024 15:51:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 01/23] util/interval-tree: Introduce
 interval_tree_free_nodes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-2-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20241009150855.804605-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
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

