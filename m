Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235A1CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 14:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1nOF-0005Ag-QL; Thu, 25 Sep 2025 10:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1nOE-00059L-Am
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:56:10 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1nO9-0004Ai-2f
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:56:08 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63605347eeeso546120d50.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758812160; x=1759416960; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s3XQREH7zSgVBuotglhyEdwkPd8d8pcGKYJ6pBasa6c=;
 b=jGaT93ar5PiBDH/y3G+8Z5Ev4KWVK2riPDlzxJAxJWLIEE7F4XHtSNAGvhqQJ6v6Sf
 i6Zc0OU+/5L8MGp+QXeYbkdOwuvAWE5yYILIkZEX6hpkfTqxR6L5T4PC+17dYg7eWXvH
 smyVQQ6DW9n6wbddXcrUo3jg5wCQviU2RO4zoo7jC67OK87eHEnGVWItXKcWf765sJW0
 4ni7OOkXJN95p8b9WlwlgEge9JJZ7xQiH0ZA82/N2ghYaQLL+sihKjhTsLpwXoP69e4S
 IjK+fkLvICYVNUXPwcrDe4+JS8atJTCiOJys55p8PZzyZwssM7oTBE65LilpfQNk7J4T
 Ug/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758812160; x=1759416960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s3XQREH7zSgVBuotglhyEdwkPd8d8pcGKYJ6pBasa6c=;
 b=k/lAPz8GDefHG8s7yrEtko5+SKFCWQjp9oZcE7KaEY4U+ecLR9hd6N0/5U+UqRJYNX
 fQF6mKCiGd/boICWaYIZCQ75383BX2SRBLGqu81Bdl51bW7xeaZzgxw+uhDyTqe7b2II
 spt98vqjpAC3SnUztb6YTNTXw/I5cejf8IMZteCe3fOsWm/on7SClBWCC65kvQZZedWz
 eo1F80zPnrRS8gvIJ28o+iQOYKzJo0OVFGNU4qYU7SHWc/yQSSPUHk5nZedlBzJSs8i/
 6Qwkew1ydxRSf6jnNyib13zDxA1NL4MBFYhLnq0pu+QJtWMWQmxhuP71C3q79co76DYq
 NyIA==
X-Gm-Message-State: AOJu0Yxx3oABMdIfP94eYHLiHttkL1C/CkH1PAnA2xBZJiAtyJknLovJ
 q2dPv9WXAqJ30UoDpURTE3tfpKQ7bcux7We3E+dCxoy0V9+f8R2DjCa/nfG7VLQTMyZAZzUk6tO
 yVVjOOtESUusrsPJgZPZHJfIIhTTXSqxBf+rkYU/EPA==
X-Gm-Gg: ASbGncu/I9E22J/9PAKeFYX3jV9pClBi+yLfTUbBESB7Tvw+D12JnGlZl5/T0w/6ED3
 uV3LV4gCQnOOr226dDSF+jdOaOeRwD8JtUL7dWRB+GvQHkc8UewAnZf1iFmsE6NvOLPMtBomO90
 sVymQNLCxvN7bQTM4w5JBh3yTYOmbcpGeddao/IZFzN3A3WtgpUwRwB/Tm1kEVzyZx51eWIr/Hl
 NVpV2JH
X-Google-Smtp-Source: AGHT+IECkkbhV9bF4Uc125vQNqTxm6jlVoDRu2MjDHNhETnNqWSEznncpRXlR/OH9S8SSlgF2Nb6VLc9E6DCLy83QZ8=
X-Received: by 2002:a05:6902:3389:b0:ea4:c83:854 with SMTP id
 3f1490d57ef6-eb37fd0247dmr3568057276.24.1758812160208; Thu, 25 Sep 2025
 07:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-29-richard.henderson@linaro.org>
In-Reply-To: <20250916142238.664316-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 15:55:49 +0100
X-Gm-Features: AS18NWAYO2gsVh-rjBn7hesxSc-25rHLT6t1Lj-0CqcuLobRnN2YI5ZWgNNDxDo
Message-ID: <CAFEAcA8Nyab2fFm7M2b4OfF=H1ZK01dQJj6eWiUoRu1gV4BbZg@mail.gmail.com>
Subject: Re: [PATCH v2 28/36] target/arm: Move alias setting for wildcards
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 16 Sept 2025 at 15:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move this test from add_cpreg_to_hashtable to
> define_one_arm_cp_reg_with_opaque, where we can also
> simplify it based on the loop variables.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>      /*
> -     * By convention, for wildcarded registers only the first
> -     * entry is used for migration; the others are marked as


> +                /*
> +                 * By convention for wildcarded registers, only the first
> +                 * entry is used for migration; the others are marked as

You moved the comma in this sentence; I preferred it where
it was so I have moved it back :-)

-- PMM

