Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AF0C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvSJ-0006ij-OD; Fri, 01 Aug 2025 15:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtrf-0005Za-4t
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:48:34 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtrZ-00078X-Ur
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:48:16 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71b6d27113fso11671107b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070492; x=1754675292; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5NQ1ukGIc/YGh9VoxkcTkcok/dnHYPmZPsHLVecHp64=;
 b=oWprUmMU0i4lyQ5CJ+FXoTqEfNArIXhWnNP1wVltwOlDt7AtH6jT1ujrN0AQCTOPcL
 cMdVF2qzGy/Qwi9mOy0BMdnnD+TRYJZRfyDMFQnVuyucoUH1Zv6AMBq3a2SHyHCC11n6
 JGPLW7JOlH0gzCACnW57dOHpZ4upNXm91S2EBTiHd+31YkHf7mcQzkNZGCOXic0edqYP
 7UtiTWLmTs1OIkGwcPflxlfy38jiofwA9o2FEITOxAoiZwWbk1GB/8W+7h7C4QDnPsR0
 6BVICDTgvNmILwugnL/fuyjFCdlDH+BAbgTagq3yOX6THv7k7AwC8Ld+Ovv1sAwuQaE0
 vgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070492; x=1754675292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5NQ1ukGIc/YGh9VoxkcTkcok/dnHYPmZPsHLVecHp64=;
 b=bhCqpmi+CyA0rVSzl9bTh6/Uh0D1QcXMRxBnPifL+QT8kFwBfbY7IwkYJpJkU85PVf
 kOOFDLoD2hfjrjQGUOHzIdFFH6Gb2RWlwqizWZGECp2K0ob+nnf0Qi4gkHZdrBrCG4Ob
 nlYGYL9VCbTqTnWiXB40W+lYeeURzi9riodRQ+YadCUxfK+STh0xxhKHMk+sJCTO9D2m
 xaKp75Qh0N7FuLg95DLA5ZhbjyDg0EtVc4o5jY6YDpBpbE7AQAYnfqIwk9mjZGJmaWd8
 yiABNqdHNu17W9S4VtVEkLPMKX9/TFnOTjvY0LgDjjr00KPWlVFBy2GVvjO21826oo6b
 eBag==
X-Gm-Message-State: AOJu0YxU5fHBCkIDuVDDpU6HH+JeRwzJdmDhWlx7V1htCtLYZzOtqiNi
 DKE5U+fOYiFUx05rrTrMPlfYgWwj99Nfyj0wfoCzQzHiSJexW7mXUR/ZgXdhCgLLZcsiAV5dOEU
 ydqy7w7IRPMBwUWkLsK34syAj8Kv+FCjH3LGI0dHaCw==
X-Gm-Gg: ASbGncuya4ithVRoSLP+2OT4bpI21EZHFytZ5T29MEamVZxuqv3M6P+vYxYlc264DCY
 MR1Tk0d1VoiKeISXO5rUwygSS1jaayu0LENhGJ47ITGwF2jpn2Ze5Ys2HPJwpgVxeSwaIsI8ei3
 944ovDCAEUUSy515CbzxZGiujV8PSp0wu0EoKxK7laV19zZmpiTuOdWykpeiegwV+InvbiPKjcv
 n3sx61ZZtpKOdZIcrk=
X-Google-Smtp-Source: AGHT+IGHunFb0WfeFzUMGhiOw5976b0XwR+Vs39JnRwB/kkxs6eq+zZYu5vbijJFJuNHHTJpgML20K5A+lztRAEdMsE=
X-Received: by 2002:a05:690c:6707:b0:70e:1bd8:a9c8 with SMTP id
 00721157ae682-71b7ef4db43mr7765997b3.23.1754070492027; Fri, 01 Aug 2025
 10:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-49-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-49-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:47:59 +0100
X-Gm-Features: Ac12FXzb7-nv3AvEvLbmBVVamZqjUDsQrbXtiGEchXZaTke6Y3cclR8GMnekkyE
Message-ID: <CAFEAcA9rYRgMJz4=2+hkCF9zk2rypkheZL0fhWawz0z1ZtHf4Q@mail.gmail.com>
Subject: Re: [PATCH 48/89] linux-user/microblaze: Split out
 target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 30 Jul 2025 at 01:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                        | 21 +--------------------
>  linux-user/microblaze/target_coredump.c.inc | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 20 deletions(-)
>  create mode 100644 linux-user/microblaze/target_coredump.c.inc

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

