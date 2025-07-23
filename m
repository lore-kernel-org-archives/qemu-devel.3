Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CECC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 10:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueWoA-0008Ee-Mw; Wed, 23 Jul 2025 06:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueWo8-0008Bq-UF
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 06:34:45 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueWo7-0005fj-2c
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 06:34:44 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e8b3cc12dceso3878019276.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753266881; x=1753871681; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vOjS7I2g0VNJ3+H4c1euxMb1mk/Z+ZtdQg3NUVk+ORk=;
 b=eqHYpw+QfDJLZlMoO9QDENKuFA+xkX7jJozYczI/MLKuXebNww4lf8Im6mbctquzDE
 vQUJNN1/5UirdhVP0++WXUGHhi1YJAOHoAUqIKxgBIyFNxBkzAcAIkd2gw8lJdT0QBWX
 ucwGAS3pQdkbq3DEseHCx+pbk94lpqsbL66NZT1Np9wenjoJfSL03HdYUwol8SBnuW4x
 tcBCf2EvrULreyHuyT8qJ7/NRlc8+ohSGmOlqZVTnUR+cee242ilt6PWX0gIBDx8I1wV
 wvYePaobE04nYIBtHRXBJDxFFBlXH6qHSEERwl0yOeonZeqzRET2qN7+aybfEu9ZK5gu
 REhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753266881; x=1753871681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOjS7I2g0VNJ3+H4c1euxMb1mk/Z+ZtdQg3NUVk+ORk=;
 b=HeOFvycgMvZDLkgtQ3qH65jsnZlR0rZbkm6H1IA4OogWBXclOqlSZM+k9zKpI+pmWx
 xOJbK7swiv0/VcK/AhigqrCKsBXquaNm48nmSvYyzQVhrnKeTSIG4bAfGSugbZ2405xY
 XOnO3k7u87DfQ2FOC5roW0nVE3iOIUZKX1b5lMsUQ9nW4seLy9FjrjESY6CkjQT34Ugu
 wff87CrU0kI4FHxPTElkujSgpUaN9AGqhZ5zDH1vtl6Vfna/0MphqRkLLzUqtOMPeJzm
 cAg+qRIZ+9aS29yNUyvOvSU4YxW39XPNdnwxfJbWY/HmpzUwkMUpOKBNkoW+AyoZr3xF
 UlnA==
X-Gm-Message-State: AOJu0YxtSYNmmx9E0Y/ha6ih7pftQuOg27noBKzKTh5sn7SpOt9knYnp
 tGZsHVj/YyT/+zTMUqZ1QWvIUhy4S9vy/73jEzDqnwk41LCPLtkuNdPqqlSeL0wFG9+CbvJK0pt
 UPXQRK6F01Z2qQx46AqXtTXg2TK07Vn+H2q3ex+AJ2A==
X-Gm-Gg: ASbGncu1UzjOh0vfi0Ryyo/BJsOfxM2Cdz85hCG9iNb8XyveMzTLW8AlPcvRlya4UT+
 5O11ZuuWYro+qXV/CkKj9VIZM5v6fl6wTADpfIGTCVSFq0h8MafeM2pmGW/Ne4VdlW36G7AZV/Z
 EtNldIrMf0ThhPdLl8EOF0/u8gZQQ7jCSbSzrSLcaiqjUGNDOPZuU+w+iqHsSuQC4GMdW3liLom
 OaDfUcg
X-Google-Smtp-Source: AGHT+IGmoOah+tj3icbsLkS15BpGETg6wMLDimKMi64bLHwRzwOpYxx4YOEFLITkTCUmJK/l+9jy/JhAS1dcZxC6eDA=
X-Received: by 2002:a05:690c:685:b0:717:b390:1af9 with SMTP id
 00721157ae682-719b41f5293mr29042997b3.19.1753266881186; Wed, 23 Jul 2025
 03:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250722183343.273533-1-richard.henderson@linaro.org>
In-Reply-To: <20250722183343.273533-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jul 2025 11:34:29 +0100
X-Gm-Features: Ac12FXxSkh8pWQfQ8KkS8QYVACHpXpvFYzPPyAZPbEM2SwkTDelfdKbs-ZNN6mg
Message-ID: <CAFEAcA8=8Cz8okx8yv+ns6n9JhkzE0xcFsCyWn9E5Q9Mf7Wm9w@mail.gmail.com>
Subject: Re: [PATCH] decodetree: Infer argument set before inferring format
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 22 Jul 2025 at 19:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Failure to confirm an argument set first may result in
> the selection of a format which leaves extra arguments
> to be filled in by the pattern.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py           | 7 ++++---
>  tests/decode/meson.build        | 1 +
>  tests/decode/succ_infer1.decode | 4 ++++
>  3 files changed, 9 insertions(+), 3 deletions(-)
>  create mode 100644 tests/decode/succ_infer1.decode

This fixes the problem I was running into with the LD1Q
fix I'm working on.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

