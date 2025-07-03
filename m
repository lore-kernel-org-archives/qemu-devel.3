Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12543C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJ7y-0005Gh-CN; Thu, 03 Jul 2025 08:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ7w-0005GT-UE
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:33:20 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ7u-0006oK-P5
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:33:20 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e8187601f85so7182919276.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545997; x=1752150797; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OBj111wfkFbpeXvKQEzQfGQco04hXtrVSeXrBgZ1R+s=;
 b=b3lC6Tvmyt/f4izwqelhh9MUYYCzWlSCP+6JvwTZmtZw9ZHWZWtAt5uOsTGUZZOgkN
 4KSP7YZ9ijzvURFN6zMkfzOG33hFEY5VzISiLpdS9dqFKrb8aDy8tLMLkS4s2wC8oQkH
 OAK45blvV5xVJqNzFFuYsQq1PZ78GIBbwaE2O6kWg3jejaNoK2/hMK3GKu7sZm8BoXQJ
 y/PS7XYCO65O4GoBtAf3a0kztc1Oc3K1VvBRCWYS490OS1dVJR6+uO5QWx5uTuQFSDWC
 +iNZ8EV1IQFFesMdhaZbsgHCSBtU5rQCb2Tkc7TyeAdPhAJ1sCTXsv98WSse3+KIBc4m
 Uxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545997; x=1752150797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OBj111wfkFbpeXvKQEzQfGQco04hXtrVSeXrBgZ1R+s=;
 b=smFfxgTgozE4gcxgVGUKv2OtxX6bF6MZkJpH95bf1OVQNPhsVHfOhVozrjBhZm+QWa
 DmH5ZN2FuAtPFgZIOB0IXC2UpuBhxSaOzCwJ6hqaHGSWGa9VRG4t4VJMoxzD1fC4Tnnv
 9Ch5oFrJGZ1uFKMub+9UIhPLvTq3ALXTfJ1ZyYMzOdyv+kgHIn8wRcl6rMuwfHHQOkPq
 CTpHCTz7KD087/CIo4W64okGY9UZKG9y0b8n+w9A9Rlxf0fBE0saC5W5d0K2quILRW5g
 anOKJ3DkOr3dLkt5En5UxqPkD/iGuJgOCYhYbD/1SiAtoGbTU32WPkkFTZDt5RJUt3iW
 C9Rw==
X-Gm-Message-State: AOJu0Yxhh6/+LWPZHqbNc471Lp0kPMJcqg512Bl9VjRjzSxSTN2pVYHa
 rxBSyWepIp0apJcXhpnOtSqE6LhAjwQfA4560sSRbk40aKNnN1PnV9uf5dtLbvJmH1Z2gP1W6IA
 fp2C/wNxfSTBNWsT2pwQpI4CMUEr0IBqGgkyPs9q93Q==
X-Gm-Gg: ASbGncu96GuxeRpkZVBi6sNKiFObPM93B3Gvb/9tYMLVxKA8aCFBSZLE/sc50q5sPfC
 ceNuoq0guF8Cs9OwgMHOAdy+V9aTMbdeEoYuzP9RsvBUiYAnxPyqzt6fvYJh+bnQQtfGMRexZ0g
 r9l/q+TcxRhyzRyMw6ZswMiJ6B5JLmTUhfkvbU7oHuZ7kX
X-Google-Smtp-Source: AGHT+IGM0rSEa23ZD9tVIGqRGLOyQy2EkBHZKKXSsRuRd3PFy3WHfNE+E9w6ar875uzx7B+NKviJYlV2B9nt7VcHvmw=
X-Received: by 2002:a05:690c:5:b0:716:3dc5:a35f with SMTP id
 00721157ae682-7164d4d84f7mr98841637b3.19.1751545996800; Thu, 03 Jul 2025
 05:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-85-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-85-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:33:05 +0100
X-Gm-Features: Ac12FXwSEO0yMpJM65OHhfiiHH9XNvX7fTU_611tzZZU85_IOBQCd0cTlWtSxNs
Message-ID: <CAFEAcA_Ad-nvFwvj70de8qsXBK808eLm-Wiga+_Ov1TmMhaBQw@mail.gmail.com>
Subject: Re: [PATCH v3 84/97] target/arm: Implement {LD1,ST1}{W,D} (128-bit
 element) for SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Wed, 2 Jul 2025 at 13:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h        |  22 +++++
>  target/arm/tcg/sve_ldst_internal.h |  26 ++++++
>  target/arm/tcg/sve_helper.c        |   6 ++
>  target/arm/tcg/translate-sve.c     | 134 +++++++++++++++++++++++------
>  target/arm/tcg/sve.decode          |  20 +++++
>  5 files changed, 181 insertions(+), 27 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

