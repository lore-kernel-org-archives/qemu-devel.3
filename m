Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE573C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDY3-0008SB-Ll; Thu, 07 Mar 2024 08:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDXz-0008R2-C3
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:12:31 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDXx-0002iH-Om
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:12:31 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d2505352e6so12198701fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709817147; x=1710421947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i8O/oqpH7QUqOA1QMcdl7GzYfJcBUjyAGIWiEPVQ06A=;
 b=AvHprHRGGbpW3SMwpzP2o9YKSMZazRsYgl7lXpXpzmatzT0GIHIm0zKdvWbrpXVOWf
 PaxlX07actJWi2/YXcPcaMRjdgkIeaxTXPDyJ9Nt4qnKTXsbezP2udyR3VYQ24CgUkaS
 HWFAJohbxAwZ84O2zETGLda4vymNPHWphyaCVv0/SdhofIMd9TvjsY9SzOyFhjdqPUyD
 2Z9QDkri5RcOZJ5M5De1FAwVHGhyBAc4w/fLudODHGVLujt5dbpr5QO5CgI77jFDr9lM
 DYiPdIb8eFIGlBpMHThwAFaKT2gA6YYiLvRsrzZF3KLWUjfvCWGNoYK6V1+5fseSV10Y
 u7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709817147; x=1710421947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i8O/oqpH7QUqOA1QMcdl7GzYfJcBUjyAGIWiEPVQ06A=;
 b=pRPGk/bx1JtmRHYLYzkIb8snh0Cm+zT1MJfUHNocbI5EFie3GsF1Rna32w9VWGG14y
 oI1FOpOOm+UtGg5ahlvSfdWao548Rop0WyKYrsRigkazQWv6NZwsbuGGuJ8BRwJmr4uU
 8nO2/4W6z/EfGzfse4MFlU1XiPHYJR/ei+/cncEPKd8ILqWMrnhUks9sURhcAG7bQvtw
 82MUC7R2D2QN/2qiGTP0DdhwwFPmMftW+2nzVSvlzzswfmL1Fy7U1AEjpocax7Ky3SM+
 lmtrzDsR+osQ7HauAFtWAIMoY1rsQaOgVMHw4y/EJvNvsXXdGwCwS/n1cBU7mOzY7TtS
 V3Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV11NgVwpPfP4JbzGSmxPTxBSdz31ozf8mAYvJrGjMDzyMTIAMYgfqcJRMhvxVPxoPe/WHisNyFxIdROARZwBF2W/oCOi4=
X-Gm-Message-State: AOJu0YxBQMOrWlUH3nq3M6Sof+FxWYbpjvXhsDFXeCExmHdcO5KwF0ln
 DiKkS0ZuTR58UjSog2VgDvpWm84QnyAbPfwWv3dimzl/hNZTgPmK+IdKgrrd7i/3etfY8ar+Vlb
 Fj2FGr4CTurpinIKSnmEStV0u3bswLOYd9b8AfQ==
X-Google-Smtp-Source: AGHT+IGrN97qK1D/8Z1+FCjUkSeOZGfLeMlGiqjNNBpWOLPHz9fPFPkw3aJQ4N+FPu8Yfalykgw7EyUgzqnoAbLB7I4=
X-Received: by 2002:a2e:a0d8:0:b0:2d3:3aab:c278 with SMTP id
 f24-20020a2ea0d8000000b002d33aabc278mr1145656ljm.2.1709817146798; Thu, 07 Mar
 2024 05:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-9-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-9-4f324ad4d99d@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 13:12:16 +0000
Message-ID: <CAFEAcA9hX-XSFkQ8n6-jtgEXJ8R++=cZLpXBUYtO15aJFpU+4Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/19] contrib/elf2dmp: Fix error reporting style in
 main.c
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 7 Mar 2024 at 10:21, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> include/qapi/error.h says:
> > We recommend
> > * bool-valued functions return true on success / false on failure,
> > ...
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

