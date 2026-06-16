Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEB4CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSy5-0003JP-7P; Tue, 16 Jun 2026 08:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSxz-0003F0-E3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:32:32 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSxx-0006Pc-Hh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:32:30 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-66049669d78so4287574d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781613147; cv=none;
 d=google.com; s=arc-20240605;
 b=FLCH4uUXmBfUm2We3VXdxZ/49YETSo4vU5yh7DtK2N7weDK8rd6QPJk+f8u1JPHcfS
 R3sQnhFfE2hviPxdtfRGKgcatMXAW1M80Kf2M/TA3DVXPQco1Bpc5mZ3+Bz6HA1swJSm
 tgh4VXK/Ncypc7k+wSYMBQYrXNvYeMgDsT02To2aTax76R4W+xj3sUryimheFcy9T51N
 A8yrGULy0rw6Y35ljVBOjgNJWyFMMUqFL+tPcl69v1BXMsPGi4y01tNpwGHEcNQ+zwte
 Awoaa4QPat/JdHIsZDyF1sGJzAhRdJoKYrzSsG3eA1yNpJGKW+tkAkOM7WMnb7wg3YUM
 2yiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z0nWJfQs9yQ/gSJuxzKeyHB5MjQefLgvpKfz/keyWjU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=eWG62SZSzdYvtLOZCi64GoVA1F7j8Y35/cozyHLAHhMf/NVH9CbBT9usgRdr7Ofcl+
 3Q6F7AFgOTmZiOCxwHB+Apju3rRSYxD7n00UawN7n+D8a5afPr5qE9pRIKBecSk5/E4x
 w1jPykQ/eeVaBlzVXtfPSXLzl/vUNvQATR3qHFIdNauTifDJigMk50Q9dEsnik8GRKhP
 StjG+T9m6UAEWJFlcx15KD3VHBFZtZuunoiuy4b7NF1UD9ddVb+EbQ9KO5+m30pn8/PF
 qFr159gUmWnAlD/UrfS6QSErK3Ig7K/RQLiv10L18bV3GU4aDlXHPzaQ7Hv3RVblwyIJ
 Ol6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781613147; x=1782217947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z0nWJfQs9yQ/gSJuxzKeyHB5MjQefLgvpKfz/keyWjU=;
 b=dB/wyhxKYJcOysZGHN98PgmkHoiIH4b5hpopab+nntb5Krcki8c8BLUX81y4KPGFp9
 gSim+H0DwTmjwlLa/RyMavGJMHWlvG4fPjGpztWXCpZqNRNngZ6nKeQC5xMBCWDT66/7
 BOuwKcYZbkNyhYnD7hNCinOZZbG/w6uaTJRfvBZt2BwWseHiEWh+rcFiA89xvXUJzWid
 J0Ucqt6gc2smUCM7C73ZIadjipwCecLM69Psxj5zFjd8YkV6UTYpFVjmD6WnyUzb1vNt
 fAyEfzSIWJ/pGV1ddLIImF8OK2FKS9ic78vNTZ3acndD4Yv0fLLAivufnfEmnLKy11AL
 7dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781613147; x=1782217947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0nWJfQs9yQ/gSJuxzKeyHB5MjQefLgvpKfz/keyWjU=;
 b=pa36lrQhPm3usx38t44hTm4s2z5+p5GW9niXBw9CDpOU/krg7X5UWx8JhabUaEnkWr
 ic4r5c/4fCY1q29rgLv230QPNpxlAD5xYZdyla+Pgq8OisfIURhGfj+m9VBzwhsJ20kO
 NyZ+X7DZ1OxZ+jPR9m8NuDXUK3n22k2I6JaFwmcO8m/2QocNnONVxYKUt9Dz8UyRws+o
 o2f/DyfFsI2KyUeJAv0JpRJKbrNgP8ovIZZ+CVvNNVzHY+UA1rCcwZDOlGNK0NfelQs7
 ZkTdmGir5gwWW4L1uPl1Hgi+dDKjV9HLMVni1Ub1nwpRorfRDh62YA2hF+B91DOxDJqn
 bP8A==
X-Gm-Message-State: AOJu0Yxt5g6YhYbw1CEgFEdZbzYrjvTih57QyCdFFNWQ2ALIi1X8p3a/
 xIOdv02dR6ml3YZhAzpjhu81duprnxuMKKbRWTabUunCZ+BLC403hu1itqg+nsayUI6EDQxtxl1
 4OI8rJrrkIZ8zURh0WYRpZiaRXtyuMzyKWQLABbUt7Q==
X-Gm-Gg: Acq92OHIqljLgxQTaO3GMWKftiBvds5B/nPO5HUpFyoc/qWiqWpDUge6u98lJy9caqj
 /dJUd+Qhgw8GUvXAt2qiYDdUUeftAHxPkrY1iSzp7X8q2hQemlD5U0KVnwLTGdoHT5msEn5y3wG
 5peQCQXnFM0719DqouRuGkN3w4gw3zqVf1ig4w6rDFW73YXKYeABIN52PKoR8FkOh3MXKLHctR9
 zWWx1wSdnjkpXr8tQcN7E1wlK9XwbFzJqjzg/8rJNVkgaepUKbqQ269fXPuQRJxlYxDjm6zJ2L7
 dwPDtiQN5ivKGgHpS2QqipoGAajSqcZbu3s+q1O4xCCL8Jx+/H25F+jv0HuqJaAuoNs=
X-Received: by 2002:a05:690e:d46:b0:65e:4b1d:c67d with SMTP id
 956f58d0204a3-6627833b603mr13437732d50.53.1781613146291; Tue, 16 Jun 2026
 05:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-10-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:32:14 +0100
X-Gm-Features: AVVi8CfBofjB6GhJAnzgTG7VvKJ6Gwxem5HhblJvx1DQ56z3wD5wGxx_3RkiW5Y
Message-ID: <CAFEAcA_x78cRfujrHqhk5s1+Pa8efYoE5oHdfc9i5390bjW56w@mail.gmail.com>
Subject: Re: [PATCH 09/25] target/arm: Implement SVE2 integer unary operations
 (predicated, zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes URECPE, URSQRTE, SQABS, SQNEG.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

