Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B95C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhv06-0004d5-HM; Fri, 01 Aug 2025 15:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtUn-0001Ld-Hi
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:24:44 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtUi-0002lL-JB
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:24:41 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71b4fc462ddso16188937b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069075; x=1754673875; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gXSZRduoGoQ9GHnjqupUM6y2bOKwFeCimgzv1TRQO8w=;
 b=a5g1Z609qyZuk39thInEfN2v49kuBXmNcX67nofApj8tmyQYLIcu5mueFegCboI718
 Y2BfqetBgtkzmVtbfKfoYSEOnpNXEnbDK+4i3gtFOx6BAsUJvKQOojm+C8EUURzqmmtS
 Ha99K0tcG8+WaXG4JqXlFlqxrNUSpLgP5KX2ULpysNl46KiwHF7lSO7alKv3ZsLUCW94
 xiUBcJH7yRWBWGa+ipuyHWwRhHKNnZzhmg6xPbKA1bRKl4+pF7z25PLOOMA856PIOai2
 58vrmK9k2xUa6nRvqzjq/iNPTs3Iv77LqT4UKpkS9SBr1z7ib0t6S9VqwbXzNrRttINq
 vA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069075; x=1754673875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gXSZRduoGoQ9GHnjqupUM6y2bOKwFeCimgzv1TRQO8w=;
 b=tUHbyQPnbAL2+JGInTtImciBQzZroSfdsK1uHyLvUZXRmuwTBqGPn9waTomBZzAz7j
 9B4M+f/1cQYCMCWYCynp5rJdGjPKRHJogjOn0S8eHor7R2O7MxT6f7Bud/4yEEuaxBu3
 AvLAi+A9X9rS9gyUT8h5efiP4NbcqHHz4SNYunwTsT/VH9OjAwnWmsQmeEXABOcPb/8U
 BRX+LHHnvbOQxFNI4Bo9+k8ByMD+Cqx5qmB3r++1Gv8+Oj03wjRZ/qe6cmxPzA5aKnFk
 frLI0U2NheNJzw9sqDfh8UhhphsZc8E/C31vSX2y6S3RCt0OG9VShyQs+2vMcOGLW+uD
 UcPQ==
X-Gm-Message-State: AOJu0YxmCBhnWWj72Zf0PJfMWjVcWhVucIxCqclsWHVQbFiGEH/XaDxE
 pD1C0JZVGeUlaJfwLWby0Pw2M/wrJMhn+gJJcRStEbpobh8EZmtyQA07JxDY7nvq8h9M8xEe9J8
 GYlyCH/Vh0s67A95c13rOSpdEMwWnWB8wiXE6enxJfrytppa07oXR
X-Gm-Gg: ASbGncs3me9zCpQRxWjntynPhF31p0rxEtleDuddM3yzhsXqekWa1pCmd+AIyXXLliU
 YrSzOAEOpe2YpUDt0K4Uo3/uKOs6Ty5pQAPr8uABVGsWcRPyCy7l59dX4FXlqkpGO09RaSHPTqf
 rGPfoWJwK0wyEaVpFQDEUE+pn/rvTF009Nc0XP9v2d5QWfqzkUyqzoJ/Fq9VY5sXeWrbdPQTVtC
 D/PgZUU
X-Google-Smtp-Source: AGHT+IE+1ci3cluTP/9VvyE7PPIKR81/l5DNkyOPpl/Z3EZlaLWxpt+Q8LgKQ74CagzuAKSszzzDoF0ksah+nd0FVEI=
X-Received: by 2002:a05:690c:660c:b0:702:52af:7168 with SMTP id
 00721157ae682-71b7ecf4e42mr8482657b3.2.1754069074998; Fri, 01 Aug 2025
 10:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-27-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:24:23 +0100
X-Gm-Features: Ac12FXz6wf1C9YNwlvgmwyNxJbbw6jKFWTAicwzqpUq6xMP-y3njGo6FYto3LOY
Message-ID: <CAFEAcA-N8R1Rxuw35sWTgoB475qnkLp16nHYhjQ0eXJhnx9xgg@mail.gmail.com>
Subject: Re: [PATCH 26/89] linux-user/sparc: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 30 Jul 2025 at 01:21, Richard Henderson
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

