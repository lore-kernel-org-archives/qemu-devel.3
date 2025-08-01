Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1463CC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvKJ-0002Wk-8V; Fri, 01 Aug 2025 15:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtfs-0006Pa-QW
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:36:08 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtfr-0004rE-Ax
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:36:08 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71840959355so24827087b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069766; x=1754674566; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3z9Wrfw4NuTiRf8Oyp3PHEGssVHtcXUdItyLJFVvBw=;
 b=ousdrsP7FcUVR8zdqXqYC/eqbF/0GHau3iKnTChvAzUJIyOwniasU2DwE7cxV+W/GN
 0yRrmQffB9JQHEUjhL9CYS6QbiB53txcoOR8itOQnx0OsJcDHC4Xu2Pbb2/Z4RDHgmvX
 1Hzwi7f4S16ltFPDM2GJOtsZrTVaXRqvTxE5ML9TRJbnsldlgBkV0fBipHACGloUY7rg
 amuyRuvy+yVSjjZurH8iEvb6lAjyScSs9Q7tmdyHv/+MhMsRSk10yrBW5r0B4EdV026g
 9+gf7I1t2wiVojhiaKPnFHpMg/e4DF9FPmt8aTYZMk+bE1zt5QGo11GgZ6Du2VsJd1gg
 9EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069766; x=1754674566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3z9Wrfw4NuTiRf8Oyp3PHEGssVHtcXUdItyLJFVvBw=;
 b=CohbFgK0fA+dKbLVBScfrvB+g9Spo5GKWVNbMcNAxt+MK9h6SBoJ4lLwJnJPZEcLah
 Yo49FnAlCC8HZpKywuc85ZwjdfnZLF/e8RueqjEinMe/ejQZWW3K9BL6cJsCBGtuqnda
 uurgwk4FZ6mtwFst9M2Qj9xaShWM69+UCh8MH9ag7pvKTcXCZMKMigj1TmRdhEyDRHcI
 NdMW5A3XGKz+VsphUpzHPoFKHZKgo5E4JaDZPLgNoEZEi/cjFBZBYfnGUF69Fc3C6Bvt
 92GmTlspvRvixbq9TioJVKSDii24+aegPlBgTg8S8Vzt/cZyVAA3rv4+n1/7XaVR6YNA
 L/rA==
X-Gm-Message-State: AOJu0YxI8rniJs/iqzmm6NeKJJGkanUamGlSOw/opRYmcmrFkjbbwiNt
 /WeXAMPDFW6inDqN6SkzWRN7Y3FUJzeFo+GL3mXluamve+gwM9aaJXNaiRL9+vKubbRey+V9P2/
 Wh0wLmMKlLYAHAJemIrRd1sL9pHqkcK2ggTAlgVaLIlX3fTmM8FbH
X-Gm-Gg: ASbGncvlPNWdhgE8jAF544//Pr6HFKxx3AMKCqaQZp9bVN7WaHVJVKD/vls6eaSmmYc
 /lbN4YgHC0X3d6WGPGX9kNaZLqdaxTV9OmzKMDMMbVSDU1hSGLCTTGrG6/cdED4cepvM1X2jw2B
 Dd9PAqecBjwqmXfZc3wYCXSE9AL7/PB6nnaEcoP6WAmwxFMcfQSWo8qcaBU3cr8alkPlatJffeY
 a6R3/HV
X-Google-Smtp-Source: AGHT+IGaAsiu+S5euRjqbySqJwtqJtw0KPdw8qjyeW9F5W8ktxE1n3DW2pPxd9mByCyy+w+65PnbV02jYKg3QxKKlGA=
X-Received: by 2002:a05:690c:1b:b0:71a:2299:f0e2 with SMTP id
 00721157ae682-71b7ed70f84mr8141407b3.5.1754069765994; Fri, 01 Aug 2025
 10:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-40-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:35:54 +0100
X-Gm-Features: Ac12FXxnzJsiTTcGUfdnVyZhIPtlRAYWHfyWebBMWRgzPFwG8bdi7ittT61uwAk
Message-ID: <CAFEAcA9D=K6A9x7O0WVU8USJ9cdET3TDwuYeRHVMKJ-UZ9Y0hQ@mail.gmail.com>
Subject: Re: [PATCH 39/89] linux-user/hexagon: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 30 Jul 2025 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

