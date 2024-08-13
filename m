Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FD5C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdryn-0004bn-Vz; Tue, 13 Aug 2024 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdryl-0004Oq-5R
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:54:27 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdryi-0007tK-5a
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:54:25 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5bb8e62570fso6623185a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723557262; x=1724162062; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GC3sjzsVx1oXybeAQAVIsuyVVLrVbcvE/J8NE6DIB38=;
 b=bpIBXRWphRE3o+pkhlpRUcILo8qylXvxfUVEO8eefKYtbDVBvjDnt52l9KDQfg/rye
 FLQBah7G32c2sEXX7GNtiN9Uj6UpaJZwUhJuHZj8Euv8uwDb3FzF4l4M7Zyg9jgXfeM3
 yGh5YGg6kws37CRBGOaF64kxex+1IdrBDmmmSO3ajCKYACBOvA/Nv2VZTa8iJOL2W4td
 gdVixF4wFA3mzpAJspK/4RJfMgHk5ZIW9N+W9s0LaFYGmaYFsTx09f3tcipnGTgaUXIx
 OcgFgMxMOZ2dDb+3r8VAUewlgI81T5RbXY/H598A/MNtkMeqMpZOXBMXYUCRrBvF0c3g
 WB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723557262; x=1724162062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GC3sjzsVx1oXybeAQAVIsuyVVLrVbcvE/J8NE6DIB38=;
 b=J9Vsi3pY8wvbQ+qWyK8BJE/Y16Z3ENJBxFec5YkfKP/eMKc02JJCRLoPnMmvaGAir9
 xcdIccA+u2Jp0/PrbEA6TQrjKr+NPPnVapW38w7u8+M2eUnfaVZMFGIoYFt0mY8v/0lZ
 8Z/+0R6nPu71YPY54VAUF8C77rj93ksOyAmDRWeqg5G/rBu1Wm6kpY0Rr7LcFchbeaU3
 RgDjeYNaWsr/zlEbNo8VlWFDTQQgJHYlUqG6bYXAqMZerLY1tR2F8kSTZIqconLXX3/2
 pXc9C4TdnjSBLBi1bj0KJA+a793NS4pGf3EyIaG5f/JD+Ya1BROcOI8TACwwJxAV5K3s
 qmEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFAcfIZFoICZqsislgLHxkjoZhgwC5EVw/uBENJwz5Pm+AMZGON+J3S2uHr3PcQeephjzFHvxl/iRR/Ini1SRvtn7UwbY=
X-Gm-Message-State: AOJu0YzAhqzgPdmzuY35gDbA+j5DXKn/MJzHTZqa+oxIdYLgPiPgtV+3
 waz8L+ejPTd+HO41dx/1cftjxv2yALetvHVIGNQJ1ZQlCsg1ZE5mdrfm+wjoxBWIXjoKkigf6b8
 Pb4q55x335KgxAHrhyqjk8U8alnKkxHw4916Axw==
X-Google-Smtp-Source: AGHT+IEZn0R1mdwZ5VGM1clediNW+bgc4+mrlnFUbctD3ICyaGzeER7mWB+WxjVMSaItFaVbdT0STbKD+r16ZKqdYW4=
X-Received: by 2002:a50:c8ca:0:b0:5b8:d362:3f46 with SMTP id
 4fb4d7f45d1cf-5bd44c79953mr1858768a12.35.1723557261788; Tue, 13 Aug 2024
 06:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240813125638.395461-1-sw@weilnetz.de>
In-Reply-To: <20240813125638.395461-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2024 14:54:10 +0100
Message-ID: <CAFEAcA_+A9TFPLiR=R+7oUdXND0gpDXa6sSC-_cVdQOPB1KiPQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1] docs: Fix some typos (found by typos) and grammar
 issues
To: Stefan Weil <sw@weilnetz.de>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 13 Aug 2024 at 13:57, Stefan Weil <sw@weilnetz.de> wrote:
>
> Fix the misspellings of "overriden" also in code comments.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  docs/devel/migration/uadk-compression.rst | 4 ++--
>  docs/interop/qemu-ga.rst                  | 2 +-
>  docs/tools/qemu-vmsr-helper.rst           | 4 ++--
>  hw/arm/smmu-common.c                      | 2 +-
>  include/exec/memory.h                     | 2 +-
>  qapi/rocker.json                          | 4 ++--
>  qga/main.c                                | 2 +-
>  7 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

