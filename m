Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A92C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrei-00052o-K0; Fri, 01 Aug 2025 11:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrCH-0006j4-GF
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:57:29 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrCD-000886-JG
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:57:23 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e8fe618dc71so459324276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754060240; x=1754665040; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hTs8jtZu0AeULu3DWwiyfAO1jUbWL2lN8moq8Qh8lhw=;
 b=kNFnPxNYwz6TnLVhRfvH2RVeOfHSvd2TIY+Dae0kaPQRkGHynPaK2najOFwYU177b9
 4SiNhnxd9a+yPGcWuKG1n2ppxb0wRsrmZPSFp+y6yIGMxBgPqMpKrbNCraedL3XH/9TB
 /ellGGMHmLAKSIhphhBC9sVUdB8c3WiX2jTkvlmQ6guMOeoeSnm0lOajd6LVhIyjHBKD
 Gsdd7mwS6rK1huUcsSL7y9VAewtnchcQsifikKZvkfuhol5hel3MutECkzaCFThWmZuu
 3QzWPQtyH+RZ+Nyp66FmawGE4gO88KzwhAWR20Vj5M5wBkXjpwi/oKRfhEJMZSkOh0Db
 buwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060240; x=1754665040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hTs8jtZu0AeULu3DWwiyfAO1jUbWL2lN8moq8Qh8lhw=;
 b=OA5CHvpQFsXT77bwzEib477AvB2uvpCwv/BvTwMh9c+6FwH8V1vGS0KtPDhP7HoejW
 dq2Tt0CCNS4wmP2sr1APCxQEpoN4fvDkpWA5zpIPgDBzPameybWXi3tSbhGnD5oCnYag
 MXMkiSu7l1UNUJOaP4b2379osqELoH+VBKNDs753WnS6QRZ6lVz6crhdzQ7jflS+tCSY
 dQRTLD/PAwqtLbyLWw8sQW6pT438HzES8nGuKo1CFSj/Wz31b1M+pdxwQW+aEi8iDOAp
 iyDHfqzHBAGmh9LsU5RPBf7ZPy4prW0Y4ODUZy8ZO2AGGJ5ulsw1ySVzi0nHrwXMKmPU
 TJgg==
X-Gm-Message-State: AOJu0Yyvi2cY2pLd8R1GvnOgo8yzdUdUuhSTlzEfoAP1q9NVyjRNETf5
 j5aOYJDGF3VMid5HPYnKmDZ15X+3ZXmnQth6qclCk5Xx486fuJBCJqlhSFKO4+rtQ+4xhokPlf0
 x2gh1ER1Yf918E0y7qb5WD0MhMTzO63wEc6iJlSidIA==
X-Gm-Gg: ASbGncu7Y5VyqaaSk5HXkiCfeTX35mWQHAZM/jMYx8rt6s44sNyUyrf3F0r9ZtPP257
 n4uxsffH7i5RT9n0CdNYE0Qi6+thAVQ827By2nKDEc37G9M4Dls1xgu+sdnpcSEKcxxPiPiK1qE
 HbgdNUYE3gw9DR8Vva4QB4JEz5d7cgtv/oSw+sgv9G0BW78C4KWhqHoTqLKbZVS92wCrovC34kB
 llYGe+e
X-Google-Smtp-Source: AGHT+IGGteGzr0D4mkr+GaWojcRdwY9ck60YnI8PNU16wrYiDNSx21qvYonPFv8HldkGdCxAIRdLhQZma/ap/IayAr4=
X-Received: by 2002:a05:690c:370a:b0:71a:3486:c779 with SMTP id
 00721157ae682-71a466d4ecamr162901777b3.36.1754060239603; Fri, 01 Aug 2025
 07:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-11-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:57:07 +0100
X-Gm-Features: Ac12FXzEXbVOEjv9ROZYRrJr7rE_lYY1mpOERKXbNIYHIv8KwSF8KwiGKYHSI98
Message-ID: <CAFEAcA9J-mUyNrMdo3TGub3zB+uKsazHoZ8r23=uA=C0j44KaQ@mail.gmail.com>
Subject: Re: [PATCH 10/89] linux-user: Move get_elf_hwcap to riscv/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Wed, 30 Jul 2025 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Change the return type to abi_ulong, and pass in the cpu.
> As this is the last instance of get_elf_hwcap to be converted,
> remove the ifdef around the declaration in loader.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

