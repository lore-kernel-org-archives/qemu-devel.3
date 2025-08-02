Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF122C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIsC-0004fl-BG; Sat, 02 Aug 2025 16:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIoB-000867-W9
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:26:24 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIoA-0003tO-GN
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:26:23 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71b6d27113fso20190777b3.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166381; x=1754771181; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QzplpwmsGMYsEdhuHNmgoz0a+XPcy3M2tagWuo0vWYk=;
 b=BaYQNAuxG8TSe8OYgE9RyMnFbR2P6vVEvapMTikF/q/VVj4uTdbpm61zzLRrL+MCXu
 XMYUfR6PXs2iKxIVrRFpaJ3huJ15IGIZ0BDoGjA4WWgKVNa92z9hmpk6c4eUPU/c9idk
 IUFoTz0K/SmUb1bNGSZIe2Qc08vFtjBuC7X7CMoM0ENVTDwYJu4o5+mszGkQfqN1MuDP
 9cNKBpM6s1xRJVHTt3m7MR/Nkvlj/xb8is5rnMicoZIzA7+S53KPhLeHdb7JlhrQeDO6
 rJ+EFHVZt1zeukSwb2ALvHay7l5WiVZECSgRU7lqdAU0aEJIxaVaGQVe9MNkoVMRCj25
 9TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166381; x=1754771181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QzplpwmsGMYsEdhuHNmgoz0a+XPcy3M2tagWuo0vWYk=;
 b=wENTT1rGoV+VZys7IThXCJdvY8X24I2cWcNLStld0oC2vG7efy5eLeKSyX/8wytk0r
 iNOFV5IVq6cksjBqsOmjjIV3ixwwWFSIOShp4OmjjhUUNRvxatiTz7ESaOiGEFW13hAP
 zvzra3Ro2rVCOyiEUjmlgQSx9QxzhlBi1o6xB3fZZJUR9tkxIFILZYT8d0qBFboA8cas
 dJNINw3nue3BNg2ueND6MLwSl9gHsr3ETtgHQbgQhd7GF+n/wGKa6Onlyuj3JIRe2/Ur
 IPcdEjS0uRDv7I3CqP8lgXq7qcDyrOlKTVGiVZk42B1O+ejeRVQwriWM54B09kas8JDW
 bc+A==
X-Gm-Message-State: AOJu0YzeN7eNPpDz1+clGllPLDTBdTuX5R5xIBoB2m7S2AleAIyzBMfR
 GmPZuCIvGYTGtOovjTe/jJhqlq7p0y5kttLWZwZvL7jiDVrJ25R3h5GhtQUYA+Yba54HL8xZU4Z
 /1j2w0lFloxNLjCg2yIpT1rriFilF18siW7Mti2tvSQ==
X-Gm-Gg: ASbGncv6nRNH/c671Wk+/knV07kBdOgzH2JNou2AA/A6EkI2OmpWW06oHobe7TuHoK6
 +EAvm9BK63nKTvWibyLRCM465oFcuZLFf4+FPEGOgKFghjR55FYqjeelbntuAh96VRbzuH4Hubi
 5tvOnOPKA0khpayUIL+uxLaBztnrErdwSVdXuR9xElk2qid74MIXNFVSEtEcLl662vsMLe7pxiS
 LQkjJCJ
X-Google-Smtp-Source: AGHT+IGPRyhjoRROkvnGwKQVr8vSORhIebiOLHoZNJzqIyHGrx7VAjjX7eTaiX8gyLyM/mTrKN8/TyRL+hBUTp0dpsw=
X-Received: by 2002:a05:690c:2502:b0:71a:3771:cd6c with SMTP id
 00721157ae682-71b7f08f845mr55203187b3.37.1754166381483; Sat, 02 Aug 2025
 13:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-67-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-67-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:26:09 +0100
X-Gm-Features: Ac12FXyXstvUWx7LhAlokcfZsIqwZdPzCi2pVW5I9sh2BzbU9szNOsNrzqqMaSI
Message-ID: <CAFEAcA-dge+9H36ci9DwSyFoK8-siwDoYT6Xm31v3mTORxO+2g@mail.gmail.com>
Subject: Re: [PATCH 66/89] linux-user: Move elf parameters to ppc/target_elf.h
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

On Wed, 30 Jul 2025 at 01:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/ppc/target_elf.h | 45 ++++++++++++++++++++++++++++++
>  linux-user/elfload.c        | 55 -------------------------------------
>  2 files changed, 45 insertions(+), 55 deletions(-)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

