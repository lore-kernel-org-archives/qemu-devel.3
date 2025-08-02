Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2CCC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIuK-0007uy-DA; Sat, 02 Aug 2025 16:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIqq-0003R5-9B
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:29:19 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIqo-000494-RJ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:29:08 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8fd38cb2abso2612380276.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166545; x=1754771345; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QNdIe6PwrEImZlHZNi7l/jJUOV9f73E6VcGZt8wAAag=;
 b=rRkKKIkuQZC7cXw2ZcdXUPYPZ2mRVcuJ6j7AZhGgDb0+jvsJVGbUJ7jp8OXXEiCz0/
 KMoKYe6VSMO2jEO65f9OKgAi3kSlBzgHXqHEAAQDj++CBnGGthc8Ry4dQU3Hi72QFkPi
 F5sI99US8DobBb3CW15SMK+wCCJheEQ8+dGmSKanCaKZ1FSg5QhvPZlf/0QkpTPFeTgs
 DlUprA5yPfdtDXNEA2aoKujyzXNOnsG58UqDbEaqsw4O7ClgUxAnS7MfE8sRNejCzBo5
 twsJL+YIM0jRKtaRjsfojQLd4KVr4VCXggkRIswj84WB+D5m03ciWtgUdd5CRGI2RR5p
 adFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166545; x=1754771345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QNdIe6PwrEImZlHZNi7l/jJUOV9f73E6VcGZt8wAAag=;
 b=f86+OlLUipXxfwu3axKxB8o8YuVWiJ9p8WjoLjAo0QKMxapw44BdgWHTEYzmUTyJNs
 4S1hAKGiD6SW+fVOwk/xX71lZiHBdmL5yDvd6SCzjPdXGGOPyV9+wtuEghaskY0rbOAk
 pXw5mTV2s6tiQGqm1zM2LKi0l5jTBrtLXGwdReFAyWVk6q/HND22oCW2BuwxILcYjkoL
 SLDH/otoCXTuxMbrynAYTgpo1eYAy43CZhO7t9hVDzWs/9L/KtG8OrY18xBy3GIwf0Xi
 iTGleTnldAsH929UuYtMnR8qRUfOxslRH+G4Q4QwSysO5KIme/8YxSrHpw9gC725lF21
 Ecww==
X-Gm-Message-State: AOJu0YyY27eQ/BPkajolTeBqat01/aSr9f0WnJ+prIKxB9/zhNj8HvA7
 S5lnG/nh7CI97ZiKruIjATasHSeOBm9eU0GS2GjfJBti7D7NXMKd+pxQu/lpN2rQ2+w3TDd9jxm
 /+C4PjUM+AW8nF5Galdoi+C1PYqdfYhaJcIgA5F7wVA==
X-Gm-Gg: ASbGncu7UZ2bLsg9ZDTWTdCs8sjTzM1im397qdFcp+5DW//3aVOk5cW+m/037iKF24V
 pVdlFu2lKts6KyNABpkf/n/dynDjf81fOY/XeqlnJg2E5ug6Aa95uGUgtJ7XtlMTgNWVQ45Qi9U
 0uYE1cnX4LNFZzORGXamFkbm2QRGhb7hOdY50j10HBdGilh5BA85j1tV5j9Ls26+0hdmVmIb1Bc
 vCWD9j0Q9dR0kJyXw0=
X-Google-Smtp-Source: AGHT+IHuHVA5BheKfgk3RgbgKnhD99DKza5606NyPjR68HqgNgWDHyTZLKt3WWTlW461t6v/7ph7kJxwyfRAzRWSN2A=
X-Received: by 2002:a05:690c:710a:b0:71b:6c7b:c7f9 with SMTP id
 00721157ae682-71b7f07fc8dmr52823077b3.33.1754166544929; Sat, 02 Aug 2025
 13:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-70-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-70-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:28:53 +0100
X-Gm-Features: Ac12FXxEAJGQaLhjITfkbnehpN7OaedvfeYC7WgaChny3yaH0izx8LAMq7GJo2k
Message-ID: <CAFEAcA-R+b+UWHmFowWPFMG9hb01ks6a4CFLRYsKNJX0E9RZpQ@mail.gmail.com>
Subject: Re: [PATCH 69/89] linux-user: Move elf parameters to
 microblaze/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

