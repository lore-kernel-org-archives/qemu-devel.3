Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B921C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 08:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rweHv-0007av-DE; Tue, 16 Apr 2024 04:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rweHh-0007aI-5f
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:35:22 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rweHf-0000BC-JM
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:35:20 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a51f9ad7684so277955466b.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713256517; x=1713861317; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYiuPV2lRTPgduAwUFsy0QQDVOGeBJ3J34rZNDJJCjs=;
 b=mMU66ZO6iL/Lbl+zSX7mxPyBNUFnxH7xMHXCeyrz6weGrlfYjMFe7vS9BAsmuKM6Mz
 PohY4C6Ch4IuDploWk4qUhPdsknd5eNrPlvHwW4iHBDBYmzvF46QzXMdC61BxT9X7Oz8
 XwSXUea/1FjHD4Oplemu4POJml1fUxsOsnz4cZ7NcRlzikNhdHonwDplK9ZEKHU5CEuq
 PbJpek+K/nvkJ1zSHYBKNJP+N+4oXtsrqMsfZHawAxpA+9Lc9HyPGO8+V5kiE41ut2w3
 F/59fBEYztdQNffhTqxZYcG+hm7V/XcLL4GOggDpQGvk9eU6DywJCKOSFUECss2He1Rs
 gWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713256517; x=1713861317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYiuPV2lRTPgduAwUFsy0QQDVOGeBJ3J34rZNDJJCjs=;
 b=gZVXOObTp5bKy7QG1Clp7dIP25vAkHUlp31kJ0JS6p2FPabFOmIKWHK/rqV34gq6aP
 sICfE1dUcObq6/1WbJdJvBP8S/OhZBekveGcWpvXCprMNiKpDJG/Kh4VTC99lCj+uydc
 ZLdL3if+QHP0IhjEJScwYVWl9zrFY4lZXlcUu1Wd+dd1+FSd1OYr546jD9rJXKxcdiUn
 oouX5Ep7sh1YZlWLD2TetH0lt9VxEG+Q54RBd58HbrlUMDbjfYMmC2TIBNGGX6GUMj2q
 5Aj6egJvmlthche4IcebHHiqncM5UVoyt0qHJu9XAPVAcYOmDPHPP7Aifgy5q2ua+Hw5
 dtmA==
X-Gm-Message-State: AOJu0YyD3Jy4GW93pNa84ejUsK1QQH+ZXEfo95zpR932tdbZM1RICI/d
 L72XA0g56sEqCVYFG8ROaWW/+aJyRL7U+SHmUGT6qV024h0zAYg/A/ydLn/PsS1BJ35AqlHt2fK
 YnyZ4HM56Io+pg1jUEx+Lv5pybras7hvITl+M8g==
X-Google-Smtp-Source: AGHT+IH8ZJUi8E8wPxcygx9d7j4GLT+l2Hr1tLkuhZJLtzdQem6i0jSQXjAxe/xcViX+SF2rl9/1XEvpBdEP/gyLYy4=
X-Received: by 2002:a50:d599:0:b0:56e:57f9:8c83 with SMTP id
 v25-20020a50d599000000b0056e57f98c83mr11182301edi.19.1713256516988; Tue, 16
 Apr 2024 01:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240413052333.688151-1-richard.henderson@linaro.org>
In-Reply-To: <20240413052333.688151-1-richard.henderson@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 16 Apr 2024 10:35:05 +0200
Message-ID: <CAJy5ezpry08WaJnj70ckgvraWm6Dk5UPNY7fC58PwsZkmB7fEw@mail.gmail.com>
Subject: Re: [PATCH 0/6] disas/cris: Use GString instead of sprintf
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, Apr 13, 2024 at 7:23=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> More sprintf cleanup encouraged by the Apple deprecation.
> Probably there's a more minimal patch.  On the other hand,
> there's certainly a larger cleanup possible.
>
>
> r~


On the series:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


>
>
> Richard Henderson (6):
>   disas/cris: Untabify
>   disas/cris: Remove TRACE_CASE and related code
>   disas/cris: Drop with_reg_prefix
>   disas/cris: Use GString in print_with_operands and subroutines
>   disas/cris: Remove struct cris_disasm_data
>   disas/cris: Improve output of register names
>
>  disas/cris.c | 2498 +++++++++++++++++++++-----------------------------
>  1 file changed, 1070 insertions(+), 1428 deletions(-)
>
> --
> 2.34.1
>

