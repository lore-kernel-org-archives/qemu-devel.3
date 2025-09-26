Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B07CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 10:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v25Rr-0001Ci-1W; Fri, 26 Sep 2025 06:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v25Ro-0001CP-PU
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 06:13:04 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v25Rc-0006xQ-Gk
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 06:13:04 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6348447d5easo884722d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758881565; x=1759486365; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoFBKgbJ+XVP3XKXZRH1nEVA2pr0ymC2siLpdG68qoE=;
 b=UA/J6YC5AeEDCUCHkoCji6lW+XEnROEeUh5CgCGN9PF29q8VvVCQiMjQKyuUf/55Vj
 MqL1pUqNsQQQSBbkXXaA7/h4EVxwVL//88SkvcrWQAYmNP6qssnFrx2JI9gPE3g9bBpw
 t0ilcE4zn+jL2zBYX1iaVAcp3MKC03xB+/iJk9Q4cAbA7uOisArvUIlRbMcPvkU/N/Oc
 j6vwdGT1+5lLVxvuuX3Du8VkxmamCMNkgpyb0itIM9jDA9qybte64uv3wsPE7Rc9uz7z
 ctE4rrWb6t5PszvSg5UowXlb0XcjtO5Yxnp4a9WkBAh/f81+7Uw5hx9FQ4gwkivoyhZS
 hPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758881565; x=1759486365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoFBKgbJ+XVP3XKXZRH1nEVA2pr0ymC2siLpdG68qoE=;
 b=iGMVZ28+o12MF1wAma1cXuvAdD6PTHy+Ovg7yNGs0d13HIHncwyIru4r7FLkwvUZwy
 V0UlO4QO9f76Y7YHpV6N0ZjAeUvOh41RaHk+X9740WBo4/gyrl8p/FiIR/z4MR22hSYh
 BNQoengZUxpr6LLYvTVvaFJmA/15YhyVUInOHDsEfIQG3m8JGI7Mb0R541WoHs40TsYX
 9h1v3qmvRBCRFjWInGJQmbhGT3yplNffH9V4zg3rHNlAgprp3Sc+GJpCPYPXLfpdeJIM
 GtO+v97fZ1EZ1RPhw5gwYFwUsq77giUH1S6VbXBa4dJFRRV9qg6HX4x1129MtMntSBbA
 rE1g==
X-Gm-Message-State: AOJu0YyL8fAU055px8zSBh4qdpUVc4X/+oRkIzxw6bdLo/X9QlvxmLHo
 Dh905zUQI7rMlCoSpAnFVVQmK4ZcATu1EXc2i5yI5970DyBsdQdqiwtKPnThxQbohRUG0sZ2snS
 N7fFUcRz9rGKXffPk65a8DhEt+hrkk2DP7YN7t8ywkg==
X-Gm-Gg: ASbGncuWlIg6g+5+ubxGW/aiBv5NThiwmWY8ikqDavxx7OfwHVyqhnqrNR4S66r5KyO
 10qUdGc/V+1HeLEl6IXA/sroUC2kJ0t0MiX8zSF7w9JQnc4U2im+C5wbKP1f0+P5cBlXqOF6sQm
 1Eo2MHTIRX5Qz7V/EEl3tcON+FoJWKXBJt609F42tpvdWSlw5W8qYxHu6NGQcJEjnVBecpLZWjx
 EpburDMFSXi0lLdGAM=
X-Google-Smtp-Source: AGHT+IE3Oa3gm3D0K46ujbkGyIVyMYwfgNclcgYKI6d/nolnzIRJtmlar+H9bkq/OGXTVfl22+PtNvOFUvWWAPGCbnc=
X-Received: by 2002:a05:690e:d51:b0:636:1a27:6aee with SMTP id
 956f58d0204a3-6361a7fc7fbmr5398072d50.31.1758881565625; Fri, 26 Sep 2025
 03:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250924163255.51145-1-philmd@linaro.org>
In-Reply-To: <20250924163255.51145-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Sep 2025 11:12:33 +0100
X-Gm-Features: AS18NWDnV_3qKBVqG8sm1MM-W0W1PFCjyriI1itFY8Jl689sbt3V89XGlY3K4D0
Message-ID: <CAFEAcA_zZ3g+QfuzWf1pa3wph4O512jCZXMtQzyo6QfSXtCYqQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Few tracing improvements around
 power/reset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 24 Sept 2025 at 17:32, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> Few patches adding trace events to power/reset methods
> which have been helpful when debugging nested guest
> behavior under HVF.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   target/arm: Convert power control DPRINTF() uses to trace events
>   target/arm: Trace emulated firmware reset call
>   target/arm: Trace vCPU reset call
>



Applied to target-arm.next, thanks.

-- PMM

