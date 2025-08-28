Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B7DCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBY-0002Us-OM; Thu, 28 Aug 2025 13:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdbk-0004D4-Pz
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:28:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdbf-0007PT-K4
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:28:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-771eecebb09so1426146b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391278; x=1756996078; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NFYAMZ+N2Cl/JDgZ6OuVjzYrgaBNaHC8gFuZmu1CTjA=;
 b=idWgIlz7aezaxUKAsjyboz1J33dDQ9nxzhk2u09SLFDNrczlX6aKToa/xou+Ug6mUS
 NDS/K7hwqCMp+zZ+F5h/fvdoeJJ766EQ3ENQvG0pttcd3qhkBd8YOgzwNfrF2TLtg+Jn
 uMhZ9FWT6uNrmHqwIu3alwHfwonQSvtVwh3Y4bmwBIQ8Y6TKznesSyB8bmH4r3U6GUtq
 5tdpQxdKwzP1FSSQX5Ms+966Tsq5LkdBj4QL+mhxzHKXoEWWdfwkwwNEC2O2G13oiXo2
 6otLxnprQnHFqSw7+bOgpy/z3VJVJkdZEZyE6jqcdBP7PlZgUBxgxb4KGklsnxYpu0ex
 KxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391278; x=1756996078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NFYAMZ+N2Cl/JDgZ6OuVjzYrgaBNaHC8gFuZmu1CTjA=;
 b=H5iE30pC7hu07GeRglAM5qasj1M9ExMKt/6GUsiRFsR7FiYd0BQ+6qR0y6+fm3+Sr6
 ejRfZSw1AiUtHsQFknC22wfD0pBxzfODETOlrHLEYuRPLushyakxSLUzsmsmW8p4OlJ4
 Z5bQcyq9WO6Ee8SDZLPTGMRI0H9MY0JICbyAs9hqqIyz5z9Lo5be7iT+xFrZGrSyeHmo
 yqf+uqY2JSXtcXIshDoXepXy40tA2ArpC45PfajpgcfRliBgMiJS9ixwi7f2Qx3Qvt2X
 DbPSuvZ9P7D13T+pkcrgCrjISNb9On7JEOZcHvbiwU98xGu3cIHYNPdSi3riMyPfcU8m
 vV6A==
X-Gm-Message-State: AOJu0YxDDBJI2eLkd4QNfJ7QLgCQRfithh6jUpPELlUp/nwirl1Lx9PT
 HInGpFr5u7wZEwbXxZh2DXOQz1gN4Q9tG4qZE61fgOnzWbtcCb0HRcP0ll17LLKzKHymmSHAhCg
 ejCITn3GrH25fn/Ep99Nxl9jGVXlw6cT5j/6Yt9/HiAWlk9eSnR9J
X-Gm-Gg: ASbGncvr0ZS7Yq1gN2E46hLki5KbEiEHARxXHjXgd4SrQfvg6jxFYCZPUN5w/Dv22F4
 ZM3yCmgIuMu995HyCJjWxs5F6V8gQIV0CpI7CJj4oYBpXOhXZy/MGfQC8XOBkkxpjQWTFIUeLr5
 RQvl5VfLj6f64bdTYlPUfZt38SRVS/hRhm/9CsTc4q74DS+FacEYkF6qAroWPX33gftYpH8vzt4
 sDk3Ppc
X-Google-Smtp-Source: AGHT+IF1a7iqVKKstNLSpzwAcT3a1vvn95wFb3Wt1Rv0AVaKqoQf6NBpMdPHh91XegX4DTIayq3kPoaKaFqBrq1QM4Q=
X-Received: by 2002:a05:690c:6e93:b0:71c:1de5:5da8 with SMTP id
 00721157ae682-71fdc40d339mr282553127b3.36.1756390894772; Thu, 28 Aug 2025
 07:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-11-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:21:22 +0100
X-Gm-Features: Ac12FXxAQvONgBgXPRqFHqaEKqZNUjHPpR5aHCkiBKgvoFdrboNVbL7g9qpIuPQ
Message-ID: <CAFEAcA9jgL0tnnqg07-Jf5GcBDjssGmiYMgAhU0yv-BWuVJdLQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/87] linux-user/sh4: Convert target_elf_gregset_t to
 a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-pf1-x42f.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

