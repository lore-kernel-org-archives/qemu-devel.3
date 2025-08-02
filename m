Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD42C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIvo-0002ly-6J; Sat, 02 Aug 2025 16:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIsX-0005bn-Rc
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:30:55 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIsW-0004Tk-9W
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:30:53 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-718389fb988so31617147b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166651; x=1754771451; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ti1dcPfbn28hYfZS1SMTPNpAI9dTo7ygKq5+f53r4IE=;
 b=RE18OYIVL0+kJMOzqWBX+o2HRB47cbM8thcNeuvJCNr29n0DS3+rj7H3IWn0ldJAEm
 9D5CcSquHvxdyFRagGAfuX6Wba4JKYz7H91QTuaro1v2C/X11WK7UVsahnRVnAgzZgI3
 dXrH1l+DKcCCL4RJptlZoxvH3kcSFGKdEu9QHJsSjycwTCqYZRuYic0aJp0PNAhym1fy
 JY/mj5f0Brd9s9+GdOnTsICDdJdR+hwL98fn7fJw0AkbSUnCIikA7XPoLnHCA5jfowzQ
 NzwoTiUEabHK4IOZp2jRIHpWGKfkosdyO63yynuNzgzu2ZB5RilWSUb1A4E7gSeWwBmU
 /Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166651; x=1754771451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ti1dcPfbn28hYfZS1SMTPNpAI9dTo7ygKq5+f53r4IE=;
 b=OGsmMrcoyMZGbjzNL0CQSuNXMcWftp8n9qUy/2MYoD0pVrhVME2GqSDUg9HKAjn7fR
 PQQNcAbwUleg+cHWklru6v1suBr7l1hxiUPii3dj99xihjpcF+arkpCnCeofuLhjPNKv
 LU7Mc3T8knlgIqU4MU148gKoSaikC9XimGPCHLcC3BfxfgIHGcTqIWYhCmO7EPZ4IFYt
 qW577dgF522dqi+LVo56P9HKzPNdeACj6R4DWmzLJvAYESLNGJdLjq+vYComqjojjRwG
 G3MOhVrR32UNIRAQTCok+tL41d9wFYjYqNAm8gLSN/+6yNIK+fZMa3/v+Wnvbsu8qjg9
 NXvA==
X-Gm-Message-State: AOJu0Ywn+/BT8uOW0l+hKrXjj654Euh1e31ds4+F8F5v6Lo8jxtdQ+xh
 GaV9GOzdzKy9kmJj0mFUck2r4aGwFnEQh1N3Qd//9X1wXTE6sM92TN9QjrZknaLCz/GLndoTAVW
 xyizaO2RwO9KXRlRnzQnYfe3DOzIRlkkOoSKqokYRMQ==
X-Gm-Gg: ASbGncvQtbYsLnubqqIYv27yksZth4kVLV5vmUkWlrgfN7btP6j1Bx4qwzqu5Bt4KiJ
 T68jLhNfjqJ4dg7vgLhUbdVZ5rTyuafR5+pvKtsS5kYJAQbva5UNMdxDhsywGXM8jtB97Hdcl2o
 mu0K0uZFE52IWEMY+8OTfxWOOG49uaIC6bkcaoIWVQcueQY1AYG/59hsQySCkaz8p9Yg/ypbrJY
 g0vYmVj
X-Google-Smtp-Source: AGHT+IH02igftIbdQgukBgYyg050NNMyWBcjf03CY/oP+msZaYrtue/W3Cli4zuk+RYTRd37qHxSCIJGrwS/KKoTlr8=
X-Received: by 2002:a05:690c:eca:b0:71a:1e8e:62e9 with SMTP id
 00721157ae682-71b7f0ac458mr58024537b3.37.1754166651271; Sat, 02 Aug 2025
 13:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-75-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-75-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:30:39 +0100
X-Gm-Features: Ac12FXyVSPdWdoewdwjb0lufvpQYP0cEG8jao71iI7dVGrhf7pK1039hBIJS4Ts
Message-ID: <CAFEAcA-8sUOOnbbeEhauSap+RTJ-h3tBCgQhAkn9bgi6z7VKaQ@mail.gmail.com>
Subject: Re: [PATCH 74/89] linux-user: Move elf parameters to
 s390x/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 30 Jul 2025 at 01:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/s390x/target_elf.h |  6 ++++++
>  linux-user/elfload.c          | 12 ------------
>  2 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

