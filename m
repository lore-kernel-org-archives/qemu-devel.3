Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C551CD37B2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSYJ-0003bX-JA; Mon, 11 May 2026 11:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSYG-0003b3-Ca
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:28:12 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSYE-00071U-Lh
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:28:12 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c5361142fso4678817d50.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778513289; cv=none;
 d=google.com; s=arc-20240605;
 b=RgGeNW1Xqgggs0yt+Cqw23f0qt38wnn5Awpm350PKZuGsxkRKAIKdYfWoEeu1T4mmT
 NQ6pjtNDXkv6eJOk4Ks5c8iNQZGUAbz9OWiu2Uh+zXBhuVqe+zCmo7LFwFmhlGvuSlrO
 mvhgwSvzBd8iBWbfodjbUo9/g2XgBJUCtkp+t2XEnUrHJ7aPVAiMtEZbq6LfI7JGF13B
 xWJIVxDPTgiPzwTCNj8g5TZNngXs5e03Iy5VqnTVvvmTyLhwsFkIyNclBWB/duQ/9wNs
 LcBNg5aE0RluHBi/56ZguY3uK/J9eDpre/JwQU5q2LdRTGOQ5jwucF1Ldhln9Zew378X
 8bjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hM1r3JgOjTttAW30OJV6demfbDOt+19NxNRSsEEpDos=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=iVc5oa1NuG8svbWCxRSQYmxkhZZoFpffy8cik7UqomLUIbbsPLKhq3HOfIAlt5ftMn
 7BGbbtNewrwctiDMzizIhkUXwR+Vf9c1SRRi4TtxhtsKEGeQ5XN1j4/wKKs3eEQezyoA
 erV1Qymw1tgC8KtPDauc6PmyeKWjoNGcL+Ym9aP+8xnfi7ORPwIsoOfjoT79bZmWeQfa
 Dpniw1TWZsn42ubnNcDMeY/6txrYHvM2NiMOm5hVh7uoIVHOq+Jq3ho0VBgbgWZ/p4FE
 q56h+K4+tzR8+9o/wHw61OEHjs+C0wWLG8cV9gXwcEKyWo9reH7d5dTuhFuMDaJruBZ6
 p7Pg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778513289; x=1779118089; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hM1r3JgOjTttAW30OJV6demfbDOt+19NxNRSsEEpDos=;
 b=NX/M+k2rwLFMHvi6sliRBmsAa5tDqzNOOERli91GCkcmw2gw5k0G29kLGhflufLJKz
 q61+8ygEJCG5QBAEUMSenC0XqxEMCFsDf8pcZsQdV7blnweogXMrI/MCMRDmaccLHG8F
 yVW0UJL6m0tmOZk+l33f88EQUTJoGDvZN/7Yfu7/3or0cb/VwoKspM9vMz1Lt8+R2PUP
 dPsFzdO1iF/Tgpp3cRKE7dhhyHS1iWJwXuelmfmnqisHpKOrF4USzasJBS+DQDJ3Sw6b
 k4lz0dnT8jRBLuGAbtrpjiKtLs++WDT85JewD398zAfqOp6GNluwaIGA+lnpr0JaMusT
 1oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778513289; x=1779118089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hM1r3JgOjTttAW30OJV6demfbDOt+19NxNRSsEEpDos=;
 b=JcmRxa9ZMoZyGM2tJqofmIuL+2JDYDo9oYMyAEdsmbzqUSsmco7baIfd8zt/q9xXVY
 LyhsGn620/ECu61ZK7GJ/or5qA9enTaSV61gOzwnrgqq70yWjaGEIOuVaEJW0OPD6kuj
 ZhW514oG0MXR0zvv+FZcAri9KoI8lyQf4c3pAvgglJ3lD8OkRO3c6mC/BDswJNlsY3K3
 UkJUG6F0BnX3xGDR4TeoqtWNb1QSj4LHhH25CJcMfIbQPIFfs4oy4zYTCFLqsPAYPuEu
 ZfRv77nEef6r0buHv14bC4az9OH/+9Wg9cC/oS3i2NppprChZN2s/L8isHeog8fLqkE0
 w7AQ==
X-Gm-Message-State: AOJu0Yysx2PpNAR7EPV8OtFh1ske4teR/CSd54arU9DbCoZn0EuYxZ4f
 cea4enhD18Hs0JRpq1fT9ngIfECc8JOHX5N8UBJjq89p5Za5DN8oh8ZD7Ll/AFEFZUyXodL+G8M
 OWG5NUcajCCOpZjiQWG8U35v2MeVgtl98vwWtMUKROT7wU9LrKRkL
X-Gm-Gg: Acq92OEFcMG1NC3c/Va/nxYRM5BA7PK8DbzRQ8+Ouzg+DeKc1wyoaa6CLWZtBrSzYpd
 QgANwGHJP6qkdv//8V35+NwgmzlgKuBEMnENuXaNcQ6uPFNYLynCS1HSHdADsY12HUNrpaXwlDo
 RkCHaiVJFSeEBs2Z8DuYYmKTKWkU7LuhvUezRJck7jUD8S6+3qjZZ0h7NnNe8Q+smETuArOX8Vk
 EOgM8BmEUhhO6hSvGFwnQKvd1oe6E0S5e1Y/aWnaC4trjYHDf2YWQmWwO5hPx6lt8XmhOflqKln
 a5WyXuTyetAHizLjomaQ2aU7wMc2GnjaS9IlIMq3bOu5GJBDD+vDXFwpne2tq+A/XdaAbTVAdzl
 v5Q==
X-Received: by 2002:a05:690e:1209:b0:651:be70:9261 with SMTP id
 956f58d0204a3-65da84fa6edmr9236957d50.43.1778513289151; Mon, 11 May 2026
 08:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260511152019.1316898-1-peterx@redhat.com>
In-Reply-To: <20260511152019.1316898-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 16:27:57 +0100
X-Gm-Features: AVHnY4JxqMwXSxgilx-FpQIBmoFehAO5Ij8OBWIjtwx4zOnDNHhQNNf81zQnWtM
Message-ID: <CAFEAcA-b5+MDVqVyaaWT=Un7gN6dZUR3Qn98Qv8GAH8M02QW7g@mail.gmail.com>
Subject: Re: [PATCH v2] migration: Fix possible division by zero on calc
 expected downtime
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 11 May 2026 at 16:20, Peter Xu <peterx@redhat.com> wrote:
>
> Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> that the value will be calculated on-demand.  One side effect on the change
> is QEMU will allow the calculation to happen anytime even if there's no
> transfer happening for a short while.
>
> PeterM reported an ubsan report from clang when running migration-test with
> aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> concurrently so some of the src QEMU may not get chance to push any data,
> causing mbps to be 0:
>
> ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
>
> Fix it by properly handle both Inf and Nan.  One note is we can't use
> ">"/">=" check here otherwise we cannot cover Nan.

I don't really understand how we can get a NaN here -- where
is it coming from? The only case I can think of is if s->mbps is
a NaN -- but in that case that probably is causing other problems
elsewhere too, and it would likely be better to do something
where the NaN is first entering the calculations.

thanks
-- PMM

