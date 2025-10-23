Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E56ACCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBxMt-0007Q2-HS; Thu, 23 Oct 2025 11:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBxMi-0007OO-Gx
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 11:36:40 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBxMg-00039A-Rj
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 11:36:36 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-784a5f53e60so11770267b3.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761233792; x=1761838592; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R7Bu0evPT10yGWWc46+/Sxv8lt3PFMq2HvV0YKepJ3o=;
 b=JxzMdtxsN+UnwXuFW+9/nLbE3GSI+l8jx+31nuKlb8qBUoHa55HuCMOW8I4Mz1Q2JY
 77ylyx/YzCwhY+j+gn1/rupgU5GWFvfijfVY6yb9YgOoLFp8DfSyEEgFTfODuCNpN0cd
 texcGmXtjMzh4K8ZytxaaTqq5/GuRRHobSna/hQyClnASVqsxRuIGyBN365Pu/kQeaQ/
 9TLL5nYz+sQKt3K2sq7KdFpf45VoptDTrhxXHavGYKi3Ze93If/c/QYSKdsFtiCwPudX
 XTQEZgjQ3WX7cqwtPjm54vYf7oWl0K8x3xbFEA0Sy04KSzKPH96MYn/Z9fflScCNPcmY
 WUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761233792; x=1761838592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7Bu0evPT10yGWWc46+/Sxv8lt3PFMq2HvV0YKepJ3o=;
 b=meX7zyu6P1tzw8t+b8YjRpeM3osZZ1WJbithBhwzT8DjFHI9qW4TeMiN+N0HhYBXQc
 ll4V188D+cGVSDqCZS8JXf4CfzC27y+Bw6sP5XRkPOBng2iEkWD+tR7471Ce+ytLfcyP
 QITs6XQGQH9kHzjkQbd3xLQB6ikrG/NbszP4l5GACGQNt1AnCqkcEfDh+cQiEjF4/z7Y
 xaIBRiu7v5R8hgjBq9335hUZ7Y1aZPffs743gP06SGvfLbhlmmxM3nL6BPgaqNmsehXs
 zksUn98dj1WcW0TiN4Nlvm5MGpLltfMLMuewx1P3zqJcS5uKE4FKGqmOv5gO1x0LfRZv
 Mx/Q==
X-Gm-Message-State: AOJu0YzpCWUp96IJw1hAp0ynLvBB4Bk4AJGOCkjWdfVGBZwio+ikDzh6
 Bedcsjj4T4qepXvVjUCsal1/QR81l3uK6iSv6J5PFnQPzb1KFAdjRByr85X2kJ3dXT129ayXlxZ
 V9CDwelppgVbIqfJfCuiQvGoEd44Mu3u9XfRphjoqcA==
X-Gm-Gg: ASbGnctI/qUbkzCtQX391jWAExQIvfIyr6aBzVADkq2VAFIXRMusmBPO+ovIwXBQv3E
 yVbXEI1dJBHQge/wNxBmkeCC1rub0jXMy7lTgIZuuQQ3mTfe7AW4bWRyh9dmHxsoZZouCj3M9aB
 vmpkCHVEDhYJhSx5v7iIykFWE9i0dHP2puzsndArKHx8KSViQ76qTa0Ct8bJLIuOR2WHzySXlGa
 iHhNCIYtr51nk4qdhjmnveZvIBxm8GfP2vZ9NFVC/OlEXQaW7e3AZQQYZS9KtzL27hYZOF8
X-Google-Smtp-Source: AGHT+IG1znZmh00ANSnKnoDmuuju/L1QBXZOYYFNIxsERl38+x0oWodGpZUqwW4HlkqiKRp1fKL9tmQEB4+JCOtGLV8=
X-Received: by 2002:a05:690c:3605:b0:783:71ee:8977 with SMTP id
 00721157ae682-78371ee8b09mr229716667b3.11.1761233792347; Thu, 23 Oct 2025
 08:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251022110524.483588-1-dbarboza@ventanamicro.com>
 <CAFEAcA-gF4himAj7k03cES2-USbE-xs7f5LZEPQaCqHhDieiEA@mail.gmail.com>
 <06684337-601b-47d3-925f-b5a693aef244@ventanamicro.com>
In-Reply-To: <06684337-601b-47d3-925f-b5a693aef244@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 16:36:20 +0100
X-Gm-Features: AS18NWD43brInKiX4K_0k2Z68WeBtLuCdwqQbOafpyOHu9aPWRRAeJleyIZYHU8
Message-ID: <CAFEAcA-5wCL7b2Vc_4NXHNUqOn6SsY8+RD0-mZo7rh_jw74BFA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/riscv-qmp-cmds.c: coverity-related fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 22 Oct 2025 at 13:39, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
> On 10/22/25 8:59 AM, Peter Maydell wrote:
> > g_autofree frees with g_free(), which isn't the right thing for
> > freeing an array of pointers. To do autofree here we need
> >
> >   g_auto(GStrv) reg_name = g_strsplit(...);
> >
> > (GStrv is the glib type for gchar**; the headers give it an
> > auto-free mechanism that calls g_strfreev().)
>
> I saw some instances of "g_autofree char **" and figured that it was ok to use
> g_autofree in this case too (just git grepping, didn't dive deeper to figure
> out context and so on).

There might be some lurking bugs here -- it's an easy
mistake to make. I did a quick audit on the results of
 git grep 'g_autofree.*\*\*'

It looks like migration/migration-hmp-cmds.c:hmp_migrate_set_parameter()
does the wrong thing when it calls g_shell_parse_argv(),
because that function documents that the vector should
be freed with g_strfreev().

All the others are OK, because the elements of the
array are either manually dereffed or else remain
the ownership of something else and shouldn't be freed.

The migration one is a recent addition so I'll follow
up to the patch where it got added to the codebase.

thanks
-- PMM

