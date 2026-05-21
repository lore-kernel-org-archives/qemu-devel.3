Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96E3CD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ9yG-0007ue-Pt; Thu, 21 May 2026 16:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wQ9y0-0007ss-0X
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:26:06 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wQ9xy-00089v-Bz
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:26:03 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dbd801138eso4399234a34.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779395161; cv=none;
 d=google.com; s=arc-20240605;
 b=PzvzZC1TXydQL0rorrQsMkgTx9TPvLEf+g/RumZuAn48lIkRNlpYO5TCePn++44Ovm
 aC0wWDK/tta1Pv4X/HyDeVHrIEkyFdCtdAe3rUnWXgnTHVoCU8xOOgVexO0d+NP1uIPH
 r4IoC0x04J5gps0XOvyByGWZ7arakynEKEUnDad7S/oa0lqYAjT2hC237G9u44gm8/3L
 WOtkGsSKNf3QY1ctqqoRw3uRrckxOhtLVVouznEpbSBUi4Z+qmq9PVGEGrlHL1VsVFa3
 SpdfoDmlZYW2lYVIvphqDBE0dPYu9pbnyCUgjU0uUMjVjYWzuImioUUMygH4ByA2qiz+
 UWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BnZKBgCkyetHodAb7HtYhzK5yHV7wQbsMypvHi4OobM=;
 fh=/aURJlcAzC93zQx7oUf7NbjdC5rKfo/4/8cj8BWsd8c=;
 b=VPt1s4OOrcg2O28hNsSvSxz7KaAQKKlbkF1LwjJE5ielfWFOpeHHVD6RrJ9V9/4khm
 V00ju2elTHeZs94gx5H/swFw8IWivdZknAROlJRdaIMYnkTAc0gDyLdVUhtphr91YZPR
 UwSqjP9zEeBO/eO74kHUpKBvapvWt7IzAfjwy5Sqm6Z3HkFQXcE0YP5JPQ95Hz+ybYkt
 ijCrY7siZEznxHaCYGF5rYIIeRuVm+hLpqVD5IyOD3EccNMZbChOr8x6uctmtDtDHCCj
 YdXPZFXAaPkaaIQ28lAZ80nNSuf3xCPYHXnBIpNuJsrm9JVbhyLMmiGoBKuzgyNkToCx
 ZkCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779395161; x=1779999961; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnZKBgCkyetHodAb7HtYhzK5yHV7wQbsMypvHi4OobM=;
 b=PgwJPt7NAKp9Ze3V5EmxQJszhXdSvuhm+CYDF4BD5ZMUgiZ3sfYE+tj4pBvYp4yKUP
 UgLvlqSkYmY4j/KMbkXxRiKus1dA5qEoEms7V4QFg5W2EThgUZnItVqutvaMzSlVe2+e
 y4MD2lsesWzbrhEiQ/a/DPZPWVEMQhZ+qMzDXZIZLcN2y+tCaUVbErbQ87SmUpMoZQl4
 t1kny3jr4JoHvOEV4u1kOiP6aaQcvB58zTBplM+sqDEJ3O053MiZ9txi6csylBmzQqwK
 /qrsxlLp3Bc8u6kBuyzbR5aA9nsASSJH+Bri0YVaD5Y/QPLrvPoIiX/lsPRANmoJQ1nx
 0H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779395161; x=1779999961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BnZKBgCkyetHodAb7HtYhzK5yHV7wQbsMypvHi4OobM=;
 b=Mi73kRu0f2XC/F8ObJwulk6/8AqMEeUFvSnUW1+XYj5gVmRcy5JOAuRp1ZBngPHHBN
 ZdqFcpb5Dse+GIIDEs+B29ZCu19qxBaVEweEUONuA09EYebota8D93nORBZGbUORQV8+
 cjkRMzpgIZCsHRkq8XuMe5fmgF++LqKEj4nA7pFbP5/84duFW1fvz8D76pE8Qu+n1fPg
 Q7yTlDsQ4snKMW1l0EYQpWqBNhWSaK1MSs2iPBRUtjD21hHvnxGgsL3Jpb/0tgBdwE/M
 nSnXwEtR9de0agDXFFFmTJha45b0IPyxpHQyvyVBjzsFsBQ3L+2wORG7T+c3p487aF+b
 BsvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TolHBwgRNa83uOulE45Na0KoDUt/hmo6adD+8LE7uWYa2lFWm2BYpwjD3rKXSVjjIAuITNe9K2yUL@nongnu.org
X-Gm-Message-State: AOJu0YxyVBVRYqxIaFopSoptEHqo2BuxUk/ATWzHrUOxrv9HXjNXUX7R
 9VmUFH0pK4geksafWeswrWci8hHqK6RPqn3aMcYsdIi+uDUJSEF3jFpbcGT2/a+OR9O6Ax/AU9d
 sVLDEOIbe4GK3f629qer4YqKohQtrCCpVzYZ4+lW+Yw==
X-Gm-Gg: Acq92OHu8yKqo9etcRAi3h3GRzD0rrQg5pRNT/ngRqubPS/kQeTln0gFx1SAaeCprWW
 tMcWk/kQsHRhbzPawQ0XBiZKiiI114Cjyjb2Ve3ZL80ur5GRmESBpWZtHDmI8/aAeQtyQ/Z7Wk5
 ML03ge7Wi6RP96/uEbGRoO5QW8bmVExMmHJwmQ7Pa7bAw0wK8+VUaKQhToM3a88ltZl5Yqor0B/
 aSNuXDVgDcxno/io80IgCh2PYnFEtpK41BE127wNrKfNdA8voarwbIOyH81BcgBo/gImVSxSKFP
 LlxosRA=
X-Received: by 2002:a05:6820:c0c7:20b0:695:94b4:d4cc with SMTP id
 006d021491bc7-69d6dfeac42mr1557107eaf.1.1779395160738; Thu, 21 May 2026
 13:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
 <52b9ca7a-9ac2-4e0b-8394-3e1f167560e0@linaro.org>
 <CAPMQPELA36GSuFhEfvgONzNYMcNQUzP6_m0FXbLjp2ZUeu-maQ@mail.gmail.com>
In-Reply-To: <CAPMQPELA36GSuFhEfvgONzNYMcNQUzP6_m0FXbLjp2ZUeu-maQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Thu, 21 May 2026 22:25:49 +0200
X-Gm-Features: AVHnY4I3Y2kLFKw92dtoRHM4C3pt18Nm2WQDOkVIlJ4kfpIHqR9A4GMROba2IlU
Message-ID: <CAPMQPE+peGvbRTZJWHzq3BXXju1zmr6gq77FOofr5vDBd8pbMQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/45] target/mips: add missing Octeon user-mode
 support
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-ot1-x32d.google.com
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

On Thu, 21 May 2026 at 22:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
> On Wed, 20 May 2026 at 12:00, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> > On 20/5/26 06:36, James Hilliard wrote:
> > > This series updates MIPS linux-user unaligned-access behavior and fil=
ls
> > > in missing Octeon user-mode instruction support used by existing Octe=
on
> > > binaries.

> > Thanks for this series, I really appreciate your dedication and the
> > quality of your patches. I have been trying to queue it since v7 but
> > you keep respinning :) Since the first half is stable and reviewed,
> > I'll queue that first and send in my next MIPS pull request; less for
> > you to carry over.
>
> Now merged as commits e83a42cbf72...006d624b948.
>
> Rebasing the rest shouldn't be too hard (changes are
> obvious, I also moved the TRANS_LX block around).
> Tell me if you have an issue rebasing your work and I'll
> repost the remaining patches.

And I now notice your v13, this is perfect, I'll follow there, thank you!
https://lore.kernel.org/qemu-devel/20260521-mips-octeon-missing-insns-v2-v1=
3-0-5a4cb8ec9cd3@gmail.com/

