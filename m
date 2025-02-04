Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35EFC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLU5-0001Os-4r; Tue, 04 Feb 2025 11:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLU2-0001O9-Ih
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:09:06 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLU0-0005Ax-SJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:09:06 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so5654556276.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738685343; x=1739290143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1jAtOVa+5QGRYtQeuDiNAasMNa9pVeWVpybgjvDAL2w=;
 b=FX0cHDFroeSPzZKxH6WoKgsf4eDJS3ViPTIEhfLDT8SWuuRx0wiB83QSBGNgHG1Nlr
 v0HWJxOaTbG6XKOd+GSrMmAEN9umf3mCGtfDzO/nPGOmlbai45bku/+AgyBOtpogx35a
 uUHZjBHISOpBydnsLd+4y5SJ3hl550VHq4eFN+ZiFFjvhLfcURfwsIiCUdS940uBp+xr
 lX9UqZCO5vn7YBpvSH7wmaW1Ub9bjAdvUHQpkMg9VS8RQ0rKyjgSL/oTcpHFZaPFhqsB
 DXR40DiJQz/gWU6rBjZJCBOkzvwkziibMMjNy7jpdpDdXBQs3BJIys5P4IrNL2RDWKeQ
 j9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738685343; x=1739290143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1jAtOVa+5QGRYtQeuDiNAasMNa9pVeWVpybgjvDAL2w=;
 b=grTWtyp6i3whd7IDu9cuGBfGIYCmLn9fh2HZEnKL38zazPNBls0HaTBNOg+54AUV/b
 wsJZ6qMXfGPAp+nPMinFdn4UNx089YfHrb5PzA6U+DMKMqp0qvB5/iuANCUCLOwwIITU
 uf1DcZxSHSLqVUq2Y3j6zNJXNAT/A1xu6jeImExcerJ+29PjJNAbvD2tJyCw5cSsKqBj
 2+2zqNkUfWPPRnGHacSJzQXuW6WXMaoANpkLqeGlQb+7frBx36NhQ5hqYyKBtRPdR3Fh
 obo3dtS89suL1UjALY3osKJLuuaEiN7iU2xIHi5KJ1R/Xid+ujU6hMWPgAOhBLMy5NOb
 vGqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYeBTnUfTOFeR43Gt1EO5MkB3Ha0DBckLngm7dp7YGF59ngZi6jKHKxwLEB4NY2jCEaEY1ZW4jn5/z@nongnu.org
X-Gm-Message-State: AOJu0Yyhc9dMtPiYQD688w5oeW/gey8G9FTAKvRBs36FXtdwEoVrZpYY
 MY0EEwXUR9xeetU9iQhy6bv+kp7uP6tUzazE4LLDBS4+FMcVZH3Pa+twH9hyu0PuTWeoXh6/Mh/
 LaCCB3IIeN6yF3jfLsjgS7u8xPsr13EH7+3bPQw==
X-Gm-Gg: ASbGncs0C5Y2lVJQ2IPdbkfK5kUXDocuNadRs2vjn0yaRBpQ2Wfm7x4/i4I1regOuoC
 Hx7LisYXvab3BY3nw2ujZMrn9hn0JPL3auYxWvHOFcVcovyhxJGFxi7mU0HY8a1kQQWL2PMCNkw
 ==
X-Google-Smtp-Source: AGHT+IHGvquTQMJEPoj1Dr/MrByPIU8kNUcnHCUO9U+GiXtaXv8Tg0rWeZbADgLJ7GxLSzXDxwivnoIM3hnYn1Y19UA=
X-Received: by 2002:a05:6902:1a41:b0:e57:4226:8ae0 with SMTP id
 3f1490d57ef6-e58a4ae962amr19440277276.18.1738685343253; Tue, 04 Feb 2025
 08:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-18-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-18-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 16:08:51 +0000
X-Gm-Features: AWEUYZk0drIDSGZCF40aepkg-jnBxMuPvlbv1UNySLhjL6TKWRIADr97vIjLwl0
Message-ID: <CAFEAcA8rR2Ajj3Bkt3AyjMXOwYLE_h9OBJ0ZmRNYs=SkEak4yQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/17] hw/arm: Add NPCM845 Evaluation board
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 26 Dec 2024 at 08:29, Hao Wu <wuhaotsh@google.com> wrote:
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/arm/meson.build       |   2 +-
>  hw/arm/npcm8xx_boards.c  | 256 +++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/npcm8xx.h |  20 +++
>  3 files changed, 277 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/npcm8xx_boards.c

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

