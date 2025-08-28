Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EAFC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIP-0007Ge-KG; Thu, 28 Aug 2025 13:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdgQ-00069R-G8
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:32:58 -0400
Received: from [2607:f8b0:4864:20::b12f] (helo=mail-yx1-xb12f.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdgO-000800-4F
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:32:58 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-5f34893ec36so509022d50.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391572; x=1756996372; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m8tt8ZyKGwsgnqXPmqoTLj68Tg26HGOu1soWoG0OlZo=;
 b=xMt3ZXQwzQ4lm1DBXL8R1di17h3GbtmzFezyZYbwIqC/T5YF9++s8mrvolE+angk+3
 wLfCEiRy+gYzLVpM1mIHQ+HJhZ+IyHYWf3z6IKRbmTnSX3bCm/IwHFU2l0BdsD8VT4a+
 ed6HcZLBTDStJSK9/8mc5QddV+1yDpUngyYiMaiivQXNe2ou44TVLka6qkMZS4VchdOc
 TuAd2HQ54t9a7W1rstIfkQv1nkotIemxOn2IHRoJ28Pr7X6srbLpImEPK7Cq9FGBeuxk
 4wYphKZav1LuRcqvpW+Tnh+JIaGKRWC2ywQfs/16RJT7QC9oFkGsm0pcrCJS3DrcnBjY
 gVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391572; x=1756996372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m8tt8ZyKGwsgnqXPmqoTLj68Tg26HGOu1soWoG0OlZo=;
 b=J75JSO7vO6SbEZRmp7AiZEe/cvtDo2WTIzeIg8/QbJenRxZINJdIEcz+6zxux9xI2j
 K8HFO8XZxLHPdiMhVSZJt36FZing08fJD24N82FygGw4/RvNwt1zXBrbPY5Oc1zha2E+
 8qcNQXFixuiYJrPt6a2Az2JKW5AEAfcXHlBiBfZefeqX2GikA7SLn1/uF2LW5OupDNO5
 SGafS4aeUNimh+kiEKC8eZCZNOLmwLcrl8w0fQaGPZnH2zX+yrtaqAUMYzpNXSn4mrcd
 SNbStTYwblLkw1kIedPK48OJaePJYKMqtydh3URjP77ZOeRfODjPvmIQ7jLJZ7/MWQhF
 hbUw==
X-Gm-Message-State: AOJu0YyxdeSNw9tCeen5XUKqOQJBvMC6aCkEfLxqj7BpMDiraxP7I5Ht
 /ZgFVThmWSt8A6x3y8x2YZKg7+q4eQHzK1oUqrbAOldGwqXwKVUAMJzPWnzdEgFq253/x6BP3Qf
 0PaFfHfsscfCrir2YOZENQdIT8xl1etkPv+WJQ9TRsTezHuPpC0e6
X-Gm-Gg: ASbGncvQIcrPlyjvDEg3CpuziT37hR9ypnFhlEilpt0x8Ln+ZT8+LQla6uQmSuTz7kS
 BtKedjeiGR7OmpFAf30DEU9Kt+NhVBid6aBiw8/b5wbGA9/INcY82EC98nQ43+GZdnVdukoPugT
 VlcEaGLQLWinyvPg24ZC9tycPbpCBSj/YzO9LYzollINXP5MglANNm1nTF6zBmzZ9TMOewA4uLG
 jE1yXYmzPPY2eiGQGAohc8UAOX4MA==
X-Google-Smtp-Source: AGHT+IEgxqBkju0d7proEVac/8ubaq/opq1XTNOur4+0sbUI+sOYkuHlFasxomWFip0MXJYGCyTfBQHG2Kn7SQCLV74=
X-Received: by 2002:a05:690c:6c83:b0:71f:9a36:d339 with SMTP id
 00721157ae682-71fdc40fcebmr225469667b3.43.1756391572497; Thu, 28 Aug 2025
 07:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-27-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:32:40 +0100
X-Gm-Features: Ac12FXwKr8POxuPxU-V9WaNssxuJchEmtxDbWvcANpKoK1lBACfasfdQIGPlN5M
Message-ID: <CAFEAcA_ap7SCk123W_JjV=Gt-SdpcWb8CkG1ugcZ+Uwj+OAJLA@mail.gmail.com>
Subject: Re: [PATCH v3 26/87] linux-user: Move elf_core_copy_regs to
 m68k/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::b12f
 (failed)
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/m68k/target_elf.h | 10 ++++++++++
>  linux-user/elfload.c         | 31 -------------------------------
>  linux-user/m68k/elfload.c    | 27 +++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 31 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

