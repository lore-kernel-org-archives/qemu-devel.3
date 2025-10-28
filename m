Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB01CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDj7s-0002f3-LB; Tue, 28 Oct 2025 08:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDj7r-0002ei-6H
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:48:35 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDj7k-0006n6-EG
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:48:34 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-592fcf7a1ceso5245552e87.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761655704; x=1762260504; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pucb64fBJWr4+y9UVYKlttRFUeMCsZ8bQOysNcf5NkE=;
 b=BjSUB7k5KPONbiecb6qXSnw5qYlgg5kWODjb9Hki8KE/LXzU+hh3UOT8TT//Jc9Rah
 igYOthmakAH2H/HH3P5SrU7T7pAv/I1TeKTLgelfEcG0fHNJRSTaZKMZlxNufb67MKCX
 nobYZ2rXQRQQEsI+ojX8cH/yS+5lCz2YDkU02MIQi5JUfGKWP9PbJ672Tv2USUSu+Hos
 i1SeJAazk+kGgY8bGMSb4eCLPuo96mq8u/7WRvXvIpa4yjL4IsmAtE99r59uox0YF4De
 G6LCz5H4BdaOk19H9cqnhZUnx37NCvc4PPrPmwpYdQtE6w7vaLsU3B5DdMdY/WQdsmLB
 GjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761655704; x=1762260504;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pucb64fBJWr4+y9UVYKlttRFUeMCsZ8bQOysNcf5NkE=;
 b=mx+jWxOwHeq5w96cr9SPXXOTluSZogk73O1bHpRoGCmEO+pa5a8tqK3BQJL4U2tAAi
 fX6SdgVEkqZ6z9uxSxKgGG5XpjYOAulBrY1dMUc2REb4d+60WnQb6snXnIQAB293Oz5P
 +XtlyErmUNfPBRR2PH4TFXeJMNPRd+QfaSikDS8ueil0LmL1eJ4dMHR/Q1LAtdPaQ7N2
 0MmW3vyahIcbYc5BepNkiifquz7RL/Yja4Ky+z9XpbgN+4QKToseIiGeu9mhzgy2eMvN
 L0y+hYsOKPrbEznE8yGQwuylXLpmb0R6vQnYzD4ffJlBujHop2/BkUT8nYCUcCzweUoy
 YiDA==
X-Gm-Message-State: AOJu0Yw3xa17iQdpNDYGfi5YQ4d0VgysUBOzJ3r+nceAYrrC0ppQWNYA
 yJxsNEXfEbHOqtoqE82fQ7aGkvppQldSgMio6+DkmLhNTVDLwBol+4mF
X-Gm-Gg: ASbGncv8rNte8pPAH4rwRLxxh4l21Qdg5MMlRr4UJ74PmjaSrR3Ns/jBuemPUXbHBOZ
 62DFsa8wM5cubYbj4jkp72WvYpqXrCqixLh/91ZJuJ0ODIwRZ9lxXH0dMEdRGEOpBuBnClKwBg5
 v5i8jeP3akuN66jwedFYBTV9kpKSUxtHYMSFwUWICeplLRuEAWpoXOWlJLmtLDG84N/R1IR7/x7
 64778OdFsB1FZld/UHYAvfhGblIIPov6lD6bpAQ9F2F+TG7p7f32gWzZOJ0yazCcxekyI/QtlNu
 jYj9T6U3bLyF6w3u7lIf7ntytt5i7OwoMDizTdWlxq5bomaE7cEmfSG/7+nU9XVOfJb0Ebgz07q
 hm83ZYlm9c4ua2weHk/5S0JmVgD3RIwxf/wiL2zAaDkG5y4Ynqwp6zB97qWn9zkLPC/1gTMIbWz
 wcH+vHLsx0+B6XWLYbYKWZZkKGAuRMmeELn2VU2kixPQUwAwI=
X-Google-Smtp-Source: AGHT+IF6ccHGzuzxNm7+bHl7g/7fMJDKTL+xoHfyAW6ncH9aLVAwNW32+RfTkPnTLRjRK6Csu5NkiQ==
X-Received: by 2002:a05:6512:238a:b0:592:fc21:bc15 with SMTP id
 2adb3069b0e04-5930e9dd032mr1404878e87.45.1761655703317; 
 Tue, 28 Oct 2025 05:48:23 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59301f5098bsm3042698e87.40.2025.10.28.05.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 05:48:21 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:48:20 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>,
 xen-devel@lists.xenproject.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 1/3] hw/xen: Use BITS_PER_BYTE & MAKE_64BIT_MASK() in
 req_size_bits()
Message-ID: <aQC7lEwW9pSmCtIx@zapote>
References: <20251022140114.72372-1-philmd@linaro.org>
 <20251022140114.72372-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022140114.72372-2-philmd@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Oct 22, 2025 at 04:01:11PM +0200, Philippe Mathieu-Daudé wrote:
> Replace magic 8 by BITS_PER_BYTE, use MAKE_64BIT_MASK()
> instead of open coding it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/xen/xen-hvm-common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index 52e2cce397a..258014370e1 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -1,5 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/bitops.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "exec/target_long.h"
> @@ -448,12 +449,14 @@ static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
>  
>  static void handle_ioreq(XenIOState *state, ioreq_t *req)
>  {
> +    size_t req_size_bits = req->size * BITS_PER_BYTE;
> +
>      trace_handle_ioreq(req, req->type, req->dir, req->df, req->data_is_ptr,
>                         req->addr, req->data, req->count, req->size);
>  
>      if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
>              (req->size < sizeof (target_ulong))) {
> -        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
> +        req->data &= MAKE_64BIT_MASK(0, req_size_bits);
>      }
>  
>      if (req->dir == IOREQ_WRITE)
> -- 
> 2.51.0
> 

