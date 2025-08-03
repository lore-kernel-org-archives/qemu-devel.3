Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92702C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 11:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWWt-0008Kz-PO; Sun, 03 Aug 2025 07:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWWq-00089J-Ax
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:05:25 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWWo-0000Wa-NT
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:05:24 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71b691a40a8so22762497b3.2
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 04:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754219121; x=1754823921; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TLy4GNBYxXCXvCmXp9TOj9u7Mi6Y2U2p95hpPGC3Hio=;
 b=JMfCJ2qrnw9X69BgRVzYk82hMljtAD3oeB56Ld5mYJa6UYq6QQTFZsH4Exl/zUN66V
 lEaJclWcex1l59aYYcatFqU7Cg672tFwZaylbnBwUKcjUgjJ5S6OsPAhBFP+7nCtLf4w
 zWDhdgtb3fSs7d4WKoNXypc+hn3GZAa3FE5syhy3Jl2n5dN188iRFi3qfERn3e+YH0T0
 v8NdK1VzjgLuB+paYQR/04bTpBtRvLC8UOkbbyWrNZvMlmBibXCsp26CoCaeZeSmSNqU
 ZSm9vYWLKQOy/VSNMT5G/vTSlCfX3KsUk4eyU/qNQHpN8y9SBR87pukg2c0xm6cOW+QQ
 FS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754219121; x=1754823921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TLy4GNBYxXCXvCmXp9TOj9u7Mi6Y2U2p95hpPGC3Hio=;
 b=BgU0D1YQRa144Fb7aCRxynwGDQR8MteI2elD8r1M1Ka+d1EGkyyiom+serRgYIQEHp
 Wg71Ls9bqaZTObIQ5k0SfK234r/k8rYzm6pwkqDfsKzZcRuosV0iRNTorqU1otbQMH16
 g4CG90NHKChjvJunXm/nLSuRJIsr8vNYYRG0yk63aY73glizDSQY29O/NoM/vCnK/BK/
 cdVWe3f8HoLLVTIDlzGtneuUA8lJpFRyPnWnlQHe/mGxa5uGke0P0t4oAZYHYFhdAbAb
 SvFPds5j6XRNokI3WXQlBT4MRqXAgFueu+hJoVNr6sLQBewms5vVvhg1pUn2K9K3hY/0
 WuGw==
X-Gm-Message-State: AOJu0YzGYb5gkeL4oq8Dt8rpCIVZkV9QPMNqpC9RdMMyLCc9E9KkjztU
 REOIs+F4LOUcZ75fNKWMTedmpGyFrCdAATAYdi0rH62BIwmr8P3Tg6z10rQb5xKVP6r+mlR8sx3
 zBi4vfjd37Th07SIw7ruB2m5Pq8R1yob7Zu1E8L2YNwETUrKnVM8x
X-Gm-Gg: ASbGnctuUErT8iy8kVakd9dWGuSbrHaOFr6J3S1I3Co7+gWdXvEKWwebt21jkdPpFpU
 LyDOeulVG+4pwjendnh21EPfaE9JLDwYH9gcwUGZX+/TG3gOgqOSqsIglamZEyxNwE9sKOYWs0E
 7NKlpfDnN1bRDwrTa05bf23EE/YU460gYeHzyUenXZWCZk6s3YRGbmHoVtnPqba3Yv7fLNiScX2
 Zcm6z5J
X-Google-Smtp-Source: AGHT+IExfWXX4L1/Ayw3tplg5yXxGhGD7enxiwqUnnXxjSOPjFC3F+d8W89JDtZbCfHaVgyvdZ43vEkphl8gDhTI4f0=
X-Received: by 2002:a05:690c:110:b0:71a:1e72:84c3 with SMTP id
 00721157ae682-71b7ecda924mr70757227b3.9.1754219121525; Sun, 03 Aug 2025
 04:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-61-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-61-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 12:05:10 +0100
X-Gm-Features: Ac12FXwXhplPm9gitrCwRFpYY4YRU4SnSKpPSzftQP-9SPaLaEsqq__If1WEREw
Message-ID: <CAFEAcA8RE-e3rnmJyzPsoQOVrgRLwmd+ChqaVsQD4S-h+WnWeA@mail.gmail.com>
Subject: Re: [PATCH v2 60/95] linux-user: Move elf_core_copy_regs to
 s390x/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sun, 3 Aug 2025 at 00:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move ELF_NREG to target_elf.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

